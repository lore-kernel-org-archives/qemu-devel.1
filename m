Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1407C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF19206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF19206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifTWs-0006uc-Cd
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:49:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1ifStJ-00086c-Bl
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1ifStI-0006Pd-7Y
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:08:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28352
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1ifStI-0006Ob-2H; Thu, 12 Dec 2019 13:08:44 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBCHrDGq050715; Thu, 12 Dec 2019 13:08:28 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wu4t7fd99-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 13:08:28 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBCHsK71083008;
 Thu, 12 Dec 2019 13:08:27 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wu4t7fd92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 13:08:27 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBCI5qCY021746;
 Thu, 12 Dec 2019 18:08:27 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma02wdc.us.ibm.com with ESMTP id 2wr3q703kq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 18:08:27 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBCI8Q2t16122714
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2019 18:08:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C58AFB2064;
 Thu, 12 Dec 2019 18:08:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B816EB2068;
 Thu, 12 Dec 2019 18:08:26 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 12 Dec 2019 18:08:26 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v4 3/8] tpm_emulator: Implement callback for whether we are
 suspended
Date: Thu, 12 Dec 2019 13:07:39 -0500
Message-Id: <20191212180744.1070446-4-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191212180744.1070446-1-stefanb@linux.vnet.ibm.com>
References: <20191212180744.1070446-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_05:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=1
 mlxscore=0 mlxlogscore=998 malwarescore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120140
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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

Implement the check whether the emulator backend is suspended.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 22f9113432..7be7d3a91b 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -80,6 +80,8 @@ typedef struct TPMEmulator {
     unsigned int established_flag_cached:1;
 
     TPMBlobBuffers state_blobs;
+
+    bool is_suspended;
 } TPMEmulator;
 
 struct tpm_error {
@@ -486,6 +488,13 @@ static size_t tpm_emulator_get_buffer_size(TPMBackend *tb)
     return actual_size;
 }
 
+static bool tpm_emulator_is_suspended(TPMBackend *tb)
+{
+    TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
+
+    return tpm_emu->is_suspended;
+}
+
 static int tpm_emulator_block_migration(TPMEmulator *tpm_emu)
 {
     Error *err = NULL;
@@ -846,6 +855,8 @@ static int tpm_emulator_pre_save(void *opaque)
     TPMBackend *tb = opaque;
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
 
+    tpm_emu->is_suspended = true;
+
     trace_tpm_emulator_pre_save();
 
     tpm_backend_finish_sync(tb);
@@ -975,6 +986,7 @@ static void tpm_emulator_class_init(ObjectClass *klass, void *data)
     tbc->get_tpm_version = tpm_emulator_get_tpm_version;
     tbc->get_buffer_size = tpm_emulator_get_buffer_size;
     tbc->get_tpm_options = tpm_emulator_get_tpm_options;
+    tbc->is_suspended = tpm_emulator_is_suspended;
 
     tbc->handle_request = tpm_emulator_handle_request;
 }
-- 
2.21.0


