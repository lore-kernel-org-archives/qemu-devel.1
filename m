Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F602C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 07:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19393207FD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 07:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+lbb6xi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19393207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioja9-0003EP-66
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 02:47:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iojOg-0003uI-9e
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iojOe-0007Gx-TR
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56243
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iojOe-0007GU-Pb
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KTcB6zAIaRzY9EwvftE6Rtrz5u5tIha89kZ+phnxUYk=;
 b=A+lbb6xik6xx3tfdSdOe1A11GGlq1drlLiYCDPpW+CmqVpcBHg38GCkzBz7yH59l6iRm8j
 02Luq0vArAGK2wRh5jufFsF0sQ3rYiXDUVFf4+UKi61ipRq4chvPhb7o5wdtLz6Yk2nJKi
 SRUwGOAn12QXAeslvGjjJXoQK4FWAek=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-i6RM7ghxNbG91c40pTq2WQ-1; Tue, 07 Jan 2020 02:35:23 -0500
Received: by mail-qk1-f198.google.com with SMTP id f124so31118403qkb.22
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RMQMUHnYVnq2AcC/aQn0pR+4gejts1KmX+FDMoG77/0=;
 b=eozGsTopnyAWBrSaP+j/jDAfh1GSs5tsNeeONmH0F+jGYIaJKnK63oArDkRQlvXUTX
 h+K0Lxl52KBRmhNfJAlkh1j5dTg2djnNfRCqlSOoj3vZC4YfmroC64W1b6tTOpzz9EZJ
 U6ebOlFyYF7m+qUMvVkv8OWNRKBl4yW4ZZ8+44RNaVgdcRMemAFZArI4tDJJNEJzG53h
 HRavLke4L46XPJaORcq4mLbfXw5jWqOj1RduWBOpedBm/PTGBCwW+epEwr1QpmkECVuq
 mmqJpXJIlf/zNnfCYRIDDjXE+fPBJ+L42sWn0yWpag/Ms6+AY9r9jF9/lgIvSvCxW/XC
 myDg==
X-Gm-Message-State: APjAAAX6r8yInjdir+cvxShJ9OWKv5Smap+m3NcKSJAiC2TOTycm1U8y
 QxT+MbkOJSnjxy3MPQv1TyCApq7eDIBX3z9HAfnjeQurp6Sa1gALGothC+5PGGICstq9EVg+0NE
 +PR5bATbdoAFGu6w=
X-Received: by 2002:a05:620a:16c6:: with SMTP id
 a6mr87981106qkn.140.1578382522512; 
 Mon, 06 Jan 2020 23:35:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqxhLAdtiJPhE/aI4ePsC2UQ2u1aXK7XFKiPt5F8mBUxv5K/6rfSATmfaqEXSRnZqWhgvblc8g==
X-Received: by 2002:a05:620a:16c6:: with SMTP id
 a6mr87981096qkn.140.1578382522334; 
 Mon, 06 Jan 2020 23:35:22 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id r205sm22044943qke.34.2020.01.06.23.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 23:35:21 -0800 (PST)
Date: Tue, 7 Jan 2020 02:35:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 02/32] virtio: make virtio_delete_queue idempotent
Message-ID: <20200107073451.298261-3-mst@redhat.com>
References: <20200107073451.298261-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107073451.298261-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: i6RM7ghxNbG91c40pTq2WQ-1
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


