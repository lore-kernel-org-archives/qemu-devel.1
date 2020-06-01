Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E057DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 07:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABACA20734
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 07:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtglodC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABACA20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jffIq-0007Ui-W3
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 03:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jffGr-0004Xs-UP
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 03:54:09 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jffGr-0003nF-5H
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 03:54:09 -0400
Received: by mail-wm1-x343.google.com with SMTP id c71so9729395wmd.5
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 00:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qIaVQcM8g4+k990uhebVSTEuTami8Xbb/Exe9m7N3F0=;
 b=rtglodC+M7ycyijwz/p8HSQw8WBbaZx2/nu27IGJKU3I5BepOGqDjUYxAjV3IYgagn
 NZmBGRJiieee5DSJsPzi1GJlLawG9NF9mBDtJJaarGzg+kqFRQMOcltVKnk2+rd3+xTo
 w64zleQ8KB2ktAdqhIIQ4VSTnV5DeXdKqJT75Ge/OJCbtQ3DI1PVkGR7NHfO7qu7A7ei
 /mpvCPsHBPvMDB8XfNFFQTSIa1+fCn3tBZykfQXRkDUE+4eJ02I7yivpO4KmsCqfBgpP
 OnnVOlRP8IioOAt6B3qL5GeERGJpQPLE63199DDCWMYz9PnJTVfoNBQFIMH76m9H1yUO
 FpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qIaVQcM8g4+k990uhebVSTEuTami8Xbb/Exe9m7N3F0=;
 b=Ihdr1halRmd7RwAejrOKrAY8EIj3SecNKl3qJOwrQKcj9h/reJooVm+GflrlhMVdDQ
 gdmkELcPiuE6bu8UmT83yvxFRAY8h2VWxlrsRAuG37syD7a8L+Z1vnxn5RieMuGxKCqk
 /kqycTUMZ/6OzwTqdfU9FcdWCjXxTuT7Qvb2WrTnE5dY4ALqFcDePZjiFOb1TnCDLYe+
 F4iWpdGhSlLIdfZOnye20S7nlzt16XdmxnVy0NWs/EsLnjo5fIyFi8hOvo6fzuLmNfrs
 O2QMPp9ue+2t4n96S9n1z5w1lkzuoi1Mw9W5J1UDYt92wKNERxp8wahanDGtx2n9s8Kw
 eeOw==
X-Gm-Message-State: AOAM532P8shM8eDeihC2E8irhBdS5u9MzTanFihSw/zWtA4Jwu0LbQQK
 FHREBq8WshEr7Rhq1b/BRa0IuK/P
X-Google-Smtp-Source: ABdhPJxDULYAQrfePoPBFwEyskWhOaczq8BQx/huhaDQGrNnFu38FQK6yaFQfE81+rCjs8u7IAHTeg==
X-Received: by 2002:a1c:4302:: with SMTP id q2mr20423265wma.54.1590998047778; 
 Mon, 01 Jun 2020 00:54:07 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id b18sm19294949wrn.88.2020.06.01.00.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 00:54:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] exec/cpu-common: Move MUSB specific typedefs to
 'hw/usb/musb.h'
Date: Mon,  1 Jun 2020 09:54:00 +0200
Message-Id: <20200601075400.2043-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200601075400.2043-1-f4bug@amsat.org>
References: <20200601075400.2043-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CPUReadMemoryFunc/CPUWriteMemoryFunc typedefs are legacy
remnant from before the conversion to MemoryRegions.
Since they are now only used in tusb6010.c and hcd-musb.c,
move them to "hw/usb/musb.h" and rename them appropriately.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/exec/cpu-common.h | 3 ---
 include/hw/usb/musb.h     | 9 +++++----
 hw/usb/hcd-musb.c         | 4 ++--
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index b47e5630e7..d5e285d2b5 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -43,9 +43,6 @@ extern ram_addr_t ram_size;
 
 /* memory API */
 
-typedef void CPUWriteMemoryFunc(void *opaque, hwaddr addr, uint32_t value);
-typedef uint32_t CPUReadMemoryFunc(void *opaque, hwaddr addr);
-
 void qemu_ram_remap(ram_addr_t addr, ram_addr_t length);
 /* This should not be used by devices.  */
 ram_addr_t qemu_ram_addr_from_host(void *ptr);
diff --git a/include/hw/usb/musb.h b/include/hw/usb/musb.h
index 26b50132ff..c874b9f292 100644
--- a/include/hw/usb/musb.h
+++ b/include/hw/usb/musb.h
@@ -13,8 +13,6 @@
 #ifndef HW_USB_MUSB_H
 #define HW_USB_MUSB_H
 
-#include "exec/cpu-common.h"
-
 enum musb_irq_source_e {
     musb_irq_suspend = 0,
     musb_irq_resume,
@@ -32,8 +30,11 @@ enum musb_irq_source_e {
     musb_irq_max /* total number of interrupts defined */
 };
 
-extern CPUReadMemoryFunc * const musb_read[];
-extern CPUWriteMemoryFunc * const musb_write[];
+/* TODO convert hcd-musb to QOM/qdev and remove MUSBReadFunc/MUSBWriteFunc */
+typedef void MUSBWriteFunc(void *opaque, hwaddr addr, uint32_t value);
+typedef uint32_t MUSBReadFunc(void *opaque, hwaddr addr);
+extern MUSBReadFunc * const musb_read[];
+extern MUSBWriteFunc * const musb_write[];
 
 typedef struct MUSBState MUSBState;
 
diff --git a/hw/usb/hcd-musb.c b/hw/usb/hcd-musb.c
index ea7a89fd0c..82865abe65 100644
--- a/hw/usb/hcd-musb.c
+++ b/hw/usb/hcd-musb.c
@@ -1540,13 +1540,13 @@ static void musb_writew(void *opaque, hwaddr addr, uint32_t value)
     };
 }
 
-CPUReadMemoryFunc * const musb_read[] = {
+MUSBReadFunc * const musb_read[] = {
     musb_readb,
     musb_readh,
     musb_readw,
 };
 
-CPUWriteMemoryFunc * const musb_write[] = {
+MUSBWriteFunc * const musb_write[] = {
     musb_writeb,
     musb_writeh,
     musb_writew,
-- 
2.21.3


