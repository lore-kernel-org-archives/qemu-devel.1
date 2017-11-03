Received: from eggs.gnu.org ([2001:4830:134:3::10]:53505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAbfr-0007Kf-UG
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAbfm-0006Rd-TY
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:06:15 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:45800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAbfm-0006RK-O4
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:06:10 -0400
Received: by mail-qt0-x244.google.com with SMTP id p1so3119787qtg.2
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 06:06:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1509697171.31823.9.camel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fa4bbd2c-5e97-8bc4-988f-8730580b6ad3@amsat.org>
Date: Fri, 3 Nov 2017 10:06:06 -0300
MIME-Version: 1.0
In-Reply-To: <1509697171.31823.9.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] capstone broke mingw cross build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi Gerd,

On 11/03/2017 05:19 AM, Gerd Hoffmann wrote:
>   Hi,
> 
> see $subject
> 
> make: Entering directory `/home/kraxel/projects/qemu/build-win64'
> mkdir -p dtc/libfdt
> mkdir -p dtc/tests
> make[1]: `/home/kraxel/projects/qemu/build-win64/capstone/capstone.lib' 
> is up to date.
>   LINK    qemu-ga.exe
>   LINK    qemu-img.exe
> /home/kraxel/projects/qemu/build-win64/capstone/capstone.lib: error
> adding symbols: Archive has no index; run ranlib to add one
> collect2: error: ld returned 1 exit status
>   LINK    qemu-io.exe
> make: *** [qemu-img.exe] Error 1
> make: *** Waiting for unfinished jobs....
> /home/kraxel/projects/qemu/build-win64/capstone/capstone.lib: error
> adding symbols: Archive has no index; run ranlib to add one
> collect2: error: ld returned 1 exit status
> make: *** [qemu-io.exe] Error 1
> make: Leaving directory `/home/kraxel/projects/qemu/build-win64'

I can't reproduce your error running:

$ docker run --rm -v $(pwd):$(pwd) -w $(pwd) -u $(id -u) \
  qemu:debian-win32-cross bash -c \
  'mkdir -p build/win32 && cd build/win32 && ../../configure
$QEMU_CONFIGURE_OPTS && make qemu-img.exe'
Install prefix    c:/Program Files/QEMU
BIOS directory    c:/Program Files/QEMU
...
GIT submodules    ui/keycodemapdb dtc capstone
C compiler        i686-w64-mingw32.shared-gcc
Host C compiler   cc
C++ compiler      i686-w64-mingw32.shared-g++
Objective-C compiler clang
ARFLAGS           rv
...
capstone          git
mkdir -p dtc/libfdt
mkdir -p dtc/tests
  CC      cs.o
  CC      utils.o
  CC      SStream.o
  CC      MCInstrDesc.o
  CC      MCRegisterInfo.o
  CC      arch/ARM/ARMDisassembler.o
  CC      arch/ARM/ARMInstPrinter.o
  CC      arch/ARM/ARMMapping.o
  CC      arch/ARM/ARMModule.o
  CC      arch/AArch64/AArch64BaseInfo.o
  CC      arch/AArch64/AArch64Disassembler.o
  CC      arch/AArch64/AArch64InstPrinter.o
  CC      arch/AArch64/AArch64Mapping.o
  CC      arch/AArch64/AArch64Module.o
  CC      arch/Mips/MipsDisassembler.o
  CC      arch/Mips/MipsInstPrinter.o
  CC      arch/Mips/MipsMapping.o
  CC      arch/Mips/MipsModule.o
  CC      arch/PowerPC/PPCDisassembler.o
  CC      arch/PowerPC/PPCInstPrinter.o
  CC      arch/PowerPC/PPCMapping.o
  CC      arch/PowerPC/PPCModule.o
  CC      arch/Sparc/SparcDisassembler.o
  CC      arch/Sparc/SparcInstPrinter.o
  CC      arch/Sparc/SparcMapping.o
  CC      arch/Sparc/SparcModule.o
  CC      arch/SystemZ/SystemZDisassembler.o
  CC      arch/SystemZ/SystemZInstPrinter.o
  CC      arch/SystemZ/SystemZMapping.o
  CC      arch/SystemZ/SystemZModule.o
  CC      arch/SystemZ/SystemZMCTargetDesc.o
  CC      arch/X86/X86DisassemblerDecoder.o
  CC      arch/X86/X86Disassembler.o
  CC      arch/X86/X86IntelInstPrinter.o
  CC      arch/X86/X86ATTInstPrinter.o
  CC      arch/X86/X86Mapping.o
  CC      arch/X86/X86Module.o
  CC      arch/XCore/XCoreDisassembler.o
  CC      arch/XCore/XCoreInstPrinter.o
  CC      arch/XCore/XCoreMapping.o
  CC      arch/XCore/XCoreModule.o
  CC      MCInst.o
  AR      capstone.lib
i686-w64-mingw32.shared-ar: creating
/home/phil/source/qemu/build/win32/capstone/capstone.lib
  RC      version.o
...
  GEN     nbd/trace.c
  GEN     scsi/trace.c
mkdir -p dtc/libfdt
mkdir -p dtc/tests
make[1]: '/home/phil/source/qemu/build/win32/capstone/capstone.lib' is
up to date.
  GEN     qemu-img-cmds.h
  CC      qemu-img.o
...
  CC      stubs/xen-hvm.o
  CC      stubs/pci-host-piix.o
  AR      libqemuutil.a
  LINK    qemu-img.exe

$ file build/win32/qemu-img.exe
build/win32/qemu-img.exe: PE32 executable (console) Intel 80386, for MS
Windows

and with:

$ docker run --rm -v $(pwd):$(pwd) -w $(pwd) -u $(id -u) \
  qemu:debian-win64-cross bash -c \
  'mkdir -p build/win64 && cd build/win64 && ../../configure
--cross-prefix=x86_64-w64-mingw32.shared- && make qemu-img.exe'
...
  CC      arch/XCore/XCoreMapping.o
  CC      arch/XCore/XCoreModule.o
  CC      MCInst.o
  AR      capstone.lib
x86_64-w64-mingw32.shared-ar: creating
/home/phil/source/qemu/build/win64/capstone/capstone.lib
  RC      version.o
  GEN     qemu-options.def
...
  AR      libqemuutil.a
  LINK    qemu-img.exe
$ file build/win64/qemu-img.exe
build/win64/qemu-img.exe: PE32+ executable (console) x86-64, for MS Windows

What mingw toolchain are you using?

Regards,

Phil.
