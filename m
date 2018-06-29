Received: from eggs.gnu.org ([2001:4830:134:3::10]:49521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6Q-0003sp-4d
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6O-0003r9-Dx
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:21 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 29 Jun 2018 16:09:42 +0200
Message-Id: <20180629140959.6690-13-kwolf@redhat.com>
In-Reply-To: <20180629140959.6690-1-kwolf@redhat.com>
References: <20180629140959.6690-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/29] qcow2: Remove dead check on !ret
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

In the beginning of the function, we initialize the local variable to 0,
and in the body of the function, we check the assigned values and exit
the loop immediately. So here it can never be non-zero.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 4a0d92860d..2d190aa00b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1772,7 +1772,7 @@ static coroutine_fn int qcow2_handle_l2meta(BlockDr=
iverState *bs,
     while (l2meta !=3D NULL) {
         QCowL2Meta *next;
=20
-        if (!ret && link_l2) {
+        if (link_l2) {
             ret =3D qcow2_alloc_cluster_link_l2(bs, l2meta);
             if (ret) {
                 goto out;
--=20
2.13.6
