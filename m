Received: from eggs.gnu.org ([2001:4830:134:3::10]:54142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fCHVJ-0000OC-Gu
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 00:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fCHVG-0003o0-Bm
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 00:30:33 -0400
Received: from indium.canonical.com ([91.189.90.7]:58278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fCHVG-0003nc-0p
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 00:30:30 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fCHVE-0006S4-SZ
	for <qemu-devel@nongnu.org>; Sat, 28 Apr 2018 04:30:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CFA022E8059
	for <qemu-devel@nongnu.org>; Sat, 28 Apr 2018 04:30:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Apr 2018 04:17:28 -0000
From: Launchpad Bug Tracker <1432103@bugs.launchpad.net>
Reply-To: Bug 1432103 <1432103@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150314042811.14702.61970.malonedeb@wampee.canonical.com>
Message-Id: <152488904894.26551.16112480134961934406.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1432103] Re: error in x86 executable segment
 permission check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1432103

Title:
  error in x86 executable segment permission check

Status in QEMU:
  Expired

Bug description:
  When the code segment register (%cs) selects an executable segment
  with no read permission, mov instructions that read from the segment
  via %cs prefix can still succeed without causing a general protection
  error.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1432103/+subscriptions
