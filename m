Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41B5C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79272217BA
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIXGnzyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79272217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFF5E-0007jb-Jd
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF2C-0002Dr-VW
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29425
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF2B-0007uW-7j
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599477002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IIHQuVQhUQGw0l9A6R2K0HqJdHkW1jpoPyqf2Fl3QEE=;
 b=OIXGnzyLgyXuqMvFwmQ4bp4BY5B5zzcIEPzIofKgl6wCFM5r+A3kn9OC7mKJw+/dzKyB12
 Q/8DiNjmGQyd8ZVClVqQljQfTAYNaRrMa5FoqGWXJvppTyCAfGPMFQp7aYADPOlfq3EFPO
 AUPQ8MHHEf8EG51loS7Vs+a0fL6Jz4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-nE_DE2ryNTm4bjSu8p8fuA-1; Mon, 07 Sep 2020 07:09:53 -0400
X-MC-Unique: nE_DE2ryNTm4bjSu8p8fuA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 208E71007461;
 Mon,  7 Sep 2020 11:09:52 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 297A77E43B;
 Mon,  7 Sep 2020 11:09:51 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 08/64] block/nvme: Rename local variable
Date: Mon,  7 Sep 2020 13:08:40 +0200
Message-Id: <20200907110936.261684-9-kwolf@redhat.com>
In-Reply-To: <20200907110936.261684-1-kwolf@redhat.com>
References: <20200907110936.261684-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:19:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We are going to modify the code in the next commit. Renaming
the 'resp' variable to 'id' first makes the next commit easier
to review. No logical changes.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200821195359.1285345-8-philmd@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/nvme.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 909a565184..0992f2fb57 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -510,8 +510,8 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     BDRVNVMeState *s = bs->opaque;
     NvmeIdCtrl *idctrl;
     NvmeIdNs *idns;
+    uint8_t *id;
     NvmeLBAF *lbaf;
-    uint8_t *resp;
     uint16_t oncs;
     int r;
     uint64_t iova;
@@ -520,14 +520,14 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
         .cdw10 = cpu_to_le32(0x1),
     };
 
-    resp = qemu_try_blockalign0(bs, sizeof(NvmeIdCtrl));
-    if (!resp) {
+    id = qemu_try_blockalign0(bs, sizeof(NvmeIdCtrl));
+    if (!id) {
         error_setg(errp, "Cannot allocate buffer for identify response");
         goto out;
     }
-    idctrl = (NvmeIdCtrl *)resp;
-    idns = (NvmeIdNs *)resp;
-    r = qemu_vfio_dma_map(s->vfio, resp, sizeof(NvmeIdCtrl), true, &iova);
+    idctrl = (NvmeIdCtrl *)id;
+    idns = (NvmeIdNs *)id;
+    r = qemu_vfio_dma_map(s->vfio, id, sizeof(NvmeIdCtrl), true, &iova);
     if (r) {
         error_setg(errp, "Cannot map buffer for DMA");
         goto out;
@@ -554,8 +554,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     s->supports_write_zeroes = !!(oncs & NVME_ONCS_WRITE_ZEROES);
     s->supports_discard = !!(oncs & NVME_ONCS_DSM);
 
-    memset(resp, 0, 4096);
-
+    memset(id, 0, 4096);
     cmd.cdw10 = 0;
     cmd.nsid = cpu_to_le32(namespace);
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
@@ -587,8 +586,8 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
 
     s->blkshift = lbaf->ds;
 out:
-    qemu_vfio_dma_unmap(s->vfio, resp);
-    qemu_vfree(resp);
+    qemu_vfio_dma_unmap(s->vfio, id);
+    qemu_vfree(id);
 }
 
 static bool nvme_poll_queues(BDRVNVMeState *s)
-- 
2.25.4


