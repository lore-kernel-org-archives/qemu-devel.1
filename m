Received: from eggs.gnu.org ([2001:4830:134:3::10]:44452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fSxQY-0005oa-DI
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:30:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fSxQX-0003a8-Bv
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:30:34 -0400
Received: from indium.canonical.com ([91.189.90.7]:55872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fSxQW-0003ZI-US
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:30:33 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fSxQV-0001jf-Vn
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 04:30:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EFA662E80C9
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 04:30:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Jun 2018 04:17:34 -0000
From: Launchpad Bug Tracker <1195012@bugs.launchpad.net>
Reply-To: Bug 1195012 <1195012@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130626203059.25509.36668.malonedeb@soybean.canonical.com>
Message-Id: <152886345430.16396.3510585561690949988.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1195012] Re: x86_64 and i386 return 0 when
 reading MSR_TSC
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
https://bugs.launchpad.net/bugs/1195012

Title:
  x86_64 and i386 return 0 when reading MSR_TSC

Status in QEMU:
  Expired

Bug description:
  Running NetBSD 6.1 (i386 and amd64) under QEMU (from git - 1.5.50 is the =
version it shows) results in an incorrectly set
  TSC frequency (set to 0), because NetBSD uses rdmsr(TSC_MSR) for its seri=
alizing CPU counter.

  To reproduce the problem, you can run an install ISO of NetBSD 6.1
  (either i386 or amd64, depending on which qemu).  Quit out of the
  installer, and you're left at a root prompt:

  # sysctl machdep.tsc_freq
  machdep.tsc_freq =3D 0

  ...on real hardware, it will return the TSC frequency:

  # sysctl machdep.tsc_freq
  machdep.tsc_freq =3D 3292685070

  ...this causes problems with a number of applications.

  The NetBSD code which reads the MSR is here:

  http://nxr.netbsd.org/xref/src/sys/arch/x86/x86/tsc.c#262

  ... the "rdmsr(MSR_TSC)" call in cpu_counter_serializing() always
  returns 0 when run under QEMU.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1195012/+subscriptions
