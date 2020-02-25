Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B013DC35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1D620658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itxEuUF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1D620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6c0j-0002zV-Ih
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:20:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6bvO-0002ae-8i
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:15:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6bvN-0001zN-9d
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:15:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29926
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6bvN-0001ys-58
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FMRhQ/mUb+ufDOWEKs47dVntkMzI4SGR916thXkoGdQ=;
 b=itxEuUF8vWYXURK45bSgjKaz0KRRL0GqB1WRnoLUWysDGZtTYMplSYkiXZ+A/q6wXQUR5V
 WRQFHvWHpmbkJBeG+/Y+WNyj9aYm4l0FGhrtr6lHpjvxf1vUb43ggN1VgjQ1AyWazZks4V
 vUnfaWRH7412PGkaPCVBNGrCvHTlYuc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-P1TuutaOPLOYV3RwtJKoAA-1; Tue, 25 Feb 2020 10:15:00 -0500
X-MC-Unique: P1TuutaOPLOYV3RwtJKoAA-1
Received: by mail-qv1-f69.google.com with SMTP id v3so13249523qvm.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:14:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9KYoAzz21glog7o+enMMiTE7eLNGzgQi6YqNld1TBIY=;
 b=XXFq6aKKqEVwPmAE/+YFpGrhlbV7nmDPbosSzsmjLheuloMLwP/E+AmkgqjCHYEJJ0
 NTQ1ob53IAMSBz0vsQkM80vnQjIBBy7k7ay7kJUVdI6Lv7L9izkuCnjwTrmD0s+0rIOJ
 FbA97tYwALcnza3uKSomeIPaMAzi7DugGrrAXMvH2M7LV3pCGF5/2xP4+H3UKSr6cSk4
 yHb/zjLCOVDaCc81p5r+DFm85ubJRG3Ci9VTeumsDBifkM0hacEmy6xYiH2jx0mDQFCr
 39nyj/18mUSuhoQm3aN3uYRA18DSiuLHyavxWTjPZDifcW86MQU52q7BOM+bLKis2NUW
 wa8A==
X-Gm-Message-State: APjAAAXL8hd2YizXoCQ9p9kCpxyj83tL/LO5SZxy8iH0BSLckVseIK9G
 vzSzYLROqFt0QAfGz2iP4CD2t4f5DloPOffVp7gP26S/HlMuK6zXbKK+WeoQvplmc1H0bB8VXyC
 GKsn1EJ+xK6NM3IA=
X-Received: by 2002:ae9:e207:: with SMTP id c7mr54105002qkc.128.1582643696845; 
 Tue, 25 Feb 2020 07:14:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqw6IYjuv6XMdVw6LPfvZxwGdWx2Niu1HKyIUy0enhfAvbYDpcq2+7ls9EkcF1nzaIRCgeDioA==
X-Received: by 2002:ae9:e207:: with SMTP id c7mr54104926qkc.128.1582643696016; 
 Tue, 25 Feb 2020 07:14:56 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 u5sm3133820qkf.32.2020.02.25.07.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:14:55 -0800 (PST)
Date: Tue, 25 Feb 2020 10:14:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/32] vhost-user: only set slave channel for first vq
Message-ID: <20200225151210.647797-30-mst@redhat.com>
References: <20200225151210.647797-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200225151210.647797-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Adrian Moreno <amorenoz@redhat.com>, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Adrian Moreno <amorenoz@redhat.com>

When multiqueue is enabled, a vhost_dev is created for each queue
pair. However, only one slave channel is needed.

Fixes: 4bbeeba023f2 (vhost-user: add slave-req-fd support)
Cc: marcandre.lureau@redhat.com
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
Message-Id: <20200121214553.28459-1-amorenoz@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 2e81f5514f..35baf4f347 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1458,9 +1458,11 @@ static int vhost_user_backend_init(struct vhost_dev =
*dev, void *opaque)
                    "VHOST_USER_PROTOCOL_F_LOG_SHMFD feature.");
     }
=20
-    err =3D vhost_setup_slave_channel(dev);
-    if (err < 0) {
-        return err;
+    if (dev->vq_index =3D=3D 0) {
+        err =3D vhost_setup_slave_channel(dev);
+        if (err < 0) {
+            return err;
+        }
     }
=20
     u->postcopy_notifier.notify =3D vhost_user_postcopy_notifier;
--=20
MST


