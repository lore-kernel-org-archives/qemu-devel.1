Received: from eggs.gnu.org ([2001:4830:134:3::10]:49428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dT18t-000389-9m
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dT18o-0005Md-S9
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:24:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dT18o-0005LC-IV
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:23:58 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v667NpwI055475
	for <qemu-devel@nongnu.org>; Thu, 6 Jul 2017 03:23:57 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bgv9u1n0x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 03:23:57 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 6 Jul 2017 08:23:45 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu,  6 Jul 2017 09:23:37 +0200
In-Reply-To: <1499325817-9166-1-git-send-email-borntraeger@de.ibm.com>
References: <1499325817-9166-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1499325817-9166-9-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 8/8] hw/s390x/ipl: Fix endianness problem with
 netboot_start_addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Thomas Huth <thuth@redhat.com>

The start address has to be stored in big endian byte order
in the iplb.ccw block for the guest.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1499268345-12552-1-git-send-email-thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/ipl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 4e6469d..cc36003 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -418,7 +418,7 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
             error_report_err(err);
             vm_stop(RUN_STATE_INTERNAL_ERROR);
         }
-        ipl->iplb.ccw.netboot_start_addr = ipl->start_addr;
+        ipl->iplb.ccw.netboot_start_addr = cpu_to_be64(ipl->start_addr);
     }
 }
 
-- 
2.7.4
