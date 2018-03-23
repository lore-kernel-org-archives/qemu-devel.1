Received: from eggs.gnu.org ([2001:4830:134:3::10]:36087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ezP0T-00005i-J0
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ezP0S-0007rK-O4
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54836 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ezP0S-0007qu-Jr
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:28 -0400
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Fri, 23 Mar 2018 18:53:05 +0300
Message-Id: <20180323155306.83812-8-marcel@redhat.com>
In-Reply-To: <20180323155306.83812-1-marcel@redhat.com>
References: <20180323155306.83812-1-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH PULL 7/8] hw/rdma: Use correct print format in
 CHK_ATTR macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, yuval.shaia@oracle.com, mst@redhat.com, marcel@redhat.com, f4bug@amsat.org, eblake@redhat.com, berrange@redhat.com, stefanha@redhat.com

From: Yuval Shaia <yuval.shaia@oracle.com>

Macro should not cast the given variable to u64 instead it should use
the supplied format argument (fmt).

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180322095220.9976-3-yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/rdma/rdma_backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index b1d2913b2c..1dbb17bd2e 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -668,8 +668,8 @@ void rdma_backend_destroy_qp(RdmaBackendQP *qp)
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
2.13.5
