Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCF7C76188
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA9B2084C
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvUDObsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA9B2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1horAH-0005DV-QM
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 11:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39833)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8R-0005rg-Uc
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8R-00086T-12
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:55 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:39314)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hor8Q-00085h-RF
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:54 -0400
Received: by mail-wm1-x32e.google.com with SMTP id u25so21150873wmc.4
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 08:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Cnx1rgP4vCPMdBzxOJnmvGYzuuFVyS3iImpvp8s2dHs=;
 b=rvUDObsAW+sIc0IuEYdvyWt5rcPzKGlCc7pv0Hky6ZWUIxx1+INH/4strtkendaZPk
 jPcwuFoPVBGMUGkhK/F6hV7+DJGoiXtazpU8ICbWzV8q46VlaCvD0pvrllQ4cfpvDHXJ
 6fFVsMdZvx0k9PuP2sBfD038ZYJ2XjObIEz6E/Lw625SgNLr+9xQ9i8Z/gfL/ioztzsN
 5wWm9xrHkVLWwQT3rJYVsXlMrdfulHSFnT4++WqBAz4vDY/HJMQ5+bEtZLdeLC6nVIsO
 0PBqTal79T9G/MdU15BbJjgRHozc9lQNTZTUo8P1Qx3AbhbjjREBJMUNxHEmBJRemO9M
 NXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Cnx1rgP4vCPMdBzxOJnmvGYzuuFVyS3iImpvp8s2dHs=;
 b=VDepK2F9MS9Bf+cUPvkmxN92w+CrsoMGt4sHAbAZGXoF3II8/jJcHWNL0O/TDQ0RYV
 dPt8z7xpDKR/eRrigmH4yVEfZxelWVI1efsKL03/N1ASG0R/LFifnmkAS71NzvdP9Rvj
 eZ2hgrOCPdv5cYPMwNQjAhV/2gH+S6FcQwLiS6inCH9Kq8zOC8+UqIj4cfoUYDIucFuh
 ZJnnkETGBwpJE5oPYPyRrcRNcZYG7R6HLb14HzjIPSnrAaf30CAEXQVg10PtflcpMA8t
 4gGEBeO/a8i/e/FybIY8/Dh5RohozUDYehHYcS/YKaE9Q89FpdtT7QroXtoFBfT+WUUH
 s1zQ==
X-Gm-Message-State: APjAAAXOS6vFv0OHsDsDM12jSJ216pmLDYx8lZIrWfYWtZSCTFWgQCaB
 iRBXPOzhY2uFkH29lP9R5NxmO95XOno=
X-Google-Smtp-Source: APXvYqycAWAn+LX1DKOCIGLO0wHaJO3PfY8NQy5ODe34D6+dF1yqrREXUwu6yO3E2IQLi0jSB6DdKQ==
X-Received: by 2002:a1c:7e90:: with SMTP id
 z138mr51983855wmc.128.1563635933613; 
 Sat, 20 Jul 2019 08:18:53 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id 4sm77517291wro.78.2019.07.20.08.18.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 20 Jul 2019 08:18:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 20 Jul 2019 17:18:38 +0200
Message-Id: <20190720151846.7450-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190720151846.7450-1-pbonzini@redhat.com>
References: <20190720151846.7450-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: [Qemu-devel] [PULL 04/12] vhost-scsi: Call
 virtio_scsi_common_unrealize() when device realize failed
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
Cc: Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

This avoids memory leak when device hotplug is failed.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Message-Id: <20190717004606.12444-1-xieyongji@baidu.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/vhost-scsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 76bb875..343ca8b 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -210,7 +210,7 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
         if (err) {
             error_propagate(errp, err);
             error_free(vsc->migration_blocker);
-            goto close_fd;
+            goto free_virtio;
         }
     }
 
@@ -240,6 +240,8 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
         migrate_del_blocker(vsc->migration_blocker);
     }
     g_free(vsc->dev.vqs);
+ free_virtio:
+    virtio_scsi_common_unrealize(dev);
  close_fd:
     close(vhostfd);
     return;
-- 
1.8.3.1



