Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92F4C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 01:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A313D20716
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 01:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOilrbL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A313D20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiTGW-0004ay-TG
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 20:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTAO-0002Vb-3l
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTAN-0006m9-5r
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:48 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42456)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTAM-0006i3-Tr
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:47 -0500
Received: by mail-wr1-x442.google.com with SMTP id q6so11029941wro.9
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 17:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=khfObrraH+OQVE05FoSKKYYMBZ+cKKyCWdxbeBJAw0M=;
 b=YOilrbL2O+wNeSpvGc88MosSSkbHNltFcklOYqGLle6y8YW/z5qoKNoPxpVHk/VHhh
 x2EI+v+S52zBnHo/zsK2Sd63ya83PejGmnpBfuGU7ZU/x3hY0raMwHzsSgJLc/cMUx0a
 TJbhpi86sngngiCO5os1zaZdsSmQcXJOAubkw/J22aEUfshILOEC6sqpYtDn281Ph66+
 6oT5zobWvfCGhtmfJA0mzwuZHhal2FXYezPMB557jm+eQLYLwRiSgvfaRMZBhUQ9OHAX
 SvwX97pfXeoZsJMAoeH+fQ+09tZSVQZVLfMKhc4LO3h+4EwDPiF9dKK9vmlAG9QRxeF6
 7ZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=khfObrraH+OQVE05FoSKKYYMBZ+cKKyCWdxbeBJAw0M=;
 b=lBYK6uluH/JJe+EBUK7LOD+kVx49xIdk7xSDRH7/JS3VhEwLT5A2f6Yj6y1ls8KAxW
 jqMqikiZfnnuiNh1z+SEKeyleol3w7RxdLB9bdcAjlmgnVAfLk/Eh4cjP9B/HBdSKarg
 YLtGv7F3BbsXzXEolEpyN4hAkO+9StvLkNGA/gQL7bIluy1N1WaIiP1/3zw136VP8TYk
 HwCqGAmwwmU7bQRzZPuCxBX2nhC8UOInicZREh3qmIwkg0y/9cErfcgbhJPo7oF7SJsT
 s4B2QjD9iTytjXVbIx4g90Llo9M7v0hnIdNnm8Qjel1w11WZ06awMb1xHSamlSWZNKdI
 oD5w==
X-Gm-Message-State: APjAAAXXnU/e4BT1iRX4Wonm3G+WJFu13/OUDY7Gu2py7zVp2ji6TR2f
 0s4orcyheXkiwAVsfPv3QIBW1tbI
X-Google-Smtp-Source: APXvYqx7d4klmo+ZIjBhYMkWiTDXx3DchmLli0P/CM+xCdEWtNFFY64PcYQXDmLNmYKp2EWZ4+YUsQ==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr18335447wrv.358.1576890165717; 
 Fri, 20 Dec 2019 17:02:45 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id t125sm8449596wmf.17.2019.12.20.17.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 17:02:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v2 5/8] tests/boot-serial-test: Test some Arduino boards (AVR
 based)
Date: Sat, 21 Dec 2019 02:02:23 +0100
Message-Id: <20191221010226.9230-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191221010226.9230-1-f4bug@amsat.org>
References: <20191221010226.9230-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Arduino Duemilanove is based on a AVR5 CPU, while the
Arduino MEGA2560 on a AVR6 CPU.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/boot-serial-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index e556f09db8..582a497963 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -113,6 +113,8 @@ typedef struct testdef {
 static testdef_t tests[] = {
     { "alpha", "clipper", "", "PCI:" },
     { "avr", "sample", "", "T", sizeof(bios_avr), NULL, bios_avr },
+    { "avr", "arduino-duemilanove", "", "T", sizeof(bios_avr), NULL, bios_avr },
+    { "avr", "arduino-mega-2560-v3", "", "T", sizeof(bios_avr), NULL, bios_avr},
     { "ppc", "ppce500", "", "U-Boot" },
     { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
     { "ppc", "g3beige", "", "PowerPC,750" },
-- 
2.21.0


