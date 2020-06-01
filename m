Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB10EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 14:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A517C206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 14:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uSgMGz3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A517C206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jflWH-0000LX-S9
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 10:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jflRi-0002a2-1W; Mon, 01 Jun 2020 10:29:46 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jflRg-0002cj-CG; Mon, 01 Jun 2020 10:29:45 -0400
Received: by mail-wm1-x342.google.com with SMTP id f5so11595340wmh.2;
 Mon, 01 Jun 2020 07:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XKZlJlfX9Xx9NUQxmLIoeX0hJAW9cFlHOUMdlpNFhrg=;
 b=uSgMGz3lX/zCVeS5N2hb8kMocWnJrBQD0iyV3MRylloSoTofEcoBsiR9QFxYNgbzRV
 qh0sLJ+RiNFsR4CIT2VAg2+CO6sT0D0sdl/G2m5Iu6v6cM/TOGhGbYSr5Xo9r6pD1DWI
 jp1YxowX9bE34rtK9aLe4e++e+a7K+9LrUMvhpkWmyyTfu/5M+ku9VfHOVsT2oZAMGk3
 HGgIDmQRereUYlDCOeFKcsvo8+Dw2V7uUTFwNprKVWgTj5Q3a/RSyWhg2iXQiIdBfQbq
 Z2Of3QPTdmADNKrA5GfKeIcMFruSd5R0KWbHfTnHTzjpjE0TMDAyXSj/8s5aY1AanxyN
 xwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=XKZlJlfX9Xx9NUQxmLIoeX0hJAW9cFlHOUMdlpNFhrg=;
 b=nAvCJBYXbqhuG+a8QxDY7/A2Fj5bVMu41f2mQVxT6yF855Ra/ZCfnCnMo75QG3b7NX
 uQC3dvlLYnsv7S8OAaBxJpKpYb6KS1M8LpI9IsMQ66ujBtL8UOv8gGZrmbBcSa4Pw+KG
 mcKF/9vD7F4IXYHZ32Xdi20phqGQBRhnBRxKzgrB6m6se6/hy9GrEe/zFYOvYevPd+En
 Pi7c05FYroI1w2F4DRDUt1Y851Mq5+TXzXXbUTkQgjRDBjsGEw897EYDKQyvHdzp9R4H
 UZl379Cy3qpje2U1G2VoCtvu0zcevtSk2VROG/G81G7QzzbsqXG4sKBHzo1AId3hikpc
 2OhQ==
X-Gm-Message-State: AOAM530MW4r0Z99WWyFjB5SB5OLbQA4USjgC3OyFwuHpS71HCceKggiE
 m8YkdwHBU5dzZwfShlE6q9z9KrlT
X-Google-Smtp-Source: ABdhPJyt8wH6JL4N0YS0dHM+IbzIPnoHhEte70jcFfAz1FX5YUjQQxAFfQgPQNYsKKu4k4TKF2I/Wg==
X-Received: by 2002:a1c:f006:: with SMTP id a6mr21730886wmb.106.1591021781801; 
 Mon, 01 Jun 2020 07:29:41 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id u12sm6824954wrq.90.2020.06.01.07.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 07:29:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/8] hw/hppa/dino: Use the IEC binary prefix definitions
Date: Mon,  1 Jun 2020 16:29:28 +0200
Message-Id: <20200601142930.29408-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200601142930.29408-1-f4bug@amsat.org>
References: <20200601142930.29408-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Helge Deller <deller@gmx.de>,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

IEC binary prefixes ease code review: the unit is explicit.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/hppa/dino.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index 2b1b38c58a..7290f23962 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -542,7 +542,7 @@ PCIBus *dino_init(MemoryRegion *addr_space,
                                 &s->parent_obj.data_mem);
 
     /* Dino PCI bus memory.  */
-    memory_region_init(&s->pci_mem, OBJECT(s), "pci-memory", 1ull << 32);
+    memory_region_init(&s->pci_mem, OBJECT(s), "pci-memory", 4 * GiB);
 
     b = pci_register_root_bus(dev, "pci", dino_set_irq, dino_pci_map_irq, s,
                               &s->pci_mem, get_system_io(),
@@ -561,7 +561,7 @@ PCIBus *dino_init(MemoryRegion *addr_space,
     }
 
     /* Set up PCI view of memory: Bus master address space.  */
-    memory_region_init(&s->bm, OBJECT(s), "bm-dino", 1ull << 32);
+    memory_region_init(&s->bm, OBJECT(s), "bm-dino", 4 * GiB);
     memory_region_init_alias(&s->bm_ram_alias, OBJECT(s),
                              "bm-system", addr_space, 0,
                              0xf0000000 + DINO_MEM_CHUNK_SIZE);
-- 
2.21.3


