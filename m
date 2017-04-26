Received: from eggs.gnu.org ([2001:4830:134:3::10]:60662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d3FA2-0001xU-HA
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 01:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d3F9x-0002ty-Ib
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 01:06:42 -0400
Received: from mailout3.w1.samsung.com ([210.118.77.13]:32442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1d3F9x-0002tk-C8
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 01:06:37 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout3.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OP00065M3IYHU80@mailout3.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:06:34 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Wed, 26 Apr 2017 08:06:15 +0300
Message-id: <1493183181-21962-2-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1493183181-21962-1-git-send-email-a.perevalov@samsung.com>
References: <1493183181-21962-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170426050632eucas1p11fb353bd5801ae238a9adf55dcd0ea09@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH V3 1/6] userfault: add pid into uffd_msg &
 update UFFD_FEATURE_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com
Cc: a.perevalov@samsung.com, i.maximets@samsung.com, f4bug@amsat.org, peterx@redhat.com, qemu-devel@nongnu.org

This commit duplicates header of "userfaultfd: provide pid in userfault msg"
into linux kernel.

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 linux-headers/linux/userfaultfd.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-headers/linux/userfaultfd.h b/linux-headers/linux/userfaultfd.h
index 2ed5dc3..e7c8898 100644
--- a/linux-headers/linux/userfaultfd.h
+++ b/linux-headers/linux/userfaultfd.h
@@ -77,6 +77,9 @@ struct uffd_msg {
 		struct {
 			__u64	flags;
 			__u64	address;
+			union {
+				__u32   ptid;
+			} feat;
 		} pagefault;
 
 		struct {
@@ -158,6 +161,8 @@ struct uffdio_api {
 #define UFFD_FEATURE_EVENT_MADVDONTNEED		(1<<3)
 #define UFFD_FEATURE_MISSING_HUGETLBFS		(1<<4)
 #define UFFD_FEATURE_MISSING_SHMEM		(1<<5)
+#define UFFD_FEATURE_EVENT_UNMAP		(1<<6)
+#define UFFD_FEATURE_THREAD_ID			(1<<7)
 	__u64 features;
 
 	__u64 ioctls;
-- 
1.9.1
