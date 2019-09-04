Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B820CC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 12:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9167D22CED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 12:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9167D22CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5U5O-0003wl-Lh
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 08:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i5TyS-0006AV-RW
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i5TyQ-0002QH-8w
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:01:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61460)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i5TyP-0002Ns-Rv
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:01:18 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3353281DF7
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 12:01:15 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id k13so22469672qtp.15
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 05:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=S/wdHeehpc8LTayuXzoK+l1PfYDr/hOA256Q3HmfrYY=;
 b=CH/ZKBlY9YKdg4Ox2O9dKxou4HYAmuIQDbpqIk5Xu/xIL3FMkJNpGJh/d+n5pIEj6I
 wfIq7xn8Ld5XQWOWp/lo07YjGMVwbAVA961ZMbxcIWl7KX6NCr84dQKn2tVMTt1k7ZMu
 tQ7LTfxK5LstwGgzJ6GyAD6wcZ/bGmTODH7RuKizCSn8yxx6WgFzkVgkLQcb/+gb7OKi
 1x7cJ6hgH0n1X1XdsSq9ZUnU88feDf07mKtvVrGUKCV/20F15WNiYcZznlznWTnrR9S3
 r4F7F36JgebSG4frheEqHrX6SZgjV4kP+5G2KUDphYjkfHH9HfGlZCbgRMV5mWFL9u2a
 fXlg==
X-Gm-Message-State: APjAAAWM6fBLmZ9tEiWI+JCY934p039XU2BHLH6yKAHmgJbfw1gl17jr
 wjFQBchskx5AmG6W315x9TtwSrqdGnKdVjwi/OwLqrvOZQPtBDaPzCpQH8i6A2Dw9Jfsi9u42TU
 u/ims7/QUnjOAFx0=
X-Received: by 2002:a37:a00f:: with SMTP id j15mr36063552qke.335.1567598474005; 
 Wed, 04 Sep 2019 05:01:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz8MBFFJqwJQfDSBDFalW+O9MqYhUMvhhihL1zNDlGRc8tVQX0CM0JKAAsFTzJQmIIKFWKjLQ==
X-Received: by 2002:a37:a00f:: with SMTP id j15mr36063527qke.335.1567598473849; 
 Wed, 04 Sep 2019 05:01:13 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id j80sm5052776qke.94.2019.09.04.05.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 05:01:13 -0700 (PDT)
Date: Wed, 4 Sep 2019 08:01:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190903200422.11693-1-johannes@sipsolutions.net>
References: <20190904120026.3220-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190904120026.3220-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 5/6] libvhost-user: fix SLAVE_SEND_FD handling
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
 Johannes Berg <johannes.berg@intel.com>, Tiwei Bie <tiwei.bie@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190904120108.5NmtJRv3jeC5OlCk1BO1wXVMbJ8Q0TuQaJQI4EILkqY@z>

From: Johannes Berg <johannes.berg@intel.com>

It doesn't look like this could possibly work properly since
VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD is defined to 10, but the
dev->protocol_features has a bitmap. I suppose the peer this
was tested with also supported VHOST_USER_PROTOCOL_F_LOG_SHMFD,
in which case the test would always be false, but nevertheless
the code seems wrong.

Use has_feature() to fix this.

Fixes: d84599f56c82 ("libvhost-user: support host notifier")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20190903200422.11693-1-johannes@sipsolutions.net>
Reviewed-by: Tiwei Bie <tiwei.bie@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 4b36e35a82..cb5f5770e4 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -1097,7 +1097,8 @@ bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
 
     vmsg.fd_num = fd_num;
 
-    if ((dev->protocol_features & VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD) == 0) {
+    if (!has_feature(dev->protocol_features,
+                     VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)) {
         return false;
     }
 
-- 
MST


