Received: from eggs.gnu.org ([2001:4830:134:3::10]:35916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d5BOL-00013R-Cl
	for qemu-devel@nongnu.org; Mon, 01 May 2017 09:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d5BOG-0007QF-CG
	for qemu-devel@nongnu.org; Mon, 01 May 2017 09:29:29 -0400
Received: from indium.canonical.com ([91.189.90.7]:42926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d5BOG-0007Q0-6j
	for qemu-devel@nongnu.org; Mon, 01 May 2017 09:29:24 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d5BOE-0006uc-8m
	for <qemu-devel@nongnu.org>; Mon, 01 May 2017 13:29:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3759C2E807D
	for <qemu-devel@nongnu.org>; Mon,  1 May 2017 13:29:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 May 2017 13:20:20 -0000
From: Thomas Huth <985288@bugs.launchpad.net>
Reply-To: Bug 985288 <985288@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120418224744.9275.96744.malonedeb@soybean.canonical.com>
Message-Id: <20170501132020.2519.81825.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 985288] Re: scsi disk emulation doesn't enforce
 FUA (Force Unit Access) in write-back mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you still reproduce this problem with the latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/985288

Title:
  scsi disk emulation doesn't enforce FUA (Force Unit Access) in write-
  back mode

Status in QEMU:
  Incomplete

Bug description:
  Microsoft NTFS utilizes the FUA bit in SCSI WRITE CDBs to insure
  integrity when a device advertises that it has write caching enabled.
  The FUA bit is meant to ensure a write is written to non-volatile
  storage before returning.  This seems to not be enforced by QEMU's
  SCSI emulation code.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/985288/+subscriptions
