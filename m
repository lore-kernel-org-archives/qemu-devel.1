Received: from eggs.gnu.org ([2001:4830:134:3::10]:60732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dOSnq-0006WB-5R
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 13:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dOSnm-0007gA-8G
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 13:55:30 -0400
Received: from indium.canonical.com ([91.189.90.7]:41344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dOSnm-0007fH-26
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 13:55:26 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dOSnk-0001i1-So
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 17:55:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D1F1C2E80E6
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 17:55:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Jun 2017 17:42:04 -0000
From: Thomas Huth <1169049@bugs.launchpad.net>
Reply-To: Bug 1169049 <1169049@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130415064224.30409.36499.malonedeb@soybean.canonical.com>
Message-Id: <149823972393.3432.15639340074386619916.malone@chaenomeles.canonical.com>
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

Ok, anyway, thanks for your reply! So let's close this ticket now...

** Changed in: qemu
       Status: Incomplete =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1169049

Title:
  do not stop on first gdb breakpoint with -enable-kvm

Status in QEMU:
  Won't Fix

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
