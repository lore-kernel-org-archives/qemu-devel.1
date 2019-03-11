Received: from eggs.gnu.org ([209.51.188.92]:51616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h39F5-0006s1-1J
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h39F4-00070W-1j
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:56:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h39F3-0006zw-RQ
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:56:33 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 11 Mar 2019 01:56:11 +0100
Message-Id: <20190311005618.19007-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/7] Kconfig dependencies for MIPS machines
 (but Malta)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: James Hogan <jhogan@kernel.org>, Yang Zhong <yang.zhong@intel.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Express the MIPS machine dependencies with Kconfig.

Due to its complexity, the Malta board fill follow in a different
series.

v3:
- addressed review comments from Thomas and Aleksandar
  (noted in each patch)

v2: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00887.html
- Do not remove machines from the default config (Thomas)
- Corrected comment about CONFIG_PCI_BONITO (Thomas)

v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg593013.html

$ git backport-diff -u kconfig_mips-v2
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/7:[----] [--] 'hw/mips: Express dependencies of the MIPSsim machine w=
ith kconfig'
002/7:[0001] [FC] 'hw/mips: Express dependencies of the Jazz machine with=
 kconfig'
003/7:[0002] [FC] 'hw/mips: Express dependencies of the r4k platform with=
 kconfig'
004/7:[down] 'hw/mips: Remove the redundant CONFIG_MIPS_ITU Makefile vari=
able'
005/7:[----] [-C] 'hw/mips: Express dependencies of the Boston machine wi=
th kconfig'
006/7:[----] [-C] 'hw/pci-host: Use CONFIG_PCI_BONITO to select the Bonit=
o North Bridge'
007/7:[----] [-C] 'hw/mips: Express dependencies of the Fulong 2E machine=
 with kconfig'

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (7):
  hw/mips: Express dependencies of the MIPSsim machine with Kconfig
  hw/mips: Express dependencies of the Jazz machine with Kconfig
  hw/mips: Express dependencies of the r4k platform with Kconfig
  hw/mips: Remove the redundant CONFIG_MIPS_ITU Makefile variable
  hw/mips: Express dependencies of the Boston machine with Kconfig
  hw/pci-host: Use CONFIG_PCI_BONITO to select the Bonito North Bridge
  hw/mips: Express dependencies of the Fulong 2E machine with Kconfig

 default-configs/mips-softmmu-common.mak |  4 ---
 default-configs/mips64-softmmu.mak      |  5 ---
 default-configs/mips64el-softmmu.mak    | 11 -------
 hw/isa/Kconfig                          | 13 +++++---
 hw/mips/Kconfig                         | 41 +++++++++++++++++++++++++
 hw/misc/Kconfig                         |  3 --
 hw/misc/Makefile.objs                   |  2 +-
 hw/pci-host/Kconfig                     |  4 +++
 hw/pci-host/Makefile.objs               |  2 +-
 9 files changed, 56 insertions(+), 29 deletions(-)

--=20
2.20.1
