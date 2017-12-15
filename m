Received: from eggs.gnu.org ([2001:4830:134:3::10]:60747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsQb-0006xY-9d
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsQX-000418-8I
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:01:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:48360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePsQW-0003rk-Mo
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:01:33 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePsQI-0008Hp-1S
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:01:18 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7BF262E8190
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:01:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 15:53:41 -0000
From: Thomas Huth <1724485@bugs.launchpad.net>
Reply-To: Bug 1724485 <1724485@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150831492991.17205.1365818841692773714.malonedeb@gac.canonical.com>
Message-Id: <151335322180.16825.11069789221522837063.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1724485] Re: Invalid assertion in
 arm_read_memory_func
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
https://bugs.launchpad.net/bugs/1724485

Title:
  Invalid assertion in arm_read_memory_func

Status in QEMU:
  Fix Released

Bug description:
  Hi,

  I think there is an invalid assertion in arm_read_memory_func:
  assert(info->endian =3D=3D BFD_ENDIAN_LITTLE)

  I face it in the following use case: target armeb-linux (I use qemu
  user mode), -d in_asm -cpu any.

  At some point during program startup, glibc's _dl_new_object calls
  strlen, which is written in thumb2 mode (armv6t2). So print_insn_arm()
  calls arm_read_memory_func() with length=3D=3D2, and info->flags =3D=3D
  INSN_ARM_BE32, and the assert is false.

  If I remove the assert, execution continues OK.

  With the assert, I get the error message from the assert, and qemu
  then stalls.

  Can you confirm the assert can be removed? Or if not, explain me how
  to avoid/fix the subsequent qemu stall?

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1724485/+subscriptions
