Received: from eggs.gnu.org ([2001:4830:134:3::10]:36917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ew8Xa-00063N-4I
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ew8XW-00037m-1e
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:42:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:37120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ew8XV-000372-Q4
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:42:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ew8XT-00088t-Uu
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 15:42:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BADDD2E80CD
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 15:42:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Mar 2018 15:32:39 -0000
From: James Cowgill <jcowgill@debian.org>
Reply-To: Bug 1754372 <1754372@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152052329803.20387.7205053769147453578.malonedeb@chaenomeles.canonical.com>
Message-Id: <152104156018.15023.18080871606430166338.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1754372] Re: Set MIPS MSA in ELF Auxiliary Vectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Patch:
https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg04399.html

** Changed in: qemu
       Status: New =3D> In Progress

** Changed in: qemu
     Assignee: (unassigned) =3D> James Cowgill (jcowgill)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1754372

Title:
  Set MIPS MSA in ELF Auxiliary Vectors

Status in QEMU:
  In Progress

Bug description:
  The MIPS MSA feature is currently not set in the ELF auxiliary vector.

  That is, querying the AT_HWCAP key of the ELF auxiliary vectors for a
  MIPS CPU that has the MSA feature should return a value that has the
  second bit [0] set.

  From [0], `HWCAP_MIPS_MSA` is defined to `1 << 1`.

  [0]:
  https://github.com/torvalds/linux/blob/master/arch/mips/include/uapi/asm/=
hwcap.h

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1754372/+subscriptions
