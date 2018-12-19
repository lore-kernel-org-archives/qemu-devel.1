Received: from eggs.gnu.org ([2001:4830:134:3::10]:46400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=884a3e257=Alistair.Francis@wdc.com>)
	id 1gZhOM-0003OV-1C
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:20:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=884a3e257=Alistair.Francis@wdc.com>)
	id 1gZhOD-0002SR-T5
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:20:23 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Wed, 19 Dec 2018 19:20:09 +0000
Message-ID: <caa478c8987d6042434bb9582017cdf0ea192208.1545246859.git.alistair.francis@wdc.com>
References: <cover.1545246859.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1545246859.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 22/23] dias: Add RISC-V support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/disas.c b/disas.c
index f9c517b358..d9aa713a40 100644
--- a/disas.c
+++ b/disas.c
@@ -522,8 +522,14 @@ void disas(FILE *out, void *code, unsigned long size)
 # ifdef _ARCH_PPC64
     s.info.cap_mode =3D CS_MODE_64;
 # endif
-#elif defined(__riscv__)
-    print_insn =3D print_insn_riscv;
+#elif defined(__riscv) && defined(CONFIG_RISCV_DIS)
+#if defined(_ILP32) || (__riscv_xlen =3D=3D 32)
+    print_insn =3D print_insn_riscv32;
+#elif defined(_LP64)
+    print_insn =3D print_insn_riscv64;
+#else
+#error unsupported RISC-V ABI
+#endif
 #elif defined(__aarch64__) && defined(CONFIG_ARM_A64_DIS)
     print_insn =3D print_insn_arm_a64;
     s.info.cap_arch =3D CS_ARCH_ARM64;
--=20
2.19.1
