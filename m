Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC5DC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D3720726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoJylWQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D3720726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aAW-0004zj-Ky
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0N-0003m7-91
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0L-0003bz-RW
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:03 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:55466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z0L-0003aA-Fm
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:01 -0500
Received: by mail-wm1-x32a.google.com with SMTP id q9so2725889wmj.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=csaz6EWYSUAGW56iw1bBi4B8rdtTGAfL4TV0/l5kdm0=;
 b=RoJylWQGsk8qWfU/LQS10QCexk88DwoH2/S7s6zXbFqACkUwGGYFWE3lVsQ79W9RQe
 gefoIlxyPhgBkjYXqNBCCy6TwZNLIndwEC44xgRFcnuaR8xVlOXUUM9kEuJ54wWXe5qS
 BMzcxsk0gLWMBzc4VILQkAqtzE+TUgoezdw3X6KLn+tDOtIrpv0uPrZ/mGSiZP2a84Yl
 O1u6GsCTW4bZpoxoRKe31D3sQDCg0URsylhnu2bwoZ+Sxnun715odrRPxkiJbnxsy9BW
 LkPaIIDhNLfHkCFYJWRKs4WVhMi900v/D6TfzUw/MO7iZ4+K6G2pWkXDVYxc/hKsUwDU
 QJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=csaz6EWYSUAGW56iw1bBi4B8rdtTGAfL4TV0/l5kdm0=;
 b=WphTFHAaP00L+B4mYptofTuXx/QlKaI2efteETQRzNcbLl24KcutwV4kDrA5TaqNsH
 MtUjq4tedmPpOFoXqkRNhskQuNc9mEj0c4L88/+b104lyGeyR7xahZH0r1tSb2nQL5IK
 68TWWE9DH0MLxHOAYmJC7AIBlWcIstlBQWv7+N24paLiuM9Yw7LimKcuAbehmJIjFrEy
 2izUB8wfaPv7ckL82wioQ+ZrbqqRGOC4tkmDdWCrJ/pRUfe/nhM2DfYgKZeSpXlne7ss
 eEENfggKNZhDdiC07Qr1Y9dBMvGekMXrnzohOLGsdsG/EK46rEztIqDXoEBbDdY9ng8F
 sEsw==
X-Gm-Message-State: APjAAAVow9P9hBNS18r0LS07+jE495HJsNqM3qaI3AhWEEfRW31IIkjK
 jgoDm+9tw+l8RnKWQGnUBOrK+ix8
X-Google-Smtp-Source: APXvYqzObSq+S1DCv7i4wfcKhV5Gi3t9TwGZQvf6psz+m3jcDiToxljk8h3xgxW2cgPAJId4eQkJvw==
X-Received: by 2002:a05:600c:2042:: with SMTP id
 p2mr5199379wmg.79.1582632478209; 
 Tue, 25 Feb 2020 04:07:58 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.07.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:07:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 125/136] hw/dma: Let devices own the MemoryRegion they create
Date: Tue, 25 Feb 2020 13:07:23 +0100
Message-Id: <1582632454-16491-23-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Avoid orphan memory regions being added in the /unattached QOM
container.

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-28-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 hw/dma/i8257.c  | 2 +-
 hw/dma/rc4030.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index bad8deb..ef15c06 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -553,7 +553,7 @@ static void i8257_realize(DeviceState *dev, Error **errp)
     I8257State *d = I8257(dev);
     int i;
 
-    memory_region_init_io(&d->channel_io, NULL, &channel_io_ops, d,
+    memory_region_init_io(&d->channel_io, OBJECT(dev), &channel_io_ops, d,
                           "dma-chan", 8 << d->dshift);
     memory_region_add_subregion(isa_address_space_io(isa),
                                 d->base, &d->channel_io);
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index c4cf823..f62eb3d 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -679,9 +679,9 @@ static void rc4030_realize(DeviceState *dev, Error **errp)
     s->periodic_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                      rc4030_periodic_timer, s);
 
-    memory_region_init_io(&s->iomem_chipset, NULL, &rc4030_ops, s,
+    memory_region_init_io(&s->iomem_chipset, o, &rc4030_ops, s,
                           "rc4030.chipset", 0x300);
-    memory_region_init_io(&s->iomem_jazzio, NULL, &jazzio_ops, s,
+    memory_region_init_io(&s->iomem_jazzio, o, &jazzio_ops, s,
                           "rc4030.jazzio", 0x00001000);
 
     memory_region_init_iommu(&s->dma_mr, sizeof(s->dma_mr),
-- 
1.8.3.1



