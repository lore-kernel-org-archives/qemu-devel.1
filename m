Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C23C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C446206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C446206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIHXO-0005aZ-IX
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 15:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iIE7U-000252-Uw
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iIE7T-0000rZ-N7
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:43:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48298)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1iIE7Q-0000qV-Oc; Wed, 09 Oct 2019 11:43:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 59DC42A09A1;
 Wed,  9 Oct 2019 15:43:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-151.rdu2.redhat.com
 [10.10.122.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFD8F5D9E2;
 Wed,  9 Oct 2019 15:43:05 +0000 (UTC)
Date: Wed, 9 Oct 2019 11:43:04 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 16/19] tests/boot_linux_console: Add a test for the
 Raspberry Pi 2
Message-ID: <20191009154304.GC30349@localhost.localdomain>
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-17-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190926173428.10713-17-f4bug@amsat.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 09 Oct 2019 15:43:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 =?iso-8859-1?Q?Zolt=E1n?= Baldaszti <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cheng Xiang <ext-cheng.xiang@here.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 26, 2019 at 07:34:24PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Similar to the x86_64/pc test, it boots a Linux kernel on a raspi2
> board and verify the serial is working.
>=20
> The kernel image and DeviceTree blob are built by the Raspbian
> project (based on Debian):
> https://www.raspbian.org/RaspbianImages
> as recommended by the Raspberry Pi project:
> https://www.raspberrypi.org/downloads/raspbian/
>=20
> If ARM is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:arm" tags.
>=20
> Alternatively, this test can be run using:
>=20
>     $ avocado run -t arch:arm tests/acceptance
>     $ avocado run -t machine:raspi2 tests/acceptance
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> v3: removed debug printf (Cleber)
>     use serial_kernel_cmdline dict
> ---
>  tests/acceptance/boot_linux_console.py | 36 ++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index 079590f0c8..7eaf6cb60e 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -318,6 +318,42 @@ class BootLinuxConsole(Test):
>          self.vm.launch()
>          self.wait_for_console_pattern('init started: BusyBox')
> =20
> +    def do_test_arm_raspi2(self, uart_id):
> +        """
> +        The kernel can be rebuilt using the kernel source referenced
> +        and following the instructions on the on:
> +        https://www.raspberrypi.org/documentation/linux/kernel/buildin=
g.md
> +        """
> +        serial_kernel_cmdline =3D {
> +            0: 'earlycon=3Dpl011,0x3f201000 console=3DttyAMA0',
> +        }
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
> +        self.vm.set_machine('raspi2')
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               serial_kernel_cmdline[uart_id])
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        console_pattern =3D 'Kernel command line: %s' % kernel_command=
_line
> +        self.wait_for_console_pattern(console_pattern)
> +
> +    def test_arm_raspi2_uart0(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:raspi2
> +        :avocado: tags=3Ddevice:pl011
> +        """
> +        self.do_test_arm_raspi2(0)
> +
>      def test_s390x_s390_ccw_virtio(self):
>          """
>          :avocado: tags=3Darch:s390x
> --=20
> 2.20.1
>=20

Reviewed-by: Cleber Rosa <crosa@redhat.com>

