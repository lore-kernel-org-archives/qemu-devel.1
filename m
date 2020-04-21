Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3417C54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0192070B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzVKn+D0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0192070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQs47-0003bZ-I7
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpf-0005YM-P5
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpf-0006e7-4H
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:16:55 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpe-0006V0-JR; Tue, 21 Apr 2020 08:16:54 -0400
Received: by mail-wm1-x342.google.com with SMTP id v4so2389855wme.1;
 Tue, 21 Apr 2020 05:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MYojzKJL3MzJX+X4CMNSUQHgAXt7TO+oqY6sRewqpC0=;
 b=fzVKn+D0xJbCPZzxfr5U2LpSjA4e1Y0zk1LtDoVL1TsYHRVgw0xYnPTsmuQLzlQAgW
 BX5BjKAf9yW34McU2o5Jr/EW38HwcUonDKiIt/ZUyALW5NT1a2/xJhILFAs1RgYDyHPr
 3L65KM+7dS0/A3SQc8W53lPviMVGnBpPqQ6eQLRyLIDiIOha7YyU64KnyQ096unvROwW
 OyABNYsOcFBVJiZeCRXwsvU7FYLZ+C5Fl9ZJns290xdf+HpdmCr6xC3BSY7WNq2Y4e1w
 f1d0ntp9la7vUXrYpFxj0BNOCAq6tgEd6lNd3e0GgTPEaPRw1FWnvskEGDTLBJybPnPB
 Ik+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=MYojzKJL3MzJX+X4CMNSUQHgAXt7TO+oqY6sRewqpC0=;
 b=loImYDtebiY4Uiv3C6D+EDYpECycvoU+VcasgoO1TwehOwJnjOE4rExDt7HOpG7+kK
 Evy16PXqMDCee03f1qMTIZ86KQZg75JErrA40cW4Q/Lvxk4ad4lfpBQ5YXP3eR3esQvC
 clM/QIOmcLUur+eW3+87SnXUutjjfntxq8upywE6VNIFESAkk/CnzpQOgNiQqkRn2pDw
 Fwk6P+SNc/ahugIX2IpHqykmCDzHB392YKgU6r2qDmfb+RxhSyAJvkxXs88r8wGbyGrt
 tlNWooAFT28CUUzhrmyOpptopEGl2z8z5vnE+lA8V6hR1hN5d76LDHOXq6P6aJLuksUS
 zCIQ==
X-Gm-Message-State: AGi0PuaVnMbRL4OACjRDUEVnRimT5shBvoayurWlBDsMzKqA80qRbQ1v
 EeELzlhbv9AmuwdJ3XaYXKk8gCv0jXo=
X-Google-Smtp-Source: APiQypLGUzA5fTPwIDwshylPJXVc2vLwZbwTc2zBEuIOwVWZEqL+BjA6yfsM/73YDpi4q3ZnYR9P3A==
X-Received: by 2002:a1c:2dc7:: with SMTP id t190mr4368526wmt.129.1587471411914; 
 Tue, 21 Apr 2020 05:16:51 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z76sm3761140wmc.9.2020.04.21.05.16.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 05:16:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 12/17] hw/misc/bcm2835_property: Hold the temperature in
 the device state
Date: Tue, 21 Apr 2020 14:16:21 +0200
Message-Id: <20200421121626.23791-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421121626.23791-1-f4bug@amsat.org>
References: <20200421121626.23791-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, John Snow <jsnow@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to modify this variable, move it to the device state.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/bcm2835_property.h | 1 +
 hw/misc/bcm2835_property.c         | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/hw/misc/bcm2835_property.h b/include/hw/misc/bcm2835_property.h
index b321f22499..010ad39ed0 100644
--- a/include/hw/misc/bcm2835_property.h
+++ b/include/hw/misc/bcm2835_property.h
@@ -31,6 +31,7 @@ typedef struct {
     uint32_t board_rev;
     uint32_t addr;
     bool pending;
+    float64 temp_mC;
 } BCM2835PropertyState;
 
 #endif
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 3e228ca0ae..bbe80affd4 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -143,7 +143,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
         /* Temperature */
 
         case 0x00030006: /* Get temperature */
-            stl_le_phys(&s->dma_as, value + 16, 25000);
+            stl_le_phys(&s->dma_as, value + 16, s->temp_mC);
             resplen = 8;
             break;
 
@@ -361,12 +361,13 @@ static const MemoryRegionOps bcm2835_property_ops = {
 
 static const VMStateDescription vmstate_bcm2835_property = {
     .name = TYPE_BCM2835_PROPERTY,
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields      = (VMStateField[]) {
         VMSTATE_MACADDR(macaddr, BCM2835PropertyState),
         VMSTATE_UINT32(addr, BCM2835PropertyState),
         VMSTATE_BOOL(pending, BCM2835PropertyState),
+        VMSTATE_FLOAT64(temp_mC, BCM2835PropertyState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -375,6 +376,7 @@ static void bcm2835_property_init(Object *obj)
 {
     BCM2835PropertyState *s = BCM2835_PROPERTY(obj);
 
+    s->temp_mC = 25e3;
     memory_region_init_io(&s->iomem, OBJECT(s), &bcm2835_property_ops, s,
                           TYPE_BCM2835_PROPERTY, 0x10);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
-- 
2.21.1


