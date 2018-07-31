Received: from eggs.gnu.org ([2001:4830:134:3::10]:42114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fkQaT-00051c-TL
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fkQaO-0006GT-WD
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:05:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41440
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fkQaO-0006Fq-Q2
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:04:56 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6V94j60097110
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 05:04:56 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2kjkmck4mh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 05:04:55 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 31 Jul 2018 10:04:54 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 11:04:47 +0200
In-Reply-To: <20180731090448.36662-1-borntraeger@de.ibm.com>
References: <20180731090448.36662-1-borntraeger@de.ibm.com>
Message-Id: <20180731090448.36662-2-borntraeger@de.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH 1/2] header sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

-> place holder for proper header sync.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 linux-headers/asm-s390/kvm.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index 11def14301..1ab9901911 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -4,7 +4,7 @@
 /*
  * KVM s390 specific structures and definitions
  *
- * Copyright IBM Corp. 2008
+ * Copyright IBM Corp. 2008, 2018
  *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *               Christian Borntraeger <borntraeger@de.ibm.com>
@@ -225,6 +225,7 @@ struct kvm_guest_debug_arch {
 #define KVM_SYNC_FPRS   (1UL << 8)
 #define KVM_SYNC_GSCB   (1UL << 9)
 #define KVM_SYNC_BPBC   (1UL << 10)
+#define KVM_SYNC_ETOKEN (1UL << 11)
 /* length and alignment of the sdnx as a power of two */
 #define SDNXC 8
 #define SDNXL (1UL << SDNXC)
@@ -258,6 +259,8 @@ struct kvm_sync_regs {
 		struct {
 			__u64 reserved1[2];
 			__u64 gscb[4];
+			__u64 etoken;
+			__u64 etoken_extension;
 		};
 	};
 };
-- 
2.17.0
