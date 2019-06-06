Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8836DC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 23:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CCA820717
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 23:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCA820717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44880 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ1cX-0000k4-7S
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 19:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42451)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hZ1ZV-0007D6-Ci
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hZ1ZU-0000A4-1R
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:13:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1hZ1ZR-0008M4-1U; Thu, 06 Jun 2019 19:13:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AB13F2F8BCF;
 Thu,  6 Jun 2019 23:13:17 +0000 (UTC)
Received: from dhcp-17-47.bos.redhat.com (dhcp-17-47.bos.redhat.com
 [10.18.17.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD7754DC4F;
 Thu,  6 Jun 2019 23:13:13 +0000 (UTC)
Date: Thu, 6 Jun 2019 19:13:11 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190606231311.GA28186@dhcp-17-47.bos.redhat.com>
References: <20190606225521.9187-1-philmd@redhat.com>
 <20190606225521.9187-3-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190606225521.9187-3-philmd@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 06 Jun 2019 23:13:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/2] BootLinuxConsoleTest: Test the
 SmartFusion2 board
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 07, 2019 at 12:55:21AM +0200, Philippe Mathieu-Daud=E9 wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
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
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Tested-by: Cleber Rosa <crosa@redhat.com>
> ---
> v2: (Cleber)
> - drop 'kernel_command_line'
> - do no concat string, use format
> - replace '-' by '_' in Avocado tags
> ---
>  tests/acceptance/boot_linux_console.py | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index f593f3858e..34527d4b38 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -178,6 +178,32 @@ class BootLinuxConsole(Test):
>          console_pattern =3D 'Kernel command line: %s' % kernel_command=
_line
>          self.wait_for_console_pattern(console_pattern)
> =20
> +    def test_arm_emcraft_sf2(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:emcraft_sf2
> +        :avocado: tags=3Dendian:little
> +        """
> +        uboot_url =3D ('https://raw.githubusercontent.com/'
> +                     'Subbaraya-Sundeep/qemu-test-binaries/'
> +                     'fa030bd77a014a0b8e360d3b7011df89283a2f0b/u-boot'=
)
> +        uboot_hash =3D 'abba5d9c24cdd2d49cdc2a8aa92976cf20737eff'
> +        uboot_path =3D self.fetch_asset(uboot_url, asset_hash=3Duboot_=
hash)
> +        spi_url =3D ('https://raw.githubusercontent.com/'
> +                   'Subbaraya-Sundeep/qemu-test-binaries/'
> +                   'fa030bd77a014a0b8e360d3b7011df89283a2f0b/spi.bin')
> +        spi_hash =3D '85f698329d38de63aea6e884a86fbde70890a78a'
> +        spi_path =3D self.fetch_asset(spi_url, asset_hash=3Dspi_hash)
> +
> +        self.vm.set_machine('emcraft-sf2')
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', uboot_path,
> +                         '-append', self.KERNEL_COMMON_COMMAND_LINE,
> +                         '-drive', 'file=3D%s,if=3Dmtd,format=3Draw' %=
 spi_path,
> +                         '-no-reboot')
> +        self.vm.launch()
> +        self.wait_for_console_pattern('init started: BusyBox')
> +
>      def test_s390x_s390_ccw_virtio(self):
>          """
>          :avocado: tags=3Darch:s390x
> --=20
> 2.20.1
>=20

Reviewed-by: Cleber Rosa <crosa@redhat.com>

