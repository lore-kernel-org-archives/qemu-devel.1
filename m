Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919A3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D1D20786
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPA1VA0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D1D20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCXR-0006Nv-Il
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPX-00020L-PJ; Tue, 16 Jun 2020 10:17:59 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:43353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPW-0006cp-6E; Tue, 16 Jun 2020 10:17:59 -0400
Received: by mail-oo1-xc44.google.com with SMTP id i4so1364902ooj.10;
 Tue, 16 Jun 2020 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+5a+vrjSxlfmXcIjNg9VjuuOpfEW7OK8MY8Z5fA99eo=;
 b=sPA1VA0hWfjbJh5OVahjWiOFCpBsweGKurk81lYML8fTMG9EqEQeKfjt5BRwaSxdGy
 4+Ftv2gG7nEOuQi3G/QwVQAwJIQ5OIZ+WJjw+35dIe3DmOwsrGpB+igA++7HlSNRb7ve
 o4eqZ/hTlChvboKFmV0loYhu+eOEuFiW/8DMkLPzamCNHCIasWky1zCWINSInOj9p0Bg
 OJ3T3Sc2CfZuaidczMh/sg03BzTeYIYYzoCCZx1NHTr4uz7RUwKwMChSlLU4J2sV6agx
 Zwek1irSjFj1hicMR70fnOHf90w2IxP0yHPg+Sf7A2399AtvAHBRaddPbO+iN4aehGqB
 zG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=+5a+vrjSxlfmXcIjNg9VjuuOpfEW7OK8MY8Z5fA99eo=;
 b=Wsq4MTAQa9FqyQL7kkb3IcJKdp2WFbFgAXmzcUMUFmVp6ix5pl1oI50ht8WZqxyejk
 1tCWDexwu1jja7X/CoUWZ22Pc9nW0WB3NskUTOjtUb8dUny5xb8iZnX4ItQkCFQu+cCI
 HUfAB9tNG5xBH6u2DuAEeZKH+YWyTt1HMXux6OkCHFNNoEiGDA7KjEH8micBKAlg5f3M
 cLaIOqphXnpacBdLBvqWXGqZ1jqmFUP2hna6LSAcf6WQYWsjVlQQj5612KJs9rQtOgyp
 e807omMi6N5bn2Kp5FR/QvsjCW9oMjHYfIXCatsUyt+u7SHwByxFGN1Ilh+sn2R7OLe2
 MNEg==
X-Gm-Message-State: AOAM530c3a2D0/G5l+20mUvRJtvBrAcJLkO+mDwW2Ie853bV9CaOGXVb
 7aUHjj08AIXIO5WaORzdnmjYZmFy
X-Google-Smtp-Source: ABdhPJxCKOJd4jeIeoNJCAOFoEMCjZpomM33u7iDdmXSk6iF42Tt8V7yVHwtIlZKhNVKFmERcGWBng==
X-Received: by 2002:a4a:5585:: with SMTP id e127mr2467360oob.47.1592317075859; 
 Tue, 16 Jun 2020 07:17:55 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id n10sm4134197oib.49.2020.06.16.07.17.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:17:55 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/78] virtio-net: delete also control queue when TX/RX deleted
Date: Tue, 16 Jun 2020 09:14:51 -0500
Message-Id: <20200616141547.24664-23-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-stable@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yuri Benditovich <yuri.benditovich@daynix.com>

https://bugzilla.redhat.com/show_bug.cgi?id=1708480
If the control queue is not deleted together with TX/RX, it
later will be ignored in freeing cache resources and hot
unplug will not be completed.

Cc: qemu-stable@nongnu.org
Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Message-Id: <20191226043649.14481-3-yuri.benditovich@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit d945d9f1731244ef341f74ede93120fc9de35913)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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


