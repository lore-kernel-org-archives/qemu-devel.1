Received: from eggs.gnu.org ([2001:4830:134:3::10]:55295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cM5sL-0003PV-U7
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 23:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cM5sI-0003l7-Dv
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 23:30:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:43253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cM5sI-0003km-9I
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 23:30:02 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cM5sF-0001MX-8n
	for <qemu-devel@nongnu.org>; Wed, 28 Dec 2016 04:29:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E90C32EA030
	for <qemu-devel@nongnu.org>; Wed, 28 Dec 2016 04:29:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Dec 2016 04:17:26 -0000
From: Launchpad Bug Tracker <584514@bugs.launchpad.net>
Reply-To: Bug 584514 <584514@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100523103436.31931.34662.malonedeb@wampee.canonical.com>
Message-Id: <20161228041726.17184.70734.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 584514] Re: Qemu-KVM 0.12.4 Guest entered Paused
 State
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/584514

Title:
  Qemu-KVM 0.12.4 Guest entered Paused State

Status in QEMU:
  Expired

Bug description:
  I recently had a 0.12.4 qemu-kvm with a debian lenny guest which
  occasionally paused.

  There was no memory exhaustion as suggested earlier.

  qemu-kvm send the following output::

  VM internal error. Suberror: 1
  rax 0000000000000100 rbx ffff880017585bc0 rcx 00007f84c6d5b000 rdx 000000=
0000000001
  rsi 0000000000000000 rdi ffff88001d322dec rsp ffff88001e133e88 rbp ffff88=
001e133e88
  r8  0000000001f25bc2 r9  0000000000000007 r10 00007f84c6b4d97b r11 000000=
0000000206
  r12 ffff88001d322dec r13 ffff88001d322de8 r14 0000000000000001 r15 000000=
0000000000
  rip ffffffff81039719 rflags 00010092
  cs 0010 (00000000/ffffffff p 1 dpl 0 db 0 s 1 type b l 1 g 1 avl 0)
  ds 0000 (00000000/ffffffff p 0 dpl 0 db 0 s 0 type 0 l 0 g 0 avl 0)
  es 0000 (00000000/ffffffff p 0 dpl 0 db 0 s 0 type 0 l 0 g 0 avl 0)
  ss 0018 (00000000/ffffffff p 1 dpl 0 db 1 s 1 type 3 l 0 g 1 avl 0)
  fs 0000 (7f84c6d53700/ffffffff p 0 dpl 0 db 0 s 0 type 0 l 0 g 0 avl 0)
  gs 0000 (ffff880001d00000/ffffffff p 0 dpl 0 db 0 s 0 type 0 l 0 g 0 avl =
0)
  tr 0040 (ffff880001d13780/00002087 p 1 dpl 0 db 0 s 0 type b l 0 g 0 avl =
0)
  ldt 0000 (00000000/ffffffff p 0 dpl 0 db 0 s 0 type 0 l 0 g 0 avl 0)
  gdt ffff880001d04000/7f
  idt ffffffff8195e000/fff
  cr0 80050033 cr2 7f84c6b38ec8 cr3 1db7d000 cr4 6e0 cr8 0 efer 501
  emulation failure, check dmesg for details

  Unfortunately, I found nothing in syslog or dmesg

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/584514/+subscriptions
