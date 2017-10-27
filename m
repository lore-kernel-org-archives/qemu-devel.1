Received: from eggs.gnu.org ([2001:4830:134:3::10]:59045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e829R-0005k0-Aw
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:46:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e829Q-0001X1-IC
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:46:09 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 27 Oct 2017 12:45:46 +0200
Message-Id: <20171027104546.8582-1-eblake@redhat.com>
In-Reply-To: <20171027104037.8319-1-eblake@redhat.com>
References: <20171027104037.8319-1-eblake@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v6 13/12] tweak test 83 verbosity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Commenting these two lines is enough to avoid the change to 083.out
in 12/12.  That is evidence that we may want these two lines to be
trace points rather than error messages; or maybe we really do like
the extra verbosity in the case of an unexpected communication break.

This patch does not meet coding guidelines, and I'm not proud enough
of it to give S-o-b, but I'm posting it for conversation.

---
 block/nbd-client.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index b44d4d4a01..e063b3fbc0 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -654,7 +654,8 @@ static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,

     ret = nbd_co_receive_return_code(client, request->handle, &local_err);
     if (local_err) {
-        error_report_err(local_err);
+        assert(ret < 0);
+//        error_report_err(local_err);
     }
     return ret;
 }
@@ -682,7 +683,7 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
     ret = nbd_co_receive_cmdread_reply(client, request.handle, offset, qiov,
                                        &local_err);
     if (ret < 0) {
-        error_report_err(local_err);
+        //error_report_err(local_err);
     }
     return ret;
 }
-- 
2.13.6
