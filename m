Received: from eggs.gnu.org ([2001:4830:134:3::10]:34787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=812b08464=Alistair.Francis@wdc.com>)
	id 1g9aDd-0004Sz-ML
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=812b08464=Alistair.Francis@wdc.com>)
	id 1g9aDU-0007IP-CZ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:25:22 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49673)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=812b08464=Alistair.Francis@wdc.com>)
	id 1g9aDQ-0007EZ-Cs
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:25:13 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Mon, 8 Oct 2018 18:25:07 +0000
Message-ID: <cover.1539023064.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 0/5]  Misc RISC-V patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mjc@sifive.com" <mjc@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

These are some patches that I have cherry picked from Michael's RISC-V
tree that are ready to be applied.
Unless anyone has any comments against these I'll send a PR later this
week.

Michael Clark (5):
  RISC-V: Allow setting and clearing multiple irqs
  RISC-V: Move non-ops from op_helper to cpu_helper
  RISC-V: Update CSR and interrupt definitions
  RISC-V: Add missing free for plic_hart_config
  RISC-V: Don't add NULL bootargs to device-tree

 hw/riscv/sifive_clint.c                 |   8 +-
 hw/riscv/sifive_plic.c                  |   4 +-
 hw/riscv/sifive_u.c                     |   4 +-
 hw/riscv/spike.c                        |   6 +-
 hw/riscv/virt.c                         |   6 +-
 target/riscv/Makefile.objs              |   2 +-
 target/riscv/cpu.c                      |   6 +-
 target/riscv/cpu.h                      |  22 +-
 target/riscv/cpu_bits.h                 | 683 +++++++++++++-----------
 target/riscv/{helper.c =3D> cpu_helper.c} |  35 +-
 target/riscv/op_helper.c                |  34 +-
 11 files changed, 438 insertions(+), 372 deletions(-)
 rename target/riscv/{helper.c =3D> cpu_helper.c} (95%)

--=20
2.17.1
