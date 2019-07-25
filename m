Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD24FC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B3822BED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B3822BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfz8-0001Ai-DZ
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52664)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1hqfyY-0008Uv-PU
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1hqfyX-0001n4-GQ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:48:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1hqfyX-0001mV-7l
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:48:13 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6PFlDvF078820
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 11:48:12 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tycsgr7jh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 11:48:12 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
 Thu, 25 Jul 2019 16:48:10 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 25 Jul 2019 16:48:08 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6PFm8vv54264102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jul 2019 15:48:08 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED669AE097;
 Thu, 25 Jul 2019 15:48:07 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5C6FAE099;
 Thu, 25 Jul 2019 15:48:07 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jul 2019 15:48:07 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Jul 2019 11:48:06 -0400
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725154806.1193357-1-stefanb@linux.vnet.ibm.com>
References: <20190725154806.1193357-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19072515-2213-0000-0000-000003B6B1E2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011491; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01237291; UDB=6.00652199; IPR=6.01018665; 
 MB=3.00027887; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-25 15:48:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072515-2214-0000-0000-00005F63B377
Message-Id: <20190725154806.1193357-3-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-25_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907250185
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x6PFlDvF078820
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PULL v1 2/2] tpm_emulator: Translate TPM error codes
 to strings
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
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement a function to translate TPM error codes to strings so that
at least the most common error codes can be translated to human
readable strings.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_emulator.c | 60 +++++++++++++++++++++++++++++++++++--------
 hw/tpm/tpm_int.h      | 13 ++++++++++
 2 files changed, 63 insertions(+), 10 deletions(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 1288cbcb8d..fc0b512f4f 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -82,6 +82,40 @@ typedef struct TPMEmulator {
     TPMBlobBuffers state_blobs;
 } TPMEmulator;
=20
+struct tpm_error {
+    uint32_t tpm_result;
+    const char *string;
+};
+
+static const struct tpm_error tpm_errors[] =3D {
+    /* TPM 1.2 error codes */
+    { TPM_BAD_PARAMETER   , "a parameter is bad" },
+    { TPM_FAIL            , "operation failed" },
+    { TPM_KEYNOTFOUND     , "key could not be found" },
+    { TPM_BAD_PARAM_SIZE  , "bad parameter size"},
+    { TPM_ENCRYPT_ERROR   , "encryption error" },
+    { TPM_DECRYPT_ERROR   , "decryption error" },
+    { TPM_BAD_KEY_PROPERTY, "bad key property" },
+    { TPM_BAD_MODE        , "bad (encryption) mode" },
+    { TPM_BAD_VERSION     , "bad version identifier" },
+    { TPM_BAD_LOCALITY    , "bad locality" },
+    /* TPM 2 error codes */
+    { TPM_RC_FAILURE     , "operation failed" },
+    { TPM_RC_LOCALITY    , "bad locality"     },
+    { TPM_RC_INSUFFICIENT, "insufficient amount of data" },
+};
+
+static const char *tpm_emulator_strerror(uint32_t tpm_result)
+{
+    size_t i;
+
+    for (i =3D 0; i < ARRAY_SIZE(tpm_errors); i++) {
+        if (tpm_errors[i].tpm_result =3D=3D tpm_result) {
+            return tpm_errors[i].string;
+        }
+    }
+    return "";
+}
=20
 static int tpm_emulator_ctrlcmd(TPMEmulator *tpm, unsigned long cmd, voi=
d *msg,
                                 size_t msg_len_in, size_t msg_len_out)
@@ -264,7 +298,8 @@ static int tpm_emulator_stop_tpm(TPMBackend *tb)
=20
     res =3D be32_to_cpu(res);
     if (res) {
-        error_report("tpm-emulator: TPM result for CMD_STOP: 0x%x", res)=
;
+        error_report("tpm-emulator: TPM result for CMD_STOP: 0x%x %s", r=
es,
+                     tpm_emulator_strerror(res));
         return -1;
     }
=20
@@ -293,8 +328,9 @@ static int tpm_emulator_set_buffer_size(TPMBackend *t=
b,
=20
     psbs.u.resp.tpm_result =3D be32_to_cpu(psbs.u.resp.tpm_result);
     if (psbs.u.resp.tpm_result !=3D 0) {
-        error_report("tpm-emulator: TPM result for set buffer size : 0x%=
x",
-                     psbs.u.resp.tpm_result);
+        error_report("tpm-emulator: TPM result for set buffer size : 0x%=
x %s",
+                     psbs.u.resp.tpm_result,
+                     tpm_emulator_strerror(psbs.u.resp.tpm_result));
         return -1;
     }
=20
@@ -339,7 +375,8 @@ static int tpm_emulator_startup_tpm_resume(TPMBackend=
 *tb, size_t buffersize,
=20
     res =3D be32_to_cpu(init.u.resp.tpm_result);
     if (res) {
-        error_report("tpm-emulator: TPM result for CMD_INIT: 0x%x", res)=
;
+        error_report("tpm-emulator: TPM result for CMD_INIT: 0x%x %s", r=
es,
+                     tpm_emulator_strerror(res));
         goto err_exit;
     }
     return 0;
@@ -399,8 +436,9 @@ static int tpm_emulator_reset_tpm_established_flag(TP=
MBackend *tb,
=20
     res =3D be32_to_cpu(reset_est.u.resp.tpm_result);
     if (res) {
-        error_report("tpm-emulator: TPM result for rest establixhed flag=
: 0x%x",
-                     res);
+        error_report(
+            "tpm-emulator: TPM result for rest established flag: 0x%x %s=
",
+            res, tpm_emulator_strerror(res));
         return -1;
     }
=20
@@ -638,7 +676,8 @@ static int tpm_emulator_get_state_blob(TPMEmulator *t=
pm_emu,
     res =3D be32_to_cpu(pgs.u.resp.tpm_result);
     if (res !=3D 0 && (res & 0x800) =3D=3D 0) {
         error_report("tpm-emulator: Getting the stateblob (type %d) fail=
ed "
-                     "with a TPM error 0x%x", type, res);
+                     "with a TPM error 0x%x %s", type, res,
+                     tpm_emulator_strerror(res));
         return -1;
     }
=20
@@ -758,7 +797,8 @@ static int tpm_emulator_set_state_blob(TPMEmulator *t=
pm_emu,
     tpm_result =3D be32_to_cpu(pss.u.resp.tpm_result);
     if (tpm_result !=3D 0) {
         error_report("tpm-emulator: Setting the stateblob (type %d) fail=
ed "
-                     "with a TPM error 0x%x", type, tpm_result);
+                     "with a TPM error 0x%x %s", type, tpm_result,
+                     tpm_emulator_strerror(tpm_result));
         return -1;
     }
=20
@@ -888,8 +928,8 @@ static void tpm_emulator_shutdown(TPMEmulator *tpm_em=
u)
         error_report("tpm-emulator: Could not cleanly shutdown the TPM: =
%s",
                      strerror(errno));
     } else if (res !=3D 0) {
-        error_report("tpm-emulator: TPM result for sutdown: 0x%x",
-                     be32_to_cpu(res));
+        error_report("tpm-emulator: TPM result for shutdown: 0x%x %s",
+                     be32_to_cpu(res), tpm_emulator_strerror(be32_to_cpu=
(res)));
     }
 }
=20
diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
index a4c77fbd7e..3fb28a9d6c 100644
--- a/hw/tpm/tpm_int.h
+++ b/hw/tpm/tpm_int.h
@@ -39,7 +39,16 @@ struct tpm_resp_hdr {
 #define TPM_TAG_RSP_AUTH1_COMMAND 0xc5
 #define TPM_TAG_RSP_AUTH2_COMMAND 0xc6
=20
+#define TPM_BAD_PARAMETER         3
 #define TPM_FAIL                  9
+#define TPM_KEYNOTFOUND           13
+#define TPM_BAD_PARAM_SIZE        25
+#define TPM_ENCRYPT_ERROR         32
+#define TPM_DECRYPT_ERROR         33
+#define TPM_BAD_KEY_PROPERTY      40
+#define TPM_BAD_MODE              44
+#define TPM_BAD_VERSION           46
+#define TPM_BAD_LOCALITY          61
=20
 #define TPM_ORD_ContinueSelfTest  0x53
 #define TPM_ORD_GetTicks          0xf1
@@ -59,4 +68,8 @@ struct tpm_resp_hdr {
=20
 #define TPM2_PT_MAX_COMMAND_SIZE  0x11e
=20
+#define TPM_RC_INSUFFICIENT       0x9a
+#define TPM_RC_FAILURE            0x101
+#define TPM_RC_LOCALITY           0x907
+
 #endif /* TPM_TPM_INT_H */
--=20
2.20.1


