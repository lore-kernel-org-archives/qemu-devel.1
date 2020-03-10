Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B255AC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D2A20727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D2A20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBgXI-0007kO-Kn
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1jBgW8-0005wi-AR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1jBgW7-0003vD-2M
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:10:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1jBgW6-0003te-QC
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:09:58 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02AF1aaJ126027
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 11:09:58 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ym852247b-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 11:09:57 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Tue, 10 Mar 2020 15:09:55 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 10 Mar 2020 15:09:51 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 02AF8oNW48890240
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 15:08:50 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A38DEA406F;
 Tue, 10 Mar 2020 15:09:49 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 919D5A406E;
 Tue, 10 Mar 2020 15:09:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue, 10 Mar 2020 15:09:49 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
 id 54687E0249; Tue, 10 Mar 2020 16:09:49 +0100 (CET)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/4] s390/ipl: sync back loadparm
Date: Tue, 10 Mar 2020 16:09:46 +0100
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310150947.3510824-1-borntraeger@de.ibm.com>
References: <20200310150947.3510824-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031015-0008-0000-0000-0000035B3407
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031015-0009-0000-0000-00004A7C778F
Message-Id: <20200310150947.3510824-4-borntraeger@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-10_08:2020-03-10,
 2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100099
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Halil Pasic <pasic@linux.ibm.com>

We expose loadparm as a r/w machine property, but if loadparm is set by
the guest via DIAG 308, we don't update the property. Having a
disconnect between the guest view and the QEMU property is not nice in
itself, but things get even worse for SCSI, where under certain
circumstances (see 789b5a401b "s390: Ensure IPL from SCSI works as
expected" for details) we call s390_gen_initial_iplb() on resets
effectively overwriting the guest/user supplied loadparm with the stale
value.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Fixes: 7104bae9de ("hw/s390x: provide loadparm property for the machine")
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Viktor Mihajlovski <mihajlov@linux.ibm.com>
Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200309133223.100491-1-pasic@linux.ibm.com>
[borntraeger@de.ibm.com: use reverse xmas tree]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/ipl.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 9c1ecd423c23..b81942e1e6f9 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -538,6 +538,30 @@ static bool is_virtio_scsi_device(IplParameterBlock *iplb)
     return is_virtio_ccw_device_of_type(iplb, VIRTIO_ID_SCSI);
 }
 
+static void update_machine_ipl_properties(IplParameterBlock *iplb)
+{
+    Object *machine = qdev_get_machine();
+    Error *err = NULL;
+
+    /* Sync loadparm */
+    if (iplb->flags & DIAG308_FLAGS_LP_VALID) {
+        uint8_t *ebcdic_loadparm = iplb->loadparm;
+        char ascii_loadparm[8];
+        int i;
+
+        for (i = 0; i < 8 && ebcdic_loadparm[i]; i++) {
+            ascii_loadparm[i] = ebcdic2ascii[(uint8_t) ebcdic_loadparm[i]];
+        }
+        ascii_loadparm[i] = 0;
+        object_property_set_str(machine, ascii_loadparm, "loadparm", &err);
+    } else {
+        object_property_set_str(machine, "", "loadparm", &err);
+    }
+    if (err) {
+        warn_report_err(err);
+    }
+}
+
 void s390_ipl_update_diag308(IplParameterBlock *iplb)
 {
     S390IPLState *ipl = get_ipl_device();
@@ -545,6 +569,7 @@ void s390_ipl_update_diag308(IplParameterBlock *iplb)
     ipl->iplb = *iplb;
     ipl->iplb_valid = true;
     ipl->netboot = is_virtio_net_device(iplb);
+    update_machine_ipl_properties(iplb);
 }
 
 IplParameterBlock *s390_ipl_get_iplb(void)
-- 
2.24.1


