Received: from eggs.gnu.org ([2001:4830:134:3::10]:41216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g83aj-00037w-0A
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g83Ll-0004A4-ID
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:07:34 -0400
Received: from indium.canonical.com ([91.189.90.7]:36794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1g83Lf-0003tY-UE
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:07:24 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1g83LV-0000uO-O4
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 13:07:14 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 793052E81C4
	for <qemu-devel@nongnu.org>; Thu,  4 Oct 2018 13:07:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Oct 2018 12:38:56 -0000
From: Thomas Huth <1768246@bugs.launchpad.net>
Reply-To: Bug 1768246 <1768246@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152518111080.22177.382728353135880212.malonedeb@soybean.canonical.com>
Message-Id: <153865673688.12519.11320289983892503878.malone@wampee.canonical.com>
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

Fix has been committed here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D5b38d0264064055255db9=
91

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1768246

Title:
  cpu-exec.c:648: cpu_loop_exec_tb: Assertion `use_icount' failed.

Status in QEMU:
  Fix Committed

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
