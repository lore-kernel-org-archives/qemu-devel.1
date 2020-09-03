Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF72C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:37:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D473420665
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3pXJs7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D473420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwvY-0000KE-Va
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwMO-0005Z8-R0; Thu, 03 Sep 2020 17:01:32 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:35611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwMN-0007xh-0E; Thu, 03 Sep 2020 17:01:32 -0400
Received: by mail-ot1-x332.google.com with SMTP id i4so4040025ota.2;
 Thu, 03 Sep 2020 14:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QR57nNbf5eNvk41+1C7VvpA6VmcUymk4wbFzEUFu1zg=;
 b=p3pXJs7FrDAE1Oz2N+61RF9BmW0fa8GnxsGi/m4hR9VNNURiQbAvfFBxRAeX5SyM+U
 YiU0v4Nu5WKxPuAQPAzArVL92qj6Z1v+m5CE8kiXc/d+hqXRCWd0TPYR4Luugo2+byQO
 v6ybHO8VE505RyffdTr9268YfA+8HRHAoR8JuJdrvzWemMqAOb8ifGO6BAyfKlo+B94E
 4I3UlJswYjq/4C9uDFQOatgcoEezCF1Jv3ipltNt9qdQ2mKGb+BKdykC/VfjJ6k+qKsD
 9qJs26uOMj35aTi8NVoqhSKa6e5RRm9/GlK9O7DzwUFnMiR6uvTAt2ZqfoTIJNQufMFw
 YGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QR57nNbf5eNvk41+1C7VvpA6VmcUymk4wbFzEUFu1zg=;
 b=DA3unmZvO5X/s+bFE6Y+vn7A9HVGZWV4cuSxLk1vwGMVkfJwTy7h486raDU5iHBI6/
 TC/uQifi4QVPOjAwoQZio7Zw1szFSlvLA1XLB1NR0DJ2mbKSKdzlSvJYbz6Ctr+3aHdZ
 WQx1oQvf9qVTwXWqS3iX9Dia8yGhkxFpJfU6CIgVcx1H6KAziCa/ggbD+rVfgLx1H9bS
 8CfuuFGTb7/5a3Iq9hzCNQxHqe5eJrUClJfnVGG4aJhP57ydQo/oU9jA/cZmW2vuuJ2U
 rBiiylYvrxRCa0Rkg3yEFj/KvYIrpG6aFF09txM47eWPIQgwbsR2d98xkXDu2KfOkkWK
 cggg==
X-Gm-Message-State: AOAM531AG1r0ica1EEV+Llu2T2cPMKZM+uHp+D0RljxUQ2NutGX/Wh2d
 4lDhRljz01pXcLO2tmhEG9RJBhZP6nX5gg==
X-Google-Smtp-Source: ABdhPJw74MLZYytGzCizOaNATDZund5++b/KtEEAfk/3BmsrG88QG63TxHMFFKs47dKreIeZ+cFEQw==
X-Received: by 2002:a9d:4d0:: with SMTP id 74mr3171113otm.119.1599166889287;
 Thu, 03 Sep 2020 14:01:29 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id t4sm766376otc.24.2020.09.03.14.01.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:01:28 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/77] virtio-balloon: fix free page hinting check on unrealize
Date: Thu,  3 Sep 2020 15:58:26 -0500
Message-Id: <20200903205935.27832-9-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x332.google.com
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-stable@nongnu.org,
 Alexander Duyck <alexander.duyck@gmail.com>, Wei Wang <wei.w.wang@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Checking against guest features is wrong. We allocated data structures
based on host features. We can rely on "free_page_bh" as an indicator
whether to un-do stuff instead.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Cc: qemu-stable@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200520100439.19872-3-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 49b01711b8eb3796c6904c7f85d2431572cfe54f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio-balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index ef499e1b3b..3e3b5ff0f8 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -818,7 +818,7 @@ static void virtio_balloon_device_unrealize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOBalloon *s = VIRTIO_BALLOON(dev);
 
-    if (virtio_balloon_free_page_support(s)) {
+    if (s->free_page_bh) {
         qemu_bh_delete(s->free_page_bh);
         virtio_balloon_free_page_stop(s);
         precopy_remove_notifier(&s->free_page_report_notify);
-- 
2.17.1


