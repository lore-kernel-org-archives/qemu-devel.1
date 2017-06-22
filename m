Received: from eggs.gnu.org ([2001:4830:134:3::10]:33783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dO0iZ-0002yU-7z
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 07:56:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dO0iV-00051F-Ab
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 07:56:11 -0400
Received: from indium.canonical.com ([91.189.90.7]:44345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dO0iV-00050e-4Z
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 07:56:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dO0iT-0001Qd-VE
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 11:56:06 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EA33D2E8190
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 11:56:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Jun 2017 11:43:39 -0000
From: Thomas Huth <1169049@bugs.launchpad.net>
Reply-To: Bug 1169049 <1169049@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130415064224.30409.36499.malonedeb@soybean.canonical.com>
Message-Id: <149813181958.3205.14503451767104433187.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1169049] Re: do not stop on first gdb breakpoint
 with -enable-kvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Which Linux kernel version were you using here? Can you still reproduce
this problem with the latest Linux kernel version, and the latest
version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1169049

Title:
  do not stop on first gdb breakpoint with -enable-kvm

Status in QEMU:
  Incomplete

Bug description:
  I run qemu like this:
    qemu-system-x86-64 -enable-kvm -hda <path to file> -s -S,

  and start gdb with commands like this:
    gdb>tartget remote localhost:1234
    gdb>break *0x7c00
    gdb>c

  but gdb don't stop on it. I then could break execution manually and
  then breakpoints work.

  QEMU version: 1.4.0 (from Debian repos)
  GDB version: 7.5.1 (copiled from sources, but previous was 7.4.1 from Deb=
ian repo)

  PS Same problem occure on Ubuntu 13.04 with same Qemu and Gdb 7.5.0
  from repo.

  Thank you

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1169049/+subscriptions
