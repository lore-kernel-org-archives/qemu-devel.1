Received: from eggs.gnu.org ([2001:4830:134:3::10]:53307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAltz-000364-IX
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 20:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAltv-00083t-Mj
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 20:01:31 -0400
Received: from indium.canonical.com ([91.189.90.7]:35246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eAltv-00083Z-Fk
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 20:01:27 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eAltt-0002ur-NB
	for <qemu-devel@nongnu.org>; Sat, 04 Nov 2017 00:01:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ACB242E80CB
	for <qemu-devel@nongnu.org>; Sat,  4 Nov 2017 00:01:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Nov 2017 23:51:35 -0000
From: Julian Andres Klode <1726394@bugs.launchpad.net>
Reply-To: Bug 1726394 <1726394@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150876459007.17533.9812313883985505054.malonedeb@wampee.canonical.com>
Message-Id: <150975309601.4552.16599930195105010366.launchpad@chaenomeles.canonical.com>
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

** Bug watch added: Debian Bug tracker #880582
   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D880582

** Also affects: qemu (Debian) via
   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D880582
   Importance: Unknown
       Status: Unknown

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1726394

Title:
  Passes through prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, address)

Status in QEMU:
  New
Status in qemu package in Ubuntu:
  Fix Committed
Status in qemu package in Debian:
  Unknown

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
