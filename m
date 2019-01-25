Received: from eggs.gnu.org ([209.51.188.92]:52576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remi@remlab.net>) id 1gn9M8-0001Si-Jl
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 16:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remi@remlab.net>) id 1gn9M7-00035D-0Q
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 16:49:44 -0500
From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
Date: Fri, 25 Jan 2019 23:49:26 +0200
Message-Id: <20190125214926.3204-3-remi@remlab.net>
In-Reply-To: <1648289.tQCHxfjYn9@basile.remlab.net>
References: <1648289.tQCHxfjYn9@basile.remlab.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] target/arm: fix decoding of B{,L}RA{A,B}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org

From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>

A flawed test lead to the instructions always being treated as
unallocated encodings.

Signed-off-by: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
---
 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 4d28a27c3b..c550a3f013 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2036,7 +2036,7 @@ static void disas_uncond_b_reg(DisasContext *s, uin=
t32_t insn)
         if (!dc_isar_feature(aa64_pauth, s)) {
             goto do_unallocated;
         }
-        if (op3 !=3D 2 || op3 !=3D 3) {
+        if ((op3 & ~1) !=3D 2) {
             goto do_unallocated;
         }
         if (s->pauth_active) {
--=20
2.20.1
