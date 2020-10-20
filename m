Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8D1C43467
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 02:30:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E7E223FD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 02:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E7E223FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUhPr-0005ol-87
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 22:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhengui@huawei.com>)
 id 1kUhKX-00005m-0r; Mon, 19 Oct 2020 22:24:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57946 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhengui@huawei.com>)
 id 1kUhKQ-000802-KJ; Mon, 19 Oct 2020 22:24:52 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6F93C45FC900B1963286;
 Tue, 20 Oct 2020 10:24:41 +0800 (CST)
Received: from DESKTOP-80C7KIU.china.huawei.com (10.174.187.210) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 20 Oct 2020 10:24:34 +0800
From: Zhengui li <lizhengui@huawei.com>
To: <pbonzini@redhat.com>, <stefanha@redhat.com>, <mreitz@redhat.com>,
 <kwolf@redhat.com>
Subject: [PATCH v2 4/6] virtio-gpu: fix incorrect print type
Date: Tue, 20 Oct 2020 02:24:02 +0000
Message-ID: <1603160644-7308-4-git-send-email-lizhengui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
In-Reply-To: <1603160644-7308-1-git-send-email-lizhengui@huawei.com>
References: <1603160644-7308-1-git-send-email-lizhengui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.210]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=lizhengui@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 22:24:36
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
Cc: xieyingtai@huawei.com, lizhengui@huawei.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The type of input variable is unsigned int
while the printer type is int. So fix incorrect print type.

Signed-off-by: Zhengui li <lizhengui@huawei.com>
---
 hw/display/virtio-gpu.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 90be4e3..d785d88 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -275,7 +275,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
 
     res = virtio_gpu_find_resource(g, c2d.resource_id);
     if (res) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n",
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %u\n",
                       __func__, c2d.resource_id);
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
         return;
@@ -291,7 +291,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
     pformat = virtio_gpu_get_pixman_format(c2d.format);
     if (!pformat) {
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: host couldn't handle guest format %d\n",
+                      "%s: host couldn't handle guest format %u\n",
                       __func__, c2d.format);
         g_free(res);
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
@@ -308,7 +308,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
 
     if (!res->image) {
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: resource creation failed %d %d %d\n",
+                      "%s: resource creation failed %u %u %u\n",
                       __func__, c2d.resource_id, c2d.width, c2d.height);
         g_free(res);
         cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
@@ -379,7 +379,7 @@ static void virtio_gpu_resource_unref(VirtIOGPU *g,
 
     res = virtio_gpu_find_resource(g, unref.resource_id);
     if (!res) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal resource specified %d\n",
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal resource specified %u\n",
                       __func__, unref.resource_id);
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
         return;
@@ -403,7 +403,7 @@ static void virtio_gpu_transfer_to_host_2d(VirtIOGPU *g,
 
     res = virtio_gpu_find_resource(g, t2d.resource_id);
     if (!res || !res->iov) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal resource specified %d\n",
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal resource specified %u\n",
                       __func__, t2d.resource_id);
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
         return;
@@ -416,7 +416,7 @@ static void virtio_gpu_transfer_to_host_2d(VirtIOGPU *g,
         t2d.r.x + t2d.r.width > res->width ||
         t2d.r.y + t2d.r.height > res->height) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: transfer bounds outside resource"
-                      " bounds for resource %d: %d %d %d %d vs %d %d\n",
+                      " bounds for resource %u: %u %u %u %u vs %u %u\n",
                       __func__, t2d.resource_id, t2d.r.x, t2d.r.y,
                       t2d.r.width, t2d.r.height, res->width, res->height);
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
@@ -461,7 +461,7 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
 
     res = virtio_gpu_find_resource(g, rf.resource_id);
     if (!res) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal resource specified %d\n",
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal resource specified %u\n",
                       __func__, rf.resource_id);
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
         return;
@@ -474,7 +474,7 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
         rf.r.x + rf.r.width > res->width ||
         rf.r.y + rf.r.height > res->height) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: flush bounds outside resource"
-                      " bounds for resource %d: %d %d %d %d vs %d %d\n",
+                      " bounds for resource %u: %u %u %u %u vs %u %u\n",
                       __func__, rf.resource_id, rf.r.x, rf.r.y,
                       rf.r.width, rf.r.height, res->width, res->height);
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
@@ -533,7 +533,7 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
                                      ss.r.width, ss.r.height, ss.r.x, ss.r.y);
 
     if (ss.scanout_id >= g->parent_obj.conf.max_outputs) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout id specified %d",
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout id specified %u",
                       __func__, ss.scanout_id);
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID;
         return;
@@ -548,7 +548,7 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
     /* create a surface for this scanout */
     res = virtio_gpu_find_resource(g, ss.resource_id);
     if (!res) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal resource specified %d\n",
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal resource specified %u\n",
                       __func__, ss.resource_id);
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
         return;
@@ -562,8 +562,8 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
         ss.r.height > res->height ||
         ss.r.x + ss.r.width > res->width ||
         ss.r.y + ss.r.height > res->height) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %d bounds for"
-                      " resource %d, (%d,%d)+%d,%d vs %d %d\n",
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %u bounds for"
+                      " resource %u, (%u,%u)+%u,%u vs %u %u\n",
                       __func__, ss.scanout_id, ss.resource_id, ss.r.x, ss.r.y,
                       ss.r.width, ss.r.height, res->width, res->height);
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
@@ -621,7 +621,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
 
     if (ab->nr_entries > 16384) {
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: nr_entries is too big (%d > 16384)\n",
+                      "%s: nr_entries is too big (%u > 16384)\n",
                       __func__, ab->nr_entries);
         return -1;
     }
@@ -654,7 +654,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
         }
         if (!(*iov)[i].iov_base || len != l) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map MMIO memory for"
-                          " resource %d element %d\n",
+                          " resource %u element %d\n",
                           __func__, ab->resource_id, i);
             if ((*iov)[i].iov_base) {
                 i++; /* cleanup the 'i'th map */
@@ -711,7 +711,7 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
 
     res = virtio_gpu_find_resource(g, ab.resource_id);
     if (!res) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal resource specified %d\n",
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal resource specified %u\n",
                       __func__, ab.resource_id);
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
         return;
@@ -744,7 +744,7 @@ virtio_gpu_resource_detach_backing(VirtIOGPU *g,
 
     res = virtio_gpu_find_resource(g, detach.resource_id);
     if (!res || !res->iov) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal resource specified %d\n",
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal resource specified %u\n",
                       __func__, detach.resource_id);
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
         return;
-- 
2.6.4.windows.1


