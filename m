Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65A4C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:15:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88EB92171F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EB92171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43391 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrVS-0002WY-Ke
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:15:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQg-00074I-LP
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQf-00080N-LL
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:50 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:41326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrQf-0007zu-Gs
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:49 -0400
Received: by mail-qk1-f178.google.com with SMTP id m18so91617qki.8
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=CpsnX50FvethOzWJ3djTyRAM8ldWob1tvvlTZoMS0wc=;
	b=FAZvXbV+fMwH5eFffkJSyj/jUkOTbDXRMuGR6dOgayeauED3VRRrluLoAsopItRkLO
	3AILasMWrvwJk5volzZBWx0MIKbkp8/GG6Xl8Lgds7553CAeD5CVhKUtdUSTPrWiETL5
	SCBF6r1SPNk5X44ilBfuAw6H4h3WzaMGo924on/bfjlsWYXtZC4bWk/1bziRAIVjreGC
	zofIBlIZB1x/rNjEOzhtsTxdHtPC9AYhsVX1yCnOJNI1vy2O6ax75ddF+NcTckISI9GC
	Y62ZdSiAHNeR3ERZuB0PttQ++0eRsl/xB5SzJ3MiVc1Td8FEv8BbeQvvgy4GWyAdBgJh
	JvbA==
X-Gm-Message-State: APjAAAVdxjRhq5YTP6wNaxf8AL05HqczNHzug/8yhQCENhhQI5QvQJK4
	xUi+RTCKxCiivIET4Bpli2WlILYQOSE=
X-Google-Smtp-Source: APXvYqwcJG7drmG1kULlno37AjXYV51bcFabQtN5QFzcVl1n9YgBWIEJ9HtV5xegOJmV6YBlrsDRVg==
X-Received: by 2002:a37:4c1:: with SMTP id 184mr21630128qke.322.1558393848690; 
	Mon, 20 May 2019 16:10:48 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71])
	by smtp.gmail.com with ESMTPSA id v13sm8822809qkj.3.2019.05.20.16.10.47
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:10:48 -0700 (PDT)
Date: Mon, 20 May 2019 19:10:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190320112646.3712-8-xieyongji@baidu.com>
References: <20190520231008.20140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.178
Subject: [Qemu-devel] [PULL v2 10/36] contrib/vhost-user-blk: enable
 inflight I/O tracking
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
Message-ID: <20190520231046.mdfiJI4HcxpYHETHWX9sUFlUoBI8OreaZeGZW-De5Cg@z>

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


