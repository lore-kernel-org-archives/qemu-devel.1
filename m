Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17389C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 22:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA27C2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 22:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdxZjPe1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA27C2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnWQE-0007kF-31
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 18:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52940)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hnWQ0-0007Ab-DG
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 18:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hnWPy-0002Cu-89
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 18:59:32 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:41799)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hnWPu-0002AQ-F6; Tue, 16 Jul 2019 18:59:26 -0400
Received: by mail-lf1-x144.google.com with SMTP id 62so10045176lfa.8;
 Tue, 16 Jul 2019 15:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oLRCcS6yQmrfafROPIEUF78XO64TzQL+wQ2zkcr5T7c=;
 b=TdxZjPe1AOfnfaejtZysNAevvjWz5RYpgeMxMg1SqwOpDqvBux4/jSx/ML30SS35T1
 PAhDjLUf6vSzN8rz5RQkN4ytUmPiaNfd8/QMj8hTimsr+kNqgVrXdt4Rr9PtuyuEkA2l
 CUv1nMBK2r4SzIVwgceHweS9Jvnc4sqjRwRqM9jy0KFDp7w6q0wOloUjW/eWFsz7c3LZ
 2YQnHkgxPL5562S8yApSG5MBbxHMg/6OdLwjCTqV7FWQgVYotxT/+W4MjZXqK283Iy42
 VfRsnpkjar6oeo5VX3anN4HY4PEYwvJfEB3qqssggawmBPA4hF8ChMzASlnhdX+GaS9p
 oRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oLRCcS6yQmrfafROPIEUF78XO64TzQL+wQ2zkcr5T7c=;
 b=uKQAkN4ZlSC4G/OGdIhEXQ3ouFZg5XRRdIJiUWsjLxG1bF21RgUp22PnkrEO/bf9Ne
 LplBzVvA/seotX4w6TbyHCOlXEfw1b1j0FNH/sFy7+T5yFPFDzGNu33nfrpyGVQsrlt0
 2WPMotuc3ERDku7ksq1HB3ZfSRQPpgpJpPJC1vd2ninK3uTxeEKpMZUVe7kAkmm8kFNT
 tAmRiSqtqMPxPIAMiBXgCjqjOzXWsGDG6PmgKuP1+Y98maWDuqjBGXYAVXKDNWLHWTkV
 HB7JIaSWWlHC542J6tODsK6pjEEnkV445UpEta2lKZiDjWqfZC/G++PKWzU7wVFN/9hm
 7uCg==
X-Gm-Message-State: APjAAAW9Lu4f6UGL2d/TDSB/Ad7UHds/b4y4FP6AuZeTtZ3nkJOpSP7u
 GMbQ+OptFwwfJFQTKZgONGOuIp4ho+OEVbsVAII=
X-Google-Smtp-Source: APXvYqyPEb3Yqez6pL+C4l5ALKYl3Dgy6Pnc8j1S2R8Ilo+mCTlPpTUer1aPrmcy3lzl8wODHmhxRTGKUfs9DpVoGzo=
X-Received: by 2002:ac2:563c:: with SMTP id b28mr3888415lff.93.1563317964850; 
 Tue, 16 Jul 2019 15:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <1563181721-5055-1-git-send-email-chihmin.chao@sifive.com>
 <93b35a5e-c40a-535b-2a91-2c210b4a5928@redhat.com>
 <CAEiOBXXxS-93rTAQuvY_Tkxi1pYc1YfJenpBC_8gG2ou9uUZMg@mail.gmail.com>
 <7eb239bc-32aa-b5fc-ab2e-a741b005aad7@redhat.com>
 <CAKmqyKOZSz4f1-kLDhn=+imCvKHcZJVgqgqWbQ6qxD3K1n17GA@mail.gmail.com>
 <CAEiOBXUBPFx5__wOLvLD0qQ7dzV2XVpHfiOoBZpXpu-SZsMiUg@mail.gmail.com>
 <CAKmqyKNOiRYqZgiWT+LUKkOv+Bew3djOqc9vHpmSqZ-1Gfjd8Q@mail.gmail.com>
 <d2c7e6c6-4d4a-d47e-e496-4f4cfe466fe1@redhat.com>
In-Reply-To: <d2c7e6c6-4d4a-d47e-e496-4f4cfe466fe1@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jul 2019 15:56:06 -0700
Message-ID: <CAKmqyKPiDHrPVuz2P1n9_j170k2bSm=7uDKrQg-fAUhL1FQm9g@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Chih-Min Chao <chihmin.chao@sifive.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 16, 2019 at 2:50 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 7/16/19 10:43 PM, Alistair Francis wrote:
> > On Tue, Jul 16, 2019 at 6:56 AM Chih-Min Chao <chihmin.chao@sifive.com>=
 wrote:
> >>
> >>
> >> On Tue, Jul 16, 2019 at 12:34 AM Alistair Francis <alistair23@gmail.co=
m> wrote:
> >>>
> >>> On Mon, Jul 15, 2019 at 6:02 AM Philippe Mathieu-Daud=C3=A9
> >>> <philmd@redhat.com> wrote:
> >>>>
> >>>> On 7/15/19 1:09 PM, Chih-Min Chao wrote:
> >>>>> On Mon, Jul 15, 2019 at 5:15 PM Philippe Mathieu-Daud=C3=A9
> >>>>> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> >>>>>
> >>>>>     On 7/15/19 11:08 AM, Chih-Min Chao wrote:
> >>>>>     > Similar to the mips + malta test, it boots a Linux kernel on =
a virt
> >>>>>     > board and verify the serial is working.  Also, it relies on t=
he serial
> >>>>>     > device set by the machine itself.
> >>>>>     >
> >>>>>     > If riscv64 is a target being built, "make check-acceptance" w=
ill
> >>>>>     > automatically include this test by the use of the "arch:riscv=
64" tags.
> >>>>>     >
> >>>>>     > Alternatively, this test can be run using:
> >>>>>     >
> >>>>>     >   $ avocado run -t arch:riscv64 tests/acceptance
> >>>>>     >
> >>>>>     > packages
> >>>>>     >   debian official
> >>>>>     >     binutils-riscv64-linux-gnu_2.32-8
> >>>>>     >     opensbi_0.4-1_all
> >>>>>     >     linux-image-4.19.0-5-riscv64 4.19.37-4
> >>>>>     >   third-party
> >>>>>     >
> >>>>>      https://github.com/groeck/linux-build-test/rootfs/riscv64/root=
fs.cpio.gz
> >>>>>     >     (the repo is also used in mips target acceptance)
> >>>>>     >
> >>>>>     > Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com
> >>>>>     <mailto:chihmin.chao@sifive.com>>
> >>>>>     > ---
> >>>>>     >  .travis.yml                            |  2 +-
> >>>>>     >  tests/acceptance/boot_linux_console.py | 66
> >>>>>     ++++++++++++++++++++++++++++++++++
> >>>>>     >  2 files changed, 67 insertions(+), 1 deletion(-)
> >>>>>     >
> >>>>>     > diff --git a/.travis.yml b/.travis.yml
> >>>>>     > index 5d3d6ee..21fcead 100644
> >>>>>     > --- a/.travis.yml
> >>>>>     > +++ b/.travis.yml
> >>>>>     > @@ -232,7 +232,7 @@ matrix:
> >>>>>     >
> >>>>>     >      # Acceptance (Functional) tests
> >>>>>     >      - env:
> >>>>>     > -        - CONFIG=3D"--python=3D/usr/bin/python3
> >>>>>     --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,aa=
rch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu"
> >>>>>     > +        - CONFIG=3D"--python=3D/usr/bin/python3
> >>>>>     --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,aa=
rch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,riscv64-softmmu"
> >>>>>     >          - TEST_CMD=3D"make check-acceptance"
> >>>>>     >        after_failure:
> >>>>>     >          - cat tests/results/latest/job.log
> >>>>>     > diff --git a/tests/acceptance/boot_linux_console.py
> >>>>>     b/tests/acceptance/boot_linux_console.py
> >>>>>     > index 3215950..0f638bc 100644
> >>>>>     > --- a/tests/acceptance/boot_linux_console.py
> >>>>>     > +++ b/tests/acceptance/boot_linux_console.py
> >>>>>     > @@ -354,3 +354,69 @@ class BootLinuxConsole(Test):
> >>>>>     >          self.vm.launch()
> >>>>>     >          console_pattern =3D 'Kernel command line: %s' %
> >>>>>     kernel_command_line
> >>>>>     >          self.wait_for_console_pattern(console_pattern)
> >>>>>     > +
> >>>>>     > +    def test_riscv64_virt(self):
> >>>>>     > +        """
> >>>>>     > +        :avocado: tags=3Darch:riscv64
> >>>>>     > +        :avocado: tags=3Dmachine:virt
> >>>>>     > +        """
> >>>>>     > +        deb_url =3D ('https://snapshot.debian.org/archive/de=
bian/'
> >>>>>     > +                         '20190424T171759Z/pool/main/b/binut=
ils/'
> >>>>>     > +
> >>>>>      'binutils-riscv64-linux-gnu_2.32-8_amd64.deb')
> >>>>>     > +        deb_hash =3D ('7fe376fd4452696c03acd508d6d613ca553ea=
15e')
> >>>>>     > +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3D=
deb_hash)
> >>>>>     > +        objcopy_path =3D '/usr/bin/riscv64-linux-gnu-objcopy=
'
> >>>>>     > +        objcopy_path =3D self.extract_from_deb(deb_path, obj=
copy_path)
> >>>>>     > +        libbfd_path =3D
> >>>>>     '/usr/lib/x86_64-linux-gnu/libbfd-2.32-riscv64.so
> >>>>>     <http://libbfd-2.32-riscv64.so>'
> >>>>>     > +        libbfd_path =3D self.extract_from_deb(deb_path, libb=
fd_path)
> >>>>>     > +        process.run('ls -al %s' % (objcopy_path))
> >>>>>     > +
> >>>>>     > +        deb_url =3D ('https://snapshot.debian.org/archive/de=
bian/'
> >>>>>     > +                   '20190708T032337Z/pool/main/o/opensbi/'
> >>>>>     > +                   'opensbi_0.4-1_all.deb')
> >>>>>     > +        deb_hash =3D ('2319dcd702958291d323acf5649fd98a11d90=
112')
> >>>>>     > +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3D=
deb_hash)
> >>>>>     > +        opensbi_path =3D ('/usr/lib/riscv64-linux-gnu/opensb=
i/'
> >>>>>     > +                        'qemu/virt/fw_jump.elf')
> >>>>>     > +        opensbi_path =3D self.extract_from_deb(deb_path, ope=
nsbi_path)
> >>>>>     > +
> >>>>>     > +        deb_url =3D
> >>>>>     ('https://snapshot.debian.org/archive/debian-ports/'
> >>>>>     > +                   '20190620T095935Z/pool-riscv64/main/l/lin=
ux/'
> >>>>>     > +
> >>>>>      'linux-image-4.19.0-5-riscv64_4.19.37-4_riscv64.deb')
> >>>>>     > +        deb_hash =3D ('bf5b5680c41d92134d22caef4fbd277c5217e=
1f0')
> >>>>>     > +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3D=
deb_hash)
> >>>>>     > +        kernel_path =3D '/boot/vmlinux-4.19.0-5-riscv64'
> >>>>>     > +        kernel_path =3D self.extract_from_deb(deb_path, kern=
el_path)
> >>>>>     > +        kimage_path =3D self.workdir + "/Image"
> >>>>>     > +        env =3D os.environ
> >>>>>     > +        env['LD_LIBRARY_PATH'] =3D ('%s:' %
> >>>>>     (os.path.dirname(libbfd_path)) +
> >>>>>     > +                                 env.get('LD_LIBRARY_PATH', =
''))
> >>>>>     > +        process.run(('%s -O binary -O binary -R'
> >>>>>     > +                     '.note -R .note.gnu.build-id -R .commen=
t -S
> >>>>>     %s %s') %
> >>>>>     > +                     (objcopy_path, kernel_path, kimage_path=
))
> >>>>>
> >>>>>     Please explain why you need to do that...
> >>>>>
> >>>>>     Also note these tests are run on other host architecture than x=
86, at
> >>>>>     least ppc64/s390x (so this won't work there).
> >>>>>
> >>>>> it is because riscv64 vmlinux doesn't have physical loading address
> >>>>> information and
> >>>>> depends on certain stage bootloader to move kernel raw data to spec=
ific
> >>>>> physical address (0x8020_0000)
> >>>>>
> >>>>> The vmlinux program headers are
> >>>>>   Type             Offset       VirtAddr                  PhysAddr
> >>>>>     FileSiz  MemSiz   Flg Align
> >>>>>   LOAD           0x001000 0xffffffe000000000 0x0000000000000000 0x0=
303a6
> >>>>> 0x0303a6 R E 0x1000
> >>>>>   LOAD           0x032000 0xffffffe000031000 0x0000000000031000 0x8=
28f0c
> >>>>> 0x828f0c RWE 0x1000
> >>>>>   NOTE           0x85aec0 0xffffffe000859ec0 0x0000000000859ec0 0x0=
0004c
> >>>>> 0x00004c R   0x4
> >>>>>
> >>>>> For legacy bootloader, bbl, It can handle payload in ELF format.
> >>>>> However, for the newer OpenSBI, it can only handle raw data and
> >>>>> debian doesn't provide linux image in raw data format.
> >>>
> >>> This doesn't sound right. You should just be able to say -kernel
> >>> <anything> and it should work. It has worked for me with vmlinux and
> >>> Image files when using master (not the 4.0 release but master/4.1).
> >>> Although all of my testing was with the 5.1 kernel, so maybe there is
> >>> a difference there?
> >>>
> >>> What isn't working for you? Can you include the errors and output of =
-d in_asm?
> >>>
> >>>
> >>> Alistair
> >>
> >>
> >> Hi Alistair,
> >>    I have come across error before starting target simulation.  What I=
 means is to execute
> >>             qemu-system-riscv64 -M virt -m 256M -nographic -bios ./ope=
nsbi/build/platform/qemu/virt/firmware/fw_jump.elf -kernel vmlinux
> >>    then get the error message
> >>             rom: requested regions overlap (rom mrom.reset. free=3D0x0=
00000000001eb7c, addr=3D0x0000000000001000)
> >>             qemu-system-riscv64: rom check and register reset failed
> >
> > Hmmm.... I don't remember seeing this problem in my testing, but it
> > does seem to make sense.
> >
> > We have two options here:
> > 1. Use the Image file from Linux 5.0+ (my preferred option as 4.19 is
> > getting old)
> > 2. Use the device loader (documented here:
> > https://github.com/riscv/opensbi/blob/master/docs/platform/qemu_virt.md=
)
>
> Nice doc, this example is exactly what I had in mind:
>
>   qemu-system-riscv64 -M virt -m 256M -nographic \
>         -kernel build/platform/qemu/virt/firmware/fw_jump.elf \
>         -device
> loader,file=3D<linux_build_directory>/arch/riscv/boot/Image,addr=3D0x8020=
0000 \
>         -drive file=3D<path_to_linux_rootfs>,format=3Draw,id=3Dhd0 \
>         -device virtio-blk-device,drive=3Dhd0 \
>         -append "root=3D/dev/vda rw console=3DttyS0"
>
> If the Image is an ELF, I assume we don't need to specify the address,
> because the device loader knows how to parse this format. Again,
> Alistair is the expert ;)

Yep, an elf should just work.

>
> If for some reason it only works with Linux 5.0+, let's use these!

Only 5.0+ builds an elf.

Alistair

>
> Regards,
>
> Phil.

