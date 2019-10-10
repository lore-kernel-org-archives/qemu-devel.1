Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61A2C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 18:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CCC320650
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 18:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCC320650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIcp0-0003fn-JV
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 14:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iIcnl-0002m7-6j
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 14:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iIcnj-0002yG-OU
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 14:04:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43708)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iIcnj-0002xD-Fk
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 14:04:35 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BDB8046671
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 18:04:33 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id z1so3080912wrw.21
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 11:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=k1Ln7wbJdRB9+0i/i3PgA7rXs1V2HgFI5brxWPZonVI=;
 b=P94b9sRl9z3VhWsXZg5NgFChFRn7fcwTKQO2T8hQ8oSycTp80A0eXhuMrhjdNZl50R
 nMrAmwrZg3KC010eGzhGtwkqE3s8pY99Ptsz/APvO34tJHXoFoXgq52tuBCNRoVhG1eS
 DPHSrMhG0ARMzrc8BfcvV5p18HCKw+ZoWk/pBmVLtDHf8oodhPHHVhkeXtT4+YEAQMOm
 ga5E4Y9KVaZ25vv1vqwnqI0t8x5lCdysJ7jCEKBXAWy4DMHBKn0JDaPE37jJ5/8BvhYb
 /syJGcVcwUAHf24ss0OEgs0qb3E684lgNdQdd5Bp9kPcB1DeQS5JuudeXJ0t+0L420RL
 fTNA==
X-Gm-Message-State: APjAAAWnntp2xjwzF0pKw5ar863oV+oKcxyiAs6ZgGYrTN6Ghn/RUb1H
 7+m/BHqv5r5FHlkUK1hOluywLn2camSOcjwlsRqJag51WE1wMkePonJ3Bw9v8xLxLThgzbM1zDa
 AopL+YcG0kAkOdlw=
X-Received: by 2002:a05:600c:21d7:: with SMTP id
 x23mr8592670wmj.6.1570730672276; 
 Thu, 10 Oct 2019 11:04:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxkA/eRocVX8Jf6sJTTb2yqnsQBFWzL+LYA2uxg2OvzOlw2eGkEbyiplaIttMDwaHRYlo58Qw==
X-Received: by 2002:a05:600c:21d7:: with SMTP id
 x23mr8592659wmj.6.1570730672080; 
 Thu, 10 Oct 2019 11:04:32 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 d4sm7213051wrq.22.2019.10.10.11.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2019 11:04:31 -0700 (PDT)
Date: Thu, 10 Oct 2019 14:04:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC 1/2] virtio: new post_load hook
Message-ID: <20191010180412.26236-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: mikhail.sennikovskii@cloud.ionos.com, dgilbert@redhat.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Post load hook in virtio vmsd is called early while device is processed,
and when VirtIODevice core isn't fully initialized.  Most device
specific code isn't ready to deal with a device in such state, and
behaves weirdly.

Add a new post_load hook in a device class instead.  Devices should use
this unless they specifically want to verify the migration stream as
it's processed, e.g. for bounds checking.

Suggested-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c         | 7 +++++++
 include/hw/virtio/virtio.h | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 527df03bfd..54a46e204c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2291,6 +2291,13 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     }
     rcu_read_unlock();
 
+    if (vdc->post_load) {
+        ret = vdc->post_load(vdev);
+        if (ret) {
+            return ret;
+        }
+    }
+
     return 0;
 }
 
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 48e8d04ff6..ca4f9c0bcc 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -158,6 +158,12 @@ typedef struct VirtioDeviceClass {
      */
     void (*save)(VirtIODevice *vdev, QEMUFile *f);
     int (*load)(VirtIODevice *vdev, QEMUFile *f, int version_id);
+    /* Post load hook in vmsd is called early while device is processed, and
+     * when VirtIODevice isn't fully initialized.  Devices should use this instead,
+     * unless they specifically want to verify the migration stream as it's
+     * processed, e.g. for bounds checking.
+     */
+    int (*post_load)(VirtIODevice *vdev);
     const VMStateDescription *vmsd;
 } VirtioDeviceClass;
 
-- 
MST


