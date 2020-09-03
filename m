Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6247BC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243FF206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVmjv4JT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243FF206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDweE-0007xB-4t
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwL6-0003fV-Hi; Thu, 03 Sep 2020 17:00:12 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwL4-0007Qq-PH; Thu, 03 Sep 2020 17:00:12 -0400
Received: by mail-oi1-x242.google.com with SMTP id 3so4556972oih.0;
 Thu, 03 Sep 2020 14:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Ao54A2l3sEDR87eadYmmagGboLEhBAQddrGqeoropng=;
 b=YVmjv4JTEGL/h+upO6IEHC9LgSD2LGBd3A+olh3cyamWjlDE/gYCRbuyeH9dIJE22y
 BwmX18z/mn886P3Zlmx+69kQmLy7DQHSassAx59XW1DJkAnkYRzj/23w2QpOqO9emK0K
 7DdAX7ZPV/q/OmXDH+on4+fVTqZx0nWsVucEc4RFa4HyAAQQV0XaIzNXAVpFfK11vb3v
 Je/aQkTK1gossZzcNAs34dLnxBrAagjO6wtkSQlfgYbR1sTxXy98OZcdTzOsj1xNeKGL
 IVL+rpxn8vjsoYLG+DO5JiyxUCM4u4f9dBqdtAQQYnANhnb6MI5A2zAwCMajmeRd6JAw
 Nv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Ao54A2l3sEDR87eadYmmagGboLEhBAQddrGqeoropng=;
 b=rnIYxOrUo/HqHbCM/0lArYQzNsDOVfEUnXxKrW53G3bfx5QQfiSGE17RJuVc5HXf5T
 Id3JNpXWOSgg0UFBe2L2S18c7LDS4DfC0xSDu8tj7jUUcQJGQmDCjUN6+3lUwURo2Tzd
 QX92xamv2mH33HvuBTENCbbpUXS3HkP06dxUIaNQ3tUN63x66d6toKMRgEEHff6SFUV+
 fUdQoKWIf7j4d33wH+QX4WRIgTOU1AYcnMo6HKKrrvKThfzm/Xj7sQ1PL1rTXqAsAV3s
 gmOwusmPLyluX3t4tFejQSUx4Hr6ei7hZYp7pX+TqUQVbkP580xnQCK0HMj1ZTjCJ36h
 aFxA==
X-Gm-Message-State: AOAM530fN2YzK0pviU+fTIfPlCg6a3lKksjsgH4LWJkaM24UnXkGule8
 FkmIw3HFs6tyk9YW0qW1jyztHme/pHY=
X-Google-Smtp-Source: ABdhPJxERucEeDRW5rSOp26hNeioQKx56W85NQY1JaYp/plQk11AdrrsPd+5n2lpZwdrrdxchp0tEQ==
X-Received: by 2002:aca:5e82:: with SMTP id s124mr3171775oib.168.1599166809004; 
 Thu, 03 Sep 2020 14:00:09 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id d26sm601073otl.10.2020.09.03.14.00.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:08 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/77] net: use peer when purging queue in
 qemu_flush_or_purge_queue_packets()
Date: Thu,  3 Sep 2020 15:58:40 -0500
Message-Id: <20200903205935.27832-23-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Wang <jasowang@redhat.com>

The sender of packet will be checked in the qemu_net_queue_purge() but
we use NetClientState not its peer when trying to purge the incoming
queue in qemu_flush_or_purge_packets(). This will trigger the assert
in virtio_net_reset since we can't pass the sender check:

hw/net/virtio-net.c:533: void virtio_net_reset(VirtIODevice *): Assertion
`!virtio_net_get_subqueue(nc)->async_tx.elem' failed.
#9 0x55a33fa31b78 in virtio_net_reset hw/net/virtio-net.c:533:13
#10 0x55a33fc88412 in virtio_reset hw/virtio/virtio.c:1919:9
#11 0x55a341d82764 in virtio_bus_reset hw/virtio/virtio-bus.c:95:9
#12 0x55a341dba2de in virtio_pci_reset hw/virtio/virtio-pci.c:1824:5
#13 0x55a341db3e02 in virtio_pci_common_write hw/virtio/virtio-pci.c:1252:13
#14 0x55a33f62117b in memory_region_write_accessor memory.c:496:5
#15 0x55a33f6205e4 in access_with_adjusted_size memory.c:557:18
#16 0x55a33f61e177 in memory_region_dispatch_write memory.c:1488:16

Reproducer:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg701914.html

Fix by using the peer.

Reported-by: "Alexander Bulekov" <alxndr@bu.edu>
Acked-by: Alexander Bulekov <alxndr@bu.edu>
Fixes: ca77d85e1dbf9 ("net: complete all queued packets on VM stop")
Cc: qemu-stable@nongnu.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 5fe19fb81839ea42b592b409f725349cf3c73551)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 net/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/net.c b/net/net.c
index cbeeeadff8..4c62b10acd 100644
--- a/net/net.c
+++ b/net/net.c
@@ -610,7 +610,7 @@ void qemu_flush_or_purge_queued_packets(NetClientState *nc, bool purge)
         qemu_notify_event();
     } else if (purge) {
         /* Unable to empty the queue, purge remaining packets */
-        qemu_net_queue_purge(nc->incoming_queue, nc);
+        qemu_net_queue_purge(nc->incoming_queue, nc->peer);
     }
 }
 
-- 
2.17.1


