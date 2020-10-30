Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E50C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15BA920728
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvBuidan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BA920728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYW4E-0000Co-VP
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYW2S-0006ra-8H
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:10:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYW2Q-0006B2-KK
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604070596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NslL+8MYXzNC6tAMGQfCXeMzktZ0gagTiI4JSbA18W8=;
 b=ZvBuidanGOEzO1ADyWwmeq88zdE2eRyZ+799Yx6Lqj7AzLEaDshspxO8/c0EZveZdlA+1i
 zeC+90MpmYWocqdJvq+ZT9rbkLMMFcUsQJKOIIOiwKcfPg8XKRcjH+08iwg/06QwX1mwfr
 X7o53NJ8zpUW5qA5SqMSIMri0hZTnZo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-GAzrNyJENWCIgxEevvYxBQ-1; Fri, 30 Oct 2020 11:09:55 -0400
X-MC-Unique: GAzrNyJENWCIgxEevvYxBQ-1
Received: by mail-wr1-f69.google.com with SMTP id x16so2754163wrg.7
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 08:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NslL+8MYXzNC6tAMGQfCXeMzktZ0gagTiI4JSbA18W8=;
 b=gBXIxM4ZvRZ3hKCDjdZWLuN+WsMhXrMWMeJmi/j5zcXd/rLlqTM9t6rq/o1D0+a4R3
 wL7UE4sJ9VRQKGBQRqNX8BN0K/kQUd2LXqselly+32CvhHu8zhxKYUNYHpqVB2jazcsj
 0+IdTkpAG+Wv2AQ+OSjgURPR6bjgIRVVpf7IM0PzUItX5jZYc7Z/NU4QyA5AiHd2P2NJ
 hcj01kHRpB1yx4x4gozfJ11PMMAqLtfW07w7ORD2UfhldwnQiMYxkiBIHGnp3HS3xWUf
 Ovpk0pU9pLJBY6HLyEn1kxYeD+ut2ZPZFM6/cwWM7FQvVCWp8X3/hNbHK/sbQcjxqrK4
 MKnQ==
X-Gm-Message-State: AOAM531/7y+4Ji+G+8NkK/9Xlw5+QScn1AoUloMqIF2Ssm++V6oX+VLy
 m2bK3Y5goWFYOqILE9DQLaSltXN4uqqVDxdOn+g4CqQqe7ZotVq4e6b04HUxrG/4W7Sf5haQnnj
 y8D6gnC1eNwN0pto=
X-Received: by 2002:a5d:4f0b:: with SMTP id c11mr3711632wru.316.1604070593900; 
 Fri, 30 Oct 2020 08:09:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy08572UuSUWEeSTw0/5piLBtMPI1ONmMzgcSLEM/xGd+3me2lR8GDNrpGpbFFn7UfWUdBDnQ==
X-Received: by 2002:a5d:4f0b:: with SMTP id c11mr3711608wru.316.1604070593710; 
 Fri, 30 Oct 2020 08:09:53 -0700 (PDT)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id r3sm11201258wrm.51.2020.10.30.08.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 08:09:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.2] tools/virtiofsd: Check vu_init() return value
 (CID 1435958)
Date: Fri, 30 Oct 2020 16:09:51 +0100
Message-Id: <20201030150951.1542382-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 6f5fd837889, vu_init() can fail if malloc() returns NULL.

This fixes the following Coverity warning:

  CID 1435958 (#1 of 1): Unchecked return value (CHECKED_RETURN)

Fixes: 6f5fd837889 ("libvhost-user: support many virtqueues")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tools/virtiofsd/fuse_virtio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 324936948d3..3a32256e7af 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -1013,8 +1013,10 @@ int virtio_session_mount(struct fuse_session *se)
     se->vu_socketfd = data_sock;
     se->virtio_dev->se = se;
     pthread_rwlock_init(&se->virtio_dev->vu_dispatch_rwlock, NULL);
-    vu_init(&se->virtio_dev->dev, 2, se->vu_socketfd, fv_panic, NULL,
-            fv_set_watch, fv_remove_watch, &fv_iface);
+    if (!vu_init(&se->virtio_dev->dev, 2, se->vu_socketfd, fv_panic, NULL,
+                 fv_set_watch, fv_remove_watch, &fv_iface)) {
+        return -1;
+    }
 
     return 0;
 }
-- 
2.26.2


