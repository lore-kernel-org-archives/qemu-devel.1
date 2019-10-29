Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F32CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C4F720862
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4F720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPaWE-0001ex-C0
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 19:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iPaTa-0008Ek-0C
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iPaTY-0003P6-TD
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iPaTW-0003MG-Pa
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:30 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5EE2A6AAEA
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 23:00:29 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id 125so257816qkj.12
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 16:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FA5/lZk6lCS/6yerSfbbf7h1FFYnvdpxuf5qIw8oeJs=;
 b=S0ntEtBuZQr34OrEIpJj213WQNyTTbKMm1NQQvwCtLwJ0U2vCgktIT7uA1vsBTvKoo
 OzhQ0suoWiKlumPerTVjWfB/4YekUPIFSy2V3pR92NpnG5eNBmLeHuJQlCmbWfZdulp7
 a144kzwWZ7h/ec4bUJ2vBAhtuHY1SUyFN2131EhA3rPjn5Ci+FWCCP3MiE3/wb31CBCw
 YhQnZ9jrYsCOLQofKG3wcvISNuWF+9DIToFYEGq0JhHy/w5ZzdfLGVgcdUUOegkq3R/s
 GN/Io9qi47IgdOVbzNbLsZjJ6QsrQxSa456YJy0vaCQWpIZPsy6pFXQ0tasfdgfnvGJy
 zNZw==
X-Gm-Message-State: APjAAAWZs5c+NfI/aY3LAb6u4RnE78m+R5me4nlqmJT5VuLehun5OQjM
 HbkG56udQoEHcFR/siGgo0u9+0FsdcY6nW0WEWESJ64rPbm3L1rPJa33LkQAa5vilwZj+bfBRND
 f079iYufZ5xj+/Wg=
X-Received: by 2002:a0c:f4d2:: with SMTP id o18mr26307281qvm.100.1572390028168; 
 Tue, 29 Oct 2019 16:00:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxP5SguC9C8aiSQ1AqL2MM2XRiuj5MEnCf2QVm5/phGVMmBoCNsBVbiZ1b1OI3urtaGqH/DMQ==
X-Received: by 2002:a0c:f4d2:: with SMTP id o18mr26307249qvm.100.1572390027902; 
 Tue, 29 Oct 2019 16:00:27 -0700 (PDT)
Received: from redhat.com (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id t58sm98238qta.78.2019.10.29.16.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 16:00:27 -0700 (PDT)
Date: Tue, 29 Oct 2019 19:00:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/14] pci: mark device having guest unplug request pending
Message-ID: <20191029225932.14585-5-mst@redhat.com>
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

Set pending_deleted_event in DeviceState for failover
primary devices that were successfully unplugged by the Guest OS.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Message-Id: <20191029114905.6856-5-jfreimann@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 19363ff8ce..08718188bb 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -457,6 +457,7 @@ static void pcie_unplug_device(PCIBus *bus, PCIDevice *dev, void *opaque)
     HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(DEVICE(dev));
 
     if (dev->partially_hotplugged) {
+        dev->qdev.pending_deleted_event = false;
         return;
     }
     hotplug_handler_unplug(hotplug_ctrl, DEVICE(dev), &error_abort);
@@ -476,6 +477,8 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
         return;
     }
 
+    dev->pending_deleted_event = true;
+
     /* In case user cancel the operation of multi-function hot-add,
      * remove the function that is unexposed to guest individually,
      * without interaction with guest.
-- 
MST


