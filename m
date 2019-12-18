Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE947C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9954F218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ri8SSylw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9954F218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYap-0004lX-5v
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:38:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3s-0007LL-Sd
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3r-0003SA-E9
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:16 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:43642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3q-0003Jb-4D
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:15 -0500
Received: by mail-wr1-x42b.google.com with SMTP id d16so1986191wre.10
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=OQTWLYrlwKCqlPGQTAn1oHemTcy+syR9pMtUyWDmhSc=;
 b=ri8SSylw4YiYtS8bWeiSP4xSuDAL59nETQl5WxRtvXZSCjStDyPhBvikBxiOhyaqSW
 rSzL/8glez6HcsaB8TtR9wdLbxnCbjCPXfoSQc5ZGyhnH9h5rydPYmOLYcFffB3ZqMNU
 vQs8Q746xQQKjjitpoJZHvX+WaDnidRiEFJUaB3qgILwMb7QqSnZ2YcniftT24RmPxiU
 DKIobMSN7ATBpl7OMHSUB94tAF/OYzqj+MDKxh6P4jxR23KKLwqw8XIruWh7MWUznKi4
 XHfSPMst9QccECCDB/fu7ldBUK+WvZNCPyZOO2cOxvkLTjqKOm6sV/OP13Cj4mI/LOtd
 IXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=OQTWLYrlwKCqlPGQTAn1oHemTcy+syR9pMtUyWDmhSc=;
 b=rTkdhK1q2zujNnbhW0ZMxut0ssOW2F8zvCZUBDESaFUM10kZ5CRwvCbqkuxVfAH44i
 tDQwv9/lMDpvpoQIPzGjDaqAMUR9U61BAoWb6lEiHMMHywqPmanPlXDt5E1lD0zpkjpM
 2i7e3/TDFdO0eLfbCNBOrAlHHZV1UHLhWB8GO3d2CQkwaUR8aHWfUHn3I2YWSDHPL7ex
 KE5HQ9jbzUtizFHVjzW0bOZgw/jL9mb0jIvgYUcD6RRu7QkHEkEBJweeShZ/CXknSeaV
 9mpBPDvOZSxBTVxioXljPbjFd+izC5OGEIKNngqMESpnLLoVs/HEK1TCKRGngEQJswBI
 YoTw==
X-Gm-Message-State: APjAAAU7mref1RnARsYaYWqFsAzzvJa3/eW8NJ0ITW6sbTt6pKSuXlL0
 7Z5vPI2bUktzZ3NXYBbtmuRtz24E
X-Google-Smtp-Source: APXvYqxXLUH4tGe2UXggD2UOwTa5rUJg3c5ElKbcQQvUJWD2Av969lmUGZdDo+7VNYjBwAQ0EemUvA==
X-Received: by 2002:adf:f98c:: with SMTP id f12mr2374120wrr.138.1576670652810; 
 Wed, 18 Dec 2019 04:04:12 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 70/87] memory.h: Silence kernel-doc complaints
Date: Wed, 18 Dec 2019 13:02:36 +0100
Message-Id: <1576670573-48048-71-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix a few instances where kernel-doc complains about doc comments
in memory.h.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9d3fdb5..4754749 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -360,10 +360,14 @@ typedef struct IOMMUMemoryRegionClass {
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
 typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
 
+/** MemoryRegion:
+ *
+ * A struct representing a memory region.
+ */
 struct MemoryRegion {
     Object parent_obj;
 
-    /* All fields are private - violators will be prosecuted */
+    /* private: */
 
     /* The following fields should fit in a cache line */
     bool romd_mode;
@@ -452,7 +456,7 @@ struct MemoryListener {
  * AddressSpace: describes a mapping of addresses to #MemoryRegion objects
  */
 struct AddressSpace {
-    /* All fields are private. */
+    /* private: */
     struct rcu_head rcu;
     char *name;
     MemoryRegion *root;
@@ -1679,8 +1683,8 @@ bool memory_region_is_mapped(MemoryRegion *mr);
  *
  * Returns a #MemoryRegionSection that describes a contiguous overlap.
  * It will have the following characteristics:
- *    .@size = 0 iff no overlap was found
- *    .@mr is non-%NULL iff an overlap was found
+ * - @size = 0 iff no overlap was found
+ * - @mr is non-%NULL iff an overlap was found
  *
  * Remember that in the return value the @offset_within_region is
  * relative to the returned region (in the .@mr field), not to the
@@ -1691,8 +1695,8 @@ bool memory_region_is_mapped(MemoryRegion *mr);
  * returned one.  However, in the special case where the @mr argument
  * has no container (and thus is the root of the address space), the
  * following will hold:
- *    .@offset_within_address_space >= @addr
- *    .@offset_within_address_space + .@size <= @addr + @size
+ * - @offset_within_address_space >= @addr
+ * - @offset_within_address_space + .@size <= @addr + @size
  *
  * @mr: a MemoryRegion within which @addr is a relative address
  * @addr: start of the area within @as to be searched
-- 
1.8.3.1



