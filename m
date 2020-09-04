Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09E8C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 796C12074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796C12074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEE28-0007Yr-JK
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEDuL-00026S-32
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:45:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37779
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEDuI-0007jO-71
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:45:44 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-XjPgIMXFMXe028GnSSqiug-1; Fri, 04 Sep 2020 11:45:40 -0400
X-MC-Unique: XjPgIMXFMXe028GnSSqiug-1
Received: by mail-wr1-f70.google.com with SMTP id g6so2464132wrv.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 08:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JUQPC6DgM2FCUEnyNd7bTPLA1Qde172FQ2i4S8gYY7A=;
 b=LthP5asBCP9MqWHBZzhP7Vj/42waJKzorrfkVgcueaXapmAOxUW0+iJsNqFPi8ydqE
 yiU4rpSVyfFFfObNMmUqqoFpW6co4NmPKZ5N3w0DGVFtZQUZfKKexusoAyrtwZXOEyGF
 O7RLLuEhBAeoV652jGBU1qQgapO9DrMYbU8QtMxDbE8q0U+0ZYsS/8zji0i9bZGtsR2h
 v8bFUQLPbJ8vJPnttOaV+1Y+z9e1Ee+vNJNyBvZdbowxrI/RET9dYuA1kqHagpRvcXdF
 pCS+J+ZQQnBwgT96kGjGO5r2KHv/QnK5BfIYMQQk7/c7ykTvzeuk5bUPUHUVhjz18bPA
 47Fg==
X-Gm-Message-State: AOAM532Ct0P8nhAASLowxfQKD8C6FL0qe/sec+uMXc8+zMXOkkj7M6ZL
 gtGAKerf+xmY7HayJeA5g+2e3xrzf3XfOAmI0rZZfPF9bF82ZvgMbezKSL/f8sDk64dQ9gRNbgV
 11iVvZqtu0rsv9To=
X-Received: by 2002:a1c:1d52:: with SMTP id d79mr8773914wmd.82.1599234339203; 
 Fri, 04 Sep 2020 08:45:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCz582qIvV6nyW0Orl7VeZ8MxN3J0CJZxJsqhj60xKXsv5sen8ldh7Jsjv0l4hVXnzFcZ7DQ==
X-Received: by 2002:a1c:1d52:: with SMTP id d79mr8773874wmd.82.1599234339018; 
 Fri, 04 Sep 2020 08:45:39 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id q18sm12234247wre.78.2020.09.04.08.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 08:45:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 10/13] dma: Let dma_memory_rw_relaxed() take MemTxAttrs
 argument
Date: Fri,  4 Sep 2020 17:44:36 +0200
Message-Id: <20200904154439.643272-11-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904154439.643272-1-philmd@redhat.com>
References: <20200904154439.643272-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:58:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We will add the MemTxAttrs argument to dma_memory_rw() in
the next commit. Since dma_memory_rw_relaxed() is only used
by dma_memory_rw(), modify it first in a separate commit to
keep the next commit easier to review.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/sysemu/dma.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index d0381f9ae9b..59331ec0bd3 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -83,9 +83,10 @@ static inline bool dma_memory_valid(AddressSpace *as,
 static inline MemTxResult dma_memory_rw_relaxed(AddressSpace *as,
                                                 dma_addr_t addr,
                                                 void *buf, dma_addr_t len,
-                                                DMADirection dir)
+                                                DMADirection dir,
+                                                MemTxAttrs attrs)
 {
-    return address_space_rw(as, addr, MEMTXATTRS_UNSPECIFIED,
+    return address_space_rw(as, addr, attrs,
                             buf, len, dir == DMA_DIRECTION_FROM_DEVICE);
 }
 
@@ -93,7 +94,9 @@ static inline MemTxResult dma_memory_read_relaxed(AddressSpace *as,
                                                   dma_addr_t addr,
                                                   void *buf, dma_addr_t len)
 {
-    return dma_memory_rw_relaxed(as, addr, buf, len, DMA_DIRECTION_TO_DEVICE);
+    return dma_memory_rw_relaxed(as, addr, buf, len,
+                                 DMA_DIRECTION_TO_DEVICE,
+                                 MEMTXATTRS_UNSPECIFIED);
 }
 
 static inline MemTxResult dma_memory_write_relaxed(AddressSpace *as,
@@ -102,7 +105,8 @@ static inline MemTxResult dma_memory_write_relaxed(AddressSpace *as,
                                                    dma_addr_t len)
 {
     return dma_memory_rw_relaxed(as, addr, (void *)buf, len,
-                                 DMA_DIRECTION_FROM_DEVICE);
+                                 DMA_DIRECTION_FROM_DEVICE,
+                                 MEMTXATTRS_UNSPECIFIED);
 }
 
 /**
@@ -124,7 +128,8 @@ static inline MemTxResult dma_memory_rw(AddressSpace *as, dma_addr_t addr,
 {
     dma_barrier(as, dir);
 
-    return dma_memory_rw_relaxed(as, addr, buf, len, dir);
+    return dma_memory_rw_relaxed(as, addr, buf, len, dir,
+                                 MEMTXATTRS_UNSPECIFIED);
 }
 
 /**
-- 
2.26.2


