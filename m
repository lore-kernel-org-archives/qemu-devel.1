Received: from eggs.gnu.org ([2001:4830:134:3::10]:43314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzWn-0002IQ-7d
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzWk-0003jc-4b
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:02:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ebzWj-0003il-Uu
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:02:02 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Jan 2018 00:01:49 -0200
Message-Id: <20180118020157.25401-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/8] x86 queue, 2018-01-17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

The following changes since commit 8e5dc9ba49743b46d955ec7dacb04e42ae7ada7c:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180116' into staging (2018-01-16 17:36:39 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-pull-request

for you to fetch changes up to 6cfbc54e8903a9bcc0346119949162d040c144c1:

  i386: Add EPYC-IBPB CPU model (2018-01-17 23:54:39 -0200)

----------------------------------------------------------------
x86 queue, 2018-01-17

Highlight: new CPU models that expose CPU features that guests
can use to mitigate CVE-2017-5715 (Spectre variant #2).

----------------------------------------------------------------

Eduardo Habkost (5):
  i386: Change X86CPUDefinition::model_id to const char*
  i386: Add spec-ctrl CPUID bit
  i386: Add FEAT_8000_0008_EBX CPUID feature word
  i386: Add new -IBRS versions of Intel CPU models
  i386: Add EPYC-IBPB CPU model

Haozhong Zhang (2):
  pc: add 2.12 machine types
  target/i386: add clflushopt to "Skylake-Server" cpu model

Paolo Bonzini (1):
  i386: Add support for SPEC_CTRL MSR

 include/hw/i386/pc.h  |   8 +
 target/i386/cpu.h     |   7 +
 hw/i386/pc_piix.c     |  15 +-
 hw/i386/pc_q35.c      |  13 +-
 target/i386/cpu.c     | 457 +++++++++++++++++++++++++++++++++++++++++++++++++-
 target/i386/kvm.c     |  14 ++
 target/i386/machine.c |  20 +++
 7 files changed, 524 insertions(+), 10 deletions(-)

-- 
2.14.3
