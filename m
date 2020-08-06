Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FFEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D91923135
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhXF6UyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D91923135
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3hnH-0003dd-6h
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 11:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3hmh-0003BJ-5x
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 11:26:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54954
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3hme-0002pu-1g
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 11:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596727578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=erb4eP7PIYp6JmNYBDmPFH3s05kn31bn3ZVdcIfEQdM=;
 b=FhXF6UyRABbZ+RYKNDtwBmTteJG7rYGlDWzEmNQUt9UZLrhKS8fjWXeJAM47JbmTpydob1
 ZuyYcrjL+VFDZZybT9rY/2NrWOI4+2ZYbzXWfmsrHlOm6ERRm/JNy+6LTCxeIE/THo9O37
 ctYCNmFEsi1bQp4b7jV5AWMnAZhK+js=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-bavoQM_nOnev5rhYpdEoUQ-1; Thu, 06 Aug 2020 11:26:16 -0400
X-MC-Unique: bavoQM_nOnev5rhYpdEoUQ-1
Received: by mail-wr1-f72.google.com with SMTP id b13so12212016wrq.19
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 08:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=erb4eP7PIYp6JmNYBDmPFH3s05kn31bn3ZVdcIfEQdM=;
 b=tMKs3HSMSQGp45ApptT/vvP6KUgCSQXerZ2vnjPVx+nHx0+/gGxG2p7JYs3TqcNIKC
 Bra8wdELGDFauOaV7n27kmp+0VEV4MPgLdhpDV1vpEp9yYjwYcXnbs3hiaEyAJ8MuLEl
 WEq6NiHuoFtLzvz5hATrhIHuOtMOayBPxg5Onvz5o5+ru1qI8I+2i3xBOSiIcg3x8BGH
 5BFWMqMOVu/PA85PIV5J58I1LjDv93COpnGeOSqKEOgnCnBnFLr3MR/Sld8G3n0VHFL1
 sWaB5CSzLqFLUwAb9a4/g1YAuGhmvFacirPL7C9QrxvTzZBT3sotc2iLNr80i8TgfvF3
 7ubg==
X-Gm-Message-State: AOAM533+X7e3PMS7JKnf54m72aOILjarNUtERSHB4ayTtWsfJF589ZoI
 zcWcefGzUMkGRizMdQpy7YAzKJPXkhMSx4Q0ueS6z3h7SUR4e9y++UxhTS3sUm0q8zOmmYvYg8/
 rDJ86FhUxjpbAOxE=
X-Received: by 2002:a5d:4c46:: with SMTP id n6mr8497457wrt.73.1596727575355;
 Thu, 06 Aug 2020 08:26:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzGom+7chBf43WRzG7UBH+s5kncXRbxNggp/OVPiME0g2KVOXFtPLirwA55fOiypJucKUjdg==
X-Received: by 2002:a5d:4c46:: with SMTP id n6mr8497438wrt.73.1596727575141;
 Thu, 06 Aug 2020 08:26:15 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id c14sm6767633wrw.85.2020.08.06.08.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 08:26:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2] memory: Add trace events to audit MemoryRegionOps
 fields
Date: Thu,  6 Aug 2020 17:26:13 +0200
Message-Id: <20200806152613.18523-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:03:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add trace events to audit MemoryRegionOps field such:
 - are all the valid/impl fields provided?
 - is the region a power of two?

These cases are accepted, but it is interesting to list them.

Example:

  $ qemu-system-i386 -S -trace memory_region_io_check\*
  memory_region_io_check_odd_size mr name:'dma-page' size:0x3
  memory_region_io_check_access_size_incomplete mr name:'acpi-tmr' min/max:[valid:1/4 impl:4/0]
  memory_region_io_check_access_size_incomplete mr name:'acpi-evt' min/max:[valid:1/2 impl:2/0]
  memory_region_io_check_access_size_incomplete mr name:'acpi-cnt' min/max:[valid:1/2 impl:2/0]

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Based-on: <20200805130221.24487-1-philmd@redhat.com>
          "softmmu: Add missing trace-events file"
---
 softmmu/memory.c     | 11 +++++++++++
 softmmu/trace-events |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/softmmu/memory.c b/softmmu/memory.c
index d030eb6f7c..daa0daf2a8 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1488,6 +1488,17 @@ void memory_region_init_io(MemoryRegion *mr,
     mr->ops = ops ? ops : &unassigned_mem_ops;
     mr->opaque = opaque;
     mr->terminates = true;
+    if (size != UINT64_MAX && !is_power_of_2(size)) {
+        trace_memory_region_io_check_odd_size(name, size);
+    }
+    if (ops && (!ops->impl.min_access_size || !ops->impl.max_access_size ||
+                !ops->valid.min_access_size || !ops->valid.max_access_size)) {
+        trace_memory_region_io_check_access_size_incomplete(name,
+                mr->ops->valid.min_access_size,
+                mr->ops->valid.max_access_size,
+                mr->ops->impl.min_access_size,
+                mr->ops->impl.max_access_size);
+    }
 }
 
 void memory_region_init_ram_nomigrate(MemoryRegion *mr,
diff --git a/softmmu/trace-events b/softmmu/trace-events
index b80ca042e1..00eb316aef 100644
--- a/softmmu/trace-events
+++ b/softmmu/trace-events
@@ -18,6 +18,8 @@ memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t
 flatview_new(void *view, void *root) "%p (root %p)"
 flatview_destroy(void *view, void *root) "%p (root %p)"
 flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
+memory_region_io_check_odd_size(const char *name, uint64_t size) "mr name:'%s' size:0x%"PRIx64
+memory_region_io_check_access_size_incomplete(const char *name, unsigned vmin, unsigned vmax, unsigned imin, unsigned imax) "mr name:'%s' min/max:[valid:%u/%u impl:%u/%u]"
 
 # vl.c
 vm_state_notify(int running, int reason, const char *reason_str) "running %d reason %d (%s)"
-- 
2.21.3


