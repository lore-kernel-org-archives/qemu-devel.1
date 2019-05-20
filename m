Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EC0C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97CB92171F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CB92171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43417 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrYb-0005CY-PH
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:19:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQi-000768-Dh
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQh-00081T-Gs
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:52 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:44920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrQh-00081I-Ce
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:51 -0400
Received: by mail-qt1-f174.google.com with SMTP id f24so18317931qtk.11
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=OD8+8P+lHVBBPaafWccz6qd4h5juRCmJsHK6ZGASZyE=;
	b=LB5ex2TYk/TrPQoOm3djGl9/HZNHRBy0zreZSvWaCAWW54OvQ9LfZ6+/u08PUBpUNl
	xdMWYApCU2eh3/dpmxsB1TOLcGYZJdFeK8I8OGMtICrdXF+Z9cfIpOeDjny95WikFhXL
	tV3LfBlOqG2cHePSORIQEhaixCc/ceAmk+agSJjvFuaoM9Yqn66JTzrIzg+9M6+U3JFu
	vvsu8A0+olr9N6XJN4pFPRPsbUi0Un0dKNU25WzCkUtdR3Da0Uqy2b+zH9Bitv09gvOj
	ZRHceHEZQ3ZgkzvFDVx1CdCESLa2MjBdm+wP8jn1JDmh7A4ickUvR4Nrwq114j2lhB51
	iGWA==
X-Gm-Message-State: APjAAAUlvXA+VbJmT3vnGlGiWrP27m2xZZiTCybVKZFgP/kCvuGiV7zi
	adYpQRZ8ntilg+FlEo2ejCNLFumlD9E=
X-Google-Smtp-Source: APXvYqw1IaBTZ7gH++m3vaHl8IJCAzRoHY3396Ies4KOge2MaTpXjf51eJVIrUd0BzEYAAssTdwZrw==
X-Received: by 2002:a05:6214:2b2:: with SMTP id
	m18mr60412887qvv.243.1558393850662; 
	Mon, 20 May 2019 16:10:50 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	f145sm8769329qke.32.2019.05.20.16.10.49
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:10:49 -0700 (PDT)
Date: Mon, 20 May 2019 19:10:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190402161900.7374-2-armbru@redhat.com>
References: <20190520231008.20140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.174
Subject: [Qemu-devel] [PULL v2 11/36] acpi/piix4: Convert debug printf()s to
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
Message-ID: <20190520231048.XaSn0aap2ws_Fe5Rqx44AXiIvXE7rsiSO91ANne7tis@z>

From: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190402161900.7374-2-armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/acpi/piix4.c      | 14 +++-----------
 hw/acpi/trace-events |  4 ++++
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index c903e65169..ec4e186cec 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -39,14 +39,7 @@
 #include "hw/acpi/acpi_dev_interface.h"
 #include "hw/xen/xen.h"
 #include "qom/cpu.h"
-
-//#define DEBUG
-
-#ifdef DEBUG
-# define PIIX4_DPRINTF(format, ...)     printf(format, ## __VA_ARGS__)
-#else
-# define PIIX4_DPRINTF(format, ...)     do { } while (0)
-#endif
+#include "trace.h"
 
 #define GPE_BASE 0xafe0
 #define GPE_LEN 4
@@ -583,7 +576,7 @@ static uint64_t gpe_readb(void *opaque, hwaddr addr, unsigned width)
     PIIX4PMState *s = opaque;
     uint32_t val = acpi_gpe_ioport_readb(&s->ar, addr);
 
-    PIIX4_DPRINTF("gpe read %" HWADDR_PRIx " == %" PRIu32 "\n", addr, val);
+    trace_piix4_gpe_readb(addr, width, val);
     return val;
 }
 
@@ -592,10 +585,9 @@ static void gpe_writeb(void *opaque, hwaddr addr, uint64_t val,
 {
     PIIX4PMState *s = opaque;
 
+    trace_piix4_gpe_writeb(addr, width, val);
     acpi_gpe_ioport_writeb(&s->ar, addr, val);
     acpi_update_sci(&s->ar, s->irq);
-
-    PIIX4_DPRINTF("gpe write %" HWADDR_PRIx " <== %" PRIu64 "\n", addr, val);
 }
 
 static const MemoryRegionOps piix4_gpe_ops = {
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index 6272d8a9e7..825b25cbb0 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -31,6 +31,10 @@ cpuhp_acpi_ejecting_cpu(uint32_t idx) "0x%"PRIx32
 cpuhp_acpi_write_ost_ev(uint32_t slot, uint32_t ev) "idx[0x%"PRIx32"] OST EVENT: 0x%"PRIx32
 cpuhp_acpi_write_ost_status(uint32_t slot, uint32_t st) "idx[0x%"PRIx32"] OST STATUS: 0x%"PRIx32
 
+# piix4.c
+piix4_gpe_readb(uint64_t addr, unsigned width, uint64_t val) "addr: 0x%" PRIx64 " width: %d ==> 0x%" PRIx64
+piix4_gpe_writeb(uint64_t addr, unsigned width, uint64_t val) "addr: 0x%" PRIx64 " width: %d <== 0x%" PRIx64
+
 # tco.c
 tco_timer_reload(int ticks, int msec) "ticks=%d (%d ms)"
 tco_timer_expired(int timeouts_no, bool strap, bool no_reboot) "timeouts_no=%d no_reboot=%d/%d"
-- 
MST


