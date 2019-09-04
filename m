Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35807C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 12:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF4022CED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 12:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF4022CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5U6L-0004uR-5a
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 08:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i5TyZ-0006Ho-BQ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i5TyU-0002W1-1h
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:01:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24672)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i5TyT-0002VL-NP
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:01:21 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E81673C917
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 12:01:20 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id k68so22785780qkb.19
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 05:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tCK6/OLcwSs4FABgTV4T0Bg63KixKgLpwZYThOYPwqA=;
 b=fXipK4oVo05tJdjRskfUbKLKDNBS+cweRgGYULpKMAk+CRmBiFzqbbiowSxxtW/b/5
 mRktVVWoU+wdA9tZbxTVILOTpm56O4Sw1gPxWAeDyNhboJo27AUlo2UI75dWuKwueWXi
 eGl0sIwHNRG65KOpXMRuEHODCs1eTfW7yk/hJyXNtpBirCxEbfxLuEKu+aQoQlUxy2HV
 ibQ5zx24V5uAlcS4hONttRawq/nXzkrvh2gorJ436fMBWAW3R542Omogw0EGbw/xlRv5
 rhmblrVzjRA0GiPgHM47DRcpoFCk8rjazk1jthwcCFxi0VISMLuc+kP9GbfW39JxVqbb
 bIVw==
X-Gm-Message-State: APjAAAV8NwMu+ZPFzicvbsLuD0eCcFZlUplf3EwYQu+gNNkWHGSLoDN0
 MWRlkJNpgn2HSP5dQNKk0Ae8XdzbkldOM3SeYrefsZ4VpxQWXZ+Um28A7zjNEtrDjxzEssNbq+e
 mlmweqDC3Kmj4OV4=
X-Received: by 2002:a05:6214:1808:: with SMTP id
 o8mr13018421qvw.118.1567598479888; 
 Wed, 04 Sep 2019 05:01:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqypFT+oYcsqJ+G92kQoPlSc8rW12XYJXyWA2UbOYawJa6Ym6Eed3V05M5v2CNm1of9wx+yFEQ==
X-Received: by 2002:a05:6214:1808:: with SMTP id
 o8mr13018392qvw.118.1567598479607; 
 Wed, 04 Sep 2019 05:01:19 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id e14sm11795044qta.54.2019.09.04.05.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 05:01:18 -0700 (PDT)
Date: Wed, 4 Sep 2019 08:01:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190904065021.1360-1-johannes@sipsolutions.net>
References: <20190904120026.3220-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190904120026.3220-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 6/6] libvhost-user: introduce and use
 vu_has_protocol_feature()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhang Yu <zhangyu31@baidu.com>,
 Johannes Berg <johannes.berg@intel.com>, Tiwei Bie <tiwei.bie@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190904120114.IkMyz9P1u9PKjlaS5npEdhyTljt3WVbiW3tEvlDYsuQ@z>

From: Johannes Berg <johannes.berg@intel.com>

This simplifies the various has_feature() checks, we already
have vu_has_feature() but it checks features, not protocol
features.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20190904065021.1360-1-johannes@sipsolutions.net>
Reviewed-by: Tiwei Bie <tiwei.bie@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index cb5f5770e4..68c27136ae 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -94,6 +94,11 @@ bool vu_has_feature(VuDev *dev,
     return has_feature(dev->features, fbit);
 }
 
+static inline bool vu_has_protocol_feature(VuDev *dev, unsigned int fbit)
+{
+    return has_feature(dev->protocol_features, fbit);
+}
+
 static const char *
 vu_request_to_string(unsigned int req)
 {
@@ -951,8 +956,7 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
 {
     int i = 0;
 
-    if (!has_feature(dev->protocol_features,
-        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
         return 0;
     }
 
@@ -1097,8 +1101,7 @@ bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
 
     vmsg.fd_num = fd_num;
 
-    if (!has_feature(dev->protocol_features,
-                     VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)) {
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)) {
         return false;
     }
 
@@ -2191,8 +2194,7 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
 static int
 vu_queue_inflight_get(VuDev *dev, VuVirtq *vq, int desc_idx)
 {
-    if (!has_feature(dev->protocol_features,
-        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
         return 0;
     }
 
@@ -2209,8 +2211,7 @@ vu_queue_inflight_get(VuDev *dev, VuVirtq *vq, int desc_idx)
 static int
 vu_queue_inflight_pre_put(VuDev *dev, VuVirtq *vq, int desc_idx)
 {
-    if (!has_feature(dev->protocol_features,
-        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
         return 0;
     }
 
@@ -2226,8 +2227,7 @@ vu_queue_inflight_pre_put(VuDev *dev, VuVirtq *vq, int desc_idx)
 static int
 vu_queue_inflight_post_put(VuDev *dev, VuVirtq *vq, int desc_idx)
 {
-    if (!has_feature(dev->protocol_features,
-        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
         return 0;
     }
 
-- 
MST


