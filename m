Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB11C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E8020848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E8020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53878 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFUz-00009t-Rp
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:28:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFLg-0000BQ-KW
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFLc-0001d2-Rw
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:18:59 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:44358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFLc-0001cV-PL
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:18:56 -0400
Received: by mail-qt1-f178.google.com with SMTP id f24so3511079qtk.11
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=CpsnX50FvethOzWJ3djTyRAM8ldWob1tvvlTZoMS0wc=;
	b=jlHAgvEA9+cumeozCmu/YoJHJ/XlZZPd1pre7uQi1V9kgsNZvpABZKlLG8TPAr9pju
	+818mXNwfN1IB8wbqN+ne0cV7BKw5mOHNNJ1dTY3cr4Pd4y+D4YonUHPn1idHYcgZNrU
	DtaN24xPqX8gLhuhRwKYoThrMTHbjYjZe0vmlUKqC72NrY82eo9RatieljeiZJ00oqf2
	zwqLYtlV9BSkxSYi0njZIHXrL1m+J2EuWfhCxYv5Uhfsr1obMBICAlaRG3YiW5uOWvHj
	EBB4iQRxdDS1EwxjsADhgVb2MJBmKavltwyVhC/kWxBiTy7pEq9VOSkjjVQ92YORvuAR
	Y7kw==
X-Gm-Message-State: APjAAAX/63zheGixonaauxvGwnBvA+IxkfLJPpXBJWn2kUP8KexLGd7i
	2iOYpB1M7kaKSF4fDFiCwyzYSM5Mzr4=
X-Google-Smtp-Source: APXvYqzkmamseeeF2ZNRoXyafyrxcl1n3VGjzSKCzf4n1ncG7v5+MoQ/gnwzdKsKNIsLT9h0PHOW9Q==
X-Received: by 2002:a0c:9e55:: with SMTP id z21mr39731123qve.45.1558009136021; 
	Thu, 16 May 2019 05:18:56 -0700 (PDT)
Received: from redhat.com ([185.54.206.10]) by smtp.gmail.com with ESMTPSA id
	f127sm2871871qkb.53.2019.05.16.05.18.54
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:18:55 -0700 (PDT)
Date: Thu, 16 May 2019 08:18:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190320112646.3712-8-xieyongji@baidu.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.178
Subject: [Qemu-devel] [PULL 10/37] contrib/vhost-user-blk: enable inflight
 I/O tracking
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Xie Yongji <xieyongji@baidu.com>,
	Zhang Yu <zhangyu31@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

This patch enables inflight I/O tracking for
vhost-user-blk backend so that we could restart it safely.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Message-Id: <20190320112646.3712-8-xieyongji@baidu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index 43583f2659..86a3987744 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -398,7 +398,8 @@ vub_get_features(VuDev *dev)
 static uint64_t
 vub_get_protocol_features(VuDev *dev)
 {
-    return 1ull << VHOST_USER_PROTOCOL_F_CONFIG;
+    return 1ull << VHOST_USER_PROTOCOL_F_CONFIG |
+           1ull << VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD;
 }
 
 static int
-- 
MST


