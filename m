Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046BDC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7D4F20675
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D4F20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icvTW-0000UI-CT
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 13:03:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icvDQ-0007oo-7V
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:47:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icvDO-00047z-Ln
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:46:59 -0500
Received: from relay.sw.ru ([185.231.240.75]:48356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icvDO-0003Va-Ci
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:46:58 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1icvD8-00013M-Dr; Thu, 05 Dec 2019 20:46:42 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 16/21] hw/tpm: rename Error ** parameter to more common errp
Date: Thu,  5 Dec 2019 20:46:30 +0300
Message-Id: <20191205174635.18758-17-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191205174635.18758-1-vsementsov@virtuozzo.com>
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: vsementsov@virtuozzo.com, armbru@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_emulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 22f9113432..10d587ed40 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -155,7 +155,7 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
                                      const uint8_t *in, uint32_t in_len,
                                      uint8_t *out, uint32_t out_len,
                                      bool *selftest_done,
-                                     Error **err)
+                                     Error **errp)
 {
     ssize_t ret;
     bool is_selftest = false;
@@ -165,20 +165,20 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
         is_selftest = tpm_util_is_selftest(in, in_len);
     }
 
-    ret = qio_channel_write_all(tpm_emu->data_ioc, (char *)in, in_len, err);
+    ret = qio_channel_write_all(tpm_emu->data_ioc, (char *)in, in_len, errp);
     if (ret != 0) {
         return -1;
     }
 
     ret = qio_channel_read_all(tpm_emu->data_ioc, (char *)out,
-              sizeof(struct tpm_resp_hdr), err);
+              sizeof(struct tpm_resp_hdr), errp);
     if (ret != 0) {
         return -1;
     }
 
     ret = qio_channel_read_all(tpm_emu->data_ioc,
               (char *)out + sizeof(struct tpm_resp_hdr),
-              tpm_cmd_get_size(out) - sizeof(struct tpm_resp_hdr), err);
+              tpm_cmd_get_size(out) - sizeof(struct tpm_resp_hdr), errp);
     if (ret != 0) {
         return -1;
     }
-- 
2.21.0


