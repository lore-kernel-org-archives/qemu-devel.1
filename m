Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472D7C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B41B021741
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41B021741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJNQo-0006cf-G5
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 16:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN80-0005Ct-15; Fri, 18 Sep 2020 16:37:08 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7y-0004zZ-7l; Fri, 18 Sep 2020 16:37:07 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 1CF85580231;
 Fri, 18 Sep 2020 16:36:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 18 Sep 2020 16:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=UBQI++ulJhmJW
 +K8ao6+lIoIrU0hGd0x4qsrZp9HNlI=; b=tIeA7SBdD49SXc8OtVK9PC5BrOpEH
 38Cy2M/EDWq4uTp3Xq56qBUzPjv4UWQcQNqLaflSquMz+e7+EiAgkqZc5kvRhnal
 0+NWKFz58BlkhPKMLhcgl+kDSbLBWcxy5+X6RArUA+t8Pmxs0D0L+fo3qhBnxiuI
 /vBrjQMaXrq+YzVWsMqmwjUzwncrbC398x2wV/PK3O9PpIi1WCkJv7RCyCiXCjdy
 XTb4/rbaFNncz8c/Z6MOQ0/IMoRTVhoyBr9dN8KDUhIfagsEGujvQ4zI3IJ2tEhA
 l/adCc5uS+VRExCGwzPi5CMShwv3N/DVD1XPD+RR3lC8drAIbil94rrgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=UBQI++ulJhmJW+K8ao6+lIoIrU0hGd0x4qsrZp9HNlI=; b=NUhqfzOf
 6dIT1gAJrB68EHLUydB9geP2+CkBKAbMtXhkj8g16rwKMgWxzwp4plHLdT2ndx+P
 yvPG6gePUI1mXNYRX481Jd1LehOVfPVIKE4PZOyIAKmfHKYczm49HkBfZ2Deb41m
 fU+jrSNWWlLEphuXBDd+ivpbhW5/ktkka6hCJxW9rmE2gW5QooHHLYWq1ru63Sqb
 uPjEPhywL+v1APpF6T1sgltGxa1TEDw7ZySHx/yflEV1g1Bb74lJyIuug+HKqGg8
 AWtvtQuxtJlLMAWV2dU0GOn2KzwMiY+SIeVGX6UmV1BkXRCfV4jiVI6BSajibegP
 VdzjVxL59ScvSw==
X-ME-Sender: <xms:XBplX9q4K_kIumcp01tOfyekeVbPIncOHDhw2gsV5TqrFLUFKPWpmA>
 <xme:XBplX_qsnxwUnUHT1bJMy_h-7cDHrAJVGLHr0UqN_fG7VWe9zqR9YbV1YiHMXTHs9
 S6EItob9BgwvpWNINk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdduhedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeltdetfeegkefguedvtdduffejiedvjeejudejieelveekhfekvdefleeludev
 ffenucffohhmrghinhepvddtudelqddtkedrohhrghenucfkphepkedtrdduieejrdelke
 drudeltdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
 pehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:XBplX6OaPd8-Rcai3SHKOKgSomDrtH5LbystWEieopwrs74Ko4xDIA>
 <xmx:XBplX461UJNlb8XYvAOJQf2gpbNCbVLW4kiglYTPhu_UbQhZN0Qaxw>
 <xmx:XBplX86lpvvkkyNtlxQqbYOOK9QXj4lGZLO6S-JogkE7jSPZqAbOHA>
 <xmx:XBplX-txZJNx8VjSfP2gcH8MvzCv8Ci1kUDdozN34K0IGbUkMEbi-YFc7bw>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 27E553064682;
 Fri, 18 Sep 2020 16:36:43 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/17] hw/block/nvme: add support for sgl bit bucket
 descriptor
Date: Fri, 18 Sep 2020 22:36:17 +0200
Message-Id: <20200918203621.602915-14-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918203621.602915-1-its@irrelevant.dk>
References: <20200918203621.602915-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.221; envelope-from=its@irrelevant.dk;
 helo=new1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 16:36:27
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>,
 Gollu Appalanaidu <anaidu.gollu@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gollu Appalanaidu <anaidu.gollu@samsung.com>

This adds support for SGL descriptor type 0x1 (bit bucket descriptor).
See the NVM Express v1.3d specification, Section 4.4 ("Scatter Gather
List (SGL)").

Signed-off-by: Gollu Appalanaidu <anaidu.gollu@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index e01b4b22882e..d2e211c7cbc2 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -430,6 +430,10 @@ static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
         uint8_t type = NVME_SGL_TYPE(segment[i].type);
 
         switch (type) {
+        case NVME_SGL_DESCR_TYPE_BIT_BUCKET:
+            if (req->cmd.opcode == NVME_CMD_WRITE) {
+                continue;
+            }
         case NVME_SGL_DESCR_TYPE_DATA_BLOCK:
             break;
         case NVME_SGL_DESCR_TYPE_SEGMENT:
@@ -440,6 +444,7 @@ static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
         }
 
         dlen = le32_to_cpu(segment[i].len);
+
         if (!dlen) {
             continue;
         }
@@ -460,6 +465,11 @@ static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
         }
 
         trans_len = MIN(*len, dlen);
+
+        if (type == NVME_SGL_DESCR_TYPE_BIT_BUCKET) {
+            goto next;
+        }
+
         addr = le64_to_cpu(segment[i].addr);
 
         if (UINT64_MAX - addr < dlen) {
@@ -471,6 +481,7 @@ static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
             return status;
         }
 
+next:
         *len -= trans_len;
     }
 
@@ -540,7 +551,8 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
         seg_len = le32_to_cpu(sgld->len);
 
         /* check the length of the (Last) Segment descriptor */
-        if (!seg_len || seg_len & 0xf) {
+        if ((!seg_len || seg_len & 0xf) &&
+            (NVME_SGL_TYPE(sgld->type) != NVME_SGL_DESCR_TYPE_BIT_BUCKET)) {
             return NVME_INVALID_SGL_SEG_DESCR | NVME_DNR;
         }
 
@@ -577,19 +589,27 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
 
         last_sgld = &segment[nsgld - 1];
 
-        /* if the segment ends with a Data Block, then we are done */
-        if (NVME_SGL_TYPE(last_sgld->type) == NVME_SGL_DESCR_TYPE_DATA_BLOCK) {
+        /*
+         * If the segment ends with a Data Block or Bit Bucket Descriptor Type,
+         * then we are done.
+         */
+        switch (NVME_SGL_TYPE(last_sgld->type)) {
+        case NVME_SGL_DESCR_TYPE_DATA_BLOCK:
+        case NVME_SGL_DESCR_TYPE_BIT_BUCKET:
             status = nvme_map_sgl_data(n, qsg, iov, segment, nsgld, &len, req);
             if (status) {
                 goto unmap;
             }
 
             goto out;
+
+        default:
+            break;
         }
 
         /*
-         * If the last descriptor was not a Data Block, then the current
-         * segment must not be a Last Segment.
+         * If the last descriptor was not a Data Block or Bit Bucket, then the
+         * current segment must not be a Last Segment.
          */
         if (NVME_SGL_TYPE(sgld->type) == NVME_SGL_DESCR_TYPE_LAST_SEGMENT) {
             status = NVME_INVALID_SGL_SEG_DESCR | NVME_DNR;
@@ -2654,7 +2674,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->nn = cpu_to_le32(n->num_namespaces);
     id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
                            NVME_ONCS_FEATURES);
-    id->sgls = cpu_to_le32(NVME_CTRL_SGLS_SUPPORT_NO_ALIGN);
+    id->sgls = cpu_to_le32(NVME_CTRL_SGLS_SUPPORT_NO_ALIGN |
+                           NVME_CTRL_SGLS_BITBUCKET);
 
     subnqn = g_strdup_printf("nqn.2019-08.org.qemu:%s", n->params.serial);
     strpadcpy((char *)id->subnqn, sizeof(id->subnqn), subnqn, '\0');
-- 
2.28.0


