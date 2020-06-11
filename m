Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7A7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A937207ED
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNDNYQYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A937207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjU6a-0008P6-QY
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAm-0002Ns-6P
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24163
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAk-0001UK-36
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Teg1bboP42oJzk7SjLIm9ufOGo8EbIsWR0CxjrMPhm4=;
 b=ZNDNYQYdhE+tLxBCev4kBe7JfGqoLlmvJgcEqeGAENu7zcjXMCa/bpTrn6ioEej+BOC956
 K7O6mqnVE2FenjR3U9vN5rt1F9h08OPUtdofGAKl91Q4DxgHFgnBZh0k8Dn+TSKtbUMgjM
 69ghaAeQWCsYQxFChY41Q+cmj+GIIw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-WJnJc3NLNBW7Axr37Oyczg-1; Thu, 11 Jun 2020 15:47:28 -0400
X-MC-Unique: WJnJc3NLNBW7Axr37Oyczg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57D5C835B40;
 Thu, 11 Jun 2020 19:47:27 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C96EF7CCE7;
 Thu, 11 Jun 2020 19:47:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 112/115] exec/cpu-common: Move MUSB specific typedefs to
 'hw/usb/hcd-musb.h'
Date: Thu, 11 Jun 2020 15:44:46 -0400
Message-Id: <20200611194449.31468-113-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The CPUReadMemoryFunc/CPUWriteMemoryFunc typedefs are legacy
remnant from before the conversion to MemoryRegions.
Since they are now only used in tusb6010.c and hcd-musb.c,
move them to "hw/usb/musb.h" and rename them appropriately.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200601141536.15192-4-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/usb/hcd-musb.c         | 4 ++--
 include/exec/cpu-common.h | 3 ---
 include/hw/usb/hcd-musb.h | 9 +++++----
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/usb/hcd-musb.c b/hw/usb/hcd-musb.c
index 5ab13feb3a..85f5ff5bd4 100644
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
diff --git a/include/hw/usb/hcd-musb.h b/include/hw/usb/hcd-musb.h
index 26b50132ff..c874b9f292 100644
--- a/include/hw/usb/hcd-musb.h
+++ b/include/hw/usb/hcd-musb.h
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
 
-- 
2.26.2



