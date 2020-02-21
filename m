Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3312EC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F351B208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDGCXH60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F351B208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58Vb-0004cL-3N
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:38:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j58Jk-00032r-Lk
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j58Jj-0007RA-5J
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:26:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24507
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j58Jj-0007Oi-0R
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582291560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cMOXko/4H0FB0S7u3dYzICgeqoNZW5DiwbZ8PiLJoXI=;
 b=CDGCXH604QY7wRTvtKgJiPnNmS6hgCSdAEmsS5J4EEiPmn2c4VmiYHoPsGcdohT9OOobR0
 XnyCi8jIBgggeKFSg1m18Xa86FYcTDv6Xpp0LbtmMvVeQhCRMcPza9i33SOcQNOpgtY4bf
 HnqNZ3xJpNoV2bUOWvUmULHD49I9ALA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-N3A-jZskOpi5RdEk2JQk_A-1; Fri, 21 Feb 2020 08:25:58 -0500
X-MC-Unique: N3A-jZskOpi5RdEk2JQk_A-1
Received: by mail-wm1-f70.google.com with SMTP id q125so571169wme.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:25:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hcg1mTPNvTqu5kw0kpHNtRAtcOajm8vfSJTKD9bWkbM=;
 b=P08dPs+cqYM0TQd2gLLTluIZx5W+983qBCx1bQUP9LUkPTHIWuz+o9Cygc2LmIhphW
 L8T0PVza/usMLArJz0V/4kDETyI0/r0SYcrv7ONMw24MZ7FuZDYzQUam+eRRJ5FnW4Te
 v03H1wepEAlgNzmcFAxczjGg6O0Lv6cflSwatrwwSmPKBMgACOjJ8rJexJ6f/Lo4KO7c
 LFA1S/3Nufb4pF0ZA1LbFztAJ2DbrFZSS4E7uMa13dbKouoJNiEQAeNP4a12anzvWYVp
 e9V03yexY9pntsX3JOqEbfkmnvD3eywX6ke4IpRbeewx3k/NUyrp4l8UdPAOaN0qdTdY
 b7yQ==
X-Gm-Message-State: APjAAAXDCEh0qOrss6f4ZfifsGZuuwaI3+LEfexu9CC9FXNy98Fz4KoW
 LLpKk6mXTDRevKeVBqwoe5rX6uA2hSlmkCNkFPBBzYOllZ8XJEQ9YxsaqWf+hEZhN6bI8Y+b7nI
 IDXSVJV8aGcDWRuc=
X-Received: by 2002:adf:f80c:: with SMTP id s12mr49130629wrp.1.1582291557231; 
 Fri, 21 Feb 2020 05:25:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZ8zRwQjRSOapQpvHA7eWW8PLfsp1CYzT1rJ38J4VZUnRLds4ZKYRE30wnQupHSJYRW3+npQ==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr49130596wrp.1.1582291556925; 
 Fri, 21 Feb 2020 05:25:56 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id t13sm3947679wrw.19.2020.02.21.05.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:25:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] hw/net/pcnet: Let phys_mem_read/write take void pointer
 and boolean
Date: Fri, 21 Feb 2020 14:25:50 +0100
Message-Id: <20200221132550.22156-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200221132550.22156-1-philmd@redhat.com>
References: <20200221132550.22156-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both PCNetState::phys_mem_read/write handlers end calling
dma_memory_read/write, which both take void pointers (since
introduced in commit d86a77f8). The PCNetState phys_mem_read/write
handlers can take a void pointer too.
As the length is always a sizeof(), use a size_t type.
The 'do_bswap' is used as a boolean argument. Use an explicit
boolean type.

The changes in hw/net/pcnet.c are produced using the following
Coccinelle script:

    @@
    expression E1, E2, E3, E4;
    @@
    (
    - s->phys_mem_read(E1, E2, (void *)(E3), E4, 0);
    + s->phys_mem_read(E1, E2, E3, E4, false);
    |
    - s->phys_mem_write(E1, E2, (void *)(E3), E4, 0);
    + s->phys_mem_write(E1, E2, E3, E4, false);
    |
    - s->phys_mem_read(E1, E2, (void *)(E3), E4, 1);
    + s->phys_mem_read(E1, E2, E3, E4, true);
    |
    - s->phys_mem_write(E1, E2, (void *)(E3), E4, 1);
    + s->phys_mem_write(E1, E2, E3, E4, true);
    )

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/net/pcnet.h                 |  4 ++--
 include/hw/sparc/sparc32_dma.h |  4 ++--
 hw/dma/sparc32_dma.c           |  4 ++--
 hw/net/pcnet-pci.c             |  5 +++--
 hw/net/pcnet.c                 | 16 ++++++++--------
 5 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/hw/net/pcnet.h b/hw/net/pcnet.h
index f49b213c57..3f15e6f065 100644
--- a/hw/net/pcnet.h
+++ b/hw/net/pcnet.h
@@ -47,9 +47,9 @@ struct PCNetState_st {
     uint8_t buffer[4096];
     qemu_irq irq;
     void (*phys_mem_read)(void *dma_opaque, hwaddr addr,
-                         uint8_t *buf, int len, int do_bswap);
+                          void *buf, size_t len, bool do_bswap);
     void (*phys_mem_write)(void *dma_opaque, hwaddr addr,
-                          uint8_t *buf, int len, int do_bswap);
+                           const void *buf, size_t len, bool do_bswap);
     DeviceState *dma_opaque;
     int tx_busy;
     int looptest;
diff --git a/include/hw/sparc/sparc32_dma.h b/include/hw/sparc/sparc32_dma.=
h
index b3811b617d..db42f7440d 100644
--- a/include/hw/sparc/sparc32_dma.h
+++ b/include/hw/sparc/sparc32_dma.h
@@ -58,8 +58,8 @@ typedef struct SPARC32DMAState {
=20
 /* sparc32_dma.c */
 void ledma_memory_read(void *opaque, hwaddr addr,
-                       uint8_t *buf, int len, int do_bswap);
+                       void *buf, size_t len, bool do_bswap);
 void ledma_memory_write(void *opaque, hwaddr addr,
-                        uint8_t *buf, int len, int do_bswap);
+                        const void *buf, size_t len, bool do_bswap);
=20
 #endif
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index fbe58b8fea..629f9830f7 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -72,7 +72,7 @@ enum {
=20
 /* Note: on sparc, the lance 16 bit bus is swapped */
 void ledma_memory_read(void *opaque, hwaddr addr,
-                       uint8_t *buf, int len, int do_bswap)
+                       void *buf, size_t len, bool do_bswap)
 {
     DMADeviceState *s =3D opaque;
     IOMMUState *is =3D (IOMMUState *)s->iommu;
@@ -93,7 +93,7 @@ void ledma_memory_read(void *opaque, hwaddr addr,
 }
=20
 void ledma_memory_write(void *opaque, hwaddr addr,
-                        uint8_t *buf, int len, int do_bswap)
+                        const void *buf, size_t len, bool do_bswap)
 {
     DMADeviceState *s =3D opaque;
     IOMMUState *is =3D (IOMMUState *)s->iommu;
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index d1f31e0272..4e4d60b046 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -167,13 +167,14 @@ static const MemoryRegionOps pcnet_mmio_ops =3D {
 };
=20
 static void pci_physical_memory_write(void *dma_opaque, hwaddr addr,
-                                      uint8_t *buf, int len, int do_bswap)
+                                      const void *buf, size_t len,
+                                      bool do_bswap)
 {
     pci_dma_write(dma_opaque, addr, buf, len);
 }
=20
 static void pci_physical_memory_read(void *dma_opaque, hwaddr addr,
-                                     uint8_t *buf, int len, int do_bswap)
+                                     void *buf, size_t len, bool do_bswap)
 {
     pci_dma_read(dma_opaque, addr, buf, len);
 }
diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index f3f18d8598..d669ca2aa3 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -305,14 +305,14 @@ static inline void pcnet_tmd_load(PCNetState *s, stru=
ct pcnet_TMD *tmd,
             int16_t length;
             int16_t status;
         } xda;
-        s->phys_mem_read(s->dma_opaque, addr, (void *)&xda, sizeof(xda), 0=
);
+        s->phys_mem_read(s->dma_opaque, addr, &xda, sizeof(xda), false);
         tmd->tbadr =3D le32_to_cpu(xda.tbadr) & 0xffffff;
         tmd->length =3D le16_to_cpu(xda.length);
         tmd->status =3D (le32_to_cpu(xda.tbadr) >> 16) & 0xff00;
         tmd->misc =3D le16_to_cpu(xda.status) << 16;
         tmd->res =3D 0;
     } else {
-        s->phys_mem_read(s->dma_opaque, addr, (void *)tmd, sizeof(*tmd), 0=
);
+        s->phys_mem_read(s->dma_opaque, addr, tmd, sizeof(*tmd), false);
         le32_to_cpus(&tmd->tbadr);
         le16_to_cpus((uint16_t *)&tmd->length);
         le16_to_cpus((uint16_t *)&tmd->status);
@@ -339,7 +339,7 @@ static inline void pcnet_tmd_store(PCNetState *s, const=
 struct pcnet_TMD *tmd,
                                 ((tmd->status & 0xff00) << 16));
         xda.length =3D cpu_to_le16(tmd->length);
         xda.status =3D cpu_to_le16(tmd->misc >> 16);
-        s->phys_mem_write(s->dma_opaque, addr, (void *)&xda, sizeof(xda), =
0);
+        s->phys_mem_write(s->dma_opaque, addr, &xda, sizeof(xda), false);
     } else {
         struct {
             uint32_t tbadr;
@@ -358,7 +358,7 @@ static inline void pcnet_tmd_store(PCNetState *s, const=
 struct pcnet_TMD *tmd,
             xda.tbadr =3D xda.misc;
             xda.misc =3D tmp;
         }
-        s->phys_mem_write(s->dma_opaque, addr, (void *)&xda, sizeof(xda), =
0);
+        s->phys_mem_write(s->dma_opaque, addr, &xda, sizeof(xda), false);
     }
 }
=20
@@ -371,14 +371,14 @@ static inline void pcnet_rmd_load(PCNetState *s, stru=
ct pcnet_RMD *rmd,
             int16_t buf_length;
             int16_t msg_length;
 =09} rda;
-        s->phys_mem_read(s->dma_opaque, addr, (void *)&rda, sizeof(rda), 0=
);
+        s->phys_mem_read(s->dma_opaque, addr, &rda, sizeof(rda), false);
         rmd->rbadr =3D le32_to_cpu(rda.rbadr) & 0xffffff;
         rmd->buf_length =3D le16_to_cpu(rda.buf_length);
         rmd->status =3D (le32_to_cpu(rda.rbadr) >> 16) & 0xff00;
         rmd->msg_length =3D le16_to_cpu(rda.msg_length);
         rmd->res =3D 0;
     } else {
-        s->phys_mem_read(s->dma_opaque, addr, (void *)rmd, sizeof(*rmd), 0=
);
+        s->phys_mem_read(s->dma_opaque, addr, rmd, sizeof(*rmd), false);
         le32_to_cpus(&rmd->rbadr);
         le16_to_cpus((uint16_t *)&rmd->buf_length);
         le16_to_cpus((uint16_t *)&rmd->status);
@@ -405,7 +405,7 @@ static inline void pcnet_rmd_store(PCNetState *s, struc=
t pcnet_RMD *rmd,
                                 ((rmd->status & 0xff00) << 16));
         rda.buf_length =3D cpu_to_le16(rmd->buf_length);
         rda.msg_length =3D cpu_to_le16(rmd->msg_length);
-        s->phys_mem_write(s->dma_opaque, addr, (void *)&rda, sizeof(rda), =
0);
+        s->phys_mem_write(s->dma_opaque, addr, &rda, sizeof(rda), false);
     } else {
         struct {
             uint32_t rbadr;
@@ -424,7 +424,7 @@ static inline void pcnet_rmd_store(PCNetState *s, struc=
t pcnet_RMD *rmd,
             rda.rbadr =3D rda.msg_length;
             rda.msg_length =3D tmp;
         }
-        s->phys_mem_write(s->dma_opaque, addr, (void *)&rda, sizeof(rda), =
0);
+        s->phys_mem_write(s->dma_opaque, addr, &rda, sizeof(rda), false);
     }
 }
=20
--=20
2.21.1


