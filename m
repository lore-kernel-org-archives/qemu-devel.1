Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C67C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 18:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE313206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 18:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE313206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40951 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGT8F-0002YR-1B
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 14:48:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.streetman@canonical.com>) id 1hGT6U-0001fI-Rj
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.streetman@canonical.com>) id 1hGT6T-0005bt-P8
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:46:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dan.streetman@canonical.com>)
	id 1hGT6T-0005YE-JA
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:46:45 -0400
Received: from mail-yw1-f71.google.com ([209.85.161.71])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <dan.streetman@canonical.com>) id 1hGT6R-000072-JD
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 18:46:43 +0000
Received: by mail-yw1-f71.google.com with SMTP id 201so16283621ywr.13
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 11:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=JSL2reb0c3p5lrYQaX/Mundk1gFllcy7clmVFRRaQTg=;
	b=kkHjZArRtOV+Rhxt+Sh2GD3jGE2fqR/2APbiFnmq9F89AT/Lu9Ha42YM5s0z6Wu1if
	oxs24blKvkvITmrRt+hKntBkkdvEW5R4pfBrJDuUJoCxa3oN/8VwhVa1EE4oKpV+klFQ
	MV9gV24dw+vFVq1tstV6msaelDF/dnsltMnHnivp65p3L5AIBKTjofNp5tQQl5vtjY9Z
	0rvxo47iZZbR07n334e+vE5kzcLt/uVPMtUupdpKF1WvS2mbj6iWlHR9QGEJWWsEMpYt
	1mJXv+HVFgczOHUjq0pPfRJw3RNqrT1KKEuXJn7NueNj4VLbfbt8ZII3DAc0FIUWXcEc
	Ge0w==
X-Gm-Message-State: APjAAAVu8HpmlHkSV0tPUbsc7EtpmsuIg6H66YEYMj1qf1m/+DTpgjZv
	BtRHYYKrgau+h+KtK1/y4Jg/JkXprIjZH7bTNsqR8r8t8N/mHq8hW3Ld6Hreigel1ZbdP8Zv6V2
	D1MyWISaXB4knQyLZf4W8EGo+i/PuvMDa
X-Received: by 2002:a81:234a:: with SMTP id j71mr64565787ywj.352.1555440402661;
	Tue, 16 Apr 2019 11:46:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzElxArwhxx7jGTa6DtxDDsFeL4ORmUxkCDmPpf3NOGO7kzt5Yuxir4yIDFmDK1rsOAGpyERQ==
X-Received: by 2002:a81:234a:: with SMTP id j71mr64565767ywj.352.1555440402378;
	Tue, 16 Apr 2019 11:46:42 -0700 (PDT)
Received: from thorin.lan (45-27-90-188.lightspeed.rlghnc.sbcglobal.net.
	[45.27.90.188]) by smtp.gmail.com with ESMTPSA id
	c205sm17554833ywc.10.2019.04.16.11.46.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 11:46:39 -0700 (PDT)
From: Dan Streetman <dan.streetman@canonical.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	qemu-devel@nongnu.org, qemu-stable@nongnu.org
Date: Tue, 16 Apr 2019 14:46:23 -0400
Message-Id: <20190416184624.15397-2-dan.streetman@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416184624.15397-1-dan.streetman@canonical.com>
References: <20190416184624.15397-1-dan.streetman@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 91.189.89.112
Subject: [Qemu-devel] [PATCH 1/2] add VirtIONet vhost_stopped flag to
 prevent multiple stops
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416184623.6p9hmk25CH_JZBNKf4ps0MDdVnNfflFFe3Mgctzy2oE@z>

From: Dan Streetman <ddstreet@canonical.com>

Buglink: https://launchpad.net/bugs/1823458

There is a race condition when using the vhost-user driver, between a guest
shutdown and the vhost-user interface being closed.  This is explained in
more detail at the bug link above; the short explanation is the vhost-user
device can be closed while the main thread is in the middle of stopping
the vhost_net.  In this case, the main thread handling shutdown will
enter virtio_net_vhost_status() and move into the n->vhost_started (else)
block, and call vhost_net_stop(); while it is running that function,
another thread is notified that the vhost-user device has been closed,
and (indirectly) calls into virtio_net_vhost_status() also.  Since the
vhost_net status hasn't yet changed, the second thread also enters
the n->vhost_started block, and also calls vhost_net_stop().  This
causes problems for the second thread when it tries to stop the network
that's already been stopped.

This adds a flag to the struct that's atomically set to prevent more than
one thread from calling vhost_net_stop().  The atomic_fetch_inc() is likely
overkill and probably could be done with a simple check-and-set, but
since it's a race condition there would still be a (very, very) small
window without using an atomic to set it.

Signed-off-by: Dan Streetman <ddstreet@canonical.com>
---
 hw/net/virtio-net.c            | 3 ++-
 include/hw/virtio/virtio-net.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index ffe0872fff..d36f50d5dd 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/iov.h"
+#include "qemu/atomic.h"
 #include "hw/virtio/virtio.h"
 #include "net/net.h"
 #include "net/checksum.h"
@@ -240,7 +241,7 @@ static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
                          "falling back on userspace virtio", -r);
             n->vhost_started = 0;
         }
-    } else {
+    } else if (atomic_fetch_inc(&n->vhost_stopped) == 0) {
         vhost_net_stop(vdev, n->nic->ncs, queues);
         n->vhost_started = 0;
     }
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index b96f0c643f..d03fd933d0 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -164,6 +164,7 @@ struct VirtIONet {
     uint8_t nouni;
     uint8_t nobcast;
     uint8_t vhost_started;
+    int vhost_stopped;
     struct {
         uint32_t in_use;
         uint32_t first_multi;
-- 
2.20.1


