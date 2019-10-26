Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69C0CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:45:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9DA206DD
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9DA206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iORze-0002FZ-SV
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 15:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iORuj-0001Df-Hj
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iORui-0000Qq-Ik
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44202)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iORui-0000Qf-Ca
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:52 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 96A743B717
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 19:39:51 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id c32so6333239qtb.14
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 12:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=wi/B0uJWKCzFdvKSB58+PR0TfpdPviZvmd/QuFLab6g=;
 b=LqRrA/OFoh/BDioINKWqV0iw/mnXvqLu6RR9CxvAd3fwctaNb/CVkHPFDviqQlYqtO
 1x+lJvlS2FEQm2Btc1eIssyczGDSbQaVLm2Vt9kVAqBOFzgadXi+OQmv79WzyXul1KZN
 ZDdP2BnHNgEJKG4xzd9stZszV/E97fQePzJTrIrBifVMO/PurnWEGD5+AkI1ti1KaoKF
 EiO4H+dggqexO3V9ce71xHaU/vYZDKId9SOaIdHueYwaksqNuj1VIc1hJMZa+DODU1Ru
 kblE84A96x5mhCRKVZRNJ4VUs/OXhrq4QaahB7RzW7Lge0YLXMgZyFNyAdHAIo46a6YT
 KxDQ==
X-Gm-Message-State: APjAAAVnk2jrRJ8comDOHzhd9w2XCZr6ePUA21UNkm/A6g2im0zGq+S5
 HmV6hAKe2MR/Hp0E+LDV4PNwfc24Q9iGbMNaS7kL5mk3hHfkycaYOiwcTK3cMgFgP6yhd2WzyvO
 WPosGzAEwu0P9wdQ=
X-Received: by 2002:a37:6591:: with SMTP id z139mr8925864qkb.133.1572118790382; 
 Sat, 26 Oct 2019 12:39:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwGJ4w7Uc6Y/xQEb842WnJdi8NhhUjOw8eQpaPEmtn/RLCR9PbOv8jHOCLVYnLKrFh3nHNA0Q==
X-Received: by 2002:a37:6591:: with SMTP id z139mr8925848qkb.133.1572118790155; 
 Sat, 26 Oct 2019 12:39:50 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 h27sm2674855qtk.37.2019.10.26.12.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 12:39:49 -0700 (PDT)
Date: Sat, 26 Oct 2019 15:39:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/25] vhost_net: enable packed ring support
Message-ID: <20191026193824.11926-8-mst@redhat.com>
References: <20191026193824.11926-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191026193824.11926-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Wang <jasowang@redhat.com>

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
Reviewed-by: Jens Freimann <jfreimann@redhat.com>
Message-Id: <20191025083527.30803-8-eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/vhost_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index e975700f95..6b82803fa7 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -49,6 +49,7 @@ static const int kernel_feature_bits[] =3D {
     VIRTIO_F_VERSION_1,
     VIRTIO_NET_F_MTU,
     VIRTIO_F_IOMMU_PLATFORM,
+    VIRTIO_F_RING_PACKED,
     VHOST_INVALID_FEATURE_BIT
 };
=20
@@ -74,6 +75,7 @@ static const int user_feature_bits[] =3D {
     VIRTIO_NET_F_MRG_RXBUF,
     VIRTIO_NET_F_MTU,
     VIRTIO_F_IOMMU_PLATFORM,
+    VIRTIO_F_RING_PACKED,
=20
     /* This bit implies RARP isn't sent by QEMU out of band */
     VIRTIO_NET_F_GUEST_ANNOUNCE,
--=20
MST


