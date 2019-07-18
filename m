Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6940EC7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 15:34:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2814421019
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 15:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTZyYXTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2814421019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho8Qa-0001M5-4o
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 11:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49801)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1ho8QI-0000Zv-Ib
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 11:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1ho8QG-0008Ox-E3
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 11:34:22 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a]:37269)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1ho8QB-0008Kj-S7; Thu, 18 Jul 2019 11:34:16 -0400
Received: by mail-lj1-x22a.google.com with SMTP id z28so27863044ljn.4;
 Thu, 18 Jul 2019 08:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3nC2EAn8Iw1/HMEMZYLL7DEyy1UZ6diR1wVA+SuTkHw=;
 b=BTZyYXTVAxvLmBQwx4w9ggp+i1qBbifIa7sOj8OzzkFdh/45dpF5f7+shhCNpomsqz
 xjJ6xiiwyuxl8CqzL0sJspMH8k2VY7+UZl2lfi4fnnqKYVxtcZ59RLUdKWeOrxiYtNub
 qearfSSwSNbAVxxEM/fSUm7nvH7ansiNGbUut2/h4+X7bOH2bNK1qIslmWly9/AKEa/H
 9Q+jby8mHlLEl0Bwy/l4lCysB/OdgARwjMxuc7AJixXGs+WhhFt8XUrSsUbjRXpOpg71
 sB5U4kMQeDPJQPqZOa9wlGQ3JE748vTBvTD1FCtR25sTnvTdLD9vBHWw0t8IS3m8g0Ut
 9NNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3nC2EAn8Iw1/HMEMZYLL7DEyy1UZ6diR1wVA+SuTkHw=;
 b=HTWnVZHgR4d1Q94uifAgxIY4jx8m5wmIXCVefmoTgI8lYWmwW3f4iGOWxqGaX8hC+5
 iz1VFfVPUeoBeP7SmcsNaVeredEGnYv1fBpdku3x/tmGjCxP35Kzp/Y+bdMBYEF5sVHR
 vjfFzclNc0pfswZUalGEOXuBCMUFgrSmE8N8pNrvYfIm5pne4dT3oRc9o0sHuJDGcOf2
 yvF3QDvrONj58dT9TVp7BtFdDF9q1C9lzipmdGFTvb2T/QHOfooIL5TR3UPfdXT/mN+I
 gyqoZ/QaUYjen83VABedjDWGNZE/oEOTtdfB+SLmzO35a/sur9oyFOwcp9JfSC7/ddmi
 YZ7g==
X-Gm-Message-State: APjAAAWFLn7ZTqbvjqUOnxN7LR1uMVrV+4x2PbBUuWQOhpnJSeYz84xx
 usCsO+j12l/aVTf+DjZgTE+usErTJp1Kqo/LPBg=
X-Google-Smtp-Source: APXvYqy4bC//nCTy6+qhgJf9zMw2JSkI8S4Bm0enPTvpnoIMOqSFd+J1GXefg3Z2vFpP7Mie4XuirGDZQ84VE8zKQ7c=
X-Received: by 2002:a2e:b4c9:: with SMTP id r9mr24665204ljm.196.1563464052751; 
 Thu, 18 Jul 2019 08:34:12 -0700 (PDT)
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
In-Reply-To: <CAEiOBXXMRXEEdp27c0C6RpxLQFW7BYdTDsoR5pRyxf=m74A5Kg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 18 Jul 2019 08:33:46 -0700
Message-ID: <CAKmqyKPP8Y9SP8xHgA2N1n5wLmmaoXuK1GBBA7_G90rZJP5x8A@mail.gmail.com>
To: Chih-Min Chao <chihmin.chao@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::22a
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

On Thu, Jul 18, 2019 at 8:00 AM Chih-Min Chao <chihmin.chao@sifive.com> wro=
te:
>
>
>
> On Thu, Jul 18, 2019 at 6:47 AM Alistair Francis <alistair23@gmail.com> w=
rote:
>>
>> On Tue, Jul 16, 2019 at 10:21 PM Chih-Min Chao <chihmin.chao@sifive.com>=
 wrote:
>> >
>> >
>> >
>> > On Wed, Jul 17, 2019 at 6:59 AM Alistair Francis <alistair23@gmail.com=
> wrote:
>> >>
>> >> On Tue, Jul 16, 2019 at 2:50 PM Philippe Mathieu-Daud=C3=A9
>> >> <philmd@redhat.com> wrote:
>> >> >
>> >> > On 7/16/19 10:43 PM, Alistair Francis wrote:
>> >> > > On Tue, Jul 16, 2019 at 6:56 AM Chih-Min Chao <chihmin.chao@sifiv=
e.com> wrote:
>> >> > >>
>> >> > >>
>> >> > >> On Tue, Jul 16, 2019 at 12:34 AM Alistair Francis <alistair23@gm=
ail.com> wrote:
>> >> > >>>
>> >> > >>> On Mon, Jul 15, 2019 at 6:02 AM Philippe Mathieu-Daud=C3=A9
>> >> > >>> <philmd@redhat.com> wrote:
>> >> > >>>>
>> >> > >>>> On 7/15/19 1:09 PM, Chih-Min Chao wrote:
>> >> > >>>>> On Mon, Jul 15, 2019 at 5:15 PM Philippe Mathieu-Daud=C3=A9
>> >> > >>>>> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>> >> > >>>>>
>> >> > >>>>>     On 7/15/19 11:08 AM, Chih-Min Chao wrote:
>> >> > >>>>>     > Similar to the mips + malta test, it boots a Linux kern=
el on a virt
>> >> > >>>>>     > board and verify the serial is working.  Also, it relie=
s on the serial
>> >> > >>>>>     > device set by the machine itself.
>> >> > >>>>>     >
>> >> > >>>>>     > If riscv64 is a target being built, "make check-accepta=
nce" will
>> >> > >>>>>     > automatically include this test by the use of the "arch=
:riscv64" tags.
>> >> > >>>>>     >
>> >> > >>>>>     > Alternatively, this test can be run using:
>> >> > >>>>>     >
>> >> > >>>>>     >   $ avocado run -t arch:riscv64 tests/acceptance
>> >> > >>>>>     >
>> >> > >>>>>     > packages
>> >> > >>>>>     >   debian official
>> >> > >>>>>     >     binutils-riscv64-linux-gnu_2.32-8
>> >> > >>>>>     >     opensbi_0.4-1_all
>> >> > >>>>>     >     linux-image-4.19.0-5-riscv64 4.19.37-4
>> >> > >>>>>     >   third-party
>> >> > >>>>>     >
>> >> > >>>>>      https://github.com/groeck/linux-build-test/rootfs/riscv6=
4/rootfs.cpio.gz
>> >> > >>>>>     >     (the repo is also used in mips target acceptance)
>> >> > >>>>>     >
>> >> > >>>>>     > Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com
>> >> > >>>>>     <mailto:chihmin.chao@sifive.com>>
>> >> > >>>>>     > ---
>> >> > >>>>>     >  .travis.yml                            |  2 +-
>> >> > >>>>>     >  tests/acceptance/boot_linux_console.py | 66
>> >> > >>>>>     ++++++++++++++++++++++++++++++++++
>> >> > >>>>>     >  2 files changed, 67 insertions(+), 1 deletion(-)
>> >> > >>>>>     >
>> >> > >>>>>     > diff --git a/.travis.yml b/.travis.yml
>> >> > >>>>>     > index 5d3d6ee..21fcead 100644
>> >> > >>>>>     > --- a/.travis.yml
>> >> > >>>>>     > +++ b/.travis.yml
>> >> > >>>>>     > @@ -232,7 +232,7 @@ matrix:
>> >> > >>>>>     >
>> >> > >>>>>     >      # Acceptance (Functional) tests
>> >> > >>>>>     >      - env:
>> >> > >>>>>     > -        - CONFIG=3D"--python=3D/usr/bin/python3
>> >> > >>>>>     --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-soft=
mmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu"
>> >> > >>>>>     > +        - CONFIG=3D"--python=3D/usr/bin/python3
>> >> > >>>>>     --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-soft=
mmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,riscv64-softmmu=
"
>> >> > >>>>>     >          - TEST_CMD=3D"make check-acceptance"
>> >> > >>>>>     >        after_failure:
>> >> > >>>>>     >          - cat tests/results/latest/job.log
>> >> > >>>>>     > diff --git a/tests/acceptance/boot_linux_console.py
>> >> > >>>>>     b/tests/acceptance/boot_linux_console.py
>> >> > >>>>>     > index 3215950..0f638bc 100644
>> >> > >>>>>     > --- a/tests/acceptance/boot_linux_console.py
>> >> > >>>>>     > +++ b/tests/acceptance/boot_linux_console.py
>> >> > >>>>>     > @@ -354,3 +354,69 @@ class BootLinuxConsole(Test):
>> >> > >>>>>     >          self.vm.launch()
>> >> > >>>>>     >          console_pattern =3D 'Kernel command line: %s' =
%
>> >> > >>>>>     kernel_command_line
>> >> > >>>>>     >          self.wait_for_console_pattern(console_pattern)
>> >> > >>>>>     > +
>> >> > >>>>>     > +    def test_riscv64_virt(self):
>> >> > >>>>>     > +        """
>> >> > >>>>>     > +        :avocado: tags=3Darch:riscv64
>> >> > >>>>>     > +        :avocado: tags=3Dmachine:virt
>> >> > >>>>>     > +        """
>> >> > >>>>>     > +        deb_url =3D ('https://snapshot.debian.org/arch=
ive/debian/'
>> >> > >>>>>     > +                         '20190424T171759Z/pool/main/b=
/binutils/'
>> >> > >>>>>     > +
>> >> > >>>>>      'binutils-riscv64-linux-gnu_2.32-8_amd64.deb')
>> >> > >>>>>     > +        deb_hash =3D ('7fe376fd4452696c03acd508d6d613c=
a553ea15e')
>> >> > >>>>>     > +        deb_path =3D self.fetch_asset(deb_url, asset_h=
ash=3Ddeb_hash)
>> >> > >>>>>     > +        objcopy_path =3D '/usr/bin/riscv64-linux-gnu-o=
bjcopy'
>> >> > >>>>>     > +        objcopy_path =3D self.extract_from_deb(deb_pat=
h, objcopy_path)
>> >> > >>>>>     > +        libbfd_path =3D
>> >> > >>>>>     '/usr/lib/x86_64-linux-gnu/libbfd-2.32-riscv64.so
>> >> > >>>>>     <http://libbfd-2.32-riscv64.so>'
>> >> > >>>>>     > +        libbfd_path =3D self.extract_from_deb(deb_path=
, libbfd_path)
>> >> > >>>>>     > +        process.run('ls -al %s' % (objcopy_path))
>> >> > >>>>>     > +
>> >> > >>>>>     > +        deb_url =3D ('https://snapshot.debian.org/arch=
ive/debian/'
>> >> > >>>>>     > +                   '20190708T032337Z/pool/main/o/opens=
bi/'
>> >> > >>>>>     > +                   'opensbi_0.4-1_all.deb')
>> >> > >>>>>     > +        deb_hash =3D ('2319dcd702958291d323acf5649fd98=
a11d90112')
>> >> > >>>>>     > +        deb_path =3D self.fetch_asset(deb_url, asset_h=
ash=3Ddeb_hash)
>> >> > >>>>>     > +        opensbi_path =3D ('/usr/lib/riscv64-linux-gnu/=
opensbi/'
>> >> > >>>>>     > +                        'qemu/virt/fw_jump.elf')
>> >> > >>>>>     > +        opensbi_path =3D self.extract_from_deb(deb_pat=
h, opensbi_path)
>> >> > >>>>>     > +
>> >> > >>>>>     > +        deb_url =3D
>> >> > >>>>>     ('https://snapshot.debian.org/archive/debian-ports/'
>> >> > >>>>>     > +                   '20190620T095935Z/pool-riscv64/main=
/l/linux/'
>> >> > >>>>>     > +
>> >> > >>>>>      'linux-image-4.19.0-5-riscv64_4.19.37-4_riscv64.deb')
>> >> > >>>>>     > +        deb_hash =3D ('bf5b5680c41d92134d22caef4fbd277=
c5217e1f0')
>> >> > >>>>>     > +        deb_path =3D self.fetch_asset(deb_url, asset_h=
ash=3Ddeb_hash)
>> >> > >>>>>     > +        kernel_path =3D '/boot/vmlinux-4.19.0-5-riscv6=
4'
>> >> > >>>>>     > +        kernel_path =3D self.extract_from_deb(deb_path=
, kernel_path)
>> >> > >>>>>     > +        kimage_path =3D self.workdir + "/Image"
>> >> > >>>>>     > +        env =3D os.environ
>> >> > >>>>>     > +        env['LD_LIBRARY_PATH'] =3D ('%s:' %
>> >> > >>>>>     (os.path.dirname(libbfd_path)) +
>> >> > >>>>>     > +                                 env.get('LD_LIBRARY_P=
ATH', ''))
>> >> > >>>>>     > +        process.run(('%s -O binary -O binary -R'
>> >> > >>>>>     > +                     '.note -R .note.gnu.build-id -R .=
comment -S
>> >> > >>>>>     %s %s') %
>> >> > >>>>>     > +                     (objcopy_path, kernel_path, kimag=
e_path))
>> >> > >>>>>
>> >> > >>>>>     Please explain why you need to do that...
>> >> > >>>>>
>> >> > >>>>>     Also note these tests are run on other host architecture =
than x86, at
>> >> > >>>>>     least ppc64/s390x (so this won't work there).
>> >> > >>>>>
>> >> > >>>>> it is because riscv64 vmlinux doesn't have physical loading a=
ddress
>> >> > >>>>> information and
>> >> > >>>>> depends on certain stage bootloader to move kernel raw data t=
o specific
>> >> > >>>>> physical address (0x8020_0000)
>> >> > >>>>>
>> >> > >>>>> The vmlinux program headers are
>> >> > >>>>>   Type             Offset       VirtAddr                  Phy=
sAddr
>> >> > >>>>>     FileSiz  MemSiz   Flg Align
>> >> > >>>>>   LOAD           0x001000 0xffffffe000000000 0x00000000000000=
00 0x0303a6
>> >> > >>>>> 0x0303a6 R E 0x1000
>> >> > >>>>>   LOAD           0x032000 0xffffffe000031000 0x00000000000310=
00 0x828f0c
>> >> > >>>>> 0x828f0c RWE 0x1000
>> >> > >>>>>   NOTE           0x85aec0 0xffffffe000859ec0 0x0000000000859e=
c0 0x00004c
>> >> > >>>>> 0x00004c R   0x4
>> >> > >>>>>
>> >> > >>>>> For legacy bootloader, bbl, It can handle payload in ELF form=
at.
>> >> > >>>>> However, for the newer OpenSBI, it can only handle raw data a=
nd
>> >> > >>>>> debian doesn't provide linux image in raw data format.
>> >> > >>>
>> >> > >>> This doesn't sound right. You should just be able to say -kerne=
l
>> >> > >>> <anything> and it should work. It has worked for me with vmlinu=
x and
>> >> > >>> Image files when using master (not the 4.0 release but master/4=
.1).
>> >> > >>> Although all of my testing was with the 5.1 kernel, so maybe th=
ere is
>> >> > >>> a difference there?
>> >> > >>>
>> >> > >>> What isn't working for you? Can you include the errors and outp=
ut of -d in_asm?
>> >> > >>>
>> >> > >>>
>> >> > >>> Alistair
>> >> > >>
>> >> > >>
>> >> > >> Hi Alistair,
>> >> > >>    I have come across error before starting target simulation.  =
What I means is to execute
>> >> > >>             qemu-system-riscv64 -M virt -m 256M -nographic -bios=
 ./opensbi/build/platform/qemu/virt/firmware/fw_jump.elf -kernel vmlinux
>> >> > >>    then get the error message
>> >> > >>             rom: requested regions overlap (rom mrom.reset. free=
=3D0x000000000001eb7c, addr=3D0x0000000000001000)
>> >> > >>             qemu-system-riscv64: rom check and register reset fa=
iled
>> >> > >
>> >> > > Hmmm.... I don't remember seeing this problem in my testing, but =
it
>> >> > > does seem to make sense.
>> >> > >
>> >> > > We have two options here:
>> >> > > 1. Use the Image file from Linux 5.0+ (my preferred option as 4.1=
9 is
>> >> > > getting old)
>> >
>> >  I choose 4.19 version rather than 5.0+  because 4.19 is stable branch=
 maintained by Greg.
>> >  But it is ok to use 5.0 trunk, the latest version provided by debian.
>> >
>> >>
>> >> > > 2. Use the device loader (documented here:
>> >> > > https://github.com/riscv/opensbi/blob/master/docs/platform/qemu_v=
irt.md)
>> >
>> >
>> > The document describes two user cases
>> >   1. fw_payload.elf
>> >       a. include the Image (raw data file, not elf)  into data section
>> >       b. -kernel load the each part to the correct address
>> >
>> >      the program header of  fw_payload.elf are
>> >      Type           Offset   VirtAddr           PhysAddr           Fil=
eSiz  MemSiz   Flg Align
>> >     LOAD           0x0000b0 0x0000000080000000 0x0000000080000000 0x00=
a008 0x00b0b8 RWE 0x10               <-  fw_payload  main program
>> >     LOAD           0x00a0b8 0x0000000080200000 0x0000000080200000 0x8d=
be20 0x8dbe20 R E 0x1                    <-  arch/riscv/boot/Image   or u-b=
oot.bin
>> >
>> >   2. fw_jump.elf
>> >       a. use  "-kernel <raw image> or -device  loader,file=3D<raw Imag=
e>,addr=3D0x80200000" to load correct address
>> >       b. fw_jump.elf just jump to the entry address 0x80200000
>> >
>> >
>> >  The issues are
>> >    a. debian linux-image package only provides vmlinux.
>>
>> This can be fixed by upgrading the kernel version. Fedora should have
>> a 5.2 kernel that you can use instead of Debian.
>>
>> >        so I use objcopy in acceptance test
>> >    b. riscv64 vmlinux doesn't have correct PhysAddr and -kernel can't =
move data to expected address
>> >        explicit load the Image to specific
>> >            -kernel raw_image   (if file is not elf or uImage,  riscv_k=
erner_loader treat it is as raw image and place it at 0x8020_0000)
>> >            -device loader,file=3D<raw_image>,0x80200000  (do the same =
thing)
>>
>> Does the device loader not work?
>>
>> Alistair
>
>
>   The device loader works for "Image" case (raw data)
>   If the data is raw image,  for riscv_load_kernel implementation,   "-ke=
rnel <raw_image>" and  -device loader,file=3D<raw_image>,0x80200000  are th=
e same.
>   They finally call "load_image_targphys_as"
>   The only difference is that target address is hardcoded or feed from co=
mmand line option.
>
>   I don't prefe one than the other.  Both of them are Ok to me.  I could =
refine that if one of them is more preferable.

I'm a little confused with what you mean, so if you have something
that will work just send a new version and we can discuss it there.

PS: I'm still in favour of just using a newer kernel and a Image file.

Alistair

>
>
>  chihmin.chao
>>
>>
>> >
>> >   ELF should work only if it has correct loading information.
>> >
>> >   chihmin.chao
>> >>
>> >> >
>> >> > Nice doc, this example is exactly what I had in mind:
>> >> >
>> >> >   qemu-system-riscv64 -M virt -m 256M -nographic \
>> >> >         -kernel build/platform/qemu/virt/firmware/fw_jump.elf \
>> >> >         -device
>> >> > loader,file=3D<linux_build_directory>/arch/riscv/boot/Image,addr=3D=
0x80200000 \
>> >> >         -drive file=3D<path_to_linux_rootfs>,format=3Draw,id=3Dhd0 =
\
>> >> >         -device virtio-blk-device,drive=3Dhd0 \
>> >> >         -append "root=3D/dev/vda rw console=3DttyS0"
>> >> >
>> >> > If the Image is an ELF, I assume we don't need to specify the addre=
ss,
>> >> > because the device loader knows how to parse this format. Again,
>> >> > Alistair is the expert ;)
>> >>
>> >> Yep, an elf should just work.
>> >>
>> >  describe the issue above
>> >
>> >>
>> >> >
>> >> > If for some reason it only works with Linux 5.0+, let's use these!
>> >>
>> >> Only 5.0+ builds an elf.
>> >>
>> >> Alistair
>> >>
>> >> >
>> >> > Regards,
>> >> >
>> >> > Phil.

