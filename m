Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B906C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:25:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 709F520786
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQPaW9tA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709F520786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCWi-00050p-Me
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPP-0001cD-Ag; Tue, 16 Jun 2020 10:17:51 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPN-0006Zh-Sh; Tue, 16 Jun 2020 10:17:50 -0400
Received: by mail-ot1-x344.google.com with SMTP id k15so16041234otp.8;
 Tue, 16 Jun 2020 07:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=n7B/wh3iwTtyo7VyN7RqN0zDZm9E1OhXpgfK21UOXC8=;
 b=aQPaW9tAw2YZkeFMm0nfTS+qfP/GmG6XHwzbZvRydk61C3pGf18c7UPhBe2r443FPN
 a0xYZATejGGsWplnd2LfjH81j6x8FSlota+LJ+jcyAfMJe3MYgzQN7Vkf8UTkRVDVKfJ
 by+/wg+1uMd7B55JGrcP2ce+4BczPLS/wxJfb4FGBjHceMASFwSbcIRSl6CLaZ0MQqKu
 pg2sxk3Tfa2fEioThbFLlrzHxAI6djZHxF/St0Njgyll287xEjn9jUH3cpgdheW0GIih
 u87CReq8WhDndlC1SYBnvLTsl2zWiIZgftsSawUhtoWBG807QD7QmaYyF16SikmeK6yA
 uOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=n7B/wh3iwTtyo7VyN7RqN0zDZm9E1OhXpgfK21UOXC8=;
 b=K1M5em5ge66juXzmtcfvyBgwbRHQ1Z2h8fPA21T07L8IAZq7sK+noOAg2c8rn7OWMk
 P5zSL8WYKehcO9+LXZmNwBpmfcFVcPaSaHiPXMnkAfNOb6l3nts3F2b3ohYj5j3QI7Z+
 N7HLpMLtMsA0PZH5orDwzoesZEvIGJL8A1oik9EbXozVYwKNvJp8c/8aJjwl05teTm8p
 GSuTylCuHf/drdyhFI1ou1fH5GNjrglGjfE5yz/IwHLkfC6YRuhDkjcX9JVUdiuGsdaY
 BE46LCpmTQYDrwFMck/mXSb1TmqqBg73RG9xKd4dO5d0Ws9z944904VVEuk83GCXy0Gz
 ReZg==
X-Gm-Message-State: AOAM533e+7RX3AB6AuhtV/SX36jqwiPX0TKSIcmmSeUr4jSLyoLo9y5k
 SQse75HRTV6KYiL+oMQ3edURkQZ3
X-Google-Smtp-Source: ABdhPJwKg+xX9CQiekHgGGRXnhTipyam5hAQCYo798Q9SkgQuqngG0+2gPE8BJ9MPYnR6Vs3JBNSDg==
X-Received: by 2002:a9d:4b90:: with SMTP id k16mr2494240otf.69.1592317068096; 
 Tue, 16 Jun 2020 07:17:48 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id 53sm4068150otv.22.2020.06.16.07.17.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:17:47 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/78] virtio-mmio: update queue size on guest write
Date: Tue, 16 Jun 2020 09:14:47 -0500
Message-Id: <20200616141547.24664-19-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x344.google.com
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
Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-stable@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Denis Plotnikov <dplotnikov@virtuozzo.com>

Some guests read back queue size after writing it.
Always update the on size write otherwise they might be confused.

Cc: qemu-stable@nongnu.org
Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-Id: <20191224081446.17003-1-dplotnikov@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 1049f4c62c4070618cc5defc9963c6a17ae7a5ae)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio-mmio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 94d934c44b..1e40a74869 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -295,8 +295,9 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
         break;
     case VIRTIO_MMIO_QUEUE_NUM:
         trace_virtio_mmio_queue_write(value, VIRTQUEUE_MAX_SIZE);
+        virtio_queue_set_num(vdev, vdev->queue_sel, value);
+
         if (proxy->legacy) {
-            virtio_queue_set_num(vdev, vdev->queue_sel, value);
             virtio_queue_update_rings(vdev, vdev->queue_sel);
         } else {
             proxy->vqs[vdev->queue_sel].num = value;
-- 
2.17.1


