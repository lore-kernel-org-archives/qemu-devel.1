Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8F2C47404
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1492222C5
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1492222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGsDQ-0003Vt-Dy
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 18:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iGs5E-00055V-U7
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iGs5D-0004Mj-P9
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48736)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iGs5D-0004MQ-HX
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:23 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AABEBC057E9F
 for <qemu-devel@nongnu.org>; Sat,  5 Oct 2019 21:59:22 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id z25so10954732qtn.7
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 14:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SUyF0PLrm/dHKzrupq/qj52QX6pdiQds0A61/QBn86A=;
 b=YcsIgz7pY3y0LAvk2vtDBiIO+g1Oo2Q+WMXW5/WbbLI6+pR6BYRheL53R3qoKL6x8T
 6s6QNFZv87r/G9v0Rw+0aQ8/b3C88n3+BHLU8ModrGpKiNgOgI/3weT0dDJOdb0aiwbS
 OZj4nAXnlTqe2HKB8AtTNJurbEzrFRkMpgjVNlSIv+pUoRpBT6pBW4QeAxmSQdt/N0tU
 75ECHGDTQ0wOXQK+d8JTaxNjrcM+AnooSRlEFBW4crATYnIK45im3kVxuZrEbM8gZM6p
 pe069SIapGWrnTllzGMfZ3H1H6jvAV6G2KyCX/+BpyBShEbArsjLiH9a0Bg90Cown4hd
 M0QQ==
X-Gm-Message-State: APjAAAXJTpBTzBXZJwnQzNkbExBuwZto0Hn81Zk7wI9CbkzqO3ncIZnN
 SYTgNhXODaB3/+mos1q2MxB7htNb5pvLk2L+UVVj+/Wc4roPEjnw2zZMmgVdOhsbOxU/OowCeTb
 t3wzHHROscyi9teg=
X-Received: by 2002:a37:82c1:: with SMTP id
 e184mr17700891qkd.206.1570312761420; 
 Sat, 05 Oct 2019 14:59:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyToreKiDeZaqH7MyFvq1WJ8hLYlmSfLADT1kBv9XPenEODKsiR2XfOmsOMajUU1UvfKOtISQ==
X-Received: by 2002:a37:82c1:: with SMTP id
 e184mr17700878qkd.206.1570312761178; 
 Sat, 05 Oct 2019 14:59:21 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 k2sm4272201qtm.42.2019.10.05.14.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 14:59:20 -0700 (PDT)
Date: Sat, 5 Oct 2019 17:59:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/19] hw/arm: Factor out powerdown notifier from GPIO
Message-ID: <20190918130633.4872-8-shameerali.kolothum.thodi@huawei.com>
References: <20191005215508.28754-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20191005215508.28754-1-mst@redhat.com>
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
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20191005215916.vk4O1q5Bc_pu6zvMOo_xy7ECsxqz13sZN8_nbnN9js8@z>

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

This is in preparation of using GED device for
system_powerdown event. Make the powerdown notifier
registration independent of create_gpio() fn.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20190918130633.4872-8-shameerali.kolothum.thodi@huawei.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/virt.c         | 12 ++++--------
 include/hw/arm/virt.h |  1 +
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d221841c42..dbd8c18f36 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -797,10 +797,6 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
     qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
 }
 
-static Notifier virt_system_powerdown_notifier = {
-    .notify = virt_powerdown_req
-};
-
 static void create_gpio(const VirtMachineState *vms, qemu_irq *pic)
 {
     char *nodename;
@@ -841,10 +837,6 @@ static void create_gpio(const VirtMachineState *vms, qemu_irq *pic)
                           KEY_POWER);
     qemu_fdt_setprop_cells(vms->fdt, "/gpio-keys/poweroff",
                            "gpios", phandle, 3, 0);
-
-    /* connect powerdown request */
-    qemu_register_powerdown_notifier(&virt_system_powerdown_notifier);
-
     g_free(nodename);
 }
 
@@ -1737,6 +1729,10 @@ static void machvirt_init(MachineState *machine)
         vms->acpi_dev = create_acpi_ged(vms, pic);
     }
 
+     /* connect powerdown request */
+     vms->powerdown_notifier.notify = virt_powerdown_req;
+     qemu_register_powerdown_notifier(&vms->powerdown_notifier);
+
     /* Create mmio transports, so the user can create virtio backends
      * (which will be automatically plugged in to the transports). If
      * no backend is created the transport will just sit harmlessly idle.
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 577ee49b4b..0b41083e9d 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -137,6 +137,7 @@ typedef struct {
     int psci_conduit;
     hwaddr highest_gpa;
     DeviceState *acpi_dev;
+    Notifier powerdown_notifier;
 } VirtMachineState;
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
-- 
MST


