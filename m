Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09CDC04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61097208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQWpyhYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61097208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49191 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVtCo-0000NT-KX
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:41:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hVsjq-0000ii-9y
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hVsjp-0006UD-F6
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:11:06 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hVsjp-0006Tw-AE
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:11:05 -0400
Received: by mail-pg1-x541.google.com with SMTP id n2so784667pgp.11
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 00:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=03Gb86KPthOkR7l6zYdtWIDlcvr0+sRNjxvLK/QpGew=;
	b=hQWpyhYlwSHOhN/SueOAIqFdWmoyD/uiyvQeDhsrU9lwzfY0LR9HcTKxRdk91JOfPu
	ekvlEx5fk333DQ4OwlJepksehspXut72/mttjMKwOvMVKdtD5hmlAue7v6Rhw5mpat78
	JDZxo9vFaFDOSqBQPeseIjQhpG3hcLSJreCa5mZcmLURywxX6m8O1B63PPA+WPNDZW1U
	yePDGdXd3svxLJR99sPo/qRsyz0aXbxvrVaHSuXA+j7LtJBPNV0glwx2M8M0UQJ/ctKD
	dzMSy0JVQE/v3w+afuowpVlDtfWTMydjnoWN2fbcSZZ0NS1cQW+X8edRz/GyByqcUWqd
	007g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=03Gb86KPthOkR7l6zYdtWIDlcvr0+sRNjxvLK/QpGew=;
	b=CQCgg9QEtql3JppTt+9XYpJG6JG4oS+Tqsrkm/VDOX7fNrs6TBS/SVxrMJJ4qj135t
	nfMhHEsoPII/7zx15kFjr38ZsXeNDFSAacYHIJKHuBapsvY2wiU5WvOjv896vC/172OI
	q/3jjN54OeD/iWFbXK3wYMYqO+fc5kV9UzslVtR58dTwZXha/Xc+buvvGs7n3TZJ7Vm0
	/6Vw1CGtyq/yEXZ3s3NqXQN44vkL6K3v5zYcIADV5DL4sKobP2IFVccusqVF85wS3/pV
	mbHS70pOlr6YN7KyXOv9CbXTIIxEbb1ZjHdMWZxojhHMtqkzyWBYAhcCLTfmyLC7Jo0Y
	f9iw==
X-Gm-Message-State: APjAAAUFwJjzlLmdj8ee56m8q3zGlpGfisHfXVt4iX7uGiPTMQdbvuyU
	xuwH5QrMJczHw9wlCS2xK7M=
X-Google-Smtp-Source: APXvYqx2m0DQRuE0UpGlMyawvNWbiJaTsYKzI5K/s3kFSlKdrsMqG1z59naEXToy/x5J0snGiNVM9Q==
X-Received: by 2002:a63:2325:: with SMTP id
	j37mr135339747pgj.137.1559113864504; 
	Wed, 29 May 2019 00:11:04 -0700 (PDT)
Received: from localhost ([116.247.112.152]) by smtp.gmail.com with ESMTPSA id
	c127sm17387040pfb.107.2019.05.29.00.11.03
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 29 May 2019 00:11:04 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com,
	groug@kaod.org,
	dgilbert@redhat.com
Date: Wed, 29 May 2019 15:09:54 +0800
Message-Id: <20190529070955.25565-5-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529070955.25565-1-xieyongji@baidu.com>
References: <20190529070955.25565-1-xieyongji@baidu.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 4/5] virtio: Don't change "started" flag on
 virtio_vmstate_change()
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
Cc: Xie Yongji <xieyongji@baidu.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

We will call virtio_set_status() on virtio_vmstate_change().
The "started" flag should not be changed in this case. Otherwise,
we may get an incorrect value when we set "started" flag but
not set DRIVER_OK in source VM.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
---
 hw/virtio/virtio.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 8a81374492..9e17293d46 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1162,9 +1162,13 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
             }
         }
     }
-    vdev->started = val & VIRTIO_CONFIG_S_DRIVER_OK;
-    if (unlikely(vdev->start_on_kick && vdev->started)) {
-        vdev->start_on_kick = false;
+
+    if ((vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) !=
+        (val & VIRTIO_CONFIG_S_DRIVER_OK)) {
+        vdev->started = val & VIRTIO_CONFIG_S_DRIVER_OK;
+        if (unlikely(vdev->start_on_kick && vdev->started)) {
+            vdev->start_on_kick = false;
+        }
     }
 
     if (k->set_status) {
-- 
2.17.1


