Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621A3C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:46:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4265207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4265207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNQe-0001Bx-Gh
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYm-0000gN-88; Tue, 27 Oct 2020 06:50:36 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYk-0002Gb-74; Tue, 27 Oct 2020 06:50:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 0850F5C018C;
 Tue, 27 Oct 2020 06:49:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=Hg2BWcsB+uhUy
 NoC8nYzdvSMxyge01KWtWaAw8dVPoQ=; b=xklxvv2Lx6NQXtO4r47TcSP7Lo8GL
 7jL5G8UCrDl98CIpMhjfSBco5I8r6A/jY2T88liChIu7QFyemURzF0KYjfGKpbI+
 e6TBqA6TlwoV5c3kZBhyg/QdQma9eVsM5zNOMy7MbbzKnK2Z1WAf2mVDYGFhSeHY
 RBKXQ5KVjRWHO91ybitPaPxNS3aSHJRbqdT6a4sXTpjO+rRTmTyAiqa/gQ64OfTE
 8x1s6UOxIJ00PoBluxZMzCdTGxFxWlkhSotg7blPcY3iGJd39dDXDqnJWgQGRJMd
 PTPA3Uy1iOFkaP+UFb914meDojLdDSMMEuU+F8KdF4lAgX/GMATEY2S8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=Hg2BWcsB+uhUyNoC8nYzdvSMxyge01KWtWaAw8dVPoQ=; b=aR46wYVY
 ItwiVnd+DR+ObnSHkDS3/cmp8yBY83JVZn4NIOjz2a5k7pFDyg3XMwvF87pKBUvt
 HSMM/oZoPS5zX339I0Y/sMXefjm33qGQ/XOFZ9C+vawMYKHcfsRi7w+zW5MC4ztb
 1SFi2BB2CEXE5b4jrCM1NK5bYdc+JlpVWismtva1vcJcNaGsrxd/uNkBD4pKcdri
 wC/QCRQT9nz0Txx2B/LNU0tO6YWl8X+45WOmawtqMDXO+TOrgExwrr4j6+XGFdh4
 AvlKX41hK0nGkKW1zIGCpxnSxlQvtMkSn3IK3NAD0e9uyPceClHcKZQbGi3CZTuc
 2N70mN6TY9Dd7w==
X-ME-Sender: <xms:VvuXX5RvrQUgA0-COLsqdSmjdmivDOhl3hzjGAYjc52NvIScj1XxVQ>
 <xme:VvuXXyyWfbnvxyChVk4za6fXooQQETsH0RWYF2d_JzriWyDRUfkaoauvGue7UIu4Q
 rnAhWbMG7OdHypuDx8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepieenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:VvuXX-3QVF8U128u_1mBqYFksoeu_fo3ndAcekXuRqFiJSzv3gyyPw>
 <xmx:VvuXXxBPMTA_ahTRbW2ywX9i828FOMQRDbiQmC-9YLFvoAW3U4BJQw>
 <xmx:VvuXXyjOCtF4GAXMHJFTyMIx5Rh56qfJOyJEnn7zJXakYBqXy2mDKA>
 <xmx:V_uXXzsKEvvDgpn7ziK7fb_4qTEEU1m-hGEqlujMWQiBvXwQeXGeSg>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id F04403280066;
 Tue, 27 Oct 2020 06:49:57 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 21/30] hw/block/nvme: support per-namespace smart log
Date: Tue, 27 Oct 2020 11:49:23 +0100
Message-Id: <20201027104932.558087-22-its@irrelevant.dk>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201027104932.558087-1-its@irrelevant.dk>
References: <20201027104932.558087-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.26; envelope-from=its@irrelevant.dk;
 helo=out2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 06:49:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Keith Busch <kbusch@kernel.org>

Let the user specify a specific namespace if they want to get access
stats for a specific namespace.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 include/block/nvme.h |  1 +
 hw/block/nvme.c      | 63 +++++++++++++++++++++++++++-----------------
 2 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index 58647bcdad0b..868cf53f0b25 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -849,6 +849,7 @@ enum NvmeIdCtrlFrmw {
 };
 
 enum NvmeIdCtrlLpa {
+    NVME_LPA_NS_SMART = 1 << 0,
     NVME_LPA_EXTENDED = 1 << 2,
 };
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index aa725d1141b2..5a9ae699afab 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1164,48 +1164,63 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeRequest *req)
     return NVME_SUCCESS;
 }
 
+struct nvme_stats {
+    uint64_t units_read;
+    uint64_t units_written;
+    uint64_t read_commands;
+    uint64_t write_commands;
+};
+
+static void nvme_set_blk_stats(NvmeNamespace *ns, struct nvme_stats *stats)
+{
+    BlockAcctStats *s = blk_get_stats(ns->blkconf.blk);
+
+    stats->units_read += s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS;
+    stats->units_written += s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_BITS;
+    stats->read_commands += s->nr_ops[BLOCK_ACCT_READ];
+    stats->write_commands += s->nr_ops[BLOCK_ACCT_WRITE];
+}
+
 static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
                                 uint64_t off, NvmeRequest *req)
 {
     uint32_t nsid = le32_to_cpu(req->cmd.nsid);
-
+    struct nvme_stats stats = { 0 };
+    NvmeSmartLog smart = { 0 };
     uint32_t trans_len;
+    NvmeNamespace *ns;
     time_t current_ms;
-    uint64_t units_read = 0, units_written = 0;
-    uint64_t read_commands = 0, write_commands = 0;
-    NvmeSmartLog smart;
-
-    if (nsid && nsid != 0xffffffff) {
-        return NVME_INVALID_FIELD | NVME_DNR;
-    }
 
     if (off >= sizeof(smart)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    for (int i = 1; i <= n->num_namespaces; i++) {
-        NvmeNamespace *ns = nvme_ns(n, i);
+    if (nsid != 0xffffffff) {
+        ns = nvme_ns(n, nsid);
         if (!ns) {
-            continue;
+            return NVME_INVALID_NSID | NVME_DNR;
         }
+        nvme_set_blk_stats(ns, &stats);
+    } else {
+        int i;
 
-        BlockAcctStats *s = blk_get_stats(ns->blkconf.blk);
-
-        units_read += s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS;
-        units_written += s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_BITS;
-        read_commands += s->nr_ops[BLOCK_ACCT_READ];
-        write_commands += s->nr_ops[BLOCK_ACCT_WRITE];
+        for (i = 1; i <= n->num_namespaces; i++) {
+            ns = nvme_ns(n, i);
+            if (!ns) {
+                continue;
+            }
+            nvme_set_blk_stats(ns, &stats);
+        }
     }
 
     trans_len = MIN(sizeof(smart) - off, buf_len);
 
-    memset(&smart, 0x0, sizeof(smart));
-
-    smart.data_units_read[0] = cpu_to_le64(DIV_ROUND_UP(units_read, 1000));
-    smart.data_units_written[0] = cpu_to_le64(DIV_ROUND_UP(units_written,
+    smart.data_units_read[0] = cpu_to_le64(DIV_ROUND_UP(stats.units_read,
+                                                        1000));
+    smart.data_units_written[0] = cpu_to_le64(DIV_ROUND_UP(stats.units_written,
                                                            1000));
-    smart.host_read_commands[0] = cpu_to_le64(read_commands);
-    smart.host_write_commands[0] = cpu_to_le64(write_commands);
+    smart.host_read_commands[0] = cpu_to_le64(stats.read_commands);
+    smart.host_write_commands[0] = cpu_to_le64(stats.write_commands);
 
     smart.temperature = cpu_to_le16(n->temperature);
 
@@ -2703,7 +2718,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->acl = 3;
     id->aerl = n->params.aerl;
     id->frmw = (NVME_NUM_FW_SLOTS << 1) | NVME_FRMW_SLOT1_RO;
-    id->lpa = NVME_LPA_EXTENDED;
+    id->lpa = NVME_LPA_NS_SMART | NVME_LPA_EXTENDED;
 
     /* recommended default value (~70 C) */
     id->wctemp = cpu_to_le16(NVME_TEMPERATURE_WARNING);
-- 
2.29.1


