Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81122C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C22E2075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OeORbVn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C22E2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBam7-0006hM-IS
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacg-0004XQ-44
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:38 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBace-0004Ij-Ai
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:37 -0400
Received: by mail-wm1-x344.google.com with SMTP id w2so299138wmi.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=O2u1tsz9QgZ+6NbKIVCGs/beVjIdsELa+9klShgDJPk=;
 b=OeORbVn3ayh7bMtuBuEKVZqSfrFTKE3ujO7uTBOudAs7fSTPVNvAFEik3ZZQMrzCIK
 9rdcaNBNbiIgjf1KQjLUqi2Q6uhV5j6BY/Pr4Nu231WSSCdntwsydyKuhnz4642aaXB6
 +F9WuUMSQST27wQOTK/FK417L2IOpUZjanHorreCYwxczCGfzGwqkS6hVHXZyfjGKNkw
 SlY5Gt0S0qmQPqAX4StywEDtLxfeesnH47TFw8DrKITLslSn3wcCKDkoDpgdcWJU7teF
 hFdjC68Q9OSrd5p9mnIZ8vNbQ1bgo8lY1EOgKR/WWAmLaXye96muVc+IwMw0uwpU1lzz
 5sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O2u1tsz9QgZ+6NbKIVCGs/beVjIdsELa+9klShgDJPk=;
 b=UsGqrL9xyWiwc6PLiFsilUNbS8/XZylQKayLE5qAMLZE/GPOfRaMhZcWR/P3gSYrJW
 tEwZsJ74yAPYBDHnYaBVR3dtMdgUq8e+JW5tob2r+BASlSR9RWTknrDKtCvVtPIGiMSi
 QYgzOTthjmbN4UC6ZWVDHhaVS4bJXTNJKaMcWxaDirIugt5nnXsP1iJ3jzDN/tl4Sggf
 SzDA2ax8pSNMCSXPpaGiU8vNWl5CjF+2mTQ2GTPDeZTCdnwjHns+tHvlkHbe2nRFufb6
 RhWRwWqHWmPSIXL1sn6BJCVZG3jP/UxLZ+v7nZr8G4bGAoCnYH7U6xZ0Wu4+5Tklbn4j
 5fqg==
X-Gm-Message-State: AOAM5335Y+aY+hrSuVpmwmLfsCTmWdr8HAgGqKTEcn/U8mfOcaN3WeF6
 Xge8CXUytD4OmBDAfd7vMZkuHPbRgI95EXMW
X-Google-Smtp-Source: ABdhPJwON4mYzKY0BEp5JhfNcY2KkfmdI91b7bGXXdplqc5NoDa4wk3IJgF6qw60RVtXDuwso0IQuA==
X-Received: by 2002:a7b:c342:: with SMTP id l2mr656411wmj.153.1598606674649;
 Fri, 28 Aug 2020 02:24:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/35] hw/misc/unimp: Display the offset with width of the
 region size
Date: Fri, 28 Aug 2020 10:23:55 +0100
Message-Id: <20200828092413.22206-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

To have a better idea of how big is the region where the offset
belongs, display the value with the width of the region size
(i.e. a region of 0x1000 bytes uses 0x000 format).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200812190206.31595-4-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/unimp.h |  1 +
 hw/misc/unimp.c         | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
index 4c1d13c9bf8..c63968a2cda 100644
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
index b4b318db1c3..6cfc5727f0b 100644
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
2.20.1


