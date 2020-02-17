Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231FEC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 21:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE83620725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 21:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFLzAI0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE83620725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3neO-0004qM-49
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 16:09:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j3ndd-0003h4-No
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 16:09:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j3ndc-0008TE-Qq
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 16:09:09 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j3nda-0008Re-Rf; Mon, 17 Feb 2020 16:09:06 -0500
Received: by mail-pg1-x542.google.com with SMTP id d9so9862349pgu.3;
 Mon, 17 Feb 2020 13:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=GQgJidPFXL9L+5VnERG3WiMD3P/4Nq4D9jL2IVB/SHk=;
 b=HFLzAI0Qz2d9N2KTZKMjXm/yrQNnfkPwI22PNo2Tbt/FX4R0TjCJBrC88mBMYIuFOi
 RMj+6OQTwxEVd4gvGHCy+o6yG4N2uAGms7NFTbCTggjLFT279LQulPDQ7nPViHYL+Pjx
 ORqmWuIXXV9drPQn9jwkEWN5qOrhB+A2cm89+uMkS8wDPOxSgSP9DCRuBhLvg7fYZFfL
 YGgilcVnHgcPQymtbrq4KaCyQt0g8DeHhv5R6R/sS55HQhANjzZRITFCRcIsDWvj1r+P
 IV/Y6/2jeEyPqgC5lO/0wBNUVwSOhuh9dpLtR/9S65j3CIzFRDW+VTdhmoL64IMaZ65h
 aRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=GQgJidPFXL9L+5VnERG3WiMD3P/4Nq4D9jL2IVB/SHk=;
 b=SPZB6x5mb3LKsOu5osu2HCJM/zWE7HxDfM3a3jb7Vrr1pRsuiRZ+YthEpjoOWaYCuI
 4/ZIbpwsvu2OSRjaklIZ/eYBinXHKvVyA9Fg5S72YydBlDQu3KBhyV6Jkrj2wlwb1zYC
 R+ZCIHdnyjoVM1wh7t9KaceBeITZtdi7gzVeSdZJOx5+WJAQUfGqosoKpMSHgOTfrTVl
 vy/APJxFMz0SZFIT1H9fMW8Glq3MbsPcA+z3Wh/s1jRS/MdcIaTWjmsrcq8+nYRbroMA
 VkTYC+KqOWtgnycf5JpSECiSbtpZdvQY4sDv9y44TY0KI+F+mkRuWEC+HQBaEZMtWHsA
 zfmQ==
X-Gm-Message-State: APjAAAWXW0c0FC5FFl2qg9dvYIPpjZfN+tLPhfgTnq4vK/ny0UVcnl/K
 3ouNMD3edBjfEEy4zFqP8co=
X-Google-Smtp-Source: APXvYqw22Y7+GUItDenCv8bMW2LrO43v/OZYYuWqrBUGKaG8E4TP2qhCaBXpS6MITeUMMQ90rro+yg==
X-Received: by 2002:a63:d845:: with SMTP id k5mr18675513pgj.183.1581973745917; 
 Mon, 17 Feb 2020 13:09:05 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id e9sm344058pjt.16.2020.02.17.13.09.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 17 Feb 2020 13:09:05 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] z2: Make providing flash images non-mandatory
Date: Mon, 17 Feb 2020 13:09:03 -0800
Message-Id: <20200217210903.18602-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Up to now, the z2 machine only boots if a flash image is provided.
This is not really necessary; the machine can boot from initrd or from
SD without it. At the same time, having to provide dummy flash images
is a nuisance and does not add any real value. Make it optional.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/arm/z2.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 34794fe3ae..4bb237f22d 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -314,12 +314,6 @@ static void z2_init(MachineState *machine)
     be = 0;
 #endif
     dinfo = drive_get(IF_PFLASH, 0, 0);
-    if (!dinfo && !qtest_enabled()) {
-        error_report("Flash image must be given with the "
-                     "'pflash' parameter");
-        exit(1);
-    }
-
     if (!pflash_cfi01_register(Z2_FLASH_BASE, "z2.flash0", Z2_FLASH_SIZE,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                                sector_len, 4, 0, 0, 0, 0, be)) {
-- 
2.17.1


