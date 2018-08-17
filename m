Received: from eggs.gnu.org ([2001:4830:134:3::10]:48116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqTeW-00053U-H5
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqTeR-00060F-Hm
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:34:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fqTeQ-0005zG-VR
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:34:07 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 16 Aug 2018 22:33:52 -0300
Message-Id: <20180817013400.13353-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] x86 queue, 2018-08-16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>

The following changes since commit bb16c0412a572c2c9cd44496deb3ad430bc49c=
1a:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
80816' into staging (2018-08-16 14:35:50 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request

for you to fetch changes up to 7210a02c58572b2686a3a8d610c6628f87864aed:

  i386: Disable TOPOEXT by default on "-cpu host" (2018-08-16 13:43:01 -0=
300)

----------------------------------------------------------------
x86 queue, 2018-08-16

Bug fix:
* Some guests may crash when using "-cpu host" due to TOPOEXT,
  disable it by default

Features:
* PV_SEND_IPI feature bit
* Icelake-{Server,Client} CPU models
* New CPUID feature bits: PV_SEND_IPI, WBNOINVD, PCONFIG, ARCH_CAPABILITI=
ES

Documentation:
* docs/qemu-cpu-models.texi

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (1):
  docs: add guidance on configuring CPU models for x86

Eduardo Habkost (1):
  i386: Disable TOPOEXT by default on "-cpu host"

Robert Hoo (5):
  i386: Add new MSR indices for IA32_PRED_CMD and IA32_ARCH_CAPABILITIES
  i386: Add CPUID bit and feature words for IA32_ARCH_CAPABILITIES MSR
  i386: Add CPUID bit for PCONFIG
  i386: Add CPUID bit for WBNOINVD
  i386: Add new CPU model Icelake-{Server,Client}

Wanpeng Li (1):
  target-i386: adds PV_SEND_IPI CPUID feature bit

 docs/qemu-cpu-models.texi | 484 ++++++++++++++++++++++++++++++++++++++
 Makefile                  |   7 +-
 target/i386/cpu.h         |   6 +
 target/i386/cpu.c         | 130 +++++++++-
 MAINTAINERS               |   1 +
 qemu-doc.texi             |   6 +
 6 files changed, 629 insertions(+), 5 deletions(-)
 create mode 100644 docs/qemu-cpu-models.texi

--=20
2.18.0.rc1.1.g3f1ff2140
