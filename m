Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B583C8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5407120757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJPm61l1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5407120757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7uW-00088a-ES
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jd-00036n-Pc
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jZ-0000Op-Nc
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:09 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:52907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jZ-0000OH-AU
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:05 -0400
Received: by mail-wm1-x32d.google.com with SMTP id 188so1511891wmc.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=O3w8HyaAfJtw7bxuseWGtHyrXHMdqtOWwjxtX6t+QRI=;
 b=LJPm61l1x/msDMFCY74yUWnCfFx/MNcl3PkFuj5s+zascAqHwqTp8OD7chQhSzmnjM
 3RDvMPOncTranY/LSuYGXfleOu57oSfY9wKll/C5PS1aU8SefBrR1rkArTkGZs5VamAh
 zoV05IDns1Ysq0HN6XhlLuGZwFhRvV88kvogRzpHO+9K3hy9yUV/Ndfze8yVAbMUDlKD
 2anrl+AtVEwNxWAOTaEQ+blRNbb++fvcDj1jG2BDibsHvTe1Oe9BxQsz2DjdOeDwoUwg
 tE3bx1FF8JtKeWvo/fsq0cXmtodEELgIQdphYEdf4CKmQArgpBJ3gjfAsw9tzRG1DOO8
 Tf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O3w8HyaAfJtw7bxuseWGtHyrXHMdqtOWwjxtX6t+QRI=;
 b=qmSMsNjI4gBVkbHX3CzJIsCopSaigl8MQhdmOxJOqRxbAQYLYLDnoygxW2mPcBgN6C
 QMGE3PZmWaTDs0UC7LEPxP+rg2dphFfQnHY4b+var1/uVb9VZXXYncOOTZEQC21UxP2M
 hD0Rw8Y+RAY7LVr7m2h9YU2qmz/qnUQmfO9jhqmoNl95o6AEI04GCjSx179MwPDUmEWy
 a0qSIS3kesiifa1TY7kbF+1ZQzoYp9psvJNEgNcJTf+OyP6a679QmdonVP6h23JV9heP
 wFQaQKgclCathuLt3x4lojyOQjgjyFYMHQhkBj51howMYtEvD5I515GG4g5E9WWyW4NS
 uGbQ==
X-Gm-Message-State: AGi0PuZimHIYyga58u9WGCgHziyrsh5vcTTJGCpd0mDq77lu83ZePM/e
 QP2qTq50QpM0DmyoIiJvFjcKkn6w1N0jJw==
X-Google-Smtp-Source: APiQypIIWj4n1YbzQSWfzwy94G17VcnmwYrO607JxjjtndZEsv1Ws6LhnCWxnTphPz/MYtlxW4auqQ==
X-Received: by 2002:a7b:c104:: with SMTP id w4mr2606415wmi.8.1588247523570;
 Thu, 30 Apr 2020 04:52:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.52.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:52:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/31] qdev-monitor: print the device's clock with info qtree
Date: Thu, 30 Apr 2020 12:51:28 +0100
Message-Id: <20200430115142.13430-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::32d
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

From: Damien Hedde <damien.hedde@greensocs.com>

This prints the clocks attached to a DeviceState when using
"info qtree" monitor command. For every clock, it displays the
direction, the name and if the clock is forwarded. For input clock,
it displays also the frequency.

This is based on the original work of Frederic Konrad.

Here follows a sample of `info qtree` output on xilinx_zynq machine
after linux boot with only one uart clocked:
> bus: main-system-bus
>  type System
>  [...]
>  dev: cadence_uart, id ""
>    gpio-out "sysbus-irq" 1
>    clock-in "refclk" freq_hz=0.000000e+00
>    chardev = ""
>    mmio 00000000e0001000/0000000000001000
>  dev: cadence_uart, id ""
>    gpio-out "sysbus-irq" 1
>    clock-in "refclk" freq_hz=1.375661e+07
>    chardev = "serial0"
>    mmio 00000000e0000000/0000000000001000
>  [...]
>  dev: xilinx,zynq_slcr, id ""
>    clock-out "uart1_ref_clk" freq_hz=0.000000e+00
>    clock-out "uart0_ref_clk" freq_hz=1.375661e+07
>    clock-in "ps_clk" freq_hz=3.333333e+07
>    mmio 00000000f8000000/0000000000001000

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20200406135251.157596-10-damien.hedde@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qdev-monitor.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index 9833b335496..56cee1483fa 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -38,6 +38,7 @@
 #include "migration/misc.h"
 #include "migration/migration.h"
 #include "qemu/cutils.h"
+#include "hw/clock.h"
 
 /*
  * Aliases were a bad idea from the start.  Let's keep them
@@ -737,6 +738,7 @@ static void qdev_print(Monitor *mon, DeviceState *dev, int indent)
     ObjectClass *class;
     BusState *child;
     NamedGPIOList *ngl;
+    NamedClockList *ncl;
 
     qdev_printf("dev: %s, id \"%s\"\n", object_get_typename(OBJECT(dev)),
                 dev->id ? dev->id : "");
@@ -751,6 +753,13 @@ static void qdev_print(Monitor *mon, DeviceState *dev, int indent)
                         ngl->num_out);
         }
     }
+    QLIST_FOREACH(ncl, &dev->clocks, node) {
+        qdev_printf("clock-%s%s \"%s\" freq_hz=%e\n",
+                    ncl->output ? "out" : "in",
+                    ncl->alias ? " (alias)" : "",
+                    ncl->name,
+                    CLOCK_PERIOD_TO_HZ(1.0 * clock_get(ncl->clock)));
+    }
     class = object_get_class(OBJECT(dev));
     do {
         qdev_print_props(mon, dev, DEVICE_CLASS(class)->props_, indent);
-- 
2.20.1


