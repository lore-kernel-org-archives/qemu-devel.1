Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A803C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 153E220656
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQk1IKEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153E220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iokzR-0005IK-Fa
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 04:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iojOl-00048y-Tg
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iojOk-0007L0-HS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46325
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iojOk-0007Kk-Cl
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y+1AiFYA4jwJXgwLDoVnwKQ62HQ9au7D6spvhTUBGU8=;
 b=TQk1IKEjfRKTdYumTDvk+ymVW5pqvbycq9UOkAq9ktkSVtu8rAz1BR6J1pkR0EzMcuJC6K
 3WQ5pk3mnONKH8dqzBNxNLxzHMqC3hrcNpNiILQIfCgb2SaMyH9EC1J0GZUTdhvzB0Ys2d
 cEUhtQySJrAId/1fc1eat1oaBpbSJDs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-Xs1pmwo_P82CIKaNgD1wBw-1; Tue, 07 Jan 2020 02:35:28 -0500
Received: by mail-qv1-f72.google.com with SMTP id e10so5026143qvq.18
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:35:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1upHWGgN+kA2iqb9NZ9XxvQ8bHfo9CqfdVL2Jr4HnRY=;
 b=DQybrRaMXVNnFincXpXoKjgN0fDKJra08XNUwz+UqYoQ5MI+tQz22CZrIcnM8nDt+g
 Rtpk9UkLM4vrSbgq5MZF4ofBRgx6b5I0SDgpEoBZmv72S2oV3g4NwIekACSGePfiVmcB
 0Hb9/oARagWB1II2NBJeYf9RXhA9pst4ABIPMbu+SP+kXRyzebZX/WPUwjHSnkh30pna
 GwItg/FwuhBbHmOx+86fx+fA6QiScy/u0wqJJszOUSOogD37PEChGohU93viXydCD3y9
 Hts/Ejfjq0y1frnlphYXM9nbmUgnnQ8RJWYaxFjdNgTVfivepDNY/DpvtYzSq6xt9PKa
 LYMg==
X-Gm-Message-State: APjAAAVeo54ViXS5aLJtHGgN9tcVUB2Ek7CFbZfvaaehk5SgjzpjuaSr
 JpO+d29ES7L6pgVgwD8dM6yv8R+ONaIjwAvDYuEjDmPIUcTKHnbo7cQ/Tg9fxzzHP+H6yvUYFjf
 89ShSBiGW11q+3cM=
X-Received: by 2002:a0c:c18f:: with SMTP id n15mr70463499qvh.35.1578382527541; 
 Mon, 06 Jan 2020 23:35:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqwSOqp9wdGe6au8cm40/OOAUPV0iuTj/AEBQBzXV3xgoPZJm4OQ4+chno8vYFA6+p5ya98VMg==
X-Received: by 2002:a0c:c18f:: with SMTP id n15mr70463489qvh.35.1578382527347; 
 Mon, 06 Jan 2020 23:35:27 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id l6sm24706349qti.10.2020.01.06.23.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 23:35:26 -0800 (PST)
Date: Tue, 7 Jan 2020 02:35:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 03/32] virtio-balloon: fix memory leak while attach
 virtio-balloon device
Message-ID: <20200107073451.298261-4-mst@redhat.com>
References: <20200107073451.298261-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107073451.298261-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: Xs1pmwo_P82CIKaNgD1wBw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

ivq/dvq/svq/free_page_vq is forgot to cleanup in
virtio_balloon_device_unrealize, the memory leak stack is as follow:

Direct leak of 14336 byte(s) in 2 object(s) allocated from:
    #0 0x7f99fd9d8560 in calloc (/usr/lib64/libasan.so.3+0xc7560)
    #1 0x7f99fcb20015 in g_malloc0 (/usr/lib64/libglib-2.0.so.0+0x50015)
    #2 0x557d90638437 in virtio_add_queue hw/virtio/virtio.c:2327
    #3 0x557d9064401d in virtio_balloon_device_realize hw/virtio/virtio-bal=
loon.c:793
    #4 0x557d906356f7 in virtio_device_realize hw/virtio/virtio.c:3504
    #5 0x557d9073f081 in device_set_realized hw/core/qdev.c:876
    #6 0x557d908b1f4d in property_set_bool qom/object.c:2080
    #7 0x557d908b655e in object_property_set_qobject qom/qom-qobject.c:26

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <1575444716-17632-2-git-send-email-pannengyuan@huawei.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-balloon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 40b04f5180..57f3b9f22d 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -831,6 +831,13 @@ static void virtio_balloon_device_unrealize(DeviceStat=
e *dev, Error **errp)
     }
     balloon_stats_destroy_timer(s);
     qemu_remove_balloon_handler(s);
+
+    virtio_delete_queue(s->ivq);
+    virtio_delete_queue(s->dvq);
+    virtio_delete_queue(s->svq);
+    if (s->free_page_vq) {
+        virtio_delete_queue(s->free_page_vq);
+    }
     virtio_cleanup(vdev);
 }
=20
--=20
MST


