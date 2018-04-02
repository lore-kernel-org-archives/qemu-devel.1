Received: from eggs.gnu.org ([2001:4830:134:3::10]:41528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f2spv-0006vL-Ne
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 02:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f2sps-0000gB-J9
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 02:20:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:49238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f2sps-0000en-C5
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 02:20:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f2spp-0002IF-RJ
	for <qemu-devel@nongnu.org>; Mon, 02 Apr 2018 06:20:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 712E12E80D6
	for <qemu-devel@nongnu.org>; Mon,  2 Apr 2018 06:20:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Apr 2018 06:14:09 -0000
From: Bug Watch Updater <1726394@bugs.launchpad.net>
Reply-To: Bug 1726394 <1726394@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150876459007.17533.9812313883985505054.malonedeb@wampee.canonical.com>
Message-Id: <152264965242.21542.2405208181944152054.launchpad@loganberry.canonical.com>
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

** Changed in: qemu (Debian)
       Status: Confirmed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1726394

Title:
  Passes through prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, address)

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu source package in Xenial:
  Won't Fix
Status in qemu source package in Zesty:
  Won't Fix
Status in qemu source package in Artful:
  Won't Fix
Status in qemu package in Debian:
  Fix Released

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
