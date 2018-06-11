Received: from eggs.gnu.org ([2001:4830:134:3::10]:55882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQY6-0006mv-EA
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQY3-0000Sp-Le
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:24:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSQY3-0000QQ-FH
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:24:07 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Jun 2018 14:23:52 -0300
Message-Id: <20180611172355.12067-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] x86 queue, 2018-06-11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>

The following changes since commit 0d2fa03dae4fbe185a082f361342b1e30aed4582:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180608' into staging (2018-06-08 16:26:51 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request

for you to fetch changes up to 1fb6752ecf87fb132035d3c03b0b9ca012265492:

  pc: Remove PC_COMPAT_2_12 from 3.0 machine-types (2018-06-10 21:33:00 -0300)

----------------------------------------------------------------
x86 queue, 2018-06-11

* Support for CPUID[0x8000001D] (AMD Cache Topology Information)
* pc bug fix: Remove PC_COMPAT_2_12 from 3.0 machine-types

----------------------------------------------------------------

Babu Moger (1):
  i386: Populate AMD Processor Cache Information for cpuid 0x8000001D

Eduardo Habkost (2):
  i386: Clean up cache CPUID code
  pc: Remove PC_COMPAT_2_12 from 3.0 machine-types

 target/i386/cpu.h |  14 ++-
 hw/i386/pc_piix.c |   1 -
 hw/i386/pc_q35.c  |   1 -
 target/i386/cpu.c | 234 ++++++++++++++++++++++++++++++++++------------
 target/i386/kvm.c |  29 +++++-
 5 files changed, 210 insertions(+), 69 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140
