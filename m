Received: from eggs.gnu.org ([2001:4830:134:3::10]:48347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1f4OsR-0004UQ-Ts
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1f4OsO-0000Sn-PW
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:45:51 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:50917)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1f4OsO-0000R7-He
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:45:48 -0400
References: <6c7ac1ff-b375-f1f7-094e-7fb603c5e40b@msgid.tls.msk.ru>
	<alpine.BSF.2.21.1804021607010.6023@zero.eik.bme.hu>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <95d8655f-9956-6d7b-1419-efae9893784f@msgid.tls.msk.ru>
Date: Fri, 6 Apr 2018 13:45:46 +0300
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1804021607010.6023@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] some ROMs questions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

02.04.2018 17:30, BALATON Zoltan wrote:
> On Mon, 2 Apr 2018, Michael Tokarev wrote:
>> roms/u-boot-sam460ex/tools/updater/stubs.c -
>> it is some strange symlink pointing to a strange place, probably should be removed?
> 
> This does not seem to matter for building the rom image but this can be fixed by converting it to a relative path. I've done that and will send a patch to update the submodule as well to use the QEMU repo now that we have a mirror there. Thanks for finding this.

Hmm, I've no idea how to pull a submodule change.. :)

But I've one more question about this rom.  When I'm trying to build it,
the build fails:

roms/u-boot-sam460ex$ make Sam460ex_config CROSS_COMPILE=powerpc64-linux-gnu-
Generating include/autoconf.mk
cc1: error: -mcall not supported in this configuration
cc1: error: -mrelocatable not supported in this configuration
cc1: error: -meabi not supported in this configuration
cc1: error: -m64 requires a PowerPC64 cpu
Generating include/autoconf.mk.dep
cc1: error: -mcall not supported in this configuration
cc1: error: -mrelocatable not supported in this configuration
cc1: error: -meabi not supported in this configuration
cc1: error: -m64 requires a PowerPC64 cpu
Configuring for Sam460ex board...

roms/u-boot-sam460ex$ make CROSS_COMPILE=powerpc64-linux-gnu-
...
make -C arch/powerpc/cpu/ppc4xx start.o
make[1]: Entering directory '/build/qemu/debian-qemu/roms/u-boot-sam460ex/arch/powerpc/cpu/ppc4xx'
powerpc64-linux-gnu-gcc   -D__ASSEMBLY__ -g  -Os   -mrelocatable -fPIC -meabi -ffunction-sections -fdata-sections -D__KERNEL__ -DTEXT_BASE=0xFFF80000 -I/build/qemu/debian-qemu/roms/u-boot-sam460ex/include -fno-builtin -ffreestanding -nostdinc -isystem /usr/lib/gcc-cross/powerpc64-linux-gnu/6/include -pipe  -DCONFIG_PPC -D__powerpc__ -DCONFIG_4xx -ffixed-r2 -mstring -msoft-float -Wa,-m440 -mcpu=440 -DCONFIG_440=1 -I../bios_emulator/scitech/include -I../bios_emulator/scitech/src/x86emu -Dprintk=printf   \
        -o start.o start.S -c
start.S:1:0: error: -mcall not supported in this configuration
 /*

start.S:1:0: error: -mrelocatable not supported in this configuration
start.S:1:0: error: -meabi not supported in this configuration
start.S:1:0: error: -m64 requires a PowerPC64 cpu
/build/qemu/debian-qemu/roms/u-boot-sam460ex/config.mk:249: recipe for target 'start.o' failed
make[1]: *** [start.o] Error 1
make[1]: Leaving directory '/build/qemu/debian-qemu/roms/u-boot-sam460ex/arch/powerpc/cpu/ppc4xx'
Makefile:353: recipe for target 'arch/powerpc/cpu/ppc4xx/start.o' failed
make: *** [arch/powerpc/cpu/ppc4xx/start.o] Error 2

What I'm doing wrong?

$ powerpc64-linux-gnu-gcc --version
powerpc64-linux-gnu-gcc (Debian 6.3.0-18) 6.3.0 20170516

Thanks!

/mjt
