Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C7BC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 00:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10866217D4
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 00:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eWHG6nz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10866217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33274 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCCum-0003OX-9a
	for qemu-devel@archiver.kernel.org; Thu, 04 Apr 2019 20:41:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hCCtS-0002gZ-1z
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 20:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hCCtR-0003G8-3e
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 20:39:42 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:40621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hCCtQ-00039e-Qr
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 20:39:41 -0400
Received: by mail-pg1-x52a.google.com with SMTP id u9so2078189pgo.7
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 17:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
	h=subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding:cc:from:to;
	bh=0KFxRvtPVKexQ8LwFfKj/IAm9GYBQc7B3RcgR3vfV4c=;
	b=eWHG6nz0xeI2fQYubcku9OEhorB8SfZsrW30pfDQA3mLtwfqGlKM+Cdes7JK7uzixh
	DPQ0DhWErHTO1McHMJtRK3JNtBdqinImTRdWXaO7rqErmRHydUFnOPARwcid2kyEj6wE
	9fEi+A7sxSbV357MUTU2DpyPVFCtzP8ebVWJm8IS87tx1PCalXUSn6wHmhIUhXrXlOso
	bC+eN92c6JTI3aCqlccWwf79ahGrNF0VEtGr9jFPsr/TJxw134GCQZMB1XVDQ67p9BLf
	JGEWkeM7DwuOLyzySLw2nMBYMv3pOHXaLGJ3kvloY28HCUhENvHZOV8UpG0xpZBqxdV2
	+0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=0KFxRvtPVKexQ8LwFfKj/IAm9GYBQc7B3RcgR3vfV4c=;
	b=DKit0Uj9HfpsriDajgB3ux9JsG00ikV/RpOm7ci50UncTF0KCQwE3oFmoIw1+ZYNBd
	FrovWbGuf2UOM/tMaHQl6dpTY/GWMtwEG77Ls1M36oX6BVPVNe547CJbQ4FwW+gPvJvU
	R8INofhKMoqTFWlc3WGCKzMXRWAuvVyMpzxa3SIrobJ0DaxHN8A4wDjNppChfsJ87S7Y
	jx2aYHu2SmffGr2r3cLp6+Ovkjk0bAqHcwc6+kETXgOPjz0g3Zs7MVQ1iZbsX3CpoHtY
	CTK/oWGDVC/tSycf7DaFLoajZAbxScyv26VB/0SkiWYCa6jcpoMJs2lS0aIXZNFOvlrd
	pLlg==
X-Gm-Message-State: APjAAAU3R0v5Zgb6xTloVoEYCdutRqE5H8JlwsxmeMdwKAev82RPB9ux
	1HDIC6+a9x5xQmWYUrZRqVZniA==
X-Google-Smtp-Source: APXvYqwQR4PAgGMQeYPJyV2cpOIimiQ0sHh/FCawgm+xVhEkgP2RcUjii8eYQS5RSGJlLzp71NzdwA==
X-Received: by 2002:a65:5a81:: with SMTP id c1mr8948237pgt.391.1554424779795; 
	Thu, 04 Apr 2019 17:39:39 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	c17sm29392383pfd.76.2019.04.04.17.39.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 04 Apr 2019 17:39:39 -0700 (PDT)
Date: Thu,  4 Apr 2019 17:39:24 -0700
Message-Id: <20190405003924.1906-3-palmer@sifive.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190405003924.1906-1-palmer@sifive.com>
References: <20190405003924.1906-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52a
Subject: [Qemu-devel] [PULL 2/2] riscv: plic: Log guest errors
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
	Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190405003924.8Vdto3Y34AfU5238bR0Bcd4lK5FlWktkVsO19vIa5iM@z>

From: Alistair Francis <Alistair.Francis@wdc.com>

Instead of using error_report() to print guest errors let's use
qemu_log_mask(LOG_GUEST_ERROR,...) to log the error.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_plic.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 0315e035e5fb..07a032d93d2e 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -263,7 +263,9 @@ static uint64_t sifive_plic_read(void *opaque, hwaddr addr, unsigned size)
     }
 
 err:
-    error_report("plic: invalid register read: %08x", (uint32_t)addr);
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: Invalid register read 0x%" HWADDR_PRIx "\n",
+                  __func__, addr);
     return 0;
 }
 
@@ -290,7 +292,9 @@ static void sifive_plic_write(void *opaque, hwaddr addr, uint64_t value,
     } else if (addr >= plic->pending_base && /* 1 bit per source */
                addr < plic->pending_base + (plic->num_sources >> 3))
     {
-        error_report("plic: invalid pending write: %08x", (uint32_t)addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid pending write: 0x%" HWADDR_PRIx "",
+                      __func__, addr);
         return;
     } else if (addr >= plic->enable_base && /* 1 bit per source */
         addr < plic->enable_base + plic->num_addrs * plic->enable_stride)
@@ -340,7 +344,9 @@ static void sifive_plic_write(void *opaque, hwaddr addr, uint64_t value,
     }
 
 err:
-    error_report("plic: invalid register write: %08x", (uint32_t)addr);
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: Invalid register write 0x%" HWADDR_PRIx "\n",
+                  __func__, addr);
 }
 
 static const MemoryRegionOps sifive_plic_ops = {
-- 
2.19.2


