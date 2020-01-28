Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AD3C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 20:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBF8A20708
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 20:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRXCuYXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF8A20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwXEH-0001Ct-3v
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 15:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iwXDY-00007W-RY
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iwXDW-00062T-L6
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:12:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58521
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iwXDW-00062D-HK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580242298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+VD4opmU40ZhHzbZma7QoeqCyl1bZGwFJ9tIrugZqFA=;
 b=hRXCuYXAfSNSP/nnG9Kuzk27PmyjmdimKMRE0H2WBw3E1DXiiTnvgedw+DIm+BpecnOEWR
 jXKEGQTYwfuYHX0IpDkig4dMS/Ng9IUWjaHZ4j4AEMD371FUTE2d/bcvy2I4Lve3Qsa+2G
 g89KIxj3yLzjWXdC9nw3yoiBZ51pi6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-1Hva2t1HPlujZe_kcm9aFA-1; Tue, 28 Jan 2020 15:11:35 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FB77800D5F;
 Tue, 28 Jan 2020 20:10:47 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-65.gru2.redhat.com
 [10.97.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBD605C3F8;
 Tue, 28 Jan 2020 20:10:40 +0000 (UTC)
Subject: Re: [PATCH v4 6/7] tests/boot_linux_console: Test booting U-Boot on
 the Raspberry Pi 3
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200120235159.18510-1-f4bug@amsat.org>
 <20200120235159.18510-7-f4bug@amsat.org>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <a781579c-d087-724d-e8c9-346979e3848b@redhat.com>
Date: Tue, 28 Jan 2020 18:10:38 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200120235159.18510-7-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 1Hva2t1HPlujZe_kcm9aFA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/20/20 9:51 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> This test runs U-Boot on the Raspberry Pi 3.
> It is very simple and fast:
>
>    $ avocado --show=3Dapp,console run -t raspi3 -t u-boot tests/acceptanc=
e/
>    JOB LOG    : avocado/job-results/job-2020-01-20T23.40-2424777/job.log
>     (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_aa=
rch64_raspi3_uboot:
>    console: MMC:   mmc@7e202000: 0, sdhci@7e300000: 1
>    console: Loading Environment from FAT... WARNING at drivers/mmc/bcm283=
5_sdhost.c:410/bcm2835_send_command()!
>    console: WARNING at drivers/mmc/bcm2835_sdhost.c:410/bcm2835_send_comm=
and()!
>    console: Card did not respond to voltage select!
>    console: In:    serial
>    console: Out:   vidconsole
>    console: Err:   vidconsole
>    console: Net:   No ethernet found.
>    console: starting USB...
>    console: Bus usb@7e980000: Port not available.
>    console: Hit any key to stop autoboot:  0
>    console: U-Boot>
>    console: U-Boot>
>    console: U-Boot> bdinfo
>    console: arch_number =3D 0x0000000000000000
>    console: boot_params =3D 0x0000000000000100
>    console: DRAM bank   =3D 0x0000000000000000
>    console: -> start    =3D 0x0000000000000000
>    console: -> size     =3D 0x000000003c000000
>    console: baudrate    =3D 115200 bps
>    console: TLB addr    =3D 0x000000003bff0000
>    console: relocaddr   =3D 0x000000003bf57000
>    console: reloc off   =3D 0x000000003bed7000
>    console: irq_sp      =3D 0x000000003bb52dd0
>    console: sp start    =3D 0x000000003bb52dd0
>    console: FB base     =3D 0x0000000000000000
>    console: Early malloc usage: 7b0 / 2000
>    console: fdt_blob    =3D 0x000000003bfbf200
>    console: U-Boot> version
>    console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)
>    console: gcc (Debian 9.2.1-22) 9.2.1 20200104
>    console: GNU ld (GNU Binutils for Debian) 2.33.1
>    console: U-Boot> reset
>    console: resetting ...
>    PASS (1.79 s)
>
> U-Boot is built by the Debian project, see:
> https://wiki.debian.org/InstallingDebianOn/Allwinner#Creating_a_bootable_=
SD_Card_with_u-boot
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   tests/acceptance/boot_linux_console.py | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)


Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 682b801b4f..22b360118d 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -513,6 +513,31 @@ class BootLinuxConsole(Test):
>           exec_command_and_wait_for_pattern(self, 'version', 'U-Boot')
>           exec_command_and_wait_for_pattern(self, 'reset', 'resetting ...=
')
>  =20
> +    def test_aarch64_raspi3_uboot(self):
> +        """
> +        :avocado: tags=3Darch:aarch64
> +        :avocado: tags=3Dmachine:raspi3
> +        :avocado: tags=3Du-boot
> +        """
> +        deb_url =3D ('https://snapshot.debian.org/archive/debian/'
> +                   '20200108T145233Z/pool/main/u/u-boot/'
> +                   'u-boot-rpi_2020.01%2Bdfsg-1_arm64.deb')
> +        deb_hash =3D 'f394386e02469d52f2eb3c07a2325b1c95aeb00b'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        uboot_path =3D '/usr/lib/u-boot/rpi_3/u-boot.bin'
> +        uboot_path =3D self.extract_from_deb(deb_path, uboot_path)
> +
> +        self.vm.set_console(console_index=3D1)
> +        self.vm.add_args('-kernel', uboot_path,
> +                         '-no-reboot')
> +        self.vm.launch()
> +        interrupt_interactive_console_until_pattern(self,
> +                                       'Hit any key to stop autoboot:',
> +                                       'Config file not found')
> +        exec_command_and_wait_for_pattern(self, 'bdinfo', 'U-Boot')
> +        exec_command_and_wait_for_pattern(self, 'version', 'U-Boot')
> +        exec_command_and_wait_for_pattern(self, 'reset', 'resetting ...'=
)
> +
>       def test_s390x_s390_ccw_virtio(self):
>           """
>           :avocado: tags=3Darch:s390x


