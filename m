Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2E6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1DA20838
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbIZT74N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1DA20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5w3l-000601-13
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 15:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k5w0t-0002Xj-HC; Wed, 12 Aug 2020 15:02:15 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k5w0r-0006Eu-Tp; Wed, 12 Aug 2020 15:02:15 -0400
Received: by mail-wm1-x342.google.com with SMTP id x5so2692116wmi.2;
 Wed, 12 Aug 2020 12:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=51xOVz0iHhc5rb1/zArjdyiBJ2orj09aEiXFrYZBmxQ=;
 b=LbIZT74N9akuor1WBjAtsMxUiWLuENqkdyQxXoe0VeryXYKYcg0UL2UfMJmyZ52AEx
 HF9Le9CpeEMdWVj3ocoJjKyxYzQgtDt+ELuQz1SLyEJplalTThYGEyI7aWJCsFfx49is
 Y5dOaWX7Z54KrvlTpCWsp2p3ydfMvqskqJ71nhEC9Z+2SDm3bqalRQw0DcoGOYSuro+6
 Z7SdowABj/nXlINABahwZsXbHCq/+mpu+UwRToO2ZAJm5cwsLQgzSFVYiEGBlkc3VwXe
 pHO8F75nWubY0M39ZD9mEfw4S3BnlUzwgpe8AahjBgGrudE4umgoLxM2QF1di2fSklwT
 KwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=51xOVz0iHhc5rb1/zArjdyiBJ2orj09aEiXFrYZBmxQ=;
 b=bj1WEP27NBFPPdIzc5k+p2Am9riD5yX6HWDn7gKLDahVIdi5unqZlj7aKNMBckPlBB
 op8aMQ9JjMeRa86V3y3zXOcYQdVmdbifOWCw/aUHL0NOv8q1+Xib/MQNavC83QrWLCYE
 FGGUOoq+L6AOsC69EF4hVa+VvX3gjGESkv3Wa8OTtVC0SFC3tJkwGNulNzvCDn2J0R2i
 VU2bES6CFOQaM6Q6isuTF+BDxHk5OjbL+V6rlsAvOgxFogxB0mX/eYiWs8iVTAaTjfj6
 0XsIWrUURkpECozHPtirpumZbluyP5CNhNfQFsETacS1/090JfA1v6oodqKBP6bGkze/
 mjyQ==
X-Gm-Message-State: AOAM531CNnpCZdItZ3K7MfSj9D01VJ4RiVVqPdgWgpW34kwBLViwXa9A
 3RrGJE7OzRsDobw/+kRxTZf7QdLu
X-Google-Smtp-Source: ABdhPJxf8K4e2Tbys3JicI75ds3VmcHIuqnQHqBJyDjIPvfZCy7VW4rFHRqNNboQBtp/sxlXCLEDKw==
X-Received: by 2002:a7b:c095:: with SMTP id r21mr954823wmh.96.1597258931818;
 Wed, 12 Aug 2020 12:02:11 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id z12sm5689441wrp.20.2020.08.12.12.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 12:02:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] hw/misc/unimp: Display the offset with width of the
 region size
Date: Wed, 12 Aug 2020 21:02:06 +0200
Message-Id: <20200812190206.31595-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200812190206.31595-1-f4bug@amsat.org>
References: <20200812190206.31595-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To have a better idea of how big is the region where the offset
belongs, display the value with the width of the region size
(i.e. a region of 0x1000 bytes uses 0x000 format).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Since v1: Use DIV_ROUND_UP (rth)
---
 include/hw/misc/unimp.h |  1 +
 hw/misc/unimp.c         | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
index 4c1d13c9bf..c63968a2cd 100644
--- a/include/hw/misc/unimp.h
+++ b/include/hw/misc/unimp.h
@@ -20,6 +20,7 @@
 typedef struct {
     SysBusDevice parent_obj;
     MemoryRegion iomem;
+    unsigned offset_fmt_width;
     char *name;
     uint64_t size;
 } UnimplementedDeviceState;
diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
index b4b318db1c..6cfc5727f0 100644
--- a/hw/misc/unimp.c
+++ b/hw/misc/unimp.c
@@ -23,8 +23,8 @@ static uint64_t unimp_read(void *opaque, hwaddr offset, unsigned size)
     UnimplementedDeviceState *s = UNIMPLEMENTED_DEVICE(opaque);
 
     qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read  "
-                  "(size %d, offset 0x%" HWADDR_PRIx ")\n",
-                  s->name, size, offset);
+                  "(size %d, offset 0x%0*" HWADDR_PRIx ")\n",
+                  s->name, size, s->offset_fmt_width, offset);
     return 0;
 }
 
@@ -34,9 +34,9 @@ static void unimp_write(void *opaque, hwaddr offset,
     UnimplementedDeviceState *s = UNIMPLEMENTED_DEVICE(opaque);
 
     qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
-                  "(size %d, offset 0x%" HWADDR_PRIx
+                  "(size %d, offset 0x%0*" HWADDR_PRIx
                   ", value 0x%0*" PRIx64 ")\n",
-                  s->name, size, offset, size << 1, value);
+                  s->name, size, s->offset_fmt_width, offset, size << 1, value);
 }
 
 static const MemoryRegionOps unimp_ops = {
@@ -63,6 +63,8 @@ static void unimp_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    s->offset_fmt_width = DIV_ROUND_UP(64 - clz64(s->size - 1), 4);
+
     memory_region_init_io(&s->iomem, OBJECT(s), &unimp_ops, s,
                           s->name, s->size);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
-- 
2.21.3


