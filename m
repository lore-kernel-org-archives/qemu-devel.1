Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926B0C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6125024676
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jN3rrAgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6125024676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvro-0003Gv-Go
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ihvpe-0000Uc-Ro
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:27:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ihvpd-0001R5-NE
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:27:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50816
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ihvpd-0001NP-Ip
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576762028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KTcB6zAIaRzY9EwvftE6Rtrz5u5tIha89kZ+phnxUYk=;
 b=jN3rrAgDdy1gVu4rXtRM4mBDIsZijRB5f6+rYHC9BkQzGs0CMn6XnU7MN2lPdkGZFCPu65
 CV0YPfUBovhdUnx/EXp+PTcpFy+g9gWffmUxGsvrbXuD9IC7q1yb1tI5/vz7ozHIYZlnNI
 +Y8eeY7Z88Sw+bGVrcIy5oaA03UhFLQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-_kvgLlE2Mma9C4kIPoNYzw-1; Thu, 19 Dec 2019 08:27:07 -0500
Received: by mail-qv1-f69.google.com with SMTP id e14so3632588qvr.6
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 05:27:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RMQMUHnYVnq2AcC/aQn0pR+4gejts1KmX+FDMoG77/0=;
 b=naylXn3nwdLQPUAGMiHbw43sucnO67X09f7JbblIfVKCDr2Djsvb9ySaXjVKxJHLTN
 czFna/+3pFGFtnKAFMTlglplZ12MjqqEucIgp1j77XXrtm3AJ5ZtrKVjvxent4bqhO6J
 AkSBqe2HZx806j2HIyY2k08VP66VlFFB5xeUqMLS8V2hilfFxEFG4Ab/9+yoDjBa2y3B
 dxM5ChM8j+CeG99jT+Pjth8t4mNbHhvjYhq0ZpBGnRmLNpbih1dZXQgfgapTkgZgkdG6
 fjms0qzJ00FHsw02MpQdV3nf6R3UYthvf5MJb1fuM1k5yhwlOFvsMEUaDIkYakzu6PlG
 dq9A==
X-Gm-Message-State: APjAAAXzwaTLtR/CuK9DTFFuPHAq8ZZ8jaJzmqQXwsHPGhRO3xnFtQDP
 3R2yhihWHNklIE31paLvW/HQJu6dzwrKILegxo9iYHzGClbQ/tIgEC6w8XR4ZKlopI4J41YH2TW
 7c8RbyJYykJI1vig=
X-Received: by 2002:a05:620a:899:: with SMTP id
 b25mr8050054qka.197.1576762026907; 
 Thu, 19 Dec 2019 05:27:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqxNnCz1H3lCM9IiZzqfI/CJF05c6S6ZN3gu+TwOOtIJkdZLM/fbz/OdgwJmPhoA4DXA0T8Ecw==
X-Received: by 2002:a05:620a:899:: with SMTP id
 b25mr8050038qka.197.1576762026665; 
 Thu, 19 Dec 2019 05:27:06 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id z28sm1899665qtz.69.2019.12.19.05.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 05:27:05 -0800 (PST)
Date: Thu, 19 Dec 2019 08:27:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/24] virtio: make virtio_delete_queue idempotent
Message-ID: <20191219132621.16595-3-mst@redhat.com>
References: <20191219132621.16595-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191219132621.16595-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: _kvgLlE2Mma9C4kIPoNYzw-1
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
 Pan Nengyuan <pannengyuan@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's make sure calling this twice is harmless -
no known instances, but seems safer.

Suggested-by: Pan Nengyuan <pannengyuan@huawei.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 31dd140990..6de3cfdc2c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2337,6 +2337,7 @@ void virtio_delete_queue(VirtQueue *vq)
     vq->handle_output =3D NULL;
     vq->handle_aio_output =3D NULL;
     g_free(vq->used_elems);
+    vq->used_elems =3D NULL;
 }
=20
 void virtio_del_queue(VirtIODevice *vdev, int n)
--=20
MST


