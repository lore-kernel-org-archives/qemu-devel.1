Received: from eggs.gnu.org ([2001:4830:134:3::10]:51371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eekk8-0003fJ-HH
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:51:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eekk3-0004sS-TW
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:51:16 -0500
Received: from indium.canonical.com ([91.189.90.7]:44266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eekk3-0004rb-MN
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:51:11 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eekk2-0003Rg-6i
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 16:51:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1DF922E854F
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 16:51:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jan 2018 16:43:41 -0000
From: John Arbuckle <programmingkidx@gmail.com>
Reply-To: Bug 1737194 <1737194@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151274735709.11243.12332071284435970530.malonedeb@soybean.canonical.com>
	<151686682161.4861.8851702267220024380.malone@wampee.canonical.com>
	<F19A160D-99BC-4170-B544-8BAFFC23FE83@gmail.com>
	<CAFEAcA9vJ7A+J2OSPNsfyT575p+heE5o_++T-Jtp6S3dyG3NTQ@mail.gmail.com>
Message-Id: <5FD1490A-41F7-4200-AB5C-3802358E1362@gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1737194] Re: Windows NT 4.0 fails to boot
 from qcow2 installation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

> On Jan 25, 2018, at 11:16 AM, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> =

> On 25 January 2018 at 15:58, John Arbuckle <programmingkidx@gmail.com> wr=
ote:
>> I did try to build at commits 306ec6c3cece7004429c79c1ac93d49919f1f1cc
>> and e689f7c668cbd9d08f330e17c3dd3a059c9553d3. Both failed to build on my
>> Mac OS X system. Here is the error message I usually saw:
>> =

>>  LINK  qemu-io
>> Undefined symbols for architecture x86_64:
>>  "_use_rt_clock", referenced from:
>>      _bdrv_acct_start in block.o
>>      _bdrv_acct_done in block.o
>> Undefined symbols for architecture x86_64:
>>      _qemu_clock_get_ns in qemu-timer.o
>>  "_use_rt_clock", referenced from:
>>      _bdrv_acct_start in block.o
>>      _bdrv_acct_done in block.o
>>      _qemu_clock_get_ns in qemu-timer.o
> =

> If you configure with --disable-tools does it manage to build,
> or does it just go on to fail to link the main QEMU binary
> with the same error? (We've had some issues in the past I think
> where configure put libraries on the main binary link line but
> not on the tools link lines, so maybe worth a try...)
> =

> thanks
> -- PMM
> =


It still fails to build:

Build commands: ./configure --disable-tools --target-list=3Di386-softmmu
&& make -j 4

QEMU at commit: 306ec6c3cece7004429c79c1ac93d49919f1f1cc

  LINK  i386-softmmu/qemu-system-i386
Undefined symbols for architecture x86_64:
  "_use_rt_clock", referenced from:
      _bdrv_acct_start in block.o
      _bdrv_acct_done in block.o
      _qemu_clock_get_ns in qemu-timer.o
      _cpu_get_clock in cpus.o
      _cpu_enable_ticks in cpus.o
      _cpu_disable_ticks in cpus.o
      _icount_warp_rt in cpus.o
      ...
ld: symbol(s) not found for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocat=
ion)
make[1]: *** [qemu-system-i386] Error 1
make: *** [subdir-i386-softmmu] Error 2

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1737194

Title:
  Windows NT 4.0 fails to boot from qcow2 installation

Status in QEMU:
  New

Bug description:
  Windows NT 4.0 will not boot from an installation more than once if
  installed in a qcow2 image file. A quick fix to this problem is to use
  the qcow format instead.

  Steps to reproduce this issue:

  Create the image file:
  qemu-img create -f qcow2 winnt4.qcow2 1G

  Boot from a Windows NT 4.0 Workstation CD:
  qemu-system-i386 -hda winnt4.qcow2 -cdrom /dev/cdrom -boot d -m 128 -cpu =
pentium -vga cirrus

  During the installation process you have the choise between FAT and
  NTFS. You can pick anyone.

  After finishing the installation the guest will reboot to install
  additional items. Once this is done the guest will be bootable. Eject
  any CD media from QEMU and reboot. You will then see Windows NT 4.0
  booting up to the desktop. Go to "Start->Shut down" to shut down. Then
  when Windows is ready quit QEMU.

  Now try to boot using this command:
  qemu-system-i386 -hda winnt4.qcow2 -boot c -m 128 -cpu pentium -vga cirru=
s =

   =

  The BIOS screen will display an error message:

  For NTFS: =

  Booting from Hard Disk...
  A disk read error occurred.
  Insert a system diskette and restart
  the system.

  For FAT:
  No bootable device.

  Additional information:
  qemu-system-i386 version: 2.10.1
  qemu-img version: 2.10.92 (v2.11.0-rc4-dirty)

  If you don't have a Windows NT 4.0 Workstation installation CD, you may d=
ownload one from here:
  https://winworldpc.com/product/windows-nt-40/40

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1737194/+subscriptions
