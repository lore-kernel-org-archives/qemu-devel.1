Received: from eggs.gnu.org ([2001:4830:134:3::10]:52385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEVqN-0007lV-O6
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEVqK-0002dY-Ko
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:41:15 -0500
Received: from indium.canonical.com ([91.189.90.7]:42466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eEVqK-0002ci-Ei
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:41:12 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eEVqG-000754-SG
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 07:41:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ADD4C2E80CC
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 07:41:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Nov 2017 07:26:23 -0000
From: ChristianEhrhardt <1726394@bugs.launchpad.net>
Reply-To: Bug 1726394 <1726394@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150876459007.17533.9812313883985505054.malonedeb@wampee.canonical.com>
Message-Id: <151064438328.27974.10684630072912513518.malone@gac.canonical.com>
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

This was blocked migrating on a autopkgtest for a known issue now resolved.
TL;DR no bionic images. Resolved now, should migrate soon.

While the final fix now accepted in linux-user is slightly different,
the difference is only a comment. It is therefore fine if we pick this
up on next merge for Bionic.

Once complete I can plan SRU uploads for this.

** Also affects: qemu (Ubuntu Artful)
   Importance: Undecided
       Status: New

** Also affects: qemu (Ubuntu Zesty)
   Importance: Undecided
       Status: New

** Also affects: qemu (Ubuntu Xenial)
   Importance: Undecided
       Status: New

** Changed in: qemu (Ubuntu Xenial)
       Status: New =3D> Triaged

** Changed in: qemu (Ubuntu Zesty)
       Status: New =3D> Triaged

** Changed in: qemu (Ubuntu Artful)
       Status: New =3D> Triaged

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1726394

Title:
  Passes through prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, address)

Status in QEMU:
  In Progress
Status in qemu package in Ubuntu:
  Fix Committed
Status in qemu source package in Xenial:
  Triaged
Status in qemu source package in Zesty:
  Triaged
Status in qemu source package in Artful:
  Triaged
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
