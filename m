Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03D8C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 20:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 871F32467B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 20:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJr6tQR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871F32467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii23Z-0001RR-Kg
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 15:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ii22S-0000G0-1U
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:04:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ii22O-0003kJ-Sc
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:04:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43147
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ii22O-0003bc-81
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576785883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wG52N/YErgv/W3XxI1efshpcorKDZYLcaar8P0GpdYg=;
 b=iJr6tQR/TSiCm6I7gmwaxh+qFjUxw4Sh+S7PajWnd6IKMF/3LBIVv7Bm4fTKTwT0q2PWVO
 Xy0fH9z4zVnROVAvNoqcVniTdhGxDFrmZZbX+Z2GGAuX4n5c7k9/5Nf0okXlHAYa6+lzAP
 6hKn77y293W683xDkDZrEqnio26d9to=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-_BSc_oBHP0a1znd5ECemfA-1; Thu, 19 Dec 2019 15:04:39 -0500
X-MC-Unique: _BSc_oBHP0a1znd5ECemfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2B1210054E3;
 Thu, 19 Dec 2019 20:04:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-70.gru2.redhat.com
 [10.97.116.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 490505D9E2;
 Thu, 19 Dec 2019 20:04:36 +0000 (UTC)
Date: Thu, 19 Dec 2019 15:04:33 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 3/5] tests/boot_linux_console: Add a SD card test for the
 OrangePi PC board
Message-ID: <20191219200433.GA28892@localhost.localdomain>
References: <20191217182730.943-1-f4bug@amsat.org>
 <20191217182730.943-4-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20191217182730.943-4-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2019 at 07:27:28PM +0100, Philippe Mathieu-Daud=E9 wrote:
> The kernel image and DeviceTree blob are built by the Raspbian
> project (based on Debian):
> https://www.raspbian.org/RaspbianImages
>=20
> The SD image is from the kernelci.org project:
> https://kernelci.org/faq/#the-code
>=20
> If ARM is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:arm" tags.
>=20
> Alternatively, this test can be run using:
>=20
>   $ avocado --show=3Dconsole run -t machine:orangepi-pc tests/acceptance/=
boot_linux_console.py
>   console: Uncompressing Linux... done, booting the kernel.
>   console: Booting Linux on physical CPU 0x0
>   console: Linux version 4.20.7-sunxi (root@armbian.com) (gcc version 7.2=
.1 20171011 (Linaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET 2019
>   console: CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=3D50c53=
87d
>   [...]
>   console: sunxi-wdt 1c20ca0.watchdog: Watchdog enabled (timeout=3D16 sec=
, nowayout=3D0)
>   console: sunxi-mmc 1c0f000.mmc: Linked as a consumer to regulator.2
>   console: sunxi-mmc 1c0f000.mmc: Got CD GPIO
>   console: ledtrig-cpu: registered to indicate activity on CPUs
>   console: hidraw: raw HID events driver (C) Jiri Kosina
>   console: usbcore: registered new interface driver usbhid
>   console: usbhid: USB HID core driver
>   console: Initializing XFRM netlink socket
>   console: sunxi-mmc 1c0f000.mmc: initialized, max. request size: 16384 K=
B
>   console: NET: Registered protocol family 10
>   console: mmc0: host does not support reading read-only switch, assuming=
 write-enable
>   console: mmc0: Problem switching card into high-speed mode!
>   console: mmc0: new SD card at address 4567
>   console: mmcblk0: mmc0:4567 QEMU! 60.0 MiB
>   [...]
>   console: EXT4-fs (mmcblk0): mounting ext2 file system using the ext4 su=
bsystem
>   console: EXT4-fs (mmcblk0): mounted filesystem without journal. Opts: (=
null)
>   console: VFS: Mounted root (ext2 filesystem) on device 179:0.
>   console: Run /sbin/init as init process
>   console: EXT4-fs (mmcblk0): re-mounted. Opts: block_validity,barrier,us=
er_xattr,acl
>   console: Starting syslogd: OK
>   console: Starting klogd: OK
>   console: Populating /dev using udev: udevd[203]: starting version 3.2.7
>   console: /bin/sh: can't access tty; job control turned off
>   console: cat /proc/partitions
>   console: / # cat /proc/partitions
>   console: major minor  #blocks  name
>   console: 1        0       4096 ram0
>   console: 1        1       4096 ram1
>   console: 1        2       4096 ram2
>   console: 1        3       4096 ram3
>   console: 179        0      61440 mmcblk0
>   console: reboot
>   console: / # reboot
>   console: umount: devtmpfs busy - remounted read-only
>   console: EXT4-fs (mmcblk0): re-mounted. Opts: (null)
>   console: The system is going down NOW!
>   console: Sent SIGTERM to all processes
>   console: Sent SIGKILL to all processes
>   console: Requesting system reboot
>   console: reboot: Restarting system
>   JOB TIME   : 68.64 s
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 42 ++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index daabd47404..8179b45910 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -478,6 +478,48 @@ class BootLinuxConsole(Test):
>          exec_command_and_wait_for_pattern(self, 'reboot',
>                                                  'reboot: Restarting syst=
em')
> =20
> +    def test_arm_orangepi_sd(self):

Same suggestion wrt test name as previous two patches.

> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:orangepi-pc
> +        """
> +        deb_url =3D ('https://apt.armbian.com/pool/main/l/'
> +                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.=
deb')
> +        deb_hash =3D '1334c29c44d984ffa05ed10de8c3361f33d78315'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        kernel_path =3D self.extract_from_deb(deb_path,
> +                                            '/boot/vmlinuz-4.20.7-sunxi'=
)
> +        dtb_path =3D '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-p=
c.dtb'
> +        dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> +        rootfs_url =3D ('http://storage.kernelci.org/images/rootfs/build=
root/'
> +                      'kci-2019.02/armel/base/rootfs.ext2.xz')
> +        rootfs_hash =3D '692510cb625efda31640d1de0a8d60e26040f061'
> +        rootfs_path_xz =3D self.fetch_asset(rootfs_url, asset_hash=3Droo=
tfs_hash)
> +        rootfs_path =3D os.path.join(self.workdir, 'rootfs.cpio')
> +        archive.lzma_uncompress(rootfs_path_xz, rootfs_path)
> +
> +        self.vm.set_machine('orangepi-pc')

Can/should be dropped.

With this,

Tested-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl37184ACgkQZX6NM6Xy
CfPeKQ//f8A9dzXc3+7b2/5oE1MTF1SOR4ETQmtNH+nd74Ga+a/0bkSGYMP9L/2h
XHL+eXivbOt4LU1/WjKVU9BgmzyeoOcTKsQKWT0S+6dtE5ROJdnXb3RzM00nwPpW
8e5SdgPLnNz0D+G1pyV6EntoRpBibddtlCFgl5uCNkV7NcpdnjjTHZwGdo21EucP
bEFWTVaTmfYBp67OQtHvTW+vWpkfueovj5hhOvicjIRqZ2qpqEwk6rcPDvk5zass
ASvH6E9MYlw1wwwlZresqKKk5aunStwaacft/cO2/FkTKZBSDkrYDcCBfGnRfrV+
5yFYrqpc3/9ODdWWZndOnEFE9DC9R/reegkj05qL74lQZ525c9MZdmur6m0FzJW+
IGtJaphmpyywUGXJgjl4pfP4r/2g8rEC/peCLkP+4IjfpjXV5bcADis6U7Zith4C
BX5HYZNnxYFr6HDB1LzlQrH/csBipDinSQsQqSMgl0c3KDP+Hdx0buQ/zn/Wwh6W
691zG2YMb1NJouNFZzOR2X5rkC4XZn9JRlQu0SAh7LTomwbJnnXWy41umkU2cCdR
29lizLyaTjP3whNO9np0UNBcUyESJ/xNCI/F5BRDCuMDOSyS/apLio+aOlDpGSuf
dkK2ysaPWz76a0VlO4EpUAagMeifOCBXmAjVIq09RUuS6VRgyUc=
=7UWe
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--


