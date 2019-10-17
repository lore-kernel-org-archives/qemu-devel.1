Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC63CA9EB3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 23:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8C821D7A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 23:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTAHgF3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8C821D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLEpM-0007xX-P6
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 19:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLEj1-0000y4-Dd
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLEj0-0002Vo-FV
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:58:31 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43453)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLEj0-0002VH-9a; Thu, 17 Oct 2019 18:58:30 -0400
Received: by mail-wr1-x441.google.com with SMTP id j18so4123182wrq.10;
 Thu, 17 Oct 2019 15:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bG9RMPIGC9ljNya02ZnuD6xFZnx6LHmfx6JD2fgLckE=;
 b=vTAHgF3lJHR3WYvlOROJlt7HdhYy13GxTy4ieBOveHDFf4NtrshRFiZNXdLoGM99on
 xwSGQ2Qv44mszHuAK/EtHC00/h+WBR2lxPJBWuXqIrQRN9RRt+jKwj5Li83jPw10Cd7u
 Da4VCZ6+sU3UK2U2ltD7mGjefZjHlfmblRbzRpj6LfT6zYjpayy98MG77MPNQK3Gsz4h
 IUK7YTIbnLM4kPWCfuF5WKFdvbuVZSRduz1y5J84ru2NTpOY51RG5sMtZmB4P3MG1boW
 5VpMKOs/ojHoOjvJgtNTXHQdoPzz7b0vYcAt8JpGdFZhXGI3D3Y8MznB1i+QWwq3A+Jh
 4NvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=bG9RMPIGC9ljNya02ZnuD6xFZnx6LHmfx6JD2fgLckE=;
 b=GOYAqpmRCld7ajVRth2klwRCgdjVI/Aj4Iu5aFdfDO4jYyTkjhe/wGccryO5GCLJby
 uh9r0xUHe0wLUz0FiLXXhFh8PleBHzt6J5b8n/VG2K8n1O6Lv3t5de0mPWUTxy4hxlLe
 lFWPOR38QqICVwedmX18sFDycdoQTzUVJIGWNvBQDnPaUEbgx2Elo3jFDJiyDJvUyj3H
 yoF73X3PlJVuilp9xbBcOX25Lzxu4eTbHEbG9beFkeyDjBuGOMMQz3CUybE++wcNvIj7
 chHhEUZhst8ctVdrRJEwcgF7KQDyRY+vKfUumlxo9iy1fNGf8GAtRIHaPsP6C0O6WHG0
 3Kqw==
X-Gm-Message-State: APjAAAXvbF1SeDHrBRdpLCRxWEw1PrcfIRy0zs2uaZ3zAAQkWtXkbHwA
 lK6lMvQJOWseqTU48QmXCDVjRV64
X-Google-Smtp-Source: APXvYqzYvLP9iPPURahfyPOTtIBYJfN5hyTjptJaULVSAAQkJmEYgkzpEEmvRaPwiFWluccLdIknow==
X-Received: by 2002:a5d:44c8:: with SMTP id z8mr4977355wrr.66.1571353109098;
 Thu, 17 Oct 2019 15:58:29 -0700 (PDT)
Received: from localhost.localdomain (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id m18sm3993873wrg.97.2019.10.17.15.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 15:58:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/10] hw/arm/highbank: Use AddressSpace when using
 write_secondary_boot()
Date: Fri, 18 Oct 2019 00:58:00 +0200
Message-Id: <20191017225800.6946-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017225800.6946-1-f4bug@amsat.org>
References: <20191017225800.6946-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Rob Herring <robh@kernel.org>, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, Pekka Enberg <penberg@iki.fi>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Pete Batard <pete@akeo.ie>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Clement Deschamps <clement.deschamps@antfield.fr>
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


