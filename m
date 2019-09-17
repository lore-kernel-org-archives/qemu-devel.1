Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874D3C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C41206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C41206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAFP0-0000AZ-9s
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 11:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iAF8N-0002ke-R3
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iAF8M-0000US-St
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:11:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43212)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iAF8M-0000UC-Nq
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:11:14 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0A9F82A09B3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 15:11:14 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id c8so4527571qtd.20
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 08:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7RdwU1BFDRkMHPHKf1AWwBU84oX8jYJL/6ib3XggkUM=;
 b=c4MLhJRVGdWDIs55tyjVHk/MSh3SkTyeq5mUXm+v2+19XZ4EBPHCKH/vTPGhhL/STZ
 IVFGUtTyGik1uFuFDEnpPvMx8M9rP5G8p2LL4FadzA1Ohe5ZmIz0rXqU7AnVwMBdcKBt
 8+Li7h5A5z+V4gTCiBz7aFc98DZzSuzSX6xT0SDHXUt+2tT6nlhL7zw089YP+62+dpoO
 OAJ8T6Ny8YWq8t/2b5dzVeWWNNQn0OWNjJ4h/uBMJISrvhjom8CwHLZqmmz1LeVmCtMC
 kkA8DHFOgvhHiM0NXKTuTcqH9qolXZhN+viCsWmHC2bYg9rgO+5exP0c3Epfcuk5kzLx
 F9ng==
X-Gm-Message-State: APjAAAVWIhHm3auJhHLwf1LMsx8IrsmVcQqp2gNEKQl8Q8YX9ewOg/x6
 aInRBnP5xojUiCa8COcnrlNNWVD3ZKs7PYohTipkm43C2VJgHzHnbkk7gCCYB5Tttnu3kXapTKT
 0keTTNioakPdr/cc=
X-Received: by 2002:a37:7402:: with SMTP id p2mr4361927qkc.457.1568733073078; 
 Tue, 17 Sep 2019 08:11:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzUblc/p90jPuLhiQevBTqlKBWCPJk5l4Li7o5O+Kb8bVRID4BF3IxuojauX0GwMevV7Q3m4w==
X-Received: by 2002:a37:7402:: with SMTP id p2mr4361900qkc.457.1568733072914; 
 Tue, 17 Sep 2019 08:11:12 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id v139sm1210628qkb.53.2019.09.17.08.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 08:11:12 -0700 (PDT)
Date: Tue, 17 Sep 2019 11:11:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190916080718.3299-5-peterx@redhat.com>
References: <20190917151011.24588-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190917151011.24588-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/10] intel_iommu: Remove the caching-mode
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190917151108.Y3vOLwJjXsdEj8BX1LhMqzskf_-8DbPFkgd6Ma8uL7o@z>

From: Peter Xu <peterx@redhat.com>

That's never a good place to stop QEMU process... Since now we have
both the machine done sanity check and also the hotplug handler, we
can safely remove this to avoid that.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190916080718.3299-5-peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index bed8ffe446..f1de8fdb75 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2936,10 +2936,6 @@ static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
     VTDAddressSpace *vtd_as = container_of(iommu, VTDAddressSpace, iommu);
     IntelIOMMUState *s = vtd_as->iommu_state;
 
-    if (!s->caching_mode && new & IOMMU_NOTIFIER_MAP) {
-        vtd_panic_require_caching_mode();
-    }
-
     /* Update per-address-space notifier flags */
     vtd_as->notifier_flags = new;
 
-- 
MST


