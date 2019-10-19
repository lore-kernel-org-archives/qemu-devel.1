Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D689DCA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E82020678
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klEle5kt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E82020678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLyYE-0000Yi-J1
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 19:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRa-0000HW-GT
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRY-0005a5-8S
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:34 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRY-0005ZW-0n; Sat, 19 Oct 2019 19:47:32 -0400
Received: by mail-wm1-x341.google.com with SMTP id p7so9571374wmp.4;
 Sat, 19 Oct 2019 16:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L3PyH2PjL+LWUaikQoc64nh02rfGUu8GQgytHqJUX0k=;
 b=klEle5kt/0R/rt1ixQbVIN7HhxMlS/C2C03S5qnsDPT5J0c0qFHxQA89TGKuWxuvQq
 yiauRhCKZjpXMe7BYIOyZknNumf8fD7qaqNFiJnpWxOWTDqRNylJ/KpbREmpPyqO24us
 MQdIFAj0/0GV8SBosNceFxHo4oOvGjseGgtJuWPwzmA2pX4APlM0qQwxwYLlcwvsCzH9
 XgDL/hK0XE3EoBSX2ngxd4CQ8V9BAX0pnKmZNapS4/WRTrRCSxHfHO3cgcYFU9FG85/+
 2LeW6W/0D2ZQy44tcJ5sts8Pvdq41QDs+6qRNL4Hbe9Z91KEIPPJTm35rOxaqp3tA+CK
 fb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=L3PyH2PjL+LWUaikQoc64nh02rfGUu8GQgytHqJUX0k=;
 b=LIQnebTKPhskeoMHK7MaqUcKF6Vj0Ozxr36dDsU9lSiuxWIDX4t5q/uyalaqCekzOp
 ELHtzOVAG/o+AxbePSrGgSG8K+VreBM0ML9oZcmQbeaWN95jxqwR8RxuBepSVY0VtP0c
 S/3lGoIil6EbW0OaCUOh7f442mKHLKiACo38v2r7FnsEA2qSXJU9p1Ks9pRJ5z5pMcxq
 0FSgXyQzuzTLDfxVXaOVAqYjSNomY+RSBhApPido/x+WCd7xOqiVH9b9udLPAVoiJ61F
 2ppxLByAhx92xQCuERhYDOFsxAM7/5UDK2xqp5DT3KKaLAm7zT98ofbzlsPa4CZVE8/B
 5FCw==
X-Gm-Message-State: APjAAAWxQGlFfyR8AyQpOut2KQl5EcwD3E5Qx122QUysPVow3IWtZ0Hd
 L+nmVhu1IABJOX8n0uOJ5GTV+LGy
X-Google-Smtp-Source: APXvYqyAsrcwYuMkKlB8RmOWW/V1J9Usiypj0uWkYJpGolnHeHtR7wZQMV9xRI/x3x68oS/v5CjHnw==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr13795436wmc.8.1571528850539; 
 Sat, 19 Oct 2019 16:47:30 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id u1sm10433763wrp.56.2019.10.19.16.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 16:47:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/16] hw/arm/bcm2836: Use per CPU address spaces
Date: Sun, 20 Oct 2019 01:47:06 +0200
Message-Id: <20191019234715.25750-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019234715.25750-1-f4bug@amsat.org>
References: <20191019234715.25750-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

Currently all CPUs access the main system bus. Let each CPU have
his own address space.

Before:

  (qemu) info mtree
  address-space: memory
    0000000000000000-ffffffffffffffff (prio 0, i/o): system
      0000000000000000-000000003fffffff (prio 0, ram): ram
      000000003f000000-000000003fffffff (prio 1, i/o): bcm2835-peripherals
        000000003f003000-000000003f00301f (prio 0, i/o): bcm2835-sys-timer
        000000003f007000-000000003f007fff (prio 0, i/o): bcm2835-dma
        000000003f00b200-000000003f00b3ff (prio 0, i/o): bcm2835-ic
        000000003f00b400-000000003f00b43f (prio -1000, i/o): bcm2835-sp804
        000000003f00b800-000000003f00bbff (prio 0, i/o): bcm2835-mbox
        000000003f100000-000000003f100fff (prio -1000, i/o): bcm2835-cprman
        000000003f102000-000000003f102fff (prio -1000, i/o): bcm2835-a2w
        000000003f104000-000000003f10400f (prio 0, i/o): bcm2835-rng
        000000003f200000-000000003f200fff (prio 0, i/o): bcm2835_gpio
        000000003f201000-000000003f201fff (prio 0, i/o): pl011
        000000003f202000-000000003f202fff (prio 0, i/o): bcm2835-sdhost
        000000003f203000-000000003f2030ff (prio -1000, i/o): bcm2835-i2s
        000000003f204000-000000003f20401f (prio -1000, i/o): bcm2835-spi0
        000000003f205000-000000003f20501f (prio -1000, i/o): bcm2835-i2c0
        000000003f20f000-000000003f20f07f (prio -1000, i/o): bcm2835-otp
        000000003f212000-000000003f212007 (prio 0, i/o): bcm2835-thermal
        000000003f214000-000000003f2140ff (prio -1000, i/o): bcm2835-spis
        000000003f215000-000000003f2150ff (prio 0, i/o): bcm2835-aux
        000000003f300000-000000003f3000ff (prio 0, i/o): sdhci
        000000003f600000-000000003f6000ff (prio -1000, i/o): bcm2835-smi
        000000003f804000-000000003f80401f (prio -1000, i/o): bcm2835-i2c1
        000000003f805000-000000003f80501f (prio -1000, i/o): bcm2835-i2c2
        000000003f900000-000000003f907fff (prio -1000, i/o): bcm2835-dbus
        000000003f910000-000000003f917fff (prio -1000, i/o): bcm2835-ave0
        000000003f980000-000000003f980fff (prio -1000, i/o): dwc-usb2
        000000003fe00000-000000003fe000ff (prio -1000, i/o): bcm2835-sdramc
        000000003fe05000-000000003fe050ff (prio 0, i/o): bcm2835-dma-chan15
      0000000040000000-00000000400000ff (prio 0, i/o): bcm2836-control

  address-space: cpu-secure-memory-0
    0000000000000000-ffffffffffffffff (prio 0, i/o): system
      0000000000000000-000000003fffffff (prio 0, ram): ram
      000000003f000000-000000003fffffff (prio 1, i/o): bcm2835-peripherals
        000000003f003000-000000003f00301f (prio 0, i/o): bcm2835-sys-timer
        000000003f007000-000000003f007fff (prio 0, i/o): bcm2835-dma
        000000003f00b200-000000003f00b3ff (prio 0, i/o): bcm2835-ic
        000000003f00b400-000000003f00b43f (prio -1000, i/o): bcm2835-sp804
        000000003f00b800-000000003f00bbff (prio 0, i/o): bcm2835-mbox
        000000003f100000-000000003f100fff (prio -1000, i/o): bcm2835-cprman
        000000003f102000-000000003f102fff (prio -1000, i/o): bcm2835-a2w
        000000003f104000-000000003f10400f (prio 0, i/o): bcm2835-rng
        000000003f200000-000000003f200fff (prio 0, i/o): bcm2835_gpio
        000000003f201000-000000003f201fff (prio 0, i/o): pl011
        000000003f202000-000000003f202fff (prio 0, i/o): bcm2835-sdhost
        000000003f203000-000000003f2030ff (prio -1000, i/o): bcm2835-i2s
        000000003f204000-000000003f20401f (prio -1000, i/o): bcm2835-spi0
        000000003f205000-000000003f20501f (prio -1000, i/o): bcm2835-i2c0
        000000003f20f000-000000003f20f07f (prio -1000, i/o): bcm2835-otp
        000000003f212000-000000003f212007 (prio 0, i/o): bcm2835-thermal
        000000003f214000-000000003f2140ff (prio -1000, i/o): bcm2835-spis
        000000003f215000-000000003f2150ff (prio 0, i/o): bcm2835-aux
        000000003f300000-000000003f3000ff (prio 0, i/o): sdhci
        000000003f600000-000000003f6000ff (prio -1000, i/o): bcm2835-smi
        000000003f804000-000000003f80401f (prio -1000, i/o): bcm2835-i2c1
        000000003f805000-000000003f80501f (prio -1000, i/o): bcm2835-i2c2
        000000003f900000-000000003f907fff (prio -1000, i/o): bcm2835-dbus
        000000003f910000-000000003f917fff (prio -1000, i/o): bcm2835-ave0
        000000003f980000-000000003f980fff (prio -1000, i/o): dwc-usb2
        000000003fe00000-000000003fe000ff (prio -1000, i/o): bcm2835-sdramc
        000000003fe05000-000000003fe050ff (prio 0, i/o): bcm2835-dma-chan15
      0000000040000000-00000000400000ff (prio 0, i/o): bcm2836-control

  address-space: cpu-memory-0
    0000000000000000-ffffffffffffffff (prio 0, i/o): system
      0000000000000000-000000003fffffff (prio 0, ram): ram
      000000003f000000-000000003fffffff (prio 1, i/o): bcm2835-peripherals
        000000003f003000-000000003f00301f (prio 0, i/o): bcm2835-sys-timer
        000000003f007000-000000003f007fff (prio 0, i/o): bcm2835-dma
        000000003f00b200-000000003f00b3ff (prio 0, i/o): bcm2835-ic
        000000003f00b400-000000003f00b43f (prio -1000, i/o): bcm2835-sp804
        000000003f00b800-000000003f00bbff (prio 0, i/o): bcm2835-mbox
        000000003f100000-000000003f100fff (prio -1000, i/o): bcm2835-cprman
        000000003f102000-000000003f102fff (prio -1000, i/o): bcm2835-a2w
        000000003f104000-000000003f10400f (prio 0, i/o): bcm2835-rng
        000000003f200000-000000003f200fff (prio 0, i/o): bcm2835_gpio
        000000003f201000-000000003f201fff (prio 0, i/o): pl011
        000000003f202000-000000003f202fff (prio 0, i/o): bcm2835-sdhost
        000000003f203000-000000003f2030ff (prio -1000, i/o): bcm2835-i2s
        000000003f204000-000000003f20401f (prio -1000, i/o): bcm2835-spi0
        000000003f205000-000000003f20501f (prio -1000, i/o): bcm2835-i2c0
        000000003f20f000-000000003f20f07f (prio -1000, i/o): bcm2835-otp
        000000003f212000-000000003f212007 (prio 0, i/o): bcm2835-thermal
        000000003f214000-000000003f2140ff (prio -1000, i/o): bcm2835-spis
        000000003f215000-000000003f2150ff (prio 0, i/o): bcm2835-aux
        000000003f300000-000000003f3000ff (prio 0, i/o): sdhci
        000000003f600000-000000003f6000ff (prio -1000, i/o): bcm2835-smi
        000000003f804000-000000003f80401f (prio -1000, i/o): bcm2835-i2c1
        000000003f805000-000000003f80501f (prio -1000, i/o): bcm2835-i2c2
        000000003f900000-000000003f907fff (prio -1000, i/o): bcm2835-dbus
        000000003f910000-000000003f917fff (prio -1000, i/o): bcm2835-ave0
        000000003f980000-000000003f980fff (prio -1000, i/o): dwc-usb2
        000000003fe00000-000000003fe000ff (prio -1000, i/o): bcm2835-sdramc
        000000003fe05000-000000003fe050ff (prio 0, i/o): bcm2835-dma-chan15
      0000000040000000-00000000400000ff (prio 0, i/o): bcm2836-control

  memory-region: ram
    0000000000000000-000000003fffffff (prio 0, ram): ram

  memory-region: bcm2835-peripherals
    000000003f000000-000000003fffffff (prio 1, i/o): bcm2835-peripherals
      000000003f003000-000000003f00301f (prio 0, i/o): bcm2835-sys-timer
      000000003f007000-000000003f007fff (prio 0, i/o): bcm2835-dma
      000000003f00b200-000000003f00b3ff (prio 0, i/o): bcm2835-ic
      000000003f00b400-000000003f00b43f (prio -1000, i/o): bcm2835-sp804
      000000003f00b800-000000003f00bbff (prio 0, i/o): bcm2835-mbox
      000000003f100000-000000003f100fff (prio -1000, i/o): bcm2835-cprman
      000000003f102000-000000003f102fff (prio -1000, i/o): bcm2835-a2w
      000000003f104000-000000003f10400f (prio 0, i/o): bcm2835-rng
      000000003f200000-000000003f200fff (prio 0, i/o): bcm2835_gpio
      000000003f201000-000000003f201fff (prio 0, i/o): pl011
      000000003f202000-000000003f202fff (prio 0, i/o): bcm2835-sdhost
      000000003f203000-000000003f2030ff (prio -1000, i/o): bcm2835-i2s
      000000003f204000-000000003f20401f (prio -1000, i/o): bcm2835-spi0
      000000003f205000-000000003f20501f (prio -1000, i/o): bcm2835-i2c0
      000000003f20f000-000000003f20f07f (prio -1000, i/o): bcm2835-otp
      000000003f212000-000000003f212007 (prio 0, i/o): bcm2835-thermal
      000000003f214000-000000003f2140ff (prio -1000, i/o): bcm2835-spis
      000000003f215000-000000003f2150ff (prio 0, i/o): bcm2835-aux
      000000003f300000-000000003f3000ff (prio 0, i/o): sdhci
      000000003f600000-000000003f6000ff (prio -1000, i/o): bcm2835-smi
      000000003f804000-000000003f80401f (prio -1000, i/o): bcm2835-i2c1
      000000003f805000-000000003f80501f (prio -1000, i/o): bcm2835-i2c2
      000000003f900000-000000003f907fff (prio -1000, i/o): bcm2835-dbus
      000000003f910000-000000003f917fff (prio -1000, i/o): bcm2835-ave0
      000000003f980000-000000003f980fff (prio -1000, i/o): dwc-usb2
      000000003fe00000-000000003fe000ff (prio -1000, i/o): bcm2835-sdramc
      000000003fe05000-000000003fe050ff (prio 0, i/o): bcm2835-dma-chan15

After:

  (qemu) info mtree
  address-space: memory
    0000000000000000-ffffffffffffffff (prio 0, i/o): system

  address-space: cpu-secure-memory-0
    0000000000000000-00000000ffffffff (prio 0, i/o): cpu-bus
      0000000000000000-000000003fffffff (prio 1, i/o): alias arm-ram @ram 0000000000000000-000000003fffffff
      000000003f000000-000000003fffffff (prio 2, i/o): alias arm-peripherals @bcm2835-peripherals 0000000000000000-0000000000ffffff
      0000000040000000-0000000040003fff (prio 2, i/o): alias arm-control @bcm2836-control 0000000000000000-0000000000003fff

  address-space: cpu-memory-0
    0000000000000000-00000000ffffffff (prio 0, i/o): cpu-bus
      0000000000000000-000000003fffffff (prio 1, i/o): alias arm-ram @ram 0000000000000000-000000003fffffff
      000000003f000000-000000003fffffff (prio 2, i/o): alias arm-peripherals @bcm2835-peripherals 0000000000000000-0000000000ffffff
      0000000040000000-0000000040003fff (prio 2, i/o): alias arm-control @bcm2836-control 0000000000000000-0000000000003fff

  memory-region: ram
    0000000000000000-000000003fffffff (prio 0, ram): ram

  memory-region: bcm2835-peripherals
    0000000000000000-0000000000ffffff (prio 0, i/o): bcm2835-peripherals
      0000000000003000-000000000000301f (prio 0, i/o): bcm2835-sys-timer
      0000000000007000-0000000000007fff (prio 0, i/o): bcm2835-dma
      000000000000b200-000000000000b3ff (prio 0, i/o): bcm2835-ic
      000000000000b400-000000000000b43f (prio -1000, i/o): bcm2835-sp804
      000000000000b800-000000000000bbff (prio 0, i/o): bcm2835-mbox
      0000000000100000-0000000000100fff (prio -1000, i/o): bcm2835-cprman
      0000000000102000-0000000000102fff (prio -1000, i/o): bcm2835-a2w
      0000000000104000-000000000010400f (prio 0, i/o): bcm2835-rng
      0000000000200000-0000000000200fff (prio 0, i/o): bcm2835_gpio
      0000000000201000-0000000000201fff (prio 0, i/o): pl011
      0000000000202000-0000000000202fff (prio 0, i/o): bcm2835-sdhost
      0000000000203000-00000000002030ff (prio -1000, i/o): bcm2835-i2s
      0000000000204000-000000000020401f (prio -1000, i/o): bcm2835-spi0
      0000000000205000-000000000020501f (prio -1000, i/o): bcm2835-i2c0
      000000000020f000-000000000020f07f (prio -1000, i/o): bcm2835-otp
      0000000000212000-0000000000212007 (prio 0, i/o): bcm2835-thermal
      0000000000214000-00000000002140ff (prio -1000, i/o): bcm2835-spis
      0000000000215000-00000000002150ff (prio 0, i/o): bcm2835-aux
      0000000000300000-00000000003000ff (prio 0, i/o): sdhci
      0000000000600000-00000000006000ff (prio -1000, i/o): bcm2835-smi
      0000000000804000-000000000080401f (prio -1000, i/o): bcm2835-i2c1
      0000000000805000-000000000080501f (prio -1000, i/o): bcm2835-i2c2
      0000000000900000-0000000000907fff (prio -1000, i/o): bcm2835-dbus
      0000000000910000-0000000000917fff (prio -1000, i/o): bcm2835-ave0
      0000000000980000-0000000000980fff (prio -1000, i/o): dwc-usb2
      0000000000e00000-0000000000e000ff (prio -1000, i/o): bcm2835-sdramc
      0000000000e05000-0000000000e050ff (prio 0, i/o): bcm2835-dma-chan15

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2836.c         | 39 ++++++++++++++++++++++++++++++++++-----
 hw/arm/raspi.c           |  2 --
 include/hw/arm/bcm2836.h |  4 ++++
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 221ff06895..374a44b38c 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "cpu.h"
@@ -51,6 +52,8 @@ static void bcm2836_init(Object *obj)
     int n;
 
     for (n = 0; n < BCM283X_NCPUS; n++) {
+        memory_region_init(&s->cpu[n].container, obj, "cpu-bus", 4 * GiB);
+
         object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
                                 sizeof(s->cpu[n].core), info->cpu_type,
                                 &error_abort, NULL);
@@ -72,9 +75,11 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
     BCM283XState *s = BCM283X(dev);
     BCM283XClass *bc = BCM283X_GET_CLASS(dev);
     const BCM283XInfo *info = bc->info;
+    MemoryRegion *ram_mr, *peri_mr, *ctrl_mr;
     Object *obj;
     Error *err = NULL;
     int n;
+    uint64_t ram_size;
 
     /* common peripherals from bcm2835 */
 
@@ -84,13 +89,14 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
                    __func__, error_get_pretty(err));
         return;
     }
+    ram_mr = MEMORY_REGION(obj);
+    ram_size = memory_region_size(ram_mr);
 
     object_property_add_const_link(OBJECT(&s->peripherals), "ram", obj, &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
-
     object_property_set_bool(OBJECT(&s->peripherals), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
@@ -104,8 +110,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
-                            info->peri_base, 1);
+    peri_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->peripherals), 0);
 
     /* bcm2836 interrupt controller (and mailboxes, etc.) */
     object_property_set_bool(OBJECT(&s->control), true, "realized", &err);
@@ -113,8 +118,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, info->ctrl_base);
+    ctrl_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->control), 0);
 
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
         qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-irq", 0));
@@ -122,6 +126,31 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-fiq", 0));
 
     for (n = 0; n < BCM283X_NCPUS; n++) {
+        memory_region_init_alias(&s->cpu[n].ram_alias, OBJECT(s),
+                                 "arm-ram", ram_mr, 0, ram_size);
+        memory_region_add_subregion_overlap(&s->cpu[n].container, 0,
+                                            &s->cpu[n].ram_alias, 1);
+
+        memory_region_init_alias(&s->cpu[n].peri_alias, OBJECT(s),
+                                 "arm-peripherals", peri_mr, 0, 16 * MiB);
+        memory_region_add_subregion_overlap(&s->cpu[n].container,
+                                            info->peri_base,
+                                            &s->cpu[n].peri_alias, 2);
+
+        memory_region_init_alias(&s->cpu[n].control_alias, OBJECT(s),
+                                 "arm-control", ctrl_mr, 0, 16 * KiB);
+        memory_region_add_subregion_overlap(&s->cpu[n].container,
+                                            info->ctrl_base,
+                                            &s->cpu[n].control_alias, 2);
+
+        object_property_set_link(OBJECT(&s->cpu[n].core),
+                                 OBJECT(&s->cpu[n].container),
+                                 "memory", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
         /* TODO: this should be converted to a property of ARM_CPU */
         s->cpu[n].core.mp_affinity = (info->clusterid << 8) | n;
 
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 615d755879..a12459bc41 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -184,8 +184,6 @@ static void raspi_init(MachineState *machine, int version)
     /* Allocate and map RAM */
     memory_region_allocate_system_memory(&s->ram, OBJECT(machine), "ram",
                                          machine->ram_size);
-    /* FIXME: Remove when we have custom CPU address space support */
-    memory_region_add_subregion_overlap(get_system_memory(), 0, &s->ram, 0);
 
     /* Setup the SOC */
     object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram),
diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 92a6544816..e3498cb861 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -37,6 +37,10 @@ typedef struct BCM283XState {
 
     struct {
         ARMCPU core;
+        MemoryRegion container;
+        MemoryRegion ram_alias;
+        MemoryRegion peri_alias;
+        MemoryRegion control_alias;
     } cpu[BCM283X_NCPUS];
     BCM2836ControlState control;
     BCM2835PeripheralState peripherals;
-- 
2.21.0


