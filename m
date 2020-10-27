Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605AFC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A130321655
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A130321655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXMvl-0006sX-B7
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYP-0000Dd-B3; Tue, 27 Oct 2020 06:50:13 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYK-000292-PN; Tue, 27 Oct 2020 06:50:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 500B65C016D;
 Tue, 27 Oct 2020 06:49:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 /QP/rpLJnd6J9z2j1DYNuXqlCPKYvrOlcIuuus2iAlg=; b=udPKXNumfsuDDiax
 H5xXdLQgL6rVqdvZIWmaoOJJPEfxH2K+9bzV9Xaf/lEE13iETjGUoo42d8lIKzs5
 pJkmHHw3bx3OvN2dj54Nn2gDCa+AKRRxr74YqOuMIDwb55e6fXFkyanzE1RcRpw8
 ek2VmWr2Qjt1erJ02EzOpoAE+eFIbLsYgCVfcZox2wdxZwCbvP1jWkAVX50DFlxM
 BZuPcW47pg/EyrbNIC5PqtMrA/OVMwyP+rVxABybS3XRTkNJkwRzTDvzvocnTOQs
 6Svfgy2V2IGtlzovEMoajP8M+7jw8G7hIJdSyqeMnmys61fqnDHT1YlQ+YuXn+KY
 Jpcieg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=/QP/rpLJnd6J9z2j1DYNuXqlCPKYvrOlcIuuus2iA
 lg=; b=bPSBh1RwoLdFpK1a/ZdEdBe0GZtjjA7Ho34jJjPpJODcuGaLS1X3y5gbY
 0pfGVL8F3Hj5AZ5bTxze0NPnrQZaoOyWF2p0vXLKAL7DD9m1upZTv0yN0gF/kYQW
 OhHbqmmE/aONKtfU0DD4aKlS9gi2NcEX5XSeWeD/evfGjhaEcUibML0G1S95Hsdg
 3BR3zMOXz2AOujmAlsWSDV+TSy3Ji5Cx16Ps/gTo56ccG46VYFvRqjKrTXvSbv2m
 P2Ir5SDLuaelVNBNu5RsFXE8jcuJbIoW8loq/xO4o5bkNI5R0pXj8TjpSp7q9tfe
 7tuA7h/hq0z9AxypAPokP7qT70wGA==
X-ME-Sender: <xms:SvuXX6CLzvm9noVeQwpETNK7KDuTb6R7UL5B3HULDjGWUI7RK-CYGw>
 <xme:SvuXX0hP2a0ibiYThsdaMRuP6fEHLfG25evP1Pcr8l7NY9Qa59rEZTk2eGTB_HFpF
 NzUCoPg7gNjDtYdS3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeetveeuudegveeiheegieelueeftedvtdekteefleegheduhfejueelvdfhffdt
 geenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpeefne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:SvuXX9nJgcDlNhaxtL10uwzZv3Eh9zAyavbG7oCL8Gswwo7qJzD81w>
 <xmx:SvuXX4xTixk0CrJynHYx0zQwWKSf6dLqAhHkKAHqLgasRu0Nkw6K7Q>
 <xmx:SvuXX_QetraJWGE6jvEkwWKQc_Z9opUXc0ZWrF6IgBLiHTKqPm7IIA>
 <xmx:SvuXX9NhUsRh4R6WRNqvqOT5P8YPXe1HyqO2QjRlktidrgSnVaOvag>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2B72E328005E;
 Tue, 27 Oct 2020 06:49:45 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 10/30] hw/block/nvme: default request status to success
Date: Tue, 27 Oct 2020 11:49:12 +0100
Message-Id: <20201027104932.558087-11-its@irrelevant.dk>
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
Cc: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Make the default request status NVME_SUCCESS so only error status codes
have to be set.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 84cde40fad56..0e916d48d763 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -230,6 +230,7 @@ static void nvme_req_clear(NvmeRequest *req)
 {
     req->ns = NULL;
     memset(&req->cqe, 0x0, sizeof(req->cqe));
+    req->status = NVME_SUCCESS;
 }
 
 static void nvme_req_exit(NvmeRequest *req)
@@ -546,8 +547,6 @@ static void nvme_process_aers(void *opaque)
         result->log_page = event->result.log_page;
         g_free(event);
 
-        req->status = NVME_SUCCESS;
-
         trace_pci_nvme_aer_post_cqe(result->event_type, result->event_info,
                                     result->log_page);
 
@@ -626,7 +625,6 @@ static void nvme_rw_cb(void *opaque, int ret)
 
     if (!ret) {
         block_acct_done(stats, acct);
-        req->status = NVME_SUCCESS;
     } else {
         uint16_t status;
 
-- 
2.29.1


