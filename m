Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED66AC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59692247C9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDX4Jrg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59692247C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXncg-0004cM-Cs
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXnYd-0007Ic-Cw
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:40:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXnYb-0000yO-Kn
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603899612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S7XMAb8q6l78gUQIvYp6GLhZjM50wNjwAwcC2omOytM=;
 b=FDX4Jrg9xB4JQk8M6e2e3JvNAopKREv1Gw6ImY2Mpsx8Xb/cM5UAJjwhNVbgqcqKZinzTc
 berhC29MVy72DXjsJzRx4cVTugMymPA/DD2z/wY9Vq+3LId5fyzljfwl/nwflV2f3lJzNq
 0PSY6IQeUWEMMmRobqwhOxUFF/4rXWw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-lC8aU0vxOAa1Vi3Wx7YTLw-1; Wed, 28 Oct 2020 11:40:11 -0400
X-MC-Unique: lC8aU0vxOAa1Vi3Wx7YTLw-1
Received: by mail-ed1-f72.google.com with SMTP id dn20so2288140edb.14
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 08:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=S7XMAb8q6l78gUQIvYp6GLhZjM50wNjwAwcC2omOytM=;
 b=jQpOcmddeCx10ACblUE6VEM6JJMTL+VlZrIqwI41ts3YRWVouk4L73YOZCAHTYrAnY
 jcdn+VjghWRzOThHyGB4taV0AdnWbZYKybb/j9eDCBcGLPv5USRL8K/MG6JhcXcjov5c
 HOXMo8OJ33+5gceTcHWYKAyswlKFRXo+6mIL2jalQtezvoZiMftGE64ifVfqaAstrFea
 paRxcTIo4GIqwj5UFKcfj5tP/aiV/gQdehTBIvHNdcXR3NZSTVOV5jxYtvPnBoPzRPXw
 XqJYZcHVaNZvC3k9qopF+WpSs0fK95E0c88FxhpPj648qLBI6qQ3iRworwk6LTSMknyq
 s0JQ==
X-Gm-Message-State: AOAM530OqYQCpxaIbfhEwwOONo70tMXnLnMG2XCGlQwlfsyEYedzMuRY
 BMAiqt6/n/qhw0b9NKNPBGIHEWqo83S4qTGRo3gKM3eYUveSiS8PRGpggrMASRSTMJvKXVDoGQ+
 xCU1lHO9sQ92t+Fg=
X-Received: by 2002:a50:b224:: with SMTP id o33mr8008708edd.21.1603899606678; 
 Wed, 28 Oct 2020 08:40:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz97zqvyCfMpYpLLwbFxHJo5uu2Ub8hwEv6Ah7TqqGTANoF/PKugYknikNL4Y34M2OaGxRCYg==
X-Received: by 2002:a50:b224:: with SMTP id o33mr8008685edd.21.1603899606456; 
 Wed, 28 Oct 2020 08:40:06 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id sa23sm1341377ejb.80.2020.10.28.08.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 08:40:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2] hw/virtio/vhost-vdpa: Fix Coverity CID 1432864
Date: Wed, 28 Oct 2020 16:40:04 +0100
Message-Id: <20201028154004.776760-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
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
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix uninitialized value issues reported by Coverity:

  Field 'msg.reserved' is uninitialized when calling write().

Fixes: a5bd05800f8 ("vhost-vdpa: batch updating IOTLB mappings")
Reported-by: Coverity (CID 1432864: UNINIT)
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Cindy Lu <lulu@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 4f1039910af..01d2101d097 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -90,7 +90,7 @@ static void vhost_vdpa_listener_begin(MemoryListener *listener)
 {
     struct vhost_vdpa *v = container_of(listener, struct vhost_vdpa, listener);
     struct vhost_dev *dev = v->dev;
-    struct vhost_msg_v2 msg;
+    struct vhost_msg_v2 msg = {};
     int fd = v->device_fd;
 
     if (!(dev->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
@@ -110,7 +110,7 @@ static void vhost_vdpa_listener_commit(MemoryListener *listener)
 {
     struct vhost_vdpa *v = container_of(listener, struct vhost_vdpa, listener);
     struct vhost_dev *dev = v->dev;
-    struct vhost_msg_v2 msg;
+    struct vhost_msg_v2 msg = {};
     int fd = v->device_fd;
 
     if (!(dev->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
-- 
2.26.2


