Received: from eggs.gnu.org ([2001:4830:134:3::10]:56737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7372f4cb7=Alistair.Francis@wdc.com>)
	id 1fiSpk-0002gJ-Ta
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 19:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7372f4cb7=Alistair.Francis@wdc.com>)
	id 1fiSph-0004hG-TP
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 19:04:40 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:53221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7372f4cb7=Alistair.Francis@wdc.com>)
	id 1fiSph-0004g4-Gn
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 19:04:37 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Wed, 25 Jul 2018 16:04:25 -0700
Message-Id: <7fc5c46c407bccc9089d7f705bdc8caaea2b67b0.1532559484.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1532559484.git.alistair.francis@wdc.com>
References: <cover.1532559484.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 4/4] target/riscv: set mtval and stval
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mjc@sifive.com
Cc: alistair.francis@wdc.com, alistair23@gmail.com

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d630e8fd6c..b33950a2d4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -133,6 +133,8 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
     set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
+    set_feature(env, RISCV_FEATURE_MTVAL_INST);
+    set_feature(env, RISCV_FEATURE_STVAL_INST);
 }
 
 static void rv32imacu_nommu_cpu_init(Object *obj)
@@ -161,6 +163,8 @@ static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
     set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
+    set_feature(env, RISCV_FEATURE_MTVAL_INST);
+    set_feature(env, RISCV_FEATURE_STVAL_INST);
 }
 
 static void rv64imacu_nommu_cpu_init(Object *obj)
-- 
2.17.1
