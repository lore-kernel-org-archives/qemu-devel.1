Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93AAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7412067C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lljcsCmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7412067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0Dz-0006bC-JW
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRztZ-0003V5-C2
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:37:53 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:34100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRztX-0007lB-8o
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:37:52 -0400
Received: by mail-wr1-x433.google.com with SMTP id i1so13574500wro.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9dCI9vVIHjGOIU15u/YnihvSC4K6HLaW4rgzCu/bPQI=;
 b=lljcsCmP0fkpHKYyW+GVLzuO7pU6NoYK52YAUzPypHUg5y2XMHbcMAkf2CktXd6hG5
 ecr0XaLQDSmrCBO8fCm6cCmcpu6samPUYiIo+PlexavyrkAIeX4Gd5xpndCsiAISZx2v
 xPv2ISdFbAMzdYAXgHyp7UyyHWofqrCXWHt71E5yH8tIbtRlZkFp73yvv1IEE9REIBGQ
 iO0BGNo3mKF0cG1WHvU+/xs+c34nMrDylCphKercMcQ96ci0P2E/dgURZm6ME5m7GX9F
 2/m/y9BOd1yxxqdBlCXKOlMtHFGhpvT8+PaJwblyyKXbA/L4Gerfc2pv4YoyBnYF7XqQ
 673g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9dCI9vVIHjGOIU15u/YnihvSC4K6HLaW4rgzCu/bPQI=;
 b=uIVx7OFIJwPpM69sjPq60rsU/ZCjrRAVag97PpybcSnvhHuSAyN+FPtw9uYPqmkzsg
 Vu6iFkBc5+0svcLxjNs8O8JZErTjPB3fdpRl1ZIB27kjZAL+23/uDpurSsF/UBkUYn/c
 dWuB6c3mDLsKpN130DKkF6nRDxtgBxDmrFx1FA5aNb1Q1Otn6lkllYeNCYM3gMUXnydr
 KxapNGRGGNGwT9hpXkJ8bTz5OGfmgAZt+Uk5bXynRpFIVQrTwpwJl5OBEy3h5v7EY6kT
 A3Vp+KN3xirgtXrDNwpzfueXkzekyK/sQmVrCEWVuC2BrSPEyGDpKnCcRrNQbWZvaA7Y
 x5lw==
X-Gm-Message-State: AOAM530uZ8daIAOCN7Yl+TYwuiQ0u7i7uSpHUYlet7oNdzoWdpbUjw0H
 HW+rnbpE4cAjsr5/rrdqjEx7PA==
X-Google-Smtp-Source: ABdhPJzv4ZgMKklrU4w0AiKdZfS8ywDfbAJeEUxveFTqLjYv4XwyYvg1fBHeYCZceBXKT5outAEVqw==
X-Received: by 2002:adf:f305:: with SMTP id i5mr25152926wro.346.1602517069740; 
 Mon, 12 Oct 2020 08:37:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y66sm7095961wmd.14.2020.10.12.08.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:37:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/10] decodetree: Fix codegen for non-overlapping group
 inside overlapping group
Date: Mon, 12 Oct 2020 16:37:37 +0100
Message-Id: <20201012153746.9996-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153746.9996-1-peter.maydell@linaro.org>
References: <20201012153746.9996-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For nested groups like:

  {
    [
      pattern 1
      pattern 2
    ]
    pattern 3
  }

the intended behaviour is that patterns 1 and 2 must not
overlap with each other; if the insn matches neither then
we fall through to pattern 3 as the next thing in the
outer overlapping group.

Currently we generate incorrect code for this situation,
because in the code path for a failed match inside the
inner non-overlapping group we generate a "return" statement,
which causes decode to stop entirely rather than continuing
to the next thing in the outer group.

Generate a "break" instead, so that decode flow behaves
as required for this nested group case.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/decodetree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 60fd3b5e5f6..c1bf3cfa85f 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -548,7 +548,7 @@ class Tree:
             output(ind, '    /* ',
                    str_match_bits(innerbits, innermask), ' */\n')
             s.output_code(i + 4, extracted, innerbits, innermask)
-            output(ind, '    return false;\n')
+            output(ind, '    break;\n')
         output(ind, '}\n')
 # end Tree
 
-- 
2.20.1


