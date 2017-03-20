Received: from eggs.gnu.org ([2001:4830:134:3::10]:41557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qy-0001zM-2N
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qq-00059j-Uq
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qq-00058R-Ip
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:44 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8WYS109589
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:43 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ak40pc7y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:43 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:42 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:23 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-60-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 59/81] target/s390x: use "qemu" cpu model in
 user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

"any" does not exist, therefore resulting in a misleading error message.

Reported-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170130145025.26475-1-david@redhat.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Alexander Graf <agraf@suse.de>
Cc: qemu-stable@nongnu.org
(cherry picked from commit d8923bc75479cd3fdcc72b7647f4877f91950b01)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 linux-user/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 75b199f..cc77ec4 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4045,6 +4045,8 @@ int main(int argc, char **argv, char **envp)
 # endif
 #elif defined TARGET_SH4
         cpu_model = TYPE_SH7785_CPU;
+#elif defined TARGET_S390X
+        cpu_model = "qemu";
 #else
         cpu_model = "any";
 #endif
-- 
2.7.4
