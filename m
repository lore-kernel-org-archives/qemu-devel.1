Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E8DC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 20:30:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCC222ADA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 20:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDIAi8OD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCC222ADA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr6rM-00005s-34
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 16:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45061)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hr6r4-0007lr-Sb
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 16:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hr6r3-0004T9-96
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 16:30:18 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:38781)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hr6r1-0004Nl-AW; Fri, 26 Jul 2019 16:30:16 -0400
Received: by mail-lj1-x242.google.com with SMTP id r9so52667524ljg.5;
 Fri, 26 Jul 2019 13:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+hVrgHXtVjveEqE+x9eXFRy8gT0mFoAWFgoVy+YUdbw=;
 b=KDIAi8ODgnrRC9j3IUDQ9HxuYtAX+DVUwoCnIiEeSzs+fnzg4v0elZM4h0M8SU60Du
 ehoowTVR+V1oy0PJuAYsKqHICaxyHkA/qRyZ/uebMPHbkH3pIhfgkhhH1oJJtu2mlilH
 wE3VuLkhtK8ebIJBUOZYvzgIvMdN/V2KZ2+Fb54TD1tfL33fes9jQsUTemtC2Kw1ZE/u
 AZSU/bce5MA2uNYsbfr9+xNf5zGbvevOgEQ/lZ8QvGRpcGA2COinJaBp8xt0Bh7Tq41a
 ntDeP6OWcvLrDM1jj9dOvq0IiOiTe3R3+kAiWPXzOMUWpX+iRyy7RDf8rLPPiyOFdPWH
 6CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+hVrgHXtVjveEqE+x9eXFRy8gT0mFoAWFgoVy+YUdbw=;
 b=becJX8CtB4YgxbKbq74Gf1sS2nmA1n2SKV3CFUYB4wNHDgngmVks+kWRADVf3pNldq
 Nopizjp9hYcrupD/b2K14fcbtNpZRcttGuM9H2I84mQ1yplUuUdNtl/Y1RpA05aQObN9
 Z6Hr5whhFBVg4H90nCVNejpX3qQEYCigesXFlzpxJ9n+HskN7nnIU6GwLvVRsFACLpjz
 rzwiv4TzyADrlWMJzcNc28bJpAZBJIKoMb9lEjg0Ma0yfb0rmN3ymd0Eprf1MA1Zf+72
 lARaDFyqHW5jprf9/PsJGe1dVeMVs+wpBYHOwPUlgxRrTmVNMQROTsRvqXvr1Duo5H+S
 fS4A==
X-Gm-Message-State: APjAAAXZPnC+VBIqqAu3Ul97/Y/vNBv1SeLFtT0zUhFEzWj867H47amG
 MWqELgtNWp97CmmT1U/1ssIw94Zz5o0wKTJpzOE=
X-Google-Smtp-Source: APXvYqxa1BPgYjRmcVJobmB5xYAkpCoHDVA/fMLViQd8HINwKlZWRLeI73a8g4TCUdvwLUvs1dWH4Niu0NAtpwV4cEQ=
X-Received: by 2002:a2e:9758:: with SMTP id f24mr51106503ljj.58.1564173012146; 
 Fri, 26 Jul 2019 13:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <1563950742-22592-1-git-send-email-chihmin.chao@sifive.com>
 <CAKmqyKM2-60bn1v+bNsX6H+jZ-gTrsUwqah9yPtAn9VhZ2d1jw@mail.gmail.com>
 <CAEiOBXXqF4qkOsQX=wdt92ice5UUZGsubVEc-5qryLdFSesUjg@mail.gmail.com>
In-Reply-To: <CAEiOBXXqF4qkOsQX=wdt92ice5UUZGsubVEc-5qryLdFSesUjg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jul 2019 13:26:39 -0700
Message-ID: <CAKmqyKNnFOuSgy=cJsET2pqi2gCk8G7eWJ3HnQdrKUcsFL4SuA@mail.gmail.com>
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

On Fri, Jul 26, 2019 at 10:12 AM Chih-Min Chao <chihmin.chao@sifive.com> wrote:
>
>
>
> On Thu, Jul 25, 2019 at 8:12 AM Alistair Francis <alistair23@gmail.com> wrote:
>>
>> On Tue, Jul 23, 2019 at 11:46 PM Chih-Min Chao <chihmin.chao@sifive.com> wrote:
>> >
>> > Similar to the mips + malta test, it boots a Linux kernel on a virt
>> > board and verify the serial is working.  Also, it relies on the serial
>> > device set by the machine itself.
>> >
>> > If riscv64 is a target being built, "make check-acceptance" will
>> > automatically include this test by the use of the "arch:riscv64" tags.
>> >
>> > Alternatively, this test can be run using:
>> >
>> >   $ avocado run -t arch:riscv64 tests/acceptance
>> >
>> > packages
>> >   debian official
>> >     binutils-riscv64-linux-gnu_2.32-8
>> >     opensbi_0.4-1_all
>> >     linux-image-5.0.0-trunk-riscv64 5.0.2-1~exp1
>> >   third-party
>> >     https://github.com/groeck/linux-build-test/rootfs/riscv64/rootfs.cpio.gz
>> >     (the repo is also used in mips target acceptance)
>> >
>> > Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
>> > ---
>> >  .travis.yml                            |  2 +-
>> >  tests/acceptance/boot_linux_console.py | 67 ++++++++++++++++++++++++++++++++++
>> >  2 files changed, 68 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/.travis.yml b/.travis.yml
>> > index caf0a1f..7ba9952 100644
>> > --- a/.travis.yml
>> > +++ b/.travis.yml
>> > @@ -232,7 +232,7 @@ matrix:
>> >
>> >      # Acceptance (Functional) tests
>> >      - env:
>> > -        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu"
>> > +        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,riscv64-softmmu"
>> >          - TEST_CMD="make check-acceptance"
>> >        after_failure:
>> >          - cat tests/results/latest/job.log
>> > diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
>> > index 3215950..b0569b9 100644
>> > --- a/tests/acceptance/boot_linux_console.py
>> > +++ b/tests/acceptance/boot_linux_console.py
>> > @@ -354,3 +354,70 @@ class BootLinuxConsole(Test):
>> >          self.vm.launch()
>> >          console_pattern = 'Kernel command line: %s' % kernel_command_line
>> >          self.wait_for_console_pattern(console_pattern)
>> > +
>> > +    def test_riscv64_virt(self):
>> > +        """
>> > +        :avocado: tags=arch:riscv64
>> > +        :avocado: tags=machine:virt
>> > +        """
>> > +        deb_url = ('https://snapshot.debian.org/archive/debian/'
>> > +                         '20190424T171759Z/pool/main/b/binutils/'
>> > +                         'binutils-riscv64-linux-gnu_2.32-8_amd64.deb')
>> > +        deb_hash = ('7fe376fd4452696c03acd508d6d613ca553ea15e')
>> > +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>> > +        objcopy_path = '/usr/bin/riscv64-linux-gnu-objcopy'
>> > +        objcopy_path = self.extract_from_deb(deb_path, objcopy_path)
>> > +        libbfd_path = '/usr/lib/x86_64-linux-gnu/libbfd-2.32-riscv64.so'
>> > +        libbfd_path = self.extract_from_deb(deb_path, libbfd_path)
>> > +        process.run('ls -al %s' % (objcopy_path))
>>
>> Why do we need objcopy? Won't this not work on non x86 architectures?
>>
>> > +
>> > +        deb_url = ('https://snapshot.debian.org/archive/debian/'
>> > +                   '20190708T032337Z/pool/main/o/opensbi/'
>> > +                   'opensbi_0.4-1_all.deb')
>> > +        deb_hash = ('2319dcd702958291d323acf5649fd98a11d90112')
>> > +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>> > +        opensbi_path = ('/usr/lib/riscv64-linux-gnu/opensbi/'
>> > +                        'qemu/virt/fw_jump.elf')
>> > +        opensbi_path = self.extract_from_deb(deb_path, opensbi_path)
>> > +
>> > +        deb_url = ('https://snapshot.debian.org/archive/debian-ports/'
>> > +                   '20190319T205124Z/pool-riscv64/main/l/linux/'
>> > +                   'linux-image-5.0.0-trunk-riscv64_5.0.2-1~exp1_riscv64.deb')
>> > +        deb_hash = ('90155ed4b36673cbf7746a37cf3159c8f0b2857a')
>> > +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>> > +        kernel_path = '/boot/vmlinux-5.0.0-trunk-riscv64'
>>
>> I thought we were swapping to using an Image file?
>>
>> Alistair
>>
>
>   For objcopy,
>          Philippe had the same question in PATCH v2 thread.  Debian linux-kernel package only has vmlinux and riscv vmlinux  ELF header doesn't contain the correct physical loading address 0x8020_0000.
>           What I think is to extract the Image from vmlinux by objcopy.  This is what kernel do when generating  arch/riscv/boot/Image.

That is a real pain. I've never used Debian on RISC-V but that seems
strange that they don't build Image files. I think you should use a
Fedora kernel instead then.

>
>   For swapping to using an image file,
>          I think what you talk about is we have included opensbi.bin into qemu master ?

That has already happened, but you don't need it included.

Alistair

>          The reason is the test use -initrd and -append to pass rootfs and kernel command line option and the two options requires using of -kernel option.
>          But -kernel option can't load the opensbi.bin to expected address.
>
> chihmin
>
>>
>> > +        kernel_path = self.extract_from_deb(deb_path, kernel_path)
>> > +        kimage_path = self.workdir + "/Image"
>> > +        env = os.environ
>> > +        env['LD_LIBRARY_PATH'] = ('%s:' % (os.path.dirname(libbfd_path)) +
>> > +                                 env.get('LD_LIBRARY_PATH', ''))
>> > +        process.run(('%s -O binary -O binary -R'
>> > +                     '.note -R .note.gnu.build-id -R .comment -S %s %s') %
>> > +                     (objcopy_path, kernel_path, kimage_path))
>> > +
>> > +        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
>> > +                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
>> > +                      'riscv64/rootfs.cpio.gz')
>> > +        initrd_hash = 'f4867d263754961b6f626cdcdc0cb334c47e3b49'
>> > +        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
>> > +
>> > +        self.vm.set_machine('virt')
>> > +        self.vm.set_console()
>> > +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
>> > +                               + 'console=ttyS0 noreboot')
>> > +        self.vm.add_args('-bios', "none",
>> > +                '-kernel', opensbi_path,
>> > +                '-device', 'loader,file=%s,addr=0x80200000' % (kimage_path),
>> > +                '-initrd', initrd_path,
>> > +                '-append', kernel_command_line,
>> > +                '-no-reboot')
>> > +
>> > +        self.vm.launch()
>> > +        self.wait_for_console_pattern('Boot successful.')
>> > +
>> > +        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
>> > +                                               'isa')
>> > +        self.exec_command_and_wait_for_pattern('uname -a',
>> > +                                               'SMP Debian')
>> > +        self.exec_command_and_wait_for_pattern('reboot',
>> > +                                               'reboot: Restarting system')
>> > --
>> > 2.7.4
>> >
>> >

