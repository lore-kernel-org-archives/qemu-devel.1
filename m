Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDA2C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DD52078B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ki5mYs8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DD52078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFi7n-0008In-0d
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kFi6r-0007Of-9s
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:12:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58641
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kFi6n-0006Mj-JP
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599588764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IA+RSVez7PStuKF9zlP35uloSrljlx4DrDIbxlycowQ=;
 b=Ki5mYs8R0WoQMDVxx+qwBParZVXi98o3m3p7LQO7Ktepsg+JOk+1PWob0D6NkSAHZu+9Gj
 mmqlaYQD2Bc7u/vT6uvgG/cQep9IKsXl30kdmKYWdpSL2VmE5JOrBpZDuqLgvDNvgoY/wx
 zrZ2uqytxCZ+Vob2RNXceyGhdbGGRKQ=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-vJIsEzy0MMiFsdPNnLF0vw-1; Tue, 08 Sep 2020 14:12:30 -0400
X-MC-Unique: vJIsEzy0MMiFsdPNnLF0vw-1
Received: by mail-vk1-f198.google.com with SMTP id l24so84048vkk.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 11:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IA+RSVez7PStuKF9zlP35uloSrljlx4DrDIbxlycowQ=;
 b=BaiO5sS2gpW92Gt0BLyg8kw6oZjtpQYEK8yCrmE01PmWSzA8geq8b5FO9l9SmXC6Cd
 +JuzFq4WLF7R4CA/KxuQtHTpFM5ecP1TFJ/RqxgNLSQw8aCbQBwSPEh4Zyhb1HCeFwNJ
 K77oefHoUCwIuzpBuTvi9THccDnJK67ca+q7uVmJyYDPnuxzoa3HYW6mnXTEDSHgLAy3
 rbRreTI1JvIBS6OfDL9ZS9j+ar0rH4ifcUojp7ksQXMZghHavCNYxMSg+O1FziASxFAU
 s8gJmK9AIyTQJvXXB8gTT4c0Pxuft1BXsK7Znjz9VsH6Twx57ZYVW4LXE/N2EB89i/SC
 YrrQ==
X-Gm-Message-State: AOAM53175EjBia6vCfPHq/U8pOOqRDBuawox0damFmjx69MZaB24n+eQ
 UmTk1fhkkId285Ce61+cz4qcyVMkWrzAUHzn5KOFMVd0A3yxTaEZ9QLpTxS+b7QK9Nb4wAFUsli
 OrDKDCsxOs9Xv1xS35jzw6REOXq3qRhM=
X-Received: by 2002:a1f:284e:: with SMTP id o75mr219857vko.19.1599588748402;
 Tue, 08 Sep 2020 11:12:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdJ87xQSaXx4SeikIiOlbKgdo59oiPp4OfAD0D2XBfZV+5kR++Dv5v60I0HFejxfgBCB+UDi1OM92gSkxQh+k=
X-Received: by 2002:a1f:284e:: with SMTP id o75mr219809vko.19.1599588747441;
 Tue, 08 Sep 2020 11:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200907042000.415931-1-crosa@redhat.com>
 <20200907042000.415931-5-crosa@redhat.com>
In-Reply-To: <20200907042000.415931-5-crosa@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Tue, 8 Sep 2020 15:12:16 -0300
Message-ID: <CAKJDGDan-EnZLKGOy9KNC1H5j4kB67eiRKfvEo2sY2Jbg+opFw@mail.gmail.com>
Subject: Re: [PATCH 4/4] Acceptance tests: cancel tests on missing assets
To: Cleber Rosa <crosa@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wrampazz@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=wrampazz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 01:08:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_BTC_ID=0.5, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 qemu-arm@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 7, 2020 at 1:20 AM Cleber Rosa <crosa@redhat.com> wrote:
>
> Asset files used on the acceptance tests (kernel, initrd images)
> unfortunately are not guaranteed to always be available at the same
> location.
>
> Let's cancel (kind of like a skip) the test, when the asset is
> missing.  This should prevent false positives, when failure are not
> caused by changes in QEMU itself.
>
> Reference: https://avocado-framework.readthedocs.io/en/81.0/api/test/avocado.html#avocado.Test.fetch_asset
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py       | 102 ++++++++++++-------
>  tests/acceptance/linux_initrd.py             |   6 +-
>  tests/acceptance/linux_ssh_mips_malta.py     |   6 +-
>  tests/acceptance/machine_arm_canona1100.py   |   3 +-
>  tests/acceptance/machine_arm_integratorcp.py |   9 +-
>  tests/acceptance/machine_arm_n8x0.py         |   3 +-
>  tests/acceptance/machine_avr6.py             |   3 +-
>  tests/acceptance/machine_m68k_nextcube.py    |   3 +-
>  tests/acceptance/machine_mips_malta.py       |   6 +-
>  tests/acceptance/machine_rx_gdbsim.py        |   9 +-
>  tests/acceptance/machine_sparc64_sun4u.py    |   3 +-
>  tests/acceptance/machine_sparc_leon3.py      |   3 +-
>  tests/acceptance/ppc_prep_40p.py             |   8 +-
>  tests/acceptance/replay_kernel.py            |  43 +++++---
>  14 files changed, 138 insertions(+), 69 deletions(-)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index c75c512c8b..c3c6ccac7c 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -99,7 +99,8 @@ class BootLinuxConsole(LinuxKernelTest):
>                        '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
>                        '/vmlinuz')
>          kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
> -        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
> +                                       cancel_on_missing=True)
>
>          self.vm.set_console()
>          kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
> @@ -119,7 +120,8 @@ class BootLinuxConsole(LinuxKernelTest):
>                     '20130217T032700Z/pool/main/l/linux-2.6/'
>                     'linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb')
>          deb_hash = 'a8cfc28ad8f45f54811fc6cf74fc43ffcfe0ba04'
> -        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash,
> +                                    cancel_on_missing=True)
>          kernel_path = self.extract_from_deb(deb_path,
>                                              '/boot/vmlinux-2.6.32-5-4kc-malta')
>
> @@ -151,7 +153,8 @@ class BootLinuxConsole(LinuxKernelTest):
>                     '20130217T032700Z/pool/main/l/linux-2.6/'
>                     'linux-image-2.6.32-5-5kc-malta_2.6.32-48_mipsel.deb')
>          deb_hash = '1aaec92083bf22fda31e0d27fa8d9a388e5fc3d5'
> -        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash,
> +                                    cancel_on_missing=True)
>          kernel_path = self.extract_from_deb(deb_path,
>                                              '/boot/vmlinux-2.6.32-5-5kc-malta')
>
> @@ -173,14 +176,16 @@ class BootLinuxConsole(LinuxKernelTest):
>                     '20160601T041800Z/pool/main/l/linux/'
>                     'linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb')
>          deb_hash = 'a3c84f3e88b54e06107d65a410d1d1e8e0f340f8'
> -        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash,
> +                                    cancel_on_missing=True)
>          kernel_path = self.extract_from_deb(deb_path,
>                                              '/boot/vmlinux-4.5.0-2-4kc-malta')
>          initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
>                        '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
>                        'mips/rootfs.cpio.gz')
>          initrd_hash = 'bf806e17009360a866bf537f6de66590de349a99'
> -        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
> +        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash,
> +                                          cancel_on_missing=True)
>          initrd_path = self.workdir + "rootfs.cpio"
>          archive.gzip_uncompress(initrd_path_gz, initrd_path)
>
> @@ -215,13 +220,15 @@ class BootLinuxConsole(LinuxKernelTest):
>                        'raw/9ad2df38/mips/malta/mips64el/'
>                        'vmlinux-3.19.3.mtoman.20150408')
>          kernel_hash = '00d1d268fb9f7d8beda1de6bebcc46e884d71754'
> -        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
> +                                       cancel_on_missing=True)
>          initrd_url = ('https://github.com/groeck/linux-build-test/'
>                        'raw/8584a59e/rootfs/'
>                        'mipsel64/rootfs.mipsel64r1.cpio.gz')
>          initrd_hash = '1dbb8a396e916847325284dbe2151167'
>          initrd_path_gz = self.fetch_asset(initrd_url, algorithm='md5',
> -                                          asset_hash=initrd_hash)
> +                                          asset_hash=initrd_hash,
> +                                          cancel_on_missing=True)
>          initrd_path = self.workdir + "rootfs.cpio"
>          archive.gzip_uncompress(initrd_path_gz, initrd_path)
>
> @@ -247,7 +254,8 @@ class BootLinuxConsole(LinuxKernelTest):
>          self.vm.wait()
>
>      def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash):
> -        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
> +                                          cancel_on_missing=True)
>          kernel_path = self.workdir + "kernel"
>          with lzma.open(kernel_path_xz, 'rb') as f_in:
>              with open(kernel_path, 'wb') as f_out:
> @@ -310,7 +318,8 @@ class BootLinuxConsole(LinuxKernelTest):
>                        '/linux/releases/29/Everything/aarch64/os/images/pxeboot'
>                        '/vmlinuz')
>          kernel_hash = '8c73e469fc6ea06a58dc83a628fc695b693b8493'
> -        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
> +                                       cancel_on_missing=True)
>
>          self.vm.set_console()
>          kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
> @@ -334,11 +343,13 @@ class BootLinuxConsole(LinuxKernelTest):
>                        '20101020ubuntu543.15/images/')
>          kernel_url = images_url + 'netboot/ubuntu-installer/arm64/linux'
>          kernel_hash = '5bfc54cf7ed8157d93f6e5b0241e727b6dc22c50'
> -        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
> +                                       cancel_on_missing=True)
>
>          initrd_url = images_url + 'netboot/ubuntu-installer/arm64/initrd.gz'
>          initrd_hash = 'd385d3e88d53e2004c5d43cbe668b458a094f772'
> -        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
> +        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash,
> +                                       cancel_on_missing=True)
>
>          self.vm.set_console()
>          self.vm.add_args('-m', '2G',
> @@ -356,7 +367,8 @@ class BootLinuxConsole(LinuxKernelTest):
>                        '/linux/releases/29/Everything/armhfp/os/images/pxeboot'
>                        '/vmlinuz')
>          kernel_hash = 'e9826d741b4fb04cadba8d4824d1ed3b7fb8b4d4'
> -        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
> +                                       cancel_on_missing=True)
>
>          self.vm.set_console()
>          kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
> @@ -378,12 +390,14 @@ class BootLinuxConsole(LinuxKernelTest):
>                       'Subbaraya-Sundeep/qemu-test-binaries/'
>                       'fe371d32e50ca682391e1e70ab98c2942aeffb01/u-boot')
>          uboot_hash = 'cbb8cbab970f594bf6523b9855be209c08374ae2'
> -        uboot_path = self.fetch_asset(uboot_url, asset_hash=uboot_hash)
> +        uboot_path = self.fetch_asset(uboot_url, asset_hash=uboot_hash,
> +                                      cancel_on_missing=True)
>          spi_url = ('https://raw.githubusercontent.com/'
>                     'Subbaraya-Sundeep/qemu-test-binaries/'
>                     'fe371d32e50ca682391e1e70ab98c2942aeffb01/spi.bin')
>          spi_hash = '65523a1835949b6f4553be96dec1b6a38fb05501'
> -        spi_path = self.fetch_asset(spi_url, asset_hash=spi_hash)
> +        spi_path = self.fetch_asset(spi_url, asset_hash=spi_hash,
> +                                    cancel_on_missing=True)
>
>          self.vm.set_console()
>          kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
> @@ -412,7 +426,8 @@ class BootLinuxConsole(LinuxKernelTest):
>                     'pool/main/r/raspberrypi-firmware/'
>                     'raspberrypi-kernel_1.20190215-1_armhf.deb')
>          deb_hash = 'cd284220b32128c5084037553db3c482426f3972'
> -        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash,
> +                                    cancel_on_missing=True)
>          kernel_path = self.extract_from_deb(deb_path, '/boot/kernel7.img')
>          dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2709-rpi-2-b.dtb')
>
> @@ -448,7 +463,8 @@ class BootLinuxConsole(LinuxKernelTest):
>                     '20190928T224601Z/pool/main/l/linux/'
>                     'linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb')
>          deb_hash = 'fa9df4a0d38936cb50084838f2cb933f570d7d82'
> -        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash,
> +                                    cancel_on_missing=True)
>          kernel_path = self.extract_from_deb(deb_path,
>                                              '/boot/vmlinuz-4.19.0-6-armmp')
>          dtb_path = '/usr/lib/linux-image-4.19.0-6-armmp/exynos4210-smdkv310.dtb'
> @@ -458,7 +474,8 @@ class BootLinuxConsole(LinuxKernelTest):
>                        '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
>                        'arm/rootfs-armv5.cpio.gz')
>          initrd_hash = '2b50f1873e113523967806f4da2afe385462ff9b'
> -        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
> +        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash,
> +                                          cancel_on_missing=True)
>          initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
>          archive.gzip_uncompress(initrd_path_gz, initrd_path)
>
> @@ -487,7 +504,8 @@ class BootLinuxConsole(LinuxKernelTest):
>          deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
>                     'linux-image-dev-sunxi_20.08_armhf.deb')
>          deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
> -        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash,
> +                                    cancel_on_missing=True)
>          kernel_path = self.extract_from_deb(deb_path,
>                                              '/boot/vmlinuz-5.8.0-sunxi')
>          dtb_path = '/usr/lib/linux-image-dev-sunxi/sun4i-a10-cubieboard.dtb'
> @@ -496,7 +514,8 @@ class BootLinuxConsole(LinuxKernelTest):
>                        '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
>                        'arm/rootfs-armv5.cpio.gz')
>          initrd_hash = '2b50f1873e113523967806f4da2afe385462ff9b'
> -        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
> +        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash,
> +                                          cancel_on_missing=True)
>          initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
>          archive.gzip_uncompress(initrd_path_gz, initrd_path)
>
> @@ -527,7 +546,8 @@ class BootLinuxConsole(LinuxKernelTest):
>          deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
>                     'linux-image-dev-sunxi_20.08_armhf.deb')
>          deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
> -        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash,
> +                                    cancel_on_missing=True)
>          kernel_path = self.extract_from_deb(deb_path,
>                                              '/boot/vmlinuz-5.8.0-sunxi')
>          dtb_path = '/usr/lib/linux-image-dev-sunxi/sun4i-a10-cubieboard.dtb'
> @@ -536,7 +556,8 @@ class BootLinuxConsole(LinuxKernelTest):
>                        '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
>                        'arm/rootfs-armv5.ext2.gz')
>          rootfs_hash = '093e89d2b4d982234bf528bc9fb2f2f17a9d1f93'
> -        rootfs_path_gz = self.fetch_asset(rootfs_url, asset_hash=rootfs_hash)
> +        rootfs_path_gz = self.fetch_asset(rootfs_url, asset_hash=rootfs_hash,
> +                                          cancel_on_missing=True)
>          rootfs_path = os.path.join(self.workdir, 'rootfs.cpio')
>          archive.gzip_uncompress(rootfs_path_gz, rootfs_path)
>
> @@ -570,7 +591,8 @@ class BootLinuxConsole(LinuxKernelTest):
>          deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
>                     'linux-image-dev-sunxi_20.08_armhf.deb')
>          deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
> -        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash,
> +                                    cancel_on_missing=True)
>          kernel_path = self.extract_from_deb(deb_path,
>                                              '/boot/vmlinuz-5.8.0-sunxi')
>          dtb_path = '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb'
> @@ -595,7 +617,8 @@ class BootLinuxConsole(LinuxKernelTest):
>          deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
>                     'linux-image-dev-sunxi_20.08_armhf.deb')
>          deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
> -        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash,
> +                                    cancel_on_missing=True)
>          kernel_path = self.extract_from_deb(deb_path,
>                                              '/boot/vmlinuz-5.8.0-sunxi')
>          dtb_path = '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb'
> @@ -604,7 +627,8 @@ class BootLinuxConsole(LinuxKernelTest):
>                        '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
>                        'arm/rootfs-armv7a.cpio.gz')
>          initrd_hash = '604b2e45cdf35045846b8bbfbf2129b1891bdc9c'
> -        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
> +        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash,
> +                                          cancel_on_missing=True)
>          initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
>          archive.gzip_uncompress(initrd_path_gz, initrd_path)
>
> @@ -638,7 +662,8 @@ class BootLinuxConsole(LinuxKernelTest):
>          deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
>                     'linux-image-dev-sunxi_20.08_armhf.deb')
>          deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
> -        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash,
> +                                    cancel_on_missing=True)
>          kernel_path = self.extract_from_deb(deb_path,
>                                              '/boot/vmlinuz-5.8.0-sunxi')
>          dtb_path = '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb'
> @@ -646,7 +671,8 @@ class BootLinuxConsole(LinuxKernelTest):
>          rootfs_url = ('http://storage.kernelci.org/images/rootfs/buildroot/'
>                        'kci-2019.02/armel/base/rootfs.ext2.xz')
>          rootfs_hash = '692510cb625efda31640d1de0a8d60e26040f061'
> -        rootfs_path_xz = self.fetch_asset(rootfs_url, asset_hash=rootfs_hash)
> +        rootfs_path_xz = self.fetch_asset(rootfs_url, asset_hash=rootfs_hash,
> +                                          cancel_on_missing=True)
>          rootfs_path = os.path.join(self.workdir, 'rootfs.cpio')
>          archive.lzma_uncompress(rootfs_path_xz, rootfs_path)
>          image_pow2ceil_expand(rootfs_path)
> @@ -693,7 +719,8 @@ class BootLinuxConsole(LinuxKernelTest):
>                       'Armbian_20.08.1_Orangepipc_bionic_current_5.8.5.img.xz')
>          image_hash = 'b4d6775f5673486329e45a0586bf06b6dbe792199fd182ac6b9c7bb6c7d3e6dd'
>          image_path_xz = self.fetch_asset(image_url, asset_hash=image_hash,
> -                                         algorithm='sha256')
> +                                         algorithm='sha256',
> +                                         cancel_on_missing=True)
>          image_path = archive.extract(image_path_xz, self.workdir)
>          image_pow2ceil_expand(image_path)
>
> @@ -734,7 +761,8 @@ class BootLinuxConsole(LinuxKernelTest):
>                     '20200108T145233Z/pool/main/u/u-boot/'
>                     'u-boot-sunxi_2020.01%2Bdfsg-1_armhf.deb')
>          deb_hash = 'f67f404a80753ca3d1258f13e38f2b060e13db99'
> -        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash,
> +                                    cancel_on_missing=True)
>          # We use the common OrangePi PC 'plus' build of U-Boot for our secondary
>          # program loader (SPL). We will then set the path to the more specific
>          # OrangePi "PC" device tree blob with 'setenv fdtfile' in U-Boot prompt,
> @@ -744,7 +772,8 @@ class BootLinuxConsole(LinuxKernelTest):
>          image_url = ('https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.0/'
>                       'evbarm-earmv7hf/binary/gzimg/armv7.img.gz')
>          image_hash = '2babb29d36d8360adcb39c09e31060945259917a'
> -        image_path_gz = self.fetch_asset(image_url, asset_hash=image_hash)
> +        image_path_gz = self.fetch_asset(image_url, asset_hash=image_hash,
> +                                         cancel_on_missing=True)
>          image_path = os.path.join(self.workdir, 'armv7.img')
>          archive.gzip_uncompress(image_path_gz, image_path)
>          image_pow2ceil_expand(image_path)
> @@ -796,7 +825,8 @@ class BootLinuxConsole(LinuxKernelTest):
>                        '/fedora-secondary/releases/29/Everything/s390x/os/images'
>                        '/kernel.img')
>          kernel_hash = 'e8e8439103ef8053418ef062644ffd46a7919313'
> -        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
> +                                       cancel_on_missing=True)
>
>          self.vm.set_console()
>          kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=sclp0'
> @@ -815,7 +845,8 @@ class BootLinuxConsole(LinuxKernelTest):
>          kernel_url = ('http://archive.debian.org/debian/dists/lenny/main/'
>                        'installer-alpha/20090123lenny10/images/cdrom/vmlinuz')
>          kernel_hash = '3a943149335529e2ed3e74d0d787b85fb5671ba3'
> -        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
> +                                       cancel_on_missing=True)
>
>          uncompressed_kernel = archive.uncompress(kernel_path, self.workdir)
>
> @@ -837,7 +868,8 @@ class BootLinuxConsole(LinuxKernelTest):
>                        '/fedora-secondary/releases/29/Everything/ppc64le/os'
>                        '/ppc/ppc64/vmlinuz')
>          kernel_hash = '3fe04abfc852b66653b8c3c897a59a689270bc77'
> -        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
> +                                       cancel_on_missing=True)
>
>          self.vm.set_console()
>          kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=hvc0'
> @@ -856,7 +888,8 @@ class BootLinuxConsole(LinuxKernelTest):
>                     '/20191021T083923Z/pool-m68k/main'
>                     '/l/linux/kernel-image-5.3.0-1-m68k-di_5.3.7-1_m68k.udeb')
>          deb_hash = '044954bb9be4160a3ce81f8bc1b5e856b75cccd1'
> -        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash,
> +                                    cancel_on_missing=True)
>          kernel_path = self.extract_from_deb(deb_path,
>                                              '/boot/vmlinux-5.3.0-1-m68k')
>
> @@ -874,7 +907,8 @@ class BootLinuxConsole(LinuxKernelTest):
>      def do_test_advcal_2018(self, day, tar_hash, kernel_name, console=0):
>          tar_url = ('https://www.qemu-advent-calendar.org'
>                     '/2018/download/day' + day + '.tar.xz')
> -        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash,
> +                                     cancel_on_missing=True)
>          archive.extract(file_path, self.workdir)
>          self.vm.set_console(console_index=console)
>          self.vm.add_args('-kernel',
> diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_initrd.py
> index a249e2f14a..d5e8e90cf9 100644
> --- a/tests/acceptance/linux_initrd.py
> +++ b/tests/acceptance/linux_initrd.py
> @@ -36,7 +36,8 @@ class LinuxInitrd(Test):
>          kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora/li'
>                        'nux/releases/18/Fedora/x86_64/os/images/pxeboot/vmlinuz')
>          kernel_hash = '41464f68efe42b9991250bed86c7081d2ccdbb21'
> -        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
> +                                       cancel_on_missing=True)
>          max_size = 2 * (1024 ** 3) - 1
>
>          with tempfile.NamedTemporaryFile() as initrd:
> @@ -63,7 +64,8 @@ class LinuxInitrd(Test):
>                        '/linux/releases/28/Everything/x86_64/os/images/pxeboot/'
>                        'vmlinuz')
>          kernel_hash = '238e083e114c48200f80d889f7e32eeb2793e02a'
> -        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
> +                                       cancel_on_missing=True)
>          max_size = 2 * (1024 ** 3) + 1
>
>          with tempfile.NamedTemporaryFile() as initrd:
> diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/linux_ssh_mips_malta.py
> index 25c5c5f741..e866a0b74e 100644
> --- a/tests/acceptance/linux_ssh_mips_malta.py
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -111,7 +111,8 @@ class LinuxSSH(Test):
>
>      def boot_debian_wheezy_image_and_ssh_login(self, endianess, kernel_path):
>          image_url, image_hash = self.get_image_info(endianess)
> -        image_path = self.fetch_asset(image_url, asset_hash=image_hash)
> +        image_path = self.fetch_asset(image_url, asset_hash=image_hash,
> +                                      cancel_on_missing=True)
>
>          self.vm.set_console()
>          kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
> @@ -204,7 +205,8 @@ class LinuxSSH(Test):
>      def check_mips_malta(self, uname_m, endianess):
>          wordsize = 64 if '64' in uname_m else 32
>          kernel_url, kernel_hash = self.get_kernel_info(endianess, wordsize)
> -        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
> +                                       cancel_on_missing=True)
>          self.boot_debian_wheezy_image_and_ssh_login(endianess, kernel_path)
>
>          stdout, _ = self.ssh_command('uname -a')
> diff --git a/tests/acceptance/machine_arm_canona1100.py b/tests/acceptance/machine_arm_canona1100.py
> index 0e5c43dbcf..dbf9d5a945 100644
> --- a/tests/acceptance/machine_arm_canona1100.py
> +++ b/tests/acceptance/machine_arm_canona1100.py
> @@ -26,7 +26,8 @@ class CanonA1100Machine(Test):
>          tar_url = ('https://www.qemu-advent-calendar.org'
>                     '/2018/download/day18.tar.xz')
>          tar_hash = '068b5fc4242b29381acee94713509f8a876e9db6'
> -        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash
> +                                     cancel_on_missing=True)
>          archive.extract(file_path, self.workdir)
>          self.vm.set_console()
>          self.vm.add_args('-bios',
> diff --git a/tests/acceptance/machine_arm_integratorcp.py b/tests/acceptance/machine_arm_integratorcp.py
> index 49c8ebff78..e795e95550 100644
> --- a/tests/acceptance/machine_arm_integratorcp.py
> +++ b/tests/acceptance/machine_arm_integratorcp.py
> @@ -37,12 +37,14 @@ class IntegratorMachine(Test):
>          kernel_url = ('https://github.com/zayac/qemu-arm/raw/master/'
>                        'arm-test/kernel/zImage.integrator')
>          kernel_hash = '0d7adba893c503267c946a3cbdc63b4b54f25468'
> -        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
> +                                       cancel_on_missing=True)
>
>          initrd_url = ('https://github.com/zayac/qemu-arm/raw/master/'
>                        'arm-test/kernel/arm_root.img')
>          initrd_hash = 'b51e4154285bf784e017a37586428332d8c7bd8b'
> -        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
> +        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash,
> +                                       cancel_on_missing=True)
>
>          self.vm.set_console()
>          self.vm.add_args('-kernel', kernel_path,
> @@ -76,7 +78,8 @@ class IntegratorMachine(Test):
>          tuxlogo_url = ('https://github.com/torvalds/linux/raw/v2.6.12/'
>                         'drivers/video/logo/logo_linux_vga16.ppm')
>          tuxlogo_hash = '3991c2ddbd1ddaecda7601f8aafbcf5b02dc86af'
> -        tuxlogo_path = self.fetch_asset(tuxlogo_url, asset_hash=tuxlogo_hash)
> +        tuxlogo_path = self.fetch_asset(tuxlogo_url, asset_hash=tuxlogo_hash,
> +                                        cancel_on_missing=True)
>
>          self.boot_integratorcp()
>          framebuffer_ready = 'Console: switching to colour frame buffer device'
> diff --git a/tests/acceptance/machine_arm_n8x0.py b/tests/acceptance/machine_arm_n8x0.py
> index e5741f2d8d..eed54a93e9 100644
> --- a/tests/acceptance/machine_arm_n8x0.py
> +++ b/tests/acceptance/machine_arm_n8x0.py
> @@ -24,7 +24,8 @@ class N8x0Machine(Test):
>                        'meego-arm-n8x0-1.0.80.20100712.1431-'
>                        'vmlinuz-2.6.35~rc4-129.1-n8x0')
>          kernel_hash = 'e9d5ab8d7548923a0061b6fbf601465e479ed269'
> -        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
> +                                       cancel_on_missing=True)
>
>          self.vm.set_console(console_index=1)
>          self.vm.add_args('-kernel', kernel_path,
> diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machine_avr6.py
> index 6baf4e9c7f..e1388eb665 100644
> --- a/tests/acceptance/machine_avr6.py
> +++ b/tests/acceptance/machine_avr6.py
> @@ -37,7 +37,8 @@ class AVR6Machine(Test):
>                     '/raw/36c3e67b8755dcf/free-rtos/Demo'
>                     '/AVR_ATMega2560_GCC/demo.elf')
>          rom_hash = '7eb521f511ca8f2622e0a3c5e8dd686efbb911d4'
> -        rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
> +        rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash,
> +                                    cancel_on_missing=True)
>
>          self.vm.add_args('-bios', rom_path)
>          self.vm.add_args('-nographic')
> diff --git a/tests/acceptance/machine_m68k_nextcube.py b/tests/acceptance/machine_m68k_nextcube.py
> index 32cf571f94..f0ff7143fe 100644
> --- a/tests/acceptance/machine_m68k_nextcube.py
> +++ b/tests/acceptance/machine_m68k_nextcube.py
> @@ -55,7 +55,8 @@ class NextCubeMachine(Test):
>          rom_url = ('http://www.nextcomputers.org/NeXTfiles/Software/ROM_Files/'
>                     '68040_Non-Turbo_Chipset/Rev_2.5_v66.BIN')
>          rom_hash = 'b3534796abae238a0111299fc406a9349f7fee24'
> -        rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
> +        rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash,
> +                                    cancel_on_missing=True)
>
>          self.vm.add_args('-bios', rom_path)
>          self.vm.launch()
> diff --git a/tests/acceptance/machine_mips_malta.py b/tests/acceptance/machine_mips_malta.py
> index 7c9a4ee4d2..347c4f8198 100644
> --- a/tests/acceptance/machine_mips_malta.py
> +++ b/tests/acceptance/machine_mips_malta.py
> @@ -49,14 +49,16 @@ class MaltaMachineFramebuffer(Test):
>                        'a5966ca4b5/mips/malta/mips64el/'
>                        'vmlinux-4.7.0-rc1.I6400.gz')
>          kernel_hash = '096f50c377ec5072e6a366943324622c312045f6'
> -        kernel_path_gz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path_gz = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
> +                                          cancel_on_missing=True)
>          kernel_path = self.workdir + "vmlinux"
>          archive.gzip_uncompress(kernel_path_gz, kernel_path)
>
>          tuxlogo_url = ('https://github.com/torvalds/linux/raw/v2.6.12/'
>                         'drivers/video/logo/logo_linux_vga16.ppm')
>          tuxlogo_hash = '3991c2ddbd1ddaecda7601f8aafbcf5b02dc86af'
> -        tuxlogo_path = self.fetch_asset(tuxlogo_url, asset_hash=tuxlogo_hash)
> +        tuxlogo_path = self.fetch_asset(tuxlogo_url, asset_hash=tuxlogo_hash,
> +                                        cancel_on_missing=True)
>
>          self.vm.set_console()
>          kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
> diff --git a/tests/acceptance/machine_rx_gdbsim.py b/tests/acceptance/machine_rx_gdbsim.py
> index 0c72506028..f876a3ec89 100644
> --- a/tests/acceptance/machine_rx_gdbsim.py
> +++ b/tests/acceptance/machine_rx_gdbsim.py
> @@ -32,7 +32,8 @@ class RxGdbSimMachine(Test):
>          """
>          uboot_url = ('https://acc.dl.osdn.jp/users/23/23888/u-boot.bin.gz')
>          uboot_hash = '9b78dbd43b40b2526848c0b1ce9de02c24f4dcdb'
> -        uboot_path = self.fetch_asset(uboot_url, asset_hash=uboot_hash)
> +        uboot_path = self.fetch_asset(uboot_url, asset_hash=uboot_hash,
> +                                      cancel_on_missing=True)
>          uboot_path = archive.uncompress(uboot_path, self.workdir)
>
>          self.vm.set_console()
> @@ -56,10 +57,12 @@ class RxGdbSimMachine(Test):
>          """
>          dtb_url = ('https://acc.dl.osdn.jp/users/23/23887/rx-virt.dtb')
>          dtb_hash = '7b4e4e2c71905da44e86ce47adee2210b026ac18'
> -        dtb_path = self.fetch_asset(dtb_url, asset_hash=dtb_hash)
> +        dtb_path = self.fetch_asset(dtb_url, asset_hash=dtb_hash,
> +                                    cancel_on_missing=True)
>          kernel_url = ('http://acc.dl.osdn.jp/users/23/23845/zImage')
>          kernel_hash = '39a81067f8d72faad90866ddfefa19165d68fc99'
> -        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
> +                                       cancel_on_missing=True)
>
>          self.vm.set_console()
>          kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'earlycon'
> diff --git a/tests/acceptance/machine_sparc64_sun4u.py b/tests/acceptance/machine_sparc64_sun4u.py
> index 458165500e..26e8cfd545 100644
> --- a/tests/acceptance/machine_sparc64_sun4u.py
> +++ b/tests/acceptance/machine_sparc64_sun4u.py
> @@ -27,7 +27,8 @@ class Sun4uMachine(LinuxKernelTest):
>          tar_url = ('https://www.qemu-advent-calendar.org'
>                     '/2018/download/day23.tar.xz')
>          tar_hash = '142db83cd974ffadc4f75c8a5cad5bcc5722c240'
> -        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash,
> +                                     cancel_on_missing=True)
>          archive.extract(file_path, self.workdir)
>          self.vm.set_console()
>          self.vm.add_args('-kernel', self.workdir + '/day23/vmlinux',
> diff --git a/tests/acceptance/machine_sparc_leon3.py b/tests/acceptance/machine_sparc_leon3.py
> index 2405cd7a0d..c6228d95a7 100644
> --- a/tests/acceptance/machine_sparc_leon3.py
> +++ b/tests/acceptance/machine_sparc_leon3.py
> @@ -26,7 +26,8 @@ class Leon3Machine(Test):
>          kernel_url = ('http://www.helenos.org/releases/'
>                        'HelenOS-0.6.0-sparc32-leon3.bin')
>          kernel_hash = 'a88c9cfdb8430c66650e5290a08765f9bf049a30'
> -        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
> +                                       cancel_on_missing=True)
>
>          self.vm.set_console()
>          self.vm.add_args('-kernel', kernel_path)
> diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_40p.py
> index 1515561249..edb7765cb6 100644
> --- a/tests/acceptance/ppc_prep_40p.py
> +++ b/tests/acceptance/ppc_prep_40p.py
> @@ -34,11 +34,13 @@ class IbmPrep40pMachine(Test):
>                      'ftp.software.ibm.com/rs6000/firmware/'
>                      '7020-40p/P12H0456.IMG')
>          bios_hash = '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
> -        bios_path = self.fetch_asset(bios_url, asset_hash=bios_hash)
> +        bios_path = self.fetch_asset(bios_url, asset_hash=bios_hash,
> +                                     cancel_on_missing=True)
>          drive_url = ('https://cdn.netbsd.org/pub/NetBSD/NetBSD-archive/'
>                       'NetBSD-4.0/prep/installation/floppy/generic_com0.fs')
>          drive_hash = 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
> -        drive_path = self.fetch_asset(drive_url, asset_hash=drive_hash)
> +        drive_path = self.fetch_asset(drive_url, asset_hash=drive_hash,
> +                                      cancel_on_missing=True)
>
>          self.vm.set_console()
>          self.vm.add_args('-bios', bios_path,
> @@ -71,7 +73,7 @@ class IbmPrep40pMachine(Test):
>                       'NetBSD-7.1.2-prep.iso')
>          drive_hash = 'ac6fa2707d888b36d6fa64de6e7fe48e'
>          drive_path = self.fetch_asset(drive_url, asset_hash=drive_hash,
> -                                      algorithm='md5')
> +                                      algorithm='md5', cancel_on_missing=True)
>          self.vm.set_console()
>          self.vm.add_args('-cdrom', drive_path,
>                           '-boot', 'd')
> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
> index 80a460814f..e0c9c19c92 100644
> --- a/tests/acceptance/replay_kernel.py
> +++ b/tests/acceptance/replay_kernel.py
> @@ -83,7 +83,8 @@ class ReplayKernel(LinuxKernelTest):
>                        '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
>                        '/vmlinuz')
>          kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
> -        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
> +                                       cancel_on_missing=True)
>
>          kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
>          console_pattern = 'VFS: Cannot open root device'
> @@ -100,7 +101,8 @@ class ReplayKernel(LinuxKernelTest):
>                        '/linux/releases/29/Everything/aarch64/os/images/pxeboot'
>                        '/vmlinuz')
>          kernel_hash = '8c73e469fc6ea06a58dc83a628fc695b693b8493'
> -        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
> +                                       cancel_on_missing=True)
>
>          kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
>                                 'console=ttyAMA0')
> @@ -118,7 +120,8 @@ class ReplayKernel(LinuxKernelTest):
>                        '/linux/releases/29/Everything/armhfp/os/images/pxeboot'
>                        '/vmlinuz')
>          kernel_hash = 'e9826d741b4fb04cadba8d4824d1ed3b7fb8b4d4'
> -        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
> +                                       cancel_on_missing=True)
>
>          kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
>                                 'console=ttyAMA0')
> @@ -136,6 +139,7 @@ class ReplayKernel(LinuxKernelTest):
>                     'linux-image-dev-sunxi_20.08_armhf.deb')
>          deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
>          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +                                    cancel_on_missing=True)
>          kernel_path = self.extract_from_deb(deb_path,
>                                              '/boot/vmlinuz-5.8.0-sunxi')
>          dtb_path = '/usr/lib/linux-image-dev-sunxi/sun4i-a10-cubieboard.dtb'
> @@ -144,7 +148,8 @@ class ReplayKernel(LinuxKernelTest):
>                        '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
>                        'arm/rootfs-armv5.cpio.gz')
>          initrd_hash = '2b50f1873e113523967806f4da2afe385462ff9b'
> -        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
> +        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash,
> +                                          cancel_on_missing=True)
>          initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
>          archive.gzip_uncompress(initrd_path_gz, initrd_path)
>
> @@ -167,7 +172,8 @@ class ReplayKernel(LinuxKernelTest):
>                        '/fedora-secondary/releases/29/Everything/ppc64le/os'
>                        '/ppc/ppc64/vmlinuz')
>          kernel_hash = '3fe04abfc852b66653b8c3c897a59a689270bc77'
> -        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash,
> +                                       cancel_on_missing=True)
>
>          kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=hvc0'
>          # icount is not good enough for PPC64 for complete boot yet
> @@ -183,7 +189,8 @@ class ReplayKernel(LinuxKernelTest):
>                     '/20191021T083923Z/pool-m68k/main'
>                     '/l/linux/kernel-image-5.3.0-1-m68k-di_5.3.7-1_m68k.udeb')
>          deb_hash = '044954bb9be4160a3ce81f8bc1b5e856b75cccd1'
> -        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash,
> +                                    cancel_on_missing=True)
>          kernel_path = self.extract_from_deb(deb_path,
>                                              '/boot/vmlinux-5.3.0-1-m68k')
>
> @@ -213,7 +220,8 @@ class ReplayKernel(LinuxKernelTest):
>          tar_hash = '32b7677ce8b6f1471fb0059865f451169934245b'
>          tar_url = ('https://www.qemu-advent-calendar.org'
>                     '/2018/download/day16.tar.xz')
> -        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash,
> +                                     cancel_on_missing=True)
>          dtb_path = self.workdir + '/day16/vexpress-v2p-ca9.dtb'
>          self.do_test_advcal_2018(file_path, 'winter.zImage',
>                                   args=('-dtb', dtb_path))
> @@ -226,7 +234,8 @@ class ReplayKernel(LinuxKernelTest):
>          tar_hash = 'ac688fd00561a2b6ce1359f9ff6aa2b98c9a570c'
>          tar_url = ('https://www.qemu-advent-calendar.org'
>                     '/2018/download/day07.tar.xz')
> -        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash,
> +                                     cancel_on_missing=True)
>          self.do_test_advcal_2018(file_path, 'sanity-clause.elf')
>
>      def test_microblaze_s3adsp1800(self):
> @@ -237,7 +246,8 @@ class ReplayKernel(LinuxKernelTest):
>          tar_hash = '08bf3e3bfb6b6c7ce1e54ab65d54e189f2caf13f'
>          tar_url = ('https://www.qemu-advent-calendar.org'
>                     '/2018/download/day17.tar.xz')
> -        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash,
> +                                     cancel_on_missing=True)
>          self.do_test_advcal_2018(file_path, 'ballerina.bin')
>
>      def test_ppc64_e500(self):
> @@ -249,7 +259,8 @@ class ReplayKernel(LinuxKernelTest):
>          tar_hash = '6951d86d644b302898da2fd701739c9406527fe1'
>          tar_url = ('https://www.qemu-advent-calendar.org'
>                     '/2018/download/day19.tar.xz')
> -        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash,
> +                                     cancel_on_missing=True)
>          self.do_test_advcal_2018(file_path, 'uImage', ('-cpu', 'e5500'))
>
>      def test_ppc_g3beige(self):
> @@ -260,7 +271,8 @@ class ReplayKernel(LinuxKernelTest):
>          tar_hash = 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
>          tar_url = ('https://www.qemu-advent-calendar.org'
>                     '/2018/download/day15.tar.xz')
> -        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash,
> +                                     cancel_on_missing=True)
>          self.do_test_advcal_2018(file_path, 'invaders.elf',
>                                   args=('-M', 'graphics=off'))
>
> @@ -272,7 +284,8 @@ class ReplayKernel(LinuxKernelTest):
>          tar_hash = 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
>          tar_url = ('https://www.qemu-advent-calendar.org'
>                     '/2018/download/day15.tar.xz')
> -        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash,
> +                                     cancel_on_missing=True)
>          self.do_test_advcal_2018(file_path, 'invaders.elf',
>                                   args=('-M', 'graphics=off'))
>
> @@ -284,7 +297,8 @@ class ReplayKernel(LinuxKernelTest):
>          tar_hash = 'b18550d5d61c7615d989a06edace051017726a9f'
>          tar_url = ('https://www.qemu-advent-calendar.org'
>                     '/2018/download/day11.tar.xz')
> -        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash,
> +                                     cancel_on_missing=True)
>          self.do_test_advcal_2018(file_path, 'zImage.elf')
>
>      def test_xtensa_lx60(self):
> @@ -296,6 +310,7 @@ class ReplayKernel(LinuxKernelTest):
>          tar_hash = '49e88d9933742f0164b60839886c9739cb7a0d34'
>          tar_url = ('https://www.qemu-advent-calendar.org'
>                     '/2018/download/day02.tar.xz')
> -        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash,
> +                                     cancel_on_missing=True)
>          self.do_test_advcal_2018(file_path, 'santas-sleigh-ride.elf',
>                                   args=('-cpu', 'dc233c'))
> --
> 2.25.4
>

Reviewed-by: Willian Rampazzo <willianr@redhat.com>


