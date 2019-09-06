Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7CEC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:05:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DC82070C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DC82070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Gjw-0005F2-64
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1i6GgC-0002Jh-H0
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1i6GgB-0004yD-C3
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:01:44 -0400
Received: from relay.sw.ru ([185.231.240.75]:37874)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
 id 1i6Gg8-0004iv-9t; Fri, 06 Sep 2019 12:01:40 -0400
Received: from [172.16.25.154] (helo=xantnef-ws.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <anton.nefedov@virtuozzo.com>)
 id 1i6Gg6-0005vz-AZ; Fri, 06 Sep 2019 19:01:38 +0300
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Fri,  6 Sep 2019 19:01:12 +0300
Message-Id: <20190906160120.70239-2-anton.nefedov@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190906160120.70239-1-anton.nefedov@virtuozzo.com>
References: <20190906160120.70239-1-anton.nefedov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v9 1/9] qapi: group BlockDeviceStats fields
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 den@virtuozzo.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, pbonzini@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the stat fields definition slightly more readable.
Also reorder total_time_ns stats read-write-flush as done elsewhere.
Cosmetic change only.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index e6edd641f1..5ab554b54a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -867,12 +867,12 @@
 # @flush_operations: The number of cache flush operations performed by the
 #                    device (since 0.15.0)
 #
-# @flush_total_time_ns: Total time spend on cache flushes in nano-seconds
-#                       (since 0.15.0).
+# @rd_total_time_ns: Total time spent on reads in nanoseconds (since 0.15.0).
 #
-# @wr_total_time_ns: Total time spend on writes in nano-seconds (since 0.15.0).
+# @wr_total_time_ns: Total time spent on writes in nanoseconds (since 0.15.0).
 #
-# @rd_total_time_ns: Total_time_spend on reads in nano-seconds (since 0.15.0).
+# @flush_total_time_ns: Total time spent on cache flushes in nanoseconds
+#                       (since 0.15.0).
 #
 # @wr_highest_offset: The offset after the greatest byte written to the
 #                     device.  The intended use of this information is for
@@ -925,14 +925,18 @@
 # Since: 0.14.0
 ##
 { 'struct': 'BlockDeviceStats',
-  'data': {'rd_bytes': 'int', 'wr_bytes': 'int', 'rd_operations': 'int',
-           'wr_operations': 'int', 'flush_operations': 'int',
-           'flush_total_time_ns': 'int', 'wr_total_time_ns': 'int',
-           'rd_total_time_ns': 'int', 'wr_highest_offset': 'int',
-           'rd_merged': 'int', 'wr_merged': 'int', '*idle_time_ns': 'int',
+  'data': {'rd_bytes': 'int', 'wr_bytes': 'int',
+           'rd_operations': 'int', 'wr_operations': 'int',
+           'flush_operations': 'int',
+           'rd_total_time_ns': 'int', 'wr_total_time_ns': 'int',
+           'flush_total_time_ns': 'int',
+           'wr_highest_offset': 'int',
+           'rd_merged': 'int', 'wr_merged': 'int',
+           '*idle_time_ns': 'int',
            'failed_rd_operations': 'int', 'failed_wr_operations': 'int',
-           'failed_flush_operations': 'int', 'invalid_rd_operations': 'int',
-           'invalid_wr_operations': 'int', 'invalid_flush_operations': 'int',
+           'failed_flush_operations': 'int',
+           'invalid_rd_operations': 'int', 'invalid_wr_operations': 'int',
+           'invalid_flush_operations': 'int',
            'account_invalid': 'bool', 'account_failed': 'bool',
            'timed_stats': ['BlockDeviceTimedStats'],
            '*rd_latency_histogram': 'BlockLatencyHistogramInfo',
-- 
2.17.1


