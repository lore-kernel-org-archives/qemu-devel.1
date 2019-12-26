Return-Path: <SRS0=LSdK=2Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9FBC2D0C0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 04:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6DE2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 04:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="BqZJWxaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6DE2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ikKv8-0002NR-1F
	for qemu-devel@archiver.kernel.org; Wed, 25 Dec 2019 23:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ikKtQ-0000AV-P7
 for qemu-devel@nongnu.org; Wed, 25 Dec 2019 23:37:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ikKtP-0002tZ-Bk
 for qemu-devel@nongnu.org; Wed, 25 Dec 2019 23:37:00 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1ikKtP-0002t3-5q
 for qemu-devel@nongnu.org; Wed, 25 Dec 2019 23:36:59 -0500
Received: by mail-wr1-x441.google.com with SMTP id z3so22819671wru.3
 for <qemu-devel@nongnu.org>; Wed, 25 Dec 2019 20:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YtUVsfYfPI32c80SGOAiyBMd/9ynOy9lw1vc9As+J08=;
 b=BqZJWxajH6ROdydX7EYEwrlQ8jSQL79WW2XjmQNV/SWH0JfYy2dzHdOc1X9rBLiJtj
 OEHJSCztzVwTaZSVp3+L4mhFjM2U4rGP9xcVEM65wHHN+an1vsXeM1fr+lGjkmnWCaWW
 glN53a5nhkLcF+piRVY8wOvtvlEF11pxcl6PlmfJcGs3rGwDl5LnXxRvnUQwVoSAon52
 PzTpQXyMOU0RW7AoBGmsr0o+nyWKEIVqyuOMuu+35AS460nZ7wJZCvFcry6XKUzQFomS
 b5zigwX1BhA2E2neMiC1H+V5v3Y/wXIOJSyheu7AqIw5C7/gftplzU2C13iO4fi9q5Qx
 1kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YtUVsfYfPI32c80SGOAiyBMd/9ynOy9lw1vc9As+J08=;
 b=YzZoBq30FGPyNoJNnFnM9g/Gaw27qHDRXPCY4f9ZLYZL2R2x7+7fWLJ32QScfI+oMA
 E/HFgOjpe0o4jEx3S8FPvHUnLPPRH96ShSkdAjebnFD2cgIHlnIP4EMlCytF1G3Okg4z
 luOvifxX8KpTxXzPOVV5iwO0CHLH2SFnC99l3+yajt3ksi9peqIaxVM8WZTGzCpqjHHX
 YjG7XYrb0eYS40HBgp66ryaVL+kPg7RpTBKRXjUP6I7xFVdQVtLEbOZwTozzn5fODkpa
 AyRCi13nHIuWyHHQZ+8NDnJqMTp1xqk7nU25eEA4PGV6ylATQbkl/LOIrjADryi6/lfN
 0gew==
X-Gm-Message-State: APjAAAWmYsHKY1oQCTTOL1C4fztjpHC0bIUK+I/taHtHqmMSPSEzwY0k
 zZpAz7i0D189wCWR1DYI8Tf/Tw==
X-Google-Smtp-Source: APXvYqyLBhd5NfXP9oNc9d+bZVOqm62zi5BuCfLtRl6g4V/Gij3u12N1FrZ4Yj95j7roYACYL4lKlA==
X-Received: by 2002:a5d:4847:: with SMTP id n7mr43129899wrs.30.1577335018238; 
 Wed, 25 Dec 2019 20:36:58 -0800 (PST)
Received: from f2.redhat.com (bzq-79-182-106-171.red.bezeqint.net.
 [79.182.106.171])
 by smtp.gmail.com with ESMTPSA id a1sm29428800wrr.80.2019.12.25.20.36.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 25 Dec 2019 20:36:57 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] virtio-net: delete also control queue when TX/RX deleted
Date: Thu, 26 Dec 2019 06:36:49 +0200
Message-Id: <20191226043649.14481-3-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191226043649.14481-1-yuri.benditovich@daynix.com>
References: <20191226043649.14481-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://bugzilla.redhat.com/show_bug.cgi?id=1708480
If the control queue is not deleted together with TX/RX, it
later will be ignored in freeing cache resources and hot
unplug will not be completed.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/net/virtio-net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index db3d7c38e6..f325440d01 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3101,7 +3101,8 @@ static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
     for (i = 0; i < max_queues; i++) {
         virtio_net_del_queue(n, i);
     }
-
+    /* delete also control vq */
+    virtio_del_queue(vdev, max_queues * 2);
     qemu_announce_timer_del(&n->announce_timer, false);
     g_free(n->vqs);
     qemu_del_nic(n->nic);
-- 
2.17.1


