Received: from eggs.gnu.org ([209.51.188.92]:45820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJisb-0003Ho-Oe
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJisX-000249-UD
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:13:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJisX-0001wu-7q
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:13:49 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Apr 2019 15:13:38 -0300
Message-Id: <20190425181342.15360-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] x86 queue, 2019-04-25
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>

The following changes since commit 3284aa128153750f14a61e8a96fd085e6f2999=
b6:

  Merge remote-tracking branch 'remotes/lersek/tags/edk2-pull-2019-04-22'=
 into staging (2019-04-24 13:19:41 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request

for you to fetch changes up to a4e0b436f44a4bb47ed4a75b0c05d2547cf12b1c:

  Pass through cache information for TOPOEXT CPUs (2019-04-25 14:52:28 -0=
300)

----------------------------------------------------------------
x86 queue, 2019-04-25

* Hygon Dhyana CPU model (Pu Wen)
* Categorize a few devices in hw/i386 (Ernest Esene)
* Support host-cache-info on TOPOEXT CPUID leaf (Stanislav Lanci)

----------------------------------------------------------------

Ernest Esene (2):
  Categorize devices: IGD passthrough ISA bridge
  Categorize devices: iommu

Pu Wen (1):
  i386: Add new Hygon 'Dhyana' CPU model

Stanislav Lanci (1):
  Pass through cache information for TOPOEXT CPUs

 target/i386/cpu.h     |  2 ++
 hw/i386/amd_iommu.c   |  2 ++
 hw/i386/intel_iommu.c |  2 ++
 hw/i386/pc_piix.c     |  1 +
 target/i386/cpu.c     | 54 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 61 insertions(+)

--=20
2.18.0.rc1.1.g3f1ff2140
