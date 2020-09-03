Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4B4C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:31:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C8AD206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM1Jf/jO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8AD206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwpo-0005VR-O8
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwM0-0004zl-Js; Thu, 03 Sep 2020 17:01:10 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36685)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLy-0007rj-QL; Thu, 03 Sep 2020 17:01:08 -0400
Received: by mail-oi1-x243.google.com with SMTP id x19so4535893oix.3;
 Thu, 03 Sep 2020 14:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=OBNgeqRx4bpj7whZl9Nqe1uUGZCI5XWKl7ZvXD57/RM=;
 b=EM1Jf/jOulJZ8qFNufvClh5XlmBbYtMw65yMz85r7W3UbzXG9ba8m6NiQXEBd2W746
 N7PLgo1L9QJKYTsjTPerD5uSn+tNXpeZ5TIBKsijToaJROvnVK+6UQ65lSjVOhQS8+77
 mT/jauay0mnzRsW/tdMPzpG8sZRVGa0cfnI8FLOgO96XwlUPj/Jrv0IqxYj5ixy0mkee
 3srFEYSGVRcf+kzqP6jyQ+BDcFiXY2z3jSn3s/ELfl+dgxi9ztembWmsvxolBEigR3oJ
 g9gosWkrCcHwL9F7RcrpFl9BtULFZGERhece6psxXxH1WEwJ1DLSICg1lqZYDgkm0cuU
 Yuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=OBNgeqRx4bpj7whZl9Nqe1uUGZCI5XWKl7ZvXD57/RM=;
 b=M7+M3r25wjaX7Cy7tOOcwlxuvgcydCgD2IcqVhdV1YjmlkLEPJdQxrUk8osMQ2PUxV
 D1P5TttqmOI+7xW1D1h2s3ZwaJDHpXFDZA62p/1z9fo1YO4uz6VBmr9sJw/thjMTTAZp
 FruXLD/gyYiRRkvtureBHQDF5WgA4KkeBfyTjn97Iqq76mj/4wkhr3YbdFJVyR8Z/87D
 8JS0+QfagdGCIvr+HqhbSULwuZFekMoguD/UQOqtyZ9q8Jm+BmzvESa+13x1HFpbaLLE
 fCuDsoqmfbt18A9SxxlXm3EUFt5secq7920wks0gYUfHWMDAFjfKhAgeEkaqzs3RkTZP
 U0FA==
X-Gm-Message-State: AOAM531WglEwZK2aOnf1cDUSBD5Q3Uy8uOvIO69XmLZyflU0G/2jQeuq
 Q8OfWciD2YcBb/YckD4+3ClO+nFh/5UKSQ==
X-Google-Smtp-Source: ABdhPJz75tcfMw+vHfTPyDv3z7hv/nXY8YkMUZJga3pGDzEmq2rdRMrGuop0U3ge1l3P9ahldkImfg==
X-Received: by 2002:aca:fc85:: with SMTP id a127mr3290379oii.148.1599166864926; 
 Thu, 03 Sep 2020 14:01:04 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id l63sm712081oia.56.2020.09.03.14.01.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:01:04 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 62/77] virtio-balloon: always indicate S_DONE when migration
 fails
Date: Thu,  3 Sep 2020 15:59:20 -0500
Message-Id: <20200903205935.27832-63-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Wei Wang <wei.w.wang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 qemu-stable@nongnu.org, Alexander Duyck <alexander.duyck@gmail.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

If something goes wrong during precopy, before stopping the VM, we will
never send a S_DONE indication to the VM, resulting in the hinted pages
not getting released to be used by the guest OS (e.g., Linux).

Easy to reproduce:
1. Start migration (e.g., HMP "migrate -d 'exec:gzip -c > STATEFILE.gz'")
2. Cancel migration (e.g., HMP "migrate_cancel")
3. Oberve in the guest (e.g., cat /proc/meminfo) that there is basically
   no free memory left.

While at it, add similar locking to virtio_balloon_free_page_done() as
done in virtio_balloon_free_page_stop. Locking is still weird, but that
has to be sorted out separately.

There is nothing to do in the PRECOPY_NOTIFY_COMPLETE case. Add some
comments regarding S_DONE handling.

Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200629080615.26022-1-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit dd8eeb9671fc881e613008bd20035b85fe45383d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio-balloon.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index d6e31de1d9..6c75db123e 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -572,8 +572,13 @@ static void virtio_balloon_free_page_done(VirtIOBalloon *s)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
 
-    s->free_page_report_status = FREE_PAGE_REPORT_S_DONE;
-    virtio_notify_config(vdev);
+    if (s->free_page_report_status != FREE_PAGE_REPORT_S_DONE) {
+        /* See virtio_balloon_free_page_stop() */
+        qemu_mutex_lock(&s->free_page_lock);
+        s->free_page_report_status = FREE_PAGE_REPORT_S_DONE;
+        qemu_mutex_unlock(&s->free_page_lock);
+        virtio_notify_config(vdev);
+    }
 }
 
 static int
@@ -597,17 +602,26 @@ virtio_balloon_free_page_report_notify(NotifierWithReturn *n, void *data)
     case PRECOPY_NOTIFY_SETUP:
         precopy_enable_free_page_optimization();
         break;
-    case PRECOPY_NOTIFY_COMPLETE:
-    case PRECOPY_NOTIFY_CLEANUP:
     case PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC:
         virtio_balloon_free_page_stop(dev);
         break;
     case PRECOPY_NOTIFY_AFTER_BITMAP_SYNC:
         if (vdev->vm_running) {
             virtio_balloon_free_page_start(dev);
-        } else {
-            virtio_balloon_free_page_done(dev);
+            break;
         }
+        /*
+         * Set S_DONE before migrating the vmstate, so the guest will reuse
+         * all hinted pages once running on the destination. Fall through.
+         */
+    case PRECOPY_NOTIFY_CLEANUP:
+        /*
+         * Especially, if something goes wrong during precopy or if migration
+         * is canceled, we have to properly communicate S_DONE to the VM.
+         */
+        virtio_balloon_free_page_done(dev);
+        break;
+    case PRECOPY_NOTIFY_COMPLETE:
         break;
     default:
         virtio_error(vdev, "%s: %d reason unknown", __func__, pnd->reason);
-- 
2.17.1


