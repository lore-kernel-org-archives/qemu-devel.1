Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC51FC3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B013C207FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qkka7/kL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B013C207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tSp-00017c-LO
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:35:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tP2-0003PB-ID
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tP0-0002CY-ID
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:15 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37752)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tP0-0002Bc-Bu
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:14 -0500
Received: by mail-wr1-x442.google.com with SMTP id 6so2374682wre.4
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=srKZx6+JQVSktw34hlVpZslhqf3wdIxhXrsJ7DiNWzA=;
 b=qkka7/kLUm1EEp7zTZwq1HX5481ZQrz3D67GJgd1XpGMU0nnSIUDhHPCGD1//Et5Zc
 fdjpJiJM8bicRywBBkXbpe8l1Cg0TCUMES2oh3BcenRzGpEtFHhpmoETShqxxH7HVwwY
 D36AnmtI9X83ixxjV6EX+WOfpeI+NlAnCw98GLoq3rHg1kkqjckFRHXqyAyeuGz5zIpo
 UbdgCbfVcTsV6S+8ar/FljH3wPWNifA6C/SNagYcfImNZ45O2gwcqan96AS4p3wxGbM5
 2GPqvF+cJjgYKl9cuMPcWTy3g4sAg+VTKjArdHYDJN6rF5Y0xGMvxABwR+oi73d2bL2A
 uL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=srKZx6+JQVSktw34hlVpZslhqf3wdIxhXrsJ7DiNWzA=;
 b=GQKNi2GC8AV22AK0j8OzXN+UjOGz/srqXOGHSojNCp09shfvM/HILZWbo+DWft/9lZ
 Nv4z6zp1cdP2RVk858s03JUz7lIf8HVJL+0Hoba6YQ+cJ5+J12ARLMjI1Ur8ZQIKWura
 za+PpdOffmw5tH1LwS3/eeFHC3n5AXxg8S9kQtIRHugN8FHqK71mDIRZR25jFtlZr38e
 MZUN2PkSbdVFxbfH14bWvX+vROdPxvbXpE6DCKx/+puTutL3ZzVGpdaFuuRFIxatQxID
 emjo6Zo1Iv6TP1OKXZALX2DEie/BENof9rszoxIOifdIMPFf5G3ttYvze6G1vPu/cwOC
 djKQ==
X-Gm-Message-State: ANhLgQ3K79mMMc2yOqmwjZem2HRxp3FnGqidG1YvC8Q+3NN52LJq1prp
 quIGR4dVCM7Bi+ryYEOTeACgwHg3NXeUFw==
X-Google-Smtp-Source: ADFU+vstNPmWYtrPXoFBGj4ivzZE+cIIyKEo/uvnBpUUef2U8DJYBNtxe004leh6hbV0l4vhagNL6w==
X-Received: by 2002:adf:a419:: with SMTP id d25mr11662565wra.210.1583425872994; 
 Thu, 05 Mar 2020 08:31:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/37] hw/arm/z2: Simplify since the machines are little-endian
 only
Date: Thu,  5 Mar 2020 16:30:32 +0000
Message-Id: <20200305163100.22912-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We only build the little-endian softmmu configurations. Checking
for big endian is pointless, remove the unused code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/z2.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 4bb237f22d2..a0f40959904 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -300,7 +300,6 @@ static void z2_init(MachineState *machine)
     uint32_t sector_len = 0x10000;
     PXA2xxState *mpu;
     DriveInfo *dinfo;
-    int be;
     void *z2_lcd;
     I2CBus *bus;
     DeviceState *wm;
@@ -308,15 +307,10 @@ static void z2_init(MachineState *machine)
     /* Setup CPU & memory */
     mpu = pxa270_init(address_space_mem, z2_binfo.ram_size, machine->cpu_type);
 
-#ifdef TARGET_WORDS_BIGENDIAN
-    be = 1;
-#else
-    be = 0;
-#endif
     dinfo = drive_get(IF_PFLASH, 0, 0);
     if (!pflash_cfi01_register(Z2_FLASH_BASE, "z2.flash0", Z2_FLASH_SIZE,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                               sector_len, 4, 0, 0, 0, 0, be)) {
+                               sector_len, 4, 0, 0, 0, 0, 0)) {
         error_report("Error registering flash memory");
         exit(1);
     }
-- 
2.20.1


