Received: from eggs.gnu.org ([2001:4830:134:3::10]:43092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEcYb-0004GZ-B9
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:51:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEcYY-0008O4-FB
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:51:21 -0500
Received: from indium.canonical.com ([91.189.90.7]:32938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eEcYY-0008MC-97
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:51:18 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eEcYV-0005hj-3b
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 14:51:15 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3D7732E818A
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 14:51:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Nov 2017 14:42:22 -0000
From: ChristianEhrhardt <1726394@bugs.launchpad.net>
Reply-To: Bug 1726394 <1726394@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150876459007.17533.9812313883985505054.malonedeb@wampee.canonical.com>
Message-Id: <151067054304.1355.504386999798059900.malone@chaenomeles.canonical.com>
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

LP, this was unfair to reverse-pass me :-)
Anyway - done - thanks Julian and James C. for your work on that.

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
