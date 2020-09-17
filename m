Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5E6C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 441B321D90
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441B321D90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIp2M-0008Mj-EE
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 04:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kIohd-00054X-W3; Thu, 17 Sep 2020 03:51:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59008 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kIohb-0005Nu-Qd; Thu, 17 Sep 2020 03:51:37 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 7AF56218DDCCA84D3D18;
 Thu, 17 Sep 2020 15:51:31 +0800 (CST)
Received: from localhost (10.174.187.87) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 15:51:20 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH V3 09/10] qapi/: fix some comment spelling errors
Date: Thu, 17 Sep 2020 15:50:28 +0800
Message-ID: <20200917075029.313-10-zhaolichang@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20200917075029.313-1-zhaolichang@huawei.com>
References: <20200917075029.313-1-zhaolichang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.187.87]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 03:51:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: zhaolichang <zhaolichang@huawei.com>, qemu-devel@nongnu.org, Markus
 Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the qapi folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 4 ++--
 qapi/crypto.json     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 2d94873ca0..3c16f1e11d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1795,7 +1795,7 @@
 #
 # @block-backend: corresponds to BlockBackend
 #
-# @block-job: corresonds to BlockJob
+# @block-job: corresponds to BlockJob
 #
 # @block-driver: corresponds to BlockDriverState
 #
@@ -2067,7 +2067,7 @@
 # @target: name of the destination dirty bitmap
 #
 # @bitmaps: name(s) of the source dirty bitmap(s) at @node and/or fully
-#           specifed BlockDirtyBitmap elements. The latter are supported
+#           specified BlockDirtyBitmap elements. The latter are supported
 #           since 4.1.
 #
 # Since: 4.0
diff --git a/qapi/crypto.json b/qapi/crypto.json
index bb7930d332..2aebe6fa20 100644
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


