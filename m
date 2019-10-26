Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83530CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5726B20867
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5726B20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOS2I-00070Y-9l
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 15:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iORup-0001IB-0r
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iORuo-0000Tx-0A
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iORun-0000Ti-Qf
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:57 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 078C785360
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 19:39:57 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id g1so6178855qtp.19
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 12:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=lQqyJlxFagbKqrc9JA5YsXn4LxS54pcPLkSb2ZI445I=;
 b=T6odJlLbIH1F/5rD/0olqrWbbxWPYqsLtaE9EjppazznL21QIyYi6glL5PA0NjV5u8
 yULmZmI1xcEsJwsVk13fiEOjrdERTsHt9eMnZhyL1nZZJgQue7GzjKAXoy4dp2vVFwfI
 ai/iwAoqgQgI8TEP3gp6S5Mf8R6A7YnpSzF+WHpkb4glT+x0T4U6hvQcAbcHNUnLisft
 5JtEex37wl+wMeNXmJHka/S6mgOfpSdw37j5GadL2VlGbLln3oAmGQIAb0S9GxTuUl9a
 v5SQ3XKRiNbX7cJF/fPgHhozDO595SIXvAu0XrhWB3PMgnpM4fjmh9gmAopUfXfdkeWe
 W0Rw==
X-Gm-Message-State: APjAAAVd8nKoYPCIw4JKN614iAC18cc7W2BvrNMFy/T+8HGw7yLVw+1J
 yDe7AWf117sC1Pb+UMgnpRa5PI2UiHkcH7kX9n2lJDOU9QqsLiqmlkWqj4FYd9xDbXEWY5glvXP
 rOqZtuU1Yu4ADmpg=
X-Received: by 2002:a0c:d4ba:: with SMTP id u55mr9939456qvh.40.1572118796027; 
 Sat, 26 Oct 2019 12:39:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyIvRO2F2Wq2Ezv+DBVVbpp0E5tZQwq5hv8+VpEaBamYalHDBdOgIteIEVjnEWFPEct5zKOyg==
X-Received: by 2002:a0c:d4ba:: with SMTP id u55mr9939439qvh.40.1572118795783; 
 Sat, 26 Oct 2019 12:39:55 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 o1sm3830831qtb.82.2019.10.26.12.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 12:39:55 -0700 (PDT)
Date: Sat, 26 Oct 2019 15:39:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/25] virtio: add property to enable packed virtqueue
Message-ID: <20191026193824.11926-9-mst@redhat.com>
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
Message-Id: <20191025083527.30803-9-eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index d123d5b181..40ddeafadb 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -285,7 +285,9 @@ typedef struct VirtIORNGConf VirtIORNGConf;
     DEFINE_PROP_BIT64("any_layout", _state, _field, \
                       VIRTIO_F_ANY_LAYOUT, true), \
     DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
-                      VIRTIO_F_IOMMU_PLATFORM, false)
+                      VIRTIO_F_IOMMU_PLATFORM, false), \
+    DEFINE_PROP_BIT64("packed", _state, _field, \
+                      VIRTIO_F_RING_PACKED, false)
=20
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
 bool virtio_queue_enabled(VirtIODevice *vdev, int n);
--=20
MST


