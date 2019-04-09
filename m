Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD75C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC982084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4GWWyRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC982084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46132 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtif-0005dZ-5q
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:35:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDtWm-0004a9-4s
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDtWk-0003VE-V7
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:16 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hDtWk-0003UF-Kr
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:14 -0400
Received: by mail-wr1-x444.google.com with SMTP id w10so21725274wrm.4
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 09:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=yuUuDxVVhvaliOcBi/FPf1oamn6ohJyWlwtQJvK0xe8=;
	b=N4GWWyRVPkOCIEtChuIdzWi/gK31m5rK10iK9ZaAWO97j9DaFYcfm6JDajGcU1ew4s
	JQPAnx1jsD60XBJE1ShWdWZ+iOdtFf00hqSF4hFZIU/j3n2WjVRZzI0VP4/t+26zJuCT
	SqI9HvbMg+C1cI7Xz/CEvSwqwDRd6qpXGTiE8Br30VkJehRuepMmTqAe8kJ4NOxgBJGm
	c6S7xb0G7ruQr7CVLpAZOXB3pJpgYodBbZgMk/bDxy/J1k4PBxbdmEbfLd6CJ7k27xNM
	3caU0LRscSLtczz1FlXiU/+C7z8QtHNUeywyp8VJfwryy/C/AkJLJHiRbUTwlH/3L6tV
	oj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=yuUuDxVVhvaliOcBi/FPf1oamn6ohJyWlwtQJvK0xe8=;
	b=i7dI8xjNL3PBb44Z2O6q7ru0j0YHzMyK+hvGR7c51Hj/hmBma6Hs4q/sRI4DCXDg19
	HJxfy1UGoHFbOq8WH4NZ6nTVAkZe5MwPKVGutsCzRRwTjJrNOE+Cw51rd3n3klTpw3ua
	BLVIHA31tkj1Bm+c/665p0zCDb5Ga9Kr7v/42QOXt4sQI57qFgUShqHlN7OtkNkeiZRW
	jlGH60ojcI1B8BUO6FoGZ4XB856tzSHzrtV/Wz7wXEn7xYosQqc70E49SfMu1dS93FLs
	S7eBLHt1HKjK73bex6zOIWiI4StG5flrPFEqK/JOxTiEmIg7iSL545iDblKYv4oW2Ss7
	8xfw==
X-Gm-Message-State: APjAAAWtjrNFskEWRkrEr+CGpGbcfP5kV+c6va11xZkXJI0bohLT4wOW
	unLZxmdytMwKtIY+PsW4aWifapgT
X-Google-Smtp-Source: APXvYqwB92SFss/xtg++wewUs//c6kiLVdJUnKMqeDvX4zxz5533S6r4vV2zO6tDf3ZEJUzZlS4ieA==
X-Received: by 2002:a5d:458f:: with SMTP id p15mr23213671wrq.188.1554826993397;
	Tue, 09 Apr 2019 09:23:13 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	e1sm59579736wrw.66.2019.04.09.09.23.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 09:23:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 18:23:04 +0200
Message-Id: <1554826986-37164-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554826986-37164-1-git-send-email-pbonzini@redhat.com>
References: <1554826986-37164-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 3/5] include/qemu/bswap.h: Use
 __builtin_memcpy() in accessor functions
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409162304.jZVDUHe4vNolQ-icVmZ6yENVvsyVAb24YU0GUe7E1lM@z>

From: Peter Maydell <peter.maydell@linaro.org>

In the accessor functions ld*_he_p() and st*_he_p() we use memcpy()
to perform a load or store to a pointer which might not be aligned
for the size of the type. We rely on the compiler to optimize this
memcpy() into an efficient load or store instruction where possible.
This is required for good performance, but at the moment it is also
required for correct operation, because some users of these functions
require that the access is atomic if the pointer is aligned, which
will only be the case if the compiler has optimized out the memcpy().
(The particular example where we discovered this is the virtio
vring_avail_idx() which calls virtio_lduw_phys_cached() which
eventually ends up calling lduw_he_p().)

Unfortunately some compile environments, such as the fortify-source
setup used in Alpine Linux, define memcpy() to a wrapper function
in a way that inhibits this compiler optimization.

The correct long-term fix here is to add a set of functions for
doing atomic accesses into AddressSpaces (and to other relevant
families of accessor functions like the virtio_*_phys_cached()
ones), and make sure that callsites which want atomic behaviour
use the correct functions.

In the meantime, switch to using __builtin_memcpy() in the
bswap.h accessor functions. This will make us robust against things
like this fortify library in the short term. In the longer term
it will mean that we don't end up with these functions being really
badly-performing even if the semantics of the out-of-line memcpy()
are correct.

Reported-by: Fernando Casas Schössow <casasfernando@outlook.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190318112938.8298-1-peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/bswap.h | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 5a70f78..2a9f3fe 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -316,51 +316,57 @@ static inline void stb_p(void *ptr, uint8_t v)
     *(uint8_t *)ptr = v;
 }
 
-/* Any compiler worth its salt will turn these memcpy into native unaligned
-   operations.  Thus we don't need to play games with packed attributes, or
-   inline byte-by-byte stores.  */
+/*
+ * Any compiler worth its salt will turn these memcpy into native unaligned
+ * operations.  Thus we don't need to play games with packed attributes, or
+ * inline byte-by-byte stores.
+ * Some compilation environments (eg some fortify-source implementations)
+ * may intercept memcpy() in a way that defeats the compiler optimization,
+ * though, so we use __builtin_memcpy() to give ourselves the best chance
+ * of good performance.
+ */
 
 static inline int lduw_he_p(const void *ptr)
 {
     uint16_t r;
-    memcpy(&r, ptr, sizeof(r));
+    __builtin_memcpy(&r, ptr, sizeof(r));
     return r;
 }
 
 static inline int ldsw_he_p(const void *ptr)
 {
     int16_t r;
-    memcpy(&r, ptr, sizeof(r));
+    __builtin_memcpy(&r, ptr, sizeof(r));
     return r;
 }
 
 static inline void stw_he_p(void *ptr, uint16_t v)
 {
-    memcpy(ptr, &v, sizeof(v));
+    __builtin_memcpy(ptr, &v, sizeof(v));
 }
 
 static inline int ldl_he_p(const void *ptr)
 {
     int32_t r;
-    memcpy(&r, ptr, sizeof(r));
+    __builtin_memcpy(&r, ptr, sizeof(r));
     return r;
 }
 
 static inline void stl_he_p(void *ptr, uint32_t v)
 {
-    memcpy(ptr, &v, sizeof(v));
+    __builtin_memcpy(ptr, &v, sizeof(v));
 }
 
 static inline uint64_t ldq_he_p(const void *ptr)
 {
     uint64_t r;
-    memcpy(&r, ptr, sizeof(r));
+    __builtin_memcpy(&r, ptr, sizeof(r));
     return r;
 }
 
 static inline void stq_he_p(void *ptr, uint64_t v)
 {
-    memcpy(ptr, &v, sizeof(v));
+    __builtin_memcpy(ptr, &v, sizeof(v));
 }
 
 static inline int lduw_le_p(const void *ptr)
-- 
1.8.3.1



