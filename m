Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6EDC4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447E32084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ManOfGkk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447E32084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6soC-0006tj-BY
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6sfm-0006sP-UP
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6sfl-0001E3-TG
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:08:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36391
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6sfl-0001Dh-OX
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582708084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FMRhQ/mUb+ufDOWEKs47dVntkMzI4SGR916thXkoGdQ=;
 b=ManOfGkkGqxWvqUPP/n27+IX/arj7IEP34It5ZrDWxcsFf9MSI+Oe9myoSgpwjcLsyfDmO
 3GLhvMWZ4HNulv0zhkmHqa52BfZllQ5ScjSHf0PuUuOJL+WooIikWo+kS4l0r6oMgCYIXN
 EWxThknpluoLJzt0Vk820kVj64lMI+k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-j6eg36cfNguRSqCo1E9lfA-1; Wed, 26 Feb 2020 04:08:02 -0500
X-MC-Unique: j6eg36cfNguRSqCo1E9lfA-1
Received: by mail-wm1-f71.google.com with SMTP id w12so466826wmc.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:08:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9KYoAzz21glog7o+enMMiTE7eLNGzgQi6YqNld1TBIY=;
 b=JufJ0aJiz1e1jzb66AziOWrZonOqQHToYEBD1ZkFz7XFsL3//iJT9fX2x9lFtf5TTo
 HT1UjutTgjA9Crx2Jn5gnqL7rDwqSK1Z5O113HuAmedvYp7UWh/IN4xhsXy2hmgtEUFA
 V8r4DXiukW/FG17jAoql4rV8biPT3oM2ejiC/iM/T4LRG7Ktl46TU9EdX5dSRwdeV0PD
 Rr4SeC8nSSUigJn8Rrwb9IG5u12fEP2MGeJW/PiQxTMQtlYeyqiQZDtRrG+mJfhQrQUj
 w2MUdG8ZiPD1hU7+1M5l05d6aLtTtJ9mNaZkCCsOpts7PVfQK4WQUhqOWlXddZITDaiw
 RpKg==
X-Gm-Message-State: APjAAAX3GVQ1wOhyaS0Dh7dWMvvY/luSP28/dQetI/1sP6qI1VlOuKnV
 JrQqWxTWkGdtmLGZDZyzSc5K3MY7JN7cCKRKPBFsUhX6fIovBrlCSuIiRRwWGT7dQzddHw5p2zg
 RZ+mG7CQcVoAJH/8=
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr4289961wmh.22.1582708080899;
 Wed, 26 Feb 2020 01:08:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqxCMgnntrAoJONFZvZ8fIefwD9iP9gxxAUmPi9PAmaon0bwu82CFU9XOBfj8bo4VsCSCD8f1Q==
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr4289942wmh.22.1582708080712;
 Wed, 26 Feb 2020 01:08:00 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 c74sm2154172wmd.26.2020.02.26.01.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:07:59 -0800 (PST)
Date: Wed, 26 Feb 2020 04:07:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 29/30] vhost-user: only set slave channel for first vq
Message-ID: <20200226090010.708934-30-mst@redhat.com>
References: <20200226090010.708934-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226090010.708934-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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


