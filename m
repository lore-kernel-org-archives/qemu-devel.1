Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F80C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09327214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09327214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAAeH-0000GW-B9
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 06:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iAAbg-0006iV-Cw
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:21:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iAAbf-0003hh-1n
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:21:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iAAbe-0003hP-Pp
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:21:11 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8HAI3ds034933
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 06:21:10 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v2v5vv5n5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 06:21:09 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Tue, 17 Sep 2019 11:21:06 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 17 Sep 2019 11:20:59 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8HAKv0O56229996
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Sep 2019 10:20:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 510BB42045;
 Tue, 17 Sep 2019 10:20:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59A8542041;
 Tue, 17 Sep 2019 10:20:56 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.22.84])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 17 Sep 2019 10:20:56 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 12:20:56 +0200
In-Reply-To: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
References: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19091710-4275-0000-0000-000003678A3C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091710-4276-0000-0000-00003879EF6F
Message-Id: <156871565600.196432.9246692833113774428.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-17_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909170106
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH 04/17] ppc: Pass local error object pointer to
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
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. =?utf-8?q?Berrang=C3=A9=22?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org"@d06av24.portsmouth.uk.ibm.com,
 Eric Farman <farman@linux.ibm.com>,
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
 hw/ppc/mac_newworld.c |    7 +++++--
 hw/ppc/spapr.c        |    7 +++++--
 hw/ppc/spapr_pci.c    |    9 +++++----
 target/ppc/kvm.c      |   13 +++++++++----
 4 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index c5bbcc743352..aca8c40bf395 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -618,8 +618,11 @@ static void core99_set_via_config(Object *obj, const char *value, Error **errp)
     } else if (!strcmp(value, "pmu-adb")) {
         cms->via_config = CORE99_VIA_CONFIG_PMU_ADB;
     } else {
-        error_setg(errp, "Invalid via value");
-        error_append_hint(errp, "Valid values are cuda, pmu, pmu-adb.\n");
+        Error *local_err = NULL;
+
+        error_setg(&local_err, "Invalid via value");
+        error_append_hint(&local_err, "Valid values are cuda, pmu, pmu-adb.\n");
+        error_propagate(errp, local_err);
     }
 }
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 08a2a5a77092..39d6f57d014e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4337,10 +4337,13 @@ void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp)
     vcpu_id = spapr_vcpu_id(spapr, cpu_index);
 
     if (kvm_enabled() && !kvm_vcpu_id_is_valid(vcpu_id)) {
-        error_setg(errp, "Can't create CPU with id %d in KVM", vcpu_id);
-        error_append_hint(errp, "Adjust the number of cpus to %d "
+        Error *local_err = NULL;
+
+        error_setg(&local_err, "Can't create CPU with id %d in KVM", vcpu_id);
+        error_append_hint(&local_err, "Adjust the number of cpus to %d "
                           "or try to raise the number of threads per core\n",
                           vcpu_id * ms->smp.threads / spapr->vsmt);
+        error_propagate(errp, local_err);
         return;
     }
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7b71ad7c74f1..4b7e9a1c8666 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1870,12 +1870,13 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     if (spapr_pci_find_phb(spapr, sphb->buid)) {
         SpaprPhbState *s;
 
-        error_setg(errp, "PCI host bridges must have unique indexes");
-        error_append_hint(errp, "The following indexes are already in use:");
+        error_setg(&local_err, "PCI host bridges must have unique indexes");
+        error_append_hint(&local_err, "The following indexes are already in use:");
         QLIST_FOREACH(s, &spapr->phbs, list) {
-            error_append_hint(errp, " %d", s->index);
+            error_append_hint(&local_err, " %d", s->index);
         }
-        error_append_hint(errp, "\nTry another value for the index property\n");
+        error_append_hint(&local_err, "\nTry another value for the index property\n");
+        error_propagate(errp, local_err);
         return;
     }
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8c5b1f25cc95..c6876b08c726 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -242,8 +242,11 @@ static void kvm_get_smmu_info(struct kvm_ppc_smmu_info *info, Error **errp)
     assert(kvm_state != NULL);
 
     if (!kvm_check_extension(kvm_state, KVM_CAP_PPC_GET_SMMU_INFO)) {
-        error_setg(errp, "KVM doesn't expose the MMU features it supports");
-        error_append_hint(errp, "Consider switching to a newer KVM\n");
+        Error *local_err = NULL;
+
+        error_setg(&local_err, "KVM doesn't expose the MMU features it supports");
+        error_append_hint(&local_err, "Consider switching to a newer KVM\n");
+        error_propagate(errp, local_err);
         return;
     }
 
@@ -2076,6 +2079,7 @@ void kvmppc_hint_smt_possible(Error **errp)
     int i;
     GString *g;
     char *s;
+    Error *local_err = NULL;
 
     assert(kvm_enabled());
     if (cap_ppc_smt_possible) {
@@ -2086,12 +2090,13 @@ void kvmppc_hint_smt_possible(Error **errp)
             }
         }
         s = g_string_free(g, false);
-        error_append_hint(errp, "%s.\n", s);
+        error_append_hint(&local_err, "%s.\n", s);
         g_free(s);
     } else {
-        error_append_hint(errp,
+        error_append_hint(&local_err,
                           "This KVM seems to be too old to support VSMT.\n");
     }
+    error_propagate(errp, local_err);
 }
 
 


