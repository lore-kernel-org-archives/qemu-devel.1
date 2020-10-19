Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F01C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 06:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2151420704
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 06:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2151420704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUP91-0003n7-Ab
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 02:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUP3v-0001j5-Ij; Mon, 19 Oct 2020 02:54:31 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:34667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUP3s-000445-S6; Mon, 19 Oct 2020 02:54:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 0BBE5A57;
 Mon, 19 Oct 2020 02:54:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Mon, 19 Oct 2020 02:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=IP8peYGBr3Br/xkSXq0bO0Pvz+
 rTWZvadOVhfYbAKXc=; b=EWeu/MVQg5kPG+YO9X0fmVvvn0DAP7Wi/1F1GeX3vl
 2hoyuWy2HI2PeAM4N6bOb9Og3bcOIZNP25zjmKswZfEj32m9aPL61PxnIDNT65Ix
 Knqao/24vC5k8X+KlKyPP3vPW/ALaPXyoCw3hfEygmEff/A8AKYggni4Qw6D0zAZ
 A6q4Uasriqgiok1PHQixFDoCLPt3qM00J2Dg89wxrmkF36Zv6ZUIASU7nw61QDxt
 eF3/N7ORXhHsAp3tn7lOWiSHEgKdpr27r1Z79BWFLc8ULuKlGFUvqS0LElNsKrck
 71R61KDBwa1Zt9JrxWEwrT/36BbvpUWnczMw8c/Cg41w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=IP8peYGBr3Br/xkSX
 q0bO0Pvz+rTWZvadOVhfYbAKXc=; b=c4aN0K/sS4DYH4EfhYIExcq8Q81WQTQo1
 Es6ClgUsSH9e4whwm0dYNQzH3PzpafvZJyfsAMjRcuXO0RscY0FQc81HfC50vn5R
 xmxscCzb+RH2a2asDfdAPH/5fEljaoncLCrYw4Dh8PdCen6kqkVjLikggmd8qLTf
 WTI6xwCJSt7hNtudDQ8KtF8oLUDdByo31ruVEdsuDeclMiFT2CQ7CkqfrqmJTAtn
 GVHfJapEJsf0TU8JELb8CSD2BBm31exRSeJQOULl7vjdDO4ccW2x6F0eOUNYpgen
 SGTuywWBhg8nHe+L4ZTryI+JLiOVHclQ290w2CywY/7cW2F8AUJlg==
X-ME-Sender: <xms:HDiNX8YeCd3gr7Kjkm3rmJOCH1BWHWqpzgOtzO4y5iJDE8KWWVJM7g>
 <xme:HDiNX3YaBqnF2zO5UpDaWCEoOaKqp3nyeoQnXpn4LNSJROVUJLMgBxEC5m1pcmr52
 s4mC6B3AC7VIrg-REk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjedtgdduuddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpeefveelvdeikeduueffteeggeefhedvffffjeeuueeludehvdegjeevjefhtdetheen
 ucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:HDiNX2-ghyMk95M5WCUoY5S-A433qxdbc-wDZNBtCVw622I5_j57HA>
 <xmx:HDiNX2p1Gmghnu-Gjnf95y7n36Wg6_HvBn0SWgltHn4QOENuMDGjJg>
 <xmx:HDiNX3r-vH6ZiP323QJJDQOwyU4jYUnqR6Nppmbk0q8UNiIE0lRCMg>
 <xmx:HTiNX4fBsw4ZhZzeG_tfgU6kygLX4gJ4ohoY2BT5QXesgb4Rn8ZaKiUqK2w>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id D0DD33064610;
 Mon, 19 Oct 2020 02:54:18 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/block/nvme: fix aer logic
Date: Mon, 19 Oct 2020 08:54:16 +0200
Message-Id: <20201019065416.34638-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.26; envelope-from=its@irrelevant.dk;
 helo=wnew1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:54:23
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Fix same flawed logic in the handling of event masking. Before this
patch the device would erroneously

  a) queue up events even though that event type is masked
  b) issue AERs for queued events in response to events getting cleared
  c) respond to new AERs with queued events even though the event was
     already cleared

Fix this by moving the mask check to nvme_enqueue_event() and replace
the nvme_process_aers() call with a pruning of queued events when the
event type is cleared.

Fixes: 5d5a53302b95 ("hw/block/nvme: add support for the asynchronous event request command")
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c       | 22 ++++++++++++++--------
 hw/block/trace-events |  2 +-
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9d30ca69dcf1..b18a310d9271 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -805,12 +805,6 @@ static void nvme_process_aers(void *opaque)
             break;
         }
 
-        /* ignore if masked (cqe posted, but event not cleared) */
-        if (n->aer_mask & (1 << event->result.event_type)) {
-            trace_pci_nvme_aer_masked(event->result.event_type, n->aer_mask);
-            continue;
-        }
-
         QTAILQ_REMOVE(&n->aer_queue, event, entry);
         n->aer_queued--;
 
@@ -844,6 +838,12 @@ static void nvme_enqueue_event(NvmeCtrl *n, uint8_t event_type,
         return;
     }
 
+    /* ignore if masked (cqe posted, but event not cleared) */
+    if (n->aer_mask & (1 << event_type)) {
+        trace_pci_nvme_aer_masked(event_type, n->aer_mask);
+        return;
+    }
+
     event = g_new(NvmeAsyncEvent, 1);
     event->result = (NvmeAerResult) {
         .event_type = event_type,
@@ -859,9 +859,15 @@ static void nvme_enqueue_event(NvmeCtrl *n, uint8_t event_type,
 
 static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
 {
+    NvmeAsyncEvent *event, *next;
+
     n->aer_mask &= ~(1 << event_type);
-    if (!QTAILQ_EMPTY(&n->aer_queue)) {
-        nvme_process_aers(n);
+
+    QTAILQ_FOREACH_SAFE(event, &n->aer_queue, entry, next) {
+        if (event->result.event_type == event_type) {
+            QTAILQ_REMOVE(&n->aer_queue, event, entry);
+            n->aer_queued--;
+        }
     }
 }
 
diff --git a/hw/block/trace-events b/hw/block/trace-events
index cab9913b1f2d..11bad6ae6a11 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -67,7 +67,7 @@ pci_nvme_aer_post_cqe(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRI
 pci_nvme_enqueue_event(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
 pci_nvme_enqueue_event_noqueue(int queued) "queued %d"
 pci_nvme_enqueue_event_masked(uint8_t typ) "type 0x%"PRIx8""
-pci_nvme_no_outstanding_aers(void) "ignoring event; no outstanding AERs"
+pci_nvme_no_outstanding_aers(void) "no outstanding aers"
 pci_nvme_enqueue_req_completion(uint16_t cid, uint16_t cqid, uint16_t status) "cid %"PRIu16" cqid %"PRIu16" status 0x%"PRIx16""
 pci_nvme_mmio_read(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_mmio_write(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PRIx64""
-- 
2.28.0


