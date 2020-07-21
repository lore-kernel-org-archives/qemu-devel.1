Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6086CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 302C62073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roGUg0Gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302C62073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrSV-0008PX-EN
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxrRA-00078o-Sp
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:32:00 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxrR9-0003St-B7
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:32:00 -0400
Received: by mail-wm1-x343.google.com with SMTP id o8so2640945wmh.4
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 05:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=75TNpvx2vRfiJZkHz29WviDSGKNpx3q3QnPcdwR4bAg=;
 b=roGUg0GwSG38IQaEk0A5FULH+vj83dR0bBr2Tg2b42GYz0anVbt8CfwR00v5+3AKQo
 EmUjMrILgxE5KR4g8ps8rbVZaHptFxR3BFZubad79jYsKiywg7WY54ns/ok0l9Wb9qpu
 Mc9l47Ejmoy2y514N1UYS/N8ZdRMBm1B6rosySb9G4YhI5wyT9M6FPETt4zf8nwwIsNy
 UpBdieoCaaV8hIuwQqn7Hrie4k8uncli1gOxkEZmyf4U9xKw7b87sy9sHMEcipGLxab9
 nz8H7yUl4rWlNgqbL82p4APW9dXrgAyalztG1WvFiQbaRY7gXO0zYkAbT7q+3TndXFi2
 Ehdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=75TNpvx2vRfiJZkHz29WviDSGKNpx3q3QnPcdwR4bAg=;
 b=g5Zgldv5P1+ZCsfARI/ufCs1aiGuEgTycOqveHruDqPGOvadlknGrpBbAbDNH3o7CW
 zlOHSoZu4mmxkFJfdeR3r14AiEzAdBuouMdUtViHiFMZ3hh5mKRrlY9nE8I5bgBoI0Pd
 G1MxY1O64dMXR4KKHt46JfyC3TyRsky1gI4FDrOc9DJw2GnCJCXZQLi61vgZBO87ip/S
 1AcV0pBoOEtWQ+VJdtyWDoIafQvx0ECHHqbsD+V7gpm7+h549j9922nfH1Y5e78JPalh
 qFOADJ5ClYDw4MpyQ4w/AXcRmH/PI7jzNpD6/cYpvbrBxG2z1uS7pz8w3Ph9H+POuBES
 99EQ==
X-Gm-Message-State: AOAM531yerCJrZDmT7b9GjIIRtuVujinzasGmgtmWtHgNk5F/ExKjWnS
 qxc85iGXzgInJ92Gbc7bLMb6c/Tf+Y4=
X-Google-Smtp-Source: ABdhPJySH8AagSdJz+PvTb+hWw4QuHNiKilG0A3D+g81S4+YoWWgwWmtmksiBP56VCc83RQ0U11/vg==
X-Received: by 2002:a1c:6887:: with SMTP id d129mr3756829wmc.179.1595334717602; 
 Tue, 21 Jul 2020 05:31:57 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id s15sm3523323wmj.41.2020.07.21.05.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 05:31:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.1? v3 1/2] memory: Allow monkey-patching
 MemoryRegion access sizes
Date: Tue, 21 Jul 2020 14:31:53 +0200
Message-Id: <20200721123154.5302-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200721123154.5302-1-f4bug@amsat.org>
References: <20200721123154.5302-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
 "Daniel P . Berrange" <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To fixes CVE-2020-13754, commit 5d971f9e67 refuses mismatching
sizes in memory_region_access_valid(). This gives troubles when
a device is on an ISA bus, because the CPU is free to use
8/16-bit accesses on the bus (or up to 32-bit on EISA bus),
regardless what range is valid for the device.

To allow surgical change for the 5.1 release, allow monkey
patching of the MemoryRegionOps (by making the MemoryRegion
field not const). This should be reverted after the release
and fixed in a more elegant manner.

Fixes: 5d971f9e67 ('memory: Revert "accept mismatching sizes in memory_region_access_valid"')
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/exec/memory.h |  7 ++++++-
 softmmu/memory.c      | 12 ++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 307e527835..22028af6b9 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -383,7 +383,12 @@ struct MemoryRegion {
     RAMBlock *ram_block;
     Object *owner;
 
-    const MemoryRegionOps *ops;
+    /*
+     * XXX this must be 'const' but to counter side effects of
+     * CVE-2020-13754, make it non-const to allow monkey patching
+     * the access sizes. Only allowed for QEMU release v5.1 :(
+     */
+    MemoryRegionOps *ops;
     void *opaque;
     MemoryRegion *container;
     Int128 size;
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 9200b20130..84b5c617e2 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1218,7 +1218,7 @@ static void memory_region_initfn(Object *obj)
     MemoryRegion *mr = MEMORY_REGION(obj);
     ObjectProperty *op;
 
-    mr->ops = &unassigned_mem_ops;
+    mr->ops = g_memdup(&unassigned_mem_ops, sizeof(MemoryRegionOps));
     mr->enabled = true;
     mr->romd_mode = true;
     mr->global_locking = true;
@@ -1485,7 +1485,11 @@ void memory_region_init_io(MemoryRegion *mr,
                            uint64_t size)
 {
     memory_region_init(mr, owner, name, size);
-    mr->ops = ops ? ops : &unassigned_mem_ops;
+    if (ops) {
+        mr->ops = g_memdup(ops, sizeof(MemoryRegionOps));
+    } else {
+        mr->ops = g_memdup(&unassigned_mem_ops, sizeof(MemoryRegionOps));
+    }
     mr->opaque = opaque;
     mr->terminates = true;
 }
@@ -1622,7 +1626,7 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
     mr->ram = true;
     mr->terminates = true;
     mr->ram_device = true;
-    mr->ops = &ram_device_mem_ops;
+    mr->ops = g_memdup(&ram_device_mem_ops, sizeof(MemoryRegionOps));
     mr->opaque = mr;
     mr->destructor = memory_region_destructor_ram;
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
@@ -1664,7 +1668,7 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
     Error *err = NULL;
     assert(ops);
     memory_region_init(mr, owner, name, size);
-    mr->ops = ops;
+    mr->ops = g_memdup(ops, sizeof(MemoryRegionOps));
     mr->opaque = opaque;
     mr->terminates = true;
     mr->rom_device = true;
-- 
2.21.3


