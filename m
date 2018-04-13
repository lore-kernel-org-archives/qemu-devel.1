Received: from eggs.gnu.org ([2001:4830:134:3::10]:37756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f6wS9-0007Ki-Mg
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f6wS6-0003DG-MC
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:01:13 -0400
Received: from indium.canonical.com ([91.189.90.7]:49452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f6wS6-0003Cr-FS
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 07:01:10 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f6wS5-00073W-Ao
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 11:01:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 49CC52E80D4
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 11:01:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Apr 2018 10:49:25 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 902720 <902720@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111211064733.26491.7785.malonedeb@soybean.canonical.com>
Message-Id: <152361656571.14427.7688669497289062541.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 902720] Re: TIME_MAX not set correctly for
 OpenBSD in qemu-common.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This was fixed in commit e7b47c22e2df14d, which was in the 2.11.0
release.


** Changed in: qemu
       Status: Triaged =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/902720

Title:
  TIME_MAX not set correctly for OpenBSD in qemu-common.h

Status in QEMU:
  Fix Released

Bug description:
  Looking at the OpenBSD buildbot logs I noticed a warning that appears to =
be a bug in the code.
  OpenBSD has a 32-bit time_t on all archs at the moment (32-bit and 64-bit=
).

    CC    i386-softmmu/monitor.o
  /buildbot-qemu/default_openbsd_current/build/monitor.c: In function 'expi=
re_password':
  /buildbot-qemu/default_openbsd_current/build/monitor.c:944: warning: over=
flow in implicit constant conversion

  qemu-common.h has...

  #ifndef TIME_MAX
  #define TIME_MAX LONG_MAX
  #endif

  for OpenBSD this should be INT_MAX.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/902720/+subscriptions
