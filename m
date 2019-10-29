Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436FCCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:12:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11BAD20862
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BAD20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPaek-0002NQ-2Q
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 19:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iPaTl-00004w-F9
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iPaTk-0003jv-70
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49267)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iPaTj-0003iA-Tn
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:44 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 11E95368CF
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 23:00:43 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id t16so515504qtp.11
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 16:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=P3u+b5+KX9c+8Ms/zyjrjs/OLh7mLvjvMFExc3PU094=;
 b=uksm2K8pWLCj++pz8DdoON0w0ShLS0NlYoX0BUwsy85cPrSb4BBtmGIKTK40ZP1yKN
 rJVXdTR0cZ3Yj2SvoZDgOtOLXbVWMZ7l2a5VoaNUoxK+dfN00lRflgqvJhEpeSe4Hjf6
 rblRezdUoBREANeHSMsU/5UoN0d408zE691HxRdEqCBhpB4qIOEzowWCcobIBFI1x12B
 mOXDWy5H4jDjy0F+w3H3xR/3YsGLvT8UePSvuAlqbIiKL+yU+CsA6I+JhK8NEvVTBkkE
 nnEqrW0sawzJd+T9xnkTksiX7CubINl5Zal0O7xQBiyjiFux40mjW9iPgKBTMc4sb0i6
 MUmw==
X-Gm-Message-State: APjAAAXr5ENZp6DmBWQ/mUQ+f+3YP+zck3eRw7SFdfb3/LyKVJKQA9bz
 yGXprnYlU6puUfLfqZ5p8UPp2EFxBACS/05bqBcrcHMGLuLjbYVR9XVz9bwngmT4vKKwu63dQ3g
 6SJKjfLsefiGfo8U=
X-Received: by 2002:ac8:377d:: with SMTP id p58mr1886485qtb.198.1572390041831; 
 Tue, 29 Oct 2019 16:00:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwcbmEI8nR7pjy43qbmiHSMwu96vGSuhWXER46KICaG8SUuZZjrI0ZXP2jRf3AGNXBZjGFy5Q==
X-Received: by 2002:ac8:377d:: with SMTP id p58mr1886446qtb.198.1572390041415; 
 Tue, 29 Oct 2019 16:00:41 -0700 (PDT)
Received: from redhat.com (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id u27sm280302qtj.5.2019.10.29.16.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 16:00:40 -0700 (PDT)
Date: Tue, 29 Oct 2019 19:00:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/14] migration: allow unplug during migration for failover
 devices
Message-ID: <20191029225932.14585-8-mst@redhat.com>
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
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jens Freimann <jfreimann@redhat.com>

In "b06424de62 migration: Disable hotplug/unplug during migration" we
added a check to disable unplug for all devices until we have figured
out what works. For failover primary devices qdev_unplug() is called
from the migration handler, i.e. during migration.

This patch adds a flag to DeviceState which is set to false for all
devices and makes an exception for PCI devices that are also
primary devices in a failover pair.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Message-Id: <20191029114905.6856-8-jfreimann@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/core/qdev.c         | 1 +
 hw/pci/pci.c           | 1 +
 include/hw/qdev-core.h | 1 +
 qdev-monitor.c         | 2 +-
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 3b8d43d0fd..cf1ba28fe3 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -996,6 +996,7 @@ static void device_initfn(Object *obj)
 
     dev->instance_id_alias = -1;
     dev->realized = false;
+    dev->allow_unplug_during_migration = false;
 
     object_property_add_bool(obj, "realized",
                              device_get_realized, device_set_realized, NULL);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 824ab4ed7b..c68498c0de 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2130,6 +2130,7 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
             pci_qdev_unrealize(DEVICE(pci_dev), NULL);
             return;
         }
+        qdev->allow_unplug_during_migration = true;
     }
 
     /* rom loading */
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 710981af36..1518495b1e 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -156,6 +156,7 @@ struct DeviceState {
     bool pending_deleted_event;
     QemuOpts *opts;
     int hotplugged;
+    bool allow_unplug_during_migration;
     BusState *parent_bus;
     QLIST_HEAD(, NamedGPIOList) gpios;
     QLIST_HEAD(, BusState) child_bus;
diff --git a/qdev-monitor.c b/qdev-monitor.c
index ffa08c670f..e6b112eb0a 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -851,7 +851,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!migration_is_idle()) {
+    if (!migration_is_idle() && !dev->allow_unplug_during_migration) {
         error_setg(errp, "device_del not allowed while migrating");
         return;
     }
-- 
MST


