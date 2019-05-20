Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0031C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 22:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B6FB20862
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 22:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7yrwjEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6FB20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42990 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSqw5-0004f0-Ms
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 18:39:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hSqum-0003p5-1n
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hSquk-0001r8-PJ
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:37:52 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:40709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hSquk-0001pe-Hq; Mon, 20 May 2019 18:37:50 -0400
Received: by mail-lf1-x142.google.com with SMTP id h13so11516104lfc.7;
	Mon, 20 May 2019 15:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=PY+CsTSh8GPctl9g5Hg+Op4ObYrj5XAFUZbl6/vgehY=;
	b=Q7yrwjEjcsduDgJCtw54glcG/sGGBm0t3Zxfc0dSesXxtHPDmNUdfXrEHCLj/2xOgF
	sdwFijhvQ4pHFXvgUn/+KNm87pnEAoNhMab5wiY8PH2lSCc/By8/RVyQBrGnmmJ0BaRb
	SdQiesyVH7MJc/uqMFagRb+oFhrPbiqsquVHV3xJ0PSAIb9NcqfPDUnfJ5eqDNL7KtSM
	V8tRvetyucO7x+k92wVZrseCNh3qW26m+0D4Dw4rjk2Zp9jdJBM+VGhasTaTnqJTInDC
	Z5dw2sdmLmZqjcl3CULi/3Cby6GGysIGtJsJqh7vlcF/OCAp+JGCmPsPHEvlkt0pASfv
	jwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=PY+CsTSh8GPctl9g5Hg+Op4ObYrj5XAFUZbl6/vgehY=;
	b=WSSeCqVIvw6aYmnGHHbYqq2KkOnSFmtZmZxH/pl4iAdJ9AwwftfX7JvxuA1etlKQCt
	7WFiFsCCTs+IEgPfcjDh3kKF/93WQJPYMudPq6tgG2EDBPexz+dFZt5iH0KUe14iCKOb
	8p/KxL7kHj29muhItkAlpfv9Y6Sv0XOskM1zGb0N24UAzIrstizExtIHVVR/5LtNX0aG
	fjJkzHgEHuBcGwo2q9F/TTHjSxu0tPyBoTZB5wsJfM7cApF34tTnNeO9+eAQ0hCwUWJ9
	O2ni2fDq5s3LILAjw+nyWIa2PhwVbU2o6aSIJpBsCox7hT8Xb6ie2ca9xgjRUl5iJsGP
	/Uiw==
X-Gm-Message-State: APjAAAX6PyFgj0RfwuaP2FRhyY4o8JQUBmuXEuN4J0T7DHI7jGcd38KP
	X9Ym4ZcLNnS/Zzf3NYz3Xxnn2Zo+Nht6JnNq1qI=
X-Google-Smtp-Source: APXvYqx8p2XoW5ANxvB/gwA8UAQFQsPr+waU/Q96WsWA/j3TdDpVJVNwcvoXjGyxePASgLUr+DjWSB9SdxGNWsfIMGg=
X-Received: by 2002:a19:4bd1:: with SMTP id y200mr39051168lfa.25.1558391868543;
	Mon, 20 May 2019 15:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190520220635.10961-1-f4bug@amsat.org>
	<20190520220635.10961-3-f4bug@amsat.org>
In-Reply-To: <20190520220635.10961-3-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 May 2019 15:35:33 -0700
Message-ID: <CAKmqyKMsVgy-f4oPZ9UaFZHqt5Q+D7=2sr=5tFqY_eU-Jws2Jg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH 2/2] BootLinuxConsoleTest: Test the
 SmartFusion2 board
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	Cleber Rosa <crosa@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	Caio Carrara <ccarrara@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 20, 2019 at 3:09 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Similar to the x86_64/pc test, it boots a Linux kernel on an
> Emcraft board and verify the serial is working.
>
> If ARM is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:arm" tags.
>
> Alternatively, this test can be run using:
>
>   $ avocado run -t arch:arm tests/acceptance
>   $ avocado run -t machine:emcraft-sf2 tests/acceptance
>
> Based on the recommended test setup from Subbaraya Sundeep:
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03810.html
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/acceptance/boot_linux_console.py | 27 ++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index f593f3858e..844cb80bb5 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -178,6 +178,33 @@ class BootLinuxConsole(Test):
>          console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
>          self.wait_for_console_pattern(console_pattern)
>
> +    def test_arm_emcraft_sf2(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:emcraft-sf2
> +        :avocado: tags=3Dendian:little
> +        """
> +        uboot_url =3D ('https://raw.githubusercontent.com/'
> +                     'Subbaraya-Sundeep/qemu-test-binaries/'
> +                     'fa030bd77a014a0b8e360d3b7011df89283a2f0b/u-boot')
> +        uboot_hash =3D 'abba5d9c24cdd2d49cdc2a8aa92976cf20737eff'
> +        uboot_path =3D self.fetch_asset(uboot_url, asset_hash=3Duboot_ha=
sh)
> +        spi_url =3D ('https://raw.githubusercontent.com/'
> +                   'Subbaraya-Sundeep/qemu-test-binaries/'
> +                   'fa030bd77a014a0b8e360d3b7011df89283a2f0b/spi.bin')
> +        spi_hash =3D '85f698329d38de63aea6e884a86fbde70890a78a'
> +        spi_path =3D self.fetch_asset(spi_url, asset_hash=3Dspi_hash)
> +
> +        self.vm.set_machine('emcraft-sf2')
> +        self.vm.set_console()
> +        kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE
> +        self.vm.add_args('-kernel', uboot_path,
> +                         '-append', kernel_command_line,
> +                         '-drive', 'file=3D' + spi_path + ',if=3Dmtd,for=
mat=3Draw',
> +                         '-no-reboot')
> +        self.vm.launch()
> +        self.wait_for_console_pattern('init started: BusyBox')
> +
>      def test_s390x_s390_ccw_virtio(self):
>          """
>          :avocado: tags=3Darch:s390x
> --
> 2.19.1
>
>

