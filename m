Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BD6C4740A
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F8A9222C5
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8A9222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGsFs-0006CS-Hu
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 18:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iGs5A-0004zT-GU
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iGs59-0004Iu-A0
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43858)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iGs59-0004Il-1o
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:19 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 30997A909
 for <qemu-devel@nongnu.org>; Sat,  5 Oct 2019 21:59:18 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id n135so10600607qke.23
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 14:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uyRLkWZIbvOXn6SP4FJI/0STB7Pb+nYILJOnqJPI2nI=;
 b=T+VEkMH+hA8ABIcWRyZ7OepU85RolMFvTpHBvafr++jUKp/OikVLar8Mupcj4PHJOv
 56ZrzqCVfpyrL6dW3n/J6WM7oP1TizrF3T4VJl+CvcvTh8Qm/cz0c5u73GdGjGcs6j78
 BsuWQvucrPqLMBezbNQI+9noAMZfAdJAIW058ng78naajQxXDN5blVy9tyOAsV8e8oIo
 yn+wYcAmOfiEKsh+dMxMaS/fIIp9aH4HXDX0zmpXH/r+7yFYB54k2nq17yaT8ua8NmZV
 bQL7OFrAa3evt6B0izeVqY5bDzdCVjp1wpWcv/1EGsIsa9qRuEooU3F7b+bfuMaH50TF
 jm3g==
X-Gm-Message-State: APjAAAWrMBfdsxA7RncmbABFKRwcJ2linEyIloQqiR5x5FafHaT184w3
 dOCG0XverXjTnSdkEfKX/LtO51HcITLKakr+AyGNxCNMhA/+UFEnRzuoseBbM/69Z44oJQla8Px
 MdNsYcIfkW0vr3XE=
X-Received: by 2002:ac8:7117:: with SMTP id z23mr22587923qto.309.1570312757206; 
 Sat, 05 Oct 2019 14:59:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxkbD+lGUlGDbIP21T/TJ4+JKfsS0gJ9nrFf4Pr2kpezDz/By0Thcendam7bRAQFv3C8tLSzw==
X-Received: by 2002:ac8:7117:: with SMTP id z23mr22587876qto.309.1570312756059; 
 Sat, 05 Oct 2019 14:59:16 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 a36sm5289376qtk.21.2019.10.05.14.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 14:59:15 -0700 (PDT)
Date: Sat, 5 Oct 2019 17:59:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/19] hw/arm/virt-acpi-build: Add PC-DIMM in SRAT
Message-ID: <20190918130633.4872-7-shameerali.kolothum.thodi@huawei.com>
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
 Eric Auger <eric.auger@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20191005215911.GBIvEKv8BzI9VTRqpzFY1YUAhiPnSzokY-B5OG3u6zQ@z>

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Generate Memory Affinity Structures for PC-DIMM ranges.

Also, Linux and Windows need ACPI SRAT table to make memory hotplug
work properly, however currently QEMU doesn't create SRAT table if
numa options aren't present on CLI. Hence add support(>=4.2) to
create numa node automatically (auto_enable_numa_with_memhp) when
QEMU is started with memory hotplug enabled but without '-numa'
options on CLI.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20190918130633.4872-7-shameerali.kolothum.thodi@huawei.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/virt-acpi-build.c | 8 ++++++++
 hw/arm/virt.c            | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index cadeea0f41..c97661ad68 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -546,6 +546,14 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
     }
 
+    if (ms->device_memory) {
+        numamem = acpi_data_push(table_data, sizeof *numamem);
+        build_srat_memory(numamem, ms->device_memory->base,
+                          memory_region_size(&ms->device_memory->mr),
+                          ms->numa_state->num_nodes - 1,
+                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
+    }
+
     build_header(linker, table_data, (void *)(table_data->data + srat_start),
                  "SRAT", table_data->len - srat_start, 3, NULL, NULL);
 }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f926477ba5..d221841c42 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2051,6 +2051,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     hc->plug = virt_machine_device_plug_cb;
     hc->unplug_request = virt_machine_device_unplug_request_cb;
     mc->numa_mem_supported = true;
+    mc->auto_enable_numa_with_memhp = true;
 }
 
 static void virt_instance_init(Object *obj)
@@ -2156,6 +2157,7 @@ static void virt_machine_4_1_options(MachineClass *mc)
     virt_machine_4_2_options(mc);
     compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
     vmc->no_ged = true;
+    mc->auto_enable_numa_with_memhp = false;
 }
 DEFINE_VIRT_MACHINE(4, 1)
 
-- 
MST


