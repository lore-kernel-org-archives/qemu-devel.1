Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCBAC7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 17:11:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D930208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 17:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="m/yWC2vy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D930208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho9wD-0000Ze-PK
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 13:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49710)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1ho9vt-0007u1-Fa
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 13:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1ho9vp-00075x-RA
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 13:11:05 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:41690)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1ho9vp-00074P-Co
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 13:11:01 -0400
Received: by mail-wr1-x42a.google.com with SMTP id c2so26322922wrm.8
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 10:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Yve9q6kG1WafFci2C5jbq9bEgYy7depfKs+qbBM2eQk=;
 b=m/yWC2vyUCRYITZHdTNskUKqLGJ08V3ojj5BMXmuBm9vNCQF7QikLckrrK+FipP3iU
 wSwdff1OwXb1FCmwES6l2zIk1cJ6TPhKrch7jm83C4KIX/24GnlQdKSh/frjDyXcloPf
 decSToARfjJAsU77fw8wR2nSz+HxTAPhOIIXiOVvhHz8I0LX79ORHZNmHK163UpF/tI5
 xQtdKmcGLPr78mh5r2ctrQd30geefRJo43wHc5cJG9RPRf2xp3kVh8waLWdlhZEoc+kS
 fn+Xv5WKJ4xJOlMSK9UE8DT5yBu3vmQe/6TfVokMJoUSxo5MfQqMbXeYwCnaER+A83lT
 mk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Yve9q6kG1WafFci2C5jbq9bEgYy7depfKs+qbBM2eQk=;
 b=FnUe41+UWkiWL3m7hVMD0tN0q1ZCsf9UjSiUo56VYnQnOm3KijdRVyR+M4GJiGScGg
 6z3uxdWBwffDtAxdnEouFFBb5MpxdBnYeMVEUUCQ9Dow5ASbs0MiEVzf9vNoa1pDWMqW
 M2hbNkYoVB2I9xODqQQi/8nwPJfFuK4dWbJ9Tx6sCGFiYvtni79yvl7my/+WlwzX6pWx
 v6pBUb74pZ5Pu5pRx9a6a4ylUlPMvStovhfNYZaw7f+VgL3DW0tx/R5V8cH8Uho2bONR
 sAMLHvWrTB06orA0u5rMXRV7u5TI8GE9FNPzu48OKJ54PqkKTpUi0GrHMQzDpLCewfm4
 q2nw==
X-Gm-Message-State: APjAAAUO5ojqnlUe34+o0sVI1QoLlkiZliGrAF1poZxHN/vk61Fch3YX
 BWg3CRCKG+gsclfQbzfMsBu3ytUOqv6I1DdmgyYM6w==
X-Google-Smtp-Source: APXvYqyHfSg8IhYCzgKL3EQbx5hBWhysqeOsCWpfYdTCkz6ia4Bx8fNFzGVOlm9VKltmoWwQVZiuybVEgCxPSsjIMMQ=
X-Received: by 2002:adf:de90:: with SMTP id w16mr15282005wrl.217.1563469859904; 
 Thu, 18 Jul 2019 10:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <1563181721-5055-1-git-send-email-chihmin.chao@sifive.com>
 <93b35a5e-c40a-535b-2a91-2c210b4a5928@redhat.com>
 <CAEiOBXXxS-93rTAQuvY_Tkxi1pYc1YfJenpBC_8gG2ou9uUZMg@mail.gmail.com>
 <7eb239bc-32aa-b5fc-ab2e-a741b005aad7@redhat.com>
 <CAKmqyKOZSz4f1-kLDhn=+imCvKHcZJVgqgqWbQ6qxD3K1n17GA@mail.gmail.com>
 <CAEiOBXUBPFx5__wOLvLD0qQ7dzV2XVpHfiOoBZpXpu-SZsMiUg@mail.gmail.com>
 <CAKmqyKNOiRYqZgiWT+LUKkOv+Bew3djOqc9vHpmSqZ-1Gfjd8Q@mail.gmail.com>
 <d2c7e6c6-4d4a-d47e-e496-4f4cfe466fe1@redhat.com>
 <CAKmqyKPiDHrPVuz2P1n9_j170k2bSm=7uDKrQg-fAUhL1FQm9g@mail.gmail.com>
 <CAEiOBXUXdyntjnt-bi9-wiO2mmpgVC8WpD9KnxWoDdP__71XXQ@mail.gmail.com>
 <CAKmqyKOHfx+h8=x2OnvyDD5LnqO09Uk56doqnkBY0VDcEbxQpA@mail.gmail.com>
 <CAEiOBXXMRXEEdp27c0C6RpxLQFW7BYdTDsoR5pRyxf=m74A5Kg@mail.gmail.com>
 <CAKmqyKPP8Y9SP8xHgA2N1n5wLmmaoXuK1GBBA7_G90rZJP5x8A@mail.gmail.com>
In-Reply-To: <CAKmqyKPP8Y9SP8xHgA2N1n5wLmmaoXuK1GBBA7_G90rZJP5x8A@mail.gmail.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Fri, 19 Jul 2019 01:10:48 +0800
Message-ID: <CAEiOBXXsEkXEDsv8pUQM8_mNfAm=6xOeODca+gLrKUYKv+Zqag@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2] tests/boot_linux_console: add a test
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
Cc: Fam Zheng <fam@euphon.net>, Cornelia Huck <cohuck@redhat.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 18, 2019 at 11:34 PM Alistair Francis <alistair23@gmail.com>
wrote:

> On Thu, Jul 18, 2019 at 8:00 AM Chih-Min Chao <chihmin.chao@sifive.com>
> wrote:
> >
> >
> >
> > On Thu, Jul 18, 2019 at 6:47 AM Alistair Francis <alistair23@gmail.com>
> wrote:
> >>
> >> On Tue, Jul 16, 2019 at 10:21 PM Chih-Min Chao <chihmin.chao@sifive.co=
m>
> wrote:
> >> >
> >> >
> >> >
> >> > On Wed, Jul 17, 2019 at 6:59 AM Alistair Francis <
> alistair23@gmail.com> wrote:
> >> >>
> >> >> On Tue, Jul 16, 2019 at 2:50 PM Philippe Mathieu-Daud=C3=A9
> >> >> <philmd@redhat.com> wrote:
> >> >> >
> >> >> > On 7/16/19 10:43 PM, Alistair Francis wrote:
> >> >> > > On Tue, Jul 16, 2019 at 6:56 AM Chih-Min Chao <
> chihmin.chao@sifive.com> wrote:
> >> >> > >>
> >> >> > >>
> >> >> > >> On Tue, Jul 16, 2019 at 12:34 AM Alistair Francis <
> alistair23@gmail.com> wrote:
> >> >> > >>>
> >> >> > >>> On Mon, Jul 15, 2019 at 6:02 AM Philippe Mathieu-Daud=C3=A9
> >> >> > >>> <philmd@redhat.com> wrote:
> >> >> > >>>>
> >> >> > >>>> On 7/15/19 1:09 PM, Chih-Min Chao wrote:
> >> >> > >>>>> On Mon, Jul 15, 2019 at 5:15 PM Philippe Mathieu-Daud=C3=A9
> >> >> > >>>>> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> >> >> > >>>>>
> >> >> > >>>>>     On 7/15/19 11:08 AM, Chih-Min Chao wrote:
> >> >> > >>>>>     > Similar to the mips + malta test, it boots a Linux
> kernel on a virt
> >> >> > >>>>>     > board and verify the serial is working.  Also, it
> relies on the serial
> >> >> > >>>>>     > device set by the machine itself.
> >> >> > >>>>>     >
> >> >> > >>>>>     > If riscv64 is a target being built, "make
> check-acceptance" will
> >> >> > >>>>>     > automatically include this test by the use of the
> "arch:riscv64" tags.
> >> >> > >>>>>     >
> >> >> > >>>>>     > Alternatively, this test can be run using:
> >> >> > >>>>>     >
> >> >> > >>>>>     >   $ avocado run -t arch:riscv64 tests/acceptance
> >> >> > >>>>>     >
> >> >> > >>>>>     > packages
> >> >> > >>>>>     >   debian official
> >> >> > >>>>>     >     binutils-riscv64-linux-gnu_2.32-8
> >> >> > >>>>>     >     opensbi_0.4-1_all
> >> >> > >>>>>     >     linux-image-4.19.0-5-riscv64 4.19.37-4
> >> >> > >>>>>     >   third-party
> >> >> > >>>>>     >
> >> >> > >>>>>
> https://github.com/groeck/linux-build-test/rootfs/riscv64/rootfs.cpio.gz
> >> >> > >>>>>     >     (the repo is also used in mips target acceptance)
> >> >> > >>>>>     >
> >> >> > >>>>>     > Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com
> >> >> > >>>>>     <mailto:chihmin.chao@sifive.com>>
> >> >> > >>>>>     > ---
> >> >> > >>>>>     >  .travis.yml                            |  2 +-
> >> >> > >>>>>     >  tests/acceptance/boot_linux_console.py | 66
> >> >> > >>>>>     ++++++++++++++++++++++++++++++++++
> >> >> > >>>>>     >  2 files changed, 67 insertions(+), 1 deletion(-)
> >> >> > >>>>>     >
> >> >> > >>>>>     > diff --git a/.travis.yml b/.travis.yml
> >> >> > >>>>>     > index 5d3d6ee..21fcead 100644
> >> >> > >>>>>     > --- a/.travis.yml
> >> >> > >>>>>     > +++ b/.travis.yml
> >> >> > >>>>>     > @@ -232,7 +232,7 @@ matrix:
> >> >> > >>>>>     >
> >> >> > >>>>>     >      # Acceptance (Functional) tests
> >> >> > >>>>>     >      - env:
> >> >> > >>>>>     > -        - CONFIG=3D"--python=3D/usr/bin/python3
> >> >> > >>>>>
>  --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-sof=
tmmu,arm-softmmu,s390x-softmmu,alpha-softmmu"
> >> >> > >>>>>     > +        - CONFIG=3D"--python=3D/usr/bin/python3
> >> >> > >>>>>
>  --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-sof=
tmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,riscv64-softmmu"
> >> >> > >>>>>     >          - TEST_CMD=3D"make check-acceptance"
> >> >> > >>>>>     >        after_failure:
> >> >> > >>>>>     >          - cat tests/results/latest/job.log
> >> >> > >>>>>     > diff --git a/tests/acceptance/boot_linux_console.py
> >> >> > >>>>>     b/tests/acceptance/boot_linux_console.py
> >> >> > >>>>>     > index 3215950..0f638bc 100644
> >> >> > >>>>>     > --- a/tests/acceptance/boot_linux_console.py
> >> >> > >>>>>     > +++ b/tests/acceptance/boot_linux_console.py
> >> >> > >>>>>     > @@ -354,3 +354,69 @@ class BootLinuxConsole(Test):
> >> >> > >>>>>     >          self.vm.launch()
> >> >> > >>>>>     >          console_pattern =3D 'Kernel command line: %s=
' %
> >> >> > >>>>>     kernel_command_line
> >> >> > >>>>>     >          self.wait_for_console_pattern(console_patter=
n)
> >> >> > >>>>>     > +
> >> >> > >>>>>     > +    def test_riscv64_virt(self):
> >> >> > >>>>>     > +        """
> >> >> > >>>>>     > +        :avocado: tags=3Darch:riscv64
> >> >> > >>>>>     > +        :avocado: tags=3Dmachine:virt
> >> >> > >>>>>     > +        """
> >> >> > >>>>>     > +        deb_url =3D ('
> https://snapshot.debian.org/archive/debian/'
> >> >> > >>>>>     > +
>  '20190424T171759Z/pool/main/b/binutils/'
> >> >> > >>>>>     > +
> >> >> > >>>>>      'binutils-riscv64-linux-gnu_2.32-8_amd64.deb')
> >> >> > >>>>>     > +        deb_hash =3D
> ('7fe376fd4452696c03acd508d6d613ca553ea15e')
> >> >> > >>>>>     > +        deb_path =3D self.fetch_asset(deb_url,
> asset_hash=3Ddeb_hash)
> >> >> > >>>>>     > +        objcopy_path =3D
> '/usr/bin/riscv64-linux-gnu-objcopy'
> >> >> > >>>>>     > +        objcopy_path =3D
> self.extract_from_deb(deb_path, objcopy_path)
> >> >> > >>>>>     > +        libbfd_path =3D
> >> >> > >>>>>     '/usr/lib/x86_64-linux-gnu/libbfd-2.32-riscv64.so
> >> >> > >>>>>     <http://libbfd-2.32-riscv64.so>'
> >> >> > >>>>>     > +        libbfd_path =3D self.extract_from_deb(deb_pa=
th,
> libbfd_path)
> >> >> > >>>>>     > +        process.run('ls -al %s' % (objcopy_path))
> >> >> > >>>>>     > +
> >> >> > >>>>>     > +        deb_url =3D ('
> https://snapshot.debian.org/archive/debian/'
> >> >> > >>>>>     > +
>  '20190708T032337Z/pool/main/o/opensbi/'
> >> >> > >>>>>     > +                   'opensbi_0.4-1_all.deb')
> >> >> > >>>>>     > +        deb_hash =3D
> ('2319dcd702958291d323acf5649fd98a11d90112')
> >> >> > >>>>>     > +        deb_path =3D self.fetch_asset(deb_url,
> asset_hash=3Ddeb_hash)
> >> >> > >>>>>     > +        opensbi_path =3D
> ('/usr/lib/riscv64-linux-gnu/opensbi/'
> >> >> > >>>>>     > +                        'qemu/virt/fw_jump.elf')
> >> >> > >>>>>     > +        opensbi_path =3D
> self.extract_from_deb(deb_path, opensbi_path)
> >> >> > >>>>>     > +
> >> >> > >>>>>     > +        deb_url =3D
> >> >> > >>>>>     ('https://snapshot.debian.org/archive/debian-ports/'
> >> >> > >>>>>     > +
>  '20190620T095935Z/pool-riscv64/main/l/linux/'
> >> >> > >>>>>     > +
> >> >> > >>>>>      'linux-image-4.19.0-5-riscv64_4.19.37-4_riscv64.deb')
> >> >> > >>>>>     > +        deb_hash =3D
> ('bf5b5680c41d92134d22caef4fbd277c5217e1f0')
> >> >> > >>>>>     > +        deb_path =3D self.fetch_asset(deb_url,
> asset_hash=3Ddeb_hash)
> >> >> > >>>>>     > +        kernel_path =3D '/boot/vmlinux-4.19.0-5-risc=
v64'
> >> >> > >>>>>     > +        kernel_path =3D self.extract_from_deb(deb_pa=
th,
> kernel_path)
> >> >> > >>>>>     > +        kimage_path =3D self.workdir + "/Image"
> >> >> > >>>>>     > +        env =3D os.environ
> >> >> > >>>>>     > +        env['LD_LIBRARY_PATH'] =3D ('%s:' %
> >> >> > >>>>>     (os.path.dirname(libbfd_path)) +
> >> >> > >>>>>     > +
>  env.get('LD_LIBRARY_PATH', ''))
> >> >> > >>>>>     > +        process.run(('%s -O binary -O binary -R'
> >> >> > >>>>>     > +                     '.note -R .note.gnu.build-id -R
> .comment -S
> >> >> > >>>>>     %s %s') %
> >> >> > >>>>>     > +                     (objcopy_path, kernel_path,
> kimage_path))
> >> >> > >>>>>
> >> >> > >>>>>     Please explain why you need to do that...
> >> >> > >>>>>
> >> >> > >>>>>     Also note these tests are run on other host architectur=
e
> than x86, at
> >> >> > >>>>>     least ppc64/s390x (so this won't work there).
> >> >> > >>>>>
> >> >> > >>>>> it is because riscv64 vmlinux doesn't have physical loading
> address
> >> >> > >>>>> information and
> >> >> > >>>>> depends on certain stage bootloader to move kernel raw data
> to specific
> >> >> > >>>>> physical address (0x8020_0000)
> >> >> > >>>>>
> >> >> > >>>>> The vmlinux program headers are
> >> >> > >>>>>   Type             Offset       VirtAddr
> PhysAddr
> >> >> > >>>>>     FileSiz  MemSiz   Flg Align
> >> >> > >>>>>   LOAD           0x001000 0xffffffe000000000
> 0x0000000000000000 0x0303a6
> >> >> > >>>>> 0x0303a6 R E 0x1000
> >> >> > >>>>>   LOAD           0x032000 0xffffffe000031000
> 0x0000000000031000 0x828f0c
> >> >> > >>>>> 0x828f0c RWE 0x1000
> >> >> > >>>>>   NOTE           0x85aec0 0xffffffe000859ec0
> 0x0000000000859ec0 0x00004c
> >> >> > >>>>> 0x00004c R   0x4
> >> >> > >>>>>
> >> >> > >>>>> For legacy bootloader, bbl, It can handle payload in ELF
> format.
> >> >> > >>>>> However, for the newer OpenSBI, it can only handle raw data
> and
> >> >> > >>>>> debian doesn't provide linux image in raw data format.
> >> >> > >>>
> >> >> > >>> This doesn't sound right. You should just be able to say
> -kernel
> >> >> > >>> <anything> and it should work. It has worked for me with
> vmlinux and
> >> >> > >>> Image files when using master (not the 4.0 release but
> master/4.1).
> >> >> > >>> Although all of my testing was with the 5.1 kernel, so maybe
> there is
> >> >> > >>> a difference there?
> >> >> > >>>
> >> >> > >>> What isn't working for you? Can you include the errors and
> output of -d in_asm?
> >> >> > >>>
> >> >> > >>>
> >> >> > >>> Alistair
> >> >> > >>
> >> >> > >>
> >> >> > >> Hi Alistair,
> >> >> > >>    I have come across error before starting target simulation.
> What I means is to execute
> >> >> > >>             qemu-system-riscv64 -M virt -m 256M -nographic
> -bios ./opensbi/build/platform/qemu/virt/firmware/fw_jump.elf -kernel
> vmlinux
> >> >> > >>    then get the error message
> >> >> > >>             rom: requested regions overlap (rom mrom.reset.
> free=3D0x000000000001eb7c, addr=3D0x0000000000001000)
> >> >> > >>             qemu-system-riscv64: rom check and register reset
> failed
> >> >> > >
> >> >> > > Hmmm.... I don't remember seeing this problem in my testing, bu=
t
> it
> >> >> > > does seem to make sense.
> >> >> > >
> >> >> > > We have two options here:
> >> >> > > 1. Use the Image file from Linux 5.0+ (my preferred option as
> 4.19 is
> >> >> > > getting old)
> >> >
> >> >  I choose 4.19 version rather than 5.0+  because 4.19 is stable
> branch maintained by Greg.
> >> >  But it is ok to use 5.0 trunk, the latest version provided by debia=
n.
> >> >
> >> >>
> >> >> > > 2. Use the device loader (documented here:
> >> >> > >
> https://github.com/riscv/opensbi/blob/master/docs/platform/qemu_virt.md)
> >> >
> >> >
> >> > The document describes two user cases
> >> >   1. fw_payload.elf
> >> >       a. include the Image (raw data file, not elf)  into data secti=
on
> >> >       b. -kernel load the each part to the correct address
> >> >
> >> >      the program header of  fw_payload.elf are
> >> >      Type           Offset   VirtAddr           PhysAddr
>  FileSiz  MemSiz   Flg Align
> >> >     LOAD           0x0000b0 0x0000000080000000 0x0000000080000000
> 0x00a008 0x00b0b8 RWE 0x10               <-  fw_payload  main program
> >> >     LOAD           0x00a0b8 0x0000000080200000 0x0000000080200000
> 0x8dbe20 0x8dbe20 R E 0x1                    <-  arch/riscv/boot/Image   =
or
> u-boot.bin
> >> >
> >> >   2. fw_jump.elf
> >> >       a. use  "-kernel <raw image> or -device  loader,file=3D<raw
> Image>,addr=3D0x80200000" to load correct address
> >> >       b. fw_jump.elf just jump to the entry address 0x80200000
> >> >
> >> >
> >> >  The issues are
> >> >    a. debian linux-image package only provides vmlinux.
> >>
> >> This can be fixed by upgrading the kernel version. Fedora should have
> >> a 5.2 kernel that you can use instead of Debian.
> >>
> >> >        so I use objcopy in acceptance test
> >> >    b. riscv64 vmlinux doesn't have correct PhysAddr and -kernel can'=
t
> move data to expected address
> >> >        explicit load the Image to specific
> >> >            -kernel raw_image   (if file is not elf or uImage,
> riscv_kerner_loader treat it is as raw image and place it at 0x8020_0000)
> >> >            -device loader,file=3D<raw_image>,0x80200000  (do the sam=
e
> thing)
> >>
> >> Does the device loader not work?
> >>
> >> Alistair
> >
> >
> >   The device loader works for "Image" case (raw data)
> >   If the data is raw image,  for riscv_load_kernel implementation,
>  "-kernel <raw_image>" and  -device loader,file=3D<raw_image>,0x80200000 =
 are
> the same.
> >   They finally call "load_image_targphys_as"
> >   The only difference is that target address is hardcoded or feed from
> command line option.
> >
> >   I don't prefe one than the other.  Both of them are Ok to me.  I coul=
d
> refine that if one of them is more preferable.
>
> I'm a little confused with what you mean, so if you have something
> that will work just send a new version and we can discuss it there.
>
> PS: I'm still in favour of just using a newer kernel and a Image file.
>
> Alistair
>
>  ok, I will use the latest kernel available in Debian package and refine
the command in next version.

chihmin.chao


> >
> >
> >  chihmin.chao
> >>
> >>
> >> >
> >> >   ELF should work only if it has correct loading information.
> >> >
> >> >   chihmin.chao
> >> >>
> >> >> >
> >> >> > Nice doc, this example is exactly what I had in mind:
> >> >> >
> >> >> >   qemu-system-riscv64 -M virt -m 256M -nographic \
> >> >> >         -kernel build/platform/qemu/virt/firmware/fw_jump.elf \
> >> >> >         -device
> >> >> >
> loader,file=3D<linux_build_directory>/arch/riscv/boot/Image,addr=3D0x8020=
0000 \
> >> >> >         -drive file=3D<path_to_linux_rootfs>,format=3Draw,id=3Dhd=
0 \
> >> >> >         -device virtio-blk-device,drive=3Dhd0 \
> >> >> >         -append "root=3D/dev/vda rw console=3DttyS0"
> >> >> >
> >> >> > If the Image is an ELF, I assume we don't need to specify the
> address,
> >> >> > because the device loader knows how to parse this format. Again,
> >> >> > Alistair is the expert ;)
> >> >>
> >> >> Yep, an elf should just work.
> >> >>
> >> >  describe the issue above
> >> >
> >> >>
> >> >> >
> >> >> > If for some reason it only works with Linux 5.0+, let's use these=
!
> >> >>
> >> >> Only 5.0+ builds an elf.
> >> >>
> >> >> Alistair
> >> >>
> >> >> >
> >> >> > Regards,
> >> >> >
> >> >> > Phil.
>
