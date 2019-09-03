Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80226C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A002207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ke3SGaZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A002207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Ba7-0006mB-Si
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMp-00012v-P4
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMo-0003hK-JA
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:15 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35890)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BMm-0003fQ-Ir
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:12 -0400
Received: by mail-pf1-x444.google.com with SMTP id y22so5434946pfr.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yA2tCG225nmRvmvSYliNTgGqIpVngsbzb4LG/KhgDa8=;
 b=ke3SGaZpp583Zt3nK84PL3TxAgya2rEu4q+EQN3uHtNLp3nRHwYz0e5gBtN8JkrY5Y
 dMZrYv5i+NPUw/p9WEUT7OwPkdBqizYxvhR0nCFOKkLquI8AXUOGTLyOTbtouszyNJXz
 wybF1c9vqP12tHK2EbnMzNVezx3l8kUQH1bhRuhxVJ5NBuWU8CLxJAv9kePoFdwcIP9L
 2Dth9InO/hDKuB7Wr6ayF3wmiCLqVGWaBD98d8azSODwtjxbNE7mLcWcBzTW/p7veSTT
 Ue6YUeay/2IAgCWz3BNILjPlD2UtrRzL4mKCnMl3Z68Zo7U/sqJ8nr83gRX8lKMOAZaQ
 XFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=yA2tCG225nmRvmvSYliNTgGqIpVngsbzb4LG/KhgDa8=;
 b=bdHBqEAJhMytkApa+MaK5CWfHODmn8mVYxwLkohpsSTBYZRdaLe8GmpauIC1j0tLic
 2Dmflq5lut8ZrKV0x+/t9NhVTnta5v0HKHYCvgctRsXAs72vL2MiJb+p8HmgvNnHEYDf
 z8iqziSnIIF4xQyoGQfigV1sCxu0JxQrf+tykEVuQQqNm40b6a3Vo86rmWyMWejygbwJ
 Z6aCfh0rH1j3BFocTxeFpEMitGMQIYKB/FyMOiq/ajAtMEgajKRcuRcVUBRRVXHmahC9
 qpPYdozO7FKso9Qy+kBE2okj5ya8LvX1ExEX4M115fh/w/9AiazIuqJ8KdsE7VtIxmH4
 a9eQ==
X-Gm-Message-State: APjAAAVc7cXrMY2d9zvtFvq5noK352F75xg0qKcroE2ZBtI95ESIH/Zd
 JYE6cukhTB4UjW7Zl4jJT98NhevWUw4=
X-Google-Smtp-Source: APXvYqyzQ+/lOFYIz3GXRHTp/l6hQhEK4aFLpYbgwZghtaA6Wcro/fEAqbpYFd47ircC+8RQ1uNE/g==
X-Received: by 2002:a63:f118:: with SMTP id f24mr31782828pgi.322.1567526949600; 
 Tue, 03 Sep 2019 09:09:09 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:29 -0700
Message-Id: <20190903160858.5296-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH 07/36] hw/vfio: Access MemoryRegion with MemOp
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
Cc: peter.maydell@linaro.org, Tony Nguyen <tony.nguyen@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tony Nguyen <tony.nguyen@bt.com>

The memory_region_dispatch_{read|write} operand "unsigned size" is
being converted into a "MemOp op".

Convert interfaces by using no-op size_memop.

After all interfaces are converted, size_memop will be implemented
and the memory_region_dispatch_{read|write} operand "unsigned size"
will be converted into a "MemOp op".

As size_memop is a no-op, this patch does not change any behaviour.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <e70ff5814ac3656974180db6375397c43b0bc8b8.1566466906.git.tony.nguyen@bt.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/vfio/pci-quirks.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index f71aace156..a4e1d2abb5 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/memop.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
@@ -1073,7 +1074,7 @@ static void vfio_rtl8168_quirk_address_write(void *opaque, hwaddr addr,
 
                 /* Write to the proper guest MSI-X table instead */
                 memory_region_dispatch_write(&vdev->pdev.msix_table_mmio,
-                                             offset, val, size,
+                                             offset, val, size_memop(size),
                                              MEMTXATTRS_UNSPECIFIED);
             }
             return; /* Do not write guest MSI-X data to hardware */
@@ -1104,7 +1105,8 @@ static uint64_t vfio_rtl8168_quirk_data_read(void *opaque,
     if (rtl->enabled && (vdev->pdev.cap_present & QEMU_PCI_CAP_MSIX)) {
         hwaddr offset = rtl->addr & 0xfff;
         memory_region_dispatch_read(&vdev->pdev.msix_table_mmio, offset,
-                                    &data, size, MEMTXATTRS_UNSPECIFIED);
+                                    &data, size_memop(size),
+                                    MEMTXATTRS_UNSPECIFIED);
         trace_vfio_quirk_rtl8168_msix_read(vdev->vbasedev.name, offset, data);
     }
 
-- 
2.17.1


