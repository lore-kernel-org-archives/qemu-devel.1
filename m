Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA09C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B37B2175B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVsud2sK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B37B2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49672 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbiok-0005sq-2G
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 05:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40783)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elohimes@gmail.com>) id 1hbieK-0004oG-56
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1hbiZF-0000q9-RY
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:32:18 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hbiZF-0000pv-Md
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:32:17 -0400
Received: by mail-pf1-x441.google.com with SMTP id a186so1098737pfa.5
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 02:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XDE2icSbolLOa01WawYlTzTQ3MDApcSEwbj0XrcaTAM=;
 b=hVsud2sK/QSUbdHBBRmIvY5nK5Pam3KE4VfxjiBlZYAALULvpakZksta5eDLByRQA9
 bEvEGs4CgwjIlqb26WM3jgQakL2vKyllH2AlyAAiD3RzH9UaUhiMS9a/HxGqkzg4tcZM
 RjbvvzpHsbhITFpYQPf9uewQB7OYupwjcfS2BVaKh4dnMLcxmrnsfVT5B27CNY0cueTw
 dY7mIBrb6OURmBt//zJoLgtlR2tKicH8Jdi5Wy8XfyIADNMRJPBTZgGIhdZTtlbKUl2n
 QhK9WmENo1GIXCXwwL9dR2WJte/P6Vd3XoxZ7QC8AHRRB9qghKsliisxIRdro37ENKng
 8tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XDE2icSbolLOa01WawYlTzTQ3MDApcSEwbj0XrcaTAM=;
 b=bTMlZunTYlnV5nsWWAORE0l42csCjdzxrJJJDDYCdQId36q1VChren9Sr1cX3TEOQ9
 lZ9tj8CKoq617+pWqyR3LwUJEu0JUh2qUJGyibn0FBDv3FOZ9rc+hDZYlll6T1Bu4KZk
 +aj4ADJf/MPLh8nfMvkkJ2iVX0kMk9lqGG4SSZvIKgCyCFWE2zGVbXuvMacl0UUATD6R
 TOYBhPgPthPg9tRamylLnFhEp1R8ZCcdlVB9/qUFhhj2ZRiJFGqp/ydwPNOvHfzGDpp6
 Om77Tjp7/1fbf9SiNbo3ba0bdVsUsIxBA3XE4SKxumgYDRBS2F+VUUALUvctgZsfwCXl
 gX/w==
X-Gm-Message-State: APjAAAU/5Wes8r9zUPGqDk/0K95Uq8Hj5sD6kJ1Jt5X1tHI9tvFbJ7Tc
 L7rsLYuH2mAYlvxMXe5S/qc=
X-Google-Smtp-Source: APXvYqx3D1bPiHSnIanbuiAHuzs4AsQDW/a5swnZaz8bNEqpaS9eOWEyW9ZnCXeaDTJwS+pwTHnLxw==
X-Received: by 2002:a63:f959:: with SMTP id q25mr26668682pgk.357.1560504736820; 
 Fri, 14 Jun 2019 02:32:16 -0700 (PDT)
Received: from localhost ([116.247.112.152])
 by smtp.gmail.com with ESMTPSA id o26sm2300980pgv.47.2019.06.14.02.32.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 14 Jun 2019 02:32:16 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com,
	groug@kaod.org
Date: Fri, 14 Jun 2019 17:31:21 +0800
Message-Id: <20190614093121.5580-6-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614093121.5580-1-xieyongji@baidu.com>
References: <20190614093121.5580-1-xieyongji@baidu.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v3 5/5] virtio: Don't change "started" flag on
 virtio_vmstate_change()
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
Cc: qemu-devel@nongnu.org, Xie Yongji <xieyongji@baidu.com>,
 dgilbert@redhat.com, ehabkost@redhat.com
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
 hw/virtio/virtio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index b4301f9e02..9af2e339af 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1163,7 +1163,10 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
         }
     }
 
-    virtio_set_started(vdev, val & VIRTIO_CONFIG_S_DRIVER_OK);
+    if ((vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) !=
+        (val & VIRTIO_CONFIG_S_DRIVER_OK)) {
+        virtio_set_started(vdev, val & VIRTIO_CONFIG_S_DRIVER_OK);
+    }
 
     if (k->set_status) {
         k->set_status(vdev, val);
-- 
2.17.1


