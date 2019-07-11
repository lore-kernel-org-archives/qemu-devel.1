Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C820FC74A56
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A22621019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDH73BpZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A22621019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlaHz-0004fE-LG
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 10:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38211)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hlaHE-000486-6g
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hlaHC-0002Br-PC
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:42:28 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:39863)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hlaHC-00027U-Ep; Thu, 11 Jul 2019 10:42:26 -0400
Received: by mail-lf1-x142.google.com with SMTP id v85so4239061lfa.6;
 Thu, 11 Jul 2019 07:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NBEGWgpWeqo8cs4hEVmc/ODFyB/v0FS0EPbJT2KuAw0=;
 b=iDH73BpZKApFELe4+C0kBN/4KiyJkAwJaybBMkwy+z8TnBSCTo7tO6LGy/us0BXega
 ePjRnJjJd53kMaGTQy2lbIzwJt72HHvk2zfVbaWuV32PbGLHK8rEdMKBurAvRVhcwlre
 OxGd7n4orOIFtCf2Q4ZfiJ3CJmsFcoSG305Dzc2LgvzUwgY8EOhAY5Csguzlokzc0hJq
 vdsHYJD62bkKhkmYi/IZRTl6eVFIrWM2QQENV3+WaiIkUvgF5CI/UXe9PDxiBkm2zrOc
 lcbED95f3XT+SkviIc3oJ4FYSExh3sL1mka0OEu+GDzKnkLMg6tn4K6nNgSIXDAMZIkW
 5oKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NBEGWgpWeqo8cs4hEVmc/ODFyB/v0FS0EPbJT2KuAw0=;
 b=X0zrLKeRoR4jdidhnKVsWR6zuvYy+4EmMYoA239iWerY16mG3vVJPl+4y4NVZJap2g
 NkCj8VCwHV0MwRFqly1rgOKqBpfaaNdcl0ff0jkEiSDR6jNa/UJVKnZiHUw41Qh8uZFw
 0x0UK7FZsJ+o5L0cJlSrP7BAWm1+RBw0rz70hEpEZ4fn/QVM/RwIX2ySkUa6Mqb8evyX
 45PIjQnq0SFLFy9bdYZSWxmNz3Cm16h4uinTd8m2E/SgcC76kD+/RR4ukOrLixSw03Nq
 EfoektoqnWXCqxieHDt+rGase4tlYZtEbChE3VZiow66XO6yre6Xl0QOOUJq9z2Kf+kv
 ZGpQ==
X-Gm-Message-State: APjAAAWSx/6zW4POPTdBdRUSwNmUAuDeX852MKS72xOyO3Q9+ZNXllAg
 7ExHv6llXBJd81ATtnL1GYEnbS5y+ZzQK5SBkpM=
X-Google-Smtp-Source: APXvYqyCtGkHEHuqlkaAUYiK+CbSwhimP7XbmLvPA4otqJGkGZOZGAsdDLl8I81yd1FsJwtPLFFMVWUwCC7AbXiYoBo=
X-Received: by 2002:a05:6512:29a:: with SMTP id
 j26mr2071961lfp.44.1562856143876; 
 Thu, 11 Jul 2019 07:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <1562781026-27570-1-git-send-email-chihmin.chao@sifive.com>
 <CAKmqyKMHxX6dhopB8fxH31HGAQ3y-EvL+09jNvp3xMS-dxirQA@mail.gmail.com>
 <CAEiOBXUZ51h165GMEJEyDhToD2op7Z6S86B+Wnt9taZ3Q2iGfA@mail.gmail.com>
In-Reply-To: <CAEiOBXUZ51h165GMEJEyDhToD2op7Z6S86B+Wnt9taZ3Q2iGfA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 11 Jul 2019 07:41:57 -0700
Message-ID: <CAKmqyKOPEASD7QEhNm5pRSKb2mDcUwg2=ik8B2UUQ_ddbypSJA@mail.gmail.com>
To: Chih-Min Chao <chihmin.chao@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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

On Wed, Jul 10, 2019 at 6:54 PM Chih-Min Chao <chihmin.chao@sifive.com> wrote:
>
>
> On Thu, Jul 11, 2019 at 2:53 AM Alistair Francis <alistair23@gmail.com> wrote:
>>
>> On Wed, Jul 10, 2019 at 10:51 AM Chih-Min Chao <chihmin.chao@sifive.com> wrote:
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
>> > Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
>>
>> Awesome! Thanks for the test case. This will help a lot with RISC-V
>> regressions in QEMU.
>>
>> > ---
>> >  tests/acceptance/boot_linux_console.py | 40 ++++++++++++++++++++++++++++++++++
>> >  1 file changed, 40 insertions(+)
>> >
>> > diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
>> > index 3215950..bbc6b06 100644
>> > --- a/tests/acceptance/boot_linux_console.py
>> > +++ b/tests/acceptance/boot_linux_console.py
>> > @@ -354,3 +354,43 @@ class BootLinuxConsole(Test):
>> >          self.vm.launch()
>> >          console_pattern = 'Kernel command line: %s' % kernel_command_line
>> >          self.wait_for_console_pattern(console_pattern)
>> > +
>> > +    def test_riscv64_virt(self):
>> > +        """
>> > +        :avocado: tags=arch:riscv64
>> > +        :avocado: tags=machine:virt
>> > +        """
>> > +
>> > +        kernel_url = ('https://github.com/chihminchao/test-binary/raw/'
>>
>> These images need to be built with a standard build flow. Having them
>> built from SiFive's custom scripts will make debugging problems in the
>> future impossible. I'm also a little worried here about GPL
>> violations, I'm not sure if it's enough to just point to a script SHA
>> to meet GPL source disclosure. I know companies have huge headaches
>> meeting GPL requirements so this seems too easy.
>
>
>    I am not very familiar with this kind of binary and source license conflict.

Thinking about it more you probably are ok with a SHA to a build tool.
I guess companies do all the extra work and vetting just to be extra
sure. So how much you do I guess is up to you ad SiFive.

>    Is it ok if I write a simple script with BSD license to build  kernel and image from sifive's linux/buildroot repo and commit the script to my test-binary repo ?

No, it must be built from an upstream repo. Others need to be able to
reproduce this in the future. You can just use upstream buildroot and
include a config. Ideally as well use a projects release instead of
some random SHA.

>>
>>
>> > +                      '0b7787305d9e40815c05a805266cc74ff356239e/qemu/riscv64/'
>> > +                      'bbl_w_kernel.gz')
>>
>> Don't use BBL, most people use OpenSBI now which is what we should be
>> testing with.
>
>    I will try to move to OpenSBI in next version. My environment is based freedom-u-sdk and It still relays  on BBL. So ..:P

Swap to an upstream distro, I think they all support OpenSBI now.
Buildroot and OE/Yocto both give you development environments and
Fedora and Debian work as well.

Alistair

>>
>>
>> > +        kernel_hash = 'c7f6cc7967975ad42dc61ee0535db01c9cbd0968'
>> > +        kernel_path_gz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>> > +        kernel_path = self.workdir + "bbl_w_kernel"
>> > +
>> > +        with gzip.open(kernel_path_gz, 'rb') as f_in:
>> > +            with open(kernel_path, 'wb') as f_out:
>> > +                shutil.copyfileobj(f_in, f_out)
>> > +
>> > +        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
>> > +                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
>> > +                      'riscv64/rootfs.cpio.gz')
>>
>> Same comment about build tools.
>>
>>
>> Alistair
>>
>     Got it
>>
>> > +        initrd_hash = 'f4867d263754961b6f626cdcdc0cb334c47e3b49'
>> > +        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
>> > +
>> > +        self.vm.set_machine('virt')
>> > +        self.vm.set_console()
>> > +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
>> > +                               + 'console=ttyS0 noreboot')
>> > +        self.vm.add_args('-kernel', kernel_path,
>> > +                         '-initrd', initrd_path,
>> > +                         '-append', kernel_command_line)
>> > +        self.vm.launch()
>> > +        self.wait_for_console_pattern('Boot successful.')
>> > +
>> > +        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
>> > +                                               'isa')
>> > +        self.exec_command_and_wait_for_pattern('uname -a',
>> > +                                               'sifive')
>> > +        self.exec_command_and_wait_for_pattern('reboot',
>> > +                                               'reboot: Restarting system')
>> > --
>> > 2.7.4
>> >
>> >

