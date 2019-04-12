Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D885BC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1479218A3
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVBkuDZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1479218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42665 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF3PP-0001iL-Rd
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 17:08:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hF3NX-0000QC-Fg
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:06:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hF3NV-00056g-Uz
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:06:31 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>)
	id 1hF3NV-000566-Nu; Fri, 12 Apr 2019 17:06:29 -0400
Received: by mail-wr1-x442.google.com with SMTP id w10so13620305wrm.4;
	Fri, 12 Apr 2019 14:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=P2WQNyUSQ57RzW0BhUh2sYxUZ68LvhtaLDPgKczx1Dc=;
	b=GVBkuDZDoUch2S5UyFd7UTdIlLalrfLmBCuWEDUwkc/I2fy0TidiF5VfL0OCn20R13
	H24ExyRdCWHDBZJdjhzh2qHRJQqhvaktJf0mJBk7w6mwpzFDHnkhHeRGtJIjTMhE83J0
	pCHZRAtdHAPEyA/+2jFfCsyhGDmxQDEkPHg7Lwc8O3ncPgcFkkd2xf6ntkyFjAb/rSEt
	V3HA67MZ6VQSWOI2pCdlVJ0+f9qeSZlN+0sJWSSQZEoP0TphV6C2Yq36Lx6pzMvaFonM
	lx1a7ZW4WWW1T/V6C6Z9dFbY6pzZD8NBJmxblm81npSzofclv9nxmpJ+4SsuiQZEU743
	+2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=P2WQNyUSQ57RzW0BhUh2sYxUZ68LvhtaLDPgKczx1Dc=;
	b=SeW1hsGsqfWqxGPIRd4cfKkVCvZ92p01Fhn1YL2FSlKoFho3hi97phoikZ7Nn8Tg0W
	wZ2YBFYZ8rmNcjy1S7IP2pq7W50s2IHjjCAG3J/auuRbgba5dmMjGW56xmKKaw65eQwy
	gdGo1+l94yv5gH8Hjj/YXlzFVdVAAwVa1KOeb7cZ4X3R5VB8Gksygr+4IWKZVlheKTxP
	oC53mqXjsxHSWBjux6ytjLUoGWeNzc6J64NkV5tj0/+gnDsmKVHXK5Uo0zpZd8c7TYKa
	5Wtlx927FGdF3XBpCHE7MB2pqv6gI1Jvz9piAijCDzMIpn0qMmql/IIfu3JfPwS9ji9B
	vLwQ==
X-Gm-Message-State: APjAAAXXqpBGXlXEjaWSdqzC/dhAjyNOUySmsWl0gr5VDklEhMBG13Hz
	y8/SGpGg2V/J0LaSxmhDm0oo/wmp
X-Google-Smtp-Source: APXvYqxZHdOcVzCKdMRMZusPFErQ49Fk0N5AuDFiiLb2SqStf4MwMpDNrgL5S+2N0KXC5nOGCBcFqg==
X-Received: by 2002:a5d:4750:: with SMTP id o16mr34046381wrs.206.1555103188614;
	Fri, 12 Apr 2019 14:06:28 -0700 (PDT)
Received: from localhost (x4d0c5397.dyn.telefonica.de. [77.12.83.151])
	by smtp.gmail.com with ESMTPSA id
	c16sm11723251wme.31.2019.04.12.14.06.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 14:06:27 -0700 (PDT)
From: Artyom Tarasenko <atar4qemu@gmail.com>
To: qemu-devel@nongnu.org,
	hpoussin@reactos.org
Date: Fri, 12 Apr 2019 23:06:16 +0200
Message-Id: <1555103178-21894-3-git-send-email-atar4qemu@gmail.com>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 2/4] 40p and prep: implement PCI bus mastering
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
Cc: qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412210616.FKyxAX2yvatF87Fruqag1_du8CPwxaRASJoFpKh-4MA@z>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 hw/pci-host/prep.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 8b9e1fd..94b7465 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -62,6 +62,7 @@ typedef struct PRePPCIState {
     AddressSpace pci_io_as;
     MemoryRegion pci_io;
     MemoryRegion pci_io_non_contiguous;
+    MemoryRegion pci_io_system;
     MemoryRegion pci_memory;
     MemoryRegion pci_intack;
     MemoryRegion bm;
@@ -146,7 +147,7 @@ static uint64_t raven_io_read(void *opaque, hwaddr addr,
     uint8_t buf[4];
 
     addr = raven_io_address(s, addr);
-    address_space_read(&s->pci_io_as, addr + 0x80000000,
+    address_space_read(&s->pci_io_as, addr,
                        MEMTXATTRS_UNSPECIFIED, buf, size);
 
     if (size == 1) {
@@ -178,7 +179,7 @@ static void raven_io_write(void *opaque, hwaddr addr,
         g_assert_not_reached();
     }
 
-    address_space_write(&s->pci_io_as, addr + 0x80000000,
+    address_space_write(&s->pci_io_as, addr,
                         MEMTXATTRS_UNSPECIFIED, buf, size);
 }
 
@@ -276,14 +277,21 @@ static void raven_pcihost_initfn(Object *obj)
     MemoryRegion *address_space_mem = get_system_memory();
     DeviceState *pci_dev;
 
-    memory_region_init(&s->pci_io, obj, "pci-io", 0x3f800000);
+    memory_region_init(&s->pci_io, obj, "pci-io", UINT32_MAX);
     memory_region_init_io(&s->pci_io_non_contiguous, obj, &raven_io_ops, s,
                           "pci-io-non-contiguous", 0x00800000);
     memory_region_init(&s->pci_memory, obj, "pci-memory", 0x3f000000);
     address_space_init(&s->pci_io_as, &s->pci_io, "raven-io");
 
     /* CPU address space */
-    memory_region_add_subregion(address_space_mem, 0x80000000, &s->pci_io);
+    memory_region_add_subregion_overlap(address_space_mem, 0x0,
+                                        &s->pci_io, -1);
+
+    memory_region_init_alias(&s->pci_io_system,  obj, "pci-io-system",
+                             &s->pci_io, 0x0000000, 0x3f800000);
+
+    memory_region_add_subregion(address_space_mem, 0x80000000,
+                                &s->pci_io_system);
     memory_region_add_subregion_overlap(address_space_mem, 0x80000000,
                                         &s->pci_io_non_contiguous, 1);
     memory_region_add_subregion(address_space_mem, 0xc0000000, &s->pci_memory);
-- 
2.7.2


