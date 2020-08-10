Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29924C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:54:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD83622CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7GBexm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD83622CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5DsA-0008Lj-3e
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DoY-0000CS-Ta
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:34 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40557)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DoX-0004kd-0Y
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:34 -0400
Received: by mail-wm1-x341.google.com with SMTP id k20so664515wmi.5
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bCdAd7Be6DRYvzpoO8DYOlXvYCiC9pmHXI5mvLQ78DM=;
 b=N7GBexm7xl37M8Z6j1VuOWuswK4MAHCqBNHj65q1qUEo6JGb+p/k6AQllwQuYaBBr0
 77y9Gyycxysqb2cTHA8XQbRlzrnIccLgABFf1s3J4BhdphWMQF+Y12T7jFUdRZFE6wi4
 B2wIe19cX0pHOjRbHNwfB4u4kMkMp74+U8eu6y/Mznpcz0oByvn1FuWo4Un+9F/llcPb
 zYIrFCvaFDjzHpTdSIyASNxpZwHjUoX/d6AHongju2NR9Knw+/XHImasHqwbgE3eMM2f
 Bj1Yj4Y7K+gmw3cvyUqLazbPMcwnhqbr9B0+jqM5DQBJbisqUNWsGe2BLuV8FZ7VyjW1
 nTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bCdAd7Be6DRYvzpoO8DYOlXvYCiC9pmHXI5mvLQ78DM=;
 b=EBQ7ucQe/tHFXKC6Wf6u+/VwFHFbzMSCBETziSNTsd3DpZ/rgUSLUUD3ePb8NS9fQV
 dpHeD3QiruXLv5w1sAHS/Apw5L//vasmdLbHY/egi6A7IKH6EJX2JdnB/p/rp+otlJp2
 6evVCvUlQWGRaZraxDYEQXcnM3/B5JIhKDFEC+Vba/4krCersoK1Gx+geyPu46ot5ouy
 vyBmibkz9bwxKGkPq8At6qy27JjTX2Sue+Jc6Ei10L0LHFtTLYO8qmUXh8D2i+CK6VXJ
 QBnaZc+WsKcjHODCxKZtWFajk5Deyh+Cb6HccNJGgKhfKbBNAe2WQAVdUbPBkhIVlmb3
 Nj/A==
X-Gm-Message-State: AOAM5328/2t/m/4e3Cu5UvuNmtuw/7bCrbilRi71qUjrbV/wt18O1Yvp
 hvfSsvOtuyfzX5zUw4E5n8Z0eIGP9Um8Pw==
X-Google-Smtp-Source: ABdhPJz9UCYmCXiWNOaBNxg/IgYdufRwKdEJ5zOuoIDfn//q/msMHTpnKjrsoXBrGzcPOvhsJGeUzw==
X-Received: by 2002:a1c:e917:: with SMTP id q23mr692273wmc.125.1597089030552; 
 Mon, 10 Aug 2020 12:50:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b129sm976087wmb.29.2020.08.10.12.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 12:50:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 05/20] qapi/machine.json: Escape a literal '*' in doc
 comment
Date: Mon, 10 Aug 2020 20:50:04 +0100
Message-Id: <20200810195019.25427-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200810195019.25427-1-peter.maydell@linaro.org>
References: <20200810195019.25427-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For rST, '*' is a kind of inline markup (for emphasis), so
"*-softmmu" is a syntax error because of the missing closing '*'.
Escape the '*' with a '\'.

The texinfo document generator will leave the '\' in the
output, which is not ideal, but that generator is going to
go away in a subsequent commit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/machine.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 5aee2bbd169..3f6ea5693d1 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -13,7 +13,7 @@
 #
 # The comprehensive enumeration of QEMU system emulation ("softmmu")
 # targets. Run "./configure --help" in the project root directory, and
-# look for the *-softmmu targets near the "--target-list" option. The
+# look for the \*-softmmu targets near the "--target-list" option. The
 # individual target constants are not documented here, for the time
 # being.
 #
-- 
2.20.1


