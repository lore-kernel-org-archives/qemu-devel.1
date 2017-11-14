Received: from eggs.gnu.org ([2001:4830:134:3::10]:38481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEcOi-0005tR-Mc
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEcOe-0007dH-Av
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:41:08 -0500
Received: from indium.canonical.com ([91.189.90.7]:58214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eEcOe-0007bv-4d
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:41:04 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eEcOc-0004ZB-2y
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 14:41:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 156D92E80D5
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 14:41:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Nov 2017 14:35:33 -0000
From: Launchpad Bug Tracker <1726394@bugs.launchpad.net>
Reply-To: Bug 1726394 <1726394@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150876459007.17533.9812313883985505054.malonedeb@wampee.canonical.com>
Message-Id: <151067013951.4962.13674405192881574433.malone@ackee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1726394] Re: Passes through prctl(PR_SET_SECCOMP,
 SECCOMP_MODE_FILTER, address)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This bug was fixed in the package qemu - 1:2.10+dfsg-0ubuntu4

---------------
qemu (1:2.10+dfsg-0ubuntu4) bionic; urgency=3Dmedium

  * Apply linux-user-return-EINVAL-from-prctl-PR_-_SECCOMP.patch from
    James Cowgill to prevent qemu-user from forwarding prctl seccomp
    calls (LP: #1726394)

 -- Julian Andres Klode <juliank@ubuntu.com>  Sat, 04 Nov 2017 00:21:14
+0100

** Changed in: qemu (Ubuntu)
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1726394

Title:
  Passes through prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, address)

Status in QEMU:
  In Progress
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu source package in Xenial:
  Won't Fix
Status in qemu source package in Zesty:
  Won't Fix
Status in qemu source package in Artful:
  Won't Fix
Status in qemu package in Debian:
  Confirmed

Bug description:
  qemu-user passes through prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER,
  address) unmodified, but the third argument is an address to a BPF
  filter, causing an EFAULT. Now, the filter is architecture-specifc, so
  you can't just rewrite the addresses, so the safest bet is to just
  return an error here.

  I guess you should just return EINVAL, but not sure. I'd really like
  something that can be identified, so seccomp errors can be ignored
  when it's not supported.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1726394/+subscriptions
