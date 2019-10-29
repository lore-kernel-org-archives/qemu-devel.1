Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506FFCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208F120862
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208F120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPabI-0006Hs-30
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 19:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iPaTW-0008CU-Rn
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iPaTU-0003Ko-Dh
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21623)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iPaTU-0003I3-5r
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:28 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D988944BD1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 23:00:24 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id l32so519445qtk.9
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 16:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0p1pl/3jTXjCPVE2PUOwJIYTROLsHIckcBMVac6VDIo=;
 b=ZRKthAmy9XBYzPdHajb6yhhu+2t0qLPMZG9a+jRaHP550h/fC+xvh0KuCH2BpyPb/i
 iuQ9D1ihsUENO4QqD08MJhMiBgYnVHhqgpIJ9cwwt2d1sa2YSCKr8qaB55/3DJXM6hGl
 l1OWUOLTl2oMZlYMwcrfR3apzcwrQh6+NnqQpix0iJjCR9hm+nrt7lUD+cnh9HOubf+q
 ecOiTKLhxCQM0IverQW1umTm9iMvd5TwzV754R2qUr8T4BQTXZDVBSlVk9AtbQngjg3D
 83NfQzZFFMDb++IQGjm5Qjh8PUyelVpqqllb2gGSRjAU99zamDo/oC3DWdFzzFyWcLsz
 07FQ==
X-Gm-Message-State: APjAAAXKYlMUd6t/S2+SeIUAYhOOyQTjyTbc2+xl/uhrTYqldeCiCW9s
 aFklLNAn8sEv98q5g8bhGakcTwJ9yAByAVmUSZWgb7YR/agPv3z5NyF7VJg+q94OP9avBwxIa6Y
 KF8NLJU8d3OFfxBU=
X-Received: by 2002:a37:a792:: with SMTP id
 q140mr24791444qke.216.1572390023607; 
 Tue, 29 Oct 2019 16:00:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwSKjBf1Pu28wDhkZXfcFxq0Ps0fP+Cp4SlmvJS+GomReNdLQdzqqRVT6RqpkwloT+CwVDaAg==
X-Received: by 2002:a37:a792:: with SMTP id
 q140mr24791419qke.216.1572390023343; 
 Tue, 29 Oct 2019 16:00:23 -0700 (PDT)
Received: from redhat.com (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id p54sm200944qta.39.2019.10.29.16.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 16:00:22 -0700 (PDT)
Date: Tue, 29 Oct 2019 19:00:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/14] pci: mark devices partially unplugged
Message-ID: <20191029225932.14585-4-mst@redhat.com>
References: <20191029225932.14585-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029225932.14585-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jens Freimann <jfreimann@redhat.com>

Only the guest unplug request was triggered. This is needed for
the failover feature. In case of a failed migration we need to
plug the device back to the guest.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Message-Id: <20191029114905.6856-4-jfreimann@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie.c        | 3 +++
 include/hw/pci/pci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index a6beb567bd..19363ff8ce 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -456,6 +456,9 @@ static void pcie_unplug_device(PCIBus *bus, PCIDevice *dev, void *opaque)
 {
     HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(DEVICE(dev));
 
+    if (dev->partially_hotplugged) {
+        return;
+    }
     hotplug_handler_unplug(hotplug_ctrl, DEVICE(dev), &error_abort);
     object_unparent(OBJECT(dev));
 }
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 69d1f0228b..db75c6dfd0 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -265,6 +265,7 @@ typedef struct PCIReqIDCache PCIReqIDCache;
 
 struct PCIDevice {
     DeviceState qdev;
+    bool partially_hotplugged;
 
     /* PCI config space */
     uint8_t *config;
-- 
MST


