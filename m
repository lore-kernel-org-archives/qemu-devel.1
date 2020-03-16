Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963CEC18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68EE62051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68EE62051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDt7b-0004qg-MS
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDqkt-0000Bd-9v
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDqkr-0002bR-7s
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:30:11 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48600)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDqkn-0007tV-Gx; Mon, 16 Mar 2020 10:30:05 -0400
Received: from apples.local (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id 352A1BF6A1;
 Mon, 16 Mar 2020 14:29:44 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v6 17/42] nvme: add log specific field to trace events
Date: Mon, 16 Mar 2020 07:29:03 -0700
Message-Id: <20200316142928.153431-18-its@irrelevant.dk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316142928.153431-1-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

The LSP field is not used directly now, but include it in the trace.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c       | 3 ++-
 hw/block/trace-events | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index e56142c4ea99..16de3ca1c5d5 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -760,6 +760,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cm=
d, NvmeRequest *req)
     uint32_t dw12 =3D le32_to_cpu(cmd->cdw12);
     uint32_t dw13 =3D le32_to_cpu(cmd->cdw13);
     uint8_t  lid =3D dw10 & 0xff;
+    uint8_t  lsp =3D (dw10 >> 8) & 0xf;
     uint8_t  rae =3D (dw10 >> 15) & 0x1;
     uint32_t numdl, numdu;
     uint64_t off, lpol, lpou;
@@ -777,7 +778,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cm=
d, NvmeRequest *req)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
=20
-    trace_nvme_dev_get_log(nvme_cid(req), lid, rae, len, off);
+    trace_nvme_dev_get_log(nvme_cid(req), lid, lsp, rae, len, off);
=20
     switch (lid) {
     case NVME_LOG_ERROR_INFO:
diff --git a/hw/block/trace-events b/hw/block/trace-events
index dde1d22bc39a..13e2c71664f6 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -48,7 +48,7 @@ nvme_dev_getfeat_numq(int result) "get feature number o=
f queues, result=3D%d"
 nvme_dev_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "reque=
sted cq_count=3D%d sq_count=3D%d, responding with cq_count=3D%d sq_count=3D=
%d"
 nvme_dev_setfeat_timestamp(uint64_t ts) "set feature timestamp =3D 0x%"P=
RIx64""
 nvme_dev_getfeat_timestamp(uint64_t ts) "get feature timestamp =3D 0x%"P=
RIx64""
-nvme_dev_get_log(uint16_t cid, uint8_t lid, uint8_t rae, uint32_t len, u=
int64_t off) "cid %"PRIu16" lid 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" o=
ff %"PRIu64""
+nvme_dev_get_log(uint16_t cid, uint8_t lid, uint8_t lsp, uint8_t rae, ui=
nt32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx8" lsp 0x%"PRIx8" ra=
e 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
 nvme_dev_process_aers(int queued) "queued %d"
 nvme_dev_aer(uint16_t cid) "cid %"PRIu16""
 nvme_dev_aer_aerl_exceeded(void) "aerl exceeded"
--=20
2.25.1


