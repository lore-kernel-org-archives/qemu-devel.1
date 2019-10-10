Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB39C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1059021835
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1059021835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIb0H-0003kh-Rs
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 12:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIaxv-0001R0-Ry
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 12:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIaxu-0004hN-8J
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 12:06:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50046)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIaxt-0004dr-Vs
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 12:06:58 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ED0FE9B291
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 16:06:56 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id i14so2958518wro.19
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 09:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MgdtPln9+u2tBjiyGEWLuBa8pPLJTIeVEq7ybGlcMtw=;
 b=mQWj3SSCnefXsFuiB0gI9JwKLvR+k4fpnQDlDAarxP36Pg/50hm3MFgnjcz3Athtei
 gUlvv9udE0hJGpHGrLNZ4Q48RKlQHtCY9WJjmcSVzgHK8PEsutSynJ1hIPyEwG/iWotp
 neM57kIMV+g4Zjf+tS6XNW+/xAIp56b4qAgForoshP/S+lilmSeuTWCrfRRnx0XJN4he
 P5kufaAyeL+r2tj+YK+GqEm0gOd+kzgOzLCdbf2Q5fuk5ZiqSSfrXUAtT1dwfpuY7fOC
 1JBILHw42R68T+xhtyirlGcYlh8aZM2hixrSxbYgicAnM7FCppcCd8/H2rw21sJw2Wr4
 qURQ==
X-Gm-Message-State: APjAAAUQzLvn73bJjYvtRbbcQfX4y10X3ZUnbO9goygV2TOxylWMaQvc
 1fM/78Ytg+dM4S79pa8kPlitPxwNYm0SsU0UuowqpZkJRFt6LAlu4Tu8AIxK2dts7IMvQqWQWjY
 h8XQxW4IQuIJshxo=
X-Received: by 2002:a7b:c40a:: with SMTP id k10mr8916306wmi.115.1570723615563; 
 Thu, 10 Oct 2019 09:06:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw4VoUkW3LmBZeIsTlaoGAAYjB4Iw3dJ/p0xqeEiuNG9ft7O3xJCQKM3XcPIJ15pFP7hp1w+g==
X-Received: by 2002:a7b:c40a:: with SMTP id k10mr8916278wmi.115.1570723615295; 
 Thu, 10 Oct 2019 09:06:55 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id v6sm11045427wma.24.2019.10.10.09.06.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2019 09:06:54 -0700 (PDT)
Subject: Re: [PATCH v25 21/22] BootLinuxConsoleTest: Test the RX-Virt machine
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190927062302.110144-1-ysato@users.sourceforge.jp>
 <20190927062302.110144-22-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fb8f1a9d-4abe-1c51-db05-a7a09b0189c8@redhat.com>
Date: Thu, 10 Oct 2019 18:06:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190927062302.110144-22-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/27/19 8:23 AM, Yoshinori Sato wrote:
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
>    JOB LOG    : /home/phil/avocado/job-results/job-2019-05-24T05.02-84a=
6ef0/job.log
>     (1/2) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_=
rx_uboot: PASS (0.11 s)
>     (2/2) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_=
rx_linux: PASS (0.45 s)
>    RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT=
 0 | CANCEL 0
>=20
> Tests can also be run with:
>=20
>    $ avocado --show=3Dconsole run -t arch:rx tests/acceptance/boot_linu=
x_console.py
>    console: U-Boot 2016.05-rc3-23705-ga1ef3c71cb-dirty (Feb 05 2019 - 2=
1:56:06 +0900)
>    console: Linux version 4.19.0+ (yo-satoh@yo-satoh-debian) (gcc versi=
on 9.0.0 20181105 (experimental) (GCC)) #137 Wed Feb 20 23:20:02 JST 2019
>    console: Built 1 zonelists, mobility grouping on.  Total pages: 8128
>    ...
>    console: SuperH (H)SCI(F) driver initialized
>    console: 88240.serial: ttySC0 at MMIO 0x88240 (irq =3D 215, base_bau=
d =3D 0) is a sci
>    console: console [ttySC0] enabled
>    console: 88248.serial: ttySC1 at MMIO 0x88248 (irq =3D 219, base_bau=
d =3D 0) is a sci
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Here goes your:

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

> ---

   ^ Because every comment after this '---' will be skipped.

> Based-on: 20190517045136.3509-1-richard.henderson@linaro.org
> "RX architecture support"
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>   tests/acceptance/boot_linux_console.py | 46 +++++++++++++++++++++++++=
+
>   1 file changed, 46 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index 8a9a314ab4..5e805a2ee1 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -378,3 +378,49 @@ class BootLinuxConsole(Test):
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_comman=
d_line
>           self.wait_for_console_pattern(console_pattern)
> +
> +    def test_rx_uboot(self):
> +        """
> +        :avocado: tags=3Darch:rx
> +        :avocado: tags=3Dmachine:rx-virt
> +        :avocado: tags=3Dendian:little
> +        """
> +        uboot_url =3D ('https://acc.dl.osdn.jp/users/23/23888/u-boot.b=
in.gz')
> +        uboot_hash =3D '9b78dbd43b40b2526848c0b1ce9de02c24f4dcdb'
> +        uboot_path =3D self.fetch_asset(uboot_url, asset_hash=3Duboot_=
hash)
> +        uboot_path =3D archive.uncompress(uboot_path, self.workdir)
> +
> +        self.vm.set_machine('rx-virt')
> +        self.vm.set_console()
> +        self.vm.add_args('-bios', uboot_path,
> +                         '-no-reboot')
> +        self.vm.launch()
> +        uboot_version =3D 'U-Boot 2016.05-rc3-23705-ga1ef3c71cb-dirty'
> +        self.wait_for_console_pattern(uboot_version)
> +        gcc_version =3D 'rx-unknown-linux-gcc (GCC) 9.0.0 20181105 (ex=
perimental)'
> +        # FIXME limit baudrate on chardev, else we type too fast
> +        #self.exec_command_and_wait_for_pattern('version', gcc_version=
)
> +
> +    def test_rx_linux(self):
> +        """
> +        :avocado: tags=3Darch:rx
> +        :avocado: tags=3Dmachine:rx-virt
> +        :avocado: tags=3Dendian:little
> +        """
> +        dtb_url =3D ('https://acc.dl.osdn.jp/users/23/23887/rx-qemu.dt=
b')
> +        dtb_hash =3D '7b4e4e2c71905da44e86ce47adee2210b026ac18'
> +        dtb_path =3D self.fetch_asset(dtb_url, asset_hash=3Ddtb_hash)
> +        kernel_url =3D ('http://acc.dl.osdn.jp/users/23/23845/zImage')
> +        kernel_hash =3D '39a81067f8d72faad90866ddfefa19165d68fc99'
> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkern=
el_hash)
> +
> +        self.vm.set_machine('rx-virt')
> +        self.vm.set_console()
> +        kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'ear=
lycon'
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-no-reboot')
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Sash command shell (version 1.1=
.1)')
> +        self.exec_command_and_wait_for_pattern('printenv',
> +                                               'TERM=3Dlinux')
>=20

