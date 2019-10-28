Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46EACA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 20:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8534F20830
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 20:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0z/eRQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8534F20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPC4K-000838-Mn
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 16:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iPC2Z-0005qL-Oc
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 16:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iPC2X-0005o8-CI
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 16:55:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38409)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iPC2W-0005nc-Se
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 16:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572296099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zzLpVCpdBGLrejxVBKJ3SW3r4XSFrbynxArLjwlQGao=;
 b=h0z/eRQdt1+P7/car8s+pQb4HSvb2ZTfMcKzJrdWStsCIJFaUTWZZXHXc03O+WPUat0tE2
 dTY/WdVSjKQXNypwQymsFYtrIv60XKHfw2ehgXX7REfw46mIqCaIzoa/9bp281t+CW2bse
 uNTttaTCh222xQv9pAVotwwgIw22onc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-CkDU23vbOg6QL9akm4eAHQ-1; Mon, 28 Oct 2019 16:54:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09E09801E64;
 Mon, 28 Oct 2019 20:54:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B18B460856;
 Mon, 28 Oct 2019 20:54:48 +0000 (UTC)
Date: Mon, 28 Oct 2019 16:54:46 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 23/26] tests/boot_linux_console: Test SDHCI and termal
 sensor on raspi3
Message-ID: <20191028205446.GE18794@localhost.localdomain>
References: <20191028073441.6448-1-philmd@redhat.com>
 <20191028073441.6448-24-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191028073441.6448-24-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: CkDU23vbOg6QL9akm4eAHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 28, 2019 at 08:34:38AM +0100, Philippe Mathieu-Daud=E9 wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> Add a test which loads the root filesystem on a SD card.
> Use a kernel recent enough to also test the thermal sensor.
>=20
> The kernel image comes from:
> https://github.com/sakaki-/bcmrpi3-kernel#description
>=20
> The cpio image used comes from the linux-build-test project:
> https://github.com/groeck/linux-build-test
>=20
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> Tested-by: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> v2: Use archive.gzip_uncompress (Cleber)
> ---
>  tests/acceptance/boot_linux_console.py | 46 ++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index dc27d79199..44a046bd64 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -386,6 +386,52 @@ class BootLinuxConsole(MachineTest):
>          exec_command_and_wait_for_pattern(self, 'reboot',
>                                                  'reboot: Restarting syst=
em')
> =20
> +    def test_arm_raspi3_initrd_sd_temp(self):
> +        """
> +        :avocado: tags=3Darch:aarch64
> +        :avocado: tags=3Dmachine:raspi3
> +        """
> +        tarball_url =3D ('https://github.com/sakaki-/bcmrpi3-kernel/rele=
ases/'
> +                       'download/4.19.71.20190910/'
> +                       'bcmrpi3-kernel-4.19.71.20190910.tar.xz')
> +        tarball_hash =3D '844f117a1a6de0532ba92d2a7bceb5b2acfbb298'
> +        tarball_path =3D self.fetch_asset(tarball_url, asset_hash=3Dtarb=
all_hash)
> +        archive.extract(tarball_path, self.workdir)
> +        dtb_path    =3D self.workdir + "/boot/bcm2837-rpi-3-b.dtb"
> +        kernel_path =3D self.workdir + "/boot/kernel8.img"
> +
> +        rootfs_url =3D ('https://github.com/groeck/linux-build-test/raw/=
'
> +                      '9b6b392ea7bc15f0d6632328d429d31c9c6273da/rootfs/'
> +                      'arm64/rootfs.ext2.gz')
> +        rootfs_hash =3D 'dbe4136f0b4a0d2180b93fd2a3b9a784f9951d10'
> +        rootfs_path_gz =3D self.fetch_asset(rootfs_url, asset_hash=3Droo=
tfs_hash)
> +        rootfs_path =3D self.workdir + "rootfs.ext2"
> +        archive.gzip_uncompress(rootfs_path_gz, rootfs_path)
> +
> +        self.vm.set_machine('raspi3')
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'earlycon=3Dpl011,0x3f201000 console=3Dtt=
yAMA0 ' +
> +                               'root=3D/dev/mmcblk0 rootwait rw ' +
> +                               'panic=3D-1 noreboot')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-append', kernel_command_line,
> +                         '-drive', 'file=3D' + rootfs_path + ',if=3Dsd,f=
ormat=3Draw',
> +                         '-no-reboot')
> +        self.vm.launch()
> +
> +        self.wait_for_console_pattern('Boot successful.',
> +                                      failure_message=3D'-----[ cut here=
 ]-----')
> +

Same here as in previous patch, that is:

        wait_for_console_pattern(self,
                                 'Boot successful.',
                                 failure_message=3D'-----[ cut here ]-----'=
)

Also, I'm getting the same experience, that is it gets stuck...

VM launch command: 'aarch64-softmmu/qemu-system-aarch64 -chardev socket,id=
=3Dmon,path=3D/var/tmp/tmpi8x47vvd/qemu-25605-monitor.sock -mon chardev=3Dm=
on,mode=3Dcontrol -display none -vga none -machine raspi3 -chardev socket,i=
d=3Dconsole,path=3D/var/tmp/tmpi8x47vvd/qemu-25605-console.sock,server,nowa=
it -serial chardev:console -kernel /var/tmp/avocado_lfnakl9r/avocado_job_t5=
whwper/1-tests_acceptance_boot_linux_console.py_BootLinuxConsole.test_arm_r=
aspi3_initrd_sd_temp/boot/kernel8.img -dtb /var/tmp/avocado_lfnakl9r/avocad=
o_job_t5whwper/1-tests_acceptance_boot_linux_console.py_BootLinuxConsole.te=
st_arm_raspi3_initrd_sd_temp/boot/bcm2837-rpi-3-b.dtb -append printk.time=
=3D0 earlycon=3Dpl011,0x3f201000 console=3DttyAMA0 root=3D/dev/mmcblk0 root=
wait rw panic=3D-1 noreboot -drive file=3D/var/tmp/avocado_lfnakl9r/avocado=
_job_t5whwper/1-tests_acceptance_boot_linux_console.py_BootLinuxConsole.tes=
t_arm_raspi3_initrd_sd_temprootfs.ext2,if=3Dsd,format=3Draw -no-reboot'
 >>> {'execute': 'qmp_capabilities'}
 <<< {'return': {}}

... right here.

- Cleber.


