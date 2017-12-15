Received: from eggs.gnu.org ([2001:4830:134:3::10]:45300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePriE-0003OR-CC
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePriA-0005Qp-6j
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:15:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:35564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePri9-0005PC-W7
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:15:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePri8-0001gP-85
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 15:15:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3B89A2E80CD
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 15:15:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 15:04:14 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1735653 <1735653@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151210789540.11140.601756006906517496.malonedeb@soybean.canonical.com>
Message-Id: <151335025420.24609.7081767467268735704.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1735653] Re: qemu aarch64 cannot boot linux
 kernel v4.6+
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This bug was fixed in QEMU commit e20d84c1407d43d, back in 2016. Are you
sure you're running the version of QEMU which you've just built, and not
the installed system one (which is likely to be older)? Your command
line suggests you're running the system one. The newly built binary will
be ./aarch64-softmmu/qemu-system-aarch64 in the build directory (and you
can check using the --version option what binary you're running).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1735653

Title:
  qemu aarch64 cannot boot linux kernel v4.6+

Status in QEMU:
  New

Bug description:
  Hi,
  I tested the latest qemu-system-aarch64 cannot boot linux mainline kernel=
 since v4.6 from https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/l=
inux.git.

  Environment info:
  # host
   ubuntu 16.04
  # qemu
   Master branch from git://git.qemu.org/qemu.git, and now the HEAD is c11d=
61271b9e6e7a1f0479ef1ca8fb55fa457a62.
  # build command
   ./configure --target-list=3Daarch64-softmmu
   make
  # qemu commmand
   qemu-system-aarch64 -machine virt -cpu cortex-a57 -machine type=3Dvirt -=
smp 4 -m 1024 -nographic -s -kernel ~/workspace/linux/arch/arm64/boot/Image=
 -device e1000,netdev=3Dnet0 -netdev user,id=3Dnet0,hostfwd=3Dtcp::2222-:22

  Error info:
   No error prompted, actually no any log which means I couldn't see the us=
ually kernel boot message.

  Debug info:
   I did a git bisect on linux, and found with this kernel commit, qemu fai=
led to boot. Parent of 406e308770a92bd33995b2e5b681e86358328bb0 can boot.
   commit 406e308770a92bd33995b2e5b681e86358328bb0
      Author: James Morse <james.morse@arm.com>
      Date:   Fri Feb 5 14:58:47 2016 +0000

      arm64: add ARMv8.2 id_aa64mmfr2 boiler plate

      ARMv8.2 adds a new feature register id_aa64mmfr2. This patch adds the
      cpu feature boiler plate used by the actual features in later patches.

      Signed-off-by: James Morse <james.morse@arm.com>
      Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
      Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
   The main change in the patch is to add reg_id_aa64mmfr2 in to arch/arm64=
/include/asm/cpu.h, so might it be any struct change not included in qemu?

  Can you please help check how to fix it?

  Thanks

  - Joey

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1735653/+subscriptions
