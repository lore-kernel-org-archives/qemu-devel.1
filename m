Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8CDC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5675B21556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VP0Wgw5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5675B21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZkZ-0003UV-D7
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlP-00023Y-54
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlN-0001ux-6c
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:34 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55383)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlN-0001qo-0M
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:33 -0500
Received: by mail-wm1-x343.google.com with SMTP id q9so2668462wmj.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Zqti9v7NLc0Q8SK8su+w/Ql2R0UL62zwfemjVtxfoQM=;
 b=VP0Wgw5dgZqEt39VylRN84JQpCYvwbhZWnl6lyZkKWi8OSL+mY4lsNWbgguDS73BOy
 cThsexK5mAYS0iHcVBw83XSXDYUzC3oV9OEkzUB6XG9ozEuIeIXKhl1H5S1tbqS3Jf8+
 6+oxN1KwV3cANggy6KIKqnCZYbyHGxKL599Jxiyax6zURDH2aUfy/h35urScs+eYxIYJ
 rG8/RKmIvgm2wJTa4zsTJu/pzQj0fbOp+6rKa0HJWrsTXeUK2zxRlY/ieVK3Xr1N70a8
 OB1anEBVt9DlJWlp8khGukM1YrkJ4VCyOXOuO0g/73oZkzPjXQZpMGXbLL1K4wh9UMUk
 0FMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Zqti9v7NLc0Q8SK8su+w/Ql2R0UL62zwfemjVtxfoQM=;
 b=UHoSYMbG0sdlsiJEtadi0x8/xAY5kAXWRnb37jTxKZ/o6yvEbCPrWdtK90V204Au00
 h9YoVVio+qgHXD3UDUu0BLTUE2m4DLcpKJE1yG1TrCtVD62Cx8NHb1jFC7of7AQH5WaM
 SvG4PhErkmMtBBli3XkUY4flANxlnBB0FYyhnxCjRS4BLQzU5bFiBvnbRByJ0AYWOn01
 rVhdVV8IDS3GpbmQ+SzqybsZCF9YTiWaMGGeZ8WEoy3SXwSR1D2ItjLdlVKnHbnEut3e
 Rv25knXAgbRH0NCGASRc5VKO5n4/qnlExBSMeiZxwmI41d87+g8KuSmmoQqUoiyebKLT
 v/fg==
X-Gm-Message-State: APjAAAVIALIWAiL7YHpRu1YeweYa4nsHhJHYQCYu3ogvBKbAJ3LxjD9W
 Np1bD31FjYIMCw1t+dhcGDoiRaX9
X-Google-Smtp-Source: APXvYqyvWVtPamhL2HJigXbm4jVbKEqCzLgmUQC7zm6fP56uYTrw4XBSuKA5G04rbDcxjzZbmJlP+w==
X-Received: by 2002:a7b:cf08:: with SMTP id l8mr4826980wmg.169.1582631551704; 
 Tue, 25 Feb 2020 03:52:31 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 092/136] hw/virtio: Let vhost_memory_map() use a boolean
 'is_write' argument
Date: Tue, 25 Feb 2020 12:50:22 +0100
Message-Id: <1582631466-13880-92-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The 'is_write' argument is either 0 or 1.
Convert it to a boolean type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/virtio/vhost.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 9edfadc..0d226da 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -294,7 +294,7 @@ static int vhost_dev_has_iommu(struct vhost_dev *dev)
 }
 
 static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
-                              hwaddr *plen, int is_write)
+                              hwaddr *plen, bool is_write)
 {
     if (!vhost_dev_has_iommu(dev)) {
         return cpu_physical_memory_map(addr, plen, is_write);
@@ -1012,21 +1012,21 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
 
     vq->desc_size = s = l = virtio_queue_get_desc_size(vdev, idx);
     vq->desc_phys = a;
-    vq->desc = vhost_memory_map(dev, a, &l, 0);
+    vq->desc = vhost_memory_map(dev, a, &l, false);
     if (!vq->desc || l != s) {
         r = -ENOMEM;
         goto fail_alloc_desc;
     }
     vq->avail_size = s = l = virtio_queue_get_avail_size(vdev, idx);
     vq->avail_phys = a = virtio_queue_get_avail_addr(vdev, idx);
-    vq->avail = vhost_memory_map(dev, a, &l, 0);
+    vq->avail = vhost_memory_map(dev, a, &l, false);
     if (!vq->avail || l != s) {
         r = -ENOMEM;
         goto fail_alloc_avail;
     }
     vq->used_size = s = l = virtio_queue_get_used_size(vdev, idx);
     vq->used_phys = a = virtio_queue_get_used_addr(vdev, idx);
-    vq->used = vhost_memory_map(dev, a, &l, 1);
+    vq->used = vhost_memory_map(dev, a, &l, true);
     if (!vq->used || l != s) {
         r = -ENOMEM;
         goto fail_alloc_used;
-- 
1.8.3.1



