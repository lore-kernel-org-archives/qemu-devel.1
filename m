Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C0AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0352168B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J5xilHuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0352168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfrk-0004X6-Qw
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfhd-0003bS-KE; Wed, 17 Jun 2020 17:34:37 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfhb-0005Dr-6a; Wed, 17 Jun 2020 17:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592429674; x=1623965674;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TP+9GhGC6V6UFGFXIelPM1rn6ry/YJFB4JIxShesYoU=;
 b=J5xilHuK4Xa9GshogIYdN3eKBuqLoSPPNaRxZXPjk7kemrldNuPSGO+I
 NnsjHpcbqsEAIyN8Oo2bUUsrcjqWo3phEMvtIv0DHa8uNQteqSBEy+6cE
 TuD7cYVuc27cQ4xLVvXTeyFDiFVYy/dc4ADwqHYSOWZlccXsAv9AYtkOL
 MIAkuUu1V60VN2c5O+2NC5wczydU8KxjfRc4FU5z07aR0VbyQLB/trp8z
 YN1cYxiV8//mmPeT9bFN3lILjijS+v62dmUZwVnu45pUBpjxzLwp0gYGQ
 BH0KPgq0kNDvUvMBWx8VHm6+gLxOx/Qo1lqR+GkdRipOLTNNMVvXpHhhO A==;
IronPort-SDR: SiUu3anDmdA9i+gWIdXzQBPpu9MnHba6kZuWixSWlUNPxn5CegNUbNkcD/0duRwtXbiaE+ZhcQ
 Ul6xOSUxpdpmU3dfGIAKiyg9Rs1CLwKYfMAtQuobkfBhYDb09Ys7qRQ59a0Ts2RwD51mVLkh6y
 iRrlO5zurqo1CNpRM4j2EZ6IA7euesVza7c+LbPQGs1PiU/5/hfjN49ALRB/XOuMEYOECwMtbN
 AWMGh4a6j0z92TP1XckwbcKeDHAzrsc3a4DjX3lEFoDIsmQIZBSC8jCbnkRj56jeKhdj3UW2c0
 d/w=
X-IronPort-AV: E=Sophos;i="5.73,523,1583164800"; d="scan'208";a="249439789"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 05:34:31 +0800
IronPort-SDR: Uj8dOHpAczLcaCzxqw5+YJNuDL+cJHDAL+tJsFGZ7TZApaInAxCkjtNgu2BhzsMPJn900UkCYW
 7QAFmkt1xXCDhMRr88cxtj/QBayDo/2t8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 14:23:12 -0700
IronPort-SDR: h00Lh9Ktzk6vEIDdrED3Zl3dCtUJB1Xf2OJVU0xaRcnHowMxE6Kpa0xww+y4IZ4b5Mk3CrrNqP
 PVYGpqpsGkWQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2020 14:34:30 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>
Subject: [PATCH v2 02/18] hw/block/nvme: Define 64 bit cqe.result
Date: Thu, 18 Jun 2020 06:33:59 +0900
Message-Id: <20200617213415.22417-3-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=430b82a1d=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 17:34:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
---
 block/nvme.c         | 2 +-
 block/trace-events   | 2 +-
 hw/block/nvme.c      | 6 +++---
 include/block/nvme.h | 6 ++++--
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index eb2f54dd9d..ca245ec574 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -287,7 +287,7 @@ static inline int nvme_translate_error(const NvmeCqe *c)
 {
     uint16_t status = (le16_to_cpu(c->status) >> 1) & 0xFF;
     if (status) {
-        trace_nvme_error(le32_to_cpu(c->result),
+        trace_nvme_error(le64_to_cpu(c->result64),
                          le16_to_cpu(c->sq_head),
                          le16_to_cpu(c->sq_id),
                          le16_to_cpu(c->cid),
diff --git a/block/trace-events b/block/trace-events
index 29dff8881c..05c1393943 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -156,7 +156,7 @@ vxhs_get_creds(const char *cacert, const char *client_key, const char *client_ce
 # nvme.c
 nvme_kick(void *s, int queue) "s %p queue %d"
 nvme_dma_flush_queue_wait(void *s) "s %p"
-nvme_error(int cmd_specific, int sq_head, int sqid, int cid, int status) "cmd_specific %d sq_head %d sqid %d cid %d status 0x%x"
+nvme_error(uint64_t cmd_specific, int sq_head, int sqid, int cid, int status) "cmd_specific %ld sq_head %d sqid %d cid %d status 0x%x"
 nvme_process_completion(void *s, int index, int inflight) "s %p queue %d inflight %d"
 nvme_process_completion_queue_busy(void *s, int index) "s %p queue %d"
 nvme_complete_command(void *s, int index, int cid) "s %p queue %d cid %d"
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 3ed9f3d321..a1bbc9acde 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -823,7 +823,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    req->cqe.result = result;
+    req->cqe.result32 = result;
     return NVME_SUCCESS;
 }
 
@@ -859,8 +859,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
                                     ((dw11 >> 16) & 0xFFFF) + 1,
                                     n->params.max_ioqpairs,
                                     n->params.max_ioqpairs);
-        req->cqe.result = cpu_to_le32((n->params.max_ioqpairs - 1) |
-                                      ((n->params.max_ioqpairs - 1) << 16));
+        req->cqe.result32 = cpu_to_le32((n->params.max_ioqpairs - 1) |
+                                        ((n->params.max_ioqpairs - 1) << 16));
         break;
     case NVME_TIMESTAMP:
         return nvme_set_feature_timestamp(n, cmd);
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 1720ee1d51..9c3a04dcd7 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -577,8 +577,10 @@ typedef struct NvmeAerResult {
 } NvmeAerResult;
 
 typedef struct NvmeCqe {
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


