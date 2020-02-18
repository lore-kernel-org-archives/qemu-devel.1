Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D8DC34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 08:08:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B52A206EF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 08:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="L9Q/iQ5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B52A206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3xvo-0007m9-9z
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 03:08:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1j3xsL-00065y-Rf
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 03:05:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1j3xsK-0003JD-Gb
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 03:05:01 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:60046)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1j3xsG-0003Fo-Om; Tue, 18 Feb 2020 03:04:57 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id BCC7496EF0;
 Tue, 18 Feb 2020 08:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1582013094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tGyqGwDRbxUKf6Z/MSnBwmUozILvP3C0b36blPlMfbs=;
 b=L9Q/iQ5c7zpBUcURA8FtfCY8SpxK+16lzs2JlB+zUrDB+KuUhicvvgGiD3XCg6XFY7Rjun
 CNFX6E5JEmucSM2E/1MX8E6cq/GH4QdoGww4CYqfpVnAJUBb5yT4F1O6pZe5d8IcZWEw1r
 P0v1Zks+s8giVPaHVMDxQTxCcA9q45U=
Subject: Re: [PATCH v2] tests/boot_linux_console: Boot Trusted Firmware-A on
 the Raspberry Pi 3
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200217103442.30318-1-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <dc7d3ca4-5613-43ab-a48b-e28a6ea0cd51@greensocs.com>
Date: Tue, 18 Feb 2020 09:04:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217103442.30318-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1582013094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tGyqGwDRbxUKf6Z/MSnBwmUozILvP3C0b36blPlMfbs=;
 b=frVCuOwkqqE9bpWyGevUtH51JveJGEg26QyUSs2evsUL+rbulhuE5S2lfhOfbXGrR9dm4G
 2/Ur7Vybhd/MZRZgR7ULX6B31lfhC3L3UJn4wT90NeP5Lx/2LuDwTqfuV3yvXHzoA4vcPL
 /hHv7PgA2BhCzLKGXIouSWeS6cvg0cE=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1582013094; a=rsa-sha256; cv=none;
 b=Jan71N4/JoWLOY2WFAz+Ub/+oV3mQ3fltnCNlQQmRan92dINsAQ4S7w0YY7YmmEWA1Y/Ln
 LktTPr1WsK7Uvtnse7JiR9twIR+ygIi/hhp4kP0Ub1c/pg+D1VXikXe6cd0hBTJ+ot8FWm
 V4dLStN0BGjLUKNF3/kDBH6iC7e9EHo=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
Cc: qemu-arm@nongnu.org, pete@akeo.ie,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 11:34 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> This test runs Trusted Firmware-A on the Raspberry Pi 3.
> We deliberately stop the boot process when the EDK2 UEFI version
> is displayed.
>=20
> The binary is build on AppVeyor CI using Pete Batard repository [1].
> ATF v2.1 binary are used (see [2]). Extra documentation in [3].
>=20
> It is very simple and fast:
>=20
>   $ avocado --show=3Dapp,console run -t atf tests/acceptance
>   JOB ID     : 1e748d7c9e9011cf0af3250ddc8ebf2389d6204e
>   JOB LOG    : avocado/job-results/job-2020-02-16T18.08-1e748d7/job.log
>    (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_a=
arch64_raspi3_atf:
>   console: NOTICE:  Booting Trusted Firmware
>   console: NOTICE:  BL1: v2.1(release):v2.1
>   console: NOTICE:  BL1: Built : 15:26:06, May 13 2019
>   console: NOTICE:  rpi3: Detected: Raspberry Pi 3 Model B (1GB, Sony, =
UK) [0x00a02082]
>   console: NOTICE:  BL1: Booting BL2
>   console: ERROR:   rpi3_sdhost: timeout status 0x40
>   console: NOTICE:  BL2: v2.1(release):v2.1
>   console: NOTICE:  BL2: Built : 15:26:01, May 13 2019
>   console: NOTICE:  BL1: Booting BL31
>   console: NOTICE:  BL31: v2.1(release):v2.1
>   console: NOTICE:  BL31: Built : 15:26:04, May 13 2019
>   console: =3DUEFI firmware (version UEFI Firmware v1.15 built at 11:58=
:44 on Feb 14 2020)
>   PASS (1.54 s)
>   RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT =
0 | CANCEL 0
>   JOB TIME   : 1.88 s
>=20
> [1] https://github.com/pbatard/RPi3#summary
> [2] https://github.com/ARM-software/arm-trusted-firmware/blob/v2.1/docs=
/plat/rpi3.rst
> [3] http://www.skylyrac.net/2018-02-01-port-arm-tf-to-rpi3.html
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
> v2: Start with a single core powered-on
> ---
>  tests/acceptance/boot_linux_console.py | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index 34d37eba3b..d1288fb59c 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -507,6 +507,30 @@ def test_arm_cubieboard_sata(self):
>          exec_command_and_wait_for_pattern(self, 'reboot',
>                                                  'reboot: Restarting sy=
stem')
> =20
> +    def test_aarch64_raspi3_atf(self):
> +        """
> +        :avocado: tags=3Darch:aarch64
> +        :avocado: tags=3Dmachine:raspi3
> +        :avocado: tags=3Dcpu:cortex-a53
> +        :avocado: tags=3Ddevice:pl011
> +        :avocado: tags=3Datf
> +        """
> +        zip_url =3D ('https://github.com/pbatard/RPi3/releases/downloa=
d/'
> +                   'v1.15/RPi3_UEFI_Firmware_v1.15.zip')
> +        zip_hash =3D '74b3bd0de92683cadb14e008a7575e1d0c3cafb9'
> +        zip_path =3D self.fetch_asset(zip_url, asset_hash=3Dzip_hash)
> +
> +        archive.extract(zip_path, self.workdir)
> +        efi_fd =3D os.path.join(self.workdir, 'RPI_EFI.fd')
> +
> +        self.vm.set_console(console_index=3D1)
> +        self.vm.add_args('-nodefaults',
> +                         # VideoCore starts CPU with only 1 core enabl=
ed
> +                         '-global', 'bcm2836.enabled-cpus=3D1',
> +                         '-device', 'loader,file=3D%s,force-raw=3Dtrue=
' % efi_fd)
> +        self.vm.launch()
> +        self.wait_for_console_pattern('version UEFI Firmware v1.15')
> +
>      def test_s390x_s390_ccw_virtio(self):
>          """
>          :avocado: tags=3Darch:s390x
>=20

