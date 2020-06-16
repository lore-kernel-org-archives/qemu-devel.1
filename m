Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C950C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C994208B3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxNvlH9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C994208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCuY-0002ER-Bh
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCRF-0004nL-St; Tue, 16 Jun 2020 10:19:45 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:38034)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCRE-00073x-Ab; Tue, 16 Jun 2020 10:19:45 -0400
Received: by mail-oi1-x229.google.com with SMTP id c194so19399823oig.5;
 Tue, 16 Jun 2020 07:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oAWQwscS3hC8ntGZh49aUc7NALi41mqvXu730WQVmJg=;
 b=TxNvlH9hXozskCo1ZGNhRFVOY+L7oacdXXqiliUi/NEx2gsmztZ/2pVbum9ABN8DUe
 nH1vFlTltQIKxaVAOPto/OzgTBAH8i+NrGNFqIzz9U5Te1HpCEOMAXpmMuCxV9sVVLJD
 GHSqSb11h0J43j6x+rYNaquvFrkkNwtwJkQcIfHLCqsnZrTRhSOOa/VDDFEuJ/sFW+BS
 mkXKp8//PyxAqMFYYD/ffhPuOWwpBBzQjlsFqnsdWcRh7lAFHJo7QN5rwAoiJXIWaCRV
 LWzqoGe9yBTAHUMbSHNJKpJtnsl5JRpr/Mg3EOCf3UyjgdrrlHIWmKHlDSunPdITLYoJ
 gdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=oAWQwscS3hC8ntGZh49aUc7NALi41mqvXu730WQVmJg=;
 b=hw9e73tZNnVs/K5nv/k2cNeb7sTrjJQUeYm2+L8Dh0vglfJ6c8wNYCrgdxkD3qRAjU
 63z8nK9tO9W4T1m25Jm+XvvP2CBPEoK/AO3Q8+r2xBo56Fy2dEbjKw9EJFtBUt7EVZ5/
 t+bReYLF0XwGc8PiCnc08Eyx8kplrv4fsSH+wor17RozBsw2ZVezd8NKpOMmMeQ4rljm
 EXnekUHGmIOIxqhYgZNKggZRqR3qPSbtkmbfbXCtaptf/qqWR0x83gDE1MpEZxmDjRIi
 VUOhpceuYGoh7EuLT3T0WM4GYQ0TEmx+y18Od8zNE4DJZrcf/4WJQiqnOJoJLIVT3FuF
 y9tg==
X-Gm-Message-State: AOAM532gBTZBS6B8nxV1tNnIdtPEnmnW1CKPjig8fUYsDHHVhXPxJ3Js
 3Eg93VNQr7V0LiQDs2Fx/Avd2pR+evU=
X-Google-Smtp-Source: ABdhPJzNBbwoWKtR/GV0PYqsijTj+PsJw7vj4XW3lDgdesdIrpe20bkLokAnsS1Jdf1oniNY9AWASQ==
X-Received: by 2002:aca:5a05:: with SMTP id o5mr3359110oib.138.1592317182493; 
 Tue, 16 Jun 2020 07:19:42 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id 53sm4069177otv.22.2020.06.16.07.19.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:19:41 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 76/78] virtio-balloon: fix free page hinting check on unrealize
Date: Tue, 16 Jun 2020 09:15:45 -0500
Message-Id: <20200616141547.24664-77-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x229.google.com
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
index 8c6a177365..64fdd0e332 100644
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


