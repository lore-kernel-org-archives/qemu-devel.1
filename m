Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FAEC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCCD2206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCD2206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9m72-0000K7-Ji
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 04:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i9m36-00057r-Jm
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:07:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i9m35-0002DN-JQ
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:07:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38698)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i9m35-0002Cx-CB
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:07:51 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A4B31C055673
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 08:07:50 +0000 (UTC)
Received: by mail-pg1-f200.google.com with SMTP id h10so4095358pgh.11
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 01:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZFeNVkx/j6RSMxkpoM7GQeDxNvolVV9ALPcNdbnD3Qk=;
 b=GMNfbbZDDOyoikPeRzMscrxQwpzHQWKQZz36FBem0woL0UBebVxpcHE0GsJzr/Rh2P
 tJJlzL/TMWcWUlYRxT2DJznANme0ukHwknz9nvU6/Dk2chOYfWWNmlHzvwXTzbTdcLgV
 gtzrdCJLrDYwHyqwpoGipLFtiDprGR9fK9iu/3p6lpxDK9hQPEUvCcLhhHUPtFuthjX+
 d34FbqY2VZYVv7UhUTvnPOfRPKm8ohprj7b1q5YzPSMGaBtTGa5QTCfYROZajhf5d+BT
 hos5zpD1xP50lErnyR6UrBDh07tPwOx1W4r3y42kHcyzDnTel2RmfX1xY8sa5EBXN+XR
 fL3Q==
X-Gm-Message-State: APjAAAXsNL4oo+SQdFINXnOBseEBnX4bbSjxyCAVzTWDKH/L5QkKYfCU
 eugkbdMPnUPfm90v3vvkTXP1hAhqDrqRg0BFjy2qwbbP2xtbrBrQRMiGVR6KlGtCN5flH0RZsiq
 T0EOQXo+H12SZwIs=
X-Received: by 2002:a17:90a:b282:: with SMTP id
 c2mr19253820pjr.135.1568621269826; 
 Mon, 16 Sep 2019 01:07:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxkFFwjEfZlp/nZTRkhUNzWW0Wdn8A/aiyl/jiPz+lt+ghFCdhyDeygM2YmhE//epS/A/d0Qg==
X-Received: by 2002:a17:90a:b282:: with SMTP id
 c2mr19253800pjr.135.1568621269652; 
 Mon, 16 Sep 2019 01:07:49 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id r12sm43051515pgb.73.2019.09.16.01.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 01:07:48 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:07:18 +0800
Message-Id: <20190916080718.3299-5-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916080718.3299-1-peterx@redhat.com>
References: <20190916080718.3299-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 4/4] intel_iommu: Remove the caching-mode
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
 peterx@redhat.com, Eric Auger <eric.auger@redhat.com>,
 Bandan Das <bsd@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

That's never a good place to stop QEMU process... Since now we have
both the machine done sanity check and also the hotplug handler, we
can safely remove this to avoid that.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index bed8ffe446..f1de8fdb75 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2936,10 +2936,6 @@ static void vtd_iommu_notify_flag_changed(IOMMUMem=
oryRegion *iommu,
     VTDAddressSpace *vtd_as =3D container_of(iommu, VTDAddressSpace, iom=
mu);
     IntelIOMMUState *s =3D vtd_as->iommu_state;
=20
-    if (!s->caching_mode && new & IOMMU_NOTIFIER_MAP) {
-        vtd_panic_require_caching_mode();
-    }
-
     /* Update per-address-space notifier flags */
     vtd_as->notifier_flags =3D new;
=20
--=20
2.21.0


