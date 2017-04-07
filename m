Received: from eggs.gnu.org ([2001:4830:134:3::10]:50433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUW0-0003UN-EG
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUVx-0000Ta-6h
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:05:28 -0400
Received: from indium.canonical.com ([91.189.90.7]:43145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cwUVw-0000Sx-Mf
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:05:25 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cwUVv-0003L4-4w
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 14:05:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 21B6F2E80C1
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 14:05:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2017 13:54:26 -0000
From: Thomas Huth <1078892@bugs.launchpad.net>
Reply-To: Bug 1078892 <1078892@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121114204838.25849.20471.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170407135426.12710.75239.malone@gac.canonical.com>
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

Triaging old bug tickets ... can you still reproduce this issue with the
latest version of QEMU (version 2.9)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1078892

Title:
  qemu doesn't general protection fault if there are reserved bits set
  in page-directory-pointer table entries

Status in QEMU:
  Incomplete

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
