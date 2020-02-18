Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D11C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF01208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+MDh2Q7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF01208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j47Hu-0003e4-84
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 13:08:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j47HA-00034h-Ac
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:07:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j47H7-0002Ds-Lc
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:07:16 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:36213)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j47H7-0002CN-D7; Tue, 18 Feb 2020 13:07:13 -0500
Received: by mail-ot1-x335.google.com with SMTP id j20so20442905otq.3;
 Tue, 18 Feb 2020 10:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=n2/ege6Oo1UKNTgt3Vp26wt/vDv3CQ2jEMi1t5+S/pY=;
 b=q+MDh2Q7wcoi/aeumzzLsWdFgEZrXnwbVFYGkor5x3SGdbnpuSmj5rbPMDOi9G3Dhg
 tcwdA3qG+uyGZFp6znLXItfrjhjBVY2JJk9BtdbpHZK29HmbqCifXi1jxs5yMyJVuObt
 usVCoitx8MYBp6q+Y7ec2CC9RwcaoHe+MTgGZEqFNnq2iQMbtKF2qktwsKG9WvPNNrcU
 89ZUiI+zPlQ/dB7WzFd2nUMG9V4rSSUZpaMFVP89pjXB7582jDUKU6BggjmQFiFV9EFN
 9chY8TSn7BVZX0r+/4aIXsqL7JtHCSRy25O/MhbVh178w6dqctXBXSc1CVbKwrg8SGYB
 ZkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=n2/ege6Oo1UKNTgt3Vp26wt/vDv3CQ2jEMi1t5+S/pY=;
 b=JreA5/ghot5gH3IshJQX8QAYTqaOLs1ddOPN+A52llqwGkCSW+/IfHXjVTSN5EW0Bc
 Q4FV1aY80DGp63/a1ZDw1URjv45lh8AuMzokjfo4YH/0IoLbI0WgLZFVw1FNv3r0OzaK
 NftGJm2HdVx2wn2E99qTpJX5ciu5O97NU/9/lF1B9P7ETnDElPM/GhzY0WzYVysYE+xd
 cd4OHCAOc+53TsCJ7ogD6UN9fZqQL32QasLhV6tpSbf7s36rZBvBVnfF5dcSr9vV94JZ
 PC3GLTyV45O8k4yp/Rwqa64G6DmhGtXW2s4XIIrnR3zUPbsrVWuwP/gGrY9AUK5f0u/5
 CnIw==
X-Gm-Message-State: APjAAAXwILIaMXsDdB7xf1l8qScDWvD34Q4NPtqI+tz765Jv59iej/7L
 HtPEaPvsJSQuIZ/pcKpkD1xAMKr5LEKrlh6z32s=
X-Google-Smtp-Source: APXvYqy01voiw20aqPye8OGXqev4B0sG4jUjCr14+08WJThIpuN+7FQDVPLR6r8dFpx86sipqt1PesSm6uNgn5/5HDM=
X-Received: by 2002:a9d:2184:: with SMTP id s4mr15710187otb.121.1582049232447; 
 Tue, 18 Feb 2020 10:07:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Tue, 18 Feb 2020 10:07:12 -0800 (PST)
In-Reply-To: <20200201204751.17810-1-f4bug@amsat.org>
References: <20200201204751.17810-1-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 18 Feb 2020 19:07:12 +0100
Message-ID: <CAL1e-=gLg0tDH8nKtC6W6jrooGbJ=iV=X1KXDBH--cTWOV-Jxg@mail.gmail.com>
Subject: Re: [PATCH] tests/acceptance: Count multiple Tux logos displayed on
 framebuffer
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000846d47059edd8a0f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Leon Alrae <leon.alrae@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000846d47059edd8a0f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Saturday, February 1, 2020, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> Add a test that verifies that each core properly displays the Tux
> logo on the framebuffer device.
>
> We simply follow the OpenCV "Template Matching with Multiple Objects"
> tutorial, replacing Lionel Messi by Tux:
> https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.html
>
> When OpenCV and NumPy are installed, this test can be run using:
>
>   $ avocado --show=3Dapp,framebuffer \
>     run -t cpu:i6400 \
>     tests/acceptance/machine_mips_malta.py
>   JOB ID     : 54f3d8efd8674f289b8aa01a87f5d70c5814544c
>   JOB LOG    : avocado/job-results/job-2020-02-01T20.52-54f3d8e/job.log
>    (1/3) tests/acceptance/machine_mips_malta.py:
> MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_1core:
>   framebuffer: found Tux at position (x, y) =3D (0, 0)
>   PASS (3.37 s)
>    (2/3) tests/acceptance/machine_mips_malta.py:
> MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_7cores:
>   framebuffer: found Tux at position (x, y) =3D (0, 0)
>   framebuffer: found Tux at position (x, y) =3D (88, 0)
>   framebuffer: found Tux at position (x, y) =3D (176, 0)
>   framebuffer: found Tux at position (x, y) =3D (264, 0)
>   framebuffer: found Tux at position (x, y) =3D (352, 0)
>   framebuffer: found Tux at position (x, y) =3D (440, 0)
>   framebuffer: found Tux at position (x, y) =3D (528, 0)
>   PASS (5.80 s)
>    (3/3) tests/acceptance/machine_mips_malta.py:
> MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_8cores:
>   framebuffer: found Tux at position (x, y) =3D (0, 0)
>   framebuffer: found Tux at position (x, y) =3D (88, 0)
>   framebuffer: found Tux at position (x, y) =3D (176, 0)
>   framebuffer: found Tux at position (x, y) =3D (264, 0)
>   framebuffer: found Tux at position (x, y) =3D (352, 0)
>   framebuffer: found Tux at position (x, y) =3D (440, 0)
>   framebuffer: found Tux at position (x, y) =3D (528, 0)
>   framebuffer: found Tux at position (x, y) =3D (616, 0)
>   PASS (6.67 s)
>   RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 =
|
> CANCEL 0
>   JOB TIME   : 16.79 s
>
> If the AVOCADO_CV2_SCREENDUMP_PNG_PATH environment variable is set, the
> test will save the screenshot with matched squares to it.
>
> Test inspired by the following post:
> https://www.mips.com/blog/how-to-run-smp-linux-in-qemu-on-a-
> mips64-release-6-cpu/
> Kernel built with the following Docker file:
> https://github.com/philmd/qemu-testing-blob/blob/malta_
> i6400/mips/malta/mips64el/Dockerfile
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> The resulting match can be visualised at https://pasteboard.co/ISIj6ZA.pn=
g
> Generated using:
>
>   $ AVOCADO_CV2_SCREENDUMP_PNG_PATH=3D/tmp/screendump_matched.png \
>     avocado --show=3Dapp run -t cpu:i6400 \
>     tests/acceptance/machine_mips_malta.py
>   JOB ID     : 54f3d8efd8674f289b8aa01a87f5d70c5814544c
>   JOB LOG    : avocado/job-results/job-2020-02-01T20.52-54f3d8e/job.log
>    (1/3) tests/acceptance/machine_mips_malta.py:
> MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_1core:
> PASS (3.37 s)
>    (2/3) tests/acceptance/machine_mips_malta.py:
> MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_7cores:
> PASS (5.80 s)
>    (3/3) tests/acceptance/machine_mips_malta.py:
> MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_8cores:
> PASS (6.67 s)
>   RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 =
|
> CANCEL 0
>   JOB TIME   : 16.79 s
> ---


Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

I may add this file to yet another section in MAINTAINTERS (main MIPS
target section) (I'll do it while applying, no need to respin), since its
importance is significant (tests MIPS' smp fearure).

Once again, a gorgeous test!

Aleksandar


>  MAINTAINERS                            |   1 +
>  tests/acceptance/machine_mips_malta.py | 116 +++++++++++++++++++++++++
>  2 files changed, 117 insertions(+)
>  create mode 100644 tests/acceptance/machine_mips_malta.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ceb1ad882..65a3dfb564 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -983,6 +983,7 @@ F: hw/mips/mips_malta.c
>  F: hw/mips/gt64xxx_pci.c
>  F: include/hw/southbridge/piix.h
>  F: tests/acceptance/linux_ssh_mips_malta.py
> +F: tests/acceptance/machine_mips_malta.py
>
>  Mipssim
>  M: Aleksandar Markovic <amarkovic@wavecomp.com>
> diff --git a/tests/acceptance/machine_mips_malta.py
> b/tests/acceptance/machine_mips_malta.py
> new file mode 100644
> index 0000000000..2764143d15
> --- /dev/null
> +++ b/tests/acceptance/machine_mips_malta.py
> @@ -0,0 +1,116 @@
> +# Functional tests for the MIPS Malta board
> +#
> +# Copyright (c) Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> +# See the COPYING file in the top-level directory.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +import gzip
> +import logging
> +
> +from avocado import skipUnless
> +from avocado_qemu import Test
> +from avocado_qemu import wait_for_console_pattern
> +from avocado.utils import archive
> +
> +
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
> +@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
> +@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
> +class MaltaMachineFramebuffer(Test):
> +
> +    timeout =3D 30
> +
> +    KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
> +
> +    def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
> +        """
> +        Boot Linux kernel and check Tux logo is displayed on the
> framebuffer.
> +        """
> +        screendump_path =3D os.path.join(self.workdir, 'screendump.pbm')
> +
> +        kernel_url =3D ('https://github.com/philmd/qemu-testing-blob/raw=
/'
> +                      'a5966ca4b5/mips/malta/mips64el/'
> +                      'vmlinux-4.7.0-rc1.I6400.gz')
> +        kernel_hash =3D '096f50c377ec5072e6a366943324622c312045f6'
> +        kernel_path_gz =3D self.fetch_asset(kernel_url,
> asset_hash=3Dkernel_hash)
> +        kernel_path =3D self.workdir + "vmlinux"
> +        archive.gzip_uncompress(kernel_path_gz, kernel_path)
> +
> +        tuxlogo_url =3D ('https://github.com/torvalds/linux/raw/v2.6.12/=
'
> +                       'drivers/video/logo/logo_linux_vga16.ppm')
> +        tuxlogo_hash =3D '3991c2ddbd1ddaecda7601f8aafbcf5b02dc86af'
> +        tuxlogo_path =3D self.fetch_asset(tuxlogo_url,
> asset_hash=3Dtuxlogo_hash)
> +
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'clocksource=3DGIC console=3Dtty0
> console=3DttyS0')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-cpu', 'I6400',
> +                         '-smp', '%u' % cpu_cores_count,
> +                         '-vga', 'std',
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        framebuffer_ready =3D 'Console: switching to colour frame buffer
> device'
> +        wait_for_console_pattern(self, framebuffer_ready,
> +                                 failure_message=3D'Kernel panic - not
> syncing')
> +        self.vm.command('human-monitor-command', command_line=3D'stop')
> +        self.vm.command('human-monitor-command',
> +                        command_line=3D'screendump %s' % screendump_path=
)
> +        logger =3D logging.getLogger('framebuffer')
> +
> +        match_threshold =3D 0.95
> +        screendump_bgr =3D cv2.imread(screendump_path, cv2.IMREAD_COLOR)
> +        tuxlogo_bgr =3D cv2.imread(tuxlogo_path, cv2.IMREAD_COLOR)
> +        result =3D cv2.matchTemplate(screendump_bgr, tuxlogo_bgr,
> +                                   cv2.TM_CCOEFF_NORMED)
> +        loc =3D np.where(result >=3D match_threshold)
> +        tuxlogo_count =3D 0
> +        h, w =3D tuxlogo_bgr.shape[:2]
> +        debug_png =3D os.getenv('AVOCADO_CV2_SCREENDUMP_PNG_PATH')
> +        for tuxlogo_count, pt in enumerate(zip(*loc[::-1]), start=3D1):
> +            logger.debug('found Tux at position (x, y) =3D %s', pt)
> +            cv2.rectangle(screendump_bgr, pt,
> +                          (pt[0] + w, pt[1] + h), (0, 0, 255), 2)
> +        if debug_png:
> +            cv2.imwrite(debug_png, screendump_bgr)
> +        self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)
> +
> +    def test_mips_malta_i6400_framebuffer_logo_1core(self):
> +        """
> +        :avocado: tags=3Darch:mips64el
> +        :avocado: tags=3Dmachine:malta
> +        :avocado: tags=3Dcpu:i6400
> +        """
> +        self.do_test_i6400_framebuffer_logo(1)
> +
> +    def test_mips_malta_i6400_framebuffer_logo_7cores(self):
> +        """
> +        :avocado: tags=3Darch:mips64el
> +        :avocado: tags=3Dmachine:malta
> +        :avocado: tags=3Dcpu:i6400
> +        """
> +        self.do_test_i6400_framebuffer_logo(7)
> +
> +    def test_mips_malta_i6400_framebuffer_logo_8cores(self):
> +        """
> +        :avocado: tags=3Darch:mips64el
> +        :avocado: tags=3Dmachine:malta
> +        :avocado: tags=3Dcpu:i6400
> +        """
> +        self.do_test_i6400_framebuffer_logo(8)
> --
> 2.21.1
>
>
>

--000000000000846d47059edd8a0f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, February 1, 2020, Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">Add a test that verifies that each core properly displ=
ays the Tux<br>
logo on the framebuffer device.<br>
<br>
We simply follow the OpenCV &quot;Template Matching with Multiple Objects&q=
uot;<br>
tutorial, replacing Lionel Messi by Tux:<br>
<a href=3D"https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matchi=
ng.html" target=3D"_blank">https://docs.opencv.org/4.2.0/<wbr>d4/dc6/tutori=
al_py_template_<wbr>matching.html</a><br>
<br>
When OpenCV and NumPy are installed, this test can be run using:<br>
<br>
=C2=A0 $ avocado --show=3Dapp,framebuffer \<br>
=C2=A0 =C2=A0 run -t cpu:i6400 \<br>
=C2=A0 =C2=A0 tests/acceptance/machine_mips_<wbr>malta.py<br>
=C2=A0 JOB ID=C2=A0 =C2=A0 =C2=A0: 54f3d8efd8674f289b8aa01a87f5d7<wbr>0c581=
4544c<br>
=C2=A0 JOB LOG=C2=A0 =C2=A0 : avocado/job-results/job-2020-<wbr>02-01T20.52=
-54f3d8e/job.log<br>
=C2=A0 =C2=A0(1/3) tests/acceptance/machine_mips_<wbr>malta.py:<wbr>MaltaMa=
chineFramebuffer.test_<wbr>mips_malta_i6400_framebuffer_<wbr>logo_1core:<br=
>
=C2=A0 framebuffer: found Tux at position (x, y) =3D (0, 0)<br>
=C2=A0 PASS (3.37 s)<br>
=C2=A0 =C2=A0(2/3) tests/acceptance/machine_mips_<wbr>malta.py:<wbr>MaltaMa=
chineFramebuffer.test_<wbr>mips_malta_i6400_framebuffer_<wbr>logo_7cores:<b=
r>
=C2=A0 framebuffer: found Tux at position (x, y) =3D (0, 0)<br>
=C2=A0 framebuffer: found Tux at position (x, y) =3D (88, 0)<br>
=C2=A0 framebuffer: found Tux at position (x, y) =3D (176, 0)<br>
=C2=A0 framebuffer: found Tux at position (x, y) =3D (264, 0)<br>
=C2=A0 framebuffer: found Tux at position (x, y) =3D (352, 0)<br>
=C2=A0 framebuffer: found Tux at position (x, y) =3D (440, 0)<br>
=C2=A0 framebuffer: found Tux at position (x, y) =3D (528, 0)<br>
=C2=A0 PASS (5.80 s)<br>
=C2=A0 =C2=A0(3/3) tests/acceptance/machine_mips_<wbr>malta.py:<wbr>MaltaMa=
chineFramebuffer.test_<wbr>mips_malta_i6400_framebuffer_<wbr>logo_8cores:<b=
r>
=C2=A0 framebuffer: found Tux at position (x, y) =3D (0, 0)<br>
=C2=A0 framebuffer: found Tux at position (x, y) =3D (88, 0)<br>
=C2=A0 framebuffer: found Tux at position (x, y) =3D (176, 0)<br>
=C2=A0 framebuffer: found Tux at position (x, y) =3D (264, 0)<br>
=C2=A0 framebuffer: found Tux at position (x, y) =3D (352, 0)<br>
=C2=A0 framebuffer: found Tux at position (x, y) =3D (440, 0)<br>
=C2=A0 framebuffer: found Tux at position (x, y) =3D (528, 0)<br>
=C2=A0 framebuffer: found Tux at position (x, y) =3D (616, 0)<br>
=C2=A0 PASS (6.67 s)<br>
=C2=A0 RESULTS=C2=A0 =C2=A0 : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 |=
 INTERRUPT 0 | CANCEL 0<br>
=C2=A0 JOB TIME=C2=A0 =C2=A0: 16.79 s<br>
<br>
If the AVOCADO_CV2_SCREENDUMP_PNG_<wbr>PATH environment variable is set, th=
e<br>
test will save the screenshot with matched squares to it.<br>
<br>
Test inspired by the following post:<br>
<a href=3D"https://www.mips.com/blog/how-to-run-smp-linux-in-qemu-on-a-mips=
64-release-6-cpu/" target=3D"_blank">https://www.mips.com/blog/how-<wbr>to-=
run-smp-linux-in-qemu-on-a-<wbr>mips64-release-6-cpu/</a><br>
Kernel built with the following Docker file:<br>
<a href=3D"https://github.com/philmd/qemu-testing-blob/blob/malta_i6400/mip=
s/malta/mips64el/Dockerfile" target=3D"_blank">https://github.com/philmd/<w=
br>qemu-testing-blob/blob/malta_<wbr>i6400/mips/malta/mips64el/<wbr>Dockerf=
ile</a><br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org">f4bug@amsat.org</a>&gt;<br>
---<br>
The resulting match can be visualised at <a href=3D"https://pasteboard.co/I=
SIj6ZA.png" target=3D"_blank">https://pasteboard.co/ISIj6ZA.<wbr>png</a><br=
>
Generated using:<br>
<br>
=C2=A0 $ AVOCADO_CV2_SCREENDUMP_PNG_<wbr>PATH=3D/tmp/screendump_matched.<wb=
r>png \<br>
=C2=A0 =C2=A0 avocado --show=3Dapp run -t cpu:i6400 \<br>
=C2=A0 =C2=A0 tests/acceptance/machine_mips_<wbr>malta.py<br>
=C2=A0 JOB ID=C2=A0 =C2=A0 =C2=A0: 54f3d8efd8674f289b8aa01a87f5d7<wbr>0c581=
4544c<br>
=C2=A0 JOB LOG=C2=A0 =C2=A0 : avocado/job-results/job-2020-<wbr>02-01T20.52=
-54f3d8e/job.log<br>
=C2=A0 =C2=A0(1/3) tests/acceptance/machine_mips_<wbr>malta.py:<wbr>MaltaMa=
chineFramebuffer.test_<wbr>mips_malta_i6400_framebuffer_<wbr>logo_1core: PA=
SS (3.37 s)<br>
=C2=A0 =C2=A0(2/3) tests/acceptance/machine_mips_<wbr>malta.py:<wbr>MaltaMa=
chineFramebuffer.test_<wbr>mips_malta_i6400_framebuffer_<wbr>logo_7cores: P=
ASS (5.80 s)<br>
=C2=A0 =C2=A0(3/3) tests/acceptance/machine_mips_<wbr>malta.py:<wbr>MaltaMa=
chineFramebuffer.test_<wbr>mips_malta_i6400_framebuffer_<wbr>logo_8cores: P=
ASS (6.67 s)<br>
=C2=A0 RESULTS=C2=A0 =C2=A0 : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 |=
 INTERRUPT 0 | CANCEL 0<br>
=C2=A0 JOB TIME=C2=A0 =C2=A0: 16.79 s<br>
---</blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);font=
-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovic=
 &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" style=3D"font-size:14=
px;line-height:22.1200008392334px">amarkovic@wavecomp.com</a><span style=3D=
"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px">&gt;</s=
pan><br></div><div><span style=3D"color:rgb(34,34,34);font-size:14px;line-h=
eight:22.1200008392334px"><br></span></div><div><span style=3D"color:rgb(34=
,34,34);font-size:14px;line-height:22.1200008392334px">I may add this file =
to yet another section in MAINTAINTERS (main MIPS target section) (I&#39;ll=
 do it while applying, no need to respin), since its importance is signific=
ant (tests MIPS&#39; smp fearure).</span></div><div><span style=3D"color:rg=
b(34,34,34);font-size:14px;line-height:22.1200008392334px"><br></span></div=
><div><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200=
008392334px">Once again, a gorgeous test!</span></div><div><span style=3D"c=
olor:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px"><br></spa=
n></div><div><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:=
22.1200008392334px">Aleksandar</span></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0tests/acceptance/machine_mips_<wbr>malta.py | 116 +++++++++++++++++++=
++++++<br>
=C2=A02 files changed, 117 insertions(+)<br>
=C2=A0create mode 100644 tests/acceptance/machine_mips_<wbr>malta.py<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 4ceb1ad882..65a3dfb564 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -983,6 +983,7 @@ F: hw/mips/mips_malta.c<br>
=C2=A0F: hw/mips/gt64xxx_pci.c<br>
=C2=A0F: include/hw/southbridge/piix.h<br>
=C2=A0F: tests/acceptance/linux_ssh_<wbr>mips_malta.py<br>
+F: tests/acceptance/machine_mips_<wbr>malta.py<br>
<br>
=C2=A0Mipssim<br>
=C2=A0M: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.com">=
amarkovic@wavecomp.com</a>&gt;<br>
diff --git a/tests/acceptance/machine_<wbr>mips_malta.py b/tests/acceptance=
/machine_<wbr>mips_malta.py<br>
new file mode 100644<br>
index 0000000000..2764143d15<br>
--- /dev/null<br>
+++ b/tests/acceptance/machine_<wbr>mips_malta.py<br>
@@ -0,0 +1,116 @@<br>
+# Functional tests for the MIPS Malta board<br>
+#<br>
+# Copyright (c) Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@am=
sat.org">f4bug@amsat.org</a>&gt;<br>
+#<br>
+# This work is licensed under the terms of the GNU GPL, version 2 or later=
.<br>
+# See the COPYING file in the top-level directory.<br>
+#<br>
+# SPDX-License-Identifier: GPL-2.0-or-later<br>
+<br>
+import os<br>
+import gzip<br>
+import logging<br>
+<br>
+from avocado import skipUnless<br>
+from avocado_qemu import Test<br>
+from avocado_qemu import wait_for_console_pattern<br>
+from avocado.utils import archive<br>
+<br>
+<br>
+NUMPY_AVAILABLE =3D True<br>
+try:<br>
+=C2=A0 =C2=A0 import numpy as np<br>
+except ImportError:<br>
+=C2=A0 =C2=A0 NUMPY_AVAILABLE =3D False<br>
+<br>
+CV2_AVAILABLE =3D True<br>
+try:<br>
+=C2=A0 =C2=A0 import cv2<br>
+except ImportError:<br>
+=C2=A0 =C2=A0 CV2_AVAILABLE =3D False<br>
+<br>
+<br>
+@skipUnless(NUMPY_AVAILABLE, &#39;Python NumPy not installed&#39;)<br>
+@skipUnless(CV2_AVAILABLE, &#39;Python OpenCV not installed&#39;)<br>
+class MaltaMachineFramebuffer(Test):<br>
+<br>
+=C2=A0 =C2=A0 timeout =3D 30<br>
+<br>
+=C2=A0 =C2=A0 KERNEL_COMMON_COMMAND_LINE =3D &#39;printk.time=3D0 &#39;<br=
>
+<br>
+=C2=A0 =C2=A0 def do_test_i6400_framebuffer_<wbr>logo(self, cpu_cores_coun=
t):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Boot Linux kernel and check Tux logo is displa=
yed on the framebuffer.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 screendump_path =3D os.path.join(self.workdir,=
 &#39;screendump.pbm&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_url =3D (&#39;<a href=3D"https://github=
.com/philmd/qemu-testing-blob/raw/" target=3D"_blank">https://github.com/ph=
ilmd/<wbr>qemu-testing-blob/raw/</a>&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;a5966ca4b5/mips/malta/<wbr>mips64el/&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;vmlinux-4.7.0-rc1.I6400.gz&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_hash =3D &#39;<wbr>096f50c377ec5072e6a3=
6694332462<wbr>2c312045f6&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path_gz =3D self.fetch_asset(kernel_url=
, asset_hash=3Dkernel_hash)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.workdir + &quot;vmlinux&q=
uot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 archive.gzip_uncompress(<wbr>kernel_path_gz, k=
ernel_path)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tuxlogo_url =3D (&#39;<a href=3D"https://githu=
b.com/torvalds/linux/raw/v2.6.12/" target=3D"_blank">https://github.com/tor=
valds/<wbr>linux/raw/v2.6.12/</a>&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&#39;drivers/video/logo/logo_<wbr>linux_vga16.ppm&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tuxlogo_hash =3D &#39;<wbr>3991c2ddbd1ddaecda7=
601f8aafbcf<wbr>5b02dc86af&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tuxlogo_path =3D self.fetch_asset(tuxlogo_url,=
 asset_hash=3Dtuxlogo_hash)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_command_line =3D (self.KERNEL_COMMON_CO=
MMAND_<wbr>LINE +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;clocksource=3DGIC console=3Dtty0=
 console=3DttyS0&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-kernel&#39;, kernel_pat=
h,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-cpu&#39;, &#39;I6400&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-smp&#39;, &#39;%u&#39; % cpu_cores_count,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-vga&#39;, &#39;std&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;-append&#39;, kernel_command_line)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.launch()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 framebuffer_ready =3D &#39;Console: switching =
to colour frame buffer device&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, framebuffer_rea=
dy,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0failure_message=3D&#39;Kernel =
panic - not syncing&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.command(&#39;human-<wbr>monitor-comman=
d&#39;, command_line=3D&#39;stop&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.command(&#39;human-<wbr>monitor-comman=
d&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 command_line=3D&#39;screendump %s&#39; % screendump_path)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 logger =3D logging.getLogger(&#39;<wbr>framebu=
ffer&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 match_threshold =3D 0.95<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 screendump_bgr =3D cv2.imread(screendump_path,=
 cv2.IMREAD_COLOR)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tuxlogo_bgr =3D cv2.imread(tuxlogo_path, cv2.I=
MREAD_COLOR)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D cv2.matchTemplate(screendump_<wbr>b=
gr, tuxlogo_bgr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cv2.TM_CCOEFF_NORMED)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 loc =3D np.where(result &gt;=3D match_threshol=
d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tuxlogo_count =3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 h, w =3D tuxlogo_bgr.shape[:2]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 debug_png =3D os.getenv(&#39;AVOCADO_CV2_<wbr>=
SCREENDUMP_PNG_PATH&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for tuxlogo_count, pt in enumerate(zip(*loc[::=
-1]), start=3D1):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.debug(&#39;found Tux at p=
osition (x, y) =3D %s&#39;, pt)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cv2.rectangle(screendump_bgr, pt=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (pt[0] + w, pt[1] + h), (0, 0, 255), 2)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if debug_png:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cv2.imwrite(debug_png, screendum=
p_bgr)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertGreaterEqual(<wbr>tuxlogo_count, cp=
u_cores_count)<br>
+<br>
+=C2=A0 =C2=A0 def test_mips_malta_i6400_<wbr>framebuffer_logo_1core(self):=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:mips64el<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:malta<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dcpu:i6400<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_test_i6400_<wbr>framebuffer_logo(1)<br=
>
+<br>
+=C2=A0 =C2=A0 def test_mips_malta_i6400_<wbr>framebuffer_logo_7cores(self)=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:mips64el<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:malta<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dcpu:i6400<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_test_i6400_<wbr>framebuffer_logo(7)<br=
>
+<br>
+=C2=A0 =C2=A0 def test_mips_malta_i6400_<wbr>framebuffer_logo_8cores(self)=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:mips64el<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:malta<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dcpu:i6400<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_test_i6400_<wbr>framebuffer_logo(8)<br=
>
-- <br>
2.21.1<br>
<br>
<br>
</blockquote>

--000000000000846d47059edd8a0f--

