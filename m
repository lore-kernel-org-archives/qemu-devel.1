Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BAFC7619B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607072064C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="27UMf5Xe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607072064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3c0N-0000vm-EW
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 03:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1j3bm6-0002Ji-C7
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:29:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1j3bm4-0007Ll-SD
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:29:06 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:47280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1j3bm4-0007LF-KB
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:29:04 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 1C46996F50;
 Mon, 17 Feb 2020 08:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1581928143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l/l+/nyo3VtMN/Jt+Vv8cGUFsVryv9bbYAXV7EkPsfo=;
 b=27UMf5Xe/ALJr3GSNl+MFISJUQFpk6NSV43QfeXmdINUicXN3LfaOeg4dXUvpSmGYEzc6X
 R0Ea2GY4jufD2vF+NoDs9Wkkqgvezrua64np54KUhFwc8DtWHZh+/AAgMJbiFcZc8Upiqf
 k+/5aIzJk2XUE6RI2Tf594bNxslJXnQ=
Subject: Re: [PATCH 8/8] tests/acceptance: Count Raspberry Pi logos displayed
 on framebuffer
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200215192216.4899-1-f4bug@amsat.org>
 <20200215192216.4899-9-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <21dd5eac-8c4f-63eb-4288-a2fb9bfe99c9@greensocs.com>
Date: Mon, 17 Feb 2020 09:29:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200215192216.4899-9-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1581928143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l/l+/nyo3VtMN/Jt+Vv8cGUFsVryv9bbYAXV7EkPsfo=;
 b=OLUgacUj0r/PLe6W89e/aaUZjJOkCeDukfb2aXzVDuPXNEQVGwEPFJ7ZECP38ciObH7tja
 120GlAAZ0yQJ7xLcyrM4ZW2v597sdNmcMqOvGm+B4ljOQCOGdGgbsAM5vllmSoU64GePGB
 C0qd2pVlTR67DIQM5Itrd4qk/dOeBqI=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1581928143; a=rsa-sha256; cv=none;
 b=DA0SpRMDMyWxxbtOWQGR4C9e+LfieBFHLMGO5CGLtNLoi6kVOatBIQt8pGf8D6tAEfrg1J
 rIOgm5UwAN8xglj7premU41QtbYULdTcq0uY7W/yzUULOHfgKcHMfENHoiBZ19NOgkdV1b
 W4uzkC+V9/OAJTVcC6Sl/t/oOxXCiyA=
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/15/20 8:22 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Add a test that verifies that each core properly displays the
> Raspberry Pi logo on the framebuffer device.
>=20
> We simply follow the OpenCV "Template Matching with Multiple Objects"
> tutorial, replacing Lionel Messi by a raspberrry:
> https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.html
>=20
> When OpenCV and NumPy are installed, this test can be run using:
>=20
>   $ avocado --show=3Dapp,framebuffer run -t device:bcm2835-fb tests/acc=
eptance/
>   JOB ID     : 9bbbc54c0a6fa180348d0b5305507f76852b4da2
>   JOB LOG    : avocado/job-results/job-2020-01-31T23.48-9bbbc54/job.log
>    (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_a=
rm_raspi2_framebuffer_logo:
>   framebuffer: found raspberry at position (x, y) =3D (0, 0)
>   framebuffer: found raspberry at position (x, y) =3D (71, 0)
>   framebuffer: found raspberry at position (x, y) =3D (142, 0)
>   framebuffer: found raspberry at position (x, y) =3D (213, 0)
>   PASS (11.06 s)
>   RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT =
0 | CANCEL 0
>   JOB TIME   : 11.39 s
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
> The resulting match can be visualised at https://pasteboard.co/ISzNHtx.=
png
> ---
>  tests/acceptance/boot_linux_console.py | 62 ++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index 989db7d461..7c960051a6 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -12,6 +12,7 @@
>  import lzma
>  import gzip
>  import shutil
> +import logging
> =20
>  from avocado import skipUnless
>  from avocado_qemu import Test
> @@ -22,6 +23,19 @@
>  from avocado.utils import archive
> =20
> =20
> +NUMPY_AVAILABLE =3D True
> +try:
> +    import numpy as np
> +except ImportError:
> +    NUMPY_AVAILABLE =3D False
> +
> +CV2_AVAILABLE =3D True
> +try:
> +    import cv2
> +except ImportError:
> +    CV2_AVAILABLE =3D False
> +
> +
>  class BootLinuxConsole(Test):
>      """
>      Boots a Linux kernel and checks that the console is operational an=
d the
> @@ -451,6 +465,54 @@ def test_arm_raspi2_uart1(self):
>          """
>          self.do_test_arm_raspi(2, 'bcm2835_aux')
> =20
> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
> +    def test_arm_raspi2_framebuffer_logo(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:raspi2
> +        :avocado: tags=3Ddevice:bcm2835-fb
> +        """
> +        screendump_path =3D os.path.join(self.workdir, 'screendump.pbm=
')
> +        rpilogo_url =3D ('https://github.com/raspberrypi/linux/raw/'
> +                       'raspberrypi-kernel_1.20190517-1/'
> +                       'drivers/video/logo/logo_linux_clut224.ppm')
> +        rpilogo_hash =3D 'fff3cc20c6030acce0953147f9baac43f44ed6b0'
> +        rpilogo_path =3D self.fetch_asset(rpilogo_url, asset_hash=3Drp=
ilogo_hash)
> +        deb_url =3D ('http://archive.raspberrypi.org/debian/'
> +                   'pool/main/r/raspberrypi-firmware/'
> +                   'raspberrypi-kernel_1.20190215-1_armhf.deb')
> +        deb_hash =3D 'cd284220b32128c5084037553db3c482426f3972'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        kernel_path =3D self.extract_from_deb(deb_path, '/boot/kernel7=
.img')
> +        dtb_path =3D self.extract_from_deb(deb_path, '/boot/bcm2709-rp=
i-2-b.dtb')
> +
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'earlycon=3Dpl011,0x3f201000 console=3D=
ttyAMA0')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        framebuffer_ready =3D 'Console: switching to colour frame buff=
er device'
> +        wait_for_console_pattern(self, framebuffer_ready)
> +        self.vm.command('human-monitor-command', command_line=3D'stop'=
)
> +        self.vm.command('human-monitor-command',
> +                        command_line=3D'screendump %s' % screendump_pa=
th)
> +        logger =3D logging.getLogger('framebuffer')
> +
> +        cpu_cores_count =3D 4
> +        match_threshold =3D 0.95
> +        screendump_bgr =3D cv2.imread(screendump_path, cv2.IMREAD_COLO=
R)
> +        rpilogo_bgr =3D cv2.imread(rpilogo_path, cv2.IMREAD_COLOR)
> +        result =3D cv2.matchTemplate(screendump_bgr, rpilogo_bgr,
> +                                   cv2.TM_CCOEFF_NORMED)
> +        loc =3D np.where(result >=3D match_threshold)
> +        rpilogo_count =3D 0
> +        for rpilogo_count, pt in enumerate(zip(*loc[::-1]), start=3D1)=
:
> +            logger.debug('found raspberry at position (x, y) =3D %s', =
pt)
> +        self.assertGreaterEqual(rpilogo_count, cpu_cores_count)
> +
>      def test_arm_exynos4210_initrd(self):
>          """
>          :avocado: tags=3Darch:arm
>=20

