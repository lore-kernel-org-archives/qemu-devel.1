Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC78BC38BE0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DFA21556
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itV2HslW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DFA21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6KlI-0004nd-Om
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 15:55:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j6KkO-0003tj-FC
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j6KkM-0001ck-IO
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:54:36 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46345)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j6KkM-0001bq-Cb; Mon, 24 Feb 2020 15:54:34 -0500
Received: by mail-oi1-x244.google.com with SMTP id a22so10301052oid.13;
 Mon, 24 Feb 2020 12:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=u6kDiAWfwMpmHeIf/i3NbiDC0VYPRn8I91wHtx7A2/U=;
 b=itV2HslWXgAntx3FheMJz9VbTkgQ+BzzdGzSx3oVlfXnKnox233ib15Fzz/eDVRzcu
 FIhNH/StUTnG3C9ZDNWbepIEpZSbzk5mLbc1YtyGzz5+NJAflAJV11S/1k9wJcs72Hio
 6IJevbt5xwp9rXVxZiBdoHZjgsVm1ZnSXXgD5zayEjk88uN3lX8IIKWaPSFKZmb2YIVS
 1Qc+Jtus/Mu/fRfqxpeTVcTs1RuTgAs0EMlHmT6Lm+TpDg3K7K/0VgE/R/bw/qVseSOj
 cuP2j1inU4Dvp1hHIEFtp/m1wYfRWdQN3bb3MpNQKECSi/+pPXpvYrO5VnnewduX0vyd
 2FvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=u6kDiAWfwMpmHeIf/i3NbiDC0VYPRn8I91wHtx7A2/U=;
 b=ARr5ShncPSF2+YPkAY5R9Tqv8iKZYHH/3jrWR1xgKDwTYQyPuLKZsQb/W+2RYl37rg
 tL/0fJ8Ew9Pun6XKrqyArPjD861LqLaqfK9KuzJiPB7BX84LkwvHnFZwu7T/PF4T6HEp
 EliPKEHTwj1TTBsh+esjhoH/oNtL9erTiebjYsE2wpaxoULR1LkF6bHma2ryHrjzRI/V
 4kaLL9dMeUMwLEfdcHH1w7y5RYfhNG0LfpNE3OC9y+d02o8eU6T+ouIBs+SX6t8C++rs
 2FemYdmRVJcIXP4IuycAgJk+RDSvg9LxH23esiemXwH64n7bXGAeQGM4TEI3zIvFd/DC
 ZTWQ==
X-Gm-Message-State: APjAAAX0Liolxz0PosSEUIRUgjKz8DX9cf52MgD0zcKpCaT60YcKOS7n
 A59Tx4vPpnlkrNziEsLqVmXgRHHD9oaD6SsuoK/0dQ==
X-Google-Smtp-Source: APXvYqzbiLfmOOqUdlFUyjxjWGWOyQabCiLrDuYNDR4yJu+/avakGrzwq/ttc5LBFpC2/hh70+koJkXqBE2L7haa3/w=
X-Received: by 2002:aca:4ece:: with SMTP id c197mr759521oib.53.1582577673033; 
 Mon, 24 Feb 2020 12:54:33 -0800 (PST)
MIME-Version: 1.0
References: <20200201204751.17810-1-f4bug@amsat.org>
In-Reply-To: <20200201204751.17810-1-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 24 Feb 2020 21:54:22 +0100
Message-ID: <CAL1e-=jqy1bcY-bt0hFxn+X_FQ095kqa__hRMUV1Bs0FjG8SiQ@mail.gmail.com>
Subject: Re: [PATCH] tests/acceptance: Count multiple Tux logos displayed on
 framebuffer
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "open list:Stellaris" <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Leon Alrae <leon.alrae@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Feb 1, 2020 at 9:48 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Add a test that verifies that each core properly displays the Tux
> logo on the framebuffer device.
>

Philippe,

I would like to select this patch for the next MIPS queue, scheduled
in next few days.

It looks to me there are no prerequisites for this patch to be applied
on current master, but I may be wrong. Philippe, is this correct or
not (selecting the patch for the queue independently on other similar
or any other patches not yet in master)?

Thanks again!
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
>    (1/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.t=
est_mips_malta_i6400_framebuffer_logo_1core:
>   framebuffer: found Tux at position (x, y) =3D (0, 0)
>   PASS (3.37 s)
>    (2/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.t=
est_mips_malta_i6400_framebuffer_logo_7cores:
>   framebuffer: found Tux at position (x, y) =3D (0, 0)
>   framebuffer: found Tux at position (x, y) =3D (88, 0)
>   framebuffer: found Tux at position (x, y) =3D (176, 0)
>   framebuffer: found Tux at position (x, y) =3D (264, 0)
>   framebuffer: found Tux at position (x, y) =3D (352, 0)
>   framebuffer: found Tux at position (x, y) =3D (440, 0)
>   framebuffer: found Tux at position (x, y) =3D (528, 0)
>   PASS (5.80 s)
>    (3/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.t=
est_mips_malta_i6400_framebuffer_logo_8cores:
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
| CANCEL 0
>   JOB TIME   : 16.79 s
>
> If the AVOCADO_CV2_SCREENDUMP_PNG_PATH environment variable is set, the
> test will save the screenshot with matched squares to it.
>
> Test inspired by the following post:
> https://www.mips.com/blog/how-to-run-smp-linux-in-qemu-on-a-mips64-releas=
e-6-cpu/
> Kernel built with the following Docker file:
> https://github.com/philmd/qemu-testing-blob/blob/malta_i6400/mips/malta/m=
ips64el/Dockerfile
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
>    (1/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.t=
est_mips_malta_i6400_framebuffer_logo_1core: PASS (3.37 s)
>    (2/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.t=
est_mips_malta_i6400_framebuffer_logo_7cores: PASS (5.80 s)
>    (3/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.t=
est_mips_malta_i6400_framebuffer_logo_8cores: PASS (6.67 s)
>   RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 =
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
> diff --git a/tests/acceptance/machine_mips_malta.py b/tests/acceptance/ma=
chine_mips_malta.py
> new file mode 100644
> index 0000000000..2764143d15
> --- /dev/null
> +++ b/tests/acceptance/machine_mips_malta.py
> @@ -0,0 +1,116 @@
> +# Functional tests for the MIPS Malta board
> +#
> +# Copyright (c) Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
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
> +        Boot Linux kernel and check Tux logo is displayed on the framebu=
ffer.
> +        """
> +        screendump_path =3D os.path.join(self.workdir, 'screendump.pbm')
> +
> +        kernel_url =3D ('https://github.com/philmd/qemu-testing-blob/raw=
/'
> +                      'a5966ca4b5/mips/malta/mips64el/'
> +                      'vmlinux-4.7.0-rc1.I6400.gz')
> +        kernel_hash =3D '096f50c377ec5072e6a366943324622c312045f6'
> +        kernel_path_gz =3D self.fetch_asset(kernel_url, asset_hash=3Dker=
nel_hash)
> +        kernel_path =3D self.workdir + "vmlinux"
> +        archive.gzip_uncompress(kernel_path_gz, kernel_path)
> +
> +        tuxlogo_url =3D ('https://github.com/torvalds/linux/raw/v2.6.12/=
'
> +                       'drivers/video/logo/logo_linux_vga16.ppm')
> +        tuxlogo_hash =3D '3991c2ddbd1ddaecda7601f8aafbcf5b02dc86af'
> +        tuxlogo_path =3D self.fetch_asset(tuxlogo_url, asset_hash=3Dtuxl=
ogo_hash)
> +
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'clocksource=3DGIC console=3Dtty0 console=
=3DttyS0')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-cpu', 'I6400',
> +                         '-smp', '%u' % cpu_cores_count,
> +                         '-vga', 'std',
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        framebuffer_ready =3D 'Console: switching to colour frame buffer=
 device'
> +        wait_for_console_pattern(self, framebuffer_ready,
> +                                 failure_message=3D'Kernel panic - not s=
yncing')
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

