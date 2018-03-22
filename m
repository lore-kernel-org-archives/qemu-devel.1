Received: from eggs.gnu.org ([2001:4830:134:3::10]:40149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eywtn-0003T7-8J
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eywtm-0000Ix-HA
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:52:43 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Thu, 22 Mar 2018 11:52:19 +0200
Message-Id: <20180322095220.9976-3-yuval.shaia@oracle.com>
In-Reply-To: <20180322095220.9976-1-yuval.shaia@oracle.com>
References: <20180322095220.9976-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-2.12 2/3] hw/rdma: Use correct print
 format in CHK_ATTR macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel@redhat.com, eblake@redhat.com, f4bug@amsat.org, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Macro should not cast the given variable to u64 instead it should use
the supplied format argument (fmt).

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/rdma/rdma_backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index f1a37ba4a2..0391a7dd95 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -656,8 +656,8 @@ void rdma_backend_destroy_qp(RdmaBackendQP *qp)
 #define CHK_ATTR(req, dev, member, fmt) ({ \
     pr_dbg("%s=3D"fmt","fmt"\n", #member, dev.member, req->member); \
     if (req->member > dev.member) { \
-        warn_report("%s =3D 0x%lx is higher than host device capability =
0x%lx", \
-                    #member, (uint64_t)req->member, (uint64_t)dev.member=
); \
+        warn_report("%s =3D "fmt" is higher than host device capability =
"fmt, \
+                    #member, req->member, dev.member); \
         req->member =3D dev.member; \
     } \
     pr_dbg("%s=3D"fmt"\n", #member, req->member); })
--=20
2.13.6
