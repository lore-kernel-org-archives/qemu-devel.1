Received: from eggs.gnu.org ([2001:4830:134:3::10]:47818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cT5oP-00024L-O1
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cT5oN-0007sL-UG
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:50:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:34554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cT5oN-0007s1-O8
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:50:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cT5oL-0006Bu-DW
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:50:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0C69E2E817B
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:50:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Jan 2017 11:45:06 -0000
From: Thomas Huth <1630527@bugs.launchpad.net>
Reply-To: Bug 1630527 <1630527@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161005105036.22226.42277.malonedeb@soybean.canonical.com>
Message-Id: <20170116114506.20360.54852.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1630527] Re: qemu/hw/i386/amd_iommu.c:188:
 possible bad shift ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Released with v2.8

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1630527

Title:
  qemu/hw/i386/amd_iommu.c:188: possible bad shift ?

Status in QEMU:
  Fix Released

Bug description:
  qemu/hw/i386/amd_iommu.c:188]: (error) Shifting 32-bit value by 64
  bits is undefined behaviour

  Source code is

      uint64_t mask =3D ((1 << length) - 1) << bitpos;

  Maybe better code

      uint64_t mask =3D ((1ULL << length) - 1) << bitpos;

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1630527/+subscriptions
