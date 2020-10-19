Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62EFC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1097E2231B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tALTCdei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1097E2231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUWtN-0001Mq-R3
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 11:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUWqS-0006nG-QS
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:13:08 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:51121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUWqQ-0002jf-Qe
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:13:08 -0400
Received: by mail-wm1-x330.google.com with SMTP id 13so198392wmf.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 08:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SjAOm7vNdY1fRUdfqYZeeidFWrwzSxpq+qzgfHwNtsM=;
 b=tALTCdeiFwC/7fynmi9JXz2zPwiHM/TCHffDUEDNeuvHvSJ6BghwLtZx15rlpC4vRy
 /UKegIHpU8yEcrEyr6hl7BvmGCkybV1zK9u8ZSO35GUnZXDE0xdr9+DXSQ5ZZfniwB7K
 w5ZH+9nS1NDpVap5Ma1GqcoK4JZRo6CX3Yo4GJK4vfnYnmb8v62tedyFICylQ6NMb/Wi
 u73mxIBAw2pFFsc6EkBfQzB8QWN+6ebbiZMAnk0HnKNp6Xx5WmFPIhAjfR5oXT4xYDlP
 adLGlOhJS1lKIV5vNP6BxMWWfhtX2lq4cx87NL7CVuiWDM5Dd6SeopSNfmgxZfciTmMl
 R5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SjAOm7vNdY1fRUdfqYZeeidFWrwzSxpq+qzgfHwNtsM=;
 b=pSg+X14Y3S7G4RMsh0niqpVqg+pYXKBaaf33SMBI+/XlPL9SaCNWtTJMr8VzDMdq8X
 92WT0jTPNYzfv+ze2YuWxcquQ53skIXm6u/PZwjoDhRS2qR0HscAk4tPA5H1i/TGN5i/
 If18OAHR8GkgR7oE+JIoJjbEh9JwJLAdRTqcokKsEWjcKGbHuTCqfxtADmgIlUex7FdL
 O2tbhjptI4j6DfHAKMkrayUMeXj9BR+MSduiSC9/NfCyx2B6UB7o8CqasQ9OVG0Zj9ej
 w1oNN86j871sZxZQlV5KwBXB1ykw2E34btDUOcYhvuUOOIoNn7vIrGmNC+TzVEaAn7Km
 PjYw==
X-Gm-Message-State: AOAM533mMwM9tuVBiKDqeWvIb40mLFdIqYHe3IodtH1iQ9JAmbSOXVXX
 8ClJjl5FBVDnOxYjj9pOhHOkojmPCcq0Rg==
X-Google-Smtp-Source: ABdhPJzzhVtOB3YfRnS/i8zFQmEaLoZsztOShK9Tq92Liv8ea4a8u6+OL4kaOtBQhu5+7nuWJBwVLw==
X-Received: by 2002:a1c:ddc2:: with SMTP id u185mr18714567wmg.21.1603120384901; 
 Mon, 19 Oct 2020 08:13:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y14sm309918wma.48.2020.10.19.08.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 08:13:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 01/10] decodetree: Fix codegen for non-overlapping group
 inside overlapping group
Date: Mon, 19 Oct 2020 16:12:52 +0100
Message-Id: <20201019151301.2046-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201019151301.2046-1-peter.maydell@linaro.org>
References: <20201019151301.2046-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


