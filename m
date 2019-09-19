Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94C4C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:02:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B6E218AF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fu416awU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B6E218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4VE-0007SU-K8
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iB49t-0001g5-QY
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iB49i-0006GT-1z
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:11 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39889)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iB49h-0006DF-Jj
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:01 -0400
Received: by mail-ot1-x341.google.com with SMTP id s22so4450541otr.6
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hEnRsnkhBw6lClljHVlxLoL/kUii/7QYP2uJtyHbCs0=;
 b=Fu416awUVxtLYIL6GI06ro3NY8xprgTY3iqYgJ1JyybCI47y9fYEQsDfJzO2plTVtD
 +908OKUzx73bHNmHn7lMLrlAxgx0qOk4KOkYtKvLYnSDhfH2J2DvmAu7LW51vPgBLzTM
 geBw7sHZRs7rgX+bWADf0NPGRkMrS2utFXwxeaahcCoJw75LwxmEhTZ4M3qTe5pcJTWl
 vEHNGSDTxstWGK/k1UsxLOWPIodwNwLyGMk7xIDQVRqD2Iuv8gZXJVTwtRM13LkB4eVG
 +JjHuMrv812PHP/yYVcs5UF9Ew6+guHcxoC/dCOYwUiTReYyfth+qHK2vFsKt5sMBfJ8
 CtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=hEnRsnkhBw6lClljHVlxLoL/kUii/7QYP2uJtyHbCs0=;
 b=Lyn4OTwR0Kmj5kZyZMEk9qR/JVfuzdFsPYVWc1R8+ZN1qVpyQbBiNUjvzr4kOb3ln8
 dGDE2cip54RgwHNBL8cMtdCf354LoVSL386tKDYHqa7hd4BDKqe5sHRfb0Stl66xBNkQ
 kNNAiANDVJNibpirKOH+2wa02fAT+kVsE5pw5urCcc9OdckWFOpIGAZ7he+BhEIRH4qL
 RLbAht4aZIXOkmx74J/F6TY3iOgMow0lUGvV4/Ghr0C+BPgx3mCA7IT6v36JJESl+joW
 56RUG0BZUVSEC8G3/kp9KvJzemL/K/Nahg8ErSfLETG3IJdd0H0fJGp00JMKcbozDh4L
 InHw==
X-Gm-Message-State: APjAAAVNL7UEFyTG1nT8mY6i+QABSZpFjY+NUvZ4PDRwFsygrjML+CMe
 atMjyTQrr8W2bFAunQThLA==
X-Google-Smtp-Source: APXvYqyqc2LNrxt1WgxBsh5zxAbunutABK8MPaoVQx755YdH9AtZD8o/O0kQON+3IxCyKu45mCHwHg==
X-Received: by 2002:a9d:5a06:: with SMTP id v6mr8634768oth.250.1568929189790; 
 Thu, 19 Sep 2019 14:39:49 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id 88sm37376otb.63.2019.09.19.14.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:39:47 -0700 (PDT)
Received: from t560.minyard.net (unknown [192.168.27.180])
 by serve.minyard.net (Postfix) with ESMTPA id A3F631805B1;
 Thu, 19 Sep 2019 21:39:37 +0000 (UTC)
From: minyard@acm.org
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 14/15] ipmi: Fix SSIF ACPI handling to use the right CRS
Date: Thu, 19 Sep 2019 16:39:23 -0500
Message-Id: <20190919213924.31852-15-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919213924.31852-1-minyard@acm.org>
References: <20190919213924.31852-1-minyard@acm.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Corey Minyard <cminyard@mvista.com>, Fam Zheng <famz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Minyard <cminyard@mvista.com>

Pass in the CRS so that it can be set to the SMBus for IPMI later.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/acpi/ipmi-stub.c    |  2 +-
 hw/acpi/ipmi.c         | 13 +++++++------
 hw/i386/acpi-build.c   |  2 +-
 include/hw/acpi/ipmi.h |  2 +-
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/acpi/ipmi-stub.c b/hw/acpi/ipmi-stub.c
index f525f71c2d..8634fb325c 100644
--- a/hw/acpi/ipmi-stub.c
+++ b/hw/acpi/ipmi-stub.c
@@ -10,6 +10,6 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/ipmi.h"
 
-void build_acpi_ipmi_devices(Aml *table, BusState *bus)
+void build_acpi_ipmi_devices(Aml *table, BusState *bus, const char *resource)
 {
 }
diff --git a/hw/acpi/ipmi.c b/hw/acpi/ipmi.c
index 651e2e94ea..96e48eba15 100644
--- a/hw/acpi/ipmi.c
+++ b/hw/acpi/ipmi.c
@@ -13,7 +13,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ipmi.h"
 
-static Aml *aml_ipmi_crs(IPMIFwInfo *info)
+static Aml *aml_ipmi_crs(IPMIFwInfo *info, const char *resource)
 {
     Aml *crs = aml_resource_template();
 
@@ -48,7 +48,8 @@ static Aml *aml_ipmi_crs(IPMIFwInfo *info)
                             info->register_spacing, info->register_length));
         break;
     case IPMI_MEMSPACE_SMBUS:
-        aml_append(crs, aml_return(aml_int(info->base_address)));
+        aml_append(crs, aml_i2c_serial_bus_device(info->base_address,
+                                                  resource));
         break;
     default:
         abort();
@@ -61,7 +62,7 @@ static Aml *aml_ipmi_crs(IPMIFwInfo *info)
     return crs;
 }
 
-static Aml *aml_ipmi_device(IPMIFwInfo *info)
+static Aml *aml_ipmi_device(IPMIFwInfo *info, const char *resource)
 {
     Aml *dev;
     uint16_t version = ((info->ipmi_spec_major_revision << 8)
@@ -74,14 +75,14 @@ static Aml *aml_ipmi_device(IPMIFwInfo *info)
     aml_append(dev, aml_name_decl("_STR", aml_string("ipmi_%s",
                                                      info->interface_name)));
     aml_append(dev, aml_name_decl("_UID", aml_int(info->uuid)));
-    aml_append(dev, aml_name_decl("_CRS", aml_ipmi_crs(info)));
+    aml_append(dev, aml_name_decl("_CRS", aml_ipmi_crs(info, resource)));
     aml_append(dev, aml_name_decl("_IFT", aml_int(info->interface_type)));
     aml_append(dev, aml_name_decl("_SRV", aml_int(version)));
 
     return dev;
 }
 
-void build_acpi_ipmi_devices(Aml *scope, BusState *bus)
+void build_acpi_ipmi_devices(Aml *scope, BusState *bus, const char *resource)
 {
 
     BusChild *kid;
@@ -101,6 +102,6 @@ void build_acpi_ipmi_devices(Aml *scope, BusState *bus)
         iic = IPMI_INTERFACE_GET_CLASS(obj);
         memset(&info, 0, sizeof(info));
         iic->get_fwinfo(ii, &info);
-        aml_append(scope, aml_ipmi_device(&info));
+        aml_append(scope, aml_ipmi_device(&info, resource));
     }
 }
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e54e571a75..8acf12df9a 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1290,7 +1290,7 @@ static void build_isa_devices_aml(Aml *table)
     } else if (!obj) {
         error_report("No ISA bus, unable to define IPMI ACPI data");
     } else {
-        build_acpi_ipmi_devices(scope, BUS(obj));
+        build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
     }
 
     aml_append(table, scope);
diff --git a/include/hw/acpi/ipmi.h b/include/hw/acpi/ipmi.h
index c38483565c..c14ad682ac 100644
--- a/include/hw/acpi/ipmi.h
+++ b/include/hw/acpi/ipmi.h
@@ -16,6 +16,6 @@
  * bus matches the given bus.  The resource is the ACPI resource that
  * contains the IPMI device, this is required for the I2C CRS.
  */
-void build_acpi_ipmi_devices(Aml *table, BusState *bus);
+void build_acpi_ipmi_devices(Aml *table, BusState *bus, const char *resource);
 
 #endif /* HW_ACPI_IPMI_H */
-- 
2.17.1


