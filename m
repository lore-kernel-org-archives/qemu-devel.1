Received: from eggs.gnu.org ([2001:4830:134:3::10]:39168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fuxBZ-0005f2-Vj
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fuwzr-000313-FQ
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:42:45 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 29 Aug 2018 11:41:43 +0200
Message-Id: <20180829094143.2102-20-cohuck@redhat.com>
In-Reply-To: <20180829094143.2102-1-cohuck@redhat.com>
References: <20180829094143.2102-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/19] target/s390x: use regular spaces in
 translate.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, Cornelia Huck <cohuck@redhat.com>

From: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>

In a few places translate.c contains non-breaking spaces (0xc2 0xa0)
instead of regular ones (0x20):

  7c 7c c2 a0 63 63
  7c 7c 20    63 63
  |  |        c  c

This confuses some text editors.

Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Message-Id: <20180822144039.5796-2-pavel.zbitskiy@gmail.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 40e12ca2c4..7363aabf3a 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -842,7 +842,7 @@ static void disas_jcc(DisasContext *s, DisasCompare *=
c, uint32_t mask)
             cond =3D TCG_COND_NE;
             c->u.s32.b =3D tcg_const_i32(1);
             break;
-        case 0x8 | 0x2: /* cc =3D=3D 0 ||=C2=A0cc =3D=3D 2 =3D> (cc & 1)=
 =3D=3D 0 */
+        case 0x8 | 0x2: /* cc =3D=3D 0 || cc =3D=3D 2 =3D> (cc & 1) =3D=3D=
 0 */
             cond =3D TCG_COND_EQ;
             c->g1 =3D false;
             c->u.s32.a =3D tcg_temp_new_i32();
@@ -861,7 +861,7 @@ static void disas_jcc(DisasContext *s, DisasCompare *=
c, uint32_t mask)
             cond =3D TCG_COND_NE;
             c->u.s32.b =3D tcg_const_i32(0);
             break;
-        case 0x4 | 0x1: /* cc =3D=3D 1 ||=C2=A0cc =3D=3D 3 =3D> (cc & 1)=
 !=3D 0 */
+        case 0x4 | 0x1: /* cc =3D=3D 1 || cc =3D=3D 3 =3D> (cc & 1) !=3D=
 0 */
             cond =3D TCG_COND_NE;
             c->g1 =3D false;
             c->u.s32.a =3D tcg_temp_new_i32();
--=20
2.14.4
