Received: from eggs.gnu.org ([2001:4830:134:3::10]:49636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds1v1-0005Ta-8f
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds1v0-0002kK-0K
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:17:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:36174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ds1uz-0002jj-QA
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:17:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ds1uy-0008Cq-B5
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:17:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 52DD72E8496
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:17:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Sep 2017 07:00:30 -0000
From: Thomas Huth <502107@bugs.launchpad.net>
Reply-To: Bug 502107 <502107@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100101165222.10901.36970.malonedeb@potassium.ubuntu.com>
Message-Id: <150528603048.13585.9006215822375821349.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 502107] Re: qemu-kvm 0.12.1.2 crashes booting
 Ubuntu 9.10 with "-vga std"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

There hasn't been a reply to my question in the last comment within
months, so I assume nobody cares about this anymore. So I'm closing this
ticket now...

** Changed in: qemu
       Status: Incomplete =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/502107

Title:
  qemu-kvm 0.12.1.2 crashes booting Ubuntu 9.10 with "-vga std"

Status in QEMU:
  Won't Fix

Bug description:
  I have an Ubuntu VM that works fine without "-vga std" but crashes if
  I add "-vga std".  This is the full command line:

  qemu-system-x86_64 -vga std -drive
  cache=3Dwriteback,index=3D0,media=3Ddisk,file=3Dubuntu.img -k en-us -m 20=
48 -smp 2 -vnc
  :3102 -usbdevice tablet -enable-kvm &

  I get this error:

   KVM internal error. Suberror: 1
  rax 00007f789177e000 rbx 0000000000000000 rcx 0000000000000000 rdx
  0000000000000000
  rsi 0000000000000000 rdi 00007f789177e000 rsp 00007fff361775e8 rbp
  00007fff36177600
  r8  000000000000ff80 r9  0000000000200000 r10 0000000000000000 r11
  00007f789100a3f0
  r12 00000000004017c0 r13 00007fff36178cf0 r14 0000000000000000 r15
  0000000000000000
  rip 00007f789100aa7b rflags 00013206
  cs 0033 (00000000/ffffffff p 1 dpl 3 db 0 s 1 type b l 1 g 1 avl 0)
  ds 0000 (00000000/ffffffff p 0 dpl 0 db 0 s 0 type 0 l 0 g 0 avl 0)
  es 0000 (00000000/ffffffff p 0 dpl 0 db 0 s 0 type 0 l 0 g 0 avl 0)
  ss 002b (00000000/ffffffff p 1 dpl 3 db 1 s 1 type 3 l 0 g 1 avl 0)
  fs 0000 (7f78917906f0/ffffffff p 0 dpl 0 db 0 s 0 type 0 l 0 g 0 avl 0)
  gs 0000 (00000000/ffffffff p 0 dpl 0 db 0 s 0 type 0 l 0 g 0 avl 0)
  tr 0040 (ffff880001a09440/00002087 p 1 dpl 0 db 0 s 0 type b l 0 g 0 avl =
0)
  ldt 0000 (00000000/ffffffff p 0 dpl 0 db 0 s 0 type 0 l 0 g 0 avl 0)
  gdt ffff8800019fa000/7f
  idt ffffffff818fd000/fff
  cr0 80050033 cr2 2408000 cr3 379d4000 cr4 6f0 cr8 0 efer d01
  emulation failure, check dmesg for details

  I'm running kernel 2.6.32, and I have the kvm stuff compiled directly int=
o the
  kernel.  There's nothing in dmesg about kvm at all.

  Note that in the VM grub comes up, but the VM dies when I boot the
  kernel.

  This command line works:

  qemu-system-x86_64 -drive cache=3Dwriteback,index=3D0,media=3Ddisk,file=
=3Dubuntu.img -k
  en-us -m 2048 -smp 2 -vnc :3102 -usbdevice tablet -enable-kvm &

  That is, removing "-vga std" fixes the problem.

  I recently added this option to both my Ubuntu and Windows XP VMs.
  The Windows VM still works fine.  If Windows can detect that the
  graphics card has changed, then Ubuntu should also have no problem.
  That being said, I added the std option when using 0.12.1.1, so there
  may be a qemu regression.

  I have reported this bug elsewhere:
  http://bugs.gentoo.org/show_bug.cgi?id=3D299211

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/502107/+subscriptions
