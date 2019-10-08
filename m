Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847FBC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 23:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58EB920873
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 23:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EB920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHyfd-0005nF-DL
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 19:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iHyen-0005Hd-3f
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 19:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iHyel-0000F7-FD
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 19:12:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46796)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1iHyeh-0000DA-8c; Tue, 08 Oct 2019 19:12:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F337F8342DF;
 Tue,  8 Oct 2019 23:12:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-151.rdu2.redhat.com
 [10.10.122.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FC895D9CD;
 Tue,  8 Oct 2019 23:12:28 +0000 (UTC)
Date: Tue, 8 Oct 2019 19:12:26 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 5/5] tests/boot_linux_console: Add sdcard test for the
 Exynos4210
Message-ID: <20191008231226.GC11091@localhost.localdomain>
References: <20191005154748.21718-1-f4bug@amsat.org>
 <20191005154748.21718-6-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191005154748.21718-6-f4bug@amsat.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Tue, 08 Oct 2019 23:12:34 +0000 (UTC)
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
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric?= Basse <contact@fredericb.info>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Evgeny Voevodin <e.voevodin@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-devel@nongnu.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Dmitry Solodkiy <d.solodkiy@samsung.com>, Maksim Kozlov <m.kozlov@samsung.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 05, 2019 at 05:47:48PM +0200, Philippe Mathieu-Daud=E9 wrote:
> This test boots a Linux kernel on a smdkc210 board and verify
> the serial output is working.
>=20
> The cpio image used comes from the linux-build-test project:
> https://github.com/groeck/linux-build-test
>=20
> Since this test is not reliable due to clock timing issues,
> it is disabled with the 'skip' property.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 47 ++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index 197358a69c..2d0d82b013 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -14,6 +14,7 @@ import lzma
>  import gzip
>  import shutil
> =20
> +from avocado import skip
>  from avocado_qemu import Test
>  from avocado.utils import process
>  from avocado.utils import archive
> @@ -359,6 +360,52 @@ class BootLinuxConsole(Test):
>          self.wait_for_console_pattern('Boot successful.')
>          # TODO user command, for now the uart is stuck
> =20
> +    @skip("unstable clock timings")

On the topic of skipping unstable tests, don't you think this is
something that should check for some type of flag?

Just for the sake of brainstorming, other possiblity is to build on
Avocado's "WARN" test status, and instead of failing a test (and
affecting the overall job execution), simply warn the user.  A
decorator such as "@warn_on" could be implemented similar to the
existing "@fail_on" and "@cancel_on".

> +    def test_arm_exynos4210_sdcard(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:smdkc210
> +        """
> +        deb_url =3D ('https://snapshot.debian.org/archive/debian/'
> +                   '20190928T224601Z/pool/main/l/linux/'
> +                   'linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf=
.deb')
> +        deb_hash =3D 'fa9df4a0d38936cb50084838f2cb933f570d7d82'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        kernel_path =3D self.extract_from_deb(deb_path,
> +                                            '/boot/vmlinuz-4.19.0-6-ar=
mmp')
> +        dtb_path =3D '/usr/lib/linux-image-4.19.0-6-armmp/exynos4210-s=
mdkv310.dtb'
> +        dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> +
> +        rootfs_url =3D ('https://github.com/groeck/linux-build-test/ra=
w/'
> +                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs=
/'
> +                      'arm/rootfs-armv5.ext2.gz')
> +        rootfs_hash =3D '093e89d2b4d982234bf528bc9fb2f2f17a9d1f93'
> +        rootfs_path_gz =3D self.fetch_asset(rootfs_url, asset_hash=3Dr=
ootfs_hash)
> +        rootfs_path =3D os.path.join(self.workdir, 'rootfs.ext2')
> +        gunzip(rootfs_path_gz, rootfs_path)

I was going to suggest the same thing as the previous patch, but this
turned out to be quite interesting.  Basically, both compressed and
uncompressed verions of this file seems to disguise themselves pretty
well as a tar file:

 $ tar vtf rootfs-armv5.ext2.gz
 $ gzip -dc rootfs-armv5.ext2.gz | tar vtf -
 $ python3 -m tarfile -l rootfs-armv5.ext2.gz
 $ python3 -m tarfile -l rootfs-armv5.ext2

Even though it is not.  This affects how "avocado.utils.uncompress"
detects the file, and consequently how it tries to uncompress it.
So, here, you could instead use:

  archive.gzip_uncompress(rootfs_path_gz, rootfs_path)

To avoid relying on the broken tar file detection.

- Cleber.

> +
> +        self.vm.set_machine('smdkc210')
> +        self.vm.set_console(console_id=3D1)
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'earlycon=3Dexynos4210,0x13810000 early=
printk ' +
> +                               'console=3DttySAC1,115200n8 ' +
> +                               'random.trust_cpu=3Doff cryptomgr.notes=
ts ' +
> +                               'root=3D/dev/mmcblk0 rootwait rw ' +
> +                               'cpuidle.off=3D1 panic=3D-1 noreboot')
> +
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-append', kernel_command_line,
> +                         # The external MMC is on the 3rd slot
> +                         '-drive', 'if=3Dsd,driver=3Dnull-co',
> +                         '-drive', 'if=3Dsd,driver=3Dnull-co',
> +                         '-drive', 'if=3Dsd,file=3D' + rootfs_path + '=
,format=3Draw',
> +                         '-no-reboot')
> +        self.vm.launch()
> +
> +        self.wait_for_console_pattern('Boot successful.')
> +        # TODO user command, for now the uart is stuck
> +
>      def test_s390x_s390_ccw_virtio(self):
>          """
>          :avocado: tags=3Darch:s390x
> --=20
> 2.20.1
>=20
>=20

