Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AB4C56201
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:19:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A38207BC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A38207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3KQ-0007l4-Jd
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinzeyu@huawei.com>)
 id 1kc3Az-0004S9-4N
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:09:25 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:2085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinzeyu@huawei.com>)
 id 1kc3Av-0006z2-Pv
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:09:24 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CV4tY0TcXzhjDy;
 Mon,  9 Nov 2020 17:09:09 +0800 (CST)
Received: from localhost (10.174.186.67) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Mon, 9 Nov 2020
 17:09:04 +0800
From: Zeyu Jin <jinzeyu@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [RFC PATCH 6/6] doc: Update multi-thread compression doc
Date: Mon, 9 Nov 2020 17:08:50 +0800
Message-ID: <20201109090850.2424-7-jinzeyu@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201109090850.2424-1-jinzeyu@huawei.com>
References: <20201109090850.2424-1-jinzeyu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.67]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=jinzeyu@huawei.com;
 helo=szxga06-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 04:09:11
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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
Cc: Ying Fang <fangying1@huawei.com>, qemu-devel@nongnu.org,
 Zeyu Jin <jinzeyu@huawei.com>, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Modify the doc to fit the previous changes.

Signed-off-by: Zeyu Jin <jinzeyu@huawei.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 docs/multi-thread-compression.txt | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/docs/multi-thread-compression.txt b/docs/multi-thread-compression.txt
index bb88c6bdf1..d429963cb0 100644
--- a/docs/multi-thread-compression.txt
+++ b/docs/multi-thread-compression.txt
@@ -33,14 +33,15 @@ thread compression can be used to accelerate the compression process.
 
 The decompression speed of Zlib is at least 4 times as quick as
 compression, if the source and destination CPU have equal speed,
-keeping the compression thread count 4 times the decompression
-thread count can avoid resource waste.
+and you choose Zlib as compression method, keeping the compression
+thread count 4 times the decompression thread count can avoid resource waste.
 
 Compression level can be used to control the compression speed and the
-compression ratio. High compression ratio will take more time, level 0
-stands for no compression, level 1 stands for the best compression
-speed, and level 9 stands for the best compression ratio. Users can
-select a level number between 0 and 9.
+compression ratio. High compression ratio will take more time,
+level 1 stands for the best compression speed, and higher level means higher
+compression ration. For Zlib, users can select a level number between 0 and 9,
+where level 0 stands for no compression. For Zstd, users can select a
+level number between 1 and 22.
 
 
 When to use the multiple thread compression in live migration
@@ -116,16 +117,19 @@ to support the multiple thread compression migration:
 2. Activate compression on the source:
     {qemu} migrate_set_capability compress on
 
-3. Set the compression thread count on source:
+3. Set the compression method:
+    {qemu} migrate_set_parameter compress_method zstd
+
+4. Set the compression thread count on source:
     {qemu} migrate_set_parameter compress_threads 12
 
-4. Set the compression level on the source:
+5. Set the compression level on the source:
     {qemu} migrate_set_parameter compress_level 1
 
-5. Set the decompression thread count on destination:
+6. Set the decompression thread count on destination:
     {qemu} migrate_set_parameter decompress_threads 3
 
-6. Start outgoing migration:
+7. Start outgoing migration:
     {qemu} migrate -d tcp:destination.host:4444
     {qemu} info migrate
     Capabilities: ... compress: on
@@ -136,6 +140,7 @@ The following are the default settings:
     compress_threads: 8
     decompress_threads: 2
     compress_level: 1 (which means best speed)
+    compress_method: zlib
 
 So, only the first two steps are required to use the multiple
 thread compression in migration. You can do more if the default
@@ -143,7 +148,7 @@ settings are not appropriate.
 
 TODO
 ====
-Some faster (de)compression method such as LZ4 and Quicklz can help
-to reduce the CPU consumption when doing (de)compression. If using
-these faster (de)compression method, less (de)compression threads
+Comparing to Zlib, Some faster (de)compression method such as LZ4
+and Quicklz can help to reduce the CPU consumption when doing (de)compression.
+If using these faster (de)compression method, less (de)compression threads
 are needed when doing the migration.
-- 
2.23.0


