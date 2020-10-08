Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CCBC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 170EE221FD
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="doi9cAZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170EE221FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQZaq-0001Ub-3I
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kQZXG-0004oV-Bs
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:16:58 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40481)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kQZXE-0006f3-D8
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:16:58 -0400
Received: by mail-wr1-x444.google.com with SMTP id j2so7460392wrx.7
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 10:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ljSwi0VqUen6R8hy1IfuL/+6iifQubTRGt68McPlcgo=;
 b=doi9cAZQ0koh8PNw4YY9QDkciPnH/LbV+T6Q80+0i0SHilBA53fWya7Q9c4w81Ydf5
 2HDiKCbLTbPqZm5xKUd7WzeoDQjq6PghKXBGP1CI/TeJRfaiFbUdjscq2IHULl6w7p5W
 H8DxkJWLHvrAA4P+JTmHMIkrFmy9uXmXwkyieQ6nb5TscQWtjeCud607umKraQOU7v11
 C5mixESvp3VV7pNEbvmJiUm326NOoUIcs0zhAobiyDAhc2K/i77LoOqecnRmfenKlXcn
 sP2KG4He2BOeZHE1sjwVZjRtYffBiIMwvH5Y0GO4Ra+IlWTQq4IBP0iuq9hdm3vlKEOw
 cddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ljSwi0VqUen6R8hy1IfuL/+6iifQubTRGt68McPlcgo=;
 b=dp9HXK5WWIcXO27phfJjex0gfi/6XqDfngjfkan5SFb3yAR8FTBkcYYXZ6+JCpBkZ5
 Dsf/feFnqa+EUlOqRq1vmInYjPI5InJIR3tdqGPzv8XnfQI1G2B/fLxQleGcCCk5raQT
 2VZqKXwNDckmo0JpI6mZkOjs73E+70fsK/s2pVVqZqdKesmJXnvP8CmjcaM3ST4p6ETL
 eDyI8/Xzkv6RYm9MFZ3rMPaktI6wCdOFpFcUnscOPuk1k6cQcCNN9Q+rHIJJWZGGfaAZ
 nPHJ6o453Qs2L/UDqUXQtP8Ug1rKJPinYekNE7/ZdrY/aSVOrH5C4OZ8Olv3YroQ+HoV
 bT9w==
X-Gm-Message-State: AOAM531m8/7ZzhkV3WEal14GDd2baLtv0GJgl9CH0hNLPLzqz6eCGqLD
 zIhOdyQjS4imiEUzlMuNhLixVA==
X-Google-Smtp-Source: ABdhPJxEM/eWuc6hOMW1CY3bl61h0Z3/m0E+EokTzVraBb7ekuAI0ZADWeIiWkAtj6XjVUx8HIyx/w==
X-Received: by 2002:adf:d089:: with SMTP id y9mr10091800wrh.234.1602177414971; 
 Thu, 08 Oct 2020 10:16:54 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x1sm719413wrl.41.2020.10.08.10.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 10:16:54 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v10 06/10] virtio-iommu: Add notify_flag_changed() memory
 region callback
Date: Thu,  8 Oct 2020 19:15:54 +0200
Message-Id: <20201008171558.410886-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008171558.410886-1-jean-philippe@linaro.org>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, mst@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com, pbonzini@redhat.com,
 bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bharat Bhushan <bbhushan2@marvell.com>

Add notify_flag_changed() to notice when memory listeners are added and
removed.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v10:
* Use notifier flags instead of notifiers_list
* Homogenize tracepoints
---
 hw/virtio/virtio-iommu.c | 14 ++++++++++++++
 hw/virtio/trace-events   |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index d2b96846134..8823bfc804a 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -901,6 +901,19 @@ unlock:
     qemu_mutex_unlock(&s->mutex);
 }
 
+static int virtio_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu_mr,
+                                            IOMMUNotifierFlag old,
+                                            IOMMUNotifierFlag new,
+                                            Error **errp)
+{
+    if (old == IOMMU_NOTIFIER_NONE) {
+        trace_virtio_iommu_notify_flag_add(iommu_mr->parent_obj.name);
+    } else if (new == IOMMU_NOTIFIER_NONE) {
+        trace_virtio_iommu_notify_flag_del(iommu_mr->parent_obj.name);
+    }
+    return 0;
+}
+
 static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1132,6 +1145,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
 
     imrc->translate = virtio_iommu_translate;
     imrc->replay = virtio_iommu_replay;
+    imrc->notify_flag_changed = virtio_iommu_notify_flag_changed;
 }
 
 static const TypeInfo virtio_iommu_info = {
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 16f4729db4b..9108992bcc3 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -109,6 +109,8 @@ virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_t start,
 virtio_iommu_notify_map(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64
 virtio_iommu_notify_unmap(const char *name, uint64_t virt_start, uint64_t virt_end) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64
 virtio_iommu_remap(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64
+virtio_iommu_notify_flag_add(const char *name) "add notifier mr=%s"
+virtio_iommu_notify_flag_del(const char *name) "del notifier mr=%s"
 
 # virtio-mem.c
 virtio_mem_send_response(uint16_t type) "type=%" PRIu16
-- 
2.28.0


