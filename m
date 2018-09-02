Received: from eggs.gnu.org ([2001:4830:134:3::10]:41437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fwGL6-0001SL-5H
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 20:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fwGL2-0003Nn-Vd
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 20:34:04 -0400
From: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Date: Sat,  1 Sep 2018 20:33:20 -0400
Message-Id: <20180902003322.3428-2-pavel.zbitskiy@gmail.com>
In-Reply-To: <20180902003322.3428-1-pavel.zbitskiy@gmail.com>
References: <20180902003322.3428-1-pavel.zbitskiy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 1/3] target/s390x: use regular spaces in
 translate.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com, richard.henderson@linaro.org, Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

In a few places translate.c contains non-breaking spaces (0xc2 0xa0)
instead of regular ones (0x20):

  7c 7c c2 a0 63 63
  7c 7c 20    63 63
  |  |        c  c

This confuses some text editors.

Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 40e12ca2c4..7363aabf3a 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -842,7 +842,7 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
             cond = TCG_COND_NE;
             c->u.s32.b = tcg_const_i32(1);
             break;
-        case 0x8 | 0x2: /* cc == 0 || cc == 2 => (cc & 1) == 0 */
+        case 0x8 | 0x2: /* cc == 0 || cc == 2 => (cc & 1) == 0 */
             cond = TCG_COND_EQ;
             c->g1 = false;
             c->u.s32.a = tcg_temp_new_i32();
@@ -861,7 +861,7 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
             cond = TCG_COND_NE;
             c->u.s32.b = tcg_const_i32(0);
             break;
-        case 0x4 | 0x1: /* cc == 1 || cc == 3 => (cc & 1) != 0 */
+        case 0x4 | 0x1: /* cc == 1 || cc == 3 => (cc & 1) != 0 */
             cond = TCG_COND_NE;
             c->g1 = false;
             c->u.s32.a = tcg_temp_new_i32();
-- 
2.18.0
