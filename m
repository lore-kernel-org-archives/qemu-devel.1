Received: from eggs.gnu.org ([2001:4830:134:3::10]:36434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gX0rN-0006Qq-G7
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:31:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gX0rM-0005DR-1X
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:31:17 -0500
Received: from indium.canonical.com ([91.189.90.7]:59204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gX0rL-00059G-NA
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:31:15 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gX0rH-0007ug-3F
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 09:31:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CF61D2E808D
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 09:31:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Dec 2018 09:21:47 -0000
From: Thomas Huth <1768246@bugs.launchpad.net>
Reply-To: Bug 1768246 <1768246@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152518111080.22177.382728353135880212.malonedeb@soybean.canonical.com>
Message-Id: <154460650886.27949.4917717698410049285.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1768246] Re: cpu-exec.c:648: cpu_loop_exec_tb:
 Assertion `use_icount' failed.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1768246

Title:
  cpu-exec.c:648: cpu_loop_exec_tb: Assertion `use_icount' failed.

Status in QEMU:
  Fix Released

Bug description:
  OpenJDK no longer works on qemu-sh4, it previously did after #1735384
  was fixed.

  Crash indicates an assertion failure:

  (sid-sh4-sbuild)root@nofan:/# java --version
  qemu-sh4-static: /root/qemu/accel/tcg/cpu-exec.c:648: cpu_loop_exec_tb: A=
ssertion `use_icount' failed.
  qemu: uncaught target signal 6 (Aborted) - core dumped
  Aborted
  (sid-sh4-sbuild)root@nofan:/#

  Haven't bi-sected the issue yet, but will do so later.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1768246/+subscriptions
