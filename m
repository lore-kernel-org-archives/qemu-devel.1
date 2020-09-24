Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538E0C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C4C221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C4C221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLYBm-00071m-BB
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 16:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7L-0004Oq-IN; Thu, 24 Sep 2020 16:45:27 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:50925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7J-0007gQ-BE; Thu, 24 Sep 2020 16:45:27 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 9BC2A580508;
 Thu, 24 Sep 2020 16:45:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 24 Sep 2020 16:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=+Fjf+ehIwJaI4
 71JRdnpqYu38GUIs8qKDBklTJPNZG4=; b=jLQ/bx+UwCp7D9LOj9aglUzUOBwzU
 y7HWrxuNtQQmgyTN6/dcr3BV7KvMX609hjJgHlrdIit/AnPP6YKph0M9RLe69b95
 6QIu1TFcTuV1I1x1c0OS8sef05mCjxuQJlyRe1flbW5a3nqa3LkjSf90LAqT8r1H
 KURNFI5zRZ3zn9qj50VEpGyjgNtW8F53JqhArzgwVNQJ8VDyEWNqKGmafViteIDx
 TtY9idC9wMrwkS1DPWDKmkLxpeM/2GivFHWfyOLsx2yt4AgCaD/dG++Bvj8ZZKpi
 IVF/h2nCGTOo9hCbu+BgqWWFZSHq6RM1d4boJ5epqTJdDkyq2vbXYTNMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=+Fjf+ehIwJaI471JRdnpqYu38GUIs8qKDBklTJPNZG4=; b=kYceSFdx
 N6MbqYb73Pmh34uO/WO5cfXaV0ks9m5/ND0Lk06KR/Q01IPmsVLWoCWqXkdXMWAF
 eAapO7u2oBNRLYQo+qOY2Lrd2JjEx4Wr7+/x/udCEuKTPKmDZpM1ouovC4MfWPFm
 5IuqAKzYHFnO7mEnjWGJH+FPHl/KAAiN9iP2SfsIJCxMwIYEwEI/30Vv8LiElrWx
 gjLvjeKQHUtsgjl/aFqEUf7YB/016YWsjnMo2PqTfBYUctgmbQoSa427tc8IQ6od
 0NbulYdzvNPUCQwFWpIb1u6FJ7sNdyCgxLu8kvu69OvOmbCP3LkIMTi1DWo0EhmJ
 9DGwljEzXYDhZQ==
X-ME-Sender: <xms:YQVtX9qP8KEyOok7A8sL0Pp2atWe7wLykUSP5H-gsrCdkg4dLeWfNg>
 <xme:YQVtX_o3mQVL6lTltTaHjTx_QS-a0Rk_vFEdiRKA0PXa3Rw0YaROyjhgzZApg-wSn
 AQLNKgTzBiSj_yyv6s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdduheduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeuleetgeeiuefhgfekfefgveejiefgteekiedtgfdtieefhfdthfefueffvefg
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:YQVtX6PJX2j2Dj9kNC56D3RbpOXZrIW-AQKlAJM13CKOY4GNcDJsxA>
 <xmx:YQVtX464GAEw-FolrwiIQGlp1tB7fUt_tEzD8uQK8Y89DvbVQ2WIYw>
 <xmx:YQVtX87sgTAhDjypKPOlOurmQHjPVb3pnLQR6RZTilbSz-dOw-XTQQ>
 <xmx:YgVtX2QkVrQBcGlteVqWZZAE0rYOoW5abAcNk-8kuXYvt7C1WzIP4g>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 950F8306467D;
 Thu, 24 Sep 2020 16:45:20 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/16] hw/block/nvme: add trace event for requests with
 non-zero status code
Date: Thu, 24 Sep 2020 22:45:02 +0200
Message-Id: <20200924204516.1881843-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924204516.1881843-1-its@irrelevant.dk>
References: <20200924204516.1881843-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.224; envelope-from=its@irrelevant.dk;
 helo=new2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 14:55:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

If a command results in a non-zero status code, trace it.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c       | 6 ++++++
 hw/block/trace-events | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 84b6b516fa7b..3cbc3c7b75b1 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -777,6 +777,12 @@ static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
     assert(cq->cqid == req->sq->cqid);
     trace_pci_nvme_enqueue_req_completion(nvme_cid(req), cq->cqid,
                                           req->status);
+
+    if (req->status) {
+        trace_pci_nvme_err_req_status(nvme_cid(req), nvme_nsid(req->ns),
+                                      req->status, req->cmd.opcode);
+    }
+
     QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
     QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
     timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 5a239b80bf36..9e7507c5abde 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -89,6 +89,7 @@ pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
 
 # nvme traces for error conditions
 pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
+pci_nvme_err_req_status(uint16_t cid, uint32_t nsid, uint16_t status, uint8_t opc) "cid %"PRIu16" nsid %"PRIu32" status 0x%"PRIx16" opc 0x%"PRIx8""
 pci_nvme_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_err_cfs(void) "controller fatal status"
-- 
2.28.0


