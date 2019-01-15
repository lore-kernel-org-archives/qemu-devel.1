Received: from eggs.gnu.org ([209.51.188.92]:57803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gjUUx-0006W9-Ta
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gjUUv-00078f-1e
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:35:43 -0500
Received: from indium.canonical.com ([91.189.90.7]:58566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gjUUt-0006u6-Nr
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:35:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gjUUk-0005k3-Ty
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 19:35:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D1BB62E80C8
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 19:35:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Jan 2019 19:25:33 -0000
From: Lukasz Janyst <xyz@jany.st>
Reply-To: Bug 1811888 <1811888@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154758033350.20612.10612778559248871550.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1811888] [NEW] Qemu refuses to multiboot Elf64
 kernels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Qemu does not multiboot Elf64 bit kernels when emulating x86_64 systems.
This is unfortunate because it renders the `-kernel` option quite
useless. It's true that a multiboot compatible bootloader puts you in
protected mode by default, and you have to set up the long mode
yourself. While it is easy to put such 32-bit bootstrap code in a 64 bit
binary, it is not possible to compile a 64 bit kernel into a 32 bit
binary.

After quick search, it turned out that loading 64 bit elf binaries has
been disabled to be compatible with GRUB. However, since that time, both
GRUB and Syslinux load 64 bit ELF kernels just fine, which makes qemu
incompatible with them. Furthermore, it seems that this feature does and
has always worked fine and that people have since submitted patches to
re-enable it.

https://patchwork.ozlabs.org/patch/62142/
https://patchwork.kernel.org/patch/9770523/

Please consider applying the attached patch.

Best Regards,
Lukasz Janyst

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "0001-hw-i386-multiboot.c-Don-t-refuse-to-boot-ELF64-b=
inar.patch"
   https://bugs.launchpad.net/bugs/1811888/+attachment/5229414/+files/0001-=
hw-i386-multiboot.c-Don-t-refuse-to-boot-ELF64-binar.patch

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1811888

Title:
  Qemu refuses to multiboot Elf64 kernels

Status in QEMU:
  New

Bug description:
  Qemu does not multiboot Elf64 bit kernels when emulating x86_64
  systems. This is unfortunate because it renders the `-kernel` option
  quite useless. It's true that a multiboot compatible bootloader puts
  you in protected mode by default, and you have to set up the long mode
  yourself. While it is easy to put such 32-bit bootstrap code in a 64
  bit binary, it is not possible to compile a 64 bit kernel into a 32
  bit binary.

  After quick search, it turned out that loading 64 bit elf binaries has
  been disabled to be compatible with GRUB. However, since that time,
  both GRUB and Syslinux load 64 bit ELF kernels just fine, which makes
  qemu incompatible with them. Furthermore, it seems that this feature
  does and has always worked fine and that people have since submitted
  patches to re-enable it.

  https://patchwork.ozlabs.org/patch/62142/
  https://patchwork.kernel.org/patch/9770523/

  Please consider applying the attached patch.

  Best Regards,
  Lukasz Janyst

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1811888/+subscriptions
