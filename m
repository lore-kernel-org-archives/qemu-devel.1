Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B54C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 21:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683A320652
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 21:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKYCBToE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683A320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32849 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hN1px-0004qF-N9
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 17:04:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hN1oI-0003sM-9x
	for qemu-devel@nongnu.org; Sat, 04 May 2019 17:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hN1oH-0004ce-Bp
	for qemu-devel@nongnu.org; Sat, 04 May 2019 17:03:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>)
	id 1hN1oH-0004c0-5V; Sat, 04 May 2019 17:03:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id f7so1836911wrq.1;
	Sat, 04 May 2019 14:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=O8KrwKkFlyf9Fo/o8AuY7bvoRhwFJvmFsOOmHrvIPIM=;
	b=bKYCBToEgd/UUd8dMqndb/J6K1pj+kX65YEdWJeX0fdIUzDO/SjvvrGFi8KteUudhq
	wtqlu8ULd2AJIZ+NkgcP+mXGG7V3WpZX4AcoFasp66LMwBT/qSSNHU+djJXzxGRHPIgk
	0ApyzxD78NsR7vniFZx3e3MiDbVSfjLINnBaXI99vPhf90HSH9clEObuxsdfjySnBWlJ
	WI+LMrkGU0spMOpHIVKrQ+UvRY5tw9kmZAcQVxAt5JZ1+7n6zOGHdS7o98HJfStA/tYp
	SoIYcXM5E+3tLWnZE61E/tgr0jOZcEnTNVRzUBVm7q5EIorXhAIugJtakAp0BolwYf8N
	zpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=O8KrwKkFlyf9Fo/o8AuY7bvoRhwFJvmFsOOmHrvIPIM=;
	b=QAlsDDwDorlKU93wPCSTmCrzUhdj/+MLggo4W7KRCIsjT0w/blmEDMykuAyf3OJsVx
	qAWdRTwuZ+ebKmMkHV39ZIcehJ+JcRMWvpNG0HPUZeaT6lKbrt/4B8WmpSIPZNzaIapf
	WIEWLew0q+q4ivVEiMokm+lNroQlXq85yswxiEVfjmuxDcMf7zwbJ7JKd5Ny3fIMe7qH
	F3zIXo75EpXKrnoWtCdnvpdGCXBVpBrr2wmKqtMuf4LnMeclQOtGZfGeRqno+QZmYEE8
	6lTRrLG/ALkDQAdD1OlNB8Hl4KjTbeNY46Et71E84eoHbyjgWRA1bzhXEFahRqPjW6Yi
	6ASA==
X-Gm-Message-State: APjAAAXHixDlR3d2p8c9q9fT9IPLUEL+6lXJFo3cmBM0vombCm3SAdeu
	BeoTWgKI/eq+1Dgzfy3XSH5gsQsg
X-Google-Smtp-Source: APXvYqxpRvxTubySKUudZe21nP3YO7Mi9Rx5p4M1JIQdyJ3gId6EP29lbcuboicllpbDJTMizxpeXQ==
X-Received: by 2002:adf:fb11:: with SMTP id c17mr11992209wrr.237.1557003783958;
	Sat, 04 May 2019 14:03:03 -0700 (PDT)
Received: from localhost ([46.114.6.7]) by smtp.gmail.com with ESMTPSA id
	w10sm5436589wrv.90.2019.05.04.14.03.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 04 May 2019 14:03:02 -0700 (PDT)
From: Artyom Tarasenko <atar4qemu@gmail.com>
To: qemu-devel@nongnu.org,
	hpoussin@reactos.org
Date: Sat,  4 May 2019 23:02:33 +0200
Message-Id: <1557003754-26473-3-git-send-email-atar4qemu@gmail.com>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1557003754-26473-1-git-send-email-atar4qemu@gmail.com>
References: <1557003754-26473-1-git-send-email-atar4qemu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 2/3] 40p and prep: implement PCI bus mastering
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
Cc: "open list:PReP" <qemu-ppc@nongnu.org>,
	Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504210233.GTeNWGoI58MtUa7zAV2b8Ur9yYxAL8BzG_5pFXbjidc@z>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
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


