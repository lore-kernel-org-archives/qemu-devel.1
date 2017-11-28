Received: from eggs.gnu.org ([2001:4830:134:3::10]:45589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eJbfQ-0007SA-G2
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 03:55:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eJbfN-0005es-Dw
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 03:55:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:41194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eJbfN-0005eY-7f
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 03:54:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eJbfL-0004fG-4Q
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 08:54:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 109FA2E80C8
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 08:54:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Nov 2017 08:43:02 -0000
From: Thomas Huth <1591611@bugs.launchpad.net>
Reply-To: Bug 1591611 <1591611@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160612061620.2663.17249.malonedeb@chaenomeles.canonical.com>
Message-Id: <151185858282.3366.5687132391413054055.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1591611] Re: chroot using qemu-x86_64-static
 fails on ppc64el
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1591611

Title:
  chroot using qemu-x86_64-static fails on ppc64el

Status in QEMU:
  Fix Released

Bug description:
  When attempting to use qemu-x86_64-static from qemu 2.5.0 on a ppc64el
  host to chroot into an amd64 environment, all commands fail with an
  assertion error.  /usr/bin/qemu-x86_64-static from the host was copied
  into the chroot /usr/bin, and the host has multiformat support in the
  kernel.

  Sample output illustrating the problem, as well as bash builtins
  working:

  # chroot /virtualbox/scratchdisks_local_001/amd64_chroot qemu-x86_64-stat=
ic /bin/bash
  # ls
  bash: ../sysdeps/nptl/fork.c:136: __libc_fork: Assertion `({ __typeof (se=
lf->tid) __value; if (sizeof (__value) =3D=3D 1) asm volatile ("movb %%fs:%=
P2,%b0" : "=3Dq" (__value) : "0" (0), "i" (__builtin_offsetof (struct pthre=
ad, tid))); else if (sizeof (__value) =3D=3D 4) asm volatile ("movl %%fs:%P=
1,%0" : "=3Dr" (__value) : "i" (__builtin_offsetof (struct pthread, tid)));=
 else { if (sizeof (__value) !=3D 8) abort (); asm volatile ("movq %%fs:%P1=
,%q0" : "=3Dr" (__value) : "i" (__builtin_offsetof (struct pthread, tid)));=
 } __value; }) !=3D ppid' failed.
  setup_frame: not implemented
  setup_frame: not implemented
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault
  setup_frame: not implemented
  setup_frame: not implemented
  # echo TEST
  TEST
  # cat test
  bash: ../sysdeps/nptl/fork.c:136: __libc_fork: Assertion `({ __typeof (se=
lf->tid) __value; if (sizeof (__value) =3D=3D 1) asm volatile ("movb %%fs:%=
P2,%b0" : "=3Dq" (__value) : "0" (0), "i" (__builtin_offsetof (struct pthre=
ad, tid))); else if (sizeof (__value) =3D=3D 4) asm volatile ("movl %%fs:%P=
1,%0" : "=3Dr" (__value) : "i" (__builtin_offsetof (struct pthread, tid)));=
 else { if (sizeof (__value) !=3D 8) abort (); asm volatile ("movq %%fs:%P1=
,%q0" : "=3Dr" (__value) : "i" (__builtin_offsetof (struct pthread, tid)));=
 } __value; }) !=3D ppid' failed.
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault

  It is currently unknown if other host architectures (e.g. aarch64) are
  also affected.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1591611/+subscriptions
