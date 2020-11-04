Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AFFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:54:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3374420BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/9d5wDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3374420BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaAoM-0002U0-9S
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 23:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAlL-0005qF-I4
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAlG-0004Qd-Mm
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=73Mpz3vICh9QEBEOeL5uEWGSphcZBjM+o5MkFyzWxeI=;
 b=O/9d5wDVhtyL0lM1kXwrxPJEFl5Ai2C8LZGoGvcMT7L8soHgb7kzoD0dihbil2cHYhtLOi
 HPzATNdA3+oLGLlBanfSDAT0XNbYmtSbpOTlqRnwMliCnJAoTylrfIoRhqMI7ehSbRuBMK
 sNsCEaw1OfRsbehIj7gWbHA09gzwGAU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-4eZ7zOzZOuSggcZZcxF_9Q-1; Tue, 03 Nov 2020 23:51:02 -0500
X-MC-Unique: 4eZ7zOzZOuSggcZZcxF_9Q-1
Received: by mail-wr1-f69.google.com with SMTP id w6so1099914wrk.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:51:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=73Mpz3vICh9QEBEOeL5uEWGSphcZBjM+o5MkFyzWxeI=;
 b=sFH4bKxKSD9sYzv8H3YJqXhoijpPeVPbMd+HBWAWmOSej/20uTNql6k1rT/JBd42e8
 3C4nwdc6aGfrhfe3sg9zI63ilTPFp2zYi1H3doPuf96ee1AWs5FCWY44XeqLAL6THjWF
 j+qrOa6C0hamwn3xyIv7jBlzoXwlisRu0actUEdVQCJC6FaF7bfdkjswj+aNxVsw4ESV
 /mEnZbH+xJbyALdPjtRnuWD2HrhoS345LHwquOZveFFrkFu/4vUzRyF7yB1TaJVnRVPb
 Gcz+Z1tc+4HnZlaZTFyuyjMvRJ3DtYnAnCLCJb4v3sLNE1ci6k3Mo5xdryU1Rd8jcrxX
 zwEw==
X-Gm-Message-State: AOAM533Ku1cdhmRwhyjn8FgBgvluB34GrmW4uAIJ+u2DzE7ep1Rctx6Z
 T4TqKWrEuYeAQo5Ex45nSBOv12mrP6pyTU7RaMSM3nQPCnEwM+rV4DJppYdp4Dv7JtdnzHIsl9+
 /yUWNR0Wx83Reltc=
X-Received: by 2002:a1c:1f91:: with SMTP id f139mr2336235wmf.187.1604465460814; 
 Tue, 03 Nov 2020 20:51:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlGTxgt4fQa8bVOXzeewVRGwCjYkKkN/GaCyW25cF43kupxdh/NTQGpck5fieisT+WO4yKbw==
X-Received: by 2002:a1c:1f91:: with SMTP id f139mr2336229wmf.187.1604465460681; 
 Tue, 03 Nov 2020 20:51:00 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id b7sm868891wrp.16.2020.11.03.20.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:51:00 -0800 (PST)
Date: Tue, 3 Nov 2020 23:50:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 06/38] memory-device: Add get_min_alignment() callback
Message-ID: <20201104044937.226370-7-mst@redhat.com>
References: <20201104044937.226370-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104044937.226370-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Add a callback that can be used to express additional alignment
requirements (exceeding the ones from the memory region).

Will be used by virtio-mem to express special alignment requirements due
to manually configured, big block sizes (e.g., 1GB with an ordinary
memory-backend-ram). This avoids failing later when realizing, because
auto-detection wasn't able to assign a properly aligned address.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20201008083029.9504-6-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/mem/memory-device.h | 10 ++++++++++
 hw/mem/memory-device.c         | 11 +++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 30d7e99f52..48d2611fc5 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -88,6 +88,16 @@ struct MemoryDeviceClass {
      */
     MemoryRegion *(*get_memory_region)(MemoryDeviceState *md, Error **errp);
 
+    /*
+     * Optional: Return the desired minimum alignment of the device in guest
+     * physical address space. The final alignment is computed based on this
+     * alignment and the alignment requirements of the memory region.
+     *
+     * Called when plugging the memory device to detect the required alignment
+     * during address assignment.
+     */
+    uint64_t (*get_min_alignment)(const MemoryDeviceState *md);
+
     /*
      * Translate the memory device into #MemoryDeviceInfo.
      */
diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 8a736f1a26..cf0627fd01 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -259,7 +259,7 @@ void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
 {
     const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
     Error *local_err = NULL;
-    uint64_t addr, align;
+    uint64_t addr, align = 0;
     MemoryRegion *mr;
 
     mr = mdc->get_memory_region(md, &local_err);
@@ -267,7 +267,14 @@ void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
         goto out;
     }
 
-    align = legacy_align ? *legacy_align : memory_region_get_alignment(mr);
+    if (legacy_align) {
+        align = *legacy_align;
+    } else {
+        if (mdc->get_min_alignment) {
+            align = mdc->get_min_alignment(md);
+        }
+        align = MAX(align, memory_region_get_alignment(mr));
+    }
     addr = mdc->get_addr(md);
     addr = memory_device_get_free_addr(ms, !addr ? NULL : &addr, align,
                                        memory_region_size(mr), &local_err);
-- 
MST


