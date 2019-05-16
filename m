Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76A3C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA8420848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA8420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54030 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFaw-0005gT-1g
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:34:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFLu-0000MJ-V1
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFLr-0001ny-Tu
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:19:14 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:34804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFLr-0001ng-Qm
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:19:11 -0400
Received: by mail-qt1-f173.google.com with SMTP id h1so3605130qtp.1
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=1LcfTJcuB3Ujwz9dZ8Eu+v5gSvOIHMjPL+YsRyxSFVc=;
	b=LkTtAAy/LelGhgDTTREJ9qYSjZ8JIO+Cjtk6C/2IwiQuqInneCXMcsXPC0yIxNGecQ
	/cjf0+Uh5Fy3lP+uV81f33bI3kxLQDRQnLfKZVY13F7rlVTsrjh7OWZ5Oo7oNGQeGdtm
	dbfrh7uG9I0FrNcJxwTdLW+B9xVTrT3nwe4hSFKqXxOA7Y5ClJg9x0AsYS9CtoB7cfVF
	1A/HXY9colDiqc3zRrnTvfaoZl4BuuqRVPoS5MsHuxGThcfQu5OTrsa+SmPoLZ6ZVWyH
	DcqVyfC5oY8EJ13RVtiPABYO76I27qwQRLrp5lBK+pKTd91wxrxsE10l0iazw+dwD01x
	EVlQ==
X-Gm-Message-State: APjAAAVlSQGkZ85mYuweXvK4h47hG6RSEGDQoaMweVlyqZG8l0m1idtV
	cYYlxftTTAfmx5nJai6Yt78H7vkwnSw=
X-Google-Smtp-Source: APXvYqz2IpN0AV21k3unvfZD+hkE6dZ2+omyk8hN0Jk+SPFvkmlUEextKlGZyOXtnqWEwTMhMjhs6w==
X-Received: by 2002:a0c:ba86:: with SMTP id x6mr39773029qvf.221.1558009150859; 
	Thu, 16 May 2019 05:19:10 -0700 (PDT)
Received: from redhat.com ([185.54.206.10])
	by smtp.gmail.com with ESMTPSA id o10sm2394598qtg.5.2019.05.16.05.19.09
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:19:10 -0700 (PDT)
Date: Thu, 16 May 2019 08:19:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190402161900.7374-3-armbru@redhat.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.173
Subject: [Qemu-devel] [PULL 12/37] acpi/pcihp: Convert debug printf()s to
 trace events
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190516121908.LGcgRUiwSMi9nbQ6AhjPjr1HUAO2twmsY4genfEuoFI@z>

From: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190402161900.7374-3-armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/acpi/pcihp.c      | 25 ++++++++-----------------
 hw/acpi/trace-events |  9 +++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 88e4ae1bcd..7729c5338b 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -37,14 +37,7 @@
 #include "hw/pci/pci_bus.h"
 #include "qapi/error.h"
 #include "qom/qom-qobject.h"
-
-//#define DEBUG
-
-#ifdef DEBUG
-# define ACPI_PCIHP_DPRINTF(format, ...)     printf(format, ## __VA_ARGS__)
-#else
-# define ACPI_PCIHP_DPRINTF(format, ...)     do { } while (0)
-#endif
+#include "trace.h"
 
 #define ACPI_PCIHP_ADDR 0xae00
 #define ACPI_PCIHP_SIZE 0x0014
@@ -306,23 +299,23 @@ static uint64_t pci_read(void *opaque, hwaddr addr, unsigned int size)
         if (!s->legacy_piix) {
             s->acpi_pcihp_pci_status[bsel].up = 0;
         }
-        ACPI_PCIHP_DPRINTF("pci_up_read %" PRIu32 "\n", val);
+        trace_acpi_pci_up_read(val);
         break;
     case PCI_DOWN_BASE:
         val = s->acpi_pcihp_pci_status[bsel].down;
-        ACPI_PCIHP_DPRINTF("pci_down_read %" PRIu32 "\n", val);
+        trace_acpi_pci_down_read(val);
         break;
     case PCI_EJ_BASE:
         /* No feature defined yet */
-        ACPI_PCIHP_DPRINTF("pci_features_read %" PRIu32 "\n", val);
+        trace_acpi_pci_features_read(val);
         break;
     case PCI_RMV_BASE:
         val = s->acpi_pcihp_pci_status[bsel].hotplug_enable;
-        ACPI_PCIHP_DPRINTF("pci_rmv_read %" PRIu32 "\n", val);
+        trace_acpi_pci_rmv_read(val);
         break;
     case PCI_SEL_BASE:
         val = s->hotplug_select;
-        ACPI_PCIHP_DPRINTF("pci_sel_read %" PRIu32 "\n", val);
+        trace_acpi_pci_sel_read(val);
     default:
         break;
     }
@@ -340,13 +333,11 @@ static void pci_write(void *opaque, hwaddr addr, uint64_t data,
             break;
         }
         acpi_pcihp_eject_slot(s, s->hotplug_select, data);
-        ACPI_PCIHP_DPRINTF("pciej write %" HWADDR_PRIx " <== %" PRIu64 "\n",
-                      addr, data);
+        trace_acpi_pci_ej_write(addr, data);
         break;
     case PCI_SEL_BASE:
         s->hotplug_select = s->legacy_piix ? ACPI_PCIHP_BSEL_DEFAULT : data;
-        ACPI_PCIHP_DPRINTF("pcisel write %" HWADDR_PRIx " <== %" PRIu64 "\n",
-                      addr, data);
+        trace_acpi_pci_sel_write(addr, data);
     default:
         break;
     }
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index 825b25cbb0..98a56baa6f 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -31,6 +31,15 @@ cpuhp_acpi_ejecting_cpu(uint32_t idx) "0x%"PRIx32
 cpuhp_acpi_write_ost_ev(uint32_t slot, uint32_t ev) "idx[0x%"PRIx32"] OST EVENT: 0x%"PRIx32
 cpuhp_acpi_write_ost_status(uint32_t slot, uint32_t st) "idx[0x%"PRIx32"] OST STATUS: 0x%"PRIx32
 
+# pcihp.c
+acpi_pci_up_read(uint32_t val) "%" PRIu32
+acpi_pci_down_read(uint32_t val) "%" PRIu32
+acpi_pci_features_read(uint32_t val) "%" PRIu32
+acpi_pci_rmv_read(uint32_t val) "%" PRIu32
+acpi_pci_sel_read(uint32_t val) "%" PRIu32
+acpi_pci_ej_write(uint64_t addr, uint64_t data) "0x%" PRIx64 " <== %" PRIu64
+acpi_pci_sel_write(uint64_t addr, uint64_t data) "0x%" PRIx64 " <== %" PRIu64
+
 # piix4.c
 piix4_gpe_readb(uint64_t addr, unsigned width, uint64_t val) "addr: 0x%" PRIx64 " width: %d ==> 0x%" PRIx64
 piix4_gpe_writeb(uint64_t addr, unsigned width, uint64_t val) "addr: 0x%" PRIx64 " width: %d <== 0x%" PRIx64
-- 
MST


