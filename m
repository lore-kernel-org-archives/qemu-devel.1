Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEF9C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73BAA218DA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BAA218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqbSv-0003vv-Ez
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41589)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1hqbSd-00030W-Lx
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1hqbSb-0007Jp-QI
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:58:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19404
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1hqbSa-0007DC-Oo
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:58:57 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6PAvLvZ041689
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 06:58:49 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ty9g8vcwd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 06:58:48 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6PAvVlQ042158
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 06:58:48 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ty9g8vcvy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jul 2019 06:58:48 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6PAt8cr014236;
 Thu, 25 Jul 2019 10:58:47 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma01dal.us.ibm.com with ESMTP id 2tx61ndxk7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jul 2019 10:58:47 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6PAwjwX57147802
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jul 2019 10:58:45 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE9966A047;
 Thu, 25 Jul 2019 10:58:45 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F47E6A051;
 Thu, 25 Jul 2019 10:58:45 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jul 2019 10:58:45 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Jul 2019 06:58:42 -0400
Message-Id: <20190725105842.872625-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725105842.872625-1-stefanb@linux.vnet.ibm.com>
References: <20190725105842.872625-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-25_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907250132
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 2/2] tpm_emulator: Translate TPM error codes to
 strings
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
Cc: Stefan Berger <stefanb@linux.ibm.com>, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement a function to translate TPM error codes to strings so that
at least the most common error codes can be translated to human
readable strings.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_emulator.c | 50 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 1288cbcb8d..186dde0838 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -82,6 +82,30 @@ typedef struct TPMEmulator {
     TPMBlobBuffers state_blobs;
 } TPMEmulator;
 
+struct tpm_error {
+    uint32_t tpm_result;
+    const char *string;
+};
+
+static const struct tpm_error tpm_errors[] = {
+    {  9 , "operation failed" },
+    {  32, "encryption error" },
+    {  33, "decryption error" },
+    /* TPM 2 codes */
+    { 0x101, "operation failed" },
+};
+
+static const char *tpm_emulator_strerror(uint32_t tpm_result)
+{
+    size_t i;
+
+    for (i = 0; i < ARRAY_SIZE(tpm_errors); i++) {
+        if (tpm_errors[i].tpm_result == tpm_result) {
+            return tpm_errors[i].string;
+        }
+    }
+    return "";
+}
 
 static int tpm_emulator_ctrlcmd(TPMEmulator *tpm, unsigned long cmd, void *msg,
                                 size_t msg_len_in, size_t msg_len_out)
@@ -264,7 +288,8 @@ static int tpm_emulator_stop_tpm(TPMBackend *tb)
 
     res = be32_to_cpu(res);
     if (res) {
-        error_report("tpm-emulator: TPM result for CMD_STOP: 0x%x", res);
+        error_report("tpm-emulator: TPM result for CMD_STOP: 0x%x %s", res,
+                     tpm_emulator_strerror(res));
         return -1;
     }
 
@@ -293,8 +318,9 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
 
     psbs.u.resp.tpm_result = be32_to_cpu(psbs.u.resp.tpm_result);
     if (psbs.u.resp.tpm_result != 0) {
-        error_report("tpm-emulator: TPM result for set buffer size : 0x%x",
-                     psbs.u.resp.tpm_result);
+        error_report("tpm-emulator: TPM result for set buffer size : 0x%x %s",
+                     psbs.u.resp.tpm_result,
+                     tpm_emulator_strerror(psbs.u.resp.tpm_result));
         return -1;
     }
 
@@ -339,7 +365,8 @@ static int tpm_emulator_startup_tpm_resume(TPMBackend *tb, size_t buffersize,
 
     res = be32_to_cpu(init.u.resp.tpm_result);
     if (res) {
-        error_report("tpm-emulator: TPM result for CMD_INIT: 0x%x", res);
+        error_report("tpm-emulator: TPM result for CMD_INIT: 0x%x %s", res,
+                     tpm_emulator_strerror(res));
         goto err_exit;
     }
     return 0;
@@ -399,8 +426,9 @@ static int tpm_emulator_reset_tpm_established_flag(TPMBackend *tb,
 
     res = be32_to_cpu(reset_est.u.resp.tpm_result);
     if (res) {
-        error_report("tpm-emulator: TPM result for rest establixhed flag: 0x%x",
-                     res);
+        error_report(
+            "tpm-emulator: TPM result for rest establixhed flag: 0x%x %s",
+            res, tpm_emulator_strerror(res));
         return -1;
     }
 
@@ -638,7 +666,8 @@ static int tpm_emulator_get_state_blob(TPMEmulator *tpm_emu,
     res = be32_to_cpu(pgs.u.resp.tpm_result);
     if (res != 0 && (res & 0x800) == 0) {
         error_report("tpm-emulator: Getting the stateblob (type %d) failed "
-                     "with a TPM error 0x%x", type, res);
+                     "with a TPM error 0x%x %s", type, res,
+                     tpm_emulator_strerror(res));
         return -1;
     }
 
@@ -758,7 +787,8 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
     tpm_result = be32_to_cpu(pss.u.resp.tpm_result);
     if (tpm_result != 0) {
         error_report("tpm-emulator: Setting the stateblob (type %d) failed "
-                     "with a TPM error 0x%x", type, tpm_result);
+                     "with a TPM error 0x%x %s", type, tpm_result,
+                     tpm_emulator_strerror(tpm_result));
         return -1;
     }
 
@@ -888,8 +918,8 @@ static void tpm_emulator_shutdown(TPMEmulator *tpm_emu)
         error_report("tpm-emulator: Could not cleanly shutdown the TPM: %s",
                      strerror(errno));
     } else if (res != 0) {
-        error_report("tpm-emulator: TPM result for sutdown: 0x%x",
-                     be32_to_cpu(res));
+        error_report("tpm-emulator: TPM result for shutdown: 0x%x %s",
+                     be32_to_cpu(res), tpm_emulator_strerror(be32_to_cpu(res)));
     }
 }
 
-- 
2.20.1


