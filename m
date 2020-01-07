Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740FAC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E7A12081E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLH6yqmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E7A12081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iorlp-00088r-AG
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iorjn-0006Kw-TN
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:29:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iorjm-0004YD-OH
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:29:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23581
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iorjm-0004Xt-KU
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578414586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KTcB6zAIaRzY9EwvftE6Rtrz5u5tIha89kZ+phnxUYk=;
 b=aLH6yqmhXA+rsKdVorVxJX6xOiXsinlRcOl0LWnHtOG04QscReJ9cQlduFapBVtDsilhP+
 iP5UL3nrO4RjSuA3YlsOoFvaOMK9eerHHSQYB7rSlt8rzh9xUzjHhxg6bN/BHHt048n7Rm
 yGMniqMzB7SthBJ7ATxlCp7zzV1BWq8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-sCws1RBqOmazZkPmqduoOA-1; Tue, 07 Jan 2020 11:29:45 -0500
Received: by mail-qk1-f198.google.com with SMTP id w64so153844qka.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RMQMUHnYVnq2AcC/aQn0pR+4gejts1KmX+FDMoG77/0=;
 b=pXfSFhkSEYkQesjqG8otoUiMaTQ02W1YwWrY6V0q6RTLiU9TBGVsF9gDfVKNjaa3za
 h9Q6IC2+GLL2Y6/wSd9yD/fmz2Z6BdQDs3sGpcySMHEcQlV9pX1TqUOk+P4I4Gu791fg
 4XdbgK2uPfKdzpqFvmowqHmr8yR2sISvL5iS22qt4nIYm9BXtZNISiu2v6fxJHWM/Msm
 g/Lrc7sHO7ueSk+JMVgY6McdSozerfywO60r2KZuHzQi9yPDJuzbjTp0Gk2hicIYopNj
 q715cXj6+4YPibsNOp/40UPRSrLj8SIxV76vG21HUnu10GliUhOhuoawyX4Gxcvm436m
 8SjQ==
X-Gm-Message-State: APjAAAXpWyZByVGcRcJcwCHYNMFnVrbE/X4epRvqPL/OMHKMawWgg88c
 1wsh2PCFYfAnKXLkRw5oDXtedB/621fZc6laWBJploe11C8V7AydsQymUC9IToxSV2IZ4WIIg9N
 yb8XehAqyoRpkThc=
X-Received: by 2002:ac8:1766:: with SMTP id u35mr80426406qtk.34.1578414584467; 
 Tue, 07 Jan 2020 08:29:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqwpu20Q96viw+KTbkp9/oJeiz9H+3pGEgPGQi3UEek0PauOmbeq7aw4Ldb/gkZSoSAsSb+JUQ==
X-Received: by 2002:ac8:1766:: with SMTP id u35mr80426396qtk.34.1578414584307; 
 Tue, 07 Jan 2020 08:29:44 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id 186sm28282qkm.93.2020.01.07.08.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 08:29:43 -0800 (PST)
Date: Tue, 7 Jan 2020 11:29:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 02/32] virtio: make virtio_delete_queue idempotent
Message-ID: <20200107162850.411448-3-mst@redhat.com>
References: <20200107162850.411448-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107162850.411448-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: sCws1RBqOmazZkPmqduoOA-1
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


