Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BB7C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B05BA273C3
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05BA273C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39095 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXrYs-0002VL-V6
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 14:19:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXrOI-00027M-EN
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXrOE-0000PT-UO
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:09:00 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:42139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hXrOA-0008Tu-Td
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:08:55 -0400
Received: by mail-qt1-f173.google.com with SMTP id s15so10504357qtk.9
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 11:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=v+ECkpJzkDVdVI5rLDwJXguPVOQxaO4yQjX4+F++UwY=;
	b=Osz/tuyJb2m8nIHrSbRoTscUmmfWPcSZqXhePtga/bacNcoyYmtgQyty7ToHoQtQvo
	kpWKFgTS/mXNKT3M6gW9+WDu8/z8uVBd3dYY9ml26ZvXtx/h3M+MvduHipsjmzwWEd9W
	1fn9UC1h+5Y+jyfP5jy6To43WvsDHqbeAhRETVQ0vVc2N3FnKM+ZWxOZZoF3faA/b9ZC
	uKOfpAQ16NDXpatCHXE8OmOtvYnh0f6wSb9DLdOAdIHd3H0VzuZno28xhIwaRNOACREA
	7j/ws2m6f2Kssn+SOMZ7Cy4UJ43w8yIzMolDomSDOA8r46A7o+8jBSFZBcOpmh7Y227c
	k2Tg==
X-Gm-Message-State: APjAAAWD1GWKbPF+QtutVpHq6Yvhy5bU2rC6W90kj5diPP4ssdH9CI0T
	fj0xZtmvDEXeNpbpAY41qfxJuXyfMsk=
X-Google-Smtp-Source: APXvYqzhDcagRCdCGQ6Ogb4fRR5yghpxo6Q+2HB9e05/a32FtlTDgMaMqtWjmD5g8VJuDyHLCxyTvw==
X-Received: by 2002:ac8:2c53:: with SMTP id e19mr24889225qta.276.1559585329521;
	Mon, 03 Jun 2019 11:08:49 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	m21sm4977796qtp.92.2019.06.03.11.08.48
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 03 Jun 2019 11:08:48 -0700 (PDT)
Date: Mon, 3 Jun 2019 14:08:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556604614-32081-1-git-send-email-wangjie88@huawei.com>
References: <20190603180807.16140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190603180807.16140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.173
Subject: [Qemu-devel] [PULL v2 07/14] vhost: remove the dead code
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
Message-ID: <20190603180847.yb0OfpNfhhE_JQ_39GLXkBUnxvFEQOGUep7IWzPiggY@z>

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


