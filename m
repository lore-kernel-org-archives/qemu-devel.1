Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9243CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93E2120678
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adqvvPr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E2120678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLyZq-0003In-9I
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 19:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRk-0000Y1-KM
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRj-0005h4-Gp
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:44 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRj-0005gV-Ar; Sat, 19 Oct 2019 19:47:43 -0400
Received: by mail-wm1-x344.google.com with SMTP id g24so376050wmh.5;
 Sat, 19 Oct 2019 16:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bG9RMPIGC9ljNya02ZnuD6xFZnx6LHmfx6JD2fgLckE=;
 b=adqvvPr6OvliCpivqvTDkGK5pQwwU3ewhTuLsLRCQEk84kVmVPjdrMkB0UNfCg7zlB
 oBcYILWfOQZ5/xZYuqggf1n4qHUx22Lc4oLoSjP6lV7GDKAz1h1VMG+cWnwhvkwF0XP9
 lQ3CeE3jffuGat5ctNihyts9U1Xo/aIOiy+HMP54f/qmasHdf3gJL9j2lcTpxhfZ3Omy
 5UwntNzjxICuMpA7S8Sf8cuXtSWhqtTOZ6Ka4Q436UZnmW9UpQQsJfl17/ry9G43NJ7f
 Ns0nopxdld0vPWVvKNwQHCE21zoUayIkXKNf7zp1vISoauT3CbkT4UQxcr2rcuqTZFb9
 Xg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=bG9RMPIGC9ljNya02ZnuD6xFZnx6LHmfx6JD2fgLckE=;
 b=Fc1uG7ml7wE9H+TPyRdbSi0aL6fehvn5mFo4nIOXZEImvIhn0z56cS1LBaB4D0ABg+
 PPZhOon46O7suX3ElkzQJg+BIz0vZWRKlgwkWenyLNcD+G5aAVPVR50CmB19/R/ZGXOi
 CEsLaU8yPz6LpoUME85xNDjxf/QM2aO33Gpa1hUaEmlj4FLO6bKXXf3iDTuCgKMNnTBD
 EG4EsiEcSKMnJaekbjxlBp9yzAZvKTZMWtt3plldKPXD/mvy1kSHnFS2wBAhJxK5nXx5
 bfg+mYWDeHKV+Rq24i6gBobiQ1VgQhpJoXaQwNCtuH/wbVSt0S4mkJVHSmpWVE+FpBUE
 cOSA==
X-Gm-Message-State: APjAAAXjzQe4crn2UhMaMjYsG7VPALakgJecBoSlnWYB+ZK2+tvGlDOv
 i6blnOm/IP53hQx9M590QqP5sOfG
X-Google-Smtp-Source: APXvYqz+Xqeje+XUM0XtNWaXzciQQtB5xpxZpONv7PQ1gUn8R2r0pxMj5A7UANd8hdkOjpZgaRmi1Q==
X-Received: by 2002:a1c:9c0c:: with SMTP id f12mr7379593wme.133.1571528862229; 
 Sat, 19 Oct 2019 16:47:42 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id u1sm10433763wrp.56.2019.10.19.16.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 16:47:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/16] hw/arm/highbank: Use AddressSpace when using
 write_secondary_boot()
Date: Sun, 20 Oct 2019 01:47:13 +0200
Message-Id: <20191019234715.25750-15-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019234715.25750-1-f4bug@amsat.org>
References: <20191019234715.25750-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

write_secondary_boot() is used in SMP configurations where the
CPU address space might not be the main System Bus.
The rom_add_blob_fixed_as() function allow us to specify an
address space. Use it to write each boot blob in the corresponding
CPU address space.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/highbank.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index f1724d6929..518d935fdf 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -78,7 +78,8 @@ static void hb_write_secondary(ARMCPU *cpu, const struct arm_boot_info *info)
     for (n = 0; n < ARRAY_SIZE(smpboot); n++) {
         smpboot[n] = tswap32(smpboot[n]);
     }
-    rom_add_blob_fixed("smpboot", smpboot, sizeof(smpboot), SMP_BOOT_ADDR);
+    rom_add_blob_fixed_as("smpboot", smpboot, sizeof(smpboot), SMP_BOOT_ADDR,
+                          arm_boot_address_space(cpu, info));
 }
 
 static void hb_reset_secondary(ARMCPU *cpu, const struct arm_boot_info *info)
-- 
2.21.0


