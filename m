Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C4FC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D5ED2468E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZoN4bK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D5ED2468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7IFw-0006fS-Nf
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 07:27:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7IFB-0006CG-0C
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:26:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7IF9-0003fT-Eo
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:26:20 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37268)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7IF7-0003YX-Hu
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:26:17 -0500
Received: by mail-ot1-x341.google.com with SMTP id b3so2721211otp.4
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 04:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eTG6V3z9UwcQWL0+TEFrKJ5GjzjiN9Fcq5E9RXBdoR0=;
 b=OZoN4bK59WDeF2XtAeKh+BYRUKVUWXLWzCi8RRzj8zn+DKMFc2c0EJFi54rcYgOfsU
 emBfe/bov8Fve/GzppF9HeNnGFmJzPs1baZPORFTiRdK+yoyonS0NL3F2l7bRtQHCQp7
 25sHCLKihn4GQ0TlZxi6dT7nHZf/EtzAs20qbXA1fZRa8qS38eoB7vknmFb5l2o2UrtR
 Han819l+jxAjPBcU7xjBjv9aQ170aa211CSsvYwBAaX20c+6agFcOQk7BHytzN6AUBhu
 GwJAMix1AuAtqLPQKZ4xCWKuvXDIfIUavfXqErz4tMz4G+E2nyIMvE0Wzv0eugNT/YGs
 zyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eTG6V3z9UwcQWL0+TEFrKJ5GjzjiN9Fcq5E9RXBdoR0=;
 b=LDwBMAYeHo9DscEsgw2XNK4YbF8pjb5g9MoIPXw2/oChqUeJhe3YoGDH0dZh5nIUWG
 bqBn1I9TpEDYtTJwxxccnJv+Q8lelCuRGZNFNb44N+92iGxOz5vjbIchbJ9J3uyw3gD1
 5h9tft69UNXj0sIHhFgghUoAPjIq/PSYe+yoEEfWEbt3Mg+XHs9T7VEQ3cO+GDofRCEX
 o+912+DdywcoGAzFg70TINZyPDf37S7E16imClnvykwHKcxgcWV0Mz7rBeprLGIjDsyw
 WETD6CSFnZLrV6WdjaCDpddAP24T5t4DeaLYPmeBGZD7V+Rx17lcBIf09xwdovLU/vKv
 BTbQ==
X-Gm-Message-State: APjAAAUxuOBISSY59DiZml2lBtUk3D/ko6ST76Mt8Vx5hMJMAylWDTAz
 GiyKSuG2pF7ATXJHuv7PlblSHQu8wgymLwGh1syd7A==
X-Google-Smtp-Source: APXvYqxanObOoSTYruw4OJ22o7UyPT1ESIgJz9ThP3DDVNQeH4RbRJ0v2nI0ppfZ0JBBNqkYGsW9DcIavODCvg53SFE=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr3107690otd.91.1582806375573; 
 Thu, 27 Feb 2020 04:26:15 -0800 (PST)
MIME-Version: 1.0
References: <20200226113034.6741-1-pbonzini@redhat.com>
 <20200226113034.6741-19-pbonzini@redhat.com>
In-Reply-To: <20200226113034.6741-19-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2020 12:26:04 +0000
Message-ID: <CAFEAcA_721QV7FKjmnFHUZsvHrACkFsu2hya_CeMe2wqOFoB_A@mail.gmail.com>
Subject: Re: [PATCH 18/18] docs/system: convert Texinfo documentation to rST
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 at 11:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Apart from targets.rst, which was written by hand, this is an automated
> conversion obtained with the following command:
>
>   makeinfo --force -o - --docbook \
>     -D 'qemu_system_x86 QEMU_SYSTEM_X86_MACRO' \
>     -D 'qemu_system     QEMU_SYSTEM_MACRO' \
>     $texi | pandoc -f docbook -t rst+smart | perl -e '
>       $/=3Dundef;
>       $_ =3D <>;
>       s/^-  =E2=88=92 /-  /gm;
>       s/QEMU_SYSTEM_MACRO/|qemu_system|/g;
>       s/QEMU_SYSTEM_X86_MACRO/|qemu_system_x86|/g;
>       s/(?=3D::\n\n +\|qemu)/.. parsed-literal/g;
>       s/:\n\n::$/::/gm;
>       print' > $rst
>
> In addition, the following changes were made manually:
>
> - target-i386.rst and target-mips.rst: replace CPU model documentation wi=
th
>   an include directive
>
> - monitor.rst: replace the command section with a comment
>
> - images.rst: add toctree
>
> - invocation.rst and ivshmem.rst: annotate more parsed-literal blocks
>
> Content that is not @included remains exclusive to qemu-doc.texi.

My Sphinx doesn't like this:

Warning, treated as error:
/home/petmay01/linaro/qemu-from-laptop/qemu/docs/system/target-arm.rst:usin=
g
"math" markup without a Sphinx math extension active, please use one
of the math extensions described at
http://sphinx-doc.org/en/master/ext/math.html

This is all down to the I2C/I2S usage of superscript; this fixes it:

diff --git a/docs/system/defs.rst.inc b/docs/system/defs.rst.inc
index bf50b442b27..0ea4df966ca 100644
--- a/docs/system/defs.rst.inc
+++ b/docs/system/defs.rst.inc
@@ -1,2 +1,4 @@
 .. |qemu_system| replace:: ``qemu-system-x86_64``
 .. |qemu_system_x86| replace:: ``qemu_system_x86``
+.. |I2C| replace:: I\ :sup:`2`\ C
+.. |I2S| replace:: I\ :sup:`2`\ S
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index fcd8f43eef2..0490be55871 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -94,7 +94,7 @@ and \"Terrier\") emulation includes the following periphe=
rals:

 -  TI ADS7846 touchscreen controller on SSP bus

--  Maxim MAX1111 analog-digital converter on I\ :math:`^2`\ C bus
+-  Maxim MAX1111 analog-digital converter on |I2C| bus

 -  GPIO-connected keyboard controller and LEDs

@@ -102,7 +102,7 @@ and \"Terrier\") emulation includes the following
peripherals:

 -  Three on-chip UARTs

--  WM8750 audio CODEC on I\ :math:`^2`\ C and I\ :math:`^2`\ S busses
+-  WM8750 audio CODEC on |I2C| and |I2S| busses

 The Palm Tungsten|E PDA (codename \"Cheetah\") emulation includes the
 following elements:
@@ -117,7 +117,7 @@ following elements:
 -  On-chip Real Time Clock

 -  TI TSC2102i touchscreen controller / analog-digital converter /
-   Audio CODEC, connected through MicroWire and I\ :math:`^2`\ S busses
+   Audio CODEC, connected through MicroWire and |I2S| busses

 -  GPIO-connected matrix keypad

@@ -139,7 +139,7 @@ Nokia N800 and N810 internet tablets (known also
as RX-34 and RX-44 /
    controllers driven through SPI bus

 -  National Semiconductor LM8323-controlled qwerty keyboard driven
-   through I\ :math:`^2`\ C bus
+   through |I2C| bus

 -  Secure Digital card connected to OMAP MMC/SD host

@@ -148,10 +148,10 @@ Nokia N800 and N810 internet tablets (known also
as RX-34 and RX-44 /
 -  Mentor Graphics \"Inventra\" dual-role USB controller embedded in a
    TI TUSB6010 chip - only USB host mode is supported

--  TI TMP105 temperature sensor driven through I\ :math:`^2`\ C bus
+-  TI TMP105 temperature sensor driven through |I2C| bus

 -  TI TWL92230C power management companion with an RTC on
-   I\ :math:`^2`\ C bus
+   |I2C| bus

 -  Nokia RETU and TAHVO multi-purpose chips with an RTC, connected
    through CBUS
@@ -163,10 +163,10 @@ devices:

 -  64k Flash and 8k SRAM.

--  Timers, UARTs, ADC and I\ :math:`^2`\ C interface.
+-  Timers, UARTs, ADC and |I2C| interface.

 -  OSRAM Pictiva 96x16 OLED with SSD0303 controller on
+-  Timers, UARTs, ADC and |I2C| interface.

 -  OSRAM Pictiva 96x16 OLED with SSD0303 controller on
-   I\ :math:`^2`\ C bus.
+   |I2C| bus.

 The Luminary Micro Stellaris LM3S6965EVB emulation includes the
 following devices:
@@ -175,7 +175,7 @@ following devices:

 -  256k Flash and 64k SRAM.

--  Timers, UARTs, ADC, I\ :math:`^2`\ C and SSI interfaces.
+-  Timers, UARTs, ADC, |I2C| and SSI interfaces.

 -  OSRAM Pictiva 128x64 OLED with SSD0323 controller connected via
    SSI.

thanks
-- PMM

