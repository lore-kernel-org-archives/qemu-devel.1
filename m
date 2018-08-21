Received: from eggs.gnu.org ([2001:4830:134:3::10]:53080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fs0Bv-0004U1-RI
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fs0Bu-0002DU-U4
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:30:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:36548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fs0Bu-0002DA-O2
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:30:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fs0Bt-0001Kn-J9
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 06:30:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8A6FF2E8520
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 06:30:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Aug 2018 06:25:07 -0000
From: Thomas Huth <1720969@bugs.launchpad.net>
Reply-To: Bug 1720969 <1720969@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150701930722.20909.12415412860482115977.malonedeb@soybean.canonical.com>
Message-Id: <153483270886.5243.7225462467359449541.launchpad@chaenomeles.canonical.com>
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

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1720969

Title:
  qemu/memory.c:206:  pointless copies of large structs ?

Status in QEMU:
  Fix Released

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
