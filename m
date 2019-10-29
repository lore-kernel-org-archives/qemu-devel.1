Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DA3CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 16:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916AB20717
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 16:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtn4D5MD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916AB20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPULQ-0008IE-5G
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 12:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iPUGp-00027m-Dn
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 12:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iPUGn-0004xa-CJ
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 12:22:59 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45054)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iPUGn-0004wH-5C
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 12:22:57 -0400
Received: by mail-wr1-x442.google.com with SMTP id z11so14298232wro.11
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 09:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JLypjmRTb08Qb0V0OoJj2WZu63pj51rP4Zc4f/igiag=;
 b=gtn4D5MDqbMuLY8udXoxMGtWyR8wRlsZ+vJjWwKNcHX8ZV4ksnRsIDTa81jVYeDw1M
 g3UA2lWZf2JApEpH7P61s0gJFP36o8NNUBVYEDc93JLPyRMFza0rfonWPJFMqXsgfjYG
 y3Su6WYfHcgJ8sOXA3fyMvzRL076AVA+lWvVYBLgInbbULUN+mGlwphBu88JuQpseKr7
 flaMnkjkG/kO5N6Mz37KIEJCtsGVnTc/3rW6b2+q3oeXKNALL0DFyO/q42gjSe4kXmJE
 FMHStU11EaO8NT2/qGzwo34CgOgrJ32e88/Iq7DXObdx48FGfyNKaDWFz5qVlwLFJEc5
 SIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JLypjmRTb08Qb0V0OoJj2WZu63pj51rP4Zc4f/igiag=;
 b=OBM/ZvQUTyrUM+wXh0osaVmuiJt/GSNvYBXBKC/ZbDaUDquD2NPWopAXo5BFaeWunK
 msy+WKNU9X856y+AGDEsZqDct36DJT4eierkSu5FJ/vur4S+wne7tqtt9Nwatky0svPn
 UJGxAHTx3RsaaUUZ+GW41Zdu0V5nEEVpSsgIFGqYY1LD0AQtTnTTfCk57JK/+UBZgIkC
 ZPW3cZWzEDSR/5A0rQ5NHk7uqz8cPyNeToIk+n8J3Rcp9Pg36qGIeF+FtzrEcXocK52x
 sf3hayolzlVf2AaZIbSTpd8VdV8rzkqYTGY32rEOgslRGU/rosDS2SRWyTRq7xBgiuR7
 XRdQ==
X-Gm-Message-State: APjAAAVmq1M7bt+gY0KVMB3erLI1aolWyegCUK1iPIqO8/t99VjH9uJF
 mL8OP2eZPpBCHA5Eiuqvj6cwvzpI/eo=
X-Google-Smtp-Source: APXvYqz3CotIYvIP4v/XmrS+zlqmN9lPwUZ9J5AzfpfcDfEJspSMKkM/MoJzw03QP43dEW7SzmZCYg==
X-Received: by 2002:adf:cd84:: with SMTP id q4mr20440845wrj.153.1572366175669; 
 Tue, 29 Oct 2019 09:22:55 -0700 (PDT)
Received: from donizetti.metropole.lan (94.222.26.109.rev.sfr.net.
 [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id q12sm9285661wrw.91.2019.10.29.09.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 09:22:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] memory: include MemoryListener documentation and some
 missing function parameters
Date: Tue, 29 Oct 2019 17:22:48 +0100
Message-Id: <20191029162248.13383-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029162248.13383-1-pbonzini@redhat.com>
References: <20191029162248.13383-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These cover the remaining warnings from kernel-doc.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h | 211 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 209 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 1e875996ec..c84fde75fa 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -423,30 +423,232 @@ struct IOMMUMemoryRegion {
  * Use with memory_listener_register() and memory_listener_unregister().
  */
 struct MemoryListener {
+    /**
+     * @begin:
+     *
+     * Called at the beginning of an address space update transaction.
+     * Followed by calls to #MemoryListener.region_add(),
+     * #MemoryListener.region_del(), #MemoryListener.region_nop(),
+     * #MemoryListener.log_start() and #MemoryListener.log_stop() in
+     * increasing address order.
+     *
+     * @listener: The #MemoryListener.
+     */
     void (*begin)(MemoryListener *listener);
+
+    /**
+     * @commit:
+     *
+     * Called at the end of an address space update transaction,
+     * after the last call to #MemoryListener.region_add(),
+     * #MemoryListener.region_del() or #MemoryListener.region_nop(),
+     * #MemoryListener.log_start() and #MemoryListener.log_stop().
+     *
+     * @listener: The #MemoryListener.
+     */
     void (*commit)(MemoryListener *listener);
+
+    /**
+     * @region_add:
+     *
+     * Called during an address space update transaction,
+     * for a section of the address space that is new in this address space
+     * space since the last transaction.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The new #MemoryRegionSection.
+     */
     void (*region_add)(MemoryListener *listener, MemoryRegionSection *section);
+
+    /**
+     * @region_del:
+     *
+     * Called during an address space update transaction,
+     * for a section of the address space that has disappeared in the address
+     * space since the last transaction.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The old #MemoryRegionSection.
+     */
     void (*region_del)(MemoryListener *listener, MemoryRegionSection *section);
+
+    /**
+     * @region_nop:
+     *
+     * Called during an address space update transaction,
+     * for a section of the address space that is in the same place in the address
+     * space as in the last transaction.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The #MemoryRegionSection.
+     */
     void (*region_nop)(MemoryListener *listener, MemoryRegionSection *section);
+
+    /**
+     * @log_start:
+     *
+     * Called during an address space update transaction, after
+     * one of #MemoryListener.region_add(),#MemoryListener.region_del() or
+     * #MemoryListener.region_nop(), if dirty memory logging clients have
+     * become active since the last transaction.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The #MemoryRegionSection.
+     * @old: A bitmap of dirty memory logging clients that were active in
+     * the previous transaction.
+     * @new: A bitmap of dirty memory logging clients that are active in
+     * the current transaction.
+     */
     void (*log_start)(MemoryListener *listener, MemoryRegionSection *section,
                       int old, int new);
+
+    /**
+     * @log_stop:
+     *
+     * Called during an address space update transaction, after
+     * one of #MemoryListener.region_add(), #MemoryListener.region_del() or
+     * #MemoryListener.region_nop() and possibly after
+     * #MemoryListener.log_start(), if dirty memory logging clients have
+     * become inactive since the last transaction.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The #MemoryRegionSection.
+     * @old: A bitmap of dirty memory logging clients that were active in
+     * the previous transaction.
+     * @new: A bitmap of dirty memory logging clients that are active in
+     * the current transaction.
+     */
     void (*log_stop)(MemoryListener *listener, MemoryRegionSection *section,
                      int old, int new);
+
+    /**
+     * @log_sync:
+     *
+     * Called by memory_region_snapshot_and_clear_dirty() and
+     * memory_global_dirty_log_sync(), before accessing QEMU's "official"
+     * copy of the dirty memory bitmap for a #MemoryRegionSection.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The #MemoryRegionSection.
+     */
     void (*log_sync)(MemoryListener *listener, MemoryRegionSection *section);
+
+    /**
+     * @log_clear:
+     *
+     * Called before reading the dirty memory bitmap for a
+     * #MemoryRegionSection.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The #MemoryRegionSection.
+     */
     void (*log_clear)(MemoryListener *listener, MemoryRegionSection *section);
+
+    /**
+     * @log_global_start:
+     *
+     * Called by memory_global_dirty_log_start(), which
+     * enables the %DIRTY_LOG_MIGRATION client on all memory regions in
+     * the address space.  #MemoryListener.log_global_start() is also
+     * called when a #MemoryListener is added, if global dirty logging is
+     * active at that time.
+     *
+     * @listener: The #MemoryListener.
+     */
     void (*log_global_start)(MemoryListener *listener);
+
+    /**
+     * @log_global_stop:
+     *
+     * Called by memory_global_dirty_log_stop(), which
+     * disables the %DIRTY_LOG_MIGRATION client on all memory regions in
+     * the address space.
+     *
+     * @listener: The #MemoryListener.
+     */
     void (*log_global_stop)(MemoryListener *listener);
+
+    /**
+     * @log_global_after_sync:
+     *
+     * Called after reading the dirty memory bitmap
+     * for any #MemoryRegionSection.
+     *
+     * @listener: The #MemoryListener.
+     */
     void (*log_global_after_sync)(MemoryListener *listener);
+
+    /**
+     * @eventfd_add:
+     *
+     * Called during an address space update transaction,
+     * for a section of the address space that has had a new ioeventfd
+     * registration since the last transaction.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The new #MemoryRegionSection.
+     * @match_data: The @match_data parameter for the new ioeventfd.
+     * @data: The @data parameter for the new ioeventfd.
+     * @e: The #EventNotifier parameter for the new ioeventfd.
+     */
     void (*eventfd_add)(MemoryListener *listener, MemoryRegionSection *section,
                         bool match_data, uint64_t data, EventNotifier *e);
+
+    /**
+     * @eventfd_del:
+     *
+     * Called during an address space update transaction,
+     * for a section of the address space that has dropped an ioeventfd
+     * registration since the last transaction.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The new #MemoryRegionSection.
+     * @match_data: The @match_data parameter for the dropped ioeventfd.
+     * @data: The @data parameter for the dropped ioeventfd.
+     * @e: The #EventNotifier parameter for the dropped ioeventfd.
+     */
     void (*eventfd_del)(MemoryListener *listener, MemoryRegionSection *section,
                         bool match_data, uint64_t data, EventNotifier *e);
+
+    /**
+     * @coalesced_io_add:
+     *
+     * Called during an address space update transaction,
+     * for a section of the address space that has had a new coalesced
+     * MMIO range registration since the last transaction.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The new #MemoryRegionSection.
+     * @addr: The starting address for the coalesced MMIO range.
+     * @len: The length of the coalesced MMIO range.
+     */
     void (*coalesced_io_add)(MemoryListener *listener, MemoryRegionSection *section,
                                hwaddr addr, hwaddr len);
+
+    /**
+     * @coalesced_io_del:
+     *
+     * Called during an address space update transaction,
+     * for a section of the address space that has dropped a coalesced
+     * MMIO range since the last transaction.
+     *
+     * @listener: The #MemoryListener.
+     * @section: The new #MemoryRegionSection.
+     * @addr: The starting address for the coalesced MMIO range.
+     * @len: The length of the coalesced MMIO range.
+     */
     void (*coalesced_io_del)(MemoryListener *listener, MemoryRegionSection *section,
                                hwaddr addr, hwaddr len);
-    /* Lower = earlier (during add), later (during del) */
+    /**
+     * @priority:
+     *
+     * Govern the order in which memory listeners are invoked. Lower priorities
+     * are invoked earlier for "add" or "start" callbacks, and later for "delete"
+     * or "stop" callbacks.
+     */
     unsigned priority;
+
+    /* private: */
     AddressSpace *address_space;
     QTAILQ_ENTRY(MemoryListener) link;
     QTAILQ_ENTRY(MemoryListener) link_as;
@@ -940,6 +1142,7 @@ void memory_region_init_rom(MemoryRegion *mr,
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
  * @ops: callbacks for write access handling (must not be NULL).
+ * @opaque: passed to the read and write callbacks of the @ops structure.
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -1028,7 +1231,7 @@ static inline IOMMUMemoryRegion *memory_region_get_iommu(MemoryRegion *mr)
  * Returns pointer to IOMMUMemoryRegionClass if a memory region is an iommu,
  * otherwise NULL. This is fast path avoiding QOM checking, use with caution.
  *
- * @mr: the memory region being queried
+ * @iommu_mr: the memory region being queried
  */
 static inline IOMMUMemoryRegionClass *memory_region_get_iommu_class_nocheck(
         IOMMUMemoryRegion *iommu_mr)
@@ -1098,6 +1301,7 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
  * @n: the IOMMUNotifier to be added; the notify callback receives a
  *     pointer to an #IOMMUTLBEntry as the opaque value; the pointer
  *     ceases to be valid on exit from the notifier.
+ * @errp: pointer to Error*, to store an error if it happens.
  */
 int memory_region_register_iommu_notifier(MemoryRegion *mr,
                                           IOMMUNotifier *n, Error **errp);
@@ -1585,6 +1789,8 @@ void memory_region_add_subregion_overlap(MemoryRegion *mr,
 /**
  * memory_region_get_ram_addr: Get the ram address associated with a memory
  *                             region
+ *
+ * @mr: the region to be queried
  */
 ram_addr_t memory_region_get_ram_addr(MemoryRegion *mr);
 
@@ -2155,6 +2361,7 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
  * @addr: address within that address space
  * @attrs: memory transaction attributes
  * @buf: buffer with the data transferred
+ * @len: length of the data transferred
  */
 static inline __attribute__((__always_inline__))
 MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
-- 
2.21.0


