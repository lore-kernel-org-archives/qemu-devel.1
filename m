Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77575C74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 18:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C6220838
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 18:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hE3qLOJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C6220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlHlm-0003Ip-O3
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 14:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53794)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hlHjG-0005U5-4n
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 14:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hlHjE-0003E8-8W
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 14:54:10 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:42582)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hlHjD-00032x-57; Wed, 10 Jul 2019 14:54:08 -0400
Received: by mail-lf1-x143.google.com with SMTP id s19so2315459lfb.9;
 Wed, 10 Jul 2019 11:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eZLYPg9RnRoxztz7McysZLtsI4n157cUMqea2jiRikQ=;
 b=hE3qLOJqY6j2FJRM/XkfXYu7iDUbUnqAs/bzCM51owZMuNp/+9B+jnZjR6cDF2nHhD
 B1zofnWQ2iDEUdnaaUHyKfM/I3IPTY8i39IBtu9VQv5zAeafEAQ6AOJa9Pn9uOLnum8w
 PU+68lTy0x7JnIu64JZoBmoVMcZjWXJOWva/kubcXFb8PbUOcu6klbCbCL1ANTeBOf9m
 wYUez073OprclnG2fMk1Gv7pA8vkjpfq4bcT3tY1PAYRAaIuRTxxOEBlUFwXRiV7aME7
 CbHvDCUpHR7qfBMjSPmakGicOWs5AuIOwsmjfAz3OCYb+Ct52I60+1AxMOzvJOlpt11w
 sEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eZLYPg9RnRoxztz7McysZLtsI4n157cUMqea2jiRikQ=;
 b=pOhsSyLZwPfxm1tbD4bfoAaxoRJ1vRzTBZ17Cr29A0WwSVjtzyUVdTclrbHEedV62x
 o6ZUR8ENtd4TYOXES6pZCbFT7SBtCXTtapbCfpt2LQLbDjYMMeRiLTIczGizw3BR6z4c
 3r7huF6LMW+TyaD8GbRlbcAN7R1VsPjvoWad8EGglirigIdt485jUh3iGKMllMCN4QOY
 ZajK1Hnc6XpZCCaBqO4MGvGOzOs85CRDsiLr0tPvV40CAT3br0pBro1+qEkhGSYYW2TU
 l35p/g/Lgh4uzT5XAtZBJMtUuDkGBvuadKdoqUVxY1LdMWQeQRrg1qkJqgnuClG67Rh+
 KnNQ==
X-Gm-Message-State: APjAAAUKlKEF51sfy00X6A8ig6ze9YvcpP/A6CwHt62tpvbx+Y8bWn4b
 maAvUhmg0eiDL/h1KN+sAcl3/o/ky102sMk5YZs=
X-Google-Smtp-Source: APXvYqxdM3LZbhSr0rkF0G18c5ZXu+W6RhL1K2ZRVXw10Tsf3y0Hm/sQkkgju/kCgrKTJn3RMXjDnu27UTW0yhmNs7U=
X-Received: by 2002:a19:6904:: with SMTP id e4mr4776090lfc.156.1562784835616; 
 Wed, 10 Jul 2019 11:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <1562781026-27570-1-git-send-email-chihmin.chao@sifive.com>
In-Reply-To: <1562781026-27570-1-git-send-email-chihmin.chao@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 10 Jul 2019 11:50:44 -0700
Message-ID: <CAKmqyKMHxX6dhopB8fxH31HGAQ3y-EvL+09jNvp3xMS-dxirQA@mail.gmail.com>
To: Chih-Min Chao <chihmin.chao@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH] tests/boot_linux_console: add a test for
 riscv64 + virt
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Caio Carrara <ccarrara@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 10, 2019 at 10:51 AM Chih-Min Chao <chihmin.chao@sifive.com> wrote:
>
> Similar to the mips + malta test, it boots a Linux kernel on a virt
> board and verify the serial is working.  Also, it relies on the serial
> device set by the machine itself.
>
> If riscv64 is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:riscv64" tags.
>
> Alternatively, this test can be run using:
>
>   $ avocado run -t arch:riscv64 tests/acceptance
>
> Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>

Awesome! Thanks for the test case. This will help a lot with RISC-V
regressions in QEMU.

> ---
>  tests/acceptance/boot_linux_console.py | 40 ++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 3215950..bbc6b06 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -354,3 +354,43 @@ class BootLinuxConsole(Test):
>          self.vm.launch()
>          console_pattern = 'Kernel command line: %s' % kernel_command_line
>          self.wait_for_console_pattern(console_pattern)
> +
> +    def test_riscv64_virt(self):
> +        """
> +        :avocado: tags=arch:riscv64
> +        :avocado: tags=machine:virt
> +        """
> +
> +        kernel_url = ('https://github.com/chihminchao/test-binary/raw/'

These images need to be built with a standard build flow. Having them
built from SiFive's custom scripts will make debugging problems in the
future impossible. I'm also a little worried here about GPL
violations, I'm not sure if it's enough to just point to a script SHA
to meet GPL source disclosure. I know companies have huge headaches
meeting GPL requirements so this seems too easy.

> +                      '0b7787305d9e40815c05a805266cc74ff356239e/qemu/riscv64/'
> +                      'bbl_w_kernel.gz')

Don't use BBL, most people use OpenSBI now which is what we should be
testing with.

> +        kernel_hash = 'c7f6cc7967975ad42dc61ee0535db01c9cbd0968'
> +        kernel_path_gz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        kernel_path = self.workdir + "bbl_w_kernel"
> +
> +        with gzip.open(kernel_path_gz, 'rb') as f_in:
> +            with open(kernel_path, 'wb') as f_out:
> +                shutil.copyfileobj(f_in, f_out)
> +
> +        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
> +                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
> +                      'riscv64/rootfs.cpio.gz')

Same comment about build tools.


Alistair

> +        initrd_hash = 'f4867d263754961b6f626cdcdc0cb334c47e3b49'
> +        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
> +
> +        self.vm.set_machine('virt')
> +        self.vm.set_console()
> +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
> +                               + 'console=ttyS0 noreboot')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-initrd', initrd_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Boot successful.')
> +
> +        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
> +                                               'isa')
> +        self.exec_command_and_wait_for_pattern('uname -a',
> +                                               'sifive')
> +        self.exec_command_and_wait_for_pattern('reboot',
> +                                               'reboot: Restarting system')
> --
> 2.7.4
>
>

