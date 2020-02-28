Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508E4C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:16:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B63F246A0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FETWvAY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B63F246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49535 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7iJA-0000Mf-7d
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7iIG-0007SD-CT
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7iIF-0006L3-DK
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:15:16 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56226
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7iIF-0006Kh-9V
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582906514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rX4c44rhuMkGop3AxusgS1sFdsudEKDgbJvrNqbBkWs=;
 b=FETWvAY4H47B5w5Msf+D1CCvGu+rve5k7gNOa6dU9HvunDiIHvTS2+1xkn/4fmzFvyHENR
 fhnzBw3FkqyUdMjf/mknf6DVsWVxYDiFfdBnyg+HOEogNeXSbSJTfPKMlYIfhPawZ/1D0g
 W2G/VK4JHGTJ/1HfiOTYozZrExMGgwE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-GZQ59ETzMJuTWCYxL-Fpkg-1; Fri, 28 Feb 2020 11:15:12 -0500
X-MC-Unique: GZQ59ETzMJuTWCYxL-Fpkg-1
Received: by mail-qk1-f199.google.com with SMTP id m25so3299578qka.4
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:15:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HdePRUJwnDwXnzR9QSorBgIKeVRO36+j82UD9j+Yyjs=;
 b=Hx3RlwxAYo/cvkZHhMRmWpIeQ4v4ZTNVVGuDVobzJt9wqiDtCnwK4iFuDzzI0psy2g
 1Xz+M6cKrJCQE+l2GrSu9zpJP0t7LRC4Hpos/1Eg0p96eDfIGzUVyJTqHWYTOuNGTYA9
 BkszU7Ap51Smy1y6m138qKb4VWsDnN2lWByWbWLSqIeTpeJkDKNDMjStjIMLvnVq0+LU
 dguyVGCdaok36i3JE0CFjCfyoJpvbSzx87gqlbVYyd4sFQqVE5FPiaBIu4JOeYq5M5nl
 h5ZkQTPxrO7rpCD8HFVdT4ePitRqfiAfk3XM5JRt/cv+jCkrLUynNNgeJ+Aa3Ckg/s9b
 ZI2w==
X-Gm-Message-State: APjAAAXGpglMo7kAURieU3rdiTFJc4uoYdzIt/foNXRtOWKHbI8E03Bt
 B04LnxbubiGKEdQJ05IXilgzYj+APsBbKSQR4qy70funHGl2gJFMa27Pr1epYPVwvRQNFy6m/d2
 oVjBDA0AsXOTF98c=
X-Received: by 2002:ac8:777b:: with SMTP id h27mr4846865qtu.251.1582906511260; 
 Fri, 28 Feb 2020 08:15:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqz4AOy2Eqao6ETvU3u7KrC6KAxNOZx9vzSUv7t7XDWxf0clXkZgLVXbMk18sRPTwFyQ3Isgow==
X-Received: by 2002:ac8:777b:: with SMTP id h27mr4846838qtu.251.1582906511029; 
 Fri, 28 Feb 2020 08:15:11 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id b23sm4006290qkc.39.2020.02.28.08.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:15:10 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/5] vfio/pci: Disable INTx fast path if using split irqchip
Date: Fri, 28 Feb 2020 11:14:59 -0500
Message-Id: <20200228161503.382656-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200228161503.382656-1-peterx@redhat.com>
References: <20200228161503.382656-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

It's currently broken.  Let's use the slow path to at least make it
functional.

Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5e75a95129..98e0e0c994 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -128,6 +128,18 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, =
Error **errp)
         return;
     }
=20
+    if (kvm_irqchip_is_split()) {
+        /*
+         * VFIO INTx is currently not working with split kernel
+         * irqchip for level triggered interrupts.  Go the slow path
+         * as long as split is enabled so we can be at least
+         * functional (even with poor performance).
+         *
+         * TODO: Remove this after all things fixed up.
+         */
+        return;
+    }
+
     /* Get to a known interrupt state */
     qemu_set_fd_handler(irqfd.fd, NULL, NULL, vdev);
     vfio_mask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
--=20
2.24.1


