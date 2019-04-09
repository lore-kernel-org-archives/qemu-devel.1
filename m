Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FD7C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 526F62084C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/DDeoO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526F62084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45151 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtA0-0002lM-JZ
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 11:59:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDt5u-00084v-3u
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDt5s-0004gc-PN
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hDt5q-0004Zf-QM
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:55:27 -0400
Received: by mail-wr1-x441.google.com with SMTP id k11so21614638wro.5
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Nts/WXslIMz+rtQxBycO4tlKgkT4fO9y2InuBgzzg+4=;
	b=u/DDeoO5dpRRkonqL/LkuBI9+y/aRA853yrotuF+IfO1aROH6KMVEf2pkIZMsEzbHm
	Fh92Sq6Du3jACRKl8RLiDzpPLpWxHbJRvHrSiFxiOn34MWayO+jEUqQpkwqbG5UEN6Hp
	AgzCpi69ZjI4L0unS9aW6nn+byxNeZ2QcUXbmWPf7g1Nc+26TvafN0vXZ9Zg5vMHLKWJ
	dNRydWYBKdlwei3v7D5nFTXxC5evXipJ1jMyKMKzT3XH9x/lArwmt38kFrxIhRunxm5y
	cshfdF2WIB0XVcCIET3PfUZ7t7W5RlTlKMIBhN+TGth9M+5apzPbNDmykrccpA6V6RK4
	boPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=Nts/WXslIMz+rtQxBycO4tlKgkT4fO9y2InuBgzzg+4=;
	b=FzZ2JkjO1fH42x155YJQYWtE/8NPwnmSBFKg0hOmSFUZgQ4608cNMeYc4fe/gituQZ
	gTs26EcP2jSd71N0JCKIY48gzFTKXp5f3p3NxmMbuloEq3HLwTtSv6hLxgMMVQpffqfN
	ihpuMgURhhj/wyEmzrkBBGXxCdI0E0x6c5uHcZQ0EgBtic81peL+iJnub50Tv3gcrMcV
	0u6SiOQTdXKT/UCqjsuAgO+7d5VcKe3huz5xt+R5HahCT/84wAemhxxjwqc38OuUmC9l
	tXM0WXYWT/8S3eqpTPq+UkYOAutQlvc8IIW0XAdzGJt9QThPmE0KB9uM0EPeQOudyrTI
	mupg==
X-Gm-Message-State: APjAAAWfFwXH6cXp9nESw61jFNacD7ADOJSq4vctqCaiTDyaoGzeeUlP
	VRF/61QzApmbEHMpefuXWW0Fi00T
X-Google-Smtp-Source: APXvYqybAC7eW4DXdeXy+V3I/SV+jBZPs38njOPyTDyif+VvTjRECjI7sOHdyCjE9YOieNcVdReQZQ==
X-Received: by 2002:adf:ef91:: with SMTP id d17mr22866739wro.78.1554825320639; 
	Tue, 09 Apr 2019 08:55:20 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	g84sm23117586wmf.25.2019.04.09.08.55.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 08:55:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 17:55:14 +0200
Message-Id: <1554825316-33288-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554825316-33288-1-git-send-email-pbonzini@redhat.com>
References: <1554825316-33288-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Message-ID: <20190409155514.-6dQtUHLnG2e2BvKvHjOpgEy8sh3uW4PtdcnRefIOtg@z>

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



