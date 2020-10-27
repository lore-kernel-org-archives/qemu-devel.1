Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8515CC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B212072D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B212072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNAE-0007qN-NZ
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYr-0000nU-VJ; Tue, 27 Oct 2020 06:50:41 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42901)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYo-0002JC-Do; Tue, 27 Oct 2020 06:50:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id BD8EC5C018F;
 Tue, 27 Oct 2020 06:50:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=3MlYZR1KynDql
 LPoJYqiCp2jjx7BDi4GUHQLWpIxQ7s=; b=InlQLpLqukejEltiKOGE5uHjUMD5H
 /VEKRyEfcRCi7VoBusuP2B/HvLz6fANErReCJWkYfgCxSu1CfRbFexwKclfPNcTw
 5ncCSr4ZmQl4aQpb2OtHMy5fVF55tpXwMgVDuxZP4RvJCwvRmimpohc6O3+76tkg
 dLDLMKxKxfpLCV1cvGFBIdwd2mAtpAxs0XOL16lqrNr7mxqHY6iU+G3UwpRG1p9I
 /kQTQ0gpo0JdSvqNf37CtDzYaJ2iOiQVozQMdMvCpjz1n6beehOEVU//YppnLabs
 8PLEAp544WA1CKfyPJAuJvCjx05NibkVlzDT3Oa9JHiFYelEATV8kcBPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=3MlYZR1KynDqlLPoJYqiCp2jjx7BDi4GUHQLWpIxQ7s=; b=qOjWEmD7
 IQGhFm7epchyThjMs5alHDdC1nyK6Gn9y/DavnfZNKBi5feqo8SVG4BZ1oVmGi0z
 jCGtNG2ekpkGC1MX14WHWfq7AE2hm/rIYQs/n+DlamYJS48dBVRNaAlHYYY+v9DE
 8dVRcWX0yNZgI4vzGOT7EA0HfAlAQUyCA/ZZBOY9p/NDeuu2GFS8sEJ504P8nPqe
 EqvmGw5aVc+A5Mvpf8o2DXJXezy/zqK/Jr2ncrzAaoKinCxSJOW2ipZ0VmI9Xb3U
 pu0A1W8H/e3z4NGeYucuqDPAkxpn6W1ZUeSuk9Wn11hgHdfg9dpSoMEZsjwAneVh
 fP4D3eTMCa3rnw==
X-ME-Sender: <xms:YPuXX2yf8MVEgcWuL0AwcdpXYuame7Tpt0tlh7KrLJjTMfbtImbzJQ>
 <xme:YPuXXyQFNV6WH9Q4Rm6Mi9mB5Xl-YIpk_4xxdFUK3wj5oe0OK7Tboz3V9wmwn9hov
 x2M6HVQmAd-YI5TYgk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepudegne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:YPuXX4XgwasKXCZyTwKfGXXQTUmRiGDiw02KKcehOZ81yPvQHNA_Jg>
 <xmx:YPuXX8iCw-ZzgutiMPxTFPfrxqz4dqjU7E0KlViEZDEjd2CHYCfOjw>
 <xmx:YPuXX4AjYiXo-y2zgAqGPaSKh_FRE2oTNXflBrMG12Pw9sbUfPb10Q>
 <xmx:YPuXX794onPj7uwKcag0pXH7yb7w39-A1bSW1BfIvchcQg0EpBBfnA>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id AA6813280060;
 Tue, 27 Oct 2020 06:50:07 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 29/30] hw/block/nvme: fix create IO SQ/CQ status codes
Date: Tue, 27 Oct 2020 11:49:31 +0100
Message-Id: <20201027104932.558087-30-its@irrelevant.dk>
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
 Gollu Appalanaidu <anaidu.gollu@samsung.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gollu Appalanaidu <anaidu.gollu@samsung.com>

Replace the Invalid Field in Command with the Invalid PRP Offset status
code in the nvme_create_{cq,sq} functions. Also, allow PRP1 to be
address 0x0.

Also replace the Completion Queue Invalid status code returned in
nvme_create_cq when the the queue identifier is invalid with the Invalid
Queue Identifier. The Completion Queue Invalid status code is
exclusively for indicating that the completion queue identifer given
when creating a submission queue is invalid.

See NVM Express v1.3d, Section 5.3 ("Create I/O Completion Queue
command") and 5.4("Create I/O Submission Queue command").

Signed-off-by: Gollu Appalanaidu <anaidu.gollu@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 2896bb49b9c0..5dfef0204c2c 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1151,9 +1151,9 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeRequest *req)
         trace_pci_nvme_err_invalid_create_sq_size(qsize);
         return NVME_MAX_QSIZE_EXCEEDED | NVME_DNR;
     }
-    if (unlikely(!prp1 || prp1 & (n->page_size - 1))) {
+    if (unlikely(prp1 & (n->page_size - 1))) {
         trace_pci_nvme_err_invalid_create_sq_addr(prp1);
-        return NVME_INVALID_FIELD | NVME_DNR;
+        return NVME_INVALID_PRP_OFFSET | NVME_DNR;
     }
     if (unlikely(!(NVME_SQ_FLAGS_PC(qflags)))) {
         trace_pci_nvme_err_invalid_create_sq_qflags(NVME_SQ_FLAGS_PC(qflags));
@@ -1400,15 +1400,15 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
 
     if (unlikely(!cqid || !nvme_check_cqid(n, cqid))) {
         trace_pci_nvme_err_invalid_create_cq_cqid(cqid);
-        return NVME_INVALID_CQID | NVME_DNR;
+        return NVME_INVALID_QID | NVME_DNR;
     }
     if (unlikely(!qsize || qsize > NVME_CAP_MQES(n->bar.cap))) {
         trace_pci_nvme_err_invalid_create_cq_size(qsize);
         return NVME_MAX_QSIZE_EXCEEDED | NVME_DNR;
     }
-    if (unlikely(!prp1)) {
+    if (unlikely(prp1 & (n->page_size - 1))) {
         trace_pci_nvme_err_invalid_create_cq_addr(prp1);
-        return NVME_INVALID_FIELD | NVME_DNR;
+        return NVME_INVALID_PRP_OFFSET | NVME_DNR;
     }
     if (unlikely(!msix_enabled(&n->parent_obj) && vector)) {
         trace_pci_nvme_err_invalid_create_cq_vector(vector);
-- 
2.29.1


