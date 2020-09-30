Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E739DC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 760B72071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZQrzxhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760B72071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNcIB-0002VS-B3
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 09:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNcHT-0001gs-1V
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:36:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNcHR-00059x-72
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:36:26 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601472983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2vHRL5eX9BL94vd+K6WurhznfeIEql4fNGTiRZTplOM=;
 b=HZQrzxhA9kkVgIQ5KYxLPikOlw/EZx/dr6VpKq0R/G4o6SN31Zuzq8BpL0cZSTp/4Eq8rf
 pGVAl3oCCx3AENPk/ifiiosU4L+aO/PYfNe/HzLO+mI7U8KK0aJFkr+K9ktvptZ1xwOxQ8
 r3TstgOMY4puLw+CPeyjzCP69R9VNeI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-u2tZcTvXPfe-J82uYlk76w-1; Wed, 30 Sep 2020 09:36:22 -0400
X-MC-Unique: u2tZcTvXPfe-J82uYlk76w-1
Received: by mail-wr1-f69.google.com with SMTP id i10so623746wrq.5
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 06:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2vHRL5eX9BL94vd+K6WurhznfeIEql4fNGTiRZTplOM=;
 b=HAf17+4sc6a3Q7Kvoe963AI26wg8LMMhE1bm/3eCdzfBIFGmbZn0Ve7D31J1naYnlo
 WstmLN2XxE1MiOugDBwQg4TpGljmnGZ3oHXxSaRjBFEn1mSmbOJr2yhHzMoxssA4xZfB
 rfse668YtxzClpphz3vbJ/oxj6TTGd4RtkcGsOinRdnPG+YDeMueOeRjNjgE2junPtKX
 sEE5MU1NkEXY0DEvLEeyYXCyawVFdnK2e3xUoAXy6/KNsDDVAUjhvpjFWs03oYvhUa5R
 uIbnnzeo/dMRyo7DWIYHelD3r0C+wgPtd7YahcKK5/RkZ6RJQYlVDQfTXvBghokP01Ui
 N1HA==
X-Gm-Message-State: AOAM533Fib8B4Yn9gLbOLVYekNjImpkB/QqEixNVSnDqw1LQ8nHBPDyt
 fu3blW/GiXvKftzNMAFXthqj2Qmfv8AEpGAk6un36YKLof4u0RjWNIWqbpzEFsEskiT5ljJXnMy
 CgSZDEHYE/s/9dp0=
X-Received: by 2002:a05:6000:1282:: with SMTP id
 f2mr3448922wrx.251.1601472980292; 
 Wed, 30 Sep 2020 06:36:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPn4mQjFp2c705V0pzEhcqr7oc7Hz+lFhZI4VZ7wrxVLEz3+qwV2Op6tj4Ck2nUmh0lo1juA==
X-Received: by 2002:a05:6000:1282:: with SMTP id
 f2mr3448892wrx.251.1601472980040; 
 Wed, 30 Sep 2020 06:36:20 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id 63sm3251130wrh.71.2020.09.30.06.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 06:36:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] block/nvme: Add driver statistics for access alignment and hw
 errors
Date: Wed, 30 Sep 2020 15:36:17 +0200
Message-Id: <20200930133617.1320941-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Keep statistics of some hardware errors, and number of
aligned/unaligned I/O accesses.

QMP example booting a full RHEL 8.3 aarch64 guest:

{ "execute": "query-blockstats" }
{
    "return": [
        {
            "device": "",
            "node-name": "drive0",
            "stats": {
                "flush_total_time_ns": 6026948,
                "wr_highest_offset": 3383991230464,
                "wr_total_time_ns": 807450995,
                "failed_wr_operations": 0,
                "failed_rd_operations": 0,
                "wr_merged": 3,
                "wr_bytes": 50133504,
                "failed_unmap_operations": 0,
                "failed_flush_operations": 0,
                "account_invalid": false,
                "rd_total_time_ns": 1846979900,
                "flush_operations": 130,
                "wr_operations": 659,
                "rd_merged": 1192,
                "rd_bytes": 218244096,
                "account_failed": false,
                "idle_time_ns": 2678641497,
                "rd_operations": 7406,
            },
            "driver-specific": {
                "driver": "nvme",
                "completion-errors": 0,
                "unaligned-access-nb": 2959,
                "aligned-access-nb": 4477
            },
            "qdev": "/machine/peripheral-anon/device[0]/virtio-backend"
        }
    ]
}

Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/block-core.json | 24 +++++++++++++++++++++++-
 block/nvme.c         | 27 +++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 86ed72ef9f..795e4185bd 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -941,6 +941,27 @@
       'discard-nb-failed': 'uint64',
       'discard-bytes-ok': 'uint64' } }
 
+##
+# @BlockStatsSpecificNvme:
+#
+# NVMe driver statistics
+#
+# @completion-errors: The number of completion errors.
+#
+# @aligned-access-nb: The number of aligned accesses performed by
+#                     the driver.
+#
+# @unaligned-access-nb: The number of unaligned accesses performed by
+#                       the driver.
+#
+# Since: 5.2
+##
+{ 'struct': 'BlockStatsSpecificNvme',
+  'data': {
+      'completion-errors': 'uint64',
+      'aligned-access-nb': 'uint64',
+      'unaligned-access-nb': 'uint64' } }
+
 ##
 # @BlockStatsSpecific:
 #
@@ -953,7 +974,8 @@
   'discriminator': 'driver',
   'data': {
       'file': 'BlockStatsSpecificFile',
-      'host_device': 'BlockStatsSpecificFile' } }
+      'host_device': 'BlockStatsSpecificFile',
+      'nvme': 'BlockStatsSpecificNvme' } }
 
 ##
 # @BlockStats:
diff --git a/block/nvme.c b/block/nvme.c
index f4f27b6da7..382f696202 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -133,6 +133,12 @@ struct BDRVNVMeState {
 
     /* PCI address (required for nvme_refresh_filename()) */
     char *device;
+
+    struct {
+        uint64_t completion_errors;
+        uint64_t aligned_access_nb;
+        uint64_t unaligned_access_nb;
+    } stats;
 };
 
 #define NVME_BLOCK_OPT_DEVICE "device"
@@ -389,6 +395,9 @@ static bool nvme_process_completion(NVMeQueuePair *q)
             break;
         }
         ret = nvme_translate_error(c);
+        if (ret) {
+            s->stats.completion_errors++;
+        }
         q->cq.head = (q->cq.head + 1) % NVME_QUEUE_SIZE;
         if (!q->cq.head) {
             q->cq_phase = !q->cq_phase;
@@ -1146,8 +1155,10 @@ static int nvme_co_prw(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     assert(QEMU_IS_ALIGNED(bytes, s->page_size));
     assert(bytes <= s->max_transfer);
     if (nvme_qiov_aligned(bs, qiov)) {
+        s->stats.aligned_access_nb++;
         return nvme_co_prw_aligned(bs, offset, bytes, qiov, is_write, flags);
     }
+    s->stats.unaligned_access_nb++;
     trace_nvme_prw_buffered(s, offset, bytes, qiov->niov, is_write);
     buf = qemu_try_memalign(s->page_size, bytes);
 
@@ -1443,6 +1454,21 @@ static void nvme_unregister_buf(BlockDriverState *bs, void *host)
     qemu_vfio_dma_unmap(s->vfio, host);
 }
 
+static BlockStatsSpecific *nvme_get_specific_stats(BlockDriverState *bs)
+{
+    BlockStatsSpecific *stats = g_new(BlockStatsSpecific, 1);
+    BDRVNVMeState *s = bs->opaque;
+
+    stats->driver = BLOCKDEV_DRIVER_NVME;
+    stats->u.nvme = (BlockStatsSpecificNvme) {
+        .completion_errors = s->stats.completion_errors,
+        .aligned_access_nb = s->stats.aligned_access_nb,
+        .unaligned_access_nb = s->stats.unaligned_access_nb,
+    };
+
+    return stats;
+}
+
 static const char *const nvme_strong_runtime_opts[] = {
     NVME_BLOCK_OPT_DEVICE,
     NVME_BLOCK_OPT_NAMESPACE,
@@ -1476,6 +1502,7 @@ static BlockDriver bdrv_nvme = {
     .bdrv_refresh_filename    = nvme_refresh_filename,
     .bdrv_refresh_limits      = nvme_refresh_limits,
     .strong_runtime_opts      = nvme_strong_runtime_opts,
+    .bdrv_get_specific_stats  = nvme_get_specific_stats,
 
     .bdrv_detach_aio_context  = nvme_detach_aio_context,
     .bdrv_attach_aio_context  = nvme_attach_aio_context,
-- 
2.26.2


