Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934CEC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E377206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tazh16zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E377206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGLJi-0000eY-IG
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 07:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGLHS-0006Em-6w
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGLHQ-0005sn-W4
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:30:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32062)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGLHQ-0005sf-Rm
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584963004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YY5Hl1kxBgBTjqar9z4p8DPMscyXhhaOdjtagcypCqI=;
 b=Tazh16zmMbTHoxIWoyQASujWSsRowYAiYVxrugw0RAvmOoOz0q6FKrc6RhdN2bklRxzsuW
 al8CctnjRpEZYqPqx+58zo0Bl9kVzwnVYLqhNadA+rocpJ4HZC3kbmDBwln3338xYdd/DI
 z8xEjRo2uP5BNAHp+eP8RInbje9QxWc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-4duAdFn5MRWBaiBCn_K4GA-1; Mon, 23 Mar 2020 07:30:02 -0400
X-MC-Unique: 4duAdFn5MRWBaiBCn_K4GA-1
Received: by mail-wm1-f71.google.com with SMTP id h203so3282633wme.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 04:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b6LKcP8aR+D0NjOE1uN+dlp4t1btfpredi4xxYHm4B0=;
 b=IhvpTijbhe+tWmjvLxQVG/gJII56ew0RhmV2CaV6sDfPArFCS4nALoIOuE2IKUyQ3p
 TA/SijnMTvUJJHBQ55WVfSOsJVfNA+/4p5dud4MlUcAPTcjVnkDdheKFfev0e/0rBz7b
 ZXO9DxBGdULFhc/CQutCQ/7KCo2TMQERDH6iXXnZlde7eYJwaldYwtyvWzZVIA57Abkx
 S0wHh0aWMq2f8g29z2WrJs/ucJRiLbceBqUYtlNzdLnh/wiUgthhsnIchb2VfrlxREPX
 n//UG+tR/WiZ+ITcUL9FPBVSIom1/xkCEih3eKtwJLWWoilBZ0kdg+PPn+pPMisKoxqs
 vlTg==
X-Gm-Message-State: ANhLgQ3VvacDlz7thzTtF5RYKG0oRyh4xL9q1jvwGBNMKn3XD3KItMFQ
 1Y+3z+aIprKD2ZN8ZH75NIFFFHBZUKBcu1WjA69eUjmTNxhEd0J8oPhk28v83HImVHf9xufqLYm
 J8EDvuFLYV8xmZDM=
X-Received: by 2002:a1c:23c8:: with SMTP id
 j191mr27194732wmj.117.1584963001169; 
 Mon, 23 Mar 2020 04:30:01 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsWMsjwRMBjwY8vtRTvSm/jolqOocJNusU/5uKsVzbfTgGmPDkKemiQxJnIaHHXXSyKdUKkAg==
X-Received: by 2002:a1c:23c8:: with SMTP id
 j191mr27194709wmj.117.1584963000904; 
 Mon, 23 Mar 2020 04:30:00 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id f1sm13331081wrv.37.2020.03.23.04.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 04:30:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 3/3] virtio-gpu: Release memory returned by
 virtqueue_pop() with free()
Date: Mon, 23 Mar 2020 12:29:43 +0100
Message-Id: <20200323112943.12010-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200323112943.12010-1-philmd@redhat.com>
References: <20200323112943.12010-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As virtio_gpu_handle_ctrl() fills the cmdq calling virtqueue_pop(),
we need to release it with free() in virtio_gpu_reset().

virtio_gpu_handle_ctrl() allocates memory calling virtqueue_pop(),
release it in virtio_gpu_process_cmdq() with free().

virtio_gpu_process_cmdq() move commands from cmdq to fenceq, so
we also have to release them with free().

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/display/virtio-gpu-3d.c | 2 +-
 hw/display/virtio-gpu.c    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index 96621576c2..3a97d267e5 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -506,7 +506,7 @@ static void virgl_write_fence(void *opaque, uint32_t fe=
nce)
         trace_virtio_gpu_fence_resp(cmd->cmd_hdr.fence_id);
         virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODATA)=
;
         QTAILQ_REMOVE(&g->fenceq, cmd, next);
-        g_free(cmd);
+        free(cmd);
         g->inflight--;
         if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
             fprintf(stderr, "inflight: %3d (-)\r", g->inflight);
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 5f0dd7c150..f5fbb722ee 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -835,7 +835,7 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
                 fprintf(stderr, "inflight: %3d (+)\r", g->inflight);
             }
         } else {
-            g_free(cmd);
+            free(cmd);
         }
     }
 }
@@ -921,7 +921,7 @@ static void virtio_gpu_handle_cursor(VirtIODevice *vdev=
, VirtQueue *vq)
         }
         virtqueue_push(vq, elem, 0);
         virtio_notify(vdev, vq);
-        g_free(elem);
+        free(elem);
     }
 }
=20
@@ -1157,14 +1157,14 @@ static void virtio_gpu_reset(VirtIODevice *vdev)
     while (!QTAILQ_EMPTY(&g->cmdq)) {
         cmd =3D QTAILQ_FIRST(&g->cmdq);
         QTAILQ_REMOVE(&g->cmdq, cmd, next);
-        g_free(cmd);
+        free(cmd);
     }
=20
     while (!QTAILQ_EMPTY(&g->fenceq)) {
         cmd =3D QTAILQ_FIRST(&g->fenceq);
         QTAILQ_REMOVE(&g->fenceq, cmd, next);
         g->inflight--;
-        g_free(cmd);
+        free(cmd);
     }
=20
 #ifdef CONFIG_VIRGL
--=20
2.21.1


