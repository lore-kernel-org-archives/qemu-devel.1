Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD7FC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F0B20678
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6OtWzvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F0B20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDx9G-0000Vj-Jm
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLw-0004xH-Qx; Thu, 03 Sep 2020 17:01:04 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLv-0007qK-2y; Thu, 03 Sep 2020 17:01:04 -0400
Received: by mail-oi1-x244.google.com with SMTP id y6so4514878oie.5;
 Thu, 03 Sep 2020 14:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6sopWa3b6iZGsfPhmep7blcBK54TQmJ/CkRAM88fyYE=;
 b=D6OtWzvOyBZyNVF95/oyLszPwT+KpsjiXUqf5If8bU/Qh9imETvmnlLZ5HBTscqARJ
 ib1/jSk1dY74B0l6b9KngunO2f0wpDC2qDGgara55qPNifZlF4K2WCbuHZGd7sQeO62b
 cZyo11JCQKog4m3OtBT++xIs2JJNfh8LmNIeXZT6LR8Q7lbiB0PizCs3yu7pJa1kOvqM
 sRAQwfDQPBUhFDVYleGZC4RT6HjiDK4RMyg2Av0jyRXT6UYD3OVrb5aTn/IpXbwAzv9C
 qtdTB9YpoypGG/G7pzhcsS8AduWxtG6pFjipkTeBosMK9oKfqyDpADDkKZvt37VrjBYD
 ZKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=6sopWa3b6iZGsfPhmep7blcBK54TQmJ/CkRAM88fyYE=;
 b=PCGdQW9I2Bs8kc6Is/x0QXF74xEfeem/D+Q76g1xDc0p30RRQqm6ccWRKUPRuBp8Uh
 06JcOH6wnIkLTG0uHc1JDkYvbZLZ/o2EEWaC5blFBM75vu/cO1fQdl0eJMNKDVanwFiZ
 GgouRplkDJnkhOl865PGiCJb8W3FpSS/b0dLpu04UM/w4gS5Inaxnmgbg2vyZAvagYAl
 TRDqLWUAlp+k3eWr1YkdwoSCNtxkVIKuoob3xG45tYjTH2XCpcMz40bbjUJZTEQfuCdb
 7LYpHzRyGRD3j+xEi4k84wnFrf/LTNWrNCyxM4omXT9d0ThIssjqKfsbiIpkERt922Y9
 iEWw==
X-Gm-Message-State: AOAM530pzpVsPKQAE/y8azGeLVvxt/4FKEWvfOdtfVqz4mQOoIrqzngU
 Pg74ebj//4enax3s9h80bweVw1a4KidAKg==
X-Google-Smtp-Source: ABdhPJwaXRhtMv8BjNSUOl5LHh7UrzWk7yp+3GyL2TEth7DIsNbbgZTJ7QJKGX6/mPSynAQSXDFwzw==
X-Received: by 2002:aca:4b95:: with SMTP id y143mr3410873oia.121.1599166860982; 
 Thu, 03 Sep 2020 14:01:00 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id l23sm766436otk.79.2020.09.03.14.01.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:01:00 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 60/77] virtio-balloon: Prevent guest from starting a report
 when we didn't request one
Date: Thu,  3 Sep 2020 15:59:18 -0500
Message-Id: <20200903205935.27832-61-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x244.google.com
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
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>, qemu-stable@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Based on code review it appears possible for the driver to force the device
out of a stopped state when hinting by repeating the last ID it was
provided.

Prevent this by only allowing a transition to the start state when we are
in the requested state. This way the driver is only allowed to send one
descriptor that will transition the device into the start state. All others
will leave it in the stop state once it has finished.

Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-Id: <20200720175115.21935.99563.stgit@localhost.localdomain>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 20a4da0f23078deeff5ea6d1e12f47d968d7c3c9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio-balloon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index e20f90dad4..a30a0c7bfa 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -466,7 +466,8 @@ static bool get_free_page_hints(VirtIOBalloon *dev)
             ret = false;
             goto out;
         }
-        if (id == dev->free_page_report_cmd_id) {
+        if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED &&
+            id == dev->free_page_report_cmd_id) {
             dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
         } else {
             /*
-- 
2.17.1


