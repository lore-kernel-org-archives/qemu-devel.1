Received: from eggs.gnu.org ([2001:4830:134:3::10]:43094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEcYb-0004Ga-Bf
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:51:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEcYW-0008LK-5u
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:51:21 -0500
Received: from indium.canonical.com ([91.189.90.7]:32792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eEcYW-0008Jl-0A
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:51:16 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eEcYT-0005ho-1H
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 14:51:13 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CCFD22E818C
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 14:51:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Nov 2017 14:37:34 -0000
From: ChristianEhrhardt <1726394@bugs.launchpad.net>
Reply-To: Bug 1726394 <1726394@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150876459007.17533.9812313883985505054.malonedeb@wampee.canonical.com>
Message-Id: <151067025448.8036.15874197387953346746.malone@wampee.canonical.com>
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

See it passed [1] but britney not picking up.
Giving it some time to do so.

[1]:
https://objectstorage.prodstack4-5.canonical.com/v1/AUTH_77e2ada1e7a84929a7=
4ba3b87153c0ac
/autopkgtest-bionic/bionic/amd64/o/open-
iscsi/20171114_135029_17bf1@/log.gz

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
