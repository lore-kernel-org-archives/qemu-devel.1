Received: from eggs.gnu.org ([2001:4830:134:3::10]:43241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZzeS-0003Ax-NX
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:45:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZzeO-00084E-QU
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:45:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:36564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eZzeO-00082a-GX
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:45:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eZzeN-0001rj-JZ
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 13:45:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8F0D82E80C8
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 13:45:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jan 2018 13:32:51 -0000
From: Thomas Huth <985288@bugs.launchpad.net>
Reply-To: Bug 985288 <985288@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120418224744.9275.96744.malonedeb@soybean.canonical.com>
Message-Id: <151576397147.24984.5564955040283600683.malone@gac.canonical.com>
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

Closing since there hasn't been any response within the last 7 months

** Changed in: qemu
     Assignee: Paolo Bonzini (bonzini) =3D> (unassigned)

** Changed in: qemu
       Status: Incomplete =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/985288

Title:
  scsi disk emulation doesn't enforce FUA (Force Unit Access) in write-
  back mode

Status in QEMU:
  Won't Fix

Bug description:
  Microsoft NTFS utilizes the FUA bit in SCSI WRITE CDBs to insure
  integrity when a device advertises that it has write caching enabled.
  The FUA bit is meant to ensure a write is written to non-volatile
  storage before returning.  This seems to not be enforced by QEMU's
  SCSI emulation code.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/985288/+subscriptions
