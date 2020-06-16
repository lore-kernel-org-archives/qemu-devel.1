Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AC9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:30:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F2720786
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwfQstSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F2720786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCbM-0005WO-9G
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPb-00021l-6v; Tue, 16 Jun 2020 10:18:04 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36658)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPZ-0006dO-Hq; Tue, 16 Jun 2020 10:18:02 -0400
Received: by mail-oi1-x244.google.com with SMTP id a137so19379834oii.3;
 Tue, 16 Jun 2020 07:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HkqpzH1+Uo68RKYymrYdAHIPp0MZsukAdfhLDqHwjIs=;
 b=EwfQstSew8KL4NK09Z518yu8GDl9t9zmAckYTgQjXMDn7Tg+29bKOJSFBBO7bQdVoj
 jcDUwSv0AIAUuuvTPIXSKPnJgXVsva4XgRdkDGqopbROS3iM8mxDMQvZAqB94AGxngLZ
 b5oriJK/nLvFExORBjgMoaS5Sh4XU9IP2+9KLlRkHzmDBqIKR4FKJN21VKTsVUfrNepI
 R3vByrFguOwOrstR5Zgs7E5NsxixviKB3jryCgz5ynKkf8HoMNybrMWDvT762ehCO3Vb
 k8ETvhOxaKjXRNhZdEZnM8hqrdfrBFHepirSz7WKlgj+7S8hg/bK4kcdfHUC0hXtWllG
 0Nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=HkqpzH1+Uo68RKYymrYdAHIPp0MZsukAdfhLDqHwjIs=;
 b=KLfOcyd/oGlbvbcfGcAZ5Aw4VUZDqStoqirLUCcN8MoHrRyQ4A75hd0Y8ktr4Lmq1j
 ZoUi+5zHMQA6SmCGbCbEZ7lm+9IOfRPwecAnuqhEe2V9tDrIElOlL8VeDJg7BJPi8BKg
 FZAHp0hNVsVQHPkNEArtPGmk4GgZAQAE4GZSt7fnbY2LR8aEWnQs8xBnndzCKwDRW0j3
 SMKhbVm0/ui88D+UcE4sIVsXBBrZHegPbtGUJyS3Qj7OY+5Ab9k277SDwIEEfbfb37cs
 /F5O/g2SNZf2fnSaFsxIjJ4mj3g6aRu6ui9lbwA2jsasxw0mZuDHJ6S/CQa2PWzIlXhT
 K8fA==
X-Gm-Message-State: AOAM533vIBLSMsRVbOzP2Ho1DzYkzAYZiEa17b57NfuSAkymGPhZfviE
 qC9xInSlW9wC1NzNH2awoCq75wNG
X-Google-Smtp-Source: ABdhPJzHTowX2UqIdPR3uRtY0MmWG8VNl69iGHoFcjzeX+eEGgahGE7uuKxAGdjE1gpQFHCWW3/MPA==
X-Received: by 2002:aca:5dd5:: with SMTP id r204mr3635419oib.80.1592317079717; 
 Tue, 16 Jun 2020 07:17:59 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id j46sm4046019ota.69.2020.06.16.07.17.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:17:58 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/78] vfio/pci: Don't remove irqchip notifier if not
 registered
Date: Tue, 16 Jun 2020 09:14:54 -0500
Message-Id: <20200616141547.24664-26-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x244.google.com
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-stable@nongnu.org,
 Peter Xu <peterx@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

The kvm irqchip notifier is only registered if the device supports
INTx, however it's unconditionally removed.  If the assigned device
does not support INTx, this will cause QEMU to crash when unplugging
the device from the system.  Change it to conditionally remove the
notifier only if the notify hook is setup.

CC: Eduardo Habkost <ehabkost@redhat.com>
CC: David Gibson <david@gibson.dropbear.id.au>
CC: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-stable@nongnu.org # v4.2
Reported-by: yanghliu@redhat.com
Debugged-by: Eduardo Habkost <ehabkost@redhat.com>
Fixes: c5478fea27ac ("vfio/pci: Respond to KVM irqchip change notifier")
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1782678
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
(cherry picked from commit 0446f8121723b134ca1d1ed0b73e96d4a0a8689d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/vfio/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 2d40b396f2..337a173ce7 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3076,7 +3076,9 @@ static void vfio_exitfn(PCIDevice *pdev)
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
-    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
+    if (vdev->irqchip_change_notifier.notify) {
+        kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
+    }
     vfio_disable_interrupts(vdev);
     if (vdev->intx.mmap_timer) {
         timer_free(vdev->intx.mmap_timer);
-- 
2.17.1


