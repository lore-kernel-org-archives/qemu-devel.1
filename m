Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADD6C35280
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 21:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C472083B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 21:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0HcLBos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C472083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWoE8-00007y-Ky
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 17:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jWoDb-0008AI-LT; Thu, 07 May 2020 17:38:11 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:42387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jWoDa-00048q-T1; Thu, 07 May 2020 17:38:11 -0400
Received: by mail-io1-xd41.google.com with SMTP id e9so4424640iok.9;
 Thu, 07 May 2020 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=mzFs3fGCzwOhGj1FmmUOmxFD2e1lVknc6E09yCHo1j0=;
 b=Q0HcLBosWDAMNnbUwkO1AtpqAQneSKWhyC4zBkTC/Y7mseCpRaOQZ2syRukEMmN5gf
 nnmovHSgqoapisorZD8+piXf1g/L7MmvUYoVpzVy4Ys1qFXcg2Em93QK/tX5ytGQW+jw
 FQC+68jzTlzxH6BdDRpCbDFrNTp3yn05VIlNp4/FDz+GM6MSoDGUcEnfbFK7a4k3YfMj
 u7IKToXtBRtNj25yY6m8/G06+jhsblJbbSmnRzvy4ETQdaCZNAAHsUZQpw2KC/mfFRro
 bbwbKP3rygGRiuWTVskwwo3M4DPxv4usQLn7t3lVHXkTlVevzq/L/+3hacjJCoRkFBvu
 bHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=mzFs3fGCzwOhGj1FmmUOmxFD2e1lVknc6E09yCHo1j0=;
 b=jNDWKIGpsQV+Uv090DPYJBlv/EB1CJsGPJY9x7lOHMa8OgKvwt2ciJoHO/SM5KP7QE
 nEMRSpTjcy+OaCe7XJFdw2Z5msu+eZj5myyx+urSOq/5y2aeEaR6iomMmbjIcVLFHY9o
 Z5BAwipzRsecEJss7x6vALeHmaBgW+J+5MlBWFU2wJt0Zs0JiIY+q7lZVTFfqRuJramB
 1DX9q7Nq3p0QS0tGSQoaKyDskxJRmyEj4S99mGCdwDWeyshESOKQ0kJaS902PZFQXq/o
 TI8B+Pch+hpMn43lDTQWlX+qnDRNMNA4u8EaQ5zVeqat2fQ52KBSjcx/fn9kiYHDbSlg
 DJJA==
X-Gm-Message-State: AGi0PuYnyWQgZKV93rmRfI9Tr4H3/CW3Sm5rqAK6XNqWsCmnuIWcirKW
 pbW1cOuQ+yoaawSTmQxIoJUJm7uIhN2vPfs2y78=
X-Google-Smtp-Source: APiQypJtqqW7KTy7Gzcxep9DebsKsEQjR4AR+FZPjWe80S+t0wMAxQHB+/SI1XoYNQVIr4neBsp+tmCfA2TzDTGRPgs=
X-Received: by 2002:a6b:b582:: with SMTP id
 e124mr16272990iof.161.1588887489505; 
 Thu, 07 May 2020 14:38:09 -0700 (PDT)
MIME-Version: 1.0
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 7 May 2020 17:37:58 -0400
Message-ID: <CAFubqFtqNZw=Y-ar3N=3zTQi6LkKg_G-7W7OOHHbE7Y1fV7HAQ@mail.gmail.com>
Subject: [PATCH v2] Fix parameter type in vhost migration log path
To: eblake@redhat.com, mst@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The =E2=80=98enable=E2=80=99 parameter to the vhost_migraion_log() function=
 is given as
an int, but "true"/"false" values are passed in wherever it is invoked.
Inside the function itself it is only ever compared with bool values.
Therefore the parameter value itself should be changed to bool.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 hw/virtio/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index aff98a0..aa06a36 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -809,12 +809,12 @@ err_features:
     return r;
 }

-static int vhost_migration_log(MemoryListener *listener, int enable)
+static int vhost_migration_log(MemoryListener *listener, bool enable)
 {
     struct vhost_dev *dev =3D container_of(listener, struct vhost_dev,
                                          memory_listener);
     int r;
-    if (!!enable =3D=3D dev->log_enabled) {
+    if (enable =3D=3D dev->log_enabled) {
         return 0;
     }
     if (!dev->started) {
--
1.8.3.1

