Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0F4C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB7B72469C
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNV1R+Lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7B72469C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7iLa-0003zk-0h
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7iIc-00085Y-Pe
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:15:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7iIb-0006SN-Du
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:15:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20666
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7iIb-0006S7-AN
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582906536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=67BJoWVgjqRaE3ez8MIcs6ZgskV92ME7JrNNMKV0joI=;
 b=jNV1R+Lc7RW68IQ+Jp3dOoORpO4OAqAx6Zc6nYKIb0Sa+56Bzc2YEaayEwhqsnwADqTHUp
 HSRFwnLtIBV5cMbx6Bt7OT/Kwx9O6e+Nka5zRirXPhtBoOl1azTaGWYo9VcVko35qoUt8n
 t83uDhtntIBzFves9x7e+X/vOkS2cUo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-lM5xUSESM42CwGD_AC5NJQ-1; Fri, 28 Feb 2020 11:15:34 -0500
X-MC-Unique: lM5xUSESM42CwGD_AC5NJQ-1
Received: by mail-qk1-f199.google.com with SMTP id h6so3258259qkj.14
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wQ1AClskklPLaQx5THQ8KFrAAijnqVsY12r4IQjRE6M=;
 b=EZ7OTWmzO5YfxE5BGV76i7aXbFyskZqWLA55yluMqrzm71hyPyOVZWoRzIhLpHyuw1
 fJPOYDzAlsl3LLAfwK7prIQQBG/bPY6keNUXsYWQJtxjYYCLIUcWU9PES2Ali0FZplfy
 ExTWUfT9JlGVqyX4aPX3ObSkLOOe3zzDYUOCJUa9gTXJMB0s3VmOT/XLhFBWCG5X6IR1
 1fFAeGk9jgd/IcK7aK0xTZUEk9sETY4m9VIzfKUW0KF8CP+AZS+HcCuCX0wsvYMXjThz
 kToXRA7ypfsVTR8i+IM0de+XwQd5TfpFd2H0lbnqTWqzvuKm3RJj7ccQ/6wqMaNIXu44
 rFIA==
X-Gm-Message-State: APjAAAWh4daoempmtr/2p45j21NKUGO1bF99Z7WJMtuZqASwiH4hZUqZ
 oVULdHqoa7sOG7CaHJNA8c2KjI6znYo9HPj76Au6PQLiLhqlRXXYPYfBYal8ebHheqnrbQ34UtC
 Ot6Ir9SPWwakOw90=
X-Received: by 2002:ae9:e115:: with SMTP id g21mr5146093qkm.83.1582906533022; 
 Fri, 28 Feb 2020 08:15:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqzhnNx7ZU7ZRIwo9V0nLkFwIxTLpKRePAlVl/GsyK84AfaA/bps4j76vCiMQqZA5qbIMPaKsA==
X-Received: by 2002:ae9:e115:: with SMTP id g21mr5146074qkm.83.1582906532826; 
 Fri, 28 Feb 2020 08:15:32 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id g62sm5257277qkd.25.2020.02.28.08.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:15:32 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] Revert "vfio/pci: Disable INTx fast path if using
 split irqchip"
Date: Fri, 28 Feb 2020 11:15:03 -0500
Message-Id: <20200228161503.382656-6-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200228161503.382656-1-peterx@redhat.com>
References: <20200228161503.382656-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, peterx@redhat.com,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With the resamplefd list introduced, we can savely enable VFIO INTx
fast path again with split irqchip so it can still be faster than the
complete slow path.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/pci.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 09703362df..1c0aa27386 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -124,18 +124,6 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, =
Error **errp)
         return;
     }
=20
-    if (kvm_irqchip_is_split()) {
-        /*
-         * VFIO INTx is currently not working with split kernel
-         * irqchip for level triggered interrupts.  Go the slow path
-         * as long as split is enabled so we can be at least
-         * functional (even with poor performance).
-         *
-         * TODO: Remove this after all things fixed up.
-         */
-        return;
-    }
-
     /* Get to a known interrupt state */
     qemu_set_fd_handler(irq_fd, NULL, NULL, vdev);
     vfio_mask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
--=20
2.24.1


