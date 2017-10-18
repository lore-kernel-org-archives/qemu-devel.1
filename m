Received: from eggs.gnu.org ([2001:4830:134:3::10]:44188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e4pgJ-0000OV-Sv
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e4pgG-0007h1-SJ
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:50:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:53358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e4pgG-0007ga-LO
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:50:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e4pgE-00051M-HU
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 14:50:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 293AC2E819D
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 14:50:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Oct 2017 14:40:55 -0000
From: Willem Mulder <willemmaster@hotmail.com>
Reply-To: Bug 1724590 <1724590@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150833765599.17635.13860559072232712887.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1724590] [NEW] Usermode networking hostfwd only
 listens on IPv4
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

When forwarding ports in usermode networking (-net user,hostfwd=3D), QEMU
binds to IPv4 only. Therefore, connecting to the port over IPv6 results
in 'connection refused'.

I experienced this in QEMU 2.10.1, but it looks to still be present in
the current master (861cd431c99e56ddb5953ca1da164a9c32b477ca), since
slirp_hostfwd in net/slirp.c uses in_addr instead of in6_addr.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1724590

Title:
  Usermode networking hostfwd only listens on IPv4

Status in QEMU:
  New

Bug description:
  When forwarding ports in usermode networking (-net user,hostfwd=3D),
  QEMU binds to IPv4 only. Therefore, connecting to the port over IPv6
  results in 'connection refused'.

  I experienced this in QEMU 2.10.1, but it looks to still be present in
  the current master (861cd431c99e56ddb5953ca1da164a9c32b477ca), since
  slirp_hostfwd in net/slirp.c uses in_addr instead of in6_addr.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1724590/+subscriptions
