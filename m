Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9B1C2D0C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35C60206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C60206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwd2-0001WG-Kl
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1ihwSc-0001s0-L2
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:07:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1ihwSX-0006eh-8i
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:07:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62138)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1ihwSW-0005W1-Ss; Thu, 19 Dec 2019 09:07:21 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBJE2Qee122565; Thu, 19 Dec 2019 09:07:04 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2x09a3uqj6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2019 09:07:03 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBJE2VOZ123035;
 Thu, 19 Dec 2019 09:06:58 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2x09a3uqfv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2019 09:06:57 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBJE4rdf023134;
 Thu, 19 Dec 2019 14:06:56 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma01dal.us.ibm.com with ESMTP id 2wvqc7ajp1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2019 14:06:56 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBJE6thv29163906
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Dec 2019 14:06:55 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08358AC05E;
 Thu, 19 Dec 2019 14:06:55 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E470CAC062;
 Thu, 19 Dec 2019 14:06:54 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 19 Dec 2019 14:06:54 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v7 1/6] tpm: Move tpm_tis_show_buffer to tpm_util.c
Date: Thu, 19 Dec 2019 09:06:00 -0500
Message-Id: <20191219140605.3243321-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191219140605.3243321-1-stefanb@linux.vnet.ibm.com>
References: <20191219140605.3243321-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_01:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 suspectscore=3 impostorscore=0 phishscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190119
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
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_tis.c    | 32 ++++----------------------------
 hw/tpm/tpm_util.c   | 25 +++++++++++++++++++++++++
 hw/tpm/tpm_util.h   |  3 +++
 hw/tpm/trace-events |  2 +-
 4 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 7aaf9b946d..5b17c88a7d 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -107,30 +107,6 @@ static uint8_t tpm_tis_locality_from_addr(hwaddr addr)
     return (uint8_t)((addr >> TPM_TIS_LOCALITY_SHIFT) & 0x7);
 }
 
-static void tpm_tis_show_buffer(const unsigned char *buffer,
-                                size_t buffer_size, const char *string)
-{
-    size_t len, i;
-    char *line_buffer, *p;
-
-    len = MIN(tpm_cmd_get_size(buffer), buffer_size);
-
-    /*
-     * allocate enough room for 3 chars per buffer entry plus a
-     * newline after every 16 chars and a final null terminator.
-     */
-    line_buffer = g_malloc(len * 3 + (len / 16) + 1);
-
-    for (i = 0, p = line_buffer; i < len; i++) {
-        if (i && !(i % 16)) {
-            p += sprintf(p, "\n");
-        }
-        p += sprintf(p, "%.2X ", buffer[i]);
-    }
-    trace_tpm_tis_show_buffer(string, len, line_buffer);
-
-    g_free(line_buffer);
-}
 
 /*
  * Set the given flags in the STS register by clearing the register but
@@ -156,8 +132,8 @@ static void tpm_tis_sts_set(TPMLocality *l, uint32_t flags)
  */
 static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
 {
-    if (trace_event_get_state_backends(TRACE_TPM_TIS_SHOW_BUFFER)) {
-        tpm_tis_show_buffer(s->buffer, s->be_buffer_size, "To TPM");
+    if (trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER)) {
+        tpm_util_show_buffer(s->buffer, s->be_buffer_size, "To TPM");
     }
 
     /*
@@ -325,8 +301,8 @@ static void tpm_tis_request_completed(TPMIf *ti, int ret)
     s->loc[locty].state = TPM_TIS_STATE_COMPLETION;
     s->rw_offset = 0;
 
-    if (trace_event_get_state_backends(TRACE_TPM_TIS_SHOW_BUFFER)) {
-        tpm_tis_show_buffer(s->buffer, s->be_buffer_size, "From TPM");
+    if (trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER)) {
+        tpm_util_show_buffer(s->buffer, s->be_buffer_size, "From TPM");
     }
 
     if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index 62b091f0c0..c0a0f3d71f 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -350,3 +350,28 @@ void tpm_sized_buffer_reset(TPMSizedBuffer *tsb)
     tsb->buffer = NULL;
     tsb->size = 0;
 }
+
+void tpm_util_show_buffer(const unsigned char *buffer,
+                          size_t buffer_size, const char *string)
+{
+    size_t len, i;
+    char *line_buffer, *p;
+
+    len = MIN(tpm_cmd_get_size(buffer), buffer_size);
+
+    /*
+     * allocate enough room for 3 chars per buffer entry plus a
+     * newline after every 16 chars and a final null terminator.
+     */
+    line_buffer = g_malloc(len * 3 + (len / 16) + 1);
+
+    for (i = 0, p = line_buffer; i < len; i++) {
+        if (i && !(i % 16)) {
+            p += sprintf(p, "\n");
+        }
+        p += sprintf(p, "%.2X ", buffer[i]);
+    }
+    trace_tpm_util_show_buffer(string, len, line_buffer);
+
+    g_free(line_buffer);
+}
diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
index f397ac21b8..7889081fba 100644
--- a/hw/tpm/tpm_util.h
+++ b/hw/tpm/tpm_util.h
@@ -79,4 +79,7 @@ typedef struct TPMSizedBuffer {
 
 void tpm_sized_buffer_reset(TPMSizedBuffer *tsb);
 
+void tpm_util_show_buffer(const unsigned char *buffer,
+                          size_t buffer_size, const char *string);
+
 #endif /* TPM_TPM_UTIL_H */
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 89804bcd64..357c9e9a84 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -14,6 +14,7 @@ tpm_util_get_buffer_size_len(uint32_t len, size_t expected) "tpm_resp->len = %u,
 tpm_util_get_buffer_size_hdr_len2(uint32_t len, size_t expected) "tpm2_resp->hdr.len = %u, expected = %zu"
 tpm_util_get_buffer_size_len2(uint32_t len, size_t expected) "tpm2_resp->len = %u, expected = %zu"
 tpm_util_get_buffer_size(size_t len) "buffersize of device: %zu"
+tpm_util_show_buffer(const char *direction, size_t len, const char *buf) "direction: %s len: %zu\n%s"
 
 # tpm_emulator.c
 tpm_emulator_set_locality(uint8_t locty) "setting locality to %d"
@@ -36,7 +37,6 @@ tpm_emulator_pre_save(void) ""
 tpm_emulator_inst_init(void) ""
 
 # tpm_tis.c
-tpm_tis_show_buffer(const char *direction, size_t len, const char *buf) "direction: %s len: %zu\nbuf: %s"
 tpm_tis_raise_irq(uint32_t irqmask) "Raising IRQ for flag 0x%08x"
 tpm_tis_new_active_locality(uint8_t locty) "Active locality is now %d"
 tpm_tis_abort(uint8_t locty) "New active locality is %d"
-- 
2.21.0


