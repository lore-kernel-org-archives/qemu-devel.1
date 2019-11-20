Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4888BC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1622D22429
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BY1AejRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1622D22429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXMoF-0006Cj-6P
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iXMlx-0003jV-OB
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:59:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iXMlw-0004id-KS
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:59:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27742
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iXMlw-0004i1-GO
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574243979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oarDnP90Afnb43mO4u2yKQgzH/TrOzm1gjqPWa9S4BA=;
 b=BY1AejRafo0ae4SUow8+XRgkPBlJcLSzYx/YyQrHHL7qlWCF3kcM5YwouV7miAx+CxFYjW
 Ne7Ml8CofXkj4v11dsGleTj7+LK7HTZuk05H2yCW+rG/4KuVwrrdcSdJCvXz4i5rV6kN1L
 DKOW2Okda0/kpIDTvYRxnuD9PplykNA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-65zqoU0HPuKmRQV__Ywj3w-1; Wed, 20 Nov 2019 04:59:38 -0500
Received: by mail-qt1-f198.google.com with SMTP id x50so16740478qth.4
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 01:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=3AVbLd6xjAB+NFS8fzE/fQA+6B5PATtOwgAshllb0wE=;
 b=OwIdoa3hltuEomEHvQjoXSftQSfqB+dp00McKovTBPqQpZnIVOXWWNANwAmwz1q+gz
 HXzMsJIcX5fjf0EUjNMqDfLT2rXBvrjPHRtxuzNuCuhkGNnbq/mpD7Ea6akeudUr0+/o
 Nngh/g5i5MLfVP49WRGV/iMQh0t9AQrofomN7EqolMTFH5SpWukTsRtMf8o0AiSOpVMp
 bjxloxxcim0X45JVBugB//CF5OQPkHXk1MsRXi5d18ChQhudg5aELry4qbp/JE+VhZW6
 5dXuM3+c5dExYclEcfMgaZLn6K8RPeXyiqhxH4th5jdnvf0W9uVOB8HpBUIL3YGIvH1k
 r3Uw==
X-Gm-Message-State: APjAAAWPN+SG5tOFfK2bPdhXihfQVCmXwRbZ7oU+TIyrePfKwz8ic87x
 oeINyLb3OIB5RUC4dQlewcSE5WsBEicWyjTd4nEEXxa4kvzVaingzdk8oKVUo7Sah4zMEXBKRzJ
 W03g/wJBUrhwdxCs=
X-Received: by 2002:ac8:6bd9:: with SMTP id b25mr1739559qtt.295.1574243977495; 
 Wed, 20 Nov 2019 01:59:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwaiVgul7wa2lB1BaRr2O9QMlmBf+3jyAeSOOLLuchvCrd62ve+1hvxDkOBmMDqr29s2f+dLA==
X-Received: by 2002:ac8:6bd9:: with SMTP id b25mr1739553qtt.295.1574243977353; 
 Wed, 20 Nov 2019 01:59:37 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id p59sm13945623qtd.2.2019.11.20.01.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 01:59:36 -0800 (PST)
Date: Wed, 20 Nov 2019 04:59:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] libvhost-user: Zero memory allocated for
 VuVirtqInflightDesc
Message-ID: <20191120095904.11384-2-mst@redhat.com>
References: <20191120095904.11384-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191120095904.11384-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: 65zqoU0HPuKmRQV__Ywj3w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Xie Yongji <xieyongji@baidu.com>,
 Zhang Yu <zhangyu31@baidu.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

Use a zero-initialized VuVirtqInflightDesc struct to avoid
that scan-build reports that vq->resubmit_list[0].counter may
be garbage value in vu_check_queue_inflights().

Fixes: 5f9ff1eff ("libvhost-user: Support tracking inflight I/O in
shared memory")
Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Message-Id: <20191119075759.4334-1-xieyongji@baidu.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/=
libvhost-user.c
index 68c27136ae..ec27b78ff1 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -992,7 +992,7 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
     vq->shadow_avail_idx =3D vq->last_avail_idx =3D vq->inuse + vq->used_i=
dx;
=20
     if (vq->inuse) {
-        vq->resubmit_list =3D malloc(sizeof(VuVirtqInflightDesc) * vq->inu=
se);
+        vq->resubmit_list =3D calloc(vq->inuse, sizeof(VuVirtqInflightDesc=
));
         if (!vq->resubmit_list) {
             return -1;
         }
--=20
MST


