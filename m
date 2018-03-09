Received: from eggs.gnu.org ([2001:4830:134:3::10]:35733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1euFDa-00012O-CG
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1euFDW-0000wd-Cs
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:25:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:51804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1euFDW-0000vy-62
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:25:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1euFDU-0007Ag-Nw
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 10:25:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AC7D42E80D9
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 10:25:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Mar 2018 10:17:10 -0000
From: "R.Nageswara Sastry" <nasastry@in.ibm.com>
Reply-To: Bug 1754605 <1754605@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152058822581.6957.10194412768738269736.malonedeb@gac.canonical.com>
Message-Id: <152059063043.7284.14082205524402869726.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1754605] Re: ppc64 migration bad_dest test is
 failed with failed to connect to socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thank you very much for your quick reply.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1754605

Title:
  ppc64 migration bad_dest test is failed with failed to connect to
  socket

Status in QEMU:
  In Progress

Bug description:
  On ppc64le machine the following test failed.

  # QTEST_QEMU_BINARY=3Dppc64-softmmu/qemu-system-ppc64 tests/migration-tes=
t V=3D1
  /ppc64/migration/deprecated: OK
  /ppc64/migration/bad_dest: qemu-system-ppc64: Failed to connect socket: C=
onnection refused
  OK
  /ppc64/migration/postcopy/unix: OK

  Head is at f6d81cdec807bb85325afedb536b17c5331483c7
  configured with options: configure --target-list=3Dppc64-softmmu

  This test case is added through
  2c9bb29703caa8fd31078cc38b3b53762557c27c

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1754605/+subscriptions
