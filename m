Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888B9C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 550502133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gayLlwi2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550502133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3p9-0000L6-VH
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qR-0004gI-D1
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qQ-0007tp-65
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:15 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qP-0007t1-WD
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:14 -0400
Received: by mail-wm1-x343.google.com with SMTP id m18so17318012wmc.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=BM7ehIz5Ww7Rbyjkjbjfbg9xCinxhB61Wg4bl5OWXAg=;
 b=gayLlwi2hJehQW9Rdr8WSdD3jdF98S8Vtxlknqc8wTqGSB/JZkl9cxofFccQ9v3OVt
 6eTxqM01bQz9knOQ/qHHS5mheN8bKNNL7smqkWfwfD/Sc7Q7McYU8liN4A+DzOXpl8bL
 3g+NvKrb4eMqlnxYTsE6YweW76sWlm9r0z+qgmOneg8xkAd5oAooh2riW4EJ6Rr8IIyl
 4Xkd9F0leJJEGtfUYaTOAa0mMm1r1is70Ms1eRX/8W5DnhTVp1NYWKC+A0VOhNFmDPTz
 xceOoMQAcRVPqrd27C0+aq1VP4T0GTNhWRzy9lP8QY+OMaQVRCtfTDk4aqdcGcc+hQrK
 7zuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BM7ehIz5Ww7Rbyjkjbjfbg9xCinxhB61Wg4bl5OWXAg=;
 b=KLaqYxSMQMMKTTxf/LnIw4hjj5nywEakWN1BX0NYnvsTPaLX1o1DcUtBiHTyu3e6cC
 9RGtwRNIfUjJ8W+KCVuWJhiChjpBLUEW5PnxA3r2aLSyiCnYXbMnrEApzzqtRnj/yDP9
 4IHEGV62MrxqtkRLdt4svweR/J3v7FI9v04MEjvGFD2tv0zTWnBXl+hEOfsyN5k82FP5
 5m+ksRNIuIaqgtfXFdLJk++wfHcUClPL6azk3SBcH/oaJJgxTPFxjL48TsSGED72AF66
 dOF1za0m2B0QU2tGfknAAtQBLEvALAQCn1XnOifdtNBbaNdwohC1zQLHx5uamtfLdMzF
 JLtg==
X-Gm-Message-State: APjAAAVWuMdhw48hEp62ewPGLGHDBy+WCr4zs6V88eFziGhI/j1NODgL
 o0GHih/VTIphfxMhf93x5wrkoAmt7hjzJA==
X-Google-Smtp-Source: APXvYqzSrGwU+5+8/XGpWF2TfwrsAACg4v2w0lvARieQVwf3rzb4tZL+CuxgjNZbGomujFxKmLoI1Q==
X-Received: by 2002:a05:600c:21c8:: with SMTP id
 x8mr14542425wmj.123.1571069112610; 
 Mon, 14 Oct 2019 09:05:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/68] target/arm/arm-semi: Implement SH_EXT_STDOUT_STDERR
 extension
Date: Mon, 14 Oct 2019 17:03:35 +0100
Message-Id: <20191014160404.19553-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SH_EXT_STDOUT_STDERR is a v2.0 semihosting extension: the guest
can open ":tt" with a file mode requesting append access in
order to open stderr, in addition to the existing "open for
read for stdin or write for stdout". Implement this and
report it via the :semihosting-features data.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20190916141544.17540-16-peter.maydell@linaro.org
---
 target/arm/arm-semi.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index f65d8c907e8..6f7b6d801bf 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -516,13 +516,14 @@ static uint32_t gdb_flenfn(ARMCPU *cpu, GuestFD *gf)
 
 /* Feature bits reportable in feature byte 0 */
 #define SH_EXT_EXIT_EXTENDED (1 << 0)
+#define SH_EXT_STDOUT_STDERR (1 << 1)
 
 static const uint8_t featurefile_data[] = {
     SHFB_MAGIC_0,
     SHFB_MAGIC_1,
     SHFB_MAGIC_2,
     SHFB_MAGIC_3,
-    SH_EXT_EXIT_EXTENDED, /* Feature byte 0 */
+    SH_EXT_EXIT_EXTENDED | SH_EXT_STDOUT_STDERR, /* Feature byte 0 */
 };
 
 static void init_featurefile_guestfd(int guestfd)
@@ -710,7 +711,21 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         }
 
         if (strcmp(s, ":tt") == 0) {
-            int result_fileno = arg1 < 4 ? STDIN_FILENO : STDOUT_FILENO;
+            int result_fileno;
+
+            /*
+             * We implement SH_EXT_STDOUT_STDERR, so:
+             *  open for read == stdin
+             *  open for write == stdout
+             *  open for append == stderr
+             */
+            if (arg1 < 4) {
+                result_fileno = STDIN_FILENO;
+            } else if (arg1 < 8) {
+                result_fileno = STDOUT_FILENO;
+            } else {
+                result_fileno = STDERR_FILENO;
+            }
             associate_guestfd(guestfd, result_fileno);
             unlock_user(s, arg0, 0);
             return guestfd;
-- 
2.20.1


