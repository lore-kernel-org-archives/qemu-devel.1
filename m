Received: from eggs.gnu.org ([2001:4830:134:3::10]:34286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwxKK-0004Nl-SR
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 18:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwxKI-00038W-51
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 18:28:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46532 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fwxKI-00037z-0F
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 18:28:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ACBAD804B9F1
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 22:28:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue,  4 Sep 2018 00:27:54 +0200
Message-Id: <20180903222758.13267-2-quintela@redhat.com>
In-Reply-To: <20180903222758.13267-1-quintela@redhat.com>
References: <20180903222758.13267-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/5] migration/rdma: Fix uninitialised
 rdma_return_path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Clang correctly errors out moaning that rdma_return_path
is used uninitialised in the earlier error paths.
Make it NULL so that the error path ignores it.

Fixes: 55cc1b5937a8e709e4c102e74b206281073aab82
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reported-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20180830173657.22939-1-dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index ae07515e83..9b2e7e10aa 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4012,7 +4012,7 @@ static void rdma_accept_incoming_migration(void *op=
aque)
 void rdma_start_incoming_migration(const char *host_port, Error **errp)
 {
     int ret;
-    RDMAContext *rdma, *rdma_return_path;
+    RDMAContext *rdma, *rdma_return_path =3D NULL;
     Error *local_err =3D NULL;
=20
     trace_rdma_start_incoming_migration();
--=20
2.17.1
