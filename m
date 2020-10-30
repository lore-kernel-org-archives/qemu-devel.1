Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A58C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954942072C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ekf0EsxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954942072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYToQ-00027S-ED
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 08:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTmR-0000Ra-8T
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTmO-0000OB-3p
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3iN6qY5085FKhuB3oQvig3p5w7EA9qYLRFEmWUtLf20=;
 b=Ekf0EsxGC+CF945+FzV7sQYPjnqFTTvTdUFlRfWFespjWOBVIaYCSOI9us39nvMXrCjIl9
 LBWQMBvPGGMFg5kB1mdJXc6bLO3YIJg9BdTFZyovAuNmN2K0NZ/UBzLtkNEU6hfAIVkRyz
 zfr+wqxXdJH3FNhbqsHNZuxcwt7bcpc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-Hs-yZCXAOdSozU6uimPVtQ-1; Fri, 30 Oct 2020 08:45:12 -0400
X-MC-Unique: Hs-yZCXAOdSozU6uimPVtQ-1
Received: by mail-wm1-f69.google.com with SMTP id r19so1191234wmh.9
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 05:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3iN6qY5085FKhuB3oQvig3p5w7EA9qYLRFEmWUtLf20=;
 b=hi2aj6NX0L4zK6l/EtKXONPaGe4vvHL1B9FPMNPoGMauMdY2L4AtFJn2SeqH52vWUn
 PwSVGLFWRwpApDPZ26QSmp3zw8gSTmL38sEve0sC9JCpVMtNH02ePVAonjtFFHSXXrBO
 RG3RFeLxcPtHCYN6LlC1hkXWVFqnSU038Q46At4Z5m6VFSvFvDhsK8s2fR5EozhGIeTm
 WTiSwEpAkY0C5NswktBsqfvpEIQ6sn91bFVQB94Sx2DpwAnA9xlL3M+CnSQ21ba70Nd7
 l4wa7zGzyOFzQQ99lydnzPvruT889JHB3LEgVtFCfgV0iXGKyhbaqsUkEM5Bq+Yr+ttV
 AkVg==
X-Gm-Message-State: AOAM532Pv3rnltdcSejOV5NE8UIScrLCMxzr31fxny24Wy0WXppCEyXE
 3Iy4XZHo9Nr6Zima6zYaZg+bFKuaCjc8YJdsbcHePftcZ+3SkEtLqsVYjaxnXz4GmNnnCJC6QFT
 t7o1ZCgXOzVj1BuY=
X-Received: by 2002:adf:8b92:: with SMTP id o18mr3048477wra.54.1604061910839; 
 Fri, 30 Oct 2020 05:45:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwG9Rt9d5JmobisJu8EXZDZM6LJOjVNOERpPm9s5cAXkQovbKn8RTzxUxYTit4SfhofXr/lzQ==
X-Received: by 2002:adf:8b92:: with SMTP id o18mr3048457wra.54.1604061910668; 
 Fri, 30 Oct 2020 05:45:10 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id h128sm4679767wme.38.2020.10.30.05.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 05:45:10 -0700 (PDT)
Date: Fri, 30 Oct 2020 08:45:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/15] vhost-vsock: set vhostfd to non-blocking mode
Message-ID: <20201030124454.854286-3-mst@redhat.com>
References: <20201030124454.854286-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201030124454.854286-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Garzarella <sgarzare@redhat.com>

vhost IOTLB API uses read()/write() to exchange iotlb messages with
the kernel module.
The QEMU implementation expects a non-blocking fd, indeed commit
c471ad0e9b ("vhost_net: device IOTLB support") set it for vhost-net.

Without this patch, if we enable iommu for the vhost-vsock device,
QEMU can hang when exchanging IOTLB messages.

As commit 894022e616 ("net: check if the file descriptor is valid
before using it") did for tap, let's use qemu_try_set_nonblock()
when fd is provided by the user.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20201029144849.70958-1-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vsock.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index f9db4beb47..8ddfb9abfe 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "hw/virtio/virtio-access.h"
 #include "qemu/error-report.h"
+#include "qemu/sockets.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
@@ -148,6 +149,13 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
             return;
         }
+
+        ret = qemu_try_set_nonblock(vhostfd);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret,
+                             "vhost-vsock: unable to set non-blocking mode");
+            return;
+        }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
@@ -155,6 +163,8 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
                              "vhost-vsock: failed to open vhost device");
             return;
         }
+
+        qemu_set_nonblock(vhostfd);
     }
 
     vhost_vsock_common_realize(vdev, "vhost-vsock");
-- 
MST


