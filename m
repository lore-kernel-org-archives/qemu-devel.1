Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE4DCA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A7B8214DA
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7B8214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOUhW-0007e8-Gn
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 18:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iOTzF-0005VT-GG
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iOTzE-0003Za-37
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:52:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54122)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iOTzD-0003ZK-RB
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:52:40 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5A27A5945B
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 21:52:38 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id v23so2739650qth.20
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 14:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3gU25GDgMsUx4G9fo45xqWhGpCO+qZL7RzGmc1DlyOI=;
 b=V9J9rQaSdtUFOnWHWswgGHFOk6D4kMyMS1zxLPCp1kMsAX0NkBQslgpTtnCl975Dk+
 Hlw6CcsBg/d1bU11pFCkk5SUzw66u8XhDrXT3V1B8EnKu9OU1bQstKbKVIKABIoy2PyD
 XrMA6ER4vtSqn+zYSJxE+rKCF0VMrwVQJvJhkkvhiBg0PyMP92r00GuWgdeS0ZgM3vsF
 yxbvPlnT8XHffgtoQYoi1SAWilhbHFu48kL3TTaKsM+o1TVsIebbWrusOMxX8Lh4YEIW
 gnV1za0T0FgB9oTWu50x+NY6hmGfvy1ki8UpCpzMaveiVdRAKRFk7c6j4VOXWWxGTMLb
 Tzzg==
X-Gm-Message-State: APjAAAX37cegOg60Qc7zrrBD7MovV4y4WRAYaQtGsUVHu6/mOcyrK63w
 qG6qXDK0/K+44d/M0NNCQvf8ppOBU6uM8sZXZ8/9OYn7NwfRCXct5MSMQvh7YYjusf3KRwmJCZQ
 mjxhKnMZXq1Z7Mw0=
X-Received: by 2002:ac8:548f:: with SMTP id h15mr10530362qtq.176.1572126757144; 
 Sat, 26 Oct 2019 14:52:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyFcWr2TR3/a8sv/hVoVHaVJY/En9bM9BtgSmbS+5gaAfTxQx0GwYqmNyf4RS/hqamjA4hx+Q==
X-Received: by 2002:ac8:548f:: with SMTP id h15mr10530345qtq.176.1572126756944; 
 Sat, 26 Oct 2019 14:52:36 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 x19sm3271213qkf.26.2019.10.26.14.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 14:52:36 -0700 (PDT)
Date: Sat, 26 Oct 2019 17:52:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/25] libqos: implement VIRTIO 1.0 FEATURES_OK step
Message-ID: <20191026193824.11926-17-mst@redhat.com>
References: <20191026193824.11926-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026193824.11926-1-mst@redhat.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Device initialization has an extra step in VIRTIO 1.0.  The FEATURES_OK
status bit is set to indicate that feature negotiation has completed.
The driver then reads the status register again to check that the device
agrees with the final features.

Implement this step as part of qvirtio_set_features() instead of
introducing a separate function.  This way all existing code works
without modifications.

The check in qvirtio_set_driver_ok() needs to be updated because
FEATURES_OK will be set for VIRTIO 1.0 devices.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20191023100425.12168-9-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth" <thuth@redhat.com>
---
 tests/libqos/virtio.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 6049ff3b3e..fa597c2481 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -46,6 +46,20 @@ void qvirtio_set_features(QVirtioDevice *d, uint64_t features)
 {
     d->features = features;
     d->bus->set_features(d, features);
+
+    /*
+     * This could be a separate function for drivers that want to access
+     * configuration space before setting FEATURES_OK, but no existing users
+     * need that and it's less code for callers if this is done implicitly.
+    */
+    if (features & (1ull << VIRTIO_F_VERSION_1)) {
+        uint8_t status = d->bus->get_status(d) |
+                         VIRTIO_CONFIG_S_FEATURES_OK;
+
+        d->bus->set_status(d, status);
+        g_assert_cmphex(d->bus->get_status(d), ==, status);
+    }
+
     d->features_negotiated = true;
 }
 
@@ -86,7 +100,9 @@ void qvirtio_set_driver_ok(QVirtioDevice *d)
 {
     d->bus->set_status(d, d->bus->get_status(d) | VIRTIO_CONFIG_S_DRIVER_OK);
     g_assert_cmphex(d->bus->get_status(d), ==, VIRTIO_CONFIG_S_DRIVER_OK |
-                    VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_ACKNOWLEDGE);
+                    VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_ACKNOWLEDGE |
+                    (d->features & (1ull << VIRTIO_F_VERSION_1) ?
+                     VIRTIO_CONFIG_S_FEATURES_OK : 0));
 }
 
 void qvirtio_wait_queue_isr(QTestState *qts, QVirtioDevice *d,
-- 
MST


