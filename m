Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B30C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7091C20773
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7091C20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNP3b-0006qx-63
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 19:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOu9-0000Vk-V1; Tue, 29 Sep 2020 19:19:29 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:35191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOu8-00008E-0k; Tue, 29 Sep 2020 19:19:29 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 1D8DCB7B;
 Tue, 29 Sep 2020 19:19:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 29 Sep 2020 19:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=WbPXCy/OFaknh
 L9vreyycHOBgrvUUYu9WIgBvZGZ6+E=; b=I9LeHaDj1bT4y+MdxzVBm9ALVqGbF
 N7kOp4ftAucjVHgjGcuip/IZxFYmqpQXCeULkPlm7JB5jZplN8vJ3VGMIwU/s6jF
 kHSiDlzpWkd/07ihz9FGKa75410bc5pgA74xjjhstCw2lJ82Cmdy0FGURZES7A3y
 CzPYjMU+wgcSymfr9zhjxpfZXvTyPXPAtMbc8BzpWdz8dAXOgMsBeUigZWuhB0Vf
 SR+X+D9jIdf6sJQ3rYsIF7bSySNckH/8aI6tn+7U7FawYY7dUJahS3ByhA5IEOaR
 I3c/potZZnU/VRgj11guBEnkj/l2Rp3ln+RsYTe+h7KL/CS5t3CZTi4BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=WbPXCy/OFaknhL9vreyycHOBgrvUUYu9WIgBvZGZ6+E=; b=KL2Mpv7u
 p1cDSxAxlmW5B5dlPNZoDfwnoiyK9UD504dwSAXqwYd0JPJz+9gXOEtMVvA0Ssnp
 iQmdZYY1GW/abY2jwnPnt5llBHg8yDbi79tyCnDNCaHVZ7z3aQC5FOHRSrkhxIWu
 bFR5MEcH/AD0csaMRRt+mEXCFhOJo38zJSm6YbAqbVFiPp89X8mLvMhONXyWzKgw
 BJVsav1TJuM0ZBiHa3AtkArCo3ljUtlZwn7Jou/D7wOA7U7OVPhmqD2G3mwkViFW
 0fK4cuuSx9CIV6d9AiDowPJQO7xDAmt8uQdm8Iuf45ZxHJ9dkXswOcySEJ5EokB+
 xtLAxP5AeNTTMw==
X-ME-Sender: <xms:_cBzX5SpQZuwjkpHTXZ-MSD5lUd4LpUjfT5BKUyyaxuMhHwlKnnDLw>
 <xme:_cBzXyxItg1vDBvHgI7hrTsJckivnmqp87vbwgtwQ1xdxeJE9GwtoNELtkNTPfrcU
 37v_Ffi78jfuV4SdEc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedtgddujecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepvdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:_cBzX-2aZEPvBAA08lj5f8ZhgMltVRmohujcRQ_CagIJRh9osnb-BQ>
 <xmx:_cBzXxBRZrKG_xa_Jm0T1UZHfh9xRQ2MfLjeZY4dfa6JC0mgc6GSVw>
 <xmx:_cBzXyioaLnDq_7bZqW4UtDw1LV_ONQ3SnbtxAwUDpmSUQZLYANz6g>
 <xmx:_cBzX0b1iXy3gIiUuft0rMHl0eB2RVQWx_zK5FayIkszvvmOKZEIpT2wyFk>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6BBE4328005D;
 Tue, 29 Sep 2020 19:19:24 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/14] hw/block/nvme: reject io commands if only admin
 command set selected
Date: Wed, 30 Sep 2020 01:19:07 +0200
Message-Id: <20200929231917.433586-5-its@irrelevant.dk>
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


