Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F5EC43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 22:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78FD21548
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 22:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fiCqsurV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78FD21548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHaII-00026g-Sr
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 18:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=518fa018e=dmitry.fomichev@wdc.com>)
 id 1kHaGr-000853-IA; Sun, 13 Sep 2020 18:14:53 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42010)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=518fa018e=dmitry.fomichev@wdc.com>)
 id 1kHaGo-00019U-N0; Sun, 13 Sep 2020 18:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600035290; x=1631571290;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KgbQNch+4cFx3msApzBbuLL93ECkVe6TluohZCU2jzA=;
 b=fiCqsurV3bj5tDYm2aXwfPOEUKrlsL6x1j0zfTqKGfd56G1hQ9bz3kzJ
 CMyQ+W3LPCjTjOckyORLdzP6DzQfiPiLw1QrCYhGsk+qGtbVo+vZMVZzf
 AcjbGTTyrM5LubMOWmDAr9SVmTSfs7sufdFZColCZXggvebx0wHq3Za0c
 siFJuE6QhhpcvWbNePyVtP05ryEOtOwvMqms2+2ombuRwAFltKozfkJpB
 UkGN+ec/zWxRlxnn1JfEm4AxE4wUkEY5h0ajb/gJKx6yvFaSJvgp06gAc
 bvCDt47YgpuZo/rYpXW77syYUMqbWwdkjZ1qNlVTg7KSqP+81BBT8EsHp g==;
IronPort-SDR: os6hMQ6UyfGNsR8e1T3GkCJMFz/4GQS5s0GBEegjQFK+vW0Cel6r997dt7bI+TT/1IRLniu3+/
 Pr9fjn1hFLDLVHR6TR3ARaC4nA0Y4UnJhVhl6EMoL+sy9vwU9N2jvc5IrDlabAMb9WW1JAqqc9
 a4Q0VFXLijgFSVWQTxpZ83DS7NZePHkjiyd5YfJSZcT+CGiie9RKpdjvDsvTkFVv3QOD8F9E48
 eGGxV4QNE2xSqAaxkYU5UHQVBJhbbMrp7sfboWZVHmSVSq0bHb/1gTf9YLjcc5Lp/QeT/lVQx0
 W+g=
X-IronPort-AV: E=Sophos;i="5.76,423,1592841600"; d="scan'208";a="147179044"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2020 06:14:45 +0800
IronPort-SDR: 2dlmScg6GYYjOAOsaDVhZUKfGd1BWkNLAqZHM0K0R17BEHGOU0hIn/Chg15cRJRtd/0qJNoiKx
 YmrgSrKA4QAQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2020 15:01:58 -0700
IronPort-SDR: 5x8PjSba3rVMs101g8miLShPdJMtDYQiLCNT4mvohFLMDc7U9WcYxfvBVqD+u0aOMxMhvIE83v
 S3yjpFLp/oYw==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Sep 2020 15:14:45 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v3 01/15] hw/block/nvme: Define 64 bit cqe.result
Date: Mon, 14 Sep 2020 07:14:22 +0900
Message-Id: <20200913221436.22844-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=518fa018e=dmitry.fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 18:14:44
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ajay Joshi <ajay.joshi@wdc.com>

A new write command, Zone Append, is added as a part of Zoned
Namespace Command Set. Upon successful completion of this command,
the controller returns the start LBA of the performed write operation
in cqe.result field. Therefore, the maximum size of this variable
needs to be changed from 32 to 64 bit, consuming the reserved 32 bit
field that follows the result in CQE struct. Since the existing
commands are expected to return a 32 bit LE value, two separate
variables, result32 and result64, are now kept in a union.

Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
---
 block/nvme.c         |  2 +-
 block/trace-events   |  2 +-
 hw/block/nvme.c      | 10 +++++-----
 include/block/nvme.h |  6 ++++--
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 05485fdd11..45e1a5dcd1 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -333,7 +333,7 @@ static inline int nvme_translate_error(const NvmeCqe *c)
 {
     uint16_t status = (le16_to_cpu(c->status) >> 1) & 0xFF;
     if (status) {
-        trace_nvme_error(le32_to_cpu(c->result),
+        trace_nvme_error(le64_to_cpu(c->result64),
                          le16_to_cpu(c->sq_head),
                          le16_to_cpu(c->sq_id),
                          le16_to_cpu(c->cid),
diff --git a/block/trace-events b/block/trace-events
index e1c79a910d..55c54a18c3 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -139,7 +139,7 @@ qed_aio_write_main(void *s, void *acb, int ret, uint64_t offset, size_t len) "s
 # nvme.c
 nvme_kick(void *s, int queue) "s %p queue %d"
 nvme_dma_flush_queue_wait(void *s) "s %p"
-nvme_error(int cmd_specific, int sq_head, int sqid, int cid, int status) "cmd_specific %d sq_head %d sqid %d cid %d status 0x%x"
+nvme_error(uint64_t cmd_specific, int sq_head, int sqid, int cid, int status) "cmd_specific %ld sq_head %d sqid %d cid %d status 0x%x"
 nvme_process_completion(void *s, int index, int inflight) "s %p queue %d inflight %d"
 nvme_process_completion_queue_plugged(void *s, int index) "s %p queue %d"
 nvme_complete_command(void *s, int index, int cid) "s %p queue %d cid %d"
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 63078f6009..3a90d80694 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -524,7 +524,7 @@ static void nvme_process_aers(void *opaque)
 
         req = n->aer_reqs[n->outstanding_aers];
 
-        result = (NvmeAerResult *) &req->cqe.result;
+        result = (NvmeAerResult *) &req->cqe.result32;
         result->event_type = event->result.event_type;
         result->event_info = event->result.event_info;
         result->log_page = event->result.log_page;
@@ -1247,7 +1247,7 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest *req)
 {
     uint16_t sqid = le32_to_cpu(req->cmd.cdw10) & 0xffff;
 
-    req->cqe.result = 1;
+    req->cqe.result32 = 1;
     if (nvme_check_sqid(n, sqid)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
@@ -1425,7 +1425,7 @@ defaults:
     }
 
 out:
-    req->cqe.result = cpu_to_le32(result);
+    req->cqe.result32 = cpu_to_le32(result);
     return NVME_SUCCESS;
 }
 
@@ -1534,8 +1534,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
                                     ((dw11 >> 16) & 0xFFFF) + 1,
                                     n->params.max_ioqpairs,
                                     n->params.max_ioqpairs);
-        req->cqe.result = cpu_to_le32((n->params.max_ioqpairs - 1) |
-                                      ((n->params.max_ioqpairs - 1) << 16));
+        req->cqe.result32 = cpu_to_le32((n->params.max_ioqpairs - 1) |
+                                        ((n->params.max_ioqpairs - 1) << 16));
         break;
     case NVME_ASYNCHRONOUS_EVENT_CONF:
         n->features.async_config = dw11;
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 65e68a82c8..ac0ccfcb26 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -617,8 +617,10 @@ typedef struct QEMU_PACKED NvmeAerResult {
 } NvmeAerResult;
 
 typedef struct QEMU_PACKED NvmeCqe {
-    uint32_t    result;
-    uint32_t    rsvd;
+    union {
+        uint64_t     result64;
+        uint32_t     result32;
+    };
     uint16_t    sq_head;
     uint16_t    sq_id;
     uint16_t    cid;
-- 
2.21.0


