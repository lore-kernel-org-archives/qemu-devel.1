Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A66C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1237520725
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbtfP3Pc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1237520725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYTr9-0005Xl-Un
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 08:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTmY-0000VS-1f
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTmW-0000ZM-5R
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z+z1Pzm/JUurzVLAFZHFV/vzVTD3l9eIdz7HgpfiM6o=;
 b=DbtfP3PcDnIS0g4foZfVAmF/XuPZIDHby3/HDXTwmY+YPQAGeAglHpWhDd5Ea0nA2Lgkop
 XA+z09/JV9dZ0/QCFKu7rnkwHvOWdv7kHCvJiJC/D1VF8InjWzUCCBCKeNhEdwCplDEyKb
 WrbYZvTC2pLc8Ik8viafhiD/CIPhLqU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-A84L1iU9MbSXqdFq3q955A-1; Fri, 30 Oct 2020 08:45:19 -0400
X-MC-Unique: A84L1iU9MbSXqdFq3q955A-1
Received: by mail-wr1-f70.google.com with SMTP id j15so2612789wrd.16
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 05:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=z+z1Pzm/JUurzVLAFZHFV/vzVTD3l9eIdz7HgpfiM6o=;
 b=ByLP30mRLSuNqehUGyD1/biClc2IrWRx2aHJfHZ0icAb1ew/YWiQgowhchJH0BX6Xy
 TNSOtEfEyR9biQ0aV/HIvxOfbKOnUxYptIs2B4MUvDm8WTVrinU4ZR3ujdQftd5ttF0p
 Jfaz9P5F76uIkN5BDc3irTUDkb5Q52S0JAIOpdziDGm3tTplnG7mPL+WWqoymo4C56Vp
 QTqXZGG6WubgU4dsF1b4GCsCb4tQeoVzgVoP4bQ4rDNuSCzHsN4tTfIimZASluBkriNO
 l+v3DYYDvLwq8NYdctXFTagQ9GJRWikJutM+Xoat68nYGNNKxsa9NFl9lS7Krh5E3DtB
 inUA==
X-Gm-Message-State: AOAM530HRCLLj+eBT2sMgKIwBSLNG4g6SxFwt+DTPMhxbpqW0mZyATmu
 K1QMl+uuxJqE4aOqc42rbQN4vfHbmZbkJyTSuOBXjE4CTEyT02SUGURqJqM+4fsnzEu+YIXo/uM
 n3znkScaj3Cge9LM=
X-Received: by 2002:adf:f10e:: with SMTP id r14mr2783724wro.337.1604061918043; 
 Fri, 30 Oct 2020 05:45:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxa4Bglpmk8XSE5mL50swaXXVk7LkktQyXC1wB943GSivsG2JKX0POs0SXtb5blt1JW+jnFbw==
X-Received: by 2002:adf:f10e:: with SMTP id r14mr2783705wro.337.1604061917903; 
 Fri, 30 Oct 2020 05:45:17 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id c10sm1960254wrx.13.2020.10.30.05.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 05:45:17 -0700 (PDT)
Date: Fri, 30 Oct 2020 08:45:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/15] hw/virtio/vhost-vdpa: Fix Coverity CID 1432864
Message-ID: <20201030124454.854286-6-mst@redhat.com>
References: <20201030124454.854286-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201030124454.854286-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Fix uninitialized value issues reported by Coverity:

  Field 'msg.reserved' is uninitialized when calling write().

Fixes: a5bd05800f8 ("vhost-vdpa: batch updating IOTLB mappings")
Reported-by: Coverity (CID 1432864: UNINIT)
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20201028154004.776760-1-philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 4f1039910a..01d2101d09 100644
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
MST


