Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30655C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF5C206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF5C206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifTPS-00085I-7F
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1ifStE-0007yr-Fh
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:08:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1ifStD-0006FK-3H
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:08:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1ifStC-0006Cl-PQ; Thu, 12 Dec 2019 13:08:39 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBCHr6XD123715; Thu, 12 Dec 2019 13:08:29 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wr8m1as35-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 13:08:29 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBCHr7u6123746;
 Thu, 12 Dec 2019 13:08:28 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wr8m1as2m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 13:08:28 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBCI5uG8015700;
 Thu, 12 Dec 2019 18:08:32 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma01wdc.us.ibm.com with ESMTP id 2wr3q705t5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 18:08:32 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBCI8Rqj44958134
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2019 18:08:27 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13509B2065;
 Thu, 12 Dec 2019 18:08:27 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05400B2067;
 Thu, 12 Dec 2019 18:08:27 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 12 Dec 2019 18:08:26 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v4 6/8] tpm_spapr: Support suspend and resume
Date: Thu, 12 Dec 2019 13:07:42 -0500
Message-Id: <20191212180744.1070446-7-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191212180744.1070446-1-stefanb@linux.vnet.ibm.com>
References: <20191212180744.1070446-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_05:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120140
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extend the tpm_spapr frontend with VM suspend and resume support.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index c4a67e2403..52e0405ab4 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -87,6 +87,8 @@ typedef struct {
     TPMVersion be_tpm_version;
 
     size_t be_buffer_size;
+
+    bool deliver_response; /* whether to deliver response after VM resume */
 } SPAPRvTPMState;
 
 static void tpm_spapr_show_buffer(const unsigned char *buffer,
@@ -255,6 +257,14 @@ static void tpm_spapr_request_completed(TPMIf *ti, int ret)
     TPMSpaprCRQ *crq = &s->crq;
     uint32_t len;
     int rc;
+    bool be_suspended;
+
+    be_suspended = tpm_backend_is_suspended(s->be_driver);
+    if (be_suspended) {
+        /* defer delivery of response until .post_load */
+        s->deliver_response |= true;
+        return;
+    }
 
     s->state = SPAPR_VTPM_STATE_COMPLETION;
 
@@ -316,6 +326,7 @@ static void tpm_spapr_reset(SpaprVioDevice *dev)
     SPAPRvTPMState *s = VIO_SPAPR_VTPM(dev);
 
     s->state = SPAPR_VTPM_STATE_NONE;
+    s->deliver_response = false;
 
     s->be_tpm_version = tpm_backend_get_tpm_version(s->be_driver);
     tpm_spapr_update_deviceclass(dev);
@@ -339,9 +350,53 @@ static enum TPMVersion tpm_spapr_get_version(TPMIf *ti)
     return tpm_backend_get_tpm_version(s->be_driver);
 }
 
+/* persistent state handling */
+
+static int tpm_spapr_pre_save(void *opaque)
+{
+    SPAPRvTPMState *s = opaque;
+
+    s->deliver_response |= tpm_backend_finish_sync(s->be_driver);
+
+    trace_tpm_spapr_pre_save(s->deliver_response);
+    /*
+     * we cannot deliver the results to the VM since DMA would touch VM memory
+     */
+
+    return 0;
+}
+
+static int tpm_spapr_post_load(void *opaque, int version_id)
+{
+    SPAPRvTPMState *s = opaque;
+
+    if (s->deliver_response) {
+        trace_tpm_spapr_post_load();
+        /* deliver the results to the VM via DMA */
+        tpm_spapr_request_completed(TPM_IF(s), 0);
+        s->deliver_response = false;
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_spapr_vtpm = {
     .name = "tpm-spapr",
-    .unmigratable = 1,
+    .version_id = 1,
+    .minimum_version_id = 0,
+    .minimum_version_id_old = 0,
+    .pre_save = tpm_spapr_pre_save,
+    .post_load = tpm_spapr_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_SPAPR_VIO(vdev, SPAPRvTPMState),
+
+        VMSTATE_UINT8(state, SPAPRvTPMState),
+        VMSTATE_BUFFER(buffer, SPAPRvTPMState),
+        /* remember DMA address */
+        VMSTATE_UINT32(crq.s.data, SPAPRvTPMState),
+        VMSTATE_BOOL(deliver_response, SPAPRvTPMState),
+        VMSTATE_END_OF_LIST(),
+    }
 };
 
 static Property tpm_spapr_properties[] = {
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 6278a39618..d109661b96 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -67,3 +67,5 @@ tpm_spapr_do_crq_get_version(uint32_t version) "response: version %u"
 tpm_spapr_do_crq_prepare_to_suspend(void) "response: preparing to suspend"
 tpm_spapr_do_crq_unknown_msg_type(uint8_t type) "Unknown message type 0x%02x"
 tpm_spapr_do_crq_unknown_crq(uint8_t raw1, uint8_t raw2) "unknown CRQ 0x%02x 0x%02x ..."
+tpm_spapr_pre_save(bool v) "TPM response to deliver after resume: %d"
+tpm_spapr_post_load(void) "Delivering TPM response after resume"
-- 
2.21.0


