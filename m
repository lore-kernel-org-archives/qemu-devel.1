Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F9FC33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 20:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF19A2063A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 20:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwOFkTUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF19A2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixzro-0007WO-1J
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 15:59:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixzqt-0006Wv-8O
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 15:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixzqq-0007EJ-Lq
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 15:58:51 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41953)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ixzqq-0007DW-CO; Sat, 01 Feb 2020 15:58:48 -0500
Received: by mail-oi1-x244.google.com with SMTP id i1so10937993oie.8;
 Sat, 01 Feb 2020 12:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IrZ03mqBg5KXZFv4UKXS803LaDKCqnp8Fr/idoYgk2M=;
 b=CwOFkTUjVGcGniQVNiExJDSwXFQHuCm80rcuDS+Tv7zRGdpEkL6zsUKN9zn7kdwdsa
 VEtMjwmeHsNEuLx6sV4P6z3F7Y8q+/B3pIyLCyPrXKfq9k8c8w79oVBurZxAYL+q10rE
 76SRFk5WiNH4Tw0uusOEeB4dBE/in0uWrtARXgVxFFonS5o+O9UMVrh7pP8zH4RCG3W+
 9/LACglGek+Yopo7AGjtVQVpT5Hkg4AsftJjDvYey5fEoAIgWj+m2iP2AQTYhYTnAzbe
 o/ZdAdGH0hipxqfSjpG9HzYwEwhdB+MNtfUjkSrCz/NYaEUHCmR9UHyl5BNcQtZPHDoZ
 021w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IrZ03mqBg5KXZFv4UKXS803LaDKCqnp8Fr/idoYgk2M=;
 b=CTdadP2UZ+P+4O6wcQQwWU1w1nAiClqCsrsT4n+7gB3fTRkUg64A6V4kr6/xmiYio5
 dwz5Gyw8sYYvu+R7eRlwbDcd7FOJOhbZbdiU71bTdTISGEChQQjtQ/Oc7VgKeXjXeyqT
 j7EuS9nRhjSmEgqssNZtlubQbqMGo0I1DB5LUudLgtyfotKTRafAu822lNmACxX4KO7m
 7TBlKXwYlA3j5fTGTaBJOOAp081YDzpV4NWxGxl4hCCdUMB3E2W1O6VQDdim8W9xiC03
 LtB0mnYLzuONmnI/j/bkPCz3xttUoaGsJNou+x65UrBD99himAc4+tZFgImXpfSEl+8S
 JQ+g==
X-Gm-Message-State: APjAAAVQ0kwRmqQCyvCQ1/ScW6wWRuudq9qhnkR/55rxc/ENgrxwEr81
 tXUX73I8Uxf5DACBCE2D3P57lrN7MjTpdTaacqw=
X-Google-Smtp-Source: APXvYqwbHhxyRnlyeINySWrxHJjnNeGoueiQMpiV0+y7L0ZDZ88eoqP3b6Gmagc2/cy+TBRnij/9VzP2TGbY/h+bDrg=
X-Received: by 2002:aca:5248:: with SMTP id g69mr4776588oib.106.1580590727283; 
 Sat, 01 Feb 2020 12:58:47 -0800 (PST)
MIME-Version: 1.0
References: <20200201204751.17810-1-f4bug@amsat.org>
In-Reply-To: <20200201204751.17810-1-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 1 Feb 2020 21:58:28 +0100
Message-ID: <CAL1e-=iA99dGqDMy7mtGtiSv7EmXG3SoxvUr-gh-ierMoWzvcw@mail.gmail.com>
Subject: Re: [PATCH] tests/acceptance: Count multiple Tux logos displayed on
 framebuffer
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000d5c966059d89f465"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Leon Alrae <leon.alrae@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d5c966059d89f465
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

21:48 Sub, 01.02.2020. Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=
=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Add a test that verifies that each core properly displays the Tux
> logo on the framebuffer device.
>

Excellent test!

Glad that Leon blog post was the inspiration. I'll email him about this, if
I find his address, one of my colegues might have it.

I don't have dev setup at hand, is 8 cores limit? I think it is. If not,
perhaps you can push the limit with 16 tuxes.

THANK YOU, PHILIPPE!

Aleksandar

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
>    (1/3)
tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_ma=
lta_i6400_framebuffer_logo_1core:
>   framebuffer: found Tux at position (x, y) =3D (0, 0)
>   PASS (3.37 s)
>    (2/3)
tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_ma=
lta_i6400_framebuffer_logo_7cores:
>   framebuffer: found Tux at position (x, y) =3D (0, 0)
>   framebuffer: found Tux at position (x, y) =3D (88, 0)
>   framebuffer: found Tux at position (x, y) =3D (176, 0)
>   framebuffer: found Tux at position (x, y) =3D (264, 0)
>   framebuffer: found Tux at position (x, y) =3D (352, 0)
>   framebuffer: found Tux at position (x, y) =3D (440, 0)
>   framebuffer: found Tux at position (x, y) =3D (528, 0)
>   PASS (5.80 s)
>    (3/3)
tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_ma=
lta_i6400_framebuffer_logo_8cores:
>   framebuffer: found Tux at position (x, y) =3D (0, 0)
>   framebuffer: found Tux at position (x, y) =3D (88, 0)
>   framebuffer: found Tux at position (x, y) =3D (176, 0)
>   framebuffer: found Tux at position (x, y) =3D (264, 0)
>   framebuffer: found Tux at position (x, y) =3D (352, 0)
>   framebuffer: found Tux at position (x, y) =3D (440, 0)
>   framebuffer: found Tux at position (x, y) =3D (528, 0)
>   framebuffer: found Tux at position (x, y) =3D (616, 0)
>   PASS (6.67 s)
>   RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0
| CANCEL 0
>   JOB TIME   : 16.79 s
>
> If the AVOCADO_CV2_SCREENDUMP_PNG_PATH environment variable is set, the
> test will save the screenshot with matched squares to it.
>
> Test inspired by the following post:
>
https://www.mips.com/blog/how-to-run-smp-linux-in-qemu-on-a-mips64-release-=
6-cpu/
> Kernel built with the following Docker file:
>
https://github.com/philmd/qemu-testing-blob/blob/malta_i6400/mips/malta/mip=
s64el/Dockerfile
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
>    (1/3)
tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_ma=
lta_i6400_framebuffer_logo_1core:
PASS (3.37 s)
>    (2/3)
tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_ma=
lta_i6400_framebuffer_logo_7cores:
PASS (5.80 s)
>    (3/3)
tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_ma=
lta_i6400_framebuffer_logo_8cores:
PASS (6.67 s)
>   RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0
| CANCEL 0
>   JOB TIME   : 16.79 s
> ---
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
b/tests/acceptance/machine_mips_malta.py
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
later.
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
framebuffer.
> +        """
> +        screendump_path =3D os.path.join(self.workdir, 'screendump.pbm')
> +
> +        kernel_url =3D ('https://github.com/philmd/qemu-testing-blob/raw=
/'
> +                      'a5966ca4b5/mips/malta/mips64el/'
> +                      'vmlinux-4.7.0-rc1.I6400.gz')
> +        kernel_hash =3D '096f50c377ec5072e6a366943324622c312045f6'
> +        kernel_path_gz =3D self.fetch_asset(kernel_url,
asset_hash=3Dkernel_hash)
> +        kernel_path =3D self.workdir + "vmlinux"
> +        archive.gzip_uncompress(kernel_path_gz, kernel_path)
> +
> +        tuxlogo_url =3D ('https://github.com/torvalds/linux/raw/v2.6.12/=
'
> +                       'drivers/video/logo/logo_linux_vga16.ppm')
> +        tuxlogo_hash =3D '3991c2ddbd1ddaecda7601f8aafbcf5b02dc86af'
> +        tuxlogo_path =3D self.fetch_asset(tuxlogo_url,
asset_hash=3Dtuxlogo_hash)
> +
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'clocksource=3DGIC console=3Dtty0
console=3DttyS0')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-cpu', 'I6400',
> +                         '-smp', '%u' % cpu_cores_count,
> +                         '-vga', 'std',
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        framebuffer_ready =3D 'Console: switching to colour frame buffer
device'
> +        wait_for_console_pattern(self, framebuffer_ready,
> +                                 failure_message=3D'Kernel panic - not
syncing')
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

--000000000000d5c966059d89f465
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">21:48 Sub, 01.02.2020. Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; Add a test that verifies that each core properly displays the Tux<br>
&gt; logo on the framebuffer device.<br>
&gt;</p>
<p dir=3D"ltr">Excellent test!</p>
<p dir=3D"ltr">Glad that Leon blog post was the inspiration. I&#39;ll email=
 him about this, if I find his address, one of my colegues might have it.</=
p>
<p dir=3D"ltr">I don&#39;t have dev setup at hand, is 8 cores limit? I thin=
k it is. If not, perhaps you can push the limit with 16 tuxes.</p>
<p dir=3D"ltr">THANK YOU, PHILIPPE!</p>
<p dir=3D"ltr">Aleksandar</p>
<p dir=3D"ltr">&gt; We simply follow the OpenCV &quot;Template Matching wit=
h Multiple Objects&quot;<br>
&gt; tutorial, replacing Lionel Messi by Tux:<br>
&gt; <a href=3D"https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_m=
atching.html">https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_mat=
ching.html</a><br>
&gt;<br>
&gt; When OpenCV and NumPy are installed, this test can be run using:<br>
&gt;<br>
&gt; =C2=A0 $ avocado --show=3Dapp,framebuffer \<br>
&gt; =C2=A0 =C2=A0 run -t cpu:i6400 \<br>
&gt; =C2=A0 =C2=A0 tests/acceptance/machine_mips_malta.py<br>
&gt; =C2=A0 JOB ID=C2=A0 =C2=A0 =C2=A0: 54f3d8efd8674f289b8aa01a87f5d70c581=
4544c<br>
&gt; =C2=A0 JOB LOG=C2=A0 =C2=A0 : avocado/job-results/job-2020-02-01T20.52=
-54f3d8e/job.log<br>
&gt; =C2=A0 =C2=A0(1/3) tests/acceptance/machine_mips_malta.py:MaltaMachine=
Framebuffer.test_mips_malta_i6400_framebuffer_logo_1core:<br>
&gt; =C2=A0 framebuffer: found Tux at position (x, y) =3D (0, 0)<br>
&gt; =C2=A0 PASS (3.37 s)<br>
&gt; =C2=A0 =C2=A0(2/3) tests/acceptance/machine_mips_malta.py:MaltaMachine=
Framebuffer.test_mips_malta_i6400_framebuffer_logo_7cores:<br>
&gt; =C2=A0 framebuffer: found Tux at position (x, y) =3D (0, 0)<br>
&gt; =C2=A0 framebuffer: found Tux at position (x, y) =3D (88, 0)<br>
&gt; =C2=A0 framebuffer: found Tux at position (x, y) =3D (176, 0)<br>
&gt; =C2=A0 framebuffer: found Tux at position (x, y) =3D (264, 0)<br>
&gt; =C2=A0 framebuffer: found Tux at position (x, y) =3D (352, 0)<br>
&gt; =C2=A0 framebuffer: found Tux at position (x, y) =3D (440, 0)<br>
&gt; =C2=A0 framebuffer: found Tux at position (x, y) =3D (528, 0)<br>
&gt; =C2=A0 PASS (5.80 s)<br>
&gt; =C2=A0 =C2=A0(3/3) tests/acceptance/machine_mips_malta.py:MaltaMachine=
Framebuffer.test_mips_malta_i6400_framebuffer_logo_8cores:<br>
&gt; =C2=A0 framebuffer: found Tux at position (x, y) =3D (0, 0)<br>
&gt; =C2=A0 framebuffer: found Tux at position (x, y) =3D (88, 0)<br>
&gt; =C2=A0 framebuffer: found Tux at position (x, y) =3D (176, 0)<br>
&gt; =C2=A0 framebuffer: found Tux at position (x, y) =3D (264, 0)<br>
&gt; =C2=A0 framebuffer: found Tux at position (x, y) =3D (352, 0)<br>
&gt; =C2=A0 framebuffer: found Tux at position (x, y) =3D (440, 0)<br>
&gt; =C2=A0 framebuffer: found Tux at position (x, y) =3D (528, 0)<br>
&gt; =C2=A0 framebuffer: found Tux at position (x, y) =3D (616, 0)<br>
&gt; =C2=A0 PASS (6.67 s)<br>
&gt; =C2=A0 RESULTS=C2=A0 =C2=A0 : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WAR=
N 0 | INTERRUPT 0 | CANCEL 0<br>
&gt; =C2=A0 JOB TIME=C2=A0 =C2=A0: 16.79 s<br>
&gt;<br>
&gt; If the AVOCADO_CV2_SCREENDUMP_PNG_PATH environment variable is set, th=
e<br>
&gt; test will save the screenshot with matched squares to it.<br>
&gt;<br>
&gt; Test inspired by the following post:<br>
&gt; <a href=3D"https://www.mips.com/blog/how-to-run-smp-linux-in-qemu-on-a=
-mips64-release-6-cpu/">https://www.mips.com/blog/how-to-run-smp-linux-in-q=
emu-on-a-mips64-release-6-cpu/</a><br>
&gt; Kernel built with the following Docker file:<br>
&gt; <a href=3D"https://github.com/philmd/qemu-testing-blob/blob/malta_i640=
0/mips/malta/mips64el/Dockerfile">https://github.com/philmd/qemu-testing-bl=
ob/blob/malta_i6400/mips/malta/mips64el/Dockerfile</a><br>
&gt;<br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug=
@amsat.org">f4bug@amsat.org</a>&gt;<br>
&gt; ---<br>
&gt; The resulting match can be visualised at <a href=3D"https://pasteboard=
.co/ISIj6ZA.png">https://pasteboard.co/ISIj6ZA.png</a><br>
&gt; Generated using:<br>
&gt;<br>
&gt; =C2=A0 $ AVOCADO_CV2_SCREENDUMP_PNG_PATH=3D/tmp/screendump_matched.png=
 \<br>
&gt; =C2=A0 =C2=A0 avocado --show=3Dapp run -t cpu:i6400 \<br>
&gt; =C2=A0 =C2=A0 tests/acceptance/machine_mips_malta.py<br>
&gt; =C2=A0 JOB ID=C2=A0 =C2=A0 =C2=A0: 54f3d8efd8674f289b8aa01a87f5d70c581=
4544c<br>
&gt; =C2=A0 JOB LOG=C2=A0 =C2=A0 : avocado/job-results/job-2020-02-01T20.52=
-54f3d8e/job.log<br>
&gt; =C2=A0 =C2=A0(1/3) tests/acceptance/machine_mips_malta.py:MaltaMachine=
Framebuffer.test_mips_malta_i6400_framebuffer_logo_1core: PASS (3.37 s)<br>
&gt; =C2=A0 =C2=A0(2/3) tests/acceptance/machine_mips_malta.py:MaltaMachine=
Framebuffer.test_mips_malta_i6400_framebuffer_logo_7cores: PASS (5.80 s)<br=
>
&gt; =C2=A0 =C2=A0(3/3) tests/acceptance/machine_mips_malta.py:MaltaMachine=
Framebuffer.test_mips_malta_i6400_framebuffer_logo_8cores: PASS (6.67 s)<br=
>
&gt; =C2=A0 RESULTS=C2=A0 =C2=A0 : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WAR=
N 0 | INTERRUPT 0 | CANCEL 0<br>
&gt; =C2=A0 JOB TIME=C2=A0 =C2=A0: 16.79 s<br>
&gt; ---<br>
&gt; =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt; =C2=A0tests/acceptance/machine_mips_malta.py | 116 +++++++++++++++++++=
++++++<br>
&gt; =C2=A02 files changed, 117 insertions(+)<br>
&gt; =C2=A0create mode 100644 tests/acceptance/machine_mips_malta.py<br>
&gt;<br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index 4ceb1ad882..65a3dfb564 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -983,6 +983,7 @@ F: hw/mips/mips_malta.c<br>
&gt; =C2=A0F: hw/mips/gt64xxx_pci.c<br>
&gt; =C2=A0F: include/hw/southbridge/piix.h<br>
&gt; =C2=A0F: tests/acceptance/linux_ssh_mips_malta.py<br>
&gt; +F: tests/acceptance/machine_mips_malta.py<br>
&gt;<br>
&gt; =C2=A0Mipssim<br>
&gt; =C2=A0M: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.=
com">amarkovic@wavecomp.com</a>&gt;<br>
&gt; diff --git a/tests/acceptance/machine_mips_malta.py b/tests/acceptance=
/machine_mips_malta.py<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..2764143d15<br>
&gt; --- /dev/null<br>
&gt; +++ b/tests/acceptance/machine_mips_malta.py<br>
&gt; @@ -0,0 +1,116 @@<br>
&gt; +# Functional tests for the MIPS Malta board<br>
&gt; +#<br>
&gt; +# Copyright (c) Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4b=
ug@amsat.org">f4bug@amsat.org</a>&gt;<br>
&gt; +#<br>
&gt; +# This work is licensed under the terms of the GNU GPL, version 2 or =
later.<br>
&gt; +# See the COPYING file in the top-level directory.<br>
&gt; +#<br>
&gt; +# SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; +<br>
&gt; +import os<br>
&gt; +import gzip<br>
&gt; +import logging<br>
&gt; +<br>
&gt; +from avocado import skipUnless<br>
&gt; +from avocado_qemu import Test<br>
&gt; +from avocado_qemu import wait_for_console_pattern<br>
&gt; +from avocado.utils import archive<br>
&gt; +<br>
&gt; +<br>
&gt; +NUMPY_AVAILABLE =3D True<br>
&gt; +try:<br>
&gt; +=C2=A0 =C2=A0 import numpy as np<br>
&gt; +except ImportError:<br>
&gt; +=C2=A0 =C2=A0 NUMPY_AVAILABLE =3D False<br>
&gt; +<br>
&gt; +CV2_AVAILABLE =3D True<br>
&gt; +try:<br>
&gt; +=C2=A0 =C2=A0 import cv2<br>
&gt; +except ImportError:<br>
&gt; +=C2=A0 =C2=A0 CV2_AVAILABLE =3D False<br>
&gt; +<br>
&gt; +<br>
&gt; +@skipUnless(NUMPY_AVAILABLE, &#39;Python NumPy not installed&#39;)<br=
>
&gt; +@skipUnless(CV2_AVAILABLE, &#39;Python OpenCV not installed&#39;)<br>
&gt; +class MaltaMachineFramebuffer(Test):<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 timeout =3D 30<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 KERNEL_COMMON_COMMAND_LINE =3D &#39;printk.time=3D0 &#3=
9;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def do_test_i6400_framebuffer_logo(self, cpu_cores_coun=
t):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Boot Linux kernel and check Tux logo is d=
isplayed on the framebuffer.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 screendump_path =3D os.path.join(self.wor=
kdir, &#39;screendump.pbm&#39;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_url =3D (&#39;<a href=3D"https://g=
ithub.com/philmd/qemu-testing-blob/raw/">https://github.com/philmd/qemu-tes=
ting-blob/raw/</a>&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &#39;a5966ca4b5/mips/malta/mips64el/&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &#39;vmlinux-4.7.0-rc1.I6400.gz&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_hash =3D &#39;096f50c377ec5072e6a3=
66943324622c312045f6&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path_gz =3D self.fetch_asset(kerne=
l_url, asset_hash=3Dkernel_hash)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.workdir + &quot;vmli=
nux&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 archive.gzip_uncompress(kernel_path_gz, k=
ernel_path)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tuxlogo_url =3D (&#39;<a href=3D"https://=
github.com/torvalds/linux/raw/v2.6.12/">https://github.com/torvalds/linux/r=
aw/v2.6.12/</a>&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&#39;drivers/video/logo/logo_linux_vga16.ppm&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tuxlogo_hash =3D &#39;3991c2ddbd1ddaecda7=
601f8aafbcf5b02dc86af&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tuxlogo_path =3D self.fetch_asset(tuxlogo=
_url, asset_hash=3Dtuxlogo_hash)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_command_line =3D (self.KERNEL_COMM=
ON_COMMAND_LINE +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;clocksource=3DGIC console=3D=
tty0 console=3DttyS0&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-kernel&#39;, kerne=
l_path,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&#39;-cpu&#39;, &#39;I6400&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&#39;-smp&#39;, &#39;%u&#39; % cpu_cores_count,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&#39;-vga&#39;, &#39;std&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&#39;-append&#39;, kernel_command_line)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.launch()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 framebuffer_ready =3D &#39;Console: switc=
hing to colour frame buffer device&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, framebuffe=
r_ready,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0failure_message=3D&#39;Ker=
nel panic - not syncing&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.command(&#39;human-monitor-comman=
d&#39;, command_line=3D&#39;stop&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.command(&#39;human-monitor-comman=
d&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 command_line=3D&#39;screendump %s&#39; % screendump_path)<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 logger =3D logging.getLogger(&#39;framebu=
ffer&#39;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 match_threshold =3D 0.95<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 screendump_bgr =3D cv2.imread(screendump_=
path, cv2.IMREAD_COLOR)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tuxlogo_bgr =3D cv2.imread(tuxlogo_path, =
cv2.IMREAD_COLOR)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D cv2.matchTemplate(screendump_b=
gr, tuxlogo_bgr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cv2.TM_CCOEFF_NORME=
D)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 loc =3D np.where(result &gt;=3D match_thr=
eshold)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tuxlogo_count =3D 0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 h, w =3D tuxlogo_bgr.shape[:2]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 debug_png =3D os.getenv(&#39;AVOCADO_CV2_=
SCREENDUMP_PNG_PATH&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for tuxlogo_count, pt in enumerate(zip(*l=
oc[::-1]), start=3D1):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.debug(&#39;found Tux=
 at position (x, y) =3D %s&#39;, pt)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cv2.rectangle(screendump_bg=
r, pt,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 (pt[0] + w, pt[1] + h), (0, 0, 255), 2)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if debug_png:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cv2.imwrite(debug_png, scre=
endump_bgr)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertGreaterEqual(tuxlogo_count, cp=
u_cores_count)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def test_mips_malta_i6400_framebuffer_logo_1core(self):=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:mips64el<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:malta<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dcpu:i6400<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_test_i6400_framebuffer_logo(1)<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def test_mips_malta_i6400_framebuffer_logo_7cores(self)=
:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:mips64el<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:malta<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dcpu:i6400<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_test_i6400_framebuffer_logo(7)<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def test_mips_malta_i6400_framebuffer_logo_8cores(self)=
:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:mips64el<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:malta<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dcpu:i6400<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_test_i6400_framebuffer_logo(8)<br=
>
&gt; -- <br>
&gt; 2.21.1<br>
&gt;<br>
&gt;<br>
</p>

--000000000000d5c966059d89f465--

