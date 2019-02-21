Received: from eggs.gnu.org ([209.51.188.92]:58191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=948ed6046=Alistair.Francis@wdc.com>)
	id 1gwcU0-00058g-C3
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 19:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=948ed6046=Alistair.Francis@wdc.com>)
	id 1gwcTy-0002c5-0m
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 19:45:00 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Thu, 21 Feb 2019 00:44:48 +0000
Message-ID: <21c6075fc9bf294109593cf987f094842c217463.1550709660.git.alistair.francis@wdc.com>
References: <cover.1550709660.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1550709660.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 10/11] RISC-V: Update load reservation
 comment in do_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "palmer@sifive.com" <palmer@sifive.com>

From: Michael Clark <mjc@sifive.com>

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6d3fbc3401..b17f169681 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -525,7 +525,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             ((async && (env->mtvec & 3) =3D=3D 1) ? cause * 4 : 0);
         riscv_cpu_set_mode(env, PRV_M);
     }
-    /* TODO yield load reservation  */
+
+    /* NOTE: it is not necessary to yield load reservations here. It is on=
ly
+     * necessary for an SC from "another hart" to cause a load reservation
+     * to be yielded. Refer to the memory consistency model section of the
+     * RISC-V ISA Specification.
+     */
+
 #endif
     cs->exception_index =3D EXCP_NONE; /* mark handled to qemu */
 }
--=20
2.20.1
