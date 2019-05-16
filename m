Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67203C04E84
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BDB120848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDB120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53940 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFXx-0003CW-CR
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:31:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFLr-0000J8-LQ
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:19:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFLo-0001kd-KP
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:19:11 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:40024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFLo-0001kL-Hk
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:19:08 -0400
Received: by mail-qk1-f182.google.com with SMTP id q197so2073262qke.7
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=dkP9xLNGqq+85u8p7aSnxQ3DQHTd2qT+9nsCyRgjWxk=;
	b=R++CrOZL8/Dz+NVDmkDFvb1myKf+I4pEUL59Q28QzKwhsvwMKjinksCFWDG4lBfQrp
	qVTNU4UkaPAn6THxJLkJb8nLHGM3/1pbkPWH+YUL+qC55T0NDHiZwekPcExYoj/KtjJa
	WHK8i0hyRHOrBAR09Awvjl8aS7pL7GVmSfd97EwsWH1m7MYq4vkzDKHsUkznbijGl5oK
	lM8x0zWONOFYwm97PLylQPDI1R1a6MeKBXEy0KfzjuWbazkctFElfvRLIPobgwPY6NtE
	KvWQdVRZEsAjboAyc9hnpIZf6PY2/jL8wfIllX5j772yyN3XX/ewFenrAmz7zOm3FgVE
	HISQ==
X-Gm-Message-State: APjAAAVwURo1lCYDvLM3Uyxb7m+OstZ0E4w6dydkIhalMgMWEsaw+W9V
	hTgnUp8WXBv5MtudqOjVyBpuqp50BA8=
X-Google-Smtp-Source: APXvYqyMfsP+VUNUTr0PLaNuqy9aD9kcoAUMTp9o7uta5sabMc7XLmp+EDDX6g5Re2xTu5oTqJ9Z9Q==
X-Received: by 2002:a05:620a:16c8:: with SMTP id
	a8mr25363994qkn.4.1558009147700; 
	Thu, 16 May 2019 05:19:07 -0700 (PDT)
Received: from redhat.com ([185.54.206.10])
	by smtp.gmail.com with ESMTPSA id q2sm2431560qkf.44.2019.05.16.05.19.03
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:19:06 -0700 (PDT)
Date: Thu, 16 May 2019 08:19:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190402161900.7374-2-armbru@redhat.com>
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
X-Received-From: 209.85.222.182
Subject: [Qemu-devel] [PULL 11/37] acpi/piix4: Convert debug printf()s to
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
Message-ID: <20190516121901.AvEsX2HU-rHX8dX2OwmaaZO2s4HZBI0hZZUPKb6EoPI@z>

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
index 9c079d6834..546ba036ed 100644
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
@@ -596,7 +589,7 @@ static uint64_t gpe_readb(void *opaque, hwaddr addr, unsigned width)
     PIIX4PMState *s = opaque;
     uint32_t val = acpi_gpe_ioport_readb(&s->ar, addr);
 
-    PIIX4_DPRINTF("gpe read %" HWADDR_PRIx " == %" PRIu32 "\n", addr, val);
+    trace_piix4_gpe_readb(addr, width, val);
     return val;
 }
 
@@ -605,10 +598,9 @@ static void gpe_writeb(void *opaque, hwaddr addr, uint64_t val,
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


