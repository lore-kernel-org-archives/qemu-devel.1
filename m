Received: from eggs.gnu.org ([2001:4830:134:3::10]:50699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dIScR-0001Wo-Lv
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 00:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dIScQ-0007Tb-JD
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 00:30:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:49200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dIScQ-0007Su-7O
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 00:30:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dIScO-0003wl-N2
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 04:30:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DF98C2E81C6
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 04:30:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Jun 2017 04:17:34 -0000
From: Launchpad Bug Tracker <1078892@bugs.launchpad.net>
Reply-To: Bug 1078892 <1078892@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121114204838.25849.20471.malonedeb@chaenomeles.canonical.com>
Message-Id: <149680905454.16952.4334482556005154258.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1078892] Re: qemu doesn't general protection
 fault if there are reserved bits set in page-directory-pointer table
 entries
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
https://bugs.launchpad.net/bugs/1078892

Title:
  qemu doesn't general protection fault if there are reserved bits set
  in page-directory-pointer table entries

Status in QEMU:
  Expired

Bug description:
  While working on implementing 32-bit PAE mode in a custom operating
  system, which I was testing in QEMU, I noticed that my OS worked
  correctly, but resulted in a general protection fault when booted on
  VMware, VirtualBox, or bochs.

  According to the Intel Architecture Manual, Volume 3A, Section 4.4.1
  "PDPTE Registers", "If any of the PDPTEs sets both the P flag (bit 0)
  and any reserved bit, the MOV to CR instruction causes a general-
  protection exception (#GP(0)) and the PDPTEs are not loaded." QEMU
  does not emulate this behavior.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1078892/+subscriptions
