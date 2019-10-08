Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F128EC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:40:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC12F21721
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n0h/OAvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC12F21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHraq-0007UX-UV
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 11:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHrVe-0002wm-LE
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHrVb-0003fP-CO
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:34:45 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHrVX-0003YR-Mc
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:34:40 -0400
Received: by mail-wr1-x442.google.com with SMTP id j11so14155571wrp.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=e4JhAZxlmZjmqrccTSdWRaEe+g0S059qc6/DVH2T8LE=;
 b=n0h/OAvN/LHsvYJY1sR6Wni6fg/wNKxGYCuHBZZHYkZmWsDHL2N1pzqcf68tfpjAqP
 guO10srDO8+VXKH3VjwDGDR2WlsLngVEFEb4LqJzcF70j/wq9Qo8ozjRNWU8mnsNnO0K
 4hH9TVQ1bhpBt3rn7Db/uKBWmoVM60mm+7HugTtxolxlC4nw/Y4EAmFm3K1xnuZ68zVM
 8CgEgblHyd5dR4Wf0JX6UhPobSFApZ4gjfykZXqIV5GTsY6rIoG26XkaYpV/Kfz6EyTE
 /RdvWVRVZyKp97UWQ5T/52CM6AUqI8iv66Io3lHhnYMgo2xxzD7Tq6exGXpW3z8LDJqc
 L74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=e4JhAZxlmZjmqrccTSdWRaEe+g0S059qc6/DVH2T8LE=;
 b=ujaxcdiZlxG9NsxUAb3Rw1Ev0N+S5SPOCm1Aq6Eo6oivPowhSkaaf1MCvl5CjfmQPi
 400SoXsfGBJFSqELyQfuAXrwPYNEYqpjE4SAxooT41zQSVlCnaFb02KlqF+MY3jAxTZN
 xtTjGzYNUq5e6E37SStjErkmL5BFgZJcTjvhGzgw+mnppR/737p7fgvVILlYhtIyEQqu
 o7qdkqzTzHD/ixjKLn7kBMe+c+hImQsRq2cmtA1rKYoFNS4uUYycWyKVg83yJyxuitMq
 dH/RXqaa0lwpLD/GcucdGqdg4SNBF8qPlhnlwDgXz+2VKAoFnvIkJ1advifJBpCanH5D
 k0mw==
X-Gm-Message-State: APjAAAV1v0ZasnixyDZRA4aYFxTZhdInjAiv+Vc8iPltwXB8cz0A9QFg
 z6/BZLa0VvtVT7d2c+daU6hcsA==
X-Google-Smtp-Source: APXvYqzK1hT9mXnUUszX94LooFgEBk0PL8iOIpjn3tb3GBluQoZlp60s61nH4n3tDKugx3/xM11QSA==
X-Received: by 2002:adf:fbc7:: with SMTP id d7mr11347069wrs.171.1570548876930; 
 Tue, 08 Oct 2019 08:34:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u10sm4318212wmm.0.2019.10.08.08.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 08:34:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C3C511FF87;
 Tue,  8 Oct 2019 16:34:35 +0100 (BST)
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-17-f4bug@amsat.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 16/19] tests/boot_linux_console: Add a test for the
 Raspberry Pi 2
In-reply-to: <20190926173428.10713-17-f4bug@amsat.org>
Date: Tue, 08 Oct 2019 16:34:35 +0100
Message-ID: <87muebi73o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Zolt=C3=A1n?= Baldaszti <bztemail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Similar to the x86_64/pc test, it boots a Linux kernel on a raspi2
> board and verify the serial is working.
>
> The kernel image and DeviceTree blob are built by the Raspbian
> project (based on Debian):
> https://www.raspbian.org/RaspbianImages
> as recommended by the Raspberry Pi project:
> https://www.raspberrypi.org/downloads/raspbian/
>
> If ARM is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:arm" tags.
>
> Alternatively, this test can be run using:
>
>     $ avocado run -t arch:arm tests/acceptance
>     $ avocado run -t machine:raspi2 tests/acceptance
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> v3: removed debug printf (Cleber)
>     use serial_kernel_cmdline dict
> ---
>  tests/acceptance/boot_linux_console.py | 36 ++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 079590f0c8..7eaf6cb60e 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -318,6 +318,42 @@ class BootLinuxConsole(Test):
>          self.vm.launch()
>          self.wait_for_console_pattern('init started: BusyBox')
>
> +    def do_test_arm_raspi2(self, uart_id):
> +        """
> +        The kernel can be rebuilt using the kernel source referenced
> +        and following the instructions on the on:
> +        https://www.raspberrypi.org/documentation/linux/kernel/building.=
md
> +        """
> +        serial_kernel_cmdline =3D {
> +            0: 'earlycon=3Dpl011,0x3f201000 console=3DttyAMA0',
> +        }
> +        deb_url =3D ('http://archive.raspberrypi.org/debian/'
> +                   'pool/main/r/raspberrypi-firmware/'
> +                   'raspberrypi-kernel_1.20190215-1_armhf.deb')
> +        deb_hash =3D 'cd284220b32128c5084037553db3c482426f3972'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        kernel_path =3D self.extract_from_deb(deb_path, '/boot/kernel7.i=
mg')
> +        dtb_path =3D self.extract_from_deb(deb_path, '/boot/bcm2709-rpi-=
2-b.dtb')
> +
> +        self.vm.set_machine('raspi2')
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               serial_kernel_cmdline[uart_id])
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
> +        self.wait_for_console_pattern(console_pattern)
> +
> +    def test_arm_raspi2_uart0(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:raspi2
> +        :avocado: tags=3Ddevice:pl011
> +        """
> +        self.do_test_arm_raspi2(0)
> +
>      def test_s390x_s390_ccw_virtio(self):
>          """
>          :avocado: tags=3Darch:s390x


--
Alex Benn=C3=A9e

