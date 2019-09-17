Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43041C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 170D1214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170D1214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAAlV-0006wG-DK
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 06:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iAAbl-0006pq-Ms
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iAAbk-0003jz-Bb
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:21:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iAAbk-0003jh-3Q
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:21:16 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8HAHFN0110686
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 06:21:15 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v2w62hc0k-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 06:21:15 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Tue, 17 Sep 2019 11:21:11 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 17 Sep 2019 11:21:05 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x8HAL3Jh44696046
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Sep 2019 10:21:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A554311C04C;
 Tue, 17 Sep 2019 10:21:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB1EA11C04A;
 Tue, 17 Sep 2019 10:21:02 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.22.84])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 17 Sep 2019 10:21:02 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 12:21:02 +0200
In-Reply-To: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
References: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19091710-0012-0000-0000-0000034D13F6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091710-0013-0000-0000-000021878DA5
Message-Id: <156871566233.196432.93294155722199104.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-17_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=962 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909170106
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH 05/17] arm: Pass local error object pointer to
 error_append_hint()
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Daniel P. =?utf-8?q?Berrang=C3=A9=22?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org"@d06av25.portsmouth.uk.ibm.com,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yuval Shaia <yuval.shaia@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ensure that hints are added even if errp is &error_fatal or &error_abort.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/arm/msf2-soc.c       |    5 +++--
 hw/arm/virt.c           |   14 ++++++++++----
 hw/intc/arm_gicv3_kvm.c |    5 +++--
 hw/misc/msf2-sysreg.c   |    6 ++++--
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 008fd9327aa4..f606cfe7d139 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -127,8 +127,9 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     }
 
     if (!s->m3clk) {
-        error_setg(errp, "Invalid m3clk value");
-        error_append_hint(errp, "m3clk can not be zero\n");
+        error_setg(&err, "Invalid m3clk value");
+        error_append_hint(&err, "m3clk can not be zero\n");
+        error_propagate(errp, err);
         return;
     }
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d74538b0212e..7ac00dab581e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1804,8 +1804,11 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
     } else if (!strcmp(value, "max")) {
         vms->gic_version = -1; /* Will probe later */
     } else {
-        error_setg(errp, "Invalid gic-version value");
-        error_append_hint(errp, "Valid values are 3, 2, host, max.\n");
+        Error *err = NULL;
+
+        error_setg(&err, "Invalid gic-version value");
+        error_append_hint(&err, "Valid values are 3, 2, host, max.\n");
+        error_propagate(errp, err);
     }
 }
 
@@ -1832,8 +1835,11 @@ static void virt_set_iommu(Object *obj, const char *value, Error **errp)
     } else if (!strcmp(value, "none")) {
         vms->iommu = VIRT_IOMMU_NONE;
     } else {
-        error_setg(errp, "Invalid iommu value");
-        error_append_hint(errp, "Valid values are none, smmuv3.\n");
+        Error *err = NULL;
+
+        error_setg(&err, "Invalid iommu value");
+        error_append_hint(&err, "Valid values are none, smmuv3.\n");
+        error_propagate(errp, err);
     }
 }
 
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 9c7f4ab8711c..09784f06f9ad 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -810,10 +810,11 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
                               KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION);
 
     if (!multiple_redist_region_allowed && s->nb_redist_regions > 1) {
-        error_setg(errp, "Multiple VGICv3 redistributor regions are not "
+        error_setg(&local_err, "Multiple VGICv3 redistributor regions are not "
                    "supported by this host kernel");
-        error_append_hint(errp, "A maximum of %d VCPUs can be used",
+        error_append_hint(&local_err, "A maximum of %d VCPUs can be used",
                           s->redist_region_count[0]);
+        error_propagate(errp, local_err);
         return;
     }
 
diff --git a/hw/misc/msf2-sysreg.c b/hw/misc/msf2-sysreg.c
index ddc5a30c80f7..23c7890ac022 100644
--- a/hw/misc/msf2-sysreg.c
+++ b/hw/misc/msf2-sysreg.c
@@ -128,12 +128,14 @@ static Property msf2_sysreg_properties[] = {
 static void msf2_sysreg_realize(DeviceState *dev, Error **errp)
 {
     MSF2SysregState *s = MSF2_SYSREG(dev);
+    Error *local_err = NULL;
 
     if ((s->apb0div > 32 || !is_power_of_2(s->apb0div))
         || (s->apb1div > 32 || !is_power_of_2(s->apb1div))) {
-        error_setg(errp, "Invalid apb divisor value");
-        error_append_hint(errp, "apb divisor must be a power of 2"
+        error_setg(&local_err, "Invalid apb divisor value");
+        error_append_hint(&local_err, "apb divisor must be a power of 2"
                            " and maximum value is 32\n");
+        error_propagate(errp, local_err);
     }
 }
 


