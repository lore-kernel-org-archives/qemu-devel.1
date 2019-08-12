Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5562DC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 07:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F762085A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 07:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F762085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx52G-0005ti-Dy
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 03:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51288)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1hx51U-000496-Vk
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 03:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hx51U-0007fM-3D
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 03:45:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hx51T-0007f9-U3
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 03:45:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so4604840wrl.7
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 00:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RDsG20k8yVofF8t9UymKDQFqIL+ySKvJDtTXty8WtCk=;
 b=CFqSufbk2gCz8HApESXBrG4/PZGaBbhQpEh4eXEOu266QR6hJacBksdl3i7vtoZyHR
 x3BgSNi/jLjNrEKd+954N7pFHYmjX/SUxrVaTEFPbnm4hcqPSKx2Pr7Zx4Wkz0DvDG7k
 1WkXYafACE5KEMMa3Krt0bR2Vkl2+K82bL56oppvLuPjcPbpYhDfxh/qpIhDFLeZWRYQ
 ipKMNpSaQr/1cQYJmOjWr35wYOR6Qvttf1EbDK3kir4QFSwCrAL1KAykHrw0Y3Qwf9UK
 iH7ezgsbOYcr4weRCp8+a+U73lzbSivfO5JyTN1f/9ri13xvS/NWpqgJZj0p3B4Yd+nm
 BLbQ==
X-Gm-Message-State: APjAAAW2XdjsrI4oQV0wbQ59YlDnJp29s4za25EMK/G4i31Vg9fokk20
 iXCLiEXbMTGC15Xu2doRoyBQwNZSeexs1g==
X-Google-Smtp-Source: APXvYqwLMvFtM7QbmCnKR225ZLij0ipSwVowg80bETE3bUL9r5laaPfYomGqzzCi39n5Z8RNbmTbrg==
X-Received: by 2002:adf:a2cd:: with SMTP id t13mr19811607wra.251.1565595942814; 
 Mon, 12 Aug 2019 00:45:42 -0700 (PDT)
Received: from xz-x1.redhat.com (net77-43-52-122.mclink.it. [77.43.52.122])
 by smtp.gmail.com with ESMTPSA id a84sm15909450wmf.29.2019.08.12.00.45.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 12 Aug 2019 00:45:42 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 12 Aug 2019 09:45:31 +0200
Message-Id: <20190812074531.28970-5-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812074531.28970-1-peterx@redhat.com>
References: <20190812074531.28970-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: [Qemu-devel] [PATCH RFC 4/4] intel_iommu: Remove the caching-mode
 check during flag change
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 peterx@redhat.com, Bandan Das <bsd@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

That's never a good place to stop QEMU process... Since now we have
both the machine done sanity check and also the hotplug handler, we
can safely remove this to avoid that.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 642dd595ed..93b26b633b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2932,10 +2932,6 @@ static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
     VTDAddressSpace *vtd_as = container_of(iommu, VTDAddressSpace, iommu);
     IntelIOMMUState *s = vtd_as->iommu_state;
 
-    if (!s->caching_mode && new & IOMMU_NOTIFIER_MAP) {
-        vtd_panic_require_caching_mode();
-    }
-
     /* Update per-address-space notifier flags */
     vtd_as->notifier_flags = new;
 
-- 
2.21.0


