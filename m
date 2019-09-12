Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A12C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 079D8208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfiggS35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079D8208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Q2W-0004PT-18
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i8Pw1-0004he-1D
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:18:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i8Pvz-0007F3-Tf
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:18:56 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i8Pvz-0007Ej-Nu
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:18:55 -0400
Received: by mail-wm1-x344.google.com with SMTP id q18so250775wmq.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 07:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XsOmn865vPaAVaoVze2USZn4OuTbtx/gpt5HlGl/9Zs=;
 b=FfiggS35UNziYiUNmeq5M6V6o+ERftJuw1m3dtAhxjr3QyNYRVfJTmS4HmvuExzhX4
 iyR3CNxgDkO1U4Yj0J57DsjJwVB2Pg083qYBbwrfKftCrMEhBlZHU4GaP0IF+UlA4kgT
 DK4ImU4MuxfV1Xmd8+U0b2DQH8NPORvXIEvMk7VlIpmDLgTMudeSOLmeAR+EJ6qBD0Ng
 TQjXzbIhQCxjdo5/kJL5onv6RVwWLNlHm+UIDiBlUdjXvDwJtLLUQ2tdoY4zx5es37ex
 Yr76E7eRP66jEEbDyP285FHtEUh5PtWCyD1NHh2txS0YoVUeOZav3Ii6RLVS1QkKxm2j
 QLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=XsOmn865vPaAVaoVze2USZn4OuTbtx/gpt5HlGl/9Zs=;
 b=mmP9g08Q0oAnGlZSbh9yflzrLJjbPj1xym/f/N8Xlp7E4BHlOQ2p/xM0vjWlmxE52/
 oEqcaT5dCOMKRqcuXVAOMOfgE979mmhAoJx8o6BS8ZaQ2iYm6UvJAJ80Y1pwptnsdPdF
 peINQYwmBDTnryoHRZxmO0M6UeaVkyzPj3BN7z/FunTLUVbSEf9vKdPDEPdwMC2GGxak
 wL47Vhsggam4DiziM4k5sNrlgond+xi2rcvVf7c2uuFGyeqEGNuKhRXOJfnLJQX1jQnC
 Jdil4pPoScPjOAgQn6I/qejJE2CyAVdPIA1lXlVOPauJmLs9AVElqVwAqGgIOZp8wThH
 WtZA==
X-Gm-Message-State: APjAAAWkyJhk8jXJ0fPPSZhzuce8LyttxN2oDOfXZTbgARGMg/mMDbef
 yeVYac2lnhq8lAuBTQyB7KVl+i77xnE=
X-Google-Smtp-Source: APXvYqws+YPzRCF71qmtd87XIcpZtKMAaxPOS8QeNHgl8PeR0oxWAQ+IxkShim0xL2dG8uAOHNUKAw==
X-Received: by 2002:a1c:2b41:: with SMTP id r62mr196458wmr.47.1568297933867;
 Thu, 12 Sep 2019 07:18:53 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:3166:d768:e1a7:aab8])
 by smtp.gmail.com with ESMTPSA id i9sm179235wmf.14.2019.09.12.07.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 07:18:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 16:18:53 +0200
Message-Id: <20190912141853.31057-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v2] memory: inline and optimize devend_memop
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
Cc: Tony Nguyen <tony.nguyen@bt.com>, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

devend_memop can rely on the fact that the result is always either
0 or MO_BSWAP, corresponding respectively to host endianness and
the opposite.  Native (target) endianness in turn can be either
the host endianness, in which case MO_BSWAP is only returned for
host-opposite endianness, or the opposite, in which case 0 is only
returned for host endianness.

With this in mind, devend_memop can be compiled as a setcond+shift
for every target.  Do this and, while at it, move it to
include/exec/memory.h since !NEED_CPU_H files do not (and should not)
need it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h | 19 ++++++++++++++++++-
 memory.c              | 18 ------------------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 2dd810259d..2e83c96580 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2201,8 +2201,25 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
     }
 }
 
+#ifdef NEED_CPU_H
 /* enum device_endian to MemOp.  */
-MemOp devend_memop(enum device_endian end);
+static inline MemOp devend_memop(enum device_endian end)
+{
+    QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
+                      DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
+
+#ifdef BSWAP_NEEDED
+    /* Swap if non-host endianness or native (target) endianness */
+    return (end == DEVICE_HOST_ENDIAN) ? 0 : MO_BSWAP;
+#else
+    const int non_host_endianness =
+        DEVICE_LITTLE_ENDIAN ^ DEVICE_BIG_ENDIAN ^ DEVICE_HOST_ENDIAN;
+
+    /* In this case, native (target) endianness needs no swap.  */
+    return (end == non_host_endianness) ? MO_BSWAP : 0;
+#endif
+}
+#endif
 
 #endif
 
diff --git a/memory.c b/memory.c
index 61a254c3f9..b9dd6b94ca 100644
--- a/memory.c
+++ b/memory.c
@@ -3267,21 +3267,3 @@ static void memory_register_types(void)
 }
 
 type_init(memory_register_types)
-
-MemOp devend_memop(enum device_endian end)
-{
-    static MemOp conv[] = {
-        [DEVICE_LITTLE_ENDIAN] = MO_LE,
-        [DEVICE_BIG_ENDIAN] = MO_BE,
-        [DEVICE_NATIVE_ENDIAN] = MO_TE,
-        [DEVICE_HOST_ENDIAN] = 0,
-    };
-    switch (end) {
-    case DEVICE_LITTLE_ENDIAN:
-    case DEVICE_BIG_ENDIAN:
-    case DEVICE_NATIVE_ENDIAN:
-        return conv[end];
-    default:
-        g_assert_not_reached();
-    }
-}
-- 
2.21.0


