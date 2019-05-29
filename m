Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63313C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9AF23DE8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9AF23DE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57763 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW1c0-0001bQ-AE
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 12:39:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hW1a2-00007I-Ls
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hW1a1-0002qa-KZ
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:37:34 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:42727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hW1a1-0002qJ-Gq
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:37:33 -0400
Received: by mail-qk1-f181.google.com with SMTP id b18so1872983qkc.9
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 09:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=v+ECkpJzkDVdVI5rLDwJXguPVOQxaO4yQjX4+F++UwY=;
	b=Cl4w+eoRrGxT0FWaWxlksY5OfSdylcmJR/HldB748t0rrSdzWW/sVA/KuaKjg9oD9K
	FeGoDt2A6MAOhvYAfVpK8KMlHt/yYXkyykbGas78a5q2JQCvlmOFQwno2moYbLUSE1Y3
	uWQv9dRzNZNiYNakGpHwWYGSUn9Hbw8N0IKAtxvxnNxT0h/744pJ3byoCq57nhqjrBea
	SCtV/0ler/F15WXaw3yxnXOPaFzZTazQdUhA3SGZFEfla1jTBGGB6jmf0UM+S6NGtX4y
	kR96dD/iqrYbYmF2jzTSl1jNFe1cA7H8M6gEvByhBJtTtscefVU16AQB+h8xbPd5Y7Bf
	88Jg==
X-Gm-Message-State: APjAAAWRDPJWx82FZsUwFHeIToIFLwIPK7hPqoeQC0hxuUK64Ry7UxWz
	53YPNs9ZgkUyykGdovG25ZE7FwYSn00=
X-Google-Smtp-Source: APXvYqzr7GKQPzCNRTyXhAYTQxpJtAV2CCQhPH2dG1eJXUclLYJZ6LLSQc+OAM/efHVkbc0w+EQb7Q==
X-Received: by 2002:a37:8183:: with SMTP id
	c125mr46236364qkd.306.1559147852711; 
	Wed, 29 May 2019 09:37:32 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103])
	by smtp.gmail.com with ESMTPSA id h6sm2774374qti.21.2019.05.29.09.37.31
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 29 May 2019 09:37:31 -0700 (PDT)
Date: Wed, 29 May 2019 12:37:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556604614-32081-1-git-send-email-wangjie88@huawei.com>
References: <20190529163604.18560-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190529163604.18560-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.181
Subject: [Qemu-devel] [PULL 08/10] vhost: remove the dead code
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, Jie Wang <wangjie88@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190529163731.gg8PzFaIoQ5xjxqjIC4_Sd3NPQK9KRvE4NLP7ouRKy0@z>

From: Jie Wang <wangjie88@huawei.com>

remove the dead code

Signed-off-by: Jie Wang <wangjie88@huawei.com>
Message-Id: <1556604614-32081-1-git-send-email-wangjie88@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/vhost.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 7f61018f2a..2303a8c206 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1650,7 +1650,6 @@ fail_vq:
                              hdev->vqs + i,
                              hdev->vq_index + i);
     }
-    i = hdev->nvqs;
 
 fail_mem:
 fail_features:
-- 
MST


