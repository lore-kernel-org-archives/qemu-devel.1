Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E382C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60D02074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60D02074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEDvj-0004WD-Ai
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEDu3-0001hn-Hf
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:45:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29696
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEDu1-0007c1-Nl
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:45:27 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324--thPNk2mOwuP43PFC4exjw-1; Fri, 04 Sep 2020 11:45:23 -0400
X-MC-Unique: -thPNk2mOwuP43PFC4exjw-1
Received: by mail-wm1-f70.google.com with SMTP id a144so1829879wme.9
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 08:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mL3SfzX7h1BSnu82I45kmjh6IJrLOjvwssjE8PtInPE=;
 b=TmJCGrO7EUwJqoolD2SVgcqhmsGv35cxJ7ONEJ3wXdTccbnKYj0xYV0IjTXDhI9FYI
 SdcyeZ39iKlb1haf/JEDabb3ZsHj/FZ94aIdfHcr2GlaUHBNySSTWFMXy+btumUiz46X
 w226b4+4n40ma/P2kOIr27d5mKB5cY8j6UhRIwbc5zzfm+qJLeDiWOLXkRFP75l1iSha
 XsN6tG9Zb9QHmwY1hJoWxIgHs4TtvltVAnxQN1fqjkNChadOC0z76c6PdbbH0W9IUvTH
 pORgP4QFWLqO08stBdWY3yZq+Q0eLA+ePj2CTnnJVBx3Y9uuwmB+AGubWcRwlL1a6Nbp
 Bc4A==
X-Gm-Message-State: AOAM531M6JIR19oXJDk7TZee5AxYcmae9zuQrO2gTjJsVNJd1MtTaaia
 WGq6bSswA4rqYOMZKXLaQds6vCRRZ1Dc/y5qScEKFCQhmfBWEqysD8cT7XppEzoKlRC8BVWrfNa
 Auw+xl2Vsb6NA+uE=
X-Received: by 2002:a1c:156:: with SMTP id 83mr8283379wmb.49.1599234322296;
 Fri, 04 Sep 2020 08:45:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8HlzCEaAiXoOZq2sbc1aPWwEDeUHVXyKSiU0mxb4TE5D3U3BouFYOodZxLEb+f6R6MSrIXQ==
X-Received: by 2002:a1c:156:: with SMTP id 83mr8283332wmb.49.1599234322070;
 Fri, 04 Sep 2020 08:45:22 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id r13sm12625498wrj.83.2020.09.04.08.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 08:45:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 07/13] dma: Let dma_memory_write() propagate MemTxResult
Date: Fri,  4 Sep 2020 17:44:33 +0200
Message-Id: <20200904154439.643272-8-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904154439.643272-1-philmd@redhat.com>
References: <20200904154439.643272-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

dma_memory_rw_relaxed() returns a MemTxResult type.
Do not discard it, return it to the caller.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/sysemu/dma.h | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index 2961a96ad67..f4ade067a46 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -96,8 +96,10 @@ static inline MemTxResult dma_memory_read_relaxed(AddressSpace *as,
     return dma_memory_rw_relaxed(as, addr, buf, len, DMA_DIRECTION_TO_DEVICE);
 }
 
-static inline int dma_memory_write_relaxed(AddressSpace *as, dma_addr_t addr,
-                                           const void *buf, dma_addr_t len)
+static inline MemTxResult dma_memory_write_relaxed(AddressSpace *as,
+                                                   dma_addr_t addr,
+                                                   const void *buf,
+                                                   dma_addr_t len)
 {
     return dma_memory_rw_relaxed(as, addr, (void *)buf, len,
                                  DMA_DIRECTION_FROM_DEVICE);
@@ -143,8 +145,20 @@ static inline MemTxResult dma_memory_read(AddressSpace *as, dma_addr_t addr,
     return dma_memory_rw(as, addr, buf, len, DMA_DIRECTION_TO_DEVICE);
 }
 
-static inline int dma_memory_write(AddressSpace *as, dma_addr_t addr,
-                                   const void *buf, dma_addr_t len)
+/**
+ * address_space_write: Write to address space from DMA controller.
+ *
+ * Return a MemTxResult indicating whether the operation succeeded
+ * or failed (eg unassigned memory, device rejected the transaction,
+ * IOMMU fault).
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ * @buf: buffer with the data transferred
+ * @len: the number of bytes to write
+ */
+static inline MemTxResult dma_memory_write(AddressSpace *as, dma_addr_t addr,
+                                           const void *buf, dma_addr_t len)
 {
     return dma_memory_rw(as, addr, (void *)buf, len,
                          DMA_DIRECTION_FROM_DEVICE);
-- 
2.26.2


