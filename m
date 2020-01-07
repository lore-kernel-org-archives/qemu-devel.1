Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E0DC33CA1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43862077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HogvtyXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43862077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iojro-0004HQ-W2
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 03:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iojP4-0004Zi-N6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iojP3-0007Wd-LP
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:50 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20474
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iojP0-0007Ur-Dd
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8li2Tk9kJtAQIFMop0/eFLC5J5NJiOvfkc+z767fYRk=;
 b=HogvtyXI3VzvlEmTLBmAnzwCYyLYGEk+AUY8MWTpWARDkIvigMXz3nk2iU+oLYFGYD6MaN
 lOTWnJ4CtczqYLqd64w2zvH1qkEka0hvBoctE4DBqmlkDjEU5VFq4dr/xzq5a4FnkEyghF
 wK0V32mHe4WSNgyw2BOFehfuf3mUKME=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-G3m3jKvvNdaGHMZlVlcbMg-1; Tue, 07 Jan 2020 02:35:44 -0500
Received: by mail-qv1-f69.google.com with SMTP id z12so17940086qvk.14
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8e5zVSr3EGK6wfLcmhM6md/VpcFIAiAuGM2x/CJ8sg4=;
 b=X46Ft6HaYu8J8Cxo+dYAMb4vuJPJwDwwbcDSI0bqFhXId3x1Fryp1UyPoF+qasRHU7
 di0gvyccUannn33fJIl6+CnVVCH4nmBoNG98rFOcWMGrJuhbE9574sj+8nAmVcj24znD
 u7Lt8PX5R9D87AX31OJ1unP7Lz8dHZKGNI3mKTCio0Gu68hHyAjsZYi5OwAg6gtcoGix
 k6JVdAVgz+rijTyuklMkmwiwOa3i27SpYAwBCGiR29I0wDssRO37KooRoFl4IwP0Ueng
 Ba7QiRCppS/kMHpX9kl8iRv+PXF3JU4bTD+IkaSGpWQQPKzfcZV2YPAqJdrcxxQVH9ss
 7Jfg==
X-Gm-Message-State: APjAAAUa1Tzv3FFQpasDvynw8MK6uyvdQrQcDTpYqK1t6buTXlE6PELi
 BG+zGCwyZyRaKGdtY6OnYzRUWScUH/fnoJIrswHW3ZcppOfbB4FmKY7aHdBtznpBRlPetz7v/y2
 ob+nFqnMw4fMWQC0=
X-Received: by 2002:a05:620a:21d4:: with SMTP id
 h20mr81885584qka.468.1578382543028; 
 Mon, 06 Jan 2020 23:35:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqyatL31mOxSE5z9V23HTQJKxL0TSnNxOQcFDqsEtK3Fs7Qqf2TobbCX3OyucIah+RFEObT/xA==
X-Received: by 2002:a05:620a:21d4:: with SMTP id
 h20mr81885570qka.468.1578382542828; 
 Mon, 06 Jan 2020 23:35:42 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id t3sm24870210qtc.8.2020.01.06.23.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 23:35:42 -0800 (PST)
Date: Tue, 7 Jan 2020 02:35:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 06/32] intel_iommu: fix bug to read DMAR_RTADDR_REG
Message-ID: <20200107073451.298261-7-mst@redhat.com>
References: <20200107073451.298261-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107073451.298261-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: G3m3jKvvNdaGHMZlVlcbMg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yi Sun <yi.y.sun@linux.intel.com>

Should directly read DMAR_RTADDR_REG but not using 's->root'.
Because 's->root' is modified in 'vtd_root_table_setup()' so
that the first 12 bits are omitted. This causes the guest
iommu debugfs cannot show pasid tables.

Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Message-Id: <20191205095439.29114-1-yi.y.sun@linux.intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 43c94b993b..ee06993675 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2610,16 +2610,15 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr a=
ddr, unsigned size)
     switch (addr) {
     /* Root Table Address Register, 64-bit */
     case DMAR_RTADDR_REG:
+        val =3D vtd_get_quad_raw(s, DMAR_RTADDR_REG);
         if (size =3D=3D 4) {
-            val =3D s->root & ((1ULL << 32) - 1);
-        } else {
-            val =3D s->root;
+            val =3D val & ((1ULL << 32) - 1);
         }
         break;
=20
     case DMAR_RTADDR_REG_HI:
         assert(size =3D=3D 4);
-        val =3D s->root >> 32;
+        val =3D vtd_get_quad_raw(s, DMAR_RTADDR_REG) >> 32;
         break;
=20
     /* Invalidation Queue Address Register, 64-bit */
--=20
MST


