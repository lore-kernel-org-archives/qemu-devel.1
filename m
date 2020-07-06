Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CF9C433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 22:14:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57695206E9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 22:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57695206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsZO0-0002a3-LA
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 18:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jsZMs-0001JS-9x; Mon, 06 Jul 2020 18:13:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22528)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jsZMp-0000s6-SC; Mon, 06 Jul 2020 18:13:42 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 066M23RD050939; Mon, 6 Jul 2020 18:13:33 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 324bfg9n6k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2020 18:13:32 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 066M2pT3054667;
 Mon, 6 Jul 2020 18:13:32 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 324bfg9n6h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2020 18:13:32 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 066MAMtT003549;
 Mon, 6 Jul 2020 22:13:32 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma01wdc.us.ibm.com with ESMTP id 322hd8ax44-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2020 22:13:31 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 066MDU8D59834744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2020 22:13:31 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE0AA7807C;
 Mon,  6 Jul 2020 22:13:30 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34C727806E;
 Mon,  6 Jul 2020 22:13:30 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2020 22:13:30 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org, marcandre.lureau@redhat.com
Subject: [PATCH 2/2] tests: Skip over first 14 bytes when comparing TPM
 PCRRead result
Date: Mon,  6 Jul 2020 18:13:27 -0400
Message-Id: <20200706221327.3914491-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200706221327.3914491-1-stefanb@linux.vnet.ibm.com>
References: <20200706221327.3914491-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-06_20:2020-07-06,
 2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 cotscore=-2147483648 suspectscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007060146
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=stefanb@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 18:13:38
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Due to a change in the TPM 2 code the pcrUpdate counter in the
PCRRead response is now different. The easiest way is to skip over
the first 14 bytes and only compare the tail of the response.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/qtest/tpm-tests.c | 6 +++---
 tests/qtest/tpm-util.c  | 6 ++++--
 tests/qtest/tpm-util.h  | 3 ++-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
index a2f2838e15..8f6491a4b7 100644
--- a/tests/qtest/tpm-tests.c
+++ b/tests/qtest/tpm-tests.c
@@ -65,7 +65,7 @@ void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx,
         "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x89"
         "\xa4\x2f\x9a\xae\xa8\xc7\xb7\xaa\x79\xa8\x62\x56\xc1\xde";
     tpm_util_pcrread(s, tx, tpm_pcrread_resp,
-                     sizeof(tpm_pcrread_resp));
+                     sizeof(tpm_pcrread_resp), 14);
 
     qtest_end();
     tpm_util_swtpm_kill(swtpm_pid);
@@ -113,13 +113,13 @@ void tpm_test_swtpm_migration_test(const char *src_tpm_path,
         "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x89"
         "\xa4\x2f\x9a\xae\xa8\xc7\xb7\xaa\x79\xa8\x62\x56\xc1\xde";
     tpm_util_pcrread(src_qemu, tx, tpm_pcrread_resp,
-                     sizeof(tpm_pcrread_resp));
+                     sizeof(tpm_pcrread_resp), 14);
 
     tpm_util_migrate(src_qemu, uri);
     tpm_util_wait_for_migration_complete(src_qemu);
 
     tpm_util_pcrread(dst_qemu, tx, tpm_pcrread_resp,
-                     sizeof(tpm_pcrread_resp));
+                     sizeof(tpm_pcrread_resp), 14);
 
     qtest_quit(dst_qemu);
     qtest_quit(src_qemu);
diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
index 34efae8f18..df85e23432 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -130,7 +130,8 @@ void tpm_util_pcrextend(QTestState *s, tx_func *tx)
 }
 
 void tpm_util_pcrread(QTestState *s, tx_func *tx,
-                      const unsigned char *exp_resp, size_t exp_resp_size)
+                      const unsigned char *exp_resp, size_t exp_resp_size,
+                      off_t offset)
 {
     unsigned char buffer[1024];
     unsigned char tpm_pcrread[] =
@@ -139,7 +140,8 @@ void tpm_util_pcrread(QTestState *s, tx_func *tx,
 
     tx(s, tpm_pcrread, sizeof(tpm_pcrread), buffer, sizeof(buffer));
 
-    g_assert_cmpmem(buffer, exp_resp_size, exp_resp, exp_resp_size);
+    g_assert_cmpmem(&buffer[offset], exp_resp_size - offset,
+                    &exp_resp[offset], exp_resp_size - offset);
 }
 
 bool tpm_util_swtpm_has_tpm2(void)
diff --git a/tests/qtest/tpm-util.h b/tests/qtest/tpm-util.h
index 3b97d69017..d6f4c17218 100644
--- a/tests/qtest/tpm-util.h
+++ b/tests/qtest/tpm-util.h
@@ -34,7 +34,8 @@ void tpm_util_tis_transfer(QTestState *s,
 void tpm_util_startup(QTestState *s, tx_func *tx);
 void tpm_util_pcrextend(QTestState *s, tx_func *tx);
 void tpm_util_pcrread(QTestState *s, tx_func *tx,
-                      const unsigned char *exp_resp, size_t exp_resp_size);
+                      const unsigned char *exp_resp, size_t exp_resp_size,
+                      off_t offset);
 
 bool tpm_util_swtpm_has_tpm2(void);
 
-- 
2.24.1


