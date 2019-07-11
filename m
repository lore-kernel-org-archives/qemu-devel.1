Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52249C74A41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 02:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14DEA20844
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 02:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QCtCZqAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DEA20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlOPS-0000bG-6j
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 22:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47217)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1hlOOh-00007W-Nk
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 22:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1hlOOf-0003mv-Rl
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 22:01:23 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1hlOOf-0003kM-Gx
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 22:01:21 -0400
Received: by mail-wr1-x443.google.com with SMTP id y4so4439910wrm.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 19:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5TTaTki2tup5KxExleASJIms4bOIFX2L1BqPPpmqnOM=;
 b=QCtCZqAqabZpjWs/zVTXNEMHKHevkSYvPYfvLwJpjMSOBwOe11KXwXueRo9xvB0PFo
 LlhrCOyVJ0E0vl/c2u74TZVXZ9AxWqdR07bAjBp2WdF65fn9d/B6YsOmB6QiGLu1mIgi
 vzTZyjj+Xi1wJwJUDHD2WV9X7bOxTqEyuWwDYyeWkIv+znzHrQeUhs5TjnyYQKFQDGso
 Tnwz8PIbDaZm0WIpW9X8ZxrZnhQxFX37y0gh4hWgnNIskYoL6KjoZBw8XTxsx6JoxBD7
 EUwlcf+IW7EHbEgjD9iKk9Dvj2emKUy3wRijqI40SUsHuwlwK5O5d2yU07NznlKzr83X
 uu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5TTaTki2tup5KxExleASJIms4bOIFX2L1BqPPpmqnOM=;
 b=iJgasT22dpS+4H/OouEcsCXxH+KQxqSatZK5dQyzDpAnGPVnc2oQGcV8m9IoGXmbRk
 B4brbSFuEGINQjlt3a2SuLf2W5oknBXdosTNcThyfE0sMsmQXzM3qJzxzu5LAX2cN7g3
 hvepFVSv8+W55ImCjjrk9BWzljZci4gFCcapL9u/s4Ec9wcwckLbsjVCKdXAgyKgiv6T
 tNmB1xTGFHL1lDqixT6PVfUNwpG7PdETQwfzPN/whf5C6YCplXly+xG/wtWLDwC7vWzQ
 OybjpnexwBhiVVBygaSTCpU1Av+Rt6QlIp6je/g6l3sVbWMnd9E/WEkXgdM4yYNiSmEs
 JnRw==
X-Gm-Message-State: APjAAAVPS3m4zg3Ff56rVgcjsgELKU3JrJssoFaubhqO7SnXF1/van4g
 vgj2z3G+8dQWqAAf9JFVosQgqPTiNZmkf3SA3TzcFw==
X-Google-Smtp-Source: APXvYqxksc1c8xxY9m/ytOGIddZ9Dj1MGLCCOg027F783JJ699/Vs9P7Qgle5a5ROfkhKoQe7O8rV+M1HpnX+uBVekY=
X-Received: by 2002:a5d:5303:: with SMTP id e3mr704876wrv.239.1562810479679;
 Wed, 10 Jul 2019 19:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <1562781026-27570-1-git-send-email-chihmin.chao@sifive.com>
 <20190710202316.GA27117@localhost.localdomain>
In-Reply-To: <20190710202316.GA27117@localhost.localdomain>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Thu, 11 Jul 2019 10:01:08 +0800
Message-ID: <CAEiOBXUmPiaNwrrcMWCmu2BDt7iLM_vyDmSLWaEYX04rB-RUVw@mail.gmail.com>
To: Cleber Rosa <crosa@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Cornelia Huck <cohuck@redhat.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 11, 2019 at 4:23 AM Cleber Rosa <crosa@redhat.com> wrote:

> On Wed, Jul 10, 2019 at 10:50:23AM -0700, Chih-Min Chao wrote:
> > Similar to the mips + malta test, it boots a Linux kernel on a virt
> > board and verify the serial is working.  Also, it relies on the serial
> > device set by the machine itself.
> >
> > If riscv64 is a target being built, "make check-acceptance" will
> > automatically include this test by the use of the "arch:riscv64" tags.
> >
> > Alternatively, this test can be run using:
> >
> >   $ avocado run -t arch:riscv64 tests/acceptance
> >
> > Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
> > ---
> >  tests/acceptance/boot_linux_console.py | 40
> ++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/tests/acceptance/boot_linux_console.py
> b/tests/acceptance/boot_linux_console.py
> > index 3215950..bbc6b06 100644
> > --- a/tests/acceptance/boot_linux_console.py
> > +++ b/tests/acceptance/boot_linux_console.py
> > @@ -354,3 +354,43 @@ class BootLinuxConsole(Test):
> >          self.vm.launch()
> >          console_pattern = 'Kernel command line: %s' %
> kernel_command_line
> >          self.wait_for_console_pattern(console_pattern)
> > +
> > +    def test_riscv64_virt(self):
> > +        """
> > +        :avocado: tags=arch:riscv64
> > +        :avocado: tags=machine:virt
> > +        """
> > +
> > +        kernel_url = ('https://github.com/chihminchao/test-binary/raw/'
> > +
> '0b7787305d9e40815c05a805266cc74ff356239e/qemu/riscv64/'
> > +                      'bbl_w_kernel.gz')
> > +        kernel_hash = 'c7f6cc7967975ad42dc61ee0535db01c9cbd0968'
> > +        kernel_path_gz = self.fetch_asset(kernel_url,
> asset_hash=kernel_hash)
> > +        kernel_path = self.workdir + "bbl_w_kernel"
> > +
> > +        with gzip.open(kernel_path_gz, 'rb') as f_in:
> > +            with open(kernel_path, 'wb') as f_out:
> > +                shutil.copyfileobj(f_in, f_out)
>
> There are currently two patterns for extracting a gzipped file
> in this test.  So, this is not a must, but maybe you'd prefer:
>

  The suggestion is good and avocado is an awesome testing framework.

---
> diff --git a/tests/acceptance/boot_linux_console.py
> b/tests/acceptance/boot_linux_console.py
> index bbc6b0683f..9f819e20e1 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -365,12 +365,8 @@ class BootLinuxConsole(Test):
>
>  '0b7787305d9e40815c05a805266cc74ff356239e/qemu/riscv64/'
>                        'bbl_w_kernel.gz')
>          kernel_hash = 'c7f6cc7967975ad42dc61ee0535db01c9cbd0968'
> -        kernel_path_gz = self.fetch_asset(kernel_url,
> asset_hash=kernel_hash)
> -        kernel_path = self.workdir + "bbl_w_kernel"
> -
> -        with gzip.open(kernel_path_gz, 'rb') as f_in:
> -            with open(kernel_path, 'wb') as f_out:
> -                shutil.copyfileobj(f_in, f_out)
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +        uncompressed_kernel = archive.uncompress(kernel_path,
> self.workdir)
>
>          initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
>                        '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
> @@ -382,7 +378,7 @@ class BootLinuxConsole(Test):
>          self.vm.set_console()
>          kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
>                                 + 'console=ttyS0 noreboot')
> -        self.vm.add_args('-kernel', kernel_path,
> +        self.vm.add_args('-kernel', uncompressed_kernel,
>                           '-initrd', initrd_path,
>                           '-append', kernel_command_line)
>          self.vm.launch()
> ---
>
> > +
> > +        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
> > +                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
> > +                      'riscv64/rootfs.cpio.gz')
> > +        initrd_hash = 'f4867d263754961b6f626cdcdc0cb334c47e3b49'
> > +        initrd_path = self.fetch_asset(initrd_url,
> asset_hash=initrd_hash)
> > +
> > +        self.vm.set_machine('virt')
> > +        self.vm.set_console()
> > +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
> > +                               + 'console=ttyS0 noreboot')
> > +        self.vm.add_args('-kernel', kernel_path,
> > +                         '-initrd', initrd_path,
> > +                         '-append', kernel_command_line)
> > +        self.vm.launch()
> > +        self.wait_for_console_pattern('Boot successful.')
> > +
> > +        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
> > +                                               'isa')
> > +        self.exec_command_and_wait_for_pattern('uname -a',
> > +                                               'sifive')
> > +        self.exec_command_and_wait_for_pattern('reboot',
> > +                                               'reboot: Restarting
> system')
> > --
> > 2.7.4
> >
> >
>
> It'd be nice to also add riscv64 to the target list in .travis.yaml
> "acceptance tests" job.
>
> Regards and many thanks for this contribution!
> - Cleber.
>
