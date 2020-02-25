Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE3EC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3093218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLZ+33xP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3093218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Zuk-0001tm-2Q
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlW-0002Pn-3M
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlV-0002Mc-22
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:42 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:40720)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlU-0002IN-R1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:41 -0500
Received: by mail-wm1-x330.google.com with SMTP id t14so2838164wmi.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8TDYd04UA0rta6zGgONMidUyYq1Fh/peI3QjQAoJMVs=;
 b=dLZ+33xPr4HB9mTbNwBfP7thYSuTbJsdIoKRDLnPIpqkAqEooN+9BPx2T0oCq6Sg6S
 JHjeeGd0UjeZpw+hjLqckRbovEhmApURZRfAOnpp3PFzmRiaEP8nQ/YwEwsnjs0d0JoP
 PpH39rt21JkbFThhXAYpSWTm5Q+0BsLTHu5Rt+2oha3gyfQyPU1ssrqPoBy2Dv6hpO6a
 +TGNGoZ9A95q9nth183BjB8vR+aDhY01JT56SynvRpgh5pTlf1LlXoHWZW7fOldpZV7z
 9Kjlr8EWO7UmiNamnMSRuGrW4g/Qk7BRy8LQ3olYxUEZD/Du9gYmZ0B+/+6EZ5jS/e5T
 oaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8TDYd04UA0rta6zGgONMidUyYq1Fh/peI3QjQAoJMVs=;
 b=tSskwsGXvh3QcaF1cDBJ5uQYyJSXWRkxmKLiwEf/MakGiGZAmWzIdH8ivvLBEbKCAA
 rX7Y4+9m/6rD7XY2XTrfmFpMoXb4AUfdRM1BJXNn3vmHfdIaI9sKr4Zf8U8sIYR9r5tD
 zNQcPfMDpv2IbRx7tRzb+jfORou1FFmHZQisnXu2y3LZohqp4TIl+D2NvwOcXsPbpcBM
 1DRJDO1t2IPY05+WHD3ybuatvbYdHP+pnts7tyzNt1uAoMtX/BZycSKMrU78gM8kMllw
 uyzVy4R40e95Abh8n96nCB2oz2CvPVFWiHLig6PVwp7iC+xLr76EFB0ZMY/vhZkrMqZc
 owig==
X-Gm-Message-State: APjAAAVq19LxCsBGV5LhC/lpmh+9lApSzn72NrbAtwG5jKxetMWh/CwV
 FZPnHOzgtDXavc7RswI7C/J3TRp4
X-Google-Smtp-Source: APXvYqyzqVuQTAe5mO8QL/XLZGUUdjKlSNC9yVOICjHxQZko6NGdq7mbMwoY7rLF/ObR291YNPrm7Q==
X-Received: by 2002:a05:600c:3d1:: with SMTP id
 z17mr5157071wmd.90.1582631559654; 
 Tue, 25 Feb 2020 03:52:39 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 101/136] scripts/cocci: Rename memory-region-{init-ram ->
 housekeeping}
Date: Tue, 25 Feb 2020 12:50:31 +0100
Message-Id: <1582631466-13880-101-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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

As we are going to add various semantic changes related to the memory
region API, rename this script to be more generic.
Add a 'usage' header, and an entry in MAINTAINERS to avoid checkpatch
warning.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-4-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 MAINTAINERS                                                 |  1 +
 ...gion-init-ram.cocci => memory-region-housekeeping.cocci} | 13 +++++++++++++
 2 files changed, 14 insertions(+)
 rename scripts/coccinelle/{memory-region-init-ram.cocci => memory-region-housekeeping.cocci} (84%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 195dd58..316a8ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1998,6 +1998,7 @@ F: include/exec/ramblock.h
 F: memory.c
 F: include/exec/memory-internal.h
 F: exec.c
+F: scripts/coccinelle/memory-region-housekeeping.cocci
 
 SPICE
 M: Gerd Hoffmann <kraxel@redhat.com>
diff --git a/scripts/coccinelle/memory-region-init-ram.cocci b/scripts/coccinelle/memory-region-housekeeping.cocci
similarity index 84%
rename from scripts/coccinelle/memory-region-init-ram.cocci
rename to scripts/coccinelle/memory-region-housekeeping.cocci
index d290150..3699c10 100644
--- a/scripts/coccinelle/memory-region-init-ram.cocci
+++ b/scripts/coccinelle/memory-region-housekeeping.cocci
@@ -1,3 +1,16 @@
+/*
+  Usage:
+
+    spatch \
+        --macro-file scripts/cocci-macro-file.h \
+        --sp-file scripts/coccinelle/memory-region-housekeeping.cocci \
+        --keep-comments \
+        --in-place \
+        --dir .
+
+*/
+
+
 // Replace by-hand memory_region_init_ram_nomigrate/vmstate_register_ram
 // code sequences with use of the new memory_region_init_ram function.
 // Similarly for the _rom and _rom_device functions.
-- 
1.8.3.1



