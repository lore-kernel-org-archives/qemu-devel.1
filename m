Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DD5C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E209F218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baXJV9p/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E209F218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZRa-0006kB-0e
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:36:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlH-0001lV-Hs
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlG-0001G5-6b
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:27 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:39099)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlF-0001Cv-VR
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:26 -0500
Received: by mail-wm1-x32d.google.com with SMTP id c84so2835491wme.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x/kWW+GhK0b6wNQSgOFOkcpnvx451R3/2lSJVAg8HB0=;
 b=baXJV9p/l/uIWduoXsh88QSwSdA3rwHfKoExfq3QYXSshxpdRNPgY8gBGQffaVkEwQ
 jcBBmEZnQ7mZ2ojN5zybr4a/U1jU5AVCENIRl2+qPddWQ9mU9YbrIBGG4pJHjxjLU09S
 i+HPH0ISjQnjROznrGjRwy3TJp0o/LIDXOU4DGxTg0onYxgO+LF3LBRjoBSFYMzkh8cW
 FSPni9ayYBiiZo/d2/M6ejYSPMC9jh7M2BlNp64ZQI+ECG670gAOsaqYB7i4N1M2Mx37
 WcwoabPbX8JP431qoYBD7KGcpLhvPVeoQ7772xI4/xMB1BZzty6RUn0AsUgG5RTkmFgQ
 HXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=x/kWW+GhK0b6wNQSgOFOkcpnvx451R3/2lSJVAg8HB0=;
 b=A1XbEx3ktdfiAO6Nh8MRquturtaI41UKApxYX6lKVQllYg990QQ0TrZtAkK6l+FpHK
 m7UYRrmIfFk9Du2KUW85QzWxYGJV/RuO5MY1OXbrQubodIq6ErTD5ZVdjPdX4Po5fCJc
 RaG2whIJ4dP7fpKsBgDde3d4jl+k+QPrugDkeEjHyLhYbvPVSDUr+ijOngHqUl4BTI6n
 cZjbGA96C+IED5Mwd6RVhz+49dcxCNQ36cr3hAKArZnCmxFvT+o3LvWuh+PZS4tJ6eGr
 zYmMqYccwMoD8i+0n3fWjSI2W983eNiGzO6ztD+U68GtmmajJgX2hmsOlmqvQzYipjO1
 NoTQ==
X-Gm-Message-State: APjAAAU19Inzu5kW8GstjCyOAGNWY8Ms7S/9UEkW/1quqhkE9mAynjOm
 Soz3YJQgR3jg9ZSuORVnsbYaZ3+Q
X-Google-Smtp-Source: APXvYqzHSvJrbdX2Tk5y51dSyQ2aLjCpqEZ+im2OfOuGOemnBCIu/ozl5Iw4Pbsy7hftJ5aEPeGfJQ==
X-Received: by 2002:a1c:e488:: with SMTP id b130mr4775982wmh.108.1582631544717; 
 Tue, 25 Feb 2020 03:52:24 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 084/136] exec: Let the address_space API use void pointer
 arguments
Date: Tue, 25 Feb 2020 12:50:14 +0100
Message-Id: <1582631466-13880-84-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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

As we are only dealing with a blob buffer, use a void pointer
argument. This will let us simplify other APIs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 exec.c                | 11 ++++++-----
 include/exec/memory.h | 12 ++++++------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/exec.c b/exec.c
index 17808e3..3d6ee06 100644
--- a/exec.c
+++ b/exec.c
@@ -3271,7 +3271,7 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
 }
 
 MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
-                                    MemTxAttrs attrs, uint8_t *buf, hwaddr len)
+                                    MemTxAttrs attrs, void *buf, hwaddr len)
 {
     MemTxResult result = MEMTX_OK;
     FlatView *fv;
@@ -3287,7 +3287,7 @@ MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
 
 MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
                                 MemTxAttrs attrs,
-                                const uint8_t *buf, hwaddr len)
+                                const void *buf, hwaddr len)
 {
     MemTxResult result = MEMTX_OK;
     FlatView *fv;
@@ -3302,7 +3302,7 @@ MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
 }
 
 MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
-                             uint8_t *buf, hwaddr len, bool is_write)
+                             void *buf, hwaddr len, bool is_write)
 {
     if (is_write) {
         return address_space_write(as, addr, attrs, buf, len);
@@ -3326,7 +3326,7 @@ enum write_rom_type {
 static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
                                                            hwaddr addr,
                                                            MemTxAttrs attrs,
-                                                           const uint8_t *buf,
+                                                           const void *ptr,
                                                            hwaddr len,
                                                            enum write_rom_type type)
 {
@@ -3334,6 +3334,7 @@ static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
     uint8_t *ram_ptr;
     hwaddr addr1;
     MemoryRegion *mr;
+    const uint8_t *buf = ptr;
 
     RCU_READ_LOCK_GUARD();
     while (len > 0) {
@@ -3366,7 +3367,7 @@ static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
 /* used for ROM loading : can write in RAM and ROM */
 MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs,
-                                    const uint8_t *buf, hwaddr len)
+                                    const void *buf, hwaddr len)
 {
     return address_space_write_rom_internal(as, addr, attrs,
                                             buf, len, WRITE_DATA);
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 6f8084f..afee185 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2052,7 +2052,7 @@ void address_space_remove_listeners(AddressSpace *as);
  * @is_write: indicates the transfer direction
  */
 MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
-                             MemTxAttrs attrs, uint8_t *buf,
+                             MemTxAttrs attrs, void *buf,
                              hwaddr len, bool is_write);
 
 /**
@@ -2070,7 +2070,7 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
  */
 MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
                                 MemTxAttrs attrs,
-                                const uint8_t *buf, hwaddr len);
+                                const void *buf, hwaddr len);
 
 /**
  * address_space_write_rom: write to address space, including ROM.
@@ -2096,7 +2096,7 @@ MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
  */
 MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs,
-                                    const uint8_t *buf, hwaddr len);
+                                    const void *buf, hwaddr len);
 
 /* address_space_ld*: load from an address space
  * address_space_st*: store to an address space
@@ -2334,7 +2334,7 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
 
 /* Internal functions, part of the implementation of address_space_read.  */
 MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
-                                    MemTxAttrs attrs, uint8_t *buf, hwaddr len);
+                                    MemTxAttrs attrs, void *buf, hwaddr len);
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemTxAttrs attrs, void *buf,
                                    hwaddr len, hwaddr addr1, hwaddr l,
@@ -2374,7 +2374,7 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
  */
 static inline __attribute__((__always_inline__))
 MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
-                               MemTxAttrs attrs, uint8_t *buf,
+                               MemTxAttrs attrs, void *buf,
                                hwaddr len)
 {
     MemTxResult result = MEMTX_OK;
@@ -2433,7 +2433,7 @@ address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
  */
 static inline void
 address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
-                           void *buf, hwaddr len)
+                           const void *buf, hwaddr len)
 {
     assert(addr < cache->len && len <= cache->len - addr);
     if (likely(cache->ptr)) {
-- 
1.8.3.1



