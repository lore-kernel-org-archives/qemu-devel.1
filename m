Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B2DC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 12:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD0622CF5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 12:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD0622CF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5U18-0007RI-Q3
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 08:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i5TyS-0006Ab-SG
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i5TyQ-0002Qy-K6
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:01:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47990)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i5TyQ-0002DX-1K
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:01:18 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 835F388307
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 12:00:59 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id f19so22529311qtq.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 05:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WxL0nQCOfT19HACNY1Zcoi1cjxT5JJKSnCqqWQgIjNM=;
 b=PWfc98soMnyKYLACgpCjmQrk2C9H/Oy8BiAx/E6y2gytPCmSmesw0KB0JAdEgsggm0
 V5UpjY9YSTI43utdlAqt2NGuKzN1tZOAbttUHZFhQyJ0Aq02wSjTygZJTf0+wCdiWPJA
 +zEdSsQn9BG3XAoCkSUfpmED8UY9U3cM0Aqq2nRf4ZCCqoltkv6xgxSvWQjiMAd3uI79
 7repR8W/4Jj8vgTRVV1tddOMGTiUo7zil3V+6K7F/YkY3FRo2eDRR6sSBHUP3UZi1myc
 ugFofSXbKihujv4UoshSmeCrHjTHLd/oKGFRTAVG128PFVVXluPoxinJurWFDlrEwE4o
 XNRw==
X-Gm-Message-State: APjAAAUSIpIl358KcuMBb6V6uIFFV/8lPqxA+vUkn5UbePiGiiEr9xIy
 r+2wfDXPdCHskbfhD9gd1c5vc4JBfKSYCsiW4aDD4P8oIf2axjsLvGctMaBXphRECas8CkTGIfm
 4Y1LhKkQwvMV4Vlg=
X-Received: by 2002:a37:660c:: with SMTP id a12mr37095505qkc.70.1567598458470; 
 Wed, 04 Sep 2019 05:00:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx5mRryPDU0+tAZ8Zkg0Z62LgiyLSEYOpEGCh/aMGqss31fXwvBfdUgw/YeOti/lERyJH4aqA==
X-Received: by 2002:a37:660c:: with SMTP id a12mr37095470qkc.70.1567598458125; 
 Wed, 04 Sep 2019 05:00:58 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id 199sm9932793qkk.112.2019.09.04.05.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 05:00:57 -0700 (PDT)
Date: Wed, 4 Sep 2019 08:00:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190820160615.14616-3-lvivier@redhat.com>
References: <20190904120026.3220-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190904120026.3220-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/6] virtio-rng: Keep the default backend out of
 VirtIORNGConf
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Amit Shah <amit@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190904120053.55KFFoUYjYFvM5ghwe9qzKnCz16OmAdLQr_SY3Swq6I@z>

From: Markus Armbruster <armbru@redhat.com>

The default backend is only used within virtio_rng_device_realize().
Replace VirtIORNGConf member default_backend by a local variable.
Adjust its type to reduce conversions.

While there, pass &error_abort instead of NULL when failure would be a
programming error.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20190820160615.14616-3-lvivier@redhat.com>
---
 hw/virtio/virtio-rng.c         | 20 +++++++++-----------
 include/hw/virtio/virtio-rng.h |  2 --
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index d1650e1dee..fcf3b2e329 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -19,6 +19,7 @@
 #include "hw/virtio/virtio-rng.h"
 #include "sysemu/rng.h"
 #include "sysemu/runstate.h"
+#include "sysemu/rng-random.h"
 #include "qom/object_interfaces.h"
 #include "trace.h"
 
@@ -192,27 +193,24 @@ static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
     }
 
     if (vrng->conf.rng == NULL) {
-        vrng->conf.default_backend = RNG_RANDOM(object_new(TYPE_RNG_RANDOM));
+        Object *default_backend = object_new(TYPE_RNG_RANDOM);
 
-        user_creatable_complete(USER_CREATABLE(vrng->conf.default_backend),
+        user_creatable_complete(USER_CREATABLE(default_backend),
                                 &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
-            object_unref(OBJECT(vrng->conf.default_backend));
+            object_unref(default_backend);
             return;
         }
 
-        object_property_add_child(OBJECT(dev),
-                                  "default-backend",
-                                  OBJECT(vrng->conf.default_backend),
-                                  NULL);
+        object_property_add_child(OBJECT(dev), "default-backend",
+                                  default_backend, &error_abort);
 
         /* The child property took a reference, we can safely drop ours now */
-        object_unref(OBJECT(vrng->conf.default_backend));
+        object_unref(default_backend);
 
-        object_property_set_link(OBJECT(dev),
-                                 OBJECT(vrng->conf.default_backend),
-                                 "rng", NULL);
+        object_property_set_link(OBJECT(dev), default_backend,
+                                 "rng", &error_abort);
     }
 
     vrng->rng = vrng->conf.rng;
diff --git a/include/hw/virtio/virtio-rng.h b/include/hw/virtio/virtio-rng.h
index ff699335e3..bd05d734b8 100644
--- a/include/hw/virtio/virtio-rng.h
+++ b/include/hw/virtio/virtio-rng.h
@@ -14,7 +14,6 @@
 
 #include "hw/virtio/virtio.h"
 #include "sysemu/rng.h"
-#include "sysemu/rng-random.h"
 #include "standard-headers/linux/virtio_rng.h"
 
 #define TYPE_VIRTIO_RNG "virtio-rng-device"
@@ -27,7 +26,6 @@ struct VirtIORNGConf {
     RngBackend *rng;
     uint64_t max_bytes;
     uint32_t period_ms;
-    RngRandom *default_backend;
 };
 
 typedef struct VirtIORNG {
-- 
MST


