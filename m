Received: from eggs.gnu.org ([2001:4830:134:3::10]:48275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f6zxj-0002uZ-Hy
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f6zxg-0002dS-Fr
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:46:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:46516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f6zxg-0002bw-9u
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:46:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f6zxe-0002JR-KA
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 14:45:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 976D42E80CF
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 14:45:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Apr 2018 14:27:49 -0000
From: Thomas Huth <1126369@bugs.launchpad.net>
Reply-To: Bug 1126369 <1126369@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130215160748.9226.2053.malonedeb@gac.canonical.com>
Message-Id: <152362966986.23464.7247155250850334343.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1126369] Re: qemu-img snapshot -c is unreasonably
 slow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... have this issue been fixed, i.e.
could we close this ticket nowadays? Or is there still something left to
do?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1126369

Title:
  qemu-img snapshot -c is unreasonably slow

Status in QEMU:
  Incomplete

Bug description:
  Something fishy is going on with qcow2 internal snapshot creation
  times.  I don't know if this is a regression because I haven't used
  internal snapshots in the past.

  QEMU 1.4-rc2:
  $ qemu-img create -f qcow2 test.qcow2 -o size=3D50G,preallocation=3Dmetad=
ata
  $ time qemu-img snapshot -c new test.qcow2
  real	3m39.147s
  user	0m10.748s
  sys	0m26.165s

  (This is on an SSD)

  I expect snapshot creation to take under 1 second.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1126369/+subscriptions
