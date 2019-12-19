Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301CBC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBDCF2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W36k18w4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBDCF2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvuw-0006uL-Hu
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:32:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ihvpk-0000eR-ME
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:27:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ihvpj-0001up-Ee
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:27:16 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48564
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ihvpj-0001r1-4m
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576762034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y+1AiFYA4jwJXgwLDoVnwKQ62HQ9au7D6spvhTUBGU8=;
 b=W36k18w4cNTM4/Ix1yhMtoMCcG3f9Jpp5xs2tWH6UE5y6f5yn7V00hlZF7ye6JUTH4XHCU
 53VIOMD7yueEUe81U1IWX4VoRfpKuy9lzRUsZUA+5uNoqk8nWRHTkdBuzZChVblwAoZvAi
 6a6R1Wtq52Ok8n+SP+ZwImYfSwPwtdg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-UZnKyHyhOcmSOJUkA3J-4Q-1; Thu, 19 Dec 2019 08:27:13 -0500
Received: by mail-qk1-f199.google.com with SMTP id a73so3627615qkg.5
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 05:27:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1upHWGgN+kA2iqb9NZ9XxvQ8bHfo9CqfdVL2Jr4HnRY=;
 b=HLwUApcnY7oYFfVWWOQgPcM0WwNp4LWl4jUYcWwqevuEXcw0BJfrPMg6kiNfgHe8AG
 OE0Z9nqBFTSZ518LcBOjodxodR8i9uoa8fp+tgFgLDxTBJQ9yyJK5ygqN+6xZZOW/U3T
 IlsS7ce3pYoCMtvk87k2s95nyTcpb4aoy/J1BrMV1GNMiz8YiIiR5t06CQiBVUqZC//c
 uc/7VdA5ovIeqrYFdM2Rk2XPYevusRAmuw0TxImw2Grlg9vSN9rEAK0Ho6GXd5eSW4Ch
 n+Ggy9mr6HChoCV4i3V6AsCl9Baq8QmtCHuYElZHrumSAPRZ8X+6ZGwizNVV295r/ey8
 6csg==
X-Gm-Message-State: APjAAAVH6Nn1sFCMRlBjKfu301iU7g1FUGjxi/+UwU92ctNyYb8jGH2g
 t2lOsE7MOORDtPX+jMWEfUTKswXrUuzItaBthT3C4VBMMBidJZedVYEddlOj8pg8+HKA0IYoGmj
 uGRi6FfxqLqUlAP0=
X-Received: by 2002:a0c:89c6:: with SMTP id 6mr7621618qvs.72.1576762032116;
 Thu, 19 Dec 2019 05:27:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqyQEb3lI6AU4HnJrLsZKO681JM41kuyGZ6+zJjKvXF459ds4mqo/YduOMfDbOKs6SCVNyaFBQ==
X-Received: by 2002:a0c:89c6:: with SMTP id 6mr7621584qvs.72.1576762031850;
 Thu, 19 Dec 2019 05:27:11 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id 17sm1890693qtz.85.2019.12.19.05.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 05:27:11 -0800 (PST)
Date: Thu, 19 Dec 2019 08:27:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/24] virtio-balloon: fix memory leak while attach
 virtio-balloon device
Message-ID: <20191219132621.16595-4-mst@redhat.com>
References: <20191219132621.16595-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191219132621.16595-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: UZnKyHyhOcmSOJUkA3J-4Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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


