Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814BFC2D0C3
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 20:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4418E20658
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 20:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8X1ijzz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4418E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1im22R-0004Z0-Fg
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 15:53:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1im21f-00043N-2S
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 15:52:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1im21c-0000Hn-1S
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 15:52:29 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22707
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1im21b-0000G2-JE
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 15:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577739146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zc0FTPmlN/eRAhViCLUrPsRLUXsok9bOT2zdMSbRLgQ=;
 b=R8X1ijzzwhP2BLHQXQe7+C7Ec4lqGlZV+KePHM+EzWmQ+aRsmT1+jbEn43b0dVmGog84bW
 gBr5li2m2Z+o5WwlKbuuVU7lN+iDB8m7ZbKwfI/pTrJulTj2M6w//qzELlyvnlznhvtA31
 Qh3j1sm7cjWWhsWQQ9+23Xmyab7h9lQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-NjHmOij-PCKjhle4dijyog-1; Mon, 30 Dec 2019 15:52:21 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 797B2107ACC5;
 Mon, 30 Dec 2019 20:52:19 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-92.gru2.redhat.com
 [10.97.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C0BF778E81;
 Mon, 30 Dec 2019 20:52:15 +0000 (UTC)
Subject: Re: [PATCH 1/6] tests/boot_linux_console: Add initrd test for the
 CubieBoard
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20191230110953.25496-1-f4bug@amsat.org>
 <20191230110953.25496-2-f4bug@amsat.org>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <31147d48-2f31-9fce-b8a4-1a270f114a45@redhat.com>
Date: Mon, 30 Dec 2019 18:52:13 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191230110953.25496-2-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: NjHmOij-PCKjhle4dijyog-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 12/30/19 9:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> This test boots a Linux kernel on a CubieBoard and verify
> the serial output is working.
>
> The kernel image and DeviceTree blob are built by the Armbian
> project (based on Debian):
> https://docs.armbian.com/Developer-Guide_Build-Preparation/
>
> The cpio image used comes from the linux-build-test project:
> https://github.com/groeck/linux-build-test
>
> If ARM is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:arm" tags.
>
> Alternatively, this test can be run using:
>
>    $ avocado --show=3Dconsole run -t machine:cubieboard tests/acceptance/=
boot_linux_console.py
>    console: Uncompressing Linux... done, booting the kernel.
>    console: Booting Linux on physical CPU 0x0
>    console: Linux version 4.20.7-sunxi (root@armbian.com) (gcc version 7.=
2.1 20171011 (Linaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET 201=
9
>    console: CPU: ARMv7 Processor [410fc080] revision 0 (ARMv7), cr=3D50c5=
387d
>    console: CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing ins=
truction cache
>    console: OF: fdt: Machine model: Cubietech Cubieboard
>    [...]
>    console: Boot successful.
>    console: cat /proc/cpuinfo
>    console: / # cat /proc/cpuinfo
>    console: processor      : 0
>    console: model name     : ARMv7 Processor rev 0 (v7l)
>    console: BogoMIPS       : 832.51
>    [...]
>    console: Hardware       : Allwinner sun4i/sun5i Families
>    console: Revision       : 0000
>    console: Serial         : 0000000000000000
>    console: cat /proc/iomem
>    console: / # cat /proc/iomem
>    console: 01c00000-01c0002f : system-control@1c00000
>    console: 01c02000-01c02fff : dma-controller@1c02000
>    console: 01c05000-01c05fff : spi@1c05000
>    console: 01c0b080-01c0b093 : mdio@1c0b080
>    console: 01c0c000-01c0cfff : lcd-controller@1c0c000
>    console: 01c0d000-01c0dfff : lcd-controller@1c0d000
>    console: 01c0f000-01c0ffff : mmc@1c0f000
>    [...]
>    PASS (54.35 s)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   tests/acceptance/boot_linux_console.py | 41 ++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 9c6aa2040a..4643f60e37 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -400,6 +400,47 @@ class BootLinuxConsole(Test):
>           self.wait_for_console_pattern('Boot successful.')
>           # TODO user command, for now the uart is stuck
>  =20
> +    def test_arm_cubieboard_initrd(self):

Unless you have two tests, one with and without initrd (not the case=20
though) the suffix '_initrd' is useless. So I suggest to remove it.

> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:cubieboard
> +        """
> +        deb_url =3D ('https://apt.armbian.com/pool/main/l/'
> +                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.=
deb')
> +        deb_hash =3D '1334c29c44d984ffa05ed10de8c3361f33d78315'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        kernel_path =3D self.extract_from_deb(deb_path,
> +                                            '/boot/vmlinuz-4.20.7-sunxi'=
)
> +        dtb_path =3D '/usr/lib/linux-image-dev-sunxi/sun4i-a10-cubieboar=
d.dtb'
> +        dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> +        initrd_url =3D ('https://github.com/groeck/linux-build-test/raw/=
'
> +                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
> +                      'arm/rootfs-armv5.cpio.gz')
> +        initrd_hash =3D '2b50f1873e113523967806f4da2afe385462ff9b'
> +        initrd_path_gz =3D self.fetch_asset(initrd_url, asset_hash=3Dini=
trd_hash)
> +        initrd_path =3D os.path.join(self.workdir, 'rootfs.cpio')
> +        archive.gzip_uncompress(initrd_path_gz, initrd_path)
> +
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'console=3DttyS0,115200 '
> +                               'usbcore.nousb '
> +                               'panic=3D-1 noreboot')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-initrd', initrd_path,
> +                         '-append', kernel_command_line,
> +                         '-no-reboot')
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Boot successful.')
> +
> +        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
> +                                                'Allwinner sun4i/sun5i')
> +        exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
> +                                                'system-control@1c00000'=
)
> +        exec_command_and_wait_for_pattern(self, 'reboot',
> +                                                'reboot: Restarting syst=
em')


I ran this test case with success, so:

Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

With the comment regarding the _initrd suffix:

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


> +
>       def test_s390x_s390_ccw_virtio(self):
>           """
>           :avocado: tags=3Darch:s390x


