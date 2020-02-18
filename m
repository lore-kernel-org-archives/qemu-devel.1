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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074E3C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB97D22B48
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2+RzFWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB97D22B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48Jx-0002hY-GX
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:14:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j48GP-0005Rc-PZ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:10:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j48GG-0002U8-Bw
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:10:29 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:41928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j48GB-0002PD-QA; Tue, 18 Feb 2020 14:10:21 -0500
Received: by mail-oi1-x22b.google.com with SMTP id i1so21205081oie.8;
 Tue, 18 Feb 2020 11:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=63/TYXyuH49zdBJxSV2OnqwII3VYC3F9LoBXpWXaLVU=;
 b=N2+RzFWBvZrEzXlCY1XvfHth02QIQGVe6anH1E0xJtwsEp1UfE1z1bY6IzLj5U6jVg
 lWMSDz7yHZSsbz6aICHztVEeseK5hour/SaQ6xYxD67u7ZuwqmUNuZIZJGSJuu1oSAlO
 3LZ/XzIvN2mnIXwBHgYsa/c1AN0gfRox+mLmH0OR26awMcZxEyXLAtqAce4+8CZzvF7Y
 zL5kHdIpgQLrLj1aCQ2+guVSDhlM3DFn156xSg94pPNAPlxdwjUgGi/HVwS+V2ZwpQUs
 YVvmXD8ynWQ5ugrCPA5Rys4O16aOl7g+123TIZ2ol4ZmCPcZPdeKzm0LZRKM9fpxkckG
 PN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=63/TYXyuH49zdBJxSV2OnqwII3VYC3F9LoBXpWXaLVU=;
 b=f1iAEkERpBeRz2uTGJP1RDWQz6n9yKYCHhuGz7tSwsOskoIWsGUw3vEJzdt6UCdX+p
 yasXK+juzj0NTjoKT0fG6/jrQcJ43iS0eGwliroXu92PBEuuVxuS1hpE9pwx8QHS5HsW
 mT4bp3IQOzSHTAoUraev1LXbP9unE4nxN/7xrHYJRijwofou2jPZDFe5G9qOEalDniaD
 3oOJWfEXOjX8O4c06fjPeSic5Gw8Cy2/6WyNB/g344ALkzAhBdkJeuKvH0oHGbv2OwTa
 xpWzwUdNFY5un6zMgCXGlS0/k6L5OFQa1/mAByYHRV0sWI16ihcbT7KFqUqwy+nLtQRh
 CaeQ==
X-Gm-Message-State: APjAAAVQrOFOUcs2lDtbLB4paPKGhBsIu9PFboJXJ3LLzxYhsPGL8pfl
 TeBKYooUl9m8YzWmfuWK280vmaJhhWEadzJMV5A=
X-Google-Smtp-Source: APXvYqwekEvhFdDIWGlen0vagBjI4hFTUDis9eTsOhZksciuhhTHu4yGVNIU01sPGyp/4JKTOJH+2sc0dFowKyAJfN8=
X-Received: by 2002:aca:5248:: with SMTP id g69mr2152814oib.106.1582053018446; 
 Tue, 18 Feb 2020 11:10:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Tue, 18 Feb 2020 11:10:17 -0800 (PST)
In-Reply-To: <CAP+75-V__ACHRUWKb=U+B27Z9=FJ7_H6N_NTs=QpyDP59WK5Xw@mail.gmail.com>
References: <20200201204751.17810-1-f4bug@amsat.org>
 <CAL1e-=gLg0tDH8nKtC6W6jrooGbJ=iV=X1KXDBH--cTWOV-Jxg@mail.gmail.com>
 <CAP+75-V__ACHRUWKb=U+B27Z9=FJ7_H6N_NTs=QpyDP59WK5Xw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 18 Feb 2020 20:10:17 +0100
Message-ID: <CAL1e-=jUcLrGbMLSJhUerEUQTa1_aeJ0K6paOdaKZ5Th1=gx6A@mail.gmail.com>
Subject: Re: [PATCH] tests/acceptance: Count multiple Tux logos displayed on
 framebuffer
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002e2fb3059ede6ced"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22b
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Leon Alrae <leon.alrae@imgtec.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002e2fb3059ede6ced
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, February 18, 2020, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
wrote:

> Hi Aleksandar,
>
> On Tue, Feb 18, 2020 at 7:07 PM Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
> > On Saturday, February 1, 2020, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org>
> wrote:
> >>
> >> Add a test that verifies that each core properly displays the Tux
> >> logo on the framebuffer device.
> >>
> >> We simply follow the OpenCV "Template Matching with Multiple Objects"
> >> tutorial, replacing Lionel Messi by Tux:
> >> https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.htm=
l
> >>
> >> When OpenCV and NumPy are installed, this test can be run using:
> >>
> >>   $ avocado --show=3Dapp,framebuffer \
> >>     run -t cpu:i6400 \
> >>     tests/acceptance/machine_mips_malta.py
> >>   JOB ID     : 54f3d8efd8674f289b8aa01a87f5d70c5814544c
> >>   JOB LOG    : avocado/job-results/job-2020-02-01T20.52-54f3d8e/job.lo=
g
> >>    (1/3) tests/acceptance/machine_mips_malta.py:
> MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_1core:
> >>   framebuffer: found Tux at position (x, y) =3D (0, 0)
> >>   PASS (3.37 s)
> >>    (2/3) tests/acceptance/machine_mips_malta.py:
> MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_7cores:
> >>   framebuffer: found Tux at position (x, y) =3D (0, 0)
> >>   framebuffer: found Tux at position (x, y) =3D (88, 0)
> >>   framebuffer: found Tux at position (x, y) =3D (176, 0)
> >>   framebuffer: found Tux at position (x, y) =3D (264, 0)
> >>   framebuffer: found Tux at position (x, y) =3D (352, 0)
> >>   framebuffer: found Tux at position (x, y) =3D (440, 0)
> >>   framebuffer: found Tux at position (x, y) =3D (528, 0)
> >>   PASS (5.80 s)
> >>    (3/3) tests/acceptance/machine_mips_malta.py:
> MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_8cores:
> >>   framebuffer: found Tux at position (x, y) =3D (0, 0)
> >>   framebuffer: found Tux at position (x, y) =3D (88, 0)
> >>   framebuffer: found Tux at position (x, y) =3D (176, 0)
> >>   framebuffer: found Tux at position (x, y) =3D (264, 0)
> >>   framebuffer: found Tux at position (x, y) =3D (352, 0)
> >>   framebuffer: found Tux at position (x, y) =3D (440, 0)
> >>   framebuffer: found Tux at position (x, y) =3D (528, 0)
> >>   framebuffer: found Tux at position (x, y) =3D (616, 0)
> >>   PASS (6.67 s)
> >>   RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT
> 0 | CANCEL 0
> >>   JOB TIME   : 16.79 s
> >>
> >> If the AVOCADO_CV2_SCREENDUMP_PNG_PATH environment variable is set, th=
e
> >> test will save the screenshot with matched squares to it.
> >>
> >> Test inspired by the following post:
> >> https://www.mips.com/blog/how-to-run-smp-linux-in-qemu-on-a-
> mips64-release-6-cpu/
> >> Kernel built with the following Docker file:
> >> https://github.com/philmd/qemu-testing-blob/blob/malta_
> i6400/mips/malta/mips64el/Dockerfile
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >> The resulting match can be visualised at https://pasteboard.co/ISIj6ZA=
.
> png
> >> Generated using:
> >>
> >>   $ AVOCADO_CV2_SCREENDUMP_PNG_PATH=3D/tmp/screendump_matched.png \
> >>     avocado --show=3Dapp run -t cpu:i6400 \
> >>     tests/acceptance/machine_mips_malta.py
> >>   JOB ID     : 54f3d8efd8674f289b8aa01a87f5d70c5814544c
> >>   JOB LOG    : avocado/job-results/job-2020-02-01T20.52-54f3d8e/job.lo=
g
> >>    (1/3) tests/acceptance/machine_mips_malta.py:
> MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_1core:
> PASS (3.37 s)
> >>    (2/3) tests/acceptance/machine_mips_malta.py:
> MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_7cores:
> PASS (5.80 s)
> >>    (3/3) tests/acceptance/machine_mips_malta.py:
> MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_8cores:
> PASS (6.67 s)
> >>   RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT
> 0 | CANCEL 0
> >>   JOB TIME   : 16.79 s
> >> ---
> >
> >
> > Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > I may add this file to yet another section in MAINTAINTERS (main MIPS
> target section) (I'll do it while applying, no need to respin), since its
> importance is significant (tests MIPS' smp fearure).
>
> Hmm you mean the "MIPS TCG CPUs"? Yes why not.
>
>
Yes, I do. This test's importance far exceeds Malta support, it is a
crucial test for mips smp support. I have in my backlog improving smp
support, that unfortunatelly currently has certain limitations, but Leon's
example still works, and this test will make sure it will continue to do
so, which is of tremendous importance in my view.

Thanks again,
Aleksandar



> >
> > Once again, a gorgeous test!
>
> Thanks :)
>
> >
> > Aleksandar
> >
> >>
> >>  MAINTAINERS                            |   1 +
> >>  tests/acceptance/machine_mips_malta.py | 116 ++++++++++++++++++++++++=
+
> >>  2 files changed, 117 insertions(+)
> >>  create mode 100644 tests/acceptance/machine_mips_malta.py
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 4ceb1ad882..65a3dfb564 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -983,6 +983,7 @@ F: hw/mips/mips_malta.c
> >>  F: hw/mips/gt64xxx_pci.c
> >>  F: include/hw/southbridge/piix.h
> >>  F: tests/acceptance/linux_ssh_mips_malta.py
> >> +F: tests/acceptance/machine_mips_malta.py
> >>
> >>  Mipssim
> >>  M: Aleksandar Markovic <amarkovic@wavecomp.com>
> >> diff --git a/tests/acceptance/machine_mips_malta.py
> b/tests/acceptance/machine_mips_malta.py
> >> new file mode 100644
> >> index 0000000000..2764143d15
> >> --- /dev/null
> >> +++ b/tests/acceptance/machine_mips_malta.py
> >> @@ -0,0 +1,116 @@
> >> +# Functional tests for the MIPS Malta board
> >> +#
> >> +# Copyright (c) Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> +#
> >> +# This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> >> +# See the COPYING file in the top-level directory.
> >> +#
> >> +# SPDX-License-Identifier: GPL-2.0-or-later
> >> +
> >> +import os
> >> +import gzip
> >> +import logging
> >> +
> >> +from avocado import skipUnless
> >> +from avocado_qemu import Test
> >> +from avocado_qemu import wait_for_console_pattern
> >> +from avocado.utils import archive
> >> +
> >> +
> >> +NUMPY_AVAILABLE =3D True
> >> +try:
> >> +    import numpy as np
> >> +except ImportError:
> >> +    NUMPY_AVAILABLE =3D False
> >> +
> >> +CV2_AVAILABLE =3D True
> >> +try:
> >> +    import cv2
> >> +except ImportError:
> >> +    CV2_AVAILABLE =3D False
> >> +
> >> +
> >> +@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
> >> +@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
> >> +class MaltaMachineFramebuffer(Test):
> >> +
> >> +    timeout =3D 30
> >> +
> >> +    KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
> >> +
> >> +    def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
> >> +        """
> >> +        Boot Linux kernel and check Tux logo is displayed on the
> framebuffer.
> >> +        """
> >> +        screendump_path =3D os.path.join(self.workdir, 'screendump.pb=
m')
> >> +
> >> +        kernel_url =3D ('https://github.com/philmd/
> qemu-testing-blob/raw/'
> >> +                      'a5966ca4b5/mips/malta/mips64el/'
> >> +                      'vmlinux-4.7.0-rc1.I6400.gz')
> >> +        kernel_hash =3D '096f50c377ec5072e6a366943324622c312045f6'
> >> +        kernel_path_gz =3D self.fetch_asset(kernel_url,
> asset_hash=3Dkernel_hash)
> >> +        kernel_path =3D self.workdir + "vmlinux"
> >> +        archive.gzip_uncompress(kernel_path_gz, kernel_path)
> >> +
> >> +        tuxlogo_url =3D ('https://github.com/torvalds/linux/raw/v2.6.=
12/
> '
> >> +                       'drivers/video/logo/logo_linux_vga16.ppm')
> >> +        tuxlogo_hash =3D '3991c2ddbd1ddaecda7601f8aafbcf5b02dc86af'
> >> +        tuxlogo_path =3D self.fetch_asset(tuxlogo_url,
> asset_hash=3Dtuxlogo_hash)
> >> +
> >> +        self.vm.set_console()
> >> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> >> +                               'clocksource=3DGIC console=3Dtty0
> console=3DttyS0')
> >> +        self.vm.add_args('-kernel', kernel_path,
> >> +                         '-cpu', 'I6400',
> >> +                         '-smp', '%u' % cpu_cores_count,
> >> +                         '-vga', 'std',
> >> +                         '-append', kernel_command_line)
> >> +        self.vm.launch()
> >> +        framebuffer_ready =3D 'Console: switching to colour frame buf=
fer
> device'
> >> +        wait_for_console_pattern(self, framebuffer_ready,
> >> +                                 failure_message=3D'Kernel panic - no=
t
> syncing')
> >> +        self.vm.command('human-monitor-command', command_line=3D'stop=
')
> >> +        self.vm.command('human-monitor-command',
> >> +                        command_line=3D'screendump %s' % screendump_p=
ath)
> >> +        logger =3D logging.getLogger('framebuffer')
> >> +
> >> +        match_threshold =3D 0.95
> >> +        screendump_bgr =3D cv2.imread(screendump_path, cv2.IMREAD_COL=
OR)
> >> +        tuxlogo_bgr =3D cv2.imread(tuxlogo_path, cv2.IMREAD_COLOR)
> >> +        result =3D cv2.matchTemplate(screendump_bgr, tuxlogo_bgr,
> >> +                                   cv2.TM_CCOEFF_NORMED)
> >> +        loc =3D np.where(result >=3D match_threshold)
> >> +        tuxlogo_count =3D 0
> >> +        h, w =3D tuxlogo_bgr.shape[:2]
> >> +        debug_png =3D os.getenv('AVOCADO_CV2_SCREENDUMP_PNG_PATH')
> >> +        for tuxlogo_count, pt in enumerate(zip(*loc[::-1]), start=3D1=
):
> >> +            logger.debug('found Tux at position (x, y) =3D %s', pt)
> >> +            cv2.rectangle(screendump_bgr, pt,
> >> +                          (pt[0] + w, pt[1] + h), (0, 0, 255), 2)
> >> +        if debug_png:
> >> +            cv2.imwrite(debug_png, screendump_bgr)
> >> +        self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)
> >> +
> >> +    def test_mips_malta_i6400_framebuffer_logo_1core(self):
> >> +        """
> >> +        :avocado: tags=3Darch:mips64el
> >> +        :avocado: tags=3Dmachine:malta
> >> +        :avocado: tags=3Dcpu:i6400
> >> +        """
> >> +        self.do_test_i6400_framebuffer_logo(1)
> >> +
> >> +    def test_mips_malta_i6400_framebuffer_logo_7cores(self):
> >> +        """
> >> +        :avocado: tags=3Darch:mips64el
> >> +        :avocado: tags=3Dmachine:malta
> >> +        :avocado: tags=3Dcpu:i6400
> >> +        """
> >> +        self.do_test_i6400_framebuffer_logo(7)
> >> +
> >> +    def test_mips_malta_i6400_framebuffer_logo_8cores(self):
> >> +        """
> >> +        :avocado: tags=3Darch:mips64el
> >> +        :avocado: tags=3Dmachine:malta
> >> +        :avocado: tags=3Dcpu:i6400
> >> +        """
> >> +        self.do_test_i6400_framebuffer_logo(8)
> >> --
> >> 2.21.1
> >>
> >>
>
>

--0000000000002e2fb3059ede6ced
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, February 18, 2020, Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">Hi Aleksandar,<br>
<br>
On Tue, Feb 18, 2020 at 7:07 PM Aleksandar Markovic<br>
&lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.=
com</a>&gt; wrote:<br>
&gt; On Saturday, February 1, 2020, Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Add a test that verifies that each core properly displays the Tux<=
br>
&gt;&gt; logo on the framebuffer device.<br>
&gt;&gt;<br>
&gt;&gt; We simply follow the OpenCV &quot;Template Matching with Multiple =
Objects&quot;<br>
&gt;&gt; tutorial, replacing Lionel Messi by Tux:<br>
&gt;&gt; <a href=3D"https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_templa=
te_matching.html" target=3D"_blank">https://docs.opencv.org/4.2.0/<wbr>d4/d=
c6/tutorial_py_template_<wbr>matching.html</a><br>
&gt;&gt;<br>
&gt;&gt; When OpenCV and NumPy are installed, this test can be run using:<b=
r>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0$ avocado --show=3Dapp,framebuffer \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0run -t cpu:i6400 \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0tests/acceptance/machine_mips_<wbr>malta.py<br>
&gt;&gt;=C2=A0 =C2=A0JOB ID=C2=A0 =C2=A0 =C2=A0: 54f3d8efd8674f289b8aa01a87=
f5d7<wbr>0c5814544c<br>
&gt;&gt;=C2=A0 =C2=A0JOB LOG=C2=A0 =C2=A0 : avocado/job-results/job-2020-<w=
br>02-01T20.52-54f3d8e/job.log<br>
&gt;&gt;=C2=A0 =C2=A0 (1/3) tests/acceptance/machine_mips_<wbr>malta.py:<wb=
r>MaltaMachineFramebuffer.test_<wbr>mips_malta_i6400_framebuffer_<wbr>logo_=
1core:<br>
&gt;&gt;=C2=A0 =C2=A0framebuffer: found Tux at position (x, y) =3D (0, 0)<b=
r>
&gt;&gt;=C2=A0 =C2=A0PASS (3.37 s)<br>
&gt;&gt;=C2=A0 =C2=A0 (2/3) tests/acceptance/machine_mips_<wbr>malta.py:<wb=
r>MaltaMachineFramebuffer.test_<wbr>mips_malta_i6400_framebuffer_<wbr>logo_=
7cores:<br>
&gt;&gt;=C2=A0 =C2=A0framebuffer: found Tux at position (x, y) =3D (0, 0)<b=
r>
&gt;&gt;=C2=A0 =C2=A0framebuffer: found Tux at position (x, y) =3D (88, 0)<=
br>
&gt;&gt;=C2=A0 =C2=A0framebuffer: found Tux at position (x, y) =3D (176, 0)=
<br>
&gt;&gt;=C2=A0 =C2=A0framebuffer: found Tux at position (x, y) =3D (264, 0)=
<br>
&gt;&gt;=C2=A0 =C2=A0framebuffer: found Tux at position (x, y) =3D (352, 0)=
<br>
&gt;&gt;=C2=A0 =C2=A0framebuffer: found Tux at position (x, y) =3D (440, 0)=
<br>
&gt;&gt;=C2=A0 =C2=A0framebuffer: found Tux at position (x, y) =3D (528, 0)=
<br>
&gt;&gt;=C2=A0 =C2=A0PASS (5.80 s)<br>
&gt;&gt;=C2=A0 =C2=A0 (3/3) tests/acceptance/machine_mips_<wbr>malta.py:<wb=
r>MaltaMachineFramebuffer.test_<wbr>mips_malta_i6400_framebuffer_<wbr>logo_=
8cores:<br>
&gt;&gt;=C2=A0 =C2=A0framebuffer: found Tux at position (x, y) =3D (0, 0)<b=
r>
&gt;&gt;=C2=A0 =C2=A0framebuffer: found Tux at position (x, y) =3D (88, 0)<=
br>
&gt;&gt;=C2=A0 =C2=A0framebuffer: found Tux at position (x, y) =3D (176, 0)=
<br>
&gt;&gt;=C2=A0 =C2=A0framebuffer: found Tux at position (x, y) =3D (264, 0)=
<br>
&gt;&gt;=C2=A0 =C2=A0framebuffer: found Tux at position (x, y) =3D (352, 0)=
<br>
&gt;&gt;=C2=A0 =C2=A0framebuffer: found Tux at position (x, y) =3D (440, 0)=
<br>
&gt;&gt;=C2=A0 =C2=A0framebuffer: found Tux at position (x, y) =3D (528, 0)=
<br>
&gt;&gt;=C2=A0 =C2=A0framebuffer: found Tux at position (x, y) =3D (616, 0)=
<br>
&gt;&gt;=C2=A0 =C2=A0PASS (6.67 s)<br>
&gt;&gt;=C2=A0 =C2=A0RESULTS=C2=A0 =C2=A0 : PASS 3 | ERROR 0 | FAIL 0 | SKI=
P 0 | WARN 0 | INTERRUPT 0 | CANCEL 0<br>
&gt;&gt;=C2=A0 =C2=A0JOB TIME=C2=A0 =C2=A0: 16.79 s<br>
&gt;&gt;<br>
&gt;&gt; If the AVOCADO_CV2_SCREENDUMP_PNG_<wbr>PATH environment variable i=
s set, the<br>
&gt;&gt; test will save the screenshot with matched squares to it.<br>
&gt;&gt;<br>
&gt;&gt; Test inspired by the following post:<br>
&gt;&gt; <a href=3D"https://www.mips.com/blog/how-to-run-smp-linux-in-qemu-=
on-a-mips64-release-6-cpu/" target=3D"_blank">https://www.mips.com/blog/how=
-<wbr>to-run-smp-linux-in-qemu-on-a-<wbr>mips64-release-6-cpu/</a><br>
&gt;&gt; Kernel built with the following Docker file:<br>
&gt;&gt; <a href=3D"https://github.com/philmd/qemu-testing-blob/blob/malta_=
i6400/mips/malta/mips64el/Dockerfile" target=3D"_blank">https://github.com/=
philmd/<wbr>qemu-testing-blob/blob/malta_<wbr>i6400/mips/malta/mips64el/<wb=
r>Dockerfile</a><br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f=
4bug@amsat.org">f4bug@amsat.org</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; The resulting match can be visualised at <a href=3D"https://pasteb=
oard.co/ISIj6ZA.png" target=3D"_blank">https://pasteboard.co/ISIj6ZA.<wbr>p=
ng</a><br>
&gt;&gt; Generated using:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0$ AVOCADO_CV2_SCREENDUMP_PNG_<wbr>PATH=3D/tmp/screendu=
mp_matched.<wbr>png \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0avocado --show=3Dapp run -t cpu:i6400 \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0tests/acceptance/machine_mips_<wbr>malta.py<br>
&gt;&gt;=C2=A0 =C2=A0JOB ID=C2=A0 =C2=A0 =C2=A0: 54f3d8efd8674f289b8aa01a87=
f5d7<wbr>0c5814544c<br>
&gt;&gt;=C2=A0 =C2=A0JOB LOG=C2=A0 =C2=A0 : avocado/job-results/job-2020-<w=
br>02-01T20.52-54f3d8e/job.log<br>
&gt;&gt;=C2=A0 =C2=A0 (1/3) tests/acceptance/machine_mips_<wbr>malta.py:<wb=
r>MaltaMachineFramebuffer.test_<wbr>mips_malta_i6400_framebuffer_<wbr>logo_=
1core: PASS (3.37 s)<br>
&gt;&gt;=C2=A0 =C2=A0 (2/3) tests/acceptance/machine_mips_<wbr>malta.py:<wb=
r>MaltaMachineFramebuffer.test_<wbr>mips_malta_i6400_framebuffer_<wbr>logo_=
7cores: PASS (5.80 s)<br>
&gt;&gt;=C2=A0 =C2=A0 (3/3) tests/acceptance/machine_mips_<wbr>malta.py:<wb=
r>MaltaMachineFramebuffer.test_<wbr>mips_malta_i6400_framebuffer_<wbr>logo_=
8cores: PASS (6.67 s)<br>
&gt;&gt;=C2=A0 =C2=A0RESULTS=C2=A0 =C2=A0 : PASS 3 | ERROR 0 | FAIL 0 | SKI=
P 0 | WARN 0 | INTERRUPT 0 | CANCEL 0<br>
&gt;&gt;=C2=A0 =C2=A0JOB TIME=C2=A0 =C2=A0: 16.79 s<br>
&gt;&gt; ---<br>
&gt;<br>
&gt;<br>
&gt; Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavec=
omp.com">amarkovic@wavecomp.com</a>&gt;<br>
&gt;<br>
&gt; I may add this file to yet another section in MAINTAINTERS (main MIPS =
target section) (I&#39;ll do it while applying, no need to respin), since i=
ts importance is significant (tests MIPS&#39; smp fearure).<br>
<br>
Hmm you mean the &quot;MIPS TCG CPUs&quot;? Yes why not.<br>
<br></blockquote><div><br></div><div>Yes, I do. This test&#39;s importance =
far exceeds Malta support, it is a crucial test for mips smp support. I hav=
e in my backlog improving smp support, that unfortunatelly currently has ce=
rtain limitations, but Leon&#39;s example still works, and this test will m=
ake sure it will continue to do so, which is of tremendous importance in my=
 view.</div><div><br></div><div>Thanks again,</div><div>Aleksandar</div><di=
v><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
&gt;<br>
&gt; Once again, a gorgeous test!<br>
<br>
Thanks :)<br>
<br>
&gt;<br>
&gt; Aleksandar<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;&gt;=C2=A0 tests/acceptance/machine_mips_<wbr>malta.py | 116 ++++++++++=
+++++++++++++++<br>
&gt;&gt;=C2=A0 2 files changed, 117 insertions(+)<br>
&gt;&gt;=C2=A0 create mode 100644 tests/acceptance/machine_mips_<wbr>malta.=
py<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt;&gt; index 4ceb1ad882..65a3dfb564 100644<br>
&gt;&gt; --- a/MAINTAINERS<br>
&gt;&gt; +++ b/MAINTAINERS<br>
&gt;&gt; @@ -983,6 +983,7 @@ F: hw/mips/mips_malta.c<br>
&gt;&gt;=C2=A0 F: hw/mips/gt64xxx_pci.c<br>
&gt;&gt;=C2=A0 F: include/hw/southbridge/piix.h<br>
&gt;&gt;=C2=A0 F: tests/acceptance/linux_ssh_<wbr>mips_malta.py<br>
&gt;&gt; +F: tests/acceptance/machine_mips_<wbr>malta.py<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 Mipssim<br>
&gt;&gt;=C2=A0 M: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavec=
omp.com">amarkovic@wavecomp.com</a>&gt;<br>
&gt;&gt; diff --git a/tests/acceptance/machine_<wbr>mips_malta.py b/tests/a=
cceptance/machine_<wbr>mips_malta.py<br>
&gt;&gt; new file mode 100644<br>
&gt;&gt; index 0000000000..2764143d15<br>
&gt;&gt; --- /dev/null<br>
&gt;&gt; +++ b/tests/acceptance/machine_<wbr>mips_malta.py<br>
&gt;&gt; @@ -0,0 +1,116 @@<br>
&gt;&gt; +# Functional tests for the MIPS Malta board<br>
&gt;&gt; +#<br>
&gt;&gt; +# Copyright (c) Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto=
:f4bug@amsat.org">f4bug@amsat.org</a>&gt;<br>
&gt;&gt; +#<br>
&gt;&gt; +# This work is licensed under the terms of the GNU GPL, version 2=
 or later.<br>
&gt;&gt; +# See the COPYING file in the top-level directory.<br>
&gt;&gt; +#<br>
&gt;&gt; +# SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;&gt; +<br>
&gt;&gt; +import os<br>
&gt;&gt; +import gzip<br>
&gt;&gt; +import logging<br>
&gt;&gt; +<br>
&gt;&gt; +from avocado import skipUnless<br>
&gt;&gt; +from avocado_qemu import Test<br>
&gt;&gt; +from avocado_qemu import wait_for_console_pattern<br>
&gt;&gt; +from avocado.utils import archive<br>
&gt;&gt; +<br>
&gt;&gt; +<br>
&gt;&gt; +NUMPY_AVAILABLE =3D True<br>
&gt;&gt; +try:<br>
&gt;&gt; +=C2=A0 =C2=A0 import numpy as np<br>
&gt;&gt; +except ImportError:<br>
&gt;&gt; +=C2=A0 =C2=A0 NUMPY_AVAILABLE =3D False<br>
&gt;&gt; +<br>
&gt;&gt; +CV2_AVAILABLE =3D True<br>
&gt;&gt; +try:<br>
&gt;&gt; +=C2=A0 =C2=A0 import cv2<br>
&gt;&gt; +except ImportError:<br>
&gt;&gt; +=C2=A0 =C2=A0 CV2_AVAILABLE =3D False<br>
&gt;&gt; +<br>
&gt;&gt; +<br>
&gt;&gt; +@skipUnless(NUMPY_AVAILABLE, &#39;Python NumPy not installed&#39;=
)<br>
&gt;&gt; +@skipUnless(CV2_AVAILABLE, &#39;Python OpenCV not installed&#39;)=
<br>
&gt;&gt; +class MaltaMachineFramebuffer(Test):<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 timeout =3D 30<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 KERNEL_COMMON_COMMAND_LINE =3D &#39;printk.time=3D0=
 &#39;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 def do_test_i6400_framebuffer_<wbr>logo(self, cpu_c=
ores_count):<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Boot Linux kernel and check Tux logo =
is displayed on the framebuffer.<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 screendump_path =3D os.path.join(self=
.workdir, &#39;screendump.pbm&#39;)<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_url =3D (&#39;<a href=3D"https=
://github.com/philmd/qemu-testing-blob/raw/" target=3D"_blank">https://gith=
ub.com/philmd/<wbr>qemu-testing-blob/raw/</a>&#39;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &#39;a5966ca4b5/mips/malta/<wbr>mips64el/&#39;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &#39;vmlinux-4.7.0-rc1.I6400.gz&#39;)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_hash =3D &#39;<wbr>096f50c377e=
c5072e6a36694332462<wbr>2c312045f6&#39;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path_gz =3D self.fetch_asset(k=
ernel_url, asset_hash=3Dkernel_hash)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_path =3D self.workdir + &quot;=
vmlinux&quot;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 archive.gzip_uncompress(<wbr>kernel_p=
ath_gz, kernel_path)<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tuxlogo_url =3D (&#39;<a href=3D"http=
s://github.com/torvalds/linux/raw/v2.6.12/" target=3D"_blank">https://githu=
b.com/torvalds/<wbr>linux/raw/v2.6.12/</a>&#39;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&#39;drivers/video/logo/logo_<wbr>linux_vga16.ppm&#39;)=
<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tuxlogo_hash =3D &#39;<wbr>3991c2ddbd=
1ddaecda7601f8aafbcf<wbr>5b02dc86af&#39;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tuxlogo_path =3D self.fetch_asset(tux=
logo_url, asset_hash=3Dtuxlogo_hash)<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.set_console()<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kernel_command_line =3D (self.KERNEL_=
COMMON_COMMAND_<wbr>LINE +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;clocksource=3DGIC cons=
ole=3Dtty0 console=3DttyS0&#39;)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.add_args(&#39;-kernel&#39;, k=
ernel_path,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-cpu&#39;, &#39;I6400&#39;,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-smp&#39;, &#39;%u&#39; % cpu_cores_count,<=
br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-vga&#39;, &#39;std&#39;,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-append&#39;, kernel_command_line)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.launch()<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 framebuffer_ready =3D &#39;Console: s=
witching to colour frame buffer device&#39;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, frameb=
uffer_ready,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0failure_message=3D&#=
39;Kernel panic - not syncing&#39;)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.command(&#39;human-<wbr>monit=
or-command&#39;, command_line=3D&#39;stop&#39;)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vm.command(&#39;human-<wbr>monit=
or-command&#39;,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 command_line=3D&#39;screendump %s&#39; % screendump_pa=
th)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 logger =3D logging.getLogger(&#39;<wb=
r>framebuffer&#39;)<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 match_threshold =3D 0.95<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 screendump_bgr =3D cv2.imread(screend=
ump_path, cv2.IMREAD_COLOR)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tuxlogo_bgr =3D cv2.imread(tuxlogo_pa=
th, cv2.IMREAD_COLOR)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D cv2.matchTemplate(screendu=
mp_<wbr>bgr, tuxlogo_bgr,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cv2.TM_CCOEFF=
_NORMED)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 loc =3D np.where(result &gt;=3D match=
_threshold)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tuxlogo_count =3D 0<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 h, w =3D tuxlogo_bgr.shape[:2]<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 debug_png =3D os.getenv(&#39;AVOCADO_=
CV2_<wbr>SCREENDUMP_PNG_PATH&#39;)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for tuxlogo_count, pt in enumerate(zi=
p(*loc[::-1]), start=3D1):<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.debug(&#39;found=
 Tux at position (x, y) =3D %s&#39;, pt)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cv2.rectangle(screendum=
p_bgr, pt,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (pt[0] + w, pt[1] + h), (0, 0, 255), 2)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if debug_png:<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cv2.imwrite(debug_png, =
screendump_bgr)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertGreaterEqual(<wbr>tuxlogo_=
count, cpu_cores_count)<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 def test_mips_malta_i6400_<wbr>framebuffer_logo_1co=
re(self):<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:mips64el<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:malta<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dcpu:i6400<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_test_i6400_<wbr>framebuffer_l=
ogo(1)<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 def test_mips_malta_i6400_<wbr>framebuffer_logo_7co=
res(self):<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:mips64el<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:malta<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dcpu:i6400<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_test_i6400_<wbr>framebuffer_l=
ogo(7)<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 def test_mips_malta_i6400_<wbr>framebuffer_logo_8co=
res(self):<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Darch:mips64el<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dmachine:malta<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 :avocado: tags=3Dcpu:i6400<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.do_test_i6400_<wbr>framebuffer_l=
ogo(8)<br>
&gt;&gt; --<br>
&gt;&gt; 2.21.1<br>
&gt;&gt;<br>
&gt;&gt;<br>
<br>
</blockquote>

--0000000000002e2fb3059ede6ced--

