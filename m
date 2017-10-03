Received: from eggs.gnu.org ([2001:4830:134:3::10]:49819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzIlK-0003UR-PP
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 04:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dzIlG-0006eJ-QD
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 04:41:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:53118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dzIlG-0006ck-Jv
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 04:41:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dzIlF-0005pV-CW
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 08:41:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 157A82E80D6
	for <qemu-devel@nongnu.org>; Tue,  3 Oct 2017 08:41:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Oct 2017 08:28:27 -0000
From: dcb <1720969@bugs.launchpad.net>
Reply-To: Bug 1720969 <1720969@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150701930722.20909.12415412860482115977.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1720969] [NEW] qemu/memory.c:206: pointless
 copies of large structs ?
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

[qemu/memory.c:206]: (performance) Function parameter 'a' should be passed =
by reference.
[qemu/memory.c:207]: (performance) Function parameter 'b' should be passed =
by reference.

Source code is

static bool memory_region_ioeventfd_equal(MemoryRegionIoeventfd a,
                                          MemoryRegionIoeventfd b)

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1720969

Title:
  qemu/memory.c:206:  pointless copies of large structs ?

Status in QEMU:
  New

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
