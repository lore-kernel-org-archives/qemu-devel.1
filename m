Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A172CC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 21:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74F35206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 21:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F35206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52525 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnVLH-00058a-PO
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 17:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33986)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnVL6-0004dS-DB
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnVL4-0000Uh-MB
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:50:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35254)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hnVL4-0000TG-FB
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:50:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so22542887wrm.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 14:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5m8UhyKGkBNjyIY6Y9IYoNE0fyBSMdPkoTV0IOJqcPk=;
 b=aViT2b8uJzcl2QcqLrgyj7C7vJAvTtaMIG4r57YtoFdRknugfrXuaSR412AIzmQeeY
 w7IcOQGZlcbcjFw2tHdYxIXgvwkHJ1XMLYXwKLwi/1+vvmC4jlt6/Db15Y44w+6YXceT
 D7R8NOTjqeDrBqDhAqEDcglOZyz1lHtxgPlMHgxXb27JuFvXGTrez2RUL5yQHHuV+J8/
 n1i1XRUtx9CvmgH66/pMHlC/xa09qGSMLYRffEUDL5e4DdlAq0bHiaVdqzs1GnajRgwp
 esLldlV3pDVJnIROf3gEc7GHo5w2FsHQhDRaklhVMGXBmG33tNZpC/w18Cd01MIdbZb3
 x2BA==
X-Gm-Message-State: APjAAAVn4GQ2gpkX2zw/pobdDbKgsVi06LIhhzy809U5sLWRjgbDMq1c
 Wro0uXawUwyou7O9mqByYI+sHA==
X-Google-Smtp-Source: APXvYqxT4yUIOAhtC0zl+SJd7/Uzp3gTKeNllbWqNQVB8eB7Ya714eLz3lEO3fUn3fLjSxClxmm7yQ==
X-Received: by 2002:a05:6000:112:: with SMTP id
 o18mr11229525wrx.153.1563313820710; 
 Tue, 16 Jul 2019 14:50:20 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id x129sm20008498wmg.44.2019.07.16.14.50.19
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 14:50:20 -0700 (PDT)
To: Alistair Francis <alistair23@gmail.com>,
 Chih-Min Chao <chihmin.chao@sifive.com>
References: <1563181721-5055-1-git-send-email-chihmin.chao@sifive.com>
 <93b35a5e-c40a-535b-2a91-2c210b4a5928@redhat.com>
 <CAEiOBXXxS-93rTAQuvY_Tkxi1pYc1YfJenpBC_8gG2ou9uUZMg@mail.gmail.com>
 <7eb239bc-32aa-b5fc-ab2e-a741b005aad7@redhat.com>
 <CAKmqyKOZSz4f1-kLDhn=+imCvKHcZJVgqgqWbQ6qxD3K1n17GA@mail.gmail.com>
 <CAEiOBXUBPFx5__wOLvLD0qQ7dzV2XVpHfiOoBZpXpu-SZsMiUg@mail.gmail.com>
 <CAKmqyKNOiRYqZgiWT+LUKkOv+Bew3djOqc9vHpmSqZ-1Gfjd8Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d2c7e6c6-4d4a-d47e-e496-4f4cfe466fe1@redhat.com>
Date: Tue, 16 Jul 2019 23:50:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNOiRYqZgiWT+LUKkOv+Bew3djOqc9vHpmSqZ-1Gfjd8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
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
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/19 10:43 PM, Alistair Francis wrote:
> On Tue, Jul 16, 2019 at 6:56 AM Chih-Min Chao <chihmin.chao@sifive.com> wrote:
>>
>>
>> On Tue, Jul 16, 2019 at 12:34 AM Alistair Francis <alistair23@gmail.com> wrote:
>>>
>>> On Mon, Jul 15, 2019 at 6:02 AM Philippe Mathieu-Daudé
>>> <philmd@redhat.com> wrote:
>>>>
>>>> On 7/15/19 1:09 PM, Chih-Min Chao wrote:
>>>>> On Mon, Jul 15, 2019 at 5:15 PM Philippe Mathieu-Daudé
>>>>> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>>>>>
>>>>>     On 7/15/19 11:08 AM, Chih-Min Chao wrote:
>>>>>     > Similar to the mips + malta test, it boots a Linux kernel on a virt
>>>>>     > board and verify the serial is working.  Also, it relies on the serial
>>>>>     > device set by the machine itself.
>>>>>     >
>>>>>     > If riscv64 is a target being built, "make check-acceptance" will
>>>>>     > automatically include this test by the use of the "arch:riscv64" tags.
>>>>>     >
>>>>>     > Alternatively, this test can be run using:
>>>>>     >
>>>>>     >   $ avocado run -t arch:riscv64 tests/acceptance
>>>>>     >
>>>>>     > packages
>>>>>     >   debian official
>>>>>     >     binutils-riscv64-linux-gnu_2.32-8
>>>>>     >     opensbi_0.4-1_all
>>>>>     >     linux-image-4.19.0-5-riscv64 4.19.37-4
>>>>>     >   third-party
>>>>>     >
>>>>>      https://github.com/groeck/linux-build-test/rootfs/riscv64/rootfs.cpio.gz
>>>>>     >     (the repo is also used in mips target acceptance)
>>>>>     >
>>>>>     > Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com
>>>>>     <mailto:chihmin.chao@sifive.com>>
>>>>>     > ---
>>>>>     >  .travis.yml                            |  2 +-
>>>>>     >  tests/acceptance/boot_linux_console.py | 66
>>>>>     ++++++++++++++++++++++++++++++++++
>>>>>     >  2 files changed, 67 insertions(+), 1 deletion(-)
>>>>>     >
>>>>>     > diff --git a/.travis.yml b/.travis.yml
>>>>>     > index 5d3d6ee..21fcead 100644
>>>>>     > --- a/.travis.yml
>>>>>     > +++ b/.travis.yml
>>>>>     > @@ -232,7 +232,7 @@ matrix:
>>>>>     >
>>>>>     >      # Acceptance (Functional) tests
>>>>>     >      - env:
>>>>>     > -        - CONFIG="--python=/usr/bin/python3
>>>>>     --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu"
>>>>>     > +        - CONFIG="--python=/usr/bin/python3
>>>>>     --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,riscv64-softmmu"
>>>>>     >          - TEST_CMD="make check-acceptance"
>>>>>     >        after_failure:
>>>>>     >          - cat tests/results/latest/job.log
>>>>>     > diff --git a/tests/acceptance/boot_linux_console.py
>>>>>     b/tests/acceptance/boot_linux_console.py
>>>>>     > index 3215950..0f638bc 100644
>>>>>     > --- a/tests/acceptance/boot_linux_console.py
>>>>>     > +++ b/tests/acceptance/boot_linux_console.py
>>>>>     > @@ -354,3 +354,69 @@ class BootLinuxConsole(Test):
>>>>>     >          self.vm.launch()
>>>>>     >          console_pattern = 'Kernel command line: %s' %
>>>>>     kernel_command_line
>>>>>     >          self.wait_for_console_pattern(console_pattern)
>>>>>     > +
>>>>>     > +    def test_riscv64_virt(self):
>>>>>     > +        """
>>>>>     > +        :avocado: tags=arch:riscv64
>>>>>     > +        :avocado: tags=machine:virt
>>>>>     > +        """
>>>>>     > +        deb_url = ('https://snapshot.debian.org/archive/debian/'
>>>>>     > +                         '20190424T171759Z/pool/main/b/binutils/'
>>>>>     > +
>>>>>      'binutils-riscv64-linux-gnu_2.32-8_amd64.deb')
>>>>>     > +        deb_hash = ('7fe376fd4452696c03acd508d6d613ca553ea15e')
>>>>>     > +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>>>>>     > +        objcopy_path = '/usr/bin/riscv64-linux-gnu-objcopy'
>>>>>     > +        objcopy_path = self.extract_from_deb(deb_path, objcopy_path)
>>>>>     > +        libbfd_path =
>>>>>     '/usr/lib/x86_64-linux-gnu/libbfd-2.32-riscv64.so
>>>>>     <http://libbfd-2.32-riscv64.so>'
>>>>>     > +        libbfd_path = self.extract_from_deb(deb_path, libbfd_path)
>>>>>     > +        process.run('ls -al %s' % (objcopy_path))
>>>>>     > +
>>>>>     > +        deb_url = ('https://snapshot.debian.org/archive/debian/'
>>>>>     > +                   '20190708T032337Z/pool/main/o/opensbi/'
>>>>>     > +                   'opensbi_0.4-1_all.deb')
>>>>>     > +        deb_hash = ('2319dcd702958291d323acf5649fd98a11d90112')
>>>>>     > +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>>>>>     > +        opensbi_path = ('/usr/lib/riscv64-linux-gnu/opensbi/'
>>>>>     > +                        'qemu/virt/fw_jump.elf')
>>>>>     > +        opensbi_path = self.extract_from_deb(deb_path, opensbi_path)
>>>>>     > +
>>>>>     > +        deb_url =
>>>>>     ('https://snapshot.debian.org/archive/debian-ports/'
>>>>>     > +                   '20190620T095935Z/pool-riscv64/main/l/linux/'
>>>>>     > +
>>>>>      'linux-image-4.19.0-5-riscv64_4.19.37-4_riscv64.deb')
>>>>>     > +        deb_hash = ('bf5b5680c41d92134d22caef4fbd277c5217e1f0')
>>>>>     > +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>>>>>     > +        kernel_path = '/boot/vmlinux-4.19.0-5-riscv64'
>>>>>     > +        kernel_path = self.extract_from_deb(deb_path, kernel_path)
>>>>>     > +        kimage_path = self.workdir + "/Image"
>>>>>     > +        env = os.environ
>>>>>     > +        env['LD_LIBRARY_PATH'] = ('%s:' %
>>>>>     (os.path.dirname(libbfd_path)) +
>>>>>     > +                                 env.get('LD_LIBRARY_PATH', ''))
>>>>>     > +        process.run(('%s -O binary -O binary -R'
>>>>>     > +                     '.note -R .note.gnu.build-id -R .comment -S
>>>>>     %s %s') %
>>>>>     > +                     (objcopy_path, kernel_path, kimage_path))
>>>>>
>>>>>     Please explain why you need to do that...
>>>>>
>>>>>     Also note these tests are run on other host architecture than x86, at
>>>>>     least ppc64/s390x (so this won't work there).
>>>>>
>>>>> it is because riscv64 vmlinux doesn't have physical loading address
>>>>> information and
>>>>> depends on certain stage bootloader to move kernel raw data to specific
>>>>> physical address (0x8020_0000)
>>>>>
>>>>> The vmlinux program headers are
>>>>>   Type             Offset       VirtAddr                  PhysAddr
>>>>>     FileSiz  MemSiz   Flg Align
>>>>>   LOAD           0x001000 0xffffffe000000000 0x0000000000000000 0x0303a6
>>>>> 0x0303a6 R E 0x1000
>>>>>   LOAD           0x032000 0xffffffe000031000 0x0000000000031000 0x828f0c
>>>>> 0x828f0c RWE 0x1000
>>>>>   NOTE           0x85aec0 0xffffffe000859ec0 0x0000000000859ec0 0x00004c
>>>>> 0x00004c R   0x4
>>>>>
>>>>> For legacy bootloader, bbl, It can handle payload in ELF format.
>>>>> However, for the newer OpenSBI, it can only handle raw data and
>>>>> debian doesn't provide linux image in raw data format.
>>>
>>> This doesn't sound right. You should just be able to say -kernel
>>> <anything> and it should work. It has worked for me with vmlinux and
>>> Image files when using master (not the 4.0 release but master/4.1).
>>> Although all of my testing was with the 5.1 kernel, so maybe there is
>>> a difference there?
>>>
>>> What isn't working for you? Can you include the errors and output of -d in_asm?
>>>
>>>
>>> Alistair
>>
>>
>> Hi Alistair,
>>    I have come across error before starting target simulation.  What I means is to execute
>>             qemu-system-riscv64 -M virt -m 256M -nographic -bios ./opensbi/build/platform/qemu/virt/firmware/fw_jump.elf -kernel vmlinux
>>    then get the error message
>>             rom: requested regions overlap (rom mrom.reset. free=0x000000000001eb7c, addr=0x0000000000001000)
>>             qemu-system-riscv64: rom check and register reset failed
> 
> Hmmm.... I don't remember seeing this problem in my testing, but it
> does seem to make sense.
> 
> We have two options here:
> 1. Use the Image file from Linux 5.0+ (my preferred option as 4.19 is
> getting old)
> 2. Use the device loader (documented here:
> https://github.com/riscv/opensbi/blob/master/docs/platform/qemu_virt.md)

Nice doc, this example is exactly what I had in mind:

  qemu-system-riscv64 -M virt -m 256M -nographic \
	-kernel build/platform/qemu/virt/firmware/fw_jump.elf \
	-device
loader,file=<linux_build_directory>/arch/riscv/boot/Image,addr=0x80200000 \
	-drive file=<path_to_linux_rootfs>,format=raw,id=hd0 \
	-device virtio-blk-device,drive=hd0 \
	-append "root=/dev/vda rw console=ttyS0"

If the Image is an ELF, I assume we don't need to specify the address,
because the device loader knows how to parse this format. Again,
Alistair is the expert ;)

If for some reason it only works with Linux 5.0+, let's use these!

Regards,

Phil.

