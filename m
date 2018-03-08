Received: from eggs.gnu.org ([2001:4830:134:3::10]:56178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1etxf4-0000c9-8p
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1etxf1-00053H-63
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:40:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:57710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1etxf0-00052l-V4
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:40:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1etxez-0003on-ND
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 15:40:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8C78D2E80C8
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 15:40:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Mar 2018 15:34:57 -0000
From: Gonzalo <1754372@bugs.launchpad.net>
Reply-To: Bug 1754372 <1754372@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152052329803.20387.7205053769147453578.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1754372] [NEW] Set MIPS MSA in ELF Auxiliary
 Vectors
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

The MIPS MSA feature is currently not set in the ELF auxiliary vector.

That is, querying the AT_HWCAP key of the ELF auxiliary vectors for a
MIPS CPU that has the MSA feature should return a value that has the
second bit [0] set.

>From [0], `HWCAP_MIPS_MSA` is defined to `1 << 1`.

[0]:
https://github.com/torvalds/linux/blob/master/arch/mips/include/uapi/asm/hw=
cap.h

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1754372

Title:
  Set MIPS MSA in ELF Auxiliary Vectors

Status in QEMU:
  New

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
