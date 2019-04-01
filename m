Received: from eggs.gnu.org ([209.51.188.92]:42433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46e-0003Eu-H0
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46d-0004gk-5O
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45484
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB46c-0004Yl-Sc
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:35 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4JIB054777
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:24 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rkr97p9xm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:21 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:01:59 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:04 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-31-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 30/97] kvm: add call to qemu_add_opts() for
 -overcommit option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Prasad Singamsetty <prasad.singamsetty@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Prasad Singamsetty <prasad.singamsetty@oracle.com>

qemu command fails to process -overcommit option. Add the missing
call to qemu_add_opts() in vl.c.

Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Message-Id: <20180815175704.105902-1-prasad.singamsetty@oracle.com>
Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 1fdd4748711a62d863744f42b958472509a6f202)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 vl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/vl.c b/vl.c
index 16b913f9d5..12d27fa028 100644
--- a/vl.c
+++ b/vl.c
@@ -2987,6 +2987,7 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_object_opts);
     qemu_add_opts(&qemu_tpmdev_opts);
     qemu_add_opts(&qemu_realtime_opts);
+    qemu_add_opts(&qemu_overcommit_opts);
     qemu_add_opts(&qemu_msg_opts);
     qemu_add_opts(&qemu_name_opts);
     qemu_add_opts(&qemu_numa_opts);
-- 
2.17.1
