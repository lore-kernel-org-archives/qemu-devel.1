Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023BFC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C106820830
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3FUYGeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C106820830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9ryN-0007DW-AQ
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnT-0004cW-JM
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnR-00072I-EC
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:07 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i9rnR-00070z-2w
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:16:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id y19so39087520wrd.3
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sbzqVgoyn7pJBiy5hHnuS48Tb76x8key349lTXeYMNs=;
 b=d3FUYGeg3cqVj9C1S9arYoSDEpD5y9oaeHUyB4LHN+eP+aQeE7wPsQdXQCWHFIl2IW
 bCxqisg7w+7xxrmXglSgz96bjs8IB6X3MLABMgniAHgWzo0cmAY6+iNbm6+d7ix4VXJH
 pWovFPiHofeAHLTGED1nyagAPB/Mh1WsBhP1b7KI6u4udpsG0qirNMQnDMgx4PwgKSoN
 1uImJ22ebqQBIS8WD2VmxWNArhS9gr4hHGXmoSEdgY/He4WMMBldspnX26/OPPMM0TP1
 jBNsrcdjLO8siKpFK7BK7sWZ7UkYKNPOb1na0kiCLNw8JCFPxAKIDkRqa0DBcSBO8E01
 NcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sbzqVgoyn7pJBiy5hHnuS48Tb76x8key349lTXeYMNs=;
 b=QHaWPWDkU9XDl9w8vmMcSB1x1jVoJFUrWGICHv2/Zbf2WUMX0wJU+T/NmhdR6Anqeu
 KIpvR3mYu29LOUOcUeVeBO6GorJwxGFEuY8ldiiGmudRIgIyUs1VCochjZZFw78jOWV8
 CdaENrk+Q9kVx9oizJrQjKabr7A28shdWGZjOW9unINdtzPNvL32wBK9CmJuNe/WhnEn
 hNzpAWKwDvOSMsViDWliyTAGXwP6vGZavRSOrVv6hRUM/nTrQhVUJEpAkliqCfC5gj31
 /YNzCZDCFMr/FHEijChtF2gFsLtlT7QNapCuilbu4maCUzEposYEG5Cq0hBXv4/MYEke
 /vag==
X-Gm-Message-State: APjAAAVUfqjogAVFC3uJ0mauvjymU2kTlDRHAGmSaqftrgqWdOYwH7jW
 z+/yX+7YpGoJn1NzRV+QrKaZFg==
X-Google-Smtp-Source: APXvYqypC/XW0HUi9u6xCUFphh2T+ilAYc+6fWlfpFBtC0WpVsqmNHtu6LUfKCQ1YVkhvCVKCSAK7A==
X-Received: by 2002:a5d:6043:: with SMTP id j3mr9974595wrt.337.1568643363989; 
 Mon, 16 Sep 2019 07:16:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s9sm15185884wme.36.2019.09.16.07.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 07:16:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:15:43 +0100
Message-Id: <20190916141544.17540-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916141544.17540-1-peter.maydell@linaro.org>
References: <20190916141544.17540-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v2 14/15] target/arm/arm-semi: Implement
 SH_EXT_EXIT_EXTENDED extension
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SH_EXT_EXIT_EXTENDED is a v2.0 semihosting extension: it
indicates that the implementation supports the SYS_EXIT_EXTENDED
function. This function allows both A64 and A32/T32 guests to
exit with a specified exit status, unlike the older SYS_EXIT
function which only allowed this for A64 guests. Implement
this extension.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/arm-semi.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 57491740d73..f65d8c907e8 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -59,6 +59,7 @@
 #define TARGET_SYS_HEAPINFO    0x16
 #define TARGET_SYS_EXIT        0x18
 #define TARGET_SYS_SYNCCACHE   0x19
+#define TARGET_SYS_EXIT_EXTENDED 0x20
 
 /* ADP_Stopped_ApplicationExit is used for exit(0),
  * anything else is implemented as exit(1) */
@@ -513,12 +514,15 @@ static uint32_t gdb_flenfn(ARMCPU *cpu, GuestFD *gf)
 #define SHFB_MAGIC_2 0x46
 #define SHFB_MAGIC_3 0x42
 
+/* Feature bits reportable in feature byte 0 */
+#define SH_EXT_EXIT_EXTENDED (1 << 0)
+
 static const uint8_t featurefile_data[] = {
     SHFB_MAGIC_0,
     SHFB_MAGIC_1,
     SHFB_MAGIC_2,
     SHFB_MAGIC_3,
-    0, /* Feature byte 0 */
+    SH_EXT_EXIT_EXTENDED, /* Feature byte 0 */
 };
 
 static void init_featurefile_guestfd(int guestfd)
@@ -1042,11 +1046,14 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return 0;
         }
     case TARGET_SYS_EXIT:
-        if (is_a64(env)) {
+    case TARGET_SYS_EXIT_EXTENDED:
+        if (nr == TARGET_SYS_EXIT_EXTENDED || is_a64(env)) {
             /*
-             * The A64 version of this call takes a parameter block,
+             * The A64 version of SYS_EXIT takes a parameter block,
              * so the application-exit type can return a subcode which
              * is the exit status code from the application.
+             * SYS_EXIT_EXTENDED is an a new-in-v2.0 optional function
+             * which allows A32/T32 guests to also provide a status code.
              */
             GET_ARG(0);
             GET_ARG(1);
@@ -1058,8 +1065,10 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             }
         } else {
             /*
-             * ARM specifies only Stopped_ApplicationExit as normal
-             * exit, everything else is considered an error
+             * The A32/T32 version of SYS_EXIT specifies only
+             * Stopped_ApplicationExit as normal exit, but does not
+             * allow the guest to specify the exit status code.
+             * Everything else is considered an error.
              */
             ret = (args == ADP_Stopped_ApplicationExit) ? 0 : 1;
         }
-- 
2.20.1


