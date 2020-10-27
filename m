Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A90AC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F4162224E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4162224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXMhw-0005kd-2O
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMXw-0008OS-9u; Tue, 27 Oct 2020 06:49:44 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMXs-000255-CC; Tue, 27 Oct 2020 06:49:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 7675B5C0118;
 Tue, 27 Oct 2020 06:49:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=9IJGrrFUppsYM
 TOomjRTCN6FsfBvTziyt/MhJK4JHfQ=; b=rJFbKwcJiDInRUUxhEhwQmWu5VrvC
 WFt8RMG+MU7xHN8yBl5hBCDjRzO9oRWloUTSa/pSX9Ll7WBCchyd3y4KGzGC7CNk
 joTlYwgOjas5q3t2jWnUnsPzOi+3IQ3dVyNy4OcWX0jrq1CDqIyEe1l2mR/Z0u8K
 0R4AIKkC7vNcYn4lk2EcKgSnjZvq4GmNbPBJw0BPliSfkk4r2kTvNk63c1ePbA/2
 xPE3akMp5JLssMT/qeBkhMPZYrfUjUnn//CPiBGqHFWM9RM2iicgroDt1BOj1sHi
 ynfzymtofTrgRg7p5bbkSO6hj7YXPpElX3WcsUbgA4VmAPb5taI+A8RHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=9IJGrrFUppsYMTOomjRTCN6FsfBvTziyt/MhJK4JHfQ=; b=jqeUU0J2
 nquyV+QvFuPiSt5tymM6vRdSFKzQQHuFu94QB9knXCGlWYeqYweaIHyQEAZ/q+5m
 K8eo+TznbVy48IBVMd3u6w0G1uDWjs5Fp1VMEHtRo3apVxHy/Og0QCsvxrNRB00T
 zfwBHEPe5SZzUmu+cXTcirisLSW+DyL67iDj+vPXLZZtsLBHZnabeptcReV+kLAI
 2USt+0fECZvZnCbKl0zfw1nIOmJK+qv8tVEEkdSjmqQTCyNr4dpmL3Zn0pbjcWID
 ZOcxEWSd8bDIZiCTnhGw/8PeXvMgFjFWLmY8iSzjfW3ASZZr/pBtoRAf7eSO6XbV
 otON2HxPJwCFBA==
X-ME-Sender: <xms:Q_uXX7ENl558j76mfTvgov7LzKWyyloh50BBszr4-mfW02WjKalVHA>
 <xme:Q_uXX4X2v6G01yF3MFs4D7K_5GsEgodieOA_IrrKO2NsMIH48aFZIrsxDPcHVOogC
 R2KEIajN_Op-2FROOU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:Q_uXX9LMM-Ys-ESj4zTSsTfQGFFaPJORY4E1pei7u_RgavGTu3u9kA>
 <xmx:Q_uXX5FNjsDqJlu7gnLTEnemk3iCjh4u314CR7r3m-ANu6AvCqfQeg>
 <xmx:Q_uXXxURN1LIl8g2yyFU2c1or4FR7cnYiDDaE0OVbB7tgVRHwHno2A>
 <xmx:Q_uXX0TLhuk4AMQsFc4n67l4oNZVpcb_-iLN6YY5x5AZooLIkl2nbA>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6AED5328005E;
 Tue, 27 Oct 2020 06:49:38 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 04/30] hw/block/nvme: commonize nvme_rw error handling
Date: Tue, 27 Oct 2020 11:49:06 +0100
Message-Id: <20201027104932.558087-5-its@irrelevant.dk>
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

From: Klaus Jensen <k.jensen@samsung.com>

Move common error handling to a label.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 7d328c08b894..0ac9d856632e 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -687,20 +687,18 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
     status = nvme_check_mdts(n, data_size);
     if (status) {
         trace_pci_nvme_err_mdts(nvme_cid(req), data_size);
-        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
-        return status;
+        goto invalid;
     }
 
     status = nvme_check_bounds(n, ns, slba, nlb);
     if (status) {
         trace_pci_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
-        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
-        return status;
+        goto invalid;
     }
 
-    if (nvme_map_dptr(n, data_size, req)) {
-        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
-        return NVME_INVALID_FIELD | NVME_DNR;
+    status = nvme_map_dptr(n, data_size, req);
+    if (status) {
+        goto invalid;
     }
 
     if (req->qsg.nsg > 0) {
@@ -722,6 +720,10 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
     }
 
     return NVME_NO_COMPLETE;
+
+invalid:
+    block_acct_invalid(blk_get_stats(n->conf.blk), acct);
+    return status;
 }
 
 static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
-- 
2.29.1


