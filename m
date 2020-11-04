Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F12CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1195B20BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jbn+muaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1195B20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaBEA-0004qW-QQ
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaBDQ-0004KN-Bw
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 00:20:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaBDM-0005WF-Et
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 00:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604467206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L0BE6BIYyp008EuFnEKAYjzMhrYRUbO0ZaRk54gDh4k=;
 b=Jbn+muaTxzbnttX/jjKyVBjGO1YKf9wDRt4ai2WDUojCOTyQxNy9XtHODPoUpAyis/ODit
 14l7BRn0EDgj+qhcSHyMFyrnJObDgcae9bYfkvSaY/AbT4ImhxHYukY2L0rgywaYDpXPfB
 jOktCxBkvJ7Ah7hkcQneDjfAkReyED8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-Zb6wPDRtNnyw6gHOrMBcBQ-1; Tue, 03 Nov 2020 23:52:25 -0500
X-MC-Unique: Zb6wPDRtNnyw6gHOrMBcBQ-1
Received: by mail-wm1-f72.google.com with SMTP id u207so736206wmu.4
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:52:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=L0BE6BIYyp008EuFnEKAYjzMhrYRUbO0ZaRk54gDh4k=;
 b=aDgWmiOVlTQsLvQAW9LwdzOw/fesxJ7Lh1UE+XV0A3udhPWqRYkjMsBErPJu5P/Hg0
 p6g9B0K6QOBd8N5uIMZUdRyR/dvsyX0fY/rWzmDXJFJ2ZU2Pt886eHYigwe+Bz5mNqIU
 XX67pp3ILDvOOb9Zcwm7HXwc9NB9ImQoNCTV6gT6eH7AGvDLWCcAMtJTJIhlrsqnRF+v
 3/VDYxe8LUNTgAwwLJq569qAocc7UEnSE6v6n35kcR56htY9kGO0iug0RdI/z5Nrlreq
 ZeA41NWcHOf/n5S04AbmfxOdx17c2JpwpFsf2sjPt87/qgnaamzd59GO9P+RBZisKg2A
 Zu/g==
X-Gm-Message-State: AOAM530MNo0/uQWhMXhTfJBJXJqtI1qZ3QV9Qht51/sWHK/r4BxXgRmE
 n/bU7qPIfgt5VuDsC8RSzv7P5YE7S9AD0aOfv0MKV0wO5bXGXNO8YF+JbnPy7WbDLamIaDWxzmi
 KIMibixJXhB0SudU=
X-Received: by 2002:a1c:9d02:: with SMTP id g2mr2528558wme.110.1604465543959; 
 Tue, 03 Nov 2020 20:52:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhmU74D82hWVAzg9XgrQQten6rOcQY6AV4flH6GhEmS7ZeopL7z2nIx7/5SCkjQxL2bYFaww==
X-Received: by 2002:a1c:9d02:: with SMTP id g2mr2528551wme.110.1604465543839; 
 Tue, 03 Nov 2020 20:52:23 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id k84sm788877wmf.42.2020.11.03.20.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:52:23 -0800 (PST)
Date: Tue, 3 Nov 2020 23:52:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 37/38] vhost-user-blk-test: drop unused return value
Message-ID: <20201104044937.226370-38-mst@redhat.com>
References: <20201104044937.226370-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104044937.226370-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

The sock_path return value was unused and bogus (it doesn't make sense
when there are multiple drives because only the last path is arbitrarily
returned).

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20201027173528.213464-12-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/vhost-user-blk-test.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
index 15daf8ccbc..0d056cc189 100644
--- a/tests/qtest/vhost-user-blk-test.c
+++ b/tests/qtest/vhost-user-blk-test.c
@@ -705,8 +705,8 @@ static void quit_storage_daemon(void *qmp_test_state)
     g_free(qmp_test_state);
 }
 
-static char *start_vhost_user_blk(GString *cmd_line, int vus_instances,
-                                  int num_queues)
+static void start_vhost_user_blk(GString *cmd_line, int vus_instances,
+                                 int num_queues)
 {
     const char *vhost_user_blk_bin = qtest_qemu_storage_daemon_binary();
     int fd, qmp_fd, i;
@@ -774,7 +774,6 @@ static char *start_vhost_user_blk(GString *cmd_line, int vus_instances,
     g_test_queue_destroy(quit_storage_daemon, qmp_test_state);
 
     qobject_unref(qtest_qmp(qmp_test_state, "{'execute': 'qmp_capabilities'}"));
-    return sock_path;
 }
 
 static void *vhost_user_blk_test_setup(GString *cmd_line, void *arg)
-- 
MST


