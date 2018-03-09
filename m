Received: from eggs.gnu.org ([2001:4830:134:3::10]:47772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1euMfO-0005g0-AO
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1euMfK-0001ny-82
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:22:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38422
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.vnet.ibm.com>)
	id 1euMfK-0001nj-34
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:22:50 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w29IKHMb023800
	for <qemu-devel@nongnu.org>; Fri, 9 Mar 2018 13:22:49 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gkwwe3s3g-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 13:22:49 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.vnet.ibm.com>;
	Fri, 9 Mar 2018 13:22:48 -0500
From: Fabiano Rosas <farosas@linux.vnet.ibm.com>
Date: Fri,  9 Mar 2018 15:22:01 -0300
In-Reply-To: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
References: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
Message-Id: <20180309182202.31206-6-farosas@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 5/5] include/block/block_int: Document protocol
 related functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

Clarify that for protocols the brdv_file_open function is used instead
of bdrv_open and that protocol_name is expected to be set.

Signed-off-by: Fabiano Rosas <farosas@linux.vnet.ibm.com>
---
 include/block/block_int.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 64a5700f2b..d5e864c2dc 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -126,6 +126,8 @@ struct BlockDriver {
 
     int (*bdrv_open)(BlockDriverState *bs, QDict *options, int flags,
                      Error **errp);
+
+    /* Protocol drivers should implement this instead of bdrv_open */
     int (*bdrv_file_open)(BlockDriverState *bs, QDict *options, int flags,
                           Error **errp);
     void (*bdrv_close)(BlockDriverState *bs);
@@ -247,6 +249,10 @@ struct BlockDriver {
      */
     int coroutine_fn (*bdrv_co_flush_to_os)(BlockDriverState *bs);
 
+    /*
+     * Drivers that set this field should also provide a
+     * bdrv_file_open implementation
+     */
     const char *protocol_name;
     int (*bdrv_truncate)(BlockDriverState *bs, int64_t offset,
                          PreallocMode prealloc, Error **errp);
-- 
2.13.6
