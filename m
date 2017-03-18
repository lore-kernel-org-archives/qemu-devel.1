Received: from eggs.gnu.org ([2001:4830:134:3::10]:60997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cpG32-0002jm-OM
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 11:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cpG2z-0000MU-KC
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 11:13:40 -0400
Received: from mailout3.w1.samsung.com ([210.118.77.13]:54589)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1cpG2z-0000Kh-Dc
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 11:13:37 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout3.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0ON0002OZNMKE660@mailout3.w1.samsung.com> for
	qemu-devel@nongnu.org; Sat, 18 Mar 2017 15:13:32 +0000 (GMT)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Sat, 18 Mar 2017 18:13:22 +0300
Message-id: <1489850003-5652-2-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1489850003-5652-1-git-send-email-a.perevalov@samsung.com>
References: <1489850003-5652-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170318151330eucas1p102b9378cc23a399528fa7f2440846650@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH 1/2] userfault: add pid into uffd_msg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: i.maximets@samsung.com, a.perevalov@samsung.com

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 linux-headers/linux/userfaultfd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-headers/linux/userfaultfd.h b/linux-headers/linux/userfaultfd.h
index 2ed5dc3..7b299a2 100644
--- a/linux-headers/linux/userfaultfd.h
+++ b/linux-headers/linux/userfaultfd.h
@@ -77,6 +77,7 @@ struct uffd_msg {
 		struct {
 			__u64	flags;
 			__u64	address;
+			pid_t   pid;
 		} pagefault;
 
 		struct {
-- 
1.8.3.1
