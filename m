Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CBDC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B002064A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B002064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXS5-0000AR-9z
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWrB-0006gb-Q1
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWrA-0008Fw-IF
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41178)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWr7-0008Eb-Hf; Thu, 10 Oct 2019 07:43:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C941D3084249;
 Thu, 10 Oct 2019 11:43:40 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6ED7860BF7;
 Thu, 10 Oct 2019 11:43:40 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 17/36] qapi: group BlockDeviceStats fields
Date: Thu, 10 Oct 2019 13:42:41 +0200
Message-Id: <20191010114300.7746-18-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 10 Oct 2019 11:43:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

Make the stat fields definition slightly more readable.
Also reorder total_time_ns stats read-write-flush as done elsewhere.
Cosmetic change only.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190923121737.83281-2-anton.nefedov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index e6edd641f1..5ab554b54a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -867,12 +867,12 @@
 # @flush_operations: The number of cache flush operations performed by t=
he
 #                    device (since 0.15.0)
 #
-# @flush_total_time_ns: Total time spend on cache flushes in nano-second=
s
-#                       (since 0.15.0).
+# @rd_total_time_ns: Total time spent on reads in nanoseconds (since 0.1=
5.0).
 #
-# @wr_total_time_ns: Total time spend on writes in nano-seconds (since 0=
.15.0).
+# @wr_total_time_ns: Total time spent on writes in nanoseconds (since 0.=
15.0).
 #
-# @rd_total_time_ns: Total_time_spend on reads in nano-seconds (since 0.=
15.0).
+# @flush_total_time_ns: Total time spent on cache flushes in nanoseconds
+#                       (since 0.15.0).
 #
 # @wr_highest_offset: The offset after the greatest byte written to the
 #                     device.  The intended use of this information is f=
or
@@ -925,14 +925,18 @@
 # Since: 0.14.0
 ##
 { 'struct': 'BlockDeviceStats',
-  'data': {'rd_bytes': 'int', 'wr_bytes': 'int', 'rd_operations': 'int',
-           'wr_operations': 'int', 'flush_operations': 'int',
-           'flush_total_time_ns': 'int', 'wr_total_time_ns': 'int',
-           'rd_total_time_ns': 'int', 'wr_highest_offset': 'int',
-           'rd_merged': 'int', 'wr_merged': 'int', '*idle_time_ns': 'int=
',
+  'data': {'rd_bytes': 'int', 'wr_bytes': 'int',
+           'rd_operations': 'int', 'wr_operations': 'int',
+           'flush_operations': 'int',
+           'rd_total_time_ns': 'int', 'wr_total_time_ns': 'int',
+           'flush_total_time_ns': 'int',
+           'wr_highest_offset': 'int',
+           'rd_merged': 'int', 'wr_merged': 'int',
+           '*idle_time_ns': 'int',
            'failed_rd_operations': 'int', 'failed_wr_operations': 'int',
-           'failed_flush_operations': 'int', 'invalid_rd_operations': 'i=
nt',
-           'invalid_wr_operations': 'int', 'invalid_flush_operations': '=
int',
+           'failed_flush_operations': 'int',
+           'invalid_rd_operations': 'int', 'invalid_wr_operations': 'int=
',
+           'invalid_flush_operations': 'int',
            'account_invalid': 'bool', 'account_failed': 'bool',
            'timed_stats': ['BlockDeviceTimedStats'],
            '*rd_latency_histogram': 'BlockLatencyHistogramInfo',
--=20
2.21.0


