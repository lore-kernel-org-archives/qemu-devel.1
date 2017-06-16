Received: from eggs.gnu.org ([2001:4830:134:3::10]:49617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dLwfU-000793-Nr
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 15:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dLwfP-0007Pd-QN
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 15:12:28 -0400
Received: from mailout4.w1.samsung.com ([210.118.77.14]:20722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dLwfP-0007PL-KB
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 15:12:23 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout4.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0ORN00H8BMOLOA20@mailout4.w1.samsung.com> for
	qemu-devel@nongnu.org; Fri, 16 Jun 2017 20:12:21 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Fri, 16 Jun 2017 22:11:58 +0300
Message-id: <1497640325-10960-2-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1497640325-10960-1-git-send-email-a.perevalov@samsung.com>
References: <1497640325-10960-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170616191219eucas1p197a274ce1b480821ac4813cde42aeb74@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH v9 1/8] userfault: add pid into uffd_msg &
 update UFFD_FEATURE_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, peterx@redhat.com, i.maximets@samsung.com, quintela@redhat.com, dgilbert@redhat.com

This commit duplicates header of "userfaultfd: provide pid in userfault msg"
into linux kernel.

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 linux-headers/linux/userfaultfd.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-headers/linux/userfaultfd.h b/linux-headers/linux/userfaultfd.h
index 9701772..eda028c 100644
--- a/linux-headers/linux/userfaultfd.h
+++ b/linux-headers/linux/userfaultfd.h
@@ -78,6 +78,9 @@ struct uffd_msg {
 		struct {
 			__u64	flags;
 			__u64	address;
+			union {
+				__u32   ptid;
+			} feat;
 		} pagefault;
 
 		struct {
@@ -161,6 +164,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_MISSING_HUGETLBFS		(1<<4)
 #define UFFD_FEATURE_MISSING_SHMEM		(1<<5)
 #define UFFD_FEATURE_EVENT_UNMAP		(1<<6)
+#define UFFD_FEATURE_THREAD_ID			(1<<7)
 	__u64 features;
 
 	__u64 ioctls;
-- 
1.8.3.1
