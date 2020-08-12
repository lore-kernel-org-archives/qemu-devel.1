Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C79C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 13:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC18206B2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 13:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC18206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5r6d-0005qB-J9
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 09:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1k5non-0008Eh-Ss; Wed, 12 Aug 2020 06:17:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4232 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1k5noj-00033b-RF; Wed, 12 Aug 2020 06:17:13 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 0C8A410C4F72EE9C2150;
 Wed, 12 Aug 2020 18:17:05 +0800 (CST)
Received: from localhost (10.174.187.253) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 12 Aug 2020
 18:16:56 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH RFC 09/10] qapi/: fix some comment spelling errors
Date: Wed, 12 Aug 2020 18:14:59 +0800
Message-ID: <20200812101500.2066-10-zhaolichang@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20200812101500.2066-1-zhaolichang@huawei.com>
References: <20200812101500.2066-1-zhaolichang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.187.253]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 06:17:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 12 Aug 2020 09:40:49 -0400
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
Cc: zhaolichang <zhaolichang@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the qapi folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
---
 qapi/block-core.json | 4 ++--
 qapi/crypto.json     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 197bdc1..b0ef7c1 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1790,7 +1790,7 @@
 #
 # @block-backend: corresponds to BlockBackend
 #
-# @block-job: corresonds to BlockJob
+# @block-job: corresponds to BlockJob
 #
 # @block-driver: corresponds to BlockDriverState
 #
@@ -2061,7 +2061,7 @@
 # @target: name of the destination dirty bitmap
 #
 # @bitmaps: name(s) of the source dirty bitmap(s) at @node and/or fully
-#           specifed BlockDirtyBitmap elements. The latter are supported
+#           specified BlockDirtyBitmap elements. The latter are supported
 #           since 4.1.
 #
 # Since: 4.0
diff --git a/qapi/crypto.json b/qapi/crypto.json
index bb7930d..2aebe6f 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -336,7 +336,7 @@
 #                 written into added active keyslots
 #
 # @old-secret:    Optional (for deactivation only)
-#                 If given will deactive all keyslots that
+#                 If given will deactivate all keyslots that
 #                 match password located in QCryptoSecret with this ID
 #
 # @iter-time:     Optional (for activation only)
@@ -354,7 +354,7 @@
 #                 keyslot to deactivate
 #
 # @secret:        Optional. The ID of a QCryptoSecret object providing the
-#                 password to use to retrive current master key.
+#                 password to use to retrieve current master key.
 #                 Defaults to the same secret that was used to open the image
 #
 #
-- 
2.26.2.windows.1



