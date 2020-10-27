Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6595C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A6922263
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A6922263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNHr-0004Gl-Gv
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYo-0000ib-AB; Tue, 27 Oct 2020 06:50:38 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYk-0002Gc-7t; Tue, 27 Oct 2020 06:50:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id ED54B5C018E;
 Tue, 27 Oct 2020 06:49:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 HcV5uo7S2D06lJn9dLCcjXK1Q9lRgxa3Gzu1P85A6S4=; b=qW3bGPSzkrg8efVl
 tJa13yC7Rl6gAwxNwzHMOtHAT63ctAPhEyAzP522qKFTrap6zvoZ84Vn99tc+zlI
 cDT6ENaoNWrGmKQTBFkXji6k8nE5dwBJ7QbZheAyKdfgwJd3A5pvnYb0NeqKhkGg
 DhwRPAARCKywBahD7AezrdwAPNdrsCbnlMhz8J2/aeip8teVaeHIb1T0J2aQKZ5n
 etDoEcpJAKKvrLdu5yNPEmwhkuXWZLlfl7jnvI2vBbDhfTlxY56kOqVR+EqOtN3r
 fXkZHsJ66ums46i/B9uAquGTq1QmjgzuPBi91851yJe2ARpjQgc+NKpjP5FgPB5b
 T4RdaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=HcV5uo7S2D06lJn9dLCcjXK1Q9lRgxa3Gzu1P85A6
 S4=; b=G0EbNeW4eFKebAPi0ORC6/Uq0oozaVInFyUGwPX5x0jj6LNheTw2fo/gg
 shgsaG/AYAABXpZbqNTIbTSvivHkkxO5xu3YGVbJ9ljhR3BIQ3jVoJxd706szfvQ
 IJJPzMnzkQhLwggGcMvjyhCYJFmJb4K6C0qzqfXn7tWIowD1EKLZ6vjtSNNUvHe4
 5JhKhKbIHVveXOfZmt2d5bAdFtRvblJmcpqagWEwORn6orJJ6PjVE2fuKnQmA6Ha
 Bdq8cPVJeRVVwOgoaINgiGSpWleE8+RUBtCqHvPo5czppBGkdaXqHASg5nv+r0m9
 Fff7h/2bpE5lkxRT4vskvFhC1+kWg==
X-ME-Sender: <xms:VfuXX9J4GTabDV7iB2vbpaTJiKgRgHj9P7dzHXs6HKpN222Usd-_Rg>
 <xme:VfuXX5I587DOyByaqiy2xkOZUpfq1KCixqvFKjRQeOzuZUgeI52DHPUVOMOJW3BWr
 7WMbM123_I4ALLkMPc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeetveeuudegveeiheegieelueeftedvtdekteefleegheduhfejueelvdfhffdt
 geenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpeeine
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:VfuXX1sHQYMN0fSBHgL-bhEzTydOI2WMDvPeDS7cMZM9s2jFWzCELQ>
 <xmx:VfuXX-ZPE0a3Zwbbv1rHxruFMo8t19ZaiXkJK5AIUPNZXx-LiZqiRQ>
 <xmx:VfuXX0ZtTYgJ4McB3tsGustNqUz4s4xONrXsbKMQLnkmU4wAZbfQzA>
 <xmx:VfuXX7XHVlFLxPaBSovW8xs1Gfhyv0PwL6w6ffrn7o5R5I_9QBhsmA>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id C64CA3280064;
 Tue, 27 Oct 2020 06:49:56 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 20/30] hw/block/nvme: fix log page offset check
Date: Tue, 27 Oct 2020 11:49:22 +0100
Message-Id: <20201027104932.558087-21-its@irrelevant.dk>
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

From: Keith Busch <kbusch@kernel.org>

Return error if the requested offset starts after the size of the log
being returned. Also, move the check for earlier in the function so
we're not doing unnecessary calculations.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed- by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index a168f0bf4adb..aa725d1141b2 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1179,6 +1179,10 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
+    if (off >= sizeof(smart)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
     for (int i = 1; i <= n->num_namespaces; i++) {
         NvmeNamespace *ns = nvme_ns(n, i);
         if (!ns) {
@@ -1193,10 +1197,6 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
         write_commands += s->nr_ops[BLOCK_ACCT_WRITE];
     }
 
-    if (off > sizeof(smart)) {
-        return NVME_INVALID_FIELD | NVME_DNR;
-    }
-
     trans_len = MIN(sizeof(smart) - off, buf_len);
 
     memset(&smart, 0x0, sizeof(smart));
@@ -1234,12 +1234,11 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, uint32_t buf_len, uint64_t off,
         .afi = 0x1,
     };
 
-    strpadcpy((char *)&fw_log.frs1, sizeof(fw_log.frs1), "1.0", ' ');
-
-    if (off > sizeof(fw_log)) {
+    if (off >= sizeof(fw_log)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
+    strpadcpy((char *)&fw_log.frs1, sizeof(fw_log.frs1), "1.0", ' ');
     trans_len = MIN(sizeof(fw_log) - off, buf_len);
 
     return nvme_dma(n, (uint8_t *) &fw_log + off, trans_len,
@@ -1252,16 +1251,15 @@ static uint16_t nvme_error_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
     uint32_t trans_len;
     NvmeErrorLog errlog;
 
+    if (off >= sizeof(errlog)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
     if (!rae) {
         nvme_clear_events(n, NVME_AER_TYPE_ERROR);
     }
 
-    if (off > sizeof(errlog)) {
-        return NVME_INVALID_FIELD | NVME_DNR;
-    }
-
     memset(&errlog, 0x0, sizeof(errlog));
-
     trans_len = MIN(sizeof(errlog) - off, buf_len);
 
     return nvme_dma(n, (uint8_t *)&errlog, trans_len,
-- 
2.29.1


