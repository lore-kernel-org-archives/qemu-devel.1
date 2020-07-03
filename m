Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90886C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7CA208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YI000V4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7CA208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOy6-0006M1-Id
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOx5-0004WI-Ko
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:15 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:37376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOx3-0005eJ-JF
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:15 -0400
Received: by mail-wm1-x332.google.com with SMTP id o2so34724247wmh.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=UmfUqdz533axEYBvzdXLChRzYDtVznAZewi3we7ufag=;
 b=YI000V4PXmcecu3NTOaXgqVUj58QkGSH1rllGbMSzOiOFhbXC5v84neUxzQgJ++pE+
 prmE3lIxijqHt7B+uqcEGURmctdtmUzqMriLWbkeQQ0MHF1Xeqp7x8+WIIIXmF60d6/p
 o2i3OkshQpnUsTrq0qrV9VIyEtwPmLhk5VUl1gzzsWVp3QfPQv4r8/KceklSUW0uxKXh
 vVuQFSLKZLwJqCnKnpMjX5MTbnMzToj4fZvTT5kRIhRSrFIJ6Wb9HPOJrDLh2yVY+TsP
 t+1SU5h/jkBGoIf4mqAkIXs2kNz0V9pXCtn1PUdJRoO8OFouthgKvjoF3OYzZxjpKzbJ
 5QFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UmfUqdz533axEYBvzdXLChRzYDtVznAZewi3we7ufag=;
 b=JXtesrx1uRhGqbFbZioP08JiZ3oACIbbd8h43RdmY3w/9cfCuxP1EMbkZ7kGHCaYT9
 v+wu2QWsZZUPIT2WkPMQnVS4u/LIptXSN8vqECCtfJhK/+ffPh4JMJv7Wk877Fz3HKKu
 hcvglsT+PIhgtGvB4J1Bj4iHFFhSskL6FQSZBPyiMhlL/f5N7OgieGQ2839LFlBAsnaP
 mDCDquYAVWt6nZDjx6p0YHdBfx+RBxNpR0ZkMKERSJKYO+Hwr3/19hufS78H+r1kOjPb
 lnjX1+NoBFFtU2RmpwBFH4PBOfnNz5YtTWf7biuINz+f7IqFPvxTkVwiPqq8qIholjfc
 QPRw==
X-Gm-Message-State: AOAM530urf/RNRgsVZwppiyW8rqCLGqUv9VeC1HFPgQkCPwBwI1S67eK
 H1lvhlSGaVK2PGNAoRN+BoixvtIoMAYcSA==
X-Google-Smtp-Source: ABdhPJwfsCVaOhdHserYXOzt2VxtNdx4gztRSx9PXBi/UBOsXJYUmDXa1LzSqldYb/8c6yIQxdZK4A==
X-Received: by 2002:a1c:1f09:: with SMTP id f9mr39394557wmf.137.1593795251848; 
 Fri, 03 Jul 2020 09:54:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/34] qdev: Introduce DEFINE_PROP_RESERVED_REGION
Date: Fri,  3 Jul 2020 17:53:35 +0100
Message-Id: <20200703165405.17672-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

Introduce a new property defining a reserved region:
<low address>:<high address>:<type>.

This will be used to encode reserved IOVA regions.

For instance, in virtio-iommu use case, reserved IOVA regions
will be passed by the machine code to the virtio-iommu-pci
device (an array of those). The type of the reserved region
will match the virtio_iommu_probe_resv_mem subtype value:
- VIRTIO_IOMMU_RESV_MEM_T_RESERVED (0)
- VIRTIO_IOMMU_RESV_MEM_T_MSI (1)

on PC/Q35 machine, this will be used to inform the
virtio-iommu-pci device it should bypass the MSI region.
The reserved region will be: 0xfee00000:0xfeefffff:1.

On ARM, we can declare the ITS MSI doorbell as an MSI
region to prevent MSIs from being mapped on guest side.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20200629070404.10969-2-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memory.h        |  6 +++
 include/hw/qdev-properties.h |  3 ++
 include/qemu/typedefs.h      |  1 +
 hw/core/qdev-properties.c    | 89 ++++++++++++++++++++++++++++++++++++
 4 files changed, 99 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 7207025bd49..84ee5b7a01f 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -51,6 +51,12 @@ extern bool global_dirty_log;
 
 typedef struct MemoryRegionOps MemoryRegionOps;
 
+struct ReservedRegion {
+    hwaddr low;
+    hwaddr high;
+    unsigned type;
+};
+
 typedef struct IOMMUTLBEntry IOMMUTLBEntry;
 
 /* See address_space_translate: bit 0 is read, bit 1 is write.  */
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 49c6cd24607..944e3f2e0cd 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -19,6 +19,7 @@ extern const PropertyInfo qdev_prop_string;
 extern const PropertyInfo qdev_prop_chr;
 extern const PropertyInfo qdev_prop_tpm;
 extern const PropertyInfo qdev_prop_macaddr;
+extern const PropertyInfo qdev_prop_reserved_region;
 extern const PropertyInfo qdev_prop_on_off_auto;
 extern const PropertyInfo qdev_prop_multifd_compression;
 extern const PropertyInfo qdev_prop_losttickpolicy;
@@ -184,6 +185,8 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
     DEFINE_PROP(_n, _s, _f, qdev_prop_drive_iothread, BlockBackend *)
 #define DEFINE_PROP_MACADDR(_n, _s, _f)         \
     DEFINE_PROP(_n, _s, _f, qdev_prop_macaddr, MACAddr)
+#define DEFINE_PROP_RESERVED_REGION(_n, _s, _f)         \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_reserved_region, ReservedRegion)
 #define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_on_off_auto, OnOffAuto)
 #define DEFINE_PROP_MULTIFD_COMPRESSION(_n, _s, _f, _d) \
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index ce4a78b687a..15f5047bf1d 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -58,6 +58,7 @@ typedef struct ISABus ISABus;
 typedef struct ISADevice ISADevice;
 typedef struct IsaDma IsaDma;
 typedef struct MACAddr MACAddr;
+typedef struct ReservedRegion ReservedRegion;
 typedef struct MachineClass MachineClass;
 typedef struct MachineState MachineState;
 typedef struct MemoryListener MemoryListener;
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 71f8aca7c60..ca7771f3072 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -15,6 +15,7 @@
 #include "chardev/char.h"
 #include "qemu/uuid.h"
 #include "qemu/units.h"
+#include "qemu/cutils.h"
 
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                   Error **errp)
@@ -578,6 +579,94 @@ const PropertyInfo qdev_prop_macaddr = {
     .set   = set_mac,
 };
 
+/* --- Reserved Region --- */
+
+/*
+ * Accepted syntax:
+ *   <low address>:<high address>:<type>
+ *   where low/high addresses are uint64_t in hexadecimal
+ *   and type is a non-negative decimal integer
+ */
+static void get_reserved_region(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    ReservedRegion *rr = qdev_get_prop_ptr(dev, prop);
+    char buffer[64];
+    char *p = buffer;
+    int rc;
+
+    rc = snprintf(buffer, sizeof(buffer), "0x%"PRIx64":0x%"PRIx64":%u",
+                  rr->low, rr->high, rr->type);
+    assert(rc < sizeof(buffer));
+
+    visit_type_str(v, name, &p, errp);
+}
+
+static void set_reserved_region(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    ReservedRegion *rr = qdev_get_prop_ptr(dev, prop);
+    Error *local_err = NULL;
+    const char *endptr;
+    char *str;
+    int ret;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_str(v, name, &str, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    ret = qemu_strtou64(str, &endptr, 16, &rr->low);
+    if (ret) {
+        error_setg(errp, "start address of '%s'"
+                   " must be a hexadecimal integer", name);
+        goto out;
+    }
+    if (*endptr != ':') {
+        goto separator_error;
+    }
+
+    ret = qemu_strtou64(endptr + 1, &endptr, 16, &rr->high);
+    if (ret) {
+        error_setg(errp, "end address of '%s'"
+                   " must be a hexadecimal integer", name);
+        goto out;
+    }
+    if (*endptr != ':') {
+        goto separator_error;
+    }
+
+    ret = qemu_strtoui(endptr + 1, &endptr, 10, &rr->type);
+    if (ret) {
+        error_setg(errp, "type of '%s'"
+                   " must be a non-negative decimal integer", name);
+    }
+    goto out;
+
+separator_error:
+    error_setg(errp, "reserved region fields must be separated with ':'");
+out:
+    g_free(str);
+    return;
+}
+
+const PropertyInfo qdev_prop_reserved_region = {
+    .name  = "reserved_region",
+    .description = "Reserved Region, example: 0xFEE00000:0xFEEFFFFF:0",
+    .get   = get_reserved_region,
+    .set   = set_reserved_region,
+};
+
 /* --- on/off/auto --- */
 
 const PropertyInfo qdev_prop_on_off_auto = {
-- 
2.20.1


