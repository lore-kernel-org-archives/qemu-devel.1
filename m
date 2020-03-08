Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F843C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 16:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55B2206D7
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 16:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRjjpfyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55B2206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAygP-0006At-R1
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 12:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jAyf2-00052m-PZ
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 12:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jAyf0-0003J1-Ra
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 12:20:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46655
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jAyf0-0003HB-Mc
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 12:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583684413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8ck3EtEyaP8T+VfEZ4oamQzFDCdoC37X5T0mG1uEKQ=;
 b=PRjjpfyvZPBPxkm0Z84ZedaQt5VqKdbnIg0dTWWhbvwDrkaWCXlE98yiQlypbqnaamyppB
 7641JA7nqQd0KxJv5n79L3Q+kHm38TzaIwMdBe/UOTF6jLxkjYdL3oO7Ulv4BupDGBttcU
 wj52dlAoLxp3p/+yojhsaSrcQx7TQP0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-9JEUFcWSPRmBKmRlA6pd8A-1; Sun, 08 Mar 2020 12:20:08 -0400
X-MC-Unique: 9JEUFcWSPRmBKmRlA6pd8A-1
Received: by mail-ed1-f71.google.com with SMTP id f13so6057846edy.21
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2020 09:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g29Unbf9Jbk3uoNuNy5JkycmQSvwfe+AqODkBdSyd8w=;
 b=psA5NJn7Ap7utu+YabG1rYk93Nvqe9KOtGKOa0W9P1RD96EFhsw5ed9TDAFLa9L/4I
 QTij5E7hyZ8kwlRiInnH14W0o5fZiZdi/zUQpPkhy2TGiSIt2+Ei7O+dOKqSp4GfCQX9
 M9jVEK693Uh1YFeGaaU6sKegLP2CucYTmdmQ9jrmGEvtvc25oj2Ixxp4oTQxo+kqttUl
 bW2DeQj2dSyLgXeZxdrY5h2udxOhEHSL9tOXmrZi1HhA9nZ6osP9JUik9m9+HgVYK7FA
 BZBk1ZyUfVqlDMla+GSD23pA9a+XicGQy4GvZGMY5ARAbQ+gywo5bADJ1WYc3lXPMFbP
 gx/g==
X-Gm-Message-State: ANhLgQ3DGsonXmQb37DOrQwZhCVTw8lv4Ecds6egO9sEUiWvGCV/DZ5D
 kRiRM+BF79E3UWfz4KKWlgy7uTWOcSmPAxpEr5HcUvPazXm/tsrP4lqZj4KOOF9OF9ycL2JicB6
 rUhKEEOxYgrRf0qQ=
X-Received: by 2002:a17:906:1c07:: with SMTP id
 k7mr798480ejg.378.1583684407563; 
 Sun, 08 Mar 2020 09:20:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs2lHT6Chqc1gtp/YauIOMaL9yO0l8vZydk9Vxe528Oowm2TMPesMNBfLEZUE8Hgimi5i+K0A==
X-Received: by 2002:a17:906:1c07:: with SMTP id
 k7mr798459ejg.378.1583684407142; 
 Sun, 08 Mar 2020 09:20:07 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id h22sm1466536edq.28.2020.03.08.09.20.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Mar 2020 09:20:06 -0700 (PDT)
Subject: Re: [PATCH v32 21/22] BootLinuxConsoleTest: Test the RX-Virt machine
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200224141923.82118-1-ysato@users.sourceforge.jp>
 <20200224141923.82118-22-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2c26a629-59d4-f6d5-d06d-cf3d1cf65f4c@redhat.com>
Date: Sun, 8 Mar 2020 17:20:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224141923.82118-22-ysato@users.sourceforge.jp>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/24/20 3:19 PM, Yoshinori Sato wrote:
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> Add two tests for the rx-virt machine, based on the recommended test
> setup from Yoshinori Sato:
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03586.html
>=20
> - U-Boot prompt
> - Linux kernel with Sash shell
>=20
> These are very quick tests:
>=20
>    $ avocado run -t arch:rx tests/acceptance/boot_linux_console.py
>    JOB ID     : 84a6ef01c0b87975ecbfcb31a920afd735753ace
>    JOB LOG    : /home/phil/avocado/job-results/job-2019-05-24T05.02-84a6e=
f0/job.log
>     (1/2) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_rx=
_uboot: PASS (0.11 s)
>     (2/2) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_rx=
_linux: PASS (0.45 s)
>    RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0=
 | CANCEL 0
>=20
> Tests can also be run with:
>=20
>    $ avocado --show=3Dconsole run -t arch:rx tests/acceptance/boot_linux_=
console.py
>    console: U-Boot 2016.05-rc3-23705-ga1ef3c71cb-dirty (Feb 05 2019 - 21:=
56:06 +0900)
>    console: Linux version 4.19.0+ (yo-satoh@yo-satoh-debian) (gcc version=
 9.0.0 20181105 (experimental) (GCC)) #137 Wed Feb 20 23:20:02 JST 2019
>    console: Built 1 zonelists, mobility grouping on.  Total pages: 8128
>    ...
>    console: SuperH (H)SCI(F) driver initialized
>    console: 88240.serial: ttySC0 at MMIO 0x88240 (irq =3D 215, base_baud =
=3D 0) is a sci
>    console: console [ttySC0] enabled
>    console: 88248.serial: ttySC1 at MMIO 0x88248 (irq =3D 219, base_baud =
=3D 0) is a sci
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Based-on: 20190517045136.3509-1-richard.henderson@linaro.org
> "RX architecture support"
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>   tests/acceptance/boot_linux_console.py | 46 ++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 34d37eba3b..367cf480a5 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -686,3 +686,49 @@ class BootLinuxConsole(Test):
>           tar_hash =3D '49e88d9933742f0164b60839886c9739cb7a0d34'
>           self.vm.add_args('-cpu', 'dc233c')
>           self.do_test_advcal_2018('02', tar_hash, 'santas-sleigh-ride.el=
f')
> +
> +    def test_rx_uboot(self):
> +        """
> +        :avocado: tags=3Darch:rx
> +        :avocado: tags=3Dmachine:rx-virt
> +        :avocado: tags=3Dendian:little
> +        """
> +        uboot_url =3D ('https://acc.dl.osdn.jp/users/23/23888/u-boot.bin=
.gz')
> +        uboot_hash =3D '9b78dbd43b40b2526848c0b1ce9de02c24f4dcdb'
> +        uboot_path =3D self.fetch_asset(uboot_url, asset_hash=3Duboot_ha=
sh)
> +        uboot_path =3D archive.uncompress(uboot_path, self.workdir)
> +
> +        self.vm.set_machine('rx-virt')
> +        self.vm.set_console()
> +        self.vm.add_args('-bios', uboot_path,
> +                         '-no-reboot')
> +        self.vm.launch()
> +        uboot_version =3D 'U-Boot 2016.05-rc3-23705-ga1ef3c71cb-dirty'
> +        self.wait_for_console_pattern(uboot_version)
> +        gcc_version =3D 'rx-unknown-linux-gcc (GCC) 9.0.0 20181105 (expe=
rimental)'
> +        # FIXME limit baudrate on chardev, else we type too fast
> +        #self.exec_command_and_wait_for_pattern('version', gcc_version)
> +
> +    def test_rx_linux(self):
> +        """
> +        :avocado: tags=3Darch:rx
> +        :avocado: tags=3Dmachine:rx-virt
> +        :avocado: tags=3Dendian:little
> +        """
> +        dtb_url =3D ('https://acc.dl.osdn.jp/users/23/23887/rx-qemu.dtb'=
)

Sourceforge URL are not very stable, I'm now getting:

HTTP request sent, awaiting response... 302 Found
Location: https://osdn.dl.osdn.net/users/23/23887/rx-qemu.dtb [following]
--2020-03-08 17:17:31--  https://osdn.dl.osdn.net/users/23/23887/rx-qemu.dt=
b
Resolving osdn.dl.osdn.net (osdn.dl.osdn.net)... 202.221.179.23
Connecting to osdn.dl.osdn.net (osdn.dl.osdn.net)|202.221.179.23|:443...=20
connected.
HTTP request sent, awaiting response... 404 Not Found
2020-03-08 17:17:32 ERROR 404: Not Found.

> +        dtb_hash =3D '7b4e4e2c71905da44e86ce47adee2210b026ac18'
> +        dtb_path =3D self.fetch_asset(dtb_url, asset_hash=3Ddtb_hash)
> +        kernel_url =3D ('http://acc.dl.osdn.jp/users/23/23845/zImage')
> +        kernel_hash =3D '39a81067f8d72faad90866ddfefa19165d68fc99'
> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
> +
> +        self.vm.set_machine('rx-virt')
> +        self.vm.set_console()
> +        kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'early=
con'
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-no-reboot')
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Sash command shell (version 1.1.1=
)')
> +        self.exec_command_and_wait_for_pattern('printenv',
> +                                               'TERM=3Dlinux')
>=20


