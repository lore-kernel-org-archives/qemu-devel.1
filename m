Received: from eggs.gnu.org ([209.51.188.92]:50655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hH5GH-0002ju-3g
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hH5GF-0004Vr-GN
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:31:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hH5GF-0004Tj-3v
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:31:23 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3IBTROo147148
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 07:31:20 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rxq8239r7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 07:31:19 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 18 Apr 2019 12:31:17 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 18 Apr 2019 13:31:05 +0200
In-Reply-To: <20190418113110.160664-1-borntraeger@de.ibm.com>
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190418113110.160664-6-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 05/10] s390x/cpumodel: vector enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Add vector enhancements to the cpu model.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/cpu_features.c     | 2 ++
 target/s390x/cpu_features_def.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 4d624b2256..ed3f6aa969 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -108,6 +108,8 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("irbm", S390_FEAT_TYPE_STFL, 145, "Insert-reference-bits-multiple facility"),
     FEAT_INIT("msa8-base", S390_FEAT_TYPE_STFL, 146, "Message-security-assist-extension-8 facility (excluding subfunctions)"),
     FEAT_INIT("cmmnt", S390_FEAT_TYPE_STFL, 147, "CMM: ESSA-enhancement (no translate) facility"),
+    FEAT_INIT("vxeh2", S390_FEAT_TYPE_STFL, 148, "Vector Enhancements facility 2"),
+    FEAT_INIT("vxbeh", S390_FEAT_TYPE_STFL, 152, "Vector BCD enhancements facility 1"),
     FEAT_INIT("msa9-base", S390_FEAT_TYPE_STFL, 155, "Message-security-assist-extension-9 facility (excluding subfunctions)"),
     FEAT_INIT("etoken", S390_FEAT_TYPE_STFL, 156, "Etoken facility"),
 
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index 030784811b..ce2223c9d7 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -96,6 +96,8 @@ typedef enum {
     S390_FEAT_INSERT_REFERENCE_BITS_MULT,
     S390_FEAT_MSA_EXT_8,
     S390_FEAT_CMM_NT,
+    S390_FEAT_VECTOR_ENH2,
+    S390_FEAT_VECTOR_BCD_ENH,
     S390_FEAT_MSA_EXT_9,
     S390_FEAT_ETOKEN,
 
-- 
2.19.1
