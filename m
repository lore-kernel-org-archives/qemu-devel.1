Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBE3C31E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:44:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EBBA2084E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inzXWINM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBBA2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49634 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbikd-0002F5-7j
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 05:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40605)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elohimes@gmail.com>) id 1hbieK-0004gq-77
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1hbiZD-0000pL-DA
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:32:16 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hbiZD-0000pF-78
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:32:15 -0400
Received: by mail-pg1-x544.google.com with SMTP id v9so1204125pgr.13
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 02:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dzTNWL7QYHXYrYeoVVUd6Gcm/t/F3nzsiE9MlJaHKkY=;
 b=inzXWINMXCpAmFDZiV2imzYQs4R/vtHlNH/9ByH5fhb52IIVP5nOP+LS0BkfA9TJ5G
 9/0taxQX0YXPqs0nyBbWO3GJVadE+eujzv1918Oh7atkisbezqrK7P4LKONn5e+WIcNI
 VtcT82HHmcbbMl9WvGnK/Xhr90r4x2PZ8wBIyANzE9s/zwjNznTnEp5pLbl+75hBJIT/
 z+oFxGPqRdbgfXtzxAsW2vQxeEagV54E9+xH2UL1LPoPqXGnxCCarV4QLdBnd12c0Qy4
 NLgSoA68HYDHjs3fVVUwf2k9zTpTpGwMp3tNIDtUXku7TiJzNlbs9CS1vaGuh1PQZ6vx
 Bwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dzTNWL7QYHXYrYeoVVUd6Gcm/t/F3nzsiE9MlJaHKkY=;
 b=Uk3GoZbY715dNf72TN/T0JbezJzrj1q64QP1b1MgDNlxqbXuUIoeT8NdW9xgCU0g5x
 vhzkOsxmqHVf+W0zNZqc7R5sWKC8dU0xVp0E+R0rGBfByZxnI3bmTnIb5fMA6EOs1kWX
 KLIJyF8RKSqLZb+jsdjTBt+8FWCkcr7JQ6Gw3U1aSuoeHK9D0S1cbR/IKyGsNuYWuDjq
 yY7lYrQFv+7MWY8uKKKuCf7O21aEa2ATMwexkOV6c7RyKl0jVmByOog2ZYfUGgtjofJw
 pO2N3Yp82cEHSS2xSbY1mAcN5y5qZu0fSGZWoidZptqCe4mVIcvrsQ9gE8SgY6UxPa91
 S5Pg==
X-Gm-Message-State: APjAAAUTJTKlHh71Ur7rYdeKSWM2ldocdL158fXSCvDwl0aZoc+peBqS
 UJ0STSztiUyRL/kfrscKJRc=
X-Google-Smtp-Source: APXvYqyQwF9C1bku9mPv3UA6kcin3IDwL9/gMImtinrEIL9CwSLIaUpU3ADaKu4X5kQ617Jh7PTj9g==
X-Received: by 2002:a17:90a:2244:: with SMTP id
 c62mr10336832pje.29.1560504734518; 
 Fri, 14 Jun 2019 02:32:14 -0700 (PDT)
Received: from localhost ([116.247.112.152])
 by smtp.gmail.com with ESMTPSA id f11sm8113834pjg.1.2019.06.14.02.32.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 14 Jun 2019 02:32:14 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com,
	groug@kaod.org
Date: Fri, 14 Jun 2019 17:31:20 +0800
Message-Id: <20190614093121.5580-5-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614093121.5580-1-xieyongji@baidu.com>
References: <20190614093121.5580-1-xieyongji@baidu.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v3 4/5] virtio: Make sure we get correct state
 of device on handle_aio_output()
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
Cc: qemu-devel@nongnu.org, Xie Yongji <xieyongji@baidu.com>,
 dgilbert@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

We should set the flags: "start_on_kick" and "started" after we call
the kick functions (handle_aio_output() and handle_output()).

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
---
 hw/virtio/virtio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 034320d277..b4301f9e02 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1571,10 +1571,10 @@ void virtio_queue_notify(VirtIODevice *vdev, int n)
         event_notifier_set(&vq->host_notifier);
     } else if (vq->handle_output) {
         vq->handle_output(vdev, vq);
-    }
 
-    if (unlikely(vdev->start_on_kick)) {
-        virtio_set_started(vdev, true);
+        if (unlikely(vdev->start_on_kick)) {
+            virtio_set_started(vdev, true);
+        }
     }
 }
 
-- 
2.17.1


