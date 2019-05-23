Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2D1C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0590720863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0590720863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37231 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToXS-0005JU-8l
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:17:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1hToNc-0002wp-4g
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:07:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1hToNP-0000Ri-FW
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:07:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>)
	id 1hToNJ-0000Iu-DR; Thu, 23 May 2019 10:07:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62AB8C05B038;
	Thu, 23 May 2019 14:07:10 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5744C68409;
	Thu, 23 May 2019 14:07:10 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
	(zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id 421375B423;
	Thu, 23 May 2019 14:07:10 +0000 (UTC)
Date: Thu, 23 May 2019 10:07:07 -0400 (EDT)
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Message-ID: <1573198914.24360394.1558620427447.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190520220635.10961-3-f4bug@amsat.org>
References: <20190520220635.10961-1-f4bug@amsat.org>
	<20190520220635.10961-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.36.116.137, 10.4.195.26]
Thread-Topic: BootLinuxConsoleTest: Test the SmartFusion2 board
Thread-Index: yuk6Th97nzYGOlrw3F6Jx+DGToPwDw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 23 May 2019 14:07:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
	Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm@nongnu.org,
	Caio Carrara <ccarrara@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
> To: qemu-devel@nongnu.org
> Cc: "Eduardo Habkost" <ehabkost@redhat.com>, "Caio Carrara" <ccarrara@red=
hat.com>, "Alistair Francis"
> <alistair@alistair23.me>, "Subbaraya Sundeep" <sundeep.lkml@gmail.com>, q=
emu-arm@nongnu.org, "Cleber Rosa"
> <crosa@redhat.com>, "Peter Maydell" <peter.maydell@linaro.org>, "Philippe=
 Mathieu-Daud=C3=A9" <f4bug@amsat.org>
> Sent: Monday, May 20, 2019 6:06:35 PM
> Subject: [PATCH 2/2] BootLinuxConsoleTest: Test the SmartFusion2 board
>=20
> Similar to the x86_64/pc test, it boots a Linux kernel on an
> Emcraft board and verify the serial is working.
>=20
> If ARM is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:arm" tags.
>=20
> Alternatively, this test can be run using:
>=20
>   $ avocado run -t arch:arm tests/acceptance
>   $ avocado run -t machine:emcraft-sf2 tests/acceptance
>=20
> Based on the recommended test setup from Subbaraya Sundeep:
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03810.html
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 27 ++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py
> b/tests/acceptance/boot_linux_console.py
> index f593f3858e..844cb80bb5 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -178,6 +178,33 @@ class BootLinuxConsole(Test):
>          console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
>          self.wait_for_console_pattern(console_pattern)
> =20
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

The kernel_command_line variable is not needed...

> +        self.vm.add_args('-kernel', uboot_path,
> +                         '-append', kernel_command_line,

... and you can just use self.KERNEL_COMMON_COMMAND_LINE here.

> +                         '-drive', 'file=3D' + spi_path +
> ',if=3Dmtd,format=3Draw',

Nitpick: it's more Pythonic to format strings than to concatenate
them.

> +                         '-no-reboot')
> +        self.vm.launch()
> +        self.wait_for_console_pattern('init started: BusyBox')

Another nitpick is, given that image is pinned down, maybe attempt to
match against the entire line?

  init started: BusyBox v1.24.1 (2017-05-15 09:57:00 IST)

> +
>      def test_s390x_s390_ccw_virtio(self):
>          """
>          :avocado: tags=3Darch:s390x
> --
> 2.19.1
>=20
>=20

Because of the other discussions about tests and timeouts, this is
what I get on a first run (having to download the images):

 (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_emc=
raft_sf2: PASS (27.49 s)

And then, a pretty consistent < 8s mark using the resources from
cache:

 (01/10) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_e=
mcraft_sf2: PASS (7.55 s)
 (02/10) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_e=
mcraft_sf2: PASS (7.35 s)
 (03/10) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_e=
mcraft_sf2: PASS (7.40 s)
 (04/10) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_e=
mcraft_sf2: PASS (7.60 s)
 (05/10) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_e=
mcraft_sf2: PASS (7.62 s)
 (06/10) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_e=
mcraft_sf2: PASS (7.33 s)
 (07/10) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_e=
mcraft_sf2: PASS (7.35 s)
 (08/10) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_e=
mcraft_sf2: PASS (6.38 s)
 (09/10) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_e=
mcraft_sf2: PASS (7.39 s)
 (10/10) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_e=
mcraft_sf2: PASS (7.44 s)

It'd be nice to know the average test execution time on real/typical
hardware, and with that, starting to adjust expected timeouts.  Anyway:

Tested-by: Cleber Rosa <crosa@redhat.com>

