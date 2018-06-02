Received: from eggs.gnu.org ([2001:4830:134:3::10]:38735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fP2FC-0000Pm-JO
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 04:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fP2F8-0006QL-G8
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 04:50:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:42302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fP2F8-0006Gg-4v
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 04:50:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fP2F6-0003mH-Sn
	for <qemu-devel@nongnu.org>; Sat, 02 Jun 2018 08:50:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B84DD2E88D2
	for <qemu-devel@nongnu.org>; Sat,  2 Jun 2018 08:50:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 Jun 2018 08:42:16 -0000
From: Samuel thibault <samuel.thibault@ens-lyon.org>
Reply-To: Bug 1724590 <1724590@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150833765599.17635.13860559072232712887.malonedeb@gac.canonical.com>
Message-Id: <152792893647.31439.17746873224055420101.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1724590] Re: Usermode networking hostfwd only
 listens on IPv4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

This is indeed not implemented, patches welcome :)

Samuel

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1724590

Title:
  Usermode networking hostfwd only listens on IPv4

Status in QEMU:
  New

Bug description:
  When forwarding ports in usermode networking (-net user,hostfwd=3D),
  QEMU binds to IPv4 only. Therefore, connecting to the port over IPv6
  results in 'connection refused'.

  I experienced this in QEMU 2.10.1, but it looks to still be present in
  the current master (861cd431c99e56ddb5953ca1da164a9c32b477ca), since
  slirp_hostfwd in net/slirp.c uses in_addr instead of in6_addr.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1724590/+subscriptions
