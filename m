Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8EFC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF7720FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBbaus/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF7720FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVxL6-0006CF-AN
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 09:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ameynarkhede03@gmail.com>)
 id 1kVwQC-0002tR-Pf
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 08:43:52 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ameynarkhede03@gmail.com>)
 id 1kVwQB-0004Uu-66
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 08:43:52 -0400
Received: by mail-pf1-x444.google.com with SMTP id a200so1141114pfa.10
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 05:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Xfa/+IUfERMNZFt57SMrHugq0gNZh3ymo/LP5O+MlWs=;
 b=eBbaus/QYA55LRKIUOzzlm4NUV1hEe9n7FioapPRfxWZUO0pU2HKPMdsPubXJPtiHb
 haWNrgutYQs1NBbQLhujJqwCHwcaaFGUaP+jJB1CC17HINV+ZEVB1/J+1iZV7QeBreNC
 Iit8oZeEXK5n5frnlt4AAlR9Yjy9fm2ZJNLM2EEcUN2x8hgOpjhP9GycHWTeeBrxFAZD
 /gDCMLS+Ux9ZyJN4UfuBX34m5j4NqsrSecBUdQv+p9Fu2Bl2RyWRvJWea0ELtnhvDDZF
 XSNOzH6k6ag4KJkTvQ948ofoz4HX91GIz9t4EJ5c9Pn6FZwJ2KWBcwOeiKuYCMXVW9XE
 LDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Xfa/+IUfERMNZFt57SMrHugq0gNZh3ymo/LP5O+MlWs=;
 b=VzMGDJ6uQkQiSxsCMNAl9HINue4npCN8W6VDOuEmRaiegXCGhXXKXmNrsxHnpmKs1a
 S9nIsCyiGLEDA/anVL2fRD2by+dqifE7LJXHxjtJqGd28hCg3jaEubC+csVFzTTo0csi
 XlBt/3xzKijluxpOh4dVR+y1CLIkgHwPbnMmcHQyHM9AUnJ89vn2ZRdrGV1oRK+myE7t
 cf9DDLAQPkKIx5uaIGZnf+Ydn2WUF62WW64fhZ+HBDhsd/x+OzwX4MtUyRascaXqIO3P
 lijbpYurR068KuatTg4NOPzRPvV49r6QgG+6jV/sk0XHY7NIyoDsB2QdxV3imgG9As/n
 S1Mw==
X-Gm-Message-State: AOAM530PerObqxqIoumy13hZe6JSY5WJUcNB/nwCD1TpwnmVGmiqLN/c
 ndd9FswDAhC6igxI+sjQ3oY=
X-Google-Smtp-Source: ABdhPJzdCEaPYR3NLTTQSjMECVEQfaQdNzYa+Vmczi6odZqUQekfhUpf1S2bCocH9L9qaRlaYNIWPA==
X-Received: by 2002:a17:90a:f3d4:: with SMTP id
 ha20mr2354900pjb.28.1603457029383; 
 Fri, 23 Oct 2020 05:43:49 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.132])
 by smtp.googlemail.com with ESMTPSA id e6sm1487056pgn.9.2020.10.23.05.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:43:48 -0700 (PDT)
From: Amey Narkhede <ameynarkhede03@gmail.com>
To: alex.williamson@redhat.com
Subject: [PATCH] hw/vfio: Use lock guard macros
Date: Fri, 23 Oct 2020 18:13:42 +0530
Message-Id: <20201023124342.17793-1-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=ameynarkhede03@gmail.com; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 23 Oct 2020 09:39:14 -0400
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
Cc: Amey Narkhede <ameynarkhede03@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use qemu LOCK_GUARD macros in hw/vfio.
Saves manual unlock calls

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 hw/vfio/platform.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 869ed2c39d..cc3f66f7e4 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -166,7 +166,7 @@ static void vfio_intp_mmap_enable(void *opaque)
     VFIOINTp *tmp;
     VFIOPlatformDevice *vdev = (VFIOPlatformDevice *)opaque;
 
-    qemu_mutex_lock(&vdev->intp_mutex);
+    QEMU_LOCK_GUARD(&vdev->intp_mutex);
     QLIST_FOREACH(tmp, &vdev->intp_list, next) {
         if (tmp->state == VFIO_IRQ_ACTIVE) {
             trace_vfio_platform_intp_mmap_enable(tmp->pin);
@@ -174,12 +174,10 @@ static void vfio_intp_mmap_enable(void *opaque)
             timer_mod(vdev->mmap_timer,
                       qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
                           vdev->mmap_timeout);
-            qemu_mutex_unlock(&vdev->intp_mutex);
             return;
         }
     }
     vfio_mmap_set_enabled(vdev, true);
-    qemu_mutex_unlock(&vdev->intp_mutex);
 }
 
 /**
@@ -289,7 +287,7 @@ static void vfio_platform_eoi(VFIODevice *vbasedev)
     VFIOPlatformDevice *vdev =
         container_of(vbasedev, VFIOPlatformDevice, vbasedev);
 
-    qemu_mutex_lock(&vdev->intp_mutex);
+    QEMU_LOCK_GUARD(&vdev->intp_mutex);
     QLIST_FOREACH(intp, &vdev->intp_list, next) {
         if (intp->state == VFIO_IRQ_ACTIVE) {
             trace_vfio_platform_eoi(intp->pin,
@@ -314,7 +312,6 @@ static void vfio_platform_eoi(VFIODevice *vbasedev)
         vfio_intp_inject_pending_lockheld(intp);
         QSIMPLEQ_REMOVE_HEAD(&vdev->pending_intp_queue, pqnext);
     }
-    qemu_mutex_unlock(&vdev->intp_mutex);
 }
 
 /**
-- 
2.29.0


