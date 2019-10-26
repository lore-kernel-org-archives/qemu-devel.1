Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1959CCA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E414621655
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E414621655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOS5k-0004Zd-5V
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 15:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iORuz-0001Z5-Br
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iORuy-0000ZS-7w
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:40:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38376)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iORux-0000Z6-W0
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:40:08 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 30BC883F45
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 19:40:07 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id m20so6313472qtq.16
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 12:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KP66ySUJcxSFVWfRvNJdHRlnkYPP/qKoNHIn6pXPGCo=;
 b=LzKgsb1XOCKtwLhzhzSKOY3ytLyexNcVrlr3Ip984/6r6qjLywT//5tKuyS1L8rbk6
 xqNpogPlfhSAAk82uKkaElFGAWa0/nqkcdK1C8irCYqD2W3dqp0DV/EWMD140exY46wf
 jG84/I3CP24LLBovZJdWlYnVemYumc6u11WBNrPjUcwOVjpv8de40YgBMjLWr7w4FKMF
 GBxkL/Jyb/1mtvVocn/uECGvqTuiUa8mHM2k6+W2ZiWTWfjvDO5oMWXH9nr46Nqzd3wA
 XGfYsvbCCC69CNkGPEO7c8cyl5UeG5ByR0hvtGDDaD0yC/t2mJZp3L6mbw+L2Kd3GDEM
 AhUQ==
X-Gm-Message-State: APjAAAWDmG/uYFlH9tJBQg4gT7uztLg83lXuBqVKFezZ8JuHj0MiNCKG
 /THlud/Go1CRUXmdBK4F8Bl73ZIiQ3A5LZy08S1c/GdjYwNYcZ4I/uu16G6IlQOr0s/BDoKY0pI
 97OQndlDxzUR9J2s=
X-Received: by 2002:ac8:6b0e:: with SMTP id w14mr4574780qts.238.1572118806033; 
 Sat, 26 Oct 2019 12:40:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwFExXTE3s0yO8K49hToexbf73mp7QuQ5BpDP4CEtutac8ORrJHLADBiPBFBsngqldC1VPAJA==
X-Received: by 2002:ac8:6b0e:: with SMTP id w14mr4574774qts.238.1572118805861; 
 Sat, 26 Oct 2019 12:40:05 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 p59sm2845525qtd.2.2019.10.26.12.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 12:40:05 -0700 (PDT)
Date: Sat, 26 Oct 2019 15:40:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/25] libqos: read QVIRTIO_MMIO_VERSION register
Message-ID: <20191026193824.11926-11-mst@redhat.com>
References: <20191026193824.11926-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026193824.11926-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

There was no real virtio-mmio ABI change between Legacy and VIRTIO 1.0
except that the Version field was incremented from 1 to 2.

However, QEMU does not allow Legacy drivers to perform VIRTIO 1.0
operations like accessing 64-bit feature bits.  Since we will introduce
64-bit feature bit support we need a way to differentiate between
virtio-mmio Version 1 and 2 to avoid upsetting QEMU when we operate in
Legacy mode.

Stash away the Version field so later patches can change behavior
depending on the version.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191023100425.12168-3-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/libqos/virtio-mmio.c | 3 +++
 tests/libqos/virtio-mmio.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
index d0047876a8..7154b03c1d 100644
--- a/tests/libqos/virtio-mmio.c
+++ b/tests/libqos/virtio-mmio.c
@@ -223,6 +223,9 @@ void qvirtio_mmio_init_device(QVirtioMMIODevice *dev, QTestState *qts,
     magic = qtest_readl(qts, addr + QVIRTIO_MMIO_MAGIC_VALUE);
     g_assert(magic == ('v' | 'i' << 8 | 'r' << 16 | 't' << 24));
 
+    dev->version = qtest_readl(qts, addr + QVIRTIO_MMIO_VERSION);
+    g_assert(dev->version == 1 || dev->version == 2);
+
     dev->qts = qts;
     dev->addr = addr;
     dev->page_size = page_size;
diff --git a/tests/libqos/virtio-mmio.h b/tests/libqos/virtio-mmio.h
index 17a17141c3..0e45778b07 100644
--- a/tests/libqos/virtio-mmio.h
+++ b/tests/libqos/virtio-mmio.h
@@ -40,6 +40,7 @@ typedef struct QVirtioMMIODevice {
     uint64_t addr;
     uint32_t page_size;
     uint32_t features; /* As it cannot be read later, save it */
+    uint32_t version;
 } QVirtioMMIODevice;
 
 extern const QVirtioBus qvirtio_mmio;
-- 
MST


