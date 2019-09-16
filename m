Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C1DC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28747206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28747206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9m0m-0002eG-RN
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 04:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i9luj-0006B7-6n
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i9lui-0006Fn-2Y
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:59:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40060)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i9luh-0006FK-TZ
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:59:12 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 333F788306
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:59:11 +0000 (UTC)
Received: by mail-pg1-f197.google.com with SMTP id r35so9877432pgb.2
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 00:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Sd75Sl64YfC71rpaDKMmxyQH/rUSVoFuK0rLbD5VCyU=;
 b=eG1AJErg9a+J1T6zZkF+aqatc/DHc0rFRHOJr2oNZcElT5AE3GvCz8GZnBDJVHDi4K
 gGr3SFkflbq1bcOSR0PxtulI2q1hk+lwUFQX4VjDlOH5whQlgXmFAvjc8V8WUe7wWTLG
 9SZBQePEaxPOFOOHZajz2w3oejcfHdG1ynW/W0ToMaNR1fz0s4MEegFTXRyCPe4SXIXI
 1ewm+4Lcxe+jxesHkx6Ne6UEwEQgf2GzH5Vg1zD+POFc9J0HNc3CPMy/apkyYYzImBb/
 2+05rVp0/n9s01YP44p/yJoWPCkxHSaLi6PhjQHaqWDSQMrp7RB2DwSZJNHMxyBGmupf
 QzRQ==
X-Gm-Message-State: APjAAAUW6qSYFl416gu5HYtxfTIkHiWxgFj7YWgdxaK1OAhguzN5lJTX
 B8V+KLWG53LOOx01y4U4C9GBDtR9LYEdJMi7uJYZZfSpf68lIrZ0y0wz4gozfuEfegRKQH8zFEy
 plHjGeW5cGO/i1mo=
X-Received: by 2002:a17:902:54f:: with SMTP id
 73mr24803368plf.329.1568620750383; 
 Mon, 16 Sep 2019 00:59:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwrJ9IHL9ttpV32BC8XJFkXF7f+RIXyc69Umca68/zrFzxV2RxYLdPDT+DoSjr3EXx199I3+w==
X-Received: by 2002:a17:902:54f:: with SMTP id
 73mr24803355plf.329.1568620750214; 
 Mon, 16 Sep 2019 00:59:10 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p20sm50321443pgi.81.2019.09.16.00.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 00:59:09 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:58:39 +0800
Message-Id: <20190916075839.390-5-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916075839.390-1-peterx@redhat.com>
References: <20190916075839.390-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 4/4] intel_iommu: Remove the caching-mode
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
index 17fc309b3d..070816c355 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2935,10 +2935,6 @@ static void vtd_iommu_notify_flag_changed(IOMMUMem=
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


