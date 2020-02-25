Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8A0C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:27:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5394121744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQ9hwR8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5394121744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6c7k-0000JY-HA
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:27:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6bvC-0002Qc-VV
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:14:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6bvB-0001oG-45
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:14:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49144
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6bvA-0001o2-Uz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l++BsqWy6N6vNodZEk7v6Kw66F2SSiMTtlt2r/wo72g=;
 b=HQ9hwR8skUj1zS0NNOoi5gWPjDwZ8rN6Y3MlU0Bm2IbBlChp6MEqokM5v7Kcse9yDdANbI
 VDsdt+YRumxNd+YIzGGQ1z2n8Rnlv0wcyIeRpkWR/xtG3Zc0lX8J70Tn+6nfX3nr94pl5s
 wo+xPrkmulIJu/iu7Wust2L+AwLaUzU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-hGLZxvgSOS-dFnuXacV1dA-1; Tue, 25 Feb 2020 10:14:49 -0500
X-MC-Unique: hGLZxvgSOS-dFnuXacV1dA-1
Received: by mail-qv1-f69.google.com with SMTP id dc2so13218582qvb.7
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:14:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ueZNy91f6vpalfK/xoKwpCSS7mTT4hlV5Y3nJIZ9/Zk=;
 b=uba1kWGyceQYpkaVPLmBj766+BEEjn8fhZJy2sj3XM8PiSHFmet5NWYzkg7DwDC4m9
 xh71kONb6IZcEnjPqvfzGaG23fbQ8LfwH66myLehjVpFBqWX/R/4hGtzKzUYjGc6zgC1
 TqJW+y/dYXxOolG48QlBbfpnSmsmGaaXzFOdSBowz7ANEmKTqrDhtEM2SKY7PpfMg7HT
 3CIAk/C3+vLvyB0EZ1zGEV0YIAzX2yFp0piGi4vvpvyes7Ht74xEuOyaTRK1KVumUHdm
 O0coEDVKWZPWvZsDAiTxz9d02shrtQHtCEnV6nPEnLhXIKGX3Kdo6KcjNv6GYVZijE3/
 Df9A==
X-Gm-Message-State: APjAAAUsf7lRY4FbUP9o8yN+rADRXNMD+oGth0y8dMv57gQ6GMpxKMLO
 Sr3HImajD54cttrH1J1hg41+7g66WKtIakhS7gkAWbCYo0rFc6M7OfPyfbFhmjJXNgAY+F9jiXp
 qcECC7KailC3U/Sw=
X-Received: by 2002:ac8:198c:: with SMTP id u12mr56228733qtj.225.1582643686884; 
 Tue, 25 Feb 2020 07:14:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqy26XlEY3MIPBpDYN91g1BMIOEER1fpG7q5M5iCBAolGZIURfia3aJqOeu6xPTE6w9s7CCmeA==
X-Received: by 2002:ac8:198c:: with SMTP id u12mr56228583qtj.225.1582643685440; 
 Tue, 25 Feb 2020 07:14:45 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 p50sm7962368qtf.5.2020.02.25.07.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:14:44 -0800 (PST)
Date: Tue, 25 Feb 2020 10:14:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/32] libvhost-user: implement in-band notifications
Message-ID: <20200225151210.647797-28-mst@redhat.com>
References: <20200225151210.647797-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200225151210.647797-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Johannes Berg <johannes.berg@intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Johannes Berg <johannes.berg@intel.com>

Add support for VHOST_USER_PROTOCOL_F_IN_BAND_NOTIFICATIONS, but
as it's not desired by default, don't enable it unless the device
implementation opts in by returning it from its protocol features
callback.

Note that I updated vu_set_vring_err_exec(), but didn't add any
sending of the VHOST_USER_SLAVE_VRING_ERR message as there's no
write to the err_fd today either.

This also adds vu_queue_notify_sync() which can be used to force
a synchronous notification if inband notifications are supported.
Previously, I had left out the slave->master direction handling
of F_REPLY_ACK, this now adds some code to support it as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20200123081708.7817-7-johannes@sipsolutions.net>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h |  14 ++++
 contrib/libvhost-user/libvhost-user.c | 103 +++++++++++++++++++++++++-
 2 files changed, 114 insertions(+), 3 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/=
libvhost-user.h
index 5cb7708559..6fc8000e99 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -54,6 +54,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD =3D 10,
     VHOST_USER_PROTOCOL_F_HOST_NOTIFIER =3D 11,
     VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD =3D 12,
+    VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS =3D 14,
=20
     VHOST_USER_PROTOCOL_F_MAX
 };
@@ -95,6 +96,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_GET_INFLIGHT_FD =3D 31,
     VHOST_USER_SET_INFLIGHT_FD =3D 32,
     VHOST_USER_GPU_SET_SOCKET =3D 33,
+    VHOST_USER_VRING_KICK =3D 35,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
@@ -103,6 +105,8 @@ typedef enum VhostUserSlaveRequest {
     VHOST_USER_SLAVE_IOTLB_MSG =3D 1,
     VHOST_USER_SLAVE_CONFIG_CHANGE_MSG =3D 2,
     VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG =3D 3,
+    VHOST_USER_SLAVE_VRING_CALL =3D 4,
+    VHOST_USER_SLAVE_VRING_ERR =3D 5,
     VHOST_USER_SLAVE_MAX
 }  VhostUserSlaveRequest;
=20
@@ -528,6 +532,16 @@ bool vu_queue_empty(VuDev *dev, VuVirtq *vq);
  */
 void vu_queue_notify(VuDev *dev, VuVirtq *vq);
=20
+/**
+ * vu_queue_notify_sync:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ *
+ * Request to notify the queue via callfd (skipped if unnecessary)
+ * or sync message if possible.
+ */
+void vu_queue_notify_sync(VuDev *dev, VuVirtq *vq);
+
 /**
  * vu_queue_pop:
  * @dev: a VuDev context
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/=
libvhost-user.c
index 3abc9689e5..3bca996c62 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -136,6 +136,7 @@ vu_request_to_string(unsigned int req)
         REQ(VHOST_USER_GET_INFLIGHT_FD),
         REQ(VHOST_USER_SET_INFLIGHT_FD),
         REQ(VHOST_USER_GPU_SET_SOCKET),
+        REQ(VHOST_USER_VRING_KICK),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
@@ -163,7 +164,10 @@ vu_panic(VuDev *dev, const char *msg, ...)
     dev->panic(dev, buf);
     free(buf);
=20
-    /* FIXME: find a way to call virtio_error? */
+    /*
+     * FIXME:
+     * find a way to call virtio_error, or perhaps close the connection?
+     */
 }
=20
 /* Translate guest physical address to our virtual address.  */
@@ -1203,6 +1207,14 @@ vu_set_vring_err_exec(VuDev *dev, VhostUserMsg *vmsg=
)
 static bool
 vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
+    /*
+     * Note that we support, but intentionally do not set,
+     * VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS. This means that
+     * a device implementation can return it in its callback
+     * (get_protocol_features) if it wants to use this for
+     * simulation, but it is otherwise not desirable (if even
+     * implemented by the master.)
+     */
     uint64_t features =3D 1ULL << VHOST_USER_PROTOCOL_F_MQ |
                         1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD |
                         1ULL << VHOST_USER_PROTOCOL_F_SLAVE_REQ |
@@ -1235,6 +1247,25 @@ vu_set_protocol_features_exec(VuDev *dev, VhostUserM=
sg *vmsg)
=20
     dev->protocol_features =3D vmsg->payload.u64;
=20
+    if (vu_has_protocol_feature(dev,
+                                VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS=
) &&
+        (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SLAVE_REQ) ||
+         !vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK))) =
{
+        /*
+         * The use case for using messages for kick/call is simulation, to=
 make
+         * the kick and call synchronous. To actually get that behaviour, =
both
+         * of the other features are required.
+         * Theoretically, one could use only kick messages, or do them wit=
hout
+         * having F_REPLY_ACK, but too many (possibly pending) messages on=
 the
+         * socket will eventually cause the master to hang, to avoid this =
in
+         * scenarios where not desired enforce that the settings are in a =
way
+         * that actually enables the simulation case.
+         */
+        vu_panic(dev,
+                 "F_IN_BAND_NOTIFICATIONS requires F_SLAVE_REQ && F_REPLY_=
ACK");
+        return false;
+    }
+
     if (dev->iface->set_protocol_features) {
         dev->iface->set_protocol_features(dev, features);
     }
@@ -1495,6 +1526,34 @@ vu_set_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
     return false;
 }
=20
+static bool
+vu_handle_vring_kick(VuDev *dev, VhostUserMsg *vmsg)
+{
+    unsigned int index =3D vmsg->payload.state.index;
+
+    if (index >=3D dev->max_queues) {
+        vu_panic(dev, "Invalid queue index: %u", index);
+        return false;
+    }
+
+    DPRINT("Got kick message: handler:%p idx:%d\n",
+           dev->vq[index].handler, index);
+
+    if (!dev->vq[index].started) {
+        dev->vq[index].started =3D true;
+
+        if (dev->iface->queue_set_started) {
+            dev->iface->queue_set_started(dev, index, true);
+        }
+    }
+
+    if (dev->vq[index].handler) {
+        dev->vq[index].handler(dev, index);
+    }
+
+    return false;
+}
+
 static bool
 vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -1577,6 +1636,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_get_inflight_fd(dev, vmsg);
     case VHOST_USER_SET_INFLIGHT_FD:
         return vu_set_inflight_fd(dev, vmsg);
+    case VHOST_USER_VRING_KICK:
+        return vu_handle_vring_kick(dev, vmsg);
     default:
         vmsg_close_fds(vmsg);
         vu_panic(dev, "Unhandled request: %d", vmsg->request);
@@ -2038,8 +2099,7 @@ vring_notify(VuDev *dev, VuVirtq *vq)
     return !v || vring_need_event(vring_get_used_event(vq), new, old);
 }
=20
-void
-vu_queue_notify(VuDev *dev, VuVirtq *vq)
+static void _vu_queue_notify(VuDev *dev, VuVirtq *vq, bool sync)
 {
     if (unlikely(dev->broken) ||
         unlikely(!vq->vring.avail)) {
@@ -2051,11 +2111,48 @@ vu_queue_notify(VuDev *dev, VuVirtq *vq)
         return;
     }
=20
+    if (vq->call_fd < 0 &&
+        vu_has_protocol_feature(dev,
+                                VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS=
) &&
+        vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SLAVE_REQ)) {
+        VhostUserMsg vmsg =3D {
+            .request =3D VHOST_USER_SLAVE_VRING_CALL,
+            .flags =3D VHOST_USER_VERSION,
+            .size =3D sizeof(vmsg.payload.state),
+            .payload.state =3D {
+                .index =3D vq - dev->vq,
+            },
+        };
+        bool ack =3D sync &&
+                   vu_has_protocol_feature(dev,
+                                           VHOST_USER_PROTOCOL_F_REPLY_ACK=
);
+
+        if (ack) {
+            vmsg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
+        }
+
+        vu_message_write(dev, dev->slave_fd, &vmsg);
+        if (ack) {
+            vu_message_read(dev, dev->slave_fd, &vmsg);
+        }
+        return;
+    }
+
     if (eventfd_write(vq->call_fd, 1) < 0) {
         vu_panic(dev, "Error writing eventfd: %s", strerror(errno));
     }
 }
=20
+void vu_queue_notify(VuDev *dev, VuVirtq *vq)
+{
+    _vu_queue_notify(dev, vq, false);
+}
+
+void vu_queue_notify_sync(VuDev *dev, VuVirtq *vq)
+{
+    _vu_queue_notify(dev, vq, true);
+}
+
 static inline void
 vring_used_flags_set_bit(VuVirtq *vq, int mask)
 {
--=20
MST


