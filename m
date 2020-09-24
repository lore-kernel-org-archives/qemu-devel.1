Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F2AC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:50:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF18620717
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF18620717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLYCX-0007Lf-M9
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 16:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7N-0004Py-3a; Thu, 24 Sep 2020 16:45:29 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:51605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7J-0007iS-NB; Thu, 24 Sep 2020 16:45:28 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id D760C580507;
 Thu, 24 Sep 2020 16:45:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 24 Sep 2020 16:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=WbPXCy/OFaknh
 L9vreyycHOBgrvUUYu9WIgBvZGZ6+E=; b=tKawj+n4tvXW+Y0Lxx+coHYMzKQEo
 d3oRKfX1ByweMyxdq5pmi9mf9UdnvqVjwenRz2z3YMd8ewKIcr5pq0yeIu2x//br
 ik2k7MFZmZq7CNp+SOHXk5NXF/2tU9cFyWJ1DIef0mesRlWt0aavGoQZvTvfv8ct
 G3hA02JD9bE6itnd4nWdCIfYLWZQTLx7GoWAwmyHEUi//KztPUYiUbY8Y9N0oHS/
 1vFiofgM5rmI6R/2qMGyVba+Rz011T/GpqMAbgby5cjZit1epiSN3OqtPKTjfXD4
 OfvTIYhy6PECgJYmOv+C5iwgLv+6NrD/HpUbYEeTDn7oYsC4ssiBKTSeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=WbPXCy/OFaknhL9vreyycHOBgrvUUYu9WIgBvZGZ6+E=; b=FWXKG6k7
 b5R95mDnWHxok2kQopm1BuLS+RKdpNIHKDIvi45lMSLWrNMpDlACowNZ9UJu2wkX
 n4qQboPgtp9dnx16gze6i1GyEd/PubtRwfJtUzu/LgvCQDFRXbFyDoopxJcZv5Nf
 7Y3LPMlWufNoBkJdU/ZnOkMWK3VDB7JkYawmNJd/Vx8IUy1T0y3D/K5fa47pqRUX
 XosV2X9OrMgExjopyO2tZLjuk42OwdmoePoX/QPzOkzG5dIwG2dlZSgQMOgZKa41
 Fwhj6VpfB+aGOm4bOGbz2E/4klzznNBlGZgUIfbLoBAKfFF+NulLq/b1qjpDYXII
 wyrtfjsBKelQ9g==
X-ME-Sender: <xms:ZAVtXxbSUFkcLauW7REOADgU4VqZraGQ2oHiPqHHXjT2-o_13CZ66A>
 <xme:ZAVtX4ZTZ6wzvRAUTJgltrqwo8kT7rnr1XXGB-kgkny-tySw2BMK9i_Z1P0FgGlPf
 CJdnyadOq1zL4Uewy4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdduheduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeuleetgeeiuefhgfekfefgveejiefgteekiedtgfdtieefhfdthfefueffvefg
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedvne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:ZAVtXz9M8WfD-GaRDLkI55VDDFBJyTM5wBEqKXCYTlKoJM9KMxE-gA>
 <xmx:ZAVtX_p8NT27WM66ofOl1kMT9g3K4gtyxfiJPm86oxwGX4q4lSfV5A>
 <xmx:ZAVtX8qWylxY4GeiVj6wFsUnRbEFNbMocywsSHItjwDGIQ6OYtLx3Q>
 <xmx:ZAVtXxB9Dy24F6h1zE-eX2IqfpIu0fnMQ_1TpvUWCVa33zr5n3_QVg>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 5CFFF3064683;
 Thu, 24 Sep 2020 16:45:23 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/16] hw/block/nvme: reject io commands if only admin command
 set selected
Date: Thu, 24 Sep 2020 22:45:04 +0200
Message-Id: <20200924204516.1881843-5-its@irrelevant.dk>
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

If the host sets CC.CSS to 111b, all commands submitted to I/O queues
should be completed with status Invalid Command Opcode.

Note that this is technically a v1.4 feature, but it does not hurt to
implement before we finally bump the reported version implemented.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 include/block/nvme.h | 5 +++++
 hw/block/nvme.c      | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index 58647bcdad0b..7a30cf285ae0 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -110,6 +110,11 @@ enum NvmeCcMask {
 #define NVME_CC_IOSQES(cc) ((cc >> CC_IOSQES_SHIFT) & CC_IOSQES_MASK)
 #define NVME_CC_IOCQES(cc) ((cc >> CC_IOCQES_SHIFT) & CC_IOCQES_MASK)
 
+enum NvmeCcCss {
+    NVME_CC_CSS_NVM        = 0x0,
+    NVME_CC_CSS_ADMIN_ONLY = 0x7,
+};
+
 enum NvmeCstsShift {
     CSTS_RDY_SHIFT      = 0,
     CSTS_CFS_SHIFT      = 1,
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 758f58c88026..27af2f0b38d5 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1065,6 +1065,10 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     trace_pci_nvme_io_cmd(nvme_cid(req), nsid, nvme_sqid(req),
                           req->cmd.opcode, nvme_io_opc_str(req->cmd.opcode));
 
+    if (NVME_CC_CSS(n->bar.cc) == NVME_CC_CSS_ADMIN_ONLY) {
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+
     if (!nvme_nsid_valid(n, nsid)) {
         return NVME_INVALID_NSID | NVME_DNR;
     }
-- 
2.28.0


