Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F9DC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F1FF2078B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3Jul1Su"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1FF2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIQ3-0000Wi-PN
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jJIKS-00005d-F7
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jJIKR-0005ED-Ef
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27229
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jJIKR-0005Df-AU
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585666642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oFBT6Saz02hT5NP2gKNT3/lC8x4Qhc9zDb0zWjI7XDA=;
 b=O3Jul1SuPMTxlXhT6sphlhEKg54m+yLQPm59uFX17tKH+k7jUprYHZHDFnqSiqBzelpbDI
 uK0QsA9aSz408zCWtMU1IKUjGZyREkHpkFfBL0nobjRR9XjsGt8P4ZF2coP7KjGjxjY8hr
 MHkogkwrr51qoqeABvMrtWx8HaLLoDg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-9xFCsXWSNBOI9nHZa11udA-1; Tue, 31 Mar 2020 10:57:20 -0400
X-MC-Unique: 9xFCsXWSNBOI9nHZa11udA-1
Received: by mail-wr1-f69.google.com with SMTP id c8so11201319wru.20
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0zH6PKQ4PTkqUI6BTEFD7QJzk8gWk/DfG7PE6omZvKA=;
 b=QhXdfvRtWieBKabqKULsaweVC96Xwd9Mq/UZdSl8h4+hShoK2mJ1hG7WrFpUOLYRZn
 aRbHFbVsrB5n3FhukUkTgahzeTFD0LjtMBbGw+ivxpI9NZc+cE5WD91doxNIs/BiGKwF
 Yr/xoEJq6HT8Ztx6KV5NJCKiJ95X614WWvlRg5wblSrJg4uj1pdpDUuaggGXcixCpC8M
 Ayws5Un3WXBv6mxpO0ctg2yeWbjqI6Sl9eguer5QMBrKzpD0ssPpGK/TVeuGu7qmTQpa
 rQtiy7L3uSgiUD0aIN/i4Tb+JdUf+U9QAA5VrgMdBQB3zuf3J5VJCxYfeJuPw+Gjo+qh
 RLoQ==
X-Gm-Message-State: ANhLgQ0YFtP6+RAJPwUtVOmeIVdu/SUq0V/cn8YDnTIIVB+d72Jhfpw3
 TUKFFuem8zgJV9OPSr3OwyCWsVmm1suhW5VdP4Nh2fIMlAHZjVCpXQ6aoBL6XOTC37XCQhqfvlW
 kBJwZ1EzIScdo1O8=
X-Received: by 2002:a1c:2489:: with SMTP id k131mr3985351wmk.86.1585666636571; 
 Tue, 31 Mar 2020 07:57:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtoQzxKeA+Ao4d+OJv0fwjKHt/r6I9lJc6AR6YgqbJJ+6narmsmO6PGQnE4osYk3hCEks9jnQ==
X-Received: by 2002:a1c:2489:: with SMTP id k131mr3985333wmk.86.1585666636361; 
 Tue, 31 Mar 2020 07:57:16 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
 by smtp.gmail.com with ESMTPSA id i21sm4392794wmb.23.2020.03.31.07.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 07:57:15 -0700 (PDT)
Date: Tue, 31 Mar 2020 10:57:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/10] virtio-iommu: avoid memleak in the unrealize
Message-ID: <20200331145631.135630-7-mst@redhat.com>
References: <20200331145631.135630-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200331145631.135630-1-mst@redhat.com>
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
 Pan Nengyuan <pannengyuan@huawei.com>, Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

req_vq/event_vq forgot to free in unrealize. Fix that.
And also do clean 's->as_by_busptr' hash table in unrealize to fix another =
leak.

Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Acked-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20200328005705.29898-3-pannengyuan@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 4cee8083bc..22ba8848c2 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -693,9 +693,12 @@ static void virtio_iommu_device_unrealize(DeviceState =
*dev, Error **errp)
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
     VirtIOIOMMU *s =3D VIRTIO_IOMMU(dev);
=20
+    g_hash_table_destroy(s->as_by_busptr);
     g_tree_destroy(s->domains);
     g_tree_destroy(s->endpoints);
=20
+    virtio_delete_queue(s->req_vq);
+    virtio_delete_queue(s->event_vq);
     virtio_cleanup(vdev);
 }
=20
--=20
MST


