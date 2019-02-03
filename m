Received: from eggs.gnu.org ([209.51.188.92]:45134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqPvh-0002Bz-51
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 17:07:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqPvg-0006vn-Cl
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 17:07:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqPvg-0006uT-78
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 17:07:56 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun,  3 Feb 2019 23:07:38 +0100
Message-Id: <20190203220744.11734-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/6] Kconfig dependencies for MIPS machines
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, James Hogan <jhogan@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>, Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Express the MIPS machine dependencies with Kconfig.

Due to the complexity of the PIIX codebase being shared with
the X86 machines, the Malta board fill follow in a different
series (after some refactor cleanup).

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

 default-configs/mips-softmmu-common.mak |  4 ---
 default-configs/mips64-softmmu.mak      |  6 ----
 default-configs/mips64el-softmmu.mak    | 14 ---------
 hw/isa/Kconfig                          | 13 +++++---
 hw/mips/Kconfig                         | 40 +++++++++++++++++++++++++
 hw/pci-host/Kconfig                     |  4 +++
 hw/pci-host/Makefile.objs               |  2 +-
 7 files changed, 54 insertions(+), 29 deletions(-)

--=20
2.20.1
