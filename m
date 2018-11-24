Received: from eggs.gnu.org ([2001:4830:134:3::10]:59878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gQPZq-0003Cd-Th
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 23:29:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gQPZn-0006M4-MD
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 23:29:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:33570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gQPZn-0006LE-G3
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 23:29:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gQPZl-0006SZ-9B
	for <qemu-devel@nongnu.org>; Sat, 24 Nov 2018 04:29:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 367D32E80C8
	for <qemu-devel@nongnu.org>; Sat, 24 Nov 2018 04:29:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Nov 2018 04:17:18 -0000
From: Launchpad Bug Tracker <1498144@bugs.launchpad.net>
Reply-To: Bug 1498144 <1498144@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150921190459.9354.26190.malonedeb@gac.canonical.com>
Message-Id: <154303304039.13818.3742370890628333116.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1498144] Re: Failure booting hurd with
 qemu-system-i386 on ARM
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
https://bugs.launchpad.net/bugs/1498144

Title:
   Failure booting hurd with qemu-system-i386 on ARM

Status in QEMU:
  Expired

Bug description:
  Trying to boot debian-hurd-20150320.img ends with:

  qemu-system-i386: qemu-coroutine-lock.c:91: qemu_co_queue_restart_all:
  Assertion `qemu_in_coroutine()' failed.

  Program received signal SIGABRT, Aborted.
  __libc_do_syscall ()
  =C2=A0=C2=A0=C2=A0=C2=A0at ../ports/sysdeps/unix/sysv/linux/arm/libc-do-s=
yscall.S:44
  44      ../ports/sysdeps/unix/sysv/linux/arm/libc-do-syscall.S: No such f=
ile or directory.
  (gdb) bt
  #0  __libc_do_syscall ()
  =C2=A0=C2=A0=C2=A0=C2=A0at ../ports/sysdeps/unix/sysv/linux/arm/libc-do-s=
yscall.S:44
  #1  0xb6ef8f0e in __GI_raise (sig=3Dsig@entry=3D6)
  =C2=A0=C2=A0=C2=A0=C2=A0at ../nptl/sysdeps/unix/sysv/linux/raise.c:56
  #2  0xb6efb766 in __GI_abort () at abort.c:89
  #3  0xb6ef4150 in __assert_fail_base (
  =C2=A0=C2=A0=C2=A0=C2=A0fmt=3D0x1 <error: Cannot access memory at address=
 0x1>,
  =C2=A0=C2=A0=C2=A0=C2=A0assertion=3D0x7f89a234 "qemu_in_coroutine()", ass=
ertion@entry=3D0x0,
  =C2=A0=C2=A0=C2=A0=C2=A0file=3D0x7f89da58 "qemu-coroutine-lock.c", file@e=
ntry=3D0xb5660000 "\001",
  =C2=A0=C2=A0=C2=A0=C2=A0line=3D91, line@entry=3D3069931692,
  =C2=A0=C2=A0=C2=A0=C2=A0function=3Dfunction@entry=3D0x7f89ab78 "qemu_co_q=
ueue_restart_all")
  =C2=A0=C2=A0=C2=A0=C2=A0at assert.c:92
  #4  0xb6ef41e6 in __GI___assert_fail (assertion=3D0x0, file=3D0xb5660000 =
"\001",
  =C2=A0=C2=A0=C2=A0=C2=A0line=3D3069931692, function=3D0x7f89ab78 "qemu_co=
_queue_restart_all")
  =C2=A0=C2=A0=C2=A0=C2=A0at assert.c:101
  #5  0x7f59a6b4 in ?? ()

  I was using the same setup as in Bug 893208 (i.e git checkout from
  2015-09-15, armv7 Odroid C1)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1498144/+subscriptions
