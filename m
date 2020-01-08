Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1B6C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:12:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6372206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6372206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipDwR-0002dg-Br
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 11:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1ipDub-0000XT-Co
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.ibm.com>) id 1ipDuZ-0000qQ-Oo
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:10:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59744)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
 id 1ipDuZ-0000pR-GS; Wed, 08 Jan 2020 11:10:23 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 008G7hQS188749; Wed, 8 Jan 2020 11:10:20 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xaq80d4d6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2020 11:10:19 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 008G7glN188730;
 Wed, 8 Jan 2020 11:10:18 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xaq80d4c8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2020 11:10:18 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 008G05sJ007266;
 Wed, 8 Jan 2020 16:10:16 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma05wdc.us.ibm.com with ESMTP id 2xajb6du1h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2020 16:10:16 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 008GAFof30212414
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jan 2020 16:10:15 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCC746A047;
 Wed,  8 Jan 2020 16:10:15 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 399CD6A04F;
 Wed,  8 Jan 2020 16:10:15 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jan 2020 16:10:15 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v8 1/6] tpm: Move tpm_tis_show_buffer to tpm_util.c
Date: Wed,  8 Jan 2020 11:10:07 -0500
Message-Id: <20200108161012.1821385-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108161012.1821385-1-stefanb@linux.ibm.com>
References: <20200108161012.1821385-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-08_04:2020-01-08,
 2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=3 adultscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001080132
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id 008G7hQS188749
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
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, david@gibson.dropbear.id.au,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Berger <stefanb@linux.vnet.ibm.com>

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
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
@@ -107,30 +107,6 @@ static uint8_t tpm_tis_locality_from_addr(hwaddr add=
r)
     return (uint8_t)((addr >> TPM_TIS_LOCALITY_SHIFT) & 0x7);
 }
=20
-static void tpm_tis_show_buffer(const unsigned char *buffer,
-                                size_t buffer_size, const char *string)
-{
-    size_t len, i;
-    char *line_buffer, *p;
-
-    len =3D MIN(tpm_cmd_get_size(buffer), buffer_size);
-
-    /*
-     * allocate enough room for 3 chars per buffer entry plus a
-     * newline after every 16 chars and a final null terminator.
-     */
-    line_buffer =3D g_malloc(len * 3 + (len / 16) + 1);
-
-    for (i =3D 0, p =3D line_buffer; i < len; i++) {
-        if (i && !(i % 16)) {
-            p +=3D sprintf(p, "\n");
-        }
-        p +=3D sprintf(p, "%.2X ", buffer[i]);
-    }
-    trace_tpm_tis_show_buffer(string, len, line_buffer);
-
-    g_free(line_buffer);
-}
=20
 /*
  * Set the given flags in the STS register by clearing the register but
@@ -156,8 +132,8 @@ static void tpm_tis_sts_set(TPMLocality *l, uint32_t =
flags)
  */
 static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
 {
-    if (trace_event_get_state_backends(TRACE_TPM_TIS_SHOW_BUFFER)) {
-        tpm_tis_show_buffer(s->buffer, s->be_buffer_size, "To TPM");
+    if (trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER)) {
+        tpm_util_show_buffer(s->buffer, s->be_buffer_size, "To TPM");
     }
=20
     /*
@@ -325,8 +301,8 @@ static void tpm_tis_request_completed(TPMIf *ti, int =
ret)
     s->loc[locty].state =3D TPM_TIS_STATE_COMPLETION;
     s->rw_offset =3D 0;
=20
-    if (trace_event_get_state_backends(TRACE_TPM_TIS_SHOW_BUFFER)) {
-        tpm_tis_show_buffer(s->buffer, s->be_buffer_size, "From TPM");
+    if (trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER)) {
+        tpm_util_show_buffer(s->buffer, s->be_buffer_size, "From TPM");
     }
=20
     if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index 62b091f0c0..c0a0f3d71f 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -350,3 +350,28 @@ void tpm_sized_buffer_reset(TPMSizedBuffer *tsb)
     tsb->buffer =3D NULL;
     tsb->size =3D 0;
 }
+
+void tpm_util_show_buffer(const unsigned char *buffer,
+                          size_t buffer_size, const char *string)
+{
+    size_t len, i;
+    char *line_buffer, *p;
+
+    len =3D MIN(tpm_cmd_get_size(buffer), buffer_size);
+
+    /*
+     * allocate enough room for 3 chars per buffer entry plus a
+     * newline after every 16 chars and a final null terminator.
+     */
+    line_buffer =3D g_malloc(len * 3 + (len / 16) + 1);
+
+    for (i =3D 0, p =3D line_buffer; i < len; i++) {
+        if (i && !(i % 16)) {
+            p +=3D sprintf(p, "\n");
+        }
+        p +=3D sprintf(p, "%.2X ", buffer[i]);
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
=20
 void tpm_sized_buffer_reset(TPMSizedBuffer *tsb);
=20
+void tpm_util_show_buffer(const unsigned char *buffer,
+                          size_t buffer_size, const char *string);
+
 #endif /* TPM_TPM_UTIL_H */
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 89804bcd64..357c9e9a84 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -14,6 +14,7 @@ tpm_util_get_buffer_size_len(uint32_t len, size_t expec=
ted) "tpm_resp->len =3D %u,
 tpm_util_get_buffer_size_hdr_len2(uint32_t len, size_t expected) "tpm2_r=
esp->hdr.len =3D %u, expected =3D %zu"
 tpm_util_get_buffer_size_len2(uint32_t len, size_t expected) "tpm2_resp-=
>len =3D %u, expected =3D %zu"
 tpm_util_get_buffer_size(size_t len) "buffersize of device: %zu"
+tpm_util_show_buffer(const char *direction, size_t len, const char *buf)=
 "direction: %s len: %zu\n%s"
=20
 # tpm_emulator.c
 tpm_emulator_set_locality(uint8_t locty) "setting locality to %d"
@@ -36,7 +37,6 @@ tpm_emulator_pre_save(void) ""
 tpm_emulator_inst_init(void) ""
=20
 # tpm_tis.c
-tpm_tis_show_buffer(const char *direction, size_t len, const char *buf) =
"direction: %s len: %zu\nbuf: %s"
 tpm_tis_raise_irq(uint32_t irqmask) "Raising IRQ for flag 0x%08x"
 tpm_tis_new_active_locality(uint8_t locty) "Active locality is now %d"
 tpm_tis_abort(uint8_t locty) "New active locality is %d"
--=20
2.24.1


