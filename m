Received: from eggs.gnu.org ([209.51.188.92]:34746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqkp1-0007cm-Hy
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:26:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqkot-0006QR-7O
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:26:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqkoq-0006Ov-Ud
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:26:17 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  4 Feb 2019 21:26:03 +0100
Message-Id: <20190204202609.26956-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/6] Kconfig dependencies for MIPS machines
 (but Malta)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Express the MIPS machine dependencies with Kconfig.

Due to the complexity of the PIIX codebase being shared with
the X86 machines, the Malta board fill follow in a different
series (after some refactor cleanup).

v2:
- Do not remove machines from the default config (Thomas)
- Corrected comment about CONFIG_PCI_BONITO (Thomas)

v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg593013.html

$ git backport-diff -u kconfig_mips_v1
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/6:[0001] [FC] 'mips: Express dependencies of the MIPSsim machine with=
 kconfig'
002/6:[0001] [FC] 'mips: Express dependencies of the Jazz machine with kc=
onfig'
003/6:[0001] [FC] 'mips: Express dependencies of the r4k platform with kc=
onfig'
004/6:[0001] [FC] 'mips: Express dependencies of the Boston machine with =
kconfig'
005/6:[----] [-C] 'hw/pci-host: Use CONFIG_PCI_BONITO to select the Bonit=
o North Bridge'
006/6:[0001] [FC] 'mips: Express dependencies of the Loongson 2E machine =
with kconfig'

Regards,

Phil.

Based on "Kconfig dependencies for ppc machines" from Thomas
Huth (which is based on Paolo's, which uses Yang Zhong "make
qemu configurable for Kconfig" v1).
Based-on: 1548942810-22942-1-git-send-email-thuth@redhat.com

Philippe Mathieu-Daud=C3=A9 (6):
  mips: Express dependencies of the MIPSsim machine with kconfig
  mips: Express dependencies of the Jazz machine with kconfig
  mips: Express dependencies of the r4k platform with kconfig
  mips: Express dependencies of the Boston machine with kconfig
  hw/pci-host: Use CONFIG_PCI_BONITO to select the Bonito North Bridge
  mips: Express dependencies of the Loongson 2E machine with kconfig

 default-configs/mips-softmmu-common.mak |  2 --
 default-configs/mips64-softmmu.mak      |  5 ----
 default-configs/mips64el-softmmu.mak    | 12 --------
 hw/isa/Kconfig                          | 13 +++++---
 hw/mips/Kconfig                         | 40 +++++++++++++++++++++++++
 hw/pci-host/Kconfig                     |  4 +++
 hw/pci-host/Makefile.objs               |  2 +-
 7 files changed, 54 insertions(+), 24 deletions(-)

--=20
2.20.1
