Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D590C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 20:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB76E2089C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 20:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB76E2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi2zb-00049B-Hn
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 16:33:39 -0400
Received: from [2001:470:142:3::10] (port=54153 helo=eggs.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hi2xk-0002te-U0
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hi2xY-00029Q-C9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:31:39 -0400
Received: from [209.132.183.28] (port=42510 helo=mx1.redhat.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hi2xY-00029I-3A
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:31:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F222D307D91E;
 Mon,  1 Jul 2019 20:09:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-124-195.rdu2.redhat.com
 [10.10.124.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF5A410018F9;
 Mon,  1 Jul 2019 20:09:10 +0000 (UTC)
Date: Mon, 1 Jul 2019 16:09:09 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Message-ID: <20190701200856.GA9225@localhost.localdomain>
References: <20190701153436.16579-1-f4bug@amsat.org>
 <20190701153436.16579-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701153436.16579-2-f4bug@amsat.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 01 Jul 2019 20:09:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/2] tests/acceptance: Add test of
 NeXTcube framebuffer using OCR
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 01, 2019 at 05:34:35PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Add a test of the NeXTcube framebuffer using the Tesseract OCR
> engine on a screenshot of the framebuffer device.
>=20
> The test is very quick:
>=20
>   $ avocado --show=3Dapp,ocr run tests/acceptance/machine_m68k_nextcube=
.py

Shouldn't we stick to "console" here?  I understand we're resorting to oc=
r
but the content, for what it's worth, should be the same as in the consol=
e
for other tests.  This allows a common expectation across tests too.

>   JOB ID     : f7d3c27976047036dc568183baf64c04863d9985
>   JOB LOG    : ~/avocado/job-results/job-2019-06-29T16.18-f7d3c27/job.l=
og
>   (1/1) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test_=
bootrom_framebuffer: |ocr:
>   ue r pun Honl'=EF=AC=82x ; 5=E2=80=98 55=E2=80=98
>   avg ncaaaaa 25 MHZ, memary jag m
>   Backplane slat =C2=ABa
>   Ethernet address a a r a r3 2
>   Memgry sackets aea canflqured far 16MB Darlly page made stMs but have=
 16MB page made stMs )nstalled
>   Memgry sackets a and 1 canflqured far 16MB Darlly page made stMs but =
have 16MB page made stMs )nstalled
>   [...]
>   Yestlnq the rpu, 5::
>   system test raneg Errar egge 51
>   Egg: cammand
>   Default pggc devlce nut fauna
>   NEXY>I
>   PASS (3.59 s)
>   RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT =
0 | CANCEL 0
>   JOB TIME   : 3.97 s
>=20
> Documentation on how to install tesseract:
>   https://github.com/tesseract-ocr/tesseract/wiki#installation
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v2:
> - test fb sizes
> - handle 2 versions of teseract
> ---
>  tests/acceptance/machine_m68k_nextcube.py | 102 ++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 tests/acceptance/machine_m68k_nextcube.py
>=20
> diff --git a/tests/acceptance/machine_m68k_nextcube.py b/tests/acceptan=
ce/machine_m68k_nextcube.py
> new file mode 100644
> index 0000000000..f8e514a058
> --- /dev/null
> +++ b/tests/acceptance/machine_m68k_nextcube.py
> @@ -0,0 +1,102 @@
> +# Functional test that boots a VM and run OCR on the framebuffer
> +#
> +# Copyright (c) Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import logging
> +import time
> +import distutils.spawn
> +
> +from avocado import skipUnless
> +from avocado_qemu import Test
> +from avocado.utils import process

Style nitpick:

from avocado_qemu import Test
from avocado import skipUnless
from avocado.utils import process

> +
> +try:
> +    from PIL import Image
> +    pil_available =3D True

Another style nitpick, but very minor issue is the use of ALL_CAPS
variables if they are at the module level.  So that would become

PIL_AVAILABLE =3D True

> +except ImportError:
> +    pil_available =3D False
> +
> +
> +def tesseract_available(expected_version):
> +    if not distutils.spawn.find_executable('tesseract'):

Just though of pointing out that there's a similar function in
avocado.utils.path, called find_command:

https://avocado-framework.readthedocs.io/en/68.0/api/utils/avocado.utils.=
html#avocado.utils.path.find_command

Feel free to pick your poison! :)

> +        return False
> +    res =3D process.run('tesseract --version')
> +    try:
> +        version =3D res.stdout_text.split()[1]
> +    except IndexError:
> +        version =3D res.stderr_text.split()[1]

Do some versions write this to stdout and others to stderr?

> +    return int(version.split('.')[0]) =3D=3D expected_version

This can raise an exception if some other sort of output is
produced.  How about:

   import re

   match =3D re.match(r'tesseract\s(\d)', res)
   if match is not None:
      # now this is guaranteed to be a digit
      if int(match.groups()[0]) =3D=3D expected_version:
         return True
   return False

> +
> +
> +class NextCubeMachine(Test):
> +
> +    timeout =3D 15
> +
> +    def check_bootrom_framebuffer(self, screenshot_path):
> +        rom_url =3D ('http://www.nextcomputers.org/NeXTfiles/Software/=
ROM_Files/'
> +                   '68040_Non-Turbo_Chipset/Rev_2.5_v66.BIN')
> +        rom_hash =3D 'b3534796abae238a0111299fc406a9349f7fee24'
> +        rom_path =3D self.fetch_asset(rom_url, asset_hash=3Drom_hash)
> +
> +        self.vm.set_machine('next-cube')
> +        self.vm.add_args('-bios', rom_path)
> +        self.vm.launch()
> +
> +        self.log.info('VM launched, waiting for display')
> +        # FIXME how to catch the 'displaysurface_create 1120x832' trac=
e-event?
> +        time.sleep(2)

There's avocado.utils.wait.wait_for() to *help* with waiting, but I'm
not sure about the trace-events.

> +
> +        self.vm.command('human-monitor-command',
> +                        command_line=3D'screendump %s' % screenshot_pa=
th)
> +
> +    @skipUnless(pil_available, 'Python PIL not installed')
> +    def test_bootrom_framebuffer_size(self):
> +        """
> +        :avocado: tags=3Darch:m68k
> +        :avocado: tags=3Dmachine:next-cube

Here we hit the syntax limitation of the Avocado tags regex again:

https://avocado-framework.readthedocs.io/en/68.0/api/core/avocado.core.ht=
ml#avocado.core.safeloader.DOCSTRING_DIRECTIVE_RE_RAW

I'll look into raising that limitation on the next release, but,
for the time being, this will need to be:

    :avocado: tags=3Dmachine:next_cube

The same applies to the other tests, of course.

> +        :avocado: tags=3Ddevice:framebuffer
> +        """
> +        screenshot_path =3D self.workdir + "dump"

Best practice is to use os.path.join() instead.

> +        self.check_bootrom_framebuffer(screenshot_path)
> +
> +        width, height =3D Image.open(screenshot_path).size
> +        self.assertEqual(width, 1120)
> +        self.assertEqual(height, 832)
> +
> +    @skipUnless(tesseract_available(3), 'tesseract v3 OCR tool not ava=
ilable')
> +    def test_bootrom_framebuffer_ocr_with_tesseract_v3(self):
> +        """
> +        :avocado: tags=3Darch:m68k
> +        :avocado: tags=3Dmachine:next-cube
> +        :avocado: tags=3Ddevice:framebuffer
> +        """
> +        screenshot_path =3D self.workdir + "dump"
> +        self.check_bootrom_framebuffer(screenshot_path)
> +
> +        console_logger =3D logging.getLogger('ocr')
> +        text =3D process.run("tesseract %s stdout" % screenshot_path).=
stdout_text
> +        console_logger.debug(text)
> +        self.assertIn('Backplane', text)
> +        self.assertIn('Ethernet address', text)

I haven't tried v3, but I'm curious... is this about the change in
command line syntax only?  Or do v3 and v4 are able to recognize
different characters?

- Cleber.

> +
> +    @skipUnless(tesseract_available(4), 'tesseract v4 OCR tool not ava=
ilable')
> +    def test_bootrom_framebuffer_ocr_with_tesseract_v4(self):
> +        """
> +        :avocado: tags=3Darch:m68k
> +        :avocado: tags=3Dmachine:next-cube
> +        :avocado: tags=3Ddevice:framebuffer
> +        """
> +        screenshot_path =3D self.workdir + "dump"
> +        self.check_bootrom_framebuffer(screenshot_path)
> +
> +        console_logger =3D logging.getLogger('ocr')
> +        proc =3D process.run("tesseract --oem 1 %s stdout" % screensho=
t_path)
> +        text =3D proc.stdout_text
> +        console_logger.debug(text)
> +        self.assertIn('Testing the FPU, SCC', text)
> +        self.assertIn('System test failed. Error code 51', text)
> +        self.assertIn('Boot command', text)
> +        self.assertIn('Next>', text)
> --=20
> 2.19.1
>=20

