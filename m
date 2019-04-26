Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B079C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 11:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E213A206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 11:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E213A206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44981 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJyot-0006R4-1E
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 07:15:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hJyks-0002Qt-1f
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hJyko-0003Ki-Cu
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:10:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hJykm-0002lq-EO
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:10:54 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3QB8bDI092104
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:10:12 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s3y21n6k9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:10:12 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 26 Apr 2019 12:10:11 +0100
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
	by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 26 Apr 2019 12:10:09 +0100
Received: from b03ledav006.gho.boulder.ibm.com
	(b03ledav006.gho.boulder.ibm.com [9.17.130.237])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3QBA7g852494460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 26 Apr 2019 11:10:08 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD310C6055;
	Fri, 26 Apr 2019 11:10:07 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 135D8C6057;
	Fri, 26 Apr 2019 11:10:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.114.17.106])
	by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
	Fri, 26 Apr 2019 11:10:06 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 26 Apr 2019 07:09:56 -0400
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426111003.21246-1-borntraeger@de.ibm.com>
References: <20190426111003.21246-1-borntraeger@de.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19042611-0016-0000-0000-000009A74D04
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010998; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01194611; UDB=6.00626339;
	IPR=6.00975446; 
	MB=3.00026606; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-26 11:10:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042611-0017-0000-0000-000042F775A0
Message-Id: <20190426111003.21246-4-borntraeger@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-26_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904260078
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v2 03/10] s390x/cpumodel:
 Miscellaneous-Instruction-Extensions Facility 3
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
	Collin Walling <walling@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
	Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426110956.3W1IQQL7TgTTEu1_X0iUsalUjjQJQaiDHzc9K3eaKmk@z>

Provide the "Miscellaneous-Instruction-Extensions Facility 3" via
stfle.61.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_features.c     | 1 +
 target/s390x/cpu_features_def.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 1843c84aaa..bbd8902087 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -83,6 +83,7 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("minste2", S390_FEAT_TYPE_STFL, 58, "Miscellaneous-instruction-extensions facility 2"),
     FEAT_INIT("sema", S390_FEAT_TYPE_STFL, 59, "Semaphore-assist facility"),
     FEAT_INIT("tsi", S390_FEAT_TYPE_STFL, 60, "Time-slice Instrumentation facility"),
+    FEAT_INIT("minste3", S390_FEAT_TYPE_STFL, 61, "Miscellaneous-Instruction-Extensions Facility 3"),
     FEAT_INIT("ri", S390_FEAT_TYPE_STFL, 64, "CPU runtime-instrumentation facility"),
     FEAT_INIT("zpci", S390_FEAT_TYPE_STFL, 69, "z/PCI facility"),
     FEAT_INIT("aen", S390_FEAT_TYPE_STFL, 71, "General-purpose-adapter-event-notification facility"),
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index 5fc7e7bf01..31dd678301 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -71,6 +71,7 @@ typedef enum {
     S390_FEAT_MISC_INSTRUCTION_EXT,
     S390_FEAT_SEMAPHORE_ASSIST,
     S390_FEAT_TIME_SLICE_INSTRUMENTATION,
+    S390_FEAT_MISC_INSTRUCTION_EXT3,
     S390_FEAT_RUNTIME_INSTRUMENTATION,
     S390_FEAT_ZPCI,
     S390_FEAT_ADAPTER_EVENT_NOTIFICATION,
-- 
2.17.1


