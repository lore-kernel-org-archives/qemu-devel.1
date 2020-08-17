Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69860C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFF82086A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDmLqWpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFF82086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hth-0007jO-AZ
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7hqg-00027Y-Fa
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:19:02 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53324)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7hqe-00052c-BY
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:19:01 -0400
Received: by mail-wm1-x343.google.com with SMTP id g8so13720220wmk.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 09:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gQrQ4Zm+ysqESM94lYurHAkeaDr7/WAxSOhUyFwAMeI=;
 b=VDmLqWpaLHoj78QfdtHN//dAvoL1aSZrzumiprXHKAKq6ZFsJ8QKLY1C92py6vlILI
 Q+ftEvSdP2rczU3MhmAUu1+mYnrTTWxtvBZvItN1MdRwWUPlaDwgXIZIdRRe2S949NSq
 2S41yETPZSv3jXZ8MReHNE/GBttdpXtzRd9s8hVocQC2EzuHiU84x3M5asvdILi7CCZO
 cboh+YcoGTbPRsyeud72n6NLoziuyl9YVEKW3BAuvxWwoeLpj+8qGiPS6edyD3LqLr6C
 7rVwWbj1xppzuP18Cwq2ukvQDp4tzoLjenY+Jofd1A6ft4M/Q0kzcT4Tndnq/fiDrE78
 c7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gQrQ4Zm+ysqESM94lYurHAkeaDr7/WAxSOhUyFwAMeI=;
 b=FlvQHuZGSSwzZUrMBzPGGvdeOyB3JzVgHMJxxtiXOWmONAy4dQzcu/bfhahsDQG99X
 f65S//fX2kESJaZGNLGEdu9353KgnysxVIYbxOecWUJsZSRvWeuuFAMUi6FUWdSsI4T0
 t9FGkK8vj3QxsjpWjGnULGrvWVc6SWRZk845tVTJdvGxOstblWPWPF7drpaYxUvnf6L5
 mrO/Wki6zZg0mZMOM2bBYwx7af99BgFXBCGmuExhyqbADaDFOQRtkCPuLThs9l07KeeV
 C2pBkX+yIfwb+EYlsF8ygR2pFxeBBm3pmsREmMJwGhNOgp3oqAgKH06GorQhPAOITDGT
 GMIw==
X-Gm-Message-State: AOAM533AaIG3y3+Tn56dNffBCA0iQY/+iJ4cXAgARqvQYRdURWhH7W2v
 pYlJ+/MsLwsWylWz50g2t08hk5Ddqq4=
X-Google-Smtp-Source: ABdhPJws79hKc5Ypc0XPLt8xa0uDbOZQrKsoDd5BCbjz+umdwB7+oJfkxmPBEeuyjRlA/KQ0B8O15w==
X-Received: by 2002:a7b:c095:: with SMTP id r21mr16311823wmh.152.1597681138166; 
 Mon, 17 Aug 2020 09:18:58 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id r3sm29535472wro.1.2020.08.17.09.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 09:18:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH 1/9] memory: Initialize MemoryRegionOps for RAM memory
 regions
Date: Mon, 17 Aug 2020 18:18:45 +0200
Message-Id: <20200817161853.593247-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817161853.593247-1-f4bug@amsat.org>
References: <20200817161853.593247-1-f4bug@amsat.org>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, P J P <ppandit@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is an issue when using memory_region_dispatch_read() or
memory_region_dispatch_write() on RAM memory regions.

RAM memory regions are initialized as:

  memory_region_init_ram()
  -> memory_region_init_ram_nomigrate()
     -> memory_region_init_ram_shared_nomigrate()
        -> memory_region_init()
           -> object_initialize(TYPE_MEMORY_REGION)
              -> memory_region_initfn()
                 -> mr->ops = &unassigned_mem_ops;

Later when accessing the alias, the memory_region_dispatch_read()
flow is:

  memory_region_dispatch_read()
  -> memory_region_dispatch_read1()
     -> if (mr->ops->read) { /* not taken */ } else ...
        -> access_with_adjusted_size
           -> memory_region_read_with_attrs_accessor
              -> memory_region_dispatch_read
                 -> unassigned_mem_read
              <- MEMTX_DECODE_ERROR

The caller gets a MEMTX_DECODE_ERROR while the access is OK.
(Similar flow with memory_region_dispatch_write).

Fix by initializing the MemoryRegionOps to ram_device_mem_ops,
this way the memory accesses are properly dispatched using
memory_region_ram_device_read() / memory_region_ram_device_write().

Fixes: 4a2e242bbb ("memory: Don't use memcpy for ram_device regions")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Since v1: Corrected description (PJP)
Cc: P J P <ppandit@redhat.com>
---
 softmmu/memory.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/softmmu/memory.c b/softmmu/memory.c
index 651705b7d1..8139da1a58 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1517,6 +1517,8 @@ void memory_region_init_ram_shared_nomigrate(MemoryRegion *mr,
     Error *err = NULL;
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
+    mr->ops = &ram_device_mem_ops;
+    mr->opaque = mr;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
     mr->ram_block = qemu_ram_alloc(size, share, mr, &err);
@@ -1541,6 +1543,8 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
     Error *err = NULL;
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
+    mr->ops = &ram_device_mem_ops;
+    mr->opaque = mr;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
     mr->ram_block = qemu_ram_alloc_resizeable(size, max_size, resized,
@@ -1566,6 +1570,8 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
     Error *err = NULL;
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
+    mr->ops = &ram_device_mem_ops;
+    mr->opaque = mr;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
     mr->align = align;
@@ -1589,6 +1595,8 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
     Error *err = NULL;
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
+    mr->ops = &ram_device_mem_ops;
+    mr->opaque = mr;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
     mr->ram_block = qemu_ram_alloc_from_fd(size, mr,
@@ -1611,6 +1619,8 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
 {
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
+    mr->ops = &ram_device_mem_ops;
+    mr->opaque = mr;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
-- 
2.26.2


