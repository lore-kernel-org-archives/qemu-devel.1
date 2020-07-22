Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21DFC433E5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB7F20771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xeb/gik5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB7F20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyDaC-0007CB-01
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 08:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDYk-0005OV-3b
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:09:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51912
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDYi-0006ZE-Bm
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595419755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/9YW6K8+jtBdnSbdO+Q9oFDtvItrtur2iZwhghw1mqc=;
 b=Xeb/gik5m7PQ2gbf/c2vOOOwmg3qqce8hr+lJgTUfgLp5EguAAwo4M7Jji2/ajgc3otI8c
 0V4tmqjw42ILAolv4683zqjy5Wne2T9yxken8mPC9Go8OesmN8wyo93Z/hhkdgyv1lOyMB
 DH3DKmgzHAnniGOVXfO1iHQEbSe7760=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-GJoeoM3MNVmnpsfBSB7EUw-1; Wed, 22 Jul 2020 08:09:12 -0400
X-MC-Unique: GJoeoM3MNVmnpsfBSB7EUw-1
Received: by mail-wr1-f70.google.com with SMTP id t12so555289wrp.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 05:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/9YW6K8+jtBdnSbdO+Q9oFDtvItrtur2iZwhghw1mqc=;
 b=W9ZkgYUuonxPpuRypP8JNPEBJcLtb0qNQ73o34NTRu1UeU9ZXWzV7MaWpXMF2xawHO
 +/wxJxbu/kY8e0p5+6zU/2qcGgdixjn1NSbvsWPo+YCYHUFIl5LRS+2rewR/3a9F2etC
 DOuFvFm/id6vyEdq337m2B6nOC6UbGn0iWoifwGitjW94nMawRDhsNWh/6JrzW+DavBu
 KR/wfRJjC1sAGlmpTn/a/rIp+HdkxSqC6APrIkUkGESaPPtN9iSNwMhCYhfIVLqlm05G
 yA4MLmy/sKXh/btgVZb/y9+Gg/mBqqZNjFSDbPYClC/pDVHEQqkWo8EO04NwGEBW5oRo
 JT8Q==
X-Gm-Message-State: AOAM533udXqQMK+1BtLL/+qWbjc9oEsqQ8K9CS492J7Jgo2fPMrXRIp/
 eFHhyjFqVrmVsmH9LOLPndzaSP1iwRATD0lSMXRKB2zMpraWs3Vm+/3gMBLe+UCWrj8JBDmsulE
 z9m+hRXZUSRbws+Y=
X-Received: by 2002:a1c:27c1:: with SMTP id n184mr8741907wmn.6.1595419750760; 
 Wed, 22 Jul 2020 05:09:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfJnsv60NWLAY6CpOwKF2nDjeLmGeyF0puGnN737dNdp1aGisd8T8TjzAYIVhDY+sDvfhy/g==
X-Received: by 2002:a1c:27c1:: with SMTP id n184mr8741885wmn.6.1595419750484; 
 Wed, 22 Jul 2020 05:09:10 -0700 (PDT)
Received: from redhat.com (bzq-79-182-82-99.red.bezeqint.net. [79.182.82.99])
 by smtp.gmail.com with ESMTPSA id
 k14sm39983301wrn.76.2020.07.22.05.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 05:09:09 -0700 (PDT)
Date: Wed, 22 Jul 2020 08:09:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/9] acpi: accept byte and word access to core ACPI registers
Message-ID: <20200722120853.9144-2-mst@redhat.com>
References: <20200722120853.9144-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200722120853.9144-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Simon John <git@the-jedi.co.uk>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-stable@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Tokarev <mjt@tls.msk.ru>

All ISA registers should be accessible as bytes, words or dwords
(if wide enough).  Fix the access constraints for acpi-pm-evt,
acpi-pm-tmr & acpi-cnt registers.

Fixes: 5d971f9e67 (memory: Revert "memory: accept mismatching sizes in memory_region_access_valid")
Fixes: afafe4bbe0 (apci: switch cnt to memory api)
Fixes: 77d58b1e47 (apci: switch timer to memory api)
Fixes: b5a7c024d2 (apci: switch evt to memory api)
Buglink: https://lore.kernel.org/xen-devel/20200630170913.123646-1-anthony.perard@citrix.com/T/
Buglink: https://bugs.debian.org/964793
BugLink: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=964247
BugLink: https://bugs.launchpad.net/bugs/1886318
Reported-By: Simon John <git@the-jedi.co.uk>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20200720160627.15491-1-mjt@msgid.tls.msk.ru>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index f6d9ec4f13..ac06db3450 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -458,7 +458,8 @@ static void acpi_pm_evt_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps acpi_pm_evt_ops = {
     .read = acpi_pm_evt_read,
     .write = acpi_pm_evt_write,
-    .valid.min_access_size = 2,
+    .impl.min_access_size = 2,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 2,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
@@ -527,7 +528,8 @@ static void acpi_pm_tmr_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps acpi_pm_tmr_ops = {
     .read = acpi_pm_tmr_read,
     .write = acpi_pm_tmr_write,
-    .valid.min_access_size = 4,
+    .impl.min_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
@@ -599,7 +601,8 @@ static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps acpi_pm_cnt_ops = {
     .read = acpi_pm_cnt_read,
     .write = acpi_pm_cnt_write,
-    .valid.min_access_size = 2,
+    .impl.min_access_size = 2,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 2,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
-- 
MST


