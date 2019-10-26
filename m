Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3D6CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E7D206DD
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E7D206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iORwg-0003vk-1z
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 15:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iORuR-0000mq-6A
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iORuP-0000B5-TB
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38332)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iORuP-0000Av-My
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:33 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DC12D80F6D
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 19:39:32 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id i25so6314894qtm.17
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 12:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VjvBlMoTKwLGMX9SWGSd6Z2eE4BOtsqncgN0gdyFP+8=;
 b=NBlB72Ln+J1NW5NvZBmIFwCgFZBb3KugAFnne5PWCSegU2cGMyUJJnjJA6o5VKwuS3
 lp1NMM8mtFYjMW43SdRyraC9u+ziAR8Hc/mSdYX1aDH/o6Qe62wv6IMwZTsvn5oeWmbl
 RCHFnU7DOQdYPmvMZSil+TlMazK6Zrn1lKX3uxE5bTUNXkHY+ZkJuO+0MioM7JyJFi3X
 l+V7cwj0cKnzL6kPZp7YTPPoCWVNx0ex8LytWhsthEntELY8j2yfoIRFoXaUcr/U1whS
 yltuTm59lhRBU3sVtW/XiPg6MmCpC4sn4fiS4iE5dTzd2f+KAMTKmsc/ptBGQRTby2ru
 E5tw==
X-Gm-Message-State: APjAAAWofX3Zr3CTOuqLcnJiM8eex1TLCs7knynX9AzMCGA6z2Iz6WKJ
 uVmli8AkvWqBMf3CJ0xBXNtZO3ezpZFjq3jsoK6Vsn6+pcKhtmGZyiyYy4ZzrHjvNpk3ekMn1dK
 Z7Vm/1ACvTrZzsxc=
X-Received: by 2002:a05:6214:4d:: with SMTP id
 c13mr9668920qvr.116.1572118771828; 
 Sat, 26 Oct 2019 12:39:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx6wqLiKA5A17StVA84YfBdWo21UuEFuuOM9+EUtn1P0kxSYyQXM+OEeJoeotvdqaOb7gJ6tw==
X-Received: by 2002:a05:6214:4d:: with SMTP id
 c13mr9668911qvr.116.1572118771633; 
 Sat, 26 Oct 2019 12:39:31 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 n65sm3556435qkb.19.2019.10.26.12.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 12:39:30 -0700 (PDT)
Date: Sat, 26 Oct 2019 15:39:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/25] virtio: Free rnd virqueue at unrealize()
Message-ID: <20191026193824.11926-5-mst@redhat.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Amit Shah <amit@kernel.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eugenio P=C3=A9rez <eperezma@redhat.com>

The function virtio_del_queue was not called at unrealize() callback.

This was detected due to add an allocated element on the vq introduce
in future commits (used_elems) and running address sanitizer memory
leak detector.

Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
Message-Id: <20191025083527.30803-5-eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-rng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index e93bed020f..b498a20332 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -238,6 +238,7 @@ static void virtio_rng_device_unrealize(DeviceState *=
dev, Error **errp)
     qemu_del_vm_change_state_handler(vrng->vmstate);
     timer_del(vrng->rate_limit_timer);
     timer_free(vrng->rate_limit_timer);
+    virtio_del_queue(vdev, 0);
     virtio_cleanup(vdev);
 }
=20
--=20
MST


