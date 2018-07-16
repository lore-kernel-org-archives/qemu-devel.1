Received: from eggs.gnu.org ([2001:4830:134:3::10]:53350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1ff5D7-0005Jm-RZ
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1ff5D2-0000AP-Te
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:14:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41346
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1ff5D2-00006r-M5
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:14:44 -0400
From: Andre Przywara <andre.przywara@arm.com>
Date: Mon, 16 Jul 2018 16:14:36 +0100
Message-Id: <20180716151438.9877-1-andre.przywara@arm.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH 0/2] arm64: extend arch timer
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org

While debugging some timer emulation IRQ problem, I realised that the
failure pattern I was looking at is not covered by kvm-unit-tests.

Add a test for the TVAL register, also check that KVM correctly injects
the timer interrupt for the emulated physical timer when the guest is in
WFI (hint: it does not, starting with 4.15-rc, I am on it).

Cheers,
Andre.

Andre Przywara (2):
  arm64: timer: add TVAL accessors
  arm64: timer: Add TVAL timeout test and test IRQ trigger

 arm/timer.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

-- 
2.14.4
