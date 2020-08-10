Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE216C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7450A22CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="anPA1VU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7450A22CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5DsC-0008Sq-Iq
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Dol-0000gF-Dt
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:47 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:37860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Doi-0004nA-IC
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:47 -0400
Received: by mail-wr1-x42c.google.com with SMTP id y3so9308381wrl.4
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5W1KknFp9KSiL5Xfv87WpKM4kTEKJloaAztwVUv2s+w=;
 b=anPA1VU9T62Gre5BAwyOOrmr0YIxTqPjID6zid6XgdLGi4kiRTfh/SBdg4gvJhH2V3
 //LCST1IaSwmx3ukvSezdEZeNxIwYzSQZT1OLP9Yg9ZaF9KnJDjUfWXug33uc+NdxY+Y
 4jpQq4iBz5BJ1HeZgTRpniqdUBosKshg/mXellYxY8wgINny5PA3lAGsmzFYir/T3aVT
 jzC7rragwMmrToNxOfWZ21nVjDlFAu20wHCU00TgZwaGy3mUBpPP+D8kVqTUfNe5F1E9
 K6JZFcas4QhitE6gNC6wLREqvEcoQX1pQjMfQJ9i35xWau9uDyamjm4hZ3VJSAmu5Gvj
 PwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5W1KknFp9KSiL5Xfv87WpKM4kTEKJloaAztwVUv2s+w=;
 b=bo6yrAAFLGB0r+VYiegLMIoPXz+bFtcBtKDpL2z5MYs3q4hV4SImoTH2XJsRaYshNE
 mw70DPk8HfdBDUETUwcXORU+tJbB6GczAVBfPVyS/QS7blFBXYV8YUiIOKUV4zIxZ0CL
 qaSt42mX1lOR4JPOdpZ1cqs36HB4lBBGfput9uGQJetp/h0M/2CRl8YvR99yXsVVhtjD
 YtdyO1u76eXuqIh9zsILJrJG3lokCS5OE3yFX1ow0rvCL32NuHouhkVmvolluYpsUJxv
 45hB3HxuvEeSzPQyq8V3glOcbr/mER0BrhEsWgWs6erMO2/zUd0LjTYgos5lzN1oRSbt
 jUnw==
X-Gm-Message-State: AOAM533+St+jG715SbDzqLoijNQcsP1juTQ2IYtOch043sxA5fEZhn+P
 eB9GiYiZtOcTnqFz7xUTqpWSQcI93aQa+g==
X-Google-Smtp-Source: ABdhPJzoy34koVCaL7/g8Ne5LQ8Q4LiJJ7HdyjuDfyRrPvkUKjLwIJf1m3iAqpT+mVLmIhaZsqKHTQ==
X-Received: by 2002:adf:efcc:: with SMTP id i12mr2916747wrp.308.1597089042336; 
 Mon, 10 Aug 2020 12:50:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b129sm976087wmb.29.2020.08.10.12.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 12:50:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 12/20] qapi: Use rST markup for literal blocks
Date: Mon, 10 Aug 2020 20:50:11 +0100
Message-Id: <20200810195019.25427-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200810195019.25427-1-peter.maydell@linaro.org>
References: <20200810195019.25427-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

There are exactly two places in our json doc comments where we
use the markup accepted by the texi doc generator where a '|' in
the first line of a doc comment means the line should be emitted
as a literal block (fixed-width font, whitespace preserved).

Since we use this syntax so rarely, instead of making the rST
generator support it, instead just convert the two uses to
rST-format literal blocks, which are indented and introduced
with '::'.

(The rST generator doesn't complain about the old style syntax,
it just emits it with the '|' and with the whitespace not
preserved, which looks odd, but means we can safely leave this
change until after we've stopped generating texinfo.)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/block-core.json  | 16 +++++++++-------
 qapi/qapi-schema.json |  6 ++++--
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 535b2b2e7bf..12758116e85 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -566,13 +566,15 @@
 #        For the example above, @bins may be something like [3, 1, 5, 2],
 #        and corresponding histogram looks like:
 #
-# |      5|           *
-# |      4|           *
-# |      3| *         *
-# |      2| *         *    *
-# |      1| *    *    *    *
-# |       +------------------
-# |           10   50   100
+# ::
+#
+#        5|           *
+#        4|           *
+#        3| *         *
+#        2| *         *    *
+#        1| *    *    *    *
+#         +------------------
+#             10   50   100
 #
 # Since: 4.0
 ##
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 5fc0771eb04..c19b4267058 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -23,8 +23,10 @@
 #
 # Example:
 #
-# | -> data issued by the Client
-# | <- Server data response
+# ::
+#
+#   -> data issued by the Client
+#   <- Server data response
 #
 # Please, refer to the QMP specification (docs/interop/qmp-spec.txt) for
 # detailed information on the Server command and response formats.
-- 
2.20.1


