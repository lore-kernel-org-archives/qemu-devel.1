Received: from eggs.gnu.org ([2001:4830:134:3::10]:45246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=884a3e257=Alistair.Francis@wdc.com>)
	id 1gZhL1-0000sE-Fh
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:17:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=884a3e257=Alistair.Francis@wdc.com>)
	id 1gZhKx-0008DM-I2
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:16:59 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Wed, 19 Dec 2018 19:16:52 +0000
Message-ID: <00d02e34f10b87fd61f8dc69ac93d1eb63df949c.1545246859.git.alistair.francis@wdc.com>
References: <cover.1545246859.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1545246859.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 04/23] exec: Add RISC-V GCC poison macro
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
 include/exec/poison.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index 32d53789f8..ecdc83c147 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -79,6 +79,7 @@
 #pragma GCC poison CONFIG_MOXIE_DIS
 #pragma GCC poison CONFIG_NIOS2_DIS
 #pragma GCC poison CONFIG_PPC_DIS
+#pragma GCC poison CONFIG_RISCV_DIS
 #pragma GCC poison CONFIG_S390_DIS
 #pragma GCC poison CONFIG_SH4_DIS
 #pragma GCC poison CONFIG_SPARC_DIS
--=20
2.19.1
