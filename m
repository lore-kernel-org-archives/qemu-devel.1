Received: from eggs.gnu.org ([2001:4830:134:3::10]:59311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fMa3n-0006xG-A7
	for qemu-devel@nongnu.org; Sat, 26 May 2018 10:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fMa3j-0006EP-Ar
	for qemu-devel@nongnu.org; Sat, 26 May 2018 10:20:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:58760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fMa3j-0006Dn-54
	for qemu-devel@nongnu.org; Sat, 26 May 2018 10:20:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fMa3i-0005Zz-0T
	for <qemu-devel@nongnu.org>; Sat, 26 May 2018 14:20:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EF1D32E88D2
	for <qemu-devel@nongnu.org>; Sat, 26 May 2018 14:20:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 May 2018 14:11:05 -0000
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reply-To: Bug 1768246 <1768246@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152518111080.22177.382728353135880212.malonedeb@soybean.canonical.com>
	<87fu3b9ytz.fsf@linaro.org>
	<62e7854a-d325-2a06-8296-04ae500a9c41@physik.fu-berlin.de>
Message-Id: <0345ca0a-cf7c-2f04-abfe-c88f83dd32b7@physik.fu-berlin.de>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1768246] [NEW] cpu-exec.c:648:
 cpu_loop_exec_tb: Assertion `use_icount' failed.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This bug also affects GHC on qemu-sh4:

checking version of ghc... ./configure: line 3199: 55879 Segmentation fault=
      "${WithGhc-ghc}" --version > conftestghc 2>&1
8.2.2
qemu-sh4-static: /build/qemu-fWXVPw/qemu-2.12+dfsg/accel/tcg/cpu-exec.c:648=
: cpu_loop_exec_tb: Assertion `use_icount' failed.
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
qemu-sh4-static: /build/qemu-fWXVPw/qemu-2.12+dfsg/accel/tcg/cpu-exec.c:648=
: cpu_loop_exec_tb: Assertion `use_icount' failed.
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
qemu-sh4-static: /build/qemu-fWXVPw/qemu-2.12+dfsg/accel/tcg/cpu-exec.c:648=
: cpu_loop_exec_tb: Assertion `use_icount' failed.
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
qemu-sh4-static: /build/qemu-fWXVPw/qemu-2.12+dfsg/accel/tcg/cpu-exec.c:648=
: cpu_loop_exec_tb: Assertion `use_icount' failed.
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
qemu-sh4-static: /build/qemu-fWXVPw/qemu-2.12+dfsg/accel/tcg/cpu-exec.c:648=
: cpu_loop_exec_tb: Assertion `use_icount' failed.
qemu: uncaught target signal 11 (Segmentation fault) - core dumped

Just tested with qemu 5a5c383b1373aeb6c87a0d6060f6c3dc7c53082b.

-- =

 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1768246

Title:
  cpu-exec.c:648: cpu_loop_exec_tb: Assertion `use_icount' failed.

Status in QEMU:
  New

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
