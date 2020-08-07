Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E03C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:39:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 179E7221E2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX4f8Kpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179E7221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k43X0-0000qH-8d
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 10:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k43Ug-0005ts-4a
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:37:14 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k43Ue-00069q-Kg
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:37:13 -0400
Received: by mail-wr1-x443.google.com with SMTP id p20so1904869wrf.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 07:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c1wqr83siBKkTr1lZogc8mpCg6xKQgSxzHaWY2qWLvc=;
 b=YX4f8KpgIQJoJ1eS7dCRcZtLpq+YjANEiHczrYuB1eCVDAPjMBz7cSsVqgUGeTmhV2
 pyEjmE2s0+NAEQKMUfdio07n6+bQiUbfvtGMVRJgL+FeOBTZ/AqsOUlM5SOSUj8WSRc7
 cFuSAqNK1FzxFD+imI6wsozQDlFDfKSSFKE/Nj8ik4VAZfaJnrTqVrGgeTj4wqND4bIJ
 b+YDqDSJuUiPC8vOrOkSNJCMRE1prJfpiniPK3f27GetF6FN1MKNY/D44z5JoZTbriHA
 qjjhMSpT1rP3pKndQ8uAwNwfymUPUpdh3zrd+dNiuyTjDa4aWVnFBimTXMC8oSjfgi/q
 OqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=c1wqr83siBKkTr1lZogc8mpCg6xKQgSxzHaWY2qWLvc=;
 b=HpR3lRhi33RYMZOlHIhYZVvCY7C+cA+mwoqWwD8eKvhaj6VijQQJo/4mEoqEce7tsn
 JrcD6QmzHfHBbtXyZ88tm//L7lOw+ckXJFUxOff3kGH+p+sGpGX+0f6HNPBZ1mzHPRy0
 zWQNFvrmfxsPN1lxJlzHLVvQ51cJWEGjoOx9PBaGWsMOp0fpnyVat5rrORimShd+v3nN
 II/JNGIWijLfV2lpi0QjiY8FJ3dduhmUGduwIg28e4sY5WkUs31YWh3bFNk5WlSJY9pf
 Hh6ka4Vrc58dMxMkSXJZV/rsKDRl4vGJTPnPBIlzaUNL4rYmxBOQ51UnvfnBrqfrIa50
 S6Cw==
X-Gm-Message-State: AOAM532G0T9yisw1y+DkobnqT2ey8dB6XwKu9//zHrLmJwxqzLWoN5mm
 mgyzbPhPPMB/7Z6Rj0QVlKicZ1JJ
X-Google-Smtp-Source: ABdhPJzpSpqmiXaAqb2crFdXfPhoXjF7Py1EhyYxMSc9zGty9lZ3BeWR4zrdcTjuizNEeJ4E5Z1V0A==
X-Received: by 2002:a5d:5086:: with SMTP id a6mr12343263wrt.304.1596811030909; 
 Fri, 07 Aug 2020 07:37:10 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id v8sm11033302wmb.24.2020.08.07.07.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 07:37:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 3/3] hw/misc/unimp: Display the offset with width of
 the region size
Date: Fri,  7 Aug 2020 16:37:05 +0200
Message-Id: <20200807143705.30066-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200807143705.30066-1-f4bug@amsat.org>
References: <20200807143705.30066-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To have a better idea of how big is the region where the offset
belongs, display the value with the width of the region size
(i.e. a region of 0x1000 bytes uses 0x000 format).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
index b4b318db1c..7146bfaf77 100644
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
 
+    s->offset_fmt_width = ROUND_UP(64 - clz64(s->size - 1), 4) >> 2;
+
     memory_region_init_io(&s->iomem, OBJECT(s), &unimp_ops, s,
                           s->name, s->size);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
-- 
2.21.3


