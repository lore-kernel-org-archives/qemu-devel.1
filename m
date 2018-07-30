Received: from eggs.gnu.org ([2001:4830:134:3::10]:41480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fkDQD-0005Sq-1f
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 15:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fkDQ9-0000GK-21
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 15:01:33 -0400
Received: from indium.canonical.com ([91.189.90.7]:57352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fkDQ8-0000GA-Rg
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 15:01:28 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fkDQ6-0002Z9-Oq
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 19:01:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E4E5D2E8193
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 19:01:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Jul 2018 18:47:40 -0000
From: Tristan Burgess <1720969@bugs.launchpad.net>
Reply-To: Bug 1720969 <1720969@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150701930722.20909.12415412860482115977.malonedeb@soybean.canonical.com>
Message-Id: <153297646059.4662.8360227578676793394.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1720969] Re: qemu/memory.c:206: pointless copies
 of large structs ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix committed and sent upstream:
https://github.com/qemu/qemu/commit/73bb753d24a702b37913ce4b5ddb6dca40dab067

** Changed in: qemu
       Status: New =3D> Fix Committed

** Changed in: qemu
     Assignee: (unassigned) =3D> Tristan Burgess (tburgessdev)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1720969

Title:
  qemu/memory.c:206:  pointless copies of large structs ?

Status in QEMU:
  Fix Committed

Bug description:
  [qemu/memory.c:206]: (performance) Function parameter 'a' should be passe=
d by reference.
  [qemu/memory.c:207]: (performance) Function parameter 'b' should be passe=
d by reference.

  Source code is

  static bool memory_region_ioeventfd_equal(MemoryRegionIoeventfd a,
                                            MemoryRegionIoeventfd b)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1720969/+subscriptions
