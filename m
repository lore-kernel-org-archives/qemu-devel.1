Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CE5C76186
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 00:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF2921851
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 00:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/XWefTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF2921851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqRN1-0003SS-9p
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 20:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39283)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hqRMl-0002q6-QU
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 20:12:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hqRMk-0006Vq-Aw
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 20:12:15 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:36417)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hqRMk-0006Vk-2h; Wed, 24 Jul 2019 20:12:14 -0400
Received: by mail-lj1-x242.google.com with SMTP id i21so46236922ljj.3;
 Wed, 24 Jul 2019 17:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+hU/mP4YRBY/Im7LHw7YXUMtqSmCFaqUYDXdrY804x4=;
 b=X/XWefTq8gGINX3LULk+H1Bv+dFKF1rXotDjWoriZIokgXzOlqGG+4aVveCFS/Bce8
 TVmjtxbreVOlBdhq/0hXi+zbiQy8rE5zULxzvl+tIPLodr5BeVXfzKsd8hd3jI1V30Fe
 J9c4F65aONGfwYwpkvX9CN01BGGufRl6NiRQX1Kenipz6Eb28FTQRTLz9y/TKCnA57lB
 j9jaH5ZI9Z5niubRa4q0eryCAzbmhzXCuLxAsS3QcZ3RsF31zHh2IKng6RftupnqL8Mw
 W5MHYM6MnFwAfWjn3VS8WHhouPeVuz31If7WoGWpiazetGuxZm/ayob7nuk+SgbKZ+TE
 XVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+hU/mP4YRBY/Im7LHw7YXUMtqSmCFaqUYDXdrY804x4=;
 b=A28tW7WdPcHSkcd9u/o1SnnUxCiDfaJiytNt46Amujjn5Z/T+Wxz+rQerfNr6dq7PM
 y6pD8laXNw6sHgaCMOBAyQVlTptxBWrmk+Wpouy1XYq/lBIVnCm8rvRCt0qpxZOpxQRA
 uoKeYM8Dmyu1hWO4hecjqNl5e0KbJeemewAw00vqRMQKv5PJK0hvKnJQ9Jz1MGOP2P3h
 9a84YgRs1mrhTJoVNPQbEgQSgxmTP2jGSI3GSiqEIJWzqkp6CQ+K5uAy3iXbnQ9t8tb1
 MC6mPxGBe7WpxqMh08GALEWTYL71WLXCZurHDpLvEgOPjyrN5x2WCnSAwUBPj9KQzSOu
 53+w==
X-Gm-Message-State: APjAAAXyxQzrB5iy0dHExC3f1PTH1L40IiTC5oT2vMKC+NLwuiaKFrVO
 kBTt1zfEXMzV+mA6PAXOS+4FFEHt54n1ZbqbLZ4=
X-Google-Smtp-Source: APXvYqzOtXtRii9v8xl6tNKs2tg+gfb8oJIeKjEBmasDM6IL+MDaOouVJecNIxBhL0sJ7vMSIIaq6uebC0qJOToBCkc=
X-Received: by 2002:a2e:b4c9:: with SMTP id r9mr44405931ljm.196.1564013531879; 
 Wed, 24 Jul 2019 17:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <1563950742-22592-1-git-send-email-chihmin.chao@sifive.com>
In-Reply-To: <1563950742-22592-1-git-send-email-chihmin.chao@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 24 Jul 2019 17:08:37 -0700
Message-ID: <CAKmqyKM2-60bn1v+bNsX6H+jZ-gTrsUwqah9yPtAn9VhZ2d1jw@mail.gmail.com>
To: Chih-Min Chao <chihmin.chao@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v3] tests/boot_linux_console: add a test
 for riscv64 + virt
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
Cc: Fam Zheng <fam@euphon.net>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 23, 2019 at 11:46 PM Chih-Min Chao <chihmin.chao@sifive.com> wrote:
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
> packages
>   debian official
>     binutils-riscv64-linux-gnu_2.32-8
>     opensbi_0.4-1_all
>     linux-image-5.0.0-trunk-riscv64 5.0.2-1~exp1
>   third-party
>     https://github.com/groeck/linux-build-test/rootfs/riscv64/rootfs.cpio.gz
>     (the repo is also used in mips target acceptance)
>
> Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
> ---
>  .travis.yml                            |  2 +-
>  tests/acceptance/boot_linux_console.py | 67 ++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index caf0a1f..7ba9952 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -232,7 +232,7 @@ matrix:
>
>      # Acceptance (Functional) tests
>      - env:
> -        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu"
> +        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,riscv64-softmmu"
>          - TEST_CMD="make check-acceptance"
>        after_failure:
>          - cat tests/results/latest/job.log
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 3215950..b0569b9 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -354,3 +354,70 @@ class BootLinuxConsole(Test):
>          self.vm.launch()
>          console_pattern = 'Kernel command line: %s' % kernel_command_line
>          self.wait_for_console_pattern(console_pattern)
> +
> +    def test_riscv64_virt(self):
> +        """
> +        :avocado: tags=arch:riscv64
> +        :avocado: tags=machine:virt
> +        """
> +        deb_url = ('https://snapshot.debian.org/archive/debian/'
> +                         '20190424T171759Z/pool/main/b/binutils/'
> +                         'binutils-riscv64-linux-gnu_2.32-8_amd64.deb')
> +        deb_hash = ('7fe376fd4452696c03acd508d6d613ca553ea15e')
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +        objcopy_path = '/usr/bin/riscv64-linux-gnu-objcopy'
> +        objcopy_path = self.extract_from_deb(deb_path, objcopy_path)
> +        libbfd_path = '/usr/lib/x86_64-linux-gnu/libbfd-2.32-riscv64.so'
> +        libbfd_path = self.extract_from_deb(deb_path, libbfd_path)
> +        process.run('ls -al %s' % (objcopy_path))

Why do we need objcopy? Won't this not work on non x86 architectures?

> +
> +        deb_url = ('https://snapshot.debian.org/archive/debian/'
> +                   '20190708T032337Z/pool/main/o/opensbi/'
> +                   'opensbi_0.4-1_all.deb')
> +        deb_hash = ('2319dcd702958291d323acf5649fd98a11d90112')
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +        opensbi_path = ('/usr/lib/riscv64-linux-gnu/opensbi/'
> +                        'qemu/virt/fw_jump.elf')
> +        opensbi_path = self.extract_from_deb(deb_path, opensbi_path)
> +
> +        deb_url = ('https://snapshot.debian.org/archive/debian-ports/'
> +                   '20190319T205124Z/pool-riscv64/main/l/linux/'
> +                   'linux-image-5.0.0-trunk-riscv64_5.0.2-1~exp1_riscv64.deb')
> +        deb_hash = ('90155ed4b36673cbf7746a37cf3159c8f0b2857a')
> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> +        kernel_path = '/boot/vmlinux-5.0.0-trunk-riscv64'

I thought we were swapping to using an Image file?

Alistair

> +        kernel_path = self.extract_from_deb(deb_path, kernel_path)
> +        kimage_path = self.workdir + "/Image"
> +        env = os.environ
> +        env['LD_LIBRARY_PATH'] = ('%s:' % (os.path.dirname(libbfd_path)) +
> +                                 env.get('LD_LIBRARY_PATH', ''))
> +        process.run(('%s -O binary -O binary -R'
> +                     '.note -R .note.gnu.build-id -R .comment -S %s %s') %
> +                     (objcopy_path, kernel_path, kimage_path))
> +
> +        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
> +                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
> +                      'riscv64/rootfs.cpio.gz')
> +        initrd_hash = 'f4867d263754961b6f626cdcdc0cb334c47e3b49'
> +        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
> +
> +        self.vm.set_machine('virt')
> +        self.vm.set_console()
> +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
> +                               + 'console=ttyS0 noreboot')
> +        self.vm.add_args('-bios', "none",
> +                '-kernel', opensbi_path,
> +                '-device', 'loader,file=%s,addr=0x80200000' % (kimage_path),
> +                '-initrd', initrd_path,
> +                '-append', kernel_command_line,
> +                '-no-reboot')
> +
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Boot successful.')
> +
> +        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
> +                                               'isa')
> +        self.exec_command_and_wait_for_pattern('uname -a',
> +                                               'SMP Debian')
> +        self.exec_command_and_wait_for_pattern('reboot',
> +                                               'reboot: Restarting system')
> --
> 2.7.4
>
>

