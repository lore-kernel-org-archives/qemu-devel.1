Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C75C606BF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 14:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C9BA21537
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 14:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C9BA21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkUpR-0003y2-Ir
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 10:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45003)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <borntraeger@de.ibm.com>) id 1hkUoi-0003Y0-Ik
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1hkUof-0006Am-OX
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:40:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1hkUoe-0005W1-VZ
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:40:29 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x68EdIwI015056
 for <qemu-devel@nongnu.org>; Mon, 8 Jul 2019 10:40:19 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tm60yw056-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 10:40:19 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Mon, 8 Jul 2019 15:40:17 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 8 Jul 2019 15:40:15 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x68EeEix34537914
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jul 2019 14:40:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2175A52051;
 Mon,  8 Jul 2019 14:40:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 109F15204E;
 Mon,  8 Jul 2019 14:40:14 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
 id CF834E0269; Mon,  8 Jul 2019 16:40:13 +0200 (CEST)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  8 Jul 2019 16:40:13 +0200
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19070814-4275-0000-0000-0000034A3A39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070814-4276-0000-0000-0000385A61F6
Message-Id: <20190708144013.83474-1-borntraeger@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-08_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=851 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907080182
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH] s390: cpumodel: fix name and description for
 the new vector facility
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The new facility is called "Vector-Packed-Decimal-Enhancement Facility"
and not "Vector BCD enhancements facility 1". Also fixup the short
name to "vxp" to match the Linux kernel.

Fixes: 54d65de0b525 ("s390x/cpumodel: vector enhancements")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/cpu_features_def.inc.h | 2 +-
 target/s390x/gen-features.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_features_def.inc.h
index ef190e2fc783..631584786921 100644
--- a/target/s390x/cpu_features_def.inc.h
+++ b/target/s390x/cpu_features_def.inc.h
@@ -104,7 +104,7 @@ DEF_FEAT(CMM_NT, "cmmnt", STFL, 147, "CMM: ESSA-enhancement (no translate) facil
 DEF_FEAT(VECTOR_ENH2, "vxeh2", STFL, 148, "Vector Enhancements facility 2")
 DEF_FEAT(ESORT_BASE, "esort-base", STFL, 150, "Enhanced-sort facility (excluding subfunctions)")
 DEF_FEAT(DEFLATE_BASE, "deflate-base", STFL, 151, "Deflate-conversion facility (excluding subfunctions)")
-DEF_FEAT(VECTOR_BCD_ENH, "vxbeh", STFL, 152, "Vector BCD enhancements facility 1")
+DEF_FEAT(VECTOR_PACKED_DEC, "vxp", STFL, 152, "Vector-Packed-Decimal-Enhancement Facility")
 DEF_FEAT(MSA_EXT_9, "msa9-base", STFL, 155, "Message-security-assist-extension-9 facility (excluding subfunctions)")
 DEF_FEAT(ETOKEN, "etoken", STFL, 156, "Etoken facility")
 
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 9f216219ff53..7b5ed15071fa 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -558,7 +558,7 @@ static uint16_t full_GEN15_GA1[] = {
     S390_FEAT_VECTOR_ENH2,
     S390_FEAT_GROUP_ENH_SORT,
     S390_FEAT_GROUP_DEFLATE_CONVERSION,
-    S390_FEAT_VECTOR_BCD_ENH,
+    S390_FEAT_VECTOR_PACKED_DEC,
     S390_FEAT_GROUP_MSA_EXT_9,
     S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
     S390_FEAT_ETOKEN,
@@ -644,7 +644,7 @@ static uint16_t default_GEN15_GA1[] = {
     S390_FEAT_VECTOR_ENH2,
     S390_FEAT_GROUP_ENH_SORT,
     S390_FEAT_GROUP_DEFLATE_CONVERSION,
-    S390_FEAT_VECTOR_BCD_ENH,
+    S390_FEAT_VECTOR_PACKED_DEC,
     S390_FEAT_GROUP_MSA_EXT_9,
     S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
     S390_FEAT_ETOKEN,
-- 
2.21.0


