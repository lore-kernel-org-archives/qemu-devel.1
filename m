Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051D0C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 806C020773
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806C020773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNOyB-0002kn-2Y
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 19:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOu8-0000Uz-Mq; Tue, 29 Sep 2020 19:19:28 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:41609)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOu5-00007t-DD; Tue, 29 Sep 2020 19:19:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 57583E99;
 Tue, 29 Sep 2020 19:19:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 29 Sep 2020 19:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=+Fjf+ehIwJaI4
 71JRdnpqYu38GUIs8qKDBklTJPNZG4=; b=omkeBvp/cU8wrl9DoIYYWeRPxt3gL
 5au+33JV72ekcm295rgS16ZUhUyJvD13ImDvayHoWrPSYy0zAhIup4oc8Ir9fU4b
 dfEpQCTp9X1MvwFV/B30CKrYnxzRRN5Jxwg3nnTAydwDKCMrBMP7vxWhq2hmfhTp
 AoOAlgeKcwJa32LEnqlmDkUf9K16iAldeAwM0d94ppVlv4o4ibUOhMfVbuyBt8ju
 pgkW3sd7OaXiKVkQndbAAo0kkZowqZOla/yaSwDBvK6VjCIy2FPfgA+01MwgypIy
 tguwAOGxG9bMCgoTrdUFf+LkEZTn7gKwU/tru+bs7gJmssh4kcwQvMlyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=+Fjf+ehIwJaI471JRdnpqYu38GUIs8qKDBklTJPNZG4=; b=C+CTvKso
 ZixaoPz1LdsD2w4B5Cdw5qjpusxQmxd7dVW8ivY8HNFAHP8YPW4z2HIsN9FDr/Vp
 lc+KFZ8wDUi9YAaLAaYCkEnuwaqUOUq8it7vUAE9wORNUKpk2BntNLA+i/peZtg5
 IWujGTGH3uNz/Mxk+e6Ggu/PbeG976Bxx4NBev/0wS/uvt5kxJR9vpD2CDVaVgor
 WWg4NGI4AduJD8LBzsdbCbdMPSNE7Cua1JL6FGrRYo+baUvkxUK5g1JW5LQh5u3O
 ATX0U3DSM1MvYXOgMRtd/i6rtLQOYppssjP2ALFwmykWnvpJ/mSblhhRs0+X1HSY
 uW4c3o9nraPcOA==
X-ME-Sender: <xms:-sBzXy-M1VbKnakKzPLgLaYTSCd8MIF5BciTBNQiBIGOgmfJNnn0Bw>
 <xme:-sBzXysGKRoVYuZcc4QQSjIGSx_g02W8ruqAyZBZuOqgNLLAMogNlNU5aOgkMXa1i
 tqTAmYaKHFo9uHTXVU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedtgddujecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:-sBzX4CaBvA4K_pctzs8dDosG37zh1EtXTh6n6sGN4TlaBAd_2CySA>
 <xmx:-sBzX6c0gtTA5ux6zVbd_Zh65UCFaqW9K6FbsYFjBHEMnPLtmxabBA>
 <xmx:-sBzX3M59g6eBMmzY5t2y1e6sZgOm71khj849PPe5CAa8XlCWWKNZQ>
 <xmx:-sBzXy01030Uvk9Or3Xsuod9nJF5BMQKhKJmoSFkM2Lp6OQ865lHQH6gDXQ>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id A66563280066;
 Tue, 29 Sep 2020 19:19:21 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/14] hw/block/nvme: add trace event for requests with
 non-zero status code
Date: Wed, 30 Sep 2020 01:19:05 +0200
Message-Id: <20200929231917.433586-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929231917.433586-1-its@irrelevant.dk>
References: <20200929231917.433586-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.27; envelope-from=its@irrelevant.dk;
 helo=wnew2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 17:46:07
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
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


