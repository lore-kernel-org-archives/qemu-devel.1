Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBE8C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:50:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 825CB207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825CB207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNUe-0004GS-An
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYq-0000kz-DS; Tue, 27 Oct 2020 06:50:40 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59067)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYo-0002Id-Bp; Tue, 27 Oct 2020 06:50:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 505C85C0193;
 Tue, 27 Oct 2020 06:50:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 WNLNg12g5/IfDUpfOYoxicB4wDKV6e3FwTaeuo1rUc0=; b=vZ1jmMQETUo8vOW6
 Lag7XQnFTIPJFhM5lQhBtv/AuXe2cGkIJdSg0UDGKQZwrzj7yXTodTkhmk9sy8o2
 AonQOEIIIrRi2h/qWCuEmWYL7RYjw6MRnkfRGIDXsFoCb6EgKx0R8n2ne19bq3aw
 AGdEATTy6k1QVajtn9HdTjlZVw7gIQczSnLTUY3c4DxPw8GpoA5HvT+2ONNK22zw
 N3BZmOPXcw2Sztg2WYDalU5JMlRRW1kdjL4iwi4Pwd4dHOTrO/WAgqedBm+2UM8Y
 QiQyY/7ab2x1W6h54p+EMMuCLskhpUpwRVHBrlIesCc/hGcCLFB6sDGAH3HHwqlV
 NS1jcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=WNLNg12g5/IfDUpfOYoxicB4wDKV6e3FwTaeuo1rU
 c0=; b=QgD1KqfIWs1nWg/4GZwwC815Hzr9u0mRvEUJkuRdVaHNI35FtQe62UEQw
 v6eC46MQ1inX1+2p7f1xm9zvnEilwEAn96HhaV+P32InN7XswgLrwslttPs0Mzz2
 +XAqzFXcrvMKjy2w7rqL4dMzekEgtZBcTfQZUfO6tl+c151w7i9yqkxpwde1ff7j
 ++OZXMt8y75OIf5PgYYgccmlRQweTtMpO4l8rZNfPOINkB87j6tdvPJLGywIi0z2
 /WkUVJqLyX16MIpXDID49nZ8NycaprA3cyLF6X4ueAY6sSJVFmDPYzw6DBzwzlrl
 QCiS+haovCgL4kCQA2hF2IIk5Q79Q==
X-ME-Sender: <xms:XfuXXyoWEaAdW5WGWiefk1XzEHEqbzSxY7lmkJ9crGGmHQdcMnyFAw>
 <xme:XfuXXwpI3qMolpcVzzp77M2IiFoTdei6TXF7VeV80sya73vDgF2HYjoZulJj8RASP
 eo_w5fARUOlWxtQOnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeetveeuudegveeiheegieelueeftedvtdekteefleegheduhfejueelvdfhffdt
 geenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpeejne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:XfuXX3MA9oaMQlhMeRETz-TEbDPFbMJIz0lydatPP0Bbt6UhmtDiiQ>
 <xmx:XfuXXx7vDOTPuMgiIFzEVFspEhGKw3I3yJEPoOzbeK10gqrgxD7b3A>
 <xmx:XfuXXx6IQmii35Q3hfk9icwSRouJVbNPyDt4P5GMkJXQr7g2GeEPHQ>
 <xmx:XfuXX_SV6QCf0KxTCIxtWj2WQ8vtEtCg1NNOkjx9oGW3LB9KJCJHhQ>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 0B3DC3280066;
 Tue, 27 Oct 2020 06:50:03 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 26/30] hw/block/nvme: add trace event for requests with
 non-zero status code
Date: Tue, 27 Oct 2020 11:49:28 +0100
Message-Id: <20201027104932.558087-27-its@irrelevant.dk>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201027104932.558087-1-its@irrelevant.dk>
References: <20201027104932.558087-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: qemu-block@nongnu.org, Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

If a command results in a non-zero status code, trace it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c       | 6 ++++++
 hw/block/trace-events | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 5fd5a45a281a..b8c6be63186f 100644
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
index 2dc85281dc33..cab9913b1f2d 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -88,6 +88,7 @@ pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
 
 # nvme traces for error conditions
 pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
+pci_nvme_err_req_status(uint16_t cid, uint32_t nsid, uint16_t status, uint8_t opc) "cid %"PRIu16" nsid %"PRIu32" status 0x%"PRIx16" opc 0x%"PRIx8""
 pci_nvme_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_err_cfs(void) "controller fatal status"
-- 
2.29.1


