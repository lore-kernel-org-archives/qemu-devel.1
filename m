Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B5AC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4CF2071E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkhGdXqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4CF2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZYCG-0004nT-BE
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 05:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXsL-0005g9-RE
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:15:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXmI-00032L-Fc
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:09:03 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:35121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prashantbhole.linux@gmail.com>)
 id 1iZXmI-00031y-9S
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:09:02 -0500
Received: by mail-pj1-x1041.google.com with SMTP id s8so8071090pji.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 02:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JOqfaTjB9hR4SvgWUY3wyefTnNCZb7GyoEbULC6AJJo=;
 b=QkhGdXqAqq10xMSu+2CnyH8h3k9xRLREYvQrc7Kl+Q0+83MDkF+tuhBxvnRiUIrU5H
 eLqXuIZUtQQQafXXx5KJYDzw+cbyREKs1xo+xDhrhWrKOz2Hfe+KnD5BCeK8L6z7FoGB
 H8uL0SKa0QBz+PC6YnjRyHOBKKwWwEqH1f4T41+MgFl+QMvSklHCyhIdh8muKtDnfRAe
 wnppauQ8mL6ut7U+3hHZwdGgDP61KM8PE2qspO4rG1wmunzRjivSxjNu6ss3SQdisLdS
 3CD2OlXrfUF8AsknNCn14UV/RDnRG4uS2zPqKLV30IbvCAr64AsnlplUmR+oN2N7ka5Y
 wSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JOqfaTjB9hR4SvgWUY3wyefTnNCZb7GyoEbULC6AJJo=;
 b=r1HQErNXhMJuAqWRgQHy3zA/D8NjN9+wDLpajNoQONnS+bcXXGnu6qxHpmZ+ezWu5J
 PRAIcp4lB6zAhtdu4PwcixuAJ9dmriplIHLJoqexqwPP/mAXL4QYQPluDi4UymdLUFuQ
 geTEEdijM+9LnWrkL/9LwcOl3W2Ocrp/cDdK7SuIOjjIBhBC+YZJzNDc4vCwrvr1FAjA
 K+zf0kqcuygRA7nyj2Gv/uJtTzgg+a2/0SgJFUIfAFmlH0JGo87/4B5KvHpxvF8qXiTS
 yygvEG4S1jdQZUgKJGmi1QbUOAO1y1IiK1W/Ijl/zHXXw8YJ7Zvj5YTyR1O3BbTIH1rv
 +SQA==
X-Gm-Message-State: APjAAAUZF+DiX07ZkvyDEwMtz4Y8LPLxgd5eZpeg2JD8LUkaj8hcgJ+d
 OWWDqZ0Y0ENpSeX7EkSeFseDnnaz
X-Google-Smtp-Source: APXvYqwPyv6+pc3DP4PZm1a3x96MwS0Kc6f03xdB6l2+mtJteT+8mFJPIbbpCn/sngodhdsZCCyQtA==
X-Received: by 2002:a17:90b:f0c:: with SMTP id
 br12mr5745156pjb.67.1574762941343; 
 Tue, 26 Nov 2019 02:09:01 -0800 (PST)
Received: from localhost.localdomain ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id s24sm11848485pfh.108.2019.11.26.02.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 02:09:00 -0800 (PST)
From: Prashant Bhole <prashantbhole.linux@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [RFC net-next 05/18] vhost_net: user tap recvmsg api to access ptr
 ring
Date: Tue, 26 Nov 2019 19:07:31 +0900
Message-Id: <20191126100744.5083-6-prashantbhole.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: Song Liu <songliubraving@fb.com>,
 Jakub Kicinski <jakub.kicinski@netronome.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, qemu-devel@nongnu.org,
 Prashant Bhole <prashantbhole.linux@gmail.com>, kvm@vger.kernel.org,
 Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
 Martin KaFai Lau <kafai@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently vhost_net directly accesses ptr ring of tap driver to
fetch Rx packet pointers. In order to avoid it this patch modifies
tap driver's recvmsg api to do additional task of fetching Rx packet
pointers.

A special struct tun_msg_ctl is already being passed via msg_control
for tun Rx XDP batching. This patch extends tun_msg_ctl usage to
send sub commands to recvmsg api. Now tun_recvmsg will handle commands
to consume and unconsume packet pointers from ptr ring.

This will be useful in implementation of virtio-net XDP offload
feature, where packets will be XDP processed before they are passed
to vhost_net.

Signed-off-by: Prashant Bhole <prashantbhole.linux@gmail.com>
---
 drivers/net/tap.c      | 22 ++++++++++++++++++-
 drivers/net/tun.c      | 24 ++++++++++++++++++++-
 drivers/vhost/net.c    | 48 +++++++++++++++++++++++++++++++-----------
 include/linux/if_tun.h | 18 ++++++++++++++++
 4 files changed, 98 insertions(+), 14 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 4df7bf00af66..8635cdfd7aa4 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1234,8 +1234,28 @@ static int tap_recvmsg(struct socket *sock, struct msghdr *m,
 		       size_t total_len, int flags)
 {
 	struct tap_queue *q = container_of(sock, struct tap_queue, sock);
-	struct sk_buff *skb = m->msg_control;
+	struct tun_msg_ctl *ctl = m->msg_control;
+	struct sk_buff *skb = NULL;
 	int ret;
+
+	if (ctl) {
+		switch (ctl->type) {
+		case TUN_MSG_PKT:
+			skb = ctl->ptr;
+			break;
+		case TUN_MSG_CONSUME_PKTS:
+			return ptr_ring_consume_batched(&q->ring,
+							ctl->ptr,
+							ctl->num);
+		case TUN_MSG_UNCONSUME_PKTS:
+			ptr_ring_unconsume(&q->ring, ctl->ptr, ctl->num,
+					   tun_ptr_free);
+			return 0;
+		default:
+			return -EINVAL;
+		}
+	}
+
 	if (flags & ~(MSG_DONTWAIT|MSG_TRUNC)) {
 		kfree_skb(skb);
 		return -EINVAL;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 1e436d9ec4e1..4f28f2387435 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2577,7 +2577,8 @@ static int tun_recvmsg(struct socket *sock, struct msghdr *m, size_t total_len,
 {
 	struct tun_file *tfile = container_of(sock, struct tun_file, socket);
 	struct tun_struct *tun = tun_get(tfile);
-	void *ptr = m->msg_control;
+	struct tun_msg_ctl *ctl = m->msg_control;
+	void *ptr = NULL;
 	int ret;
 
 	if (!tun) {
@@ -2585,6 +2586,27 @@ static int tun_recvmsg(struct socket *sock, struct msghdr *m, size_t total_len,
 		goto out_free;
 	}
 
+	if (ctl) {
+		switch (ctl->type) {
+		case TUN_MSG_PKT:
+			ptr = ctl->ptr;
+			break;
+		case TUN_MSG_CONSUME_PKTS:
+			ret = ptr_ring_consume_batched(&tfile->tx_ring,
+						       ctl->ptr,
+						       ctl->num);
+			goto out;
+		case TUN_MSG_UNCONSUME_PKTS:
+			ptr_ring_unconsume(&tfile->tx_ring, ctl->ptr,
+					   ctl->num, tun_ptr_free);
+			ret = 0;
+			goto out;
+		default:
+			ret = -EINVAL;
+			goto out_put_tun;
+		}
+	}
+
 	if (flags & ~(MSG_DONTWAIT|MSG_TRUNC|MSG_ERRQUEUE)) {
 		ret = -EINVAL;
 		goto out_put_tun;
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 1a2dd53caade..0f91b374a558 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -175,24 +175,44 @@ static void *vhost_net_buf_consume(struct vhost_net_buf *rxq)
 
 static int vhost_net_buf_produce(struct vhost_net_virtqueue *nvq)
 {
+	struct vhost_virtqueue *vq = &nvq->vq;
+	struct socket *sock = vq->private_data;
 	struct vhost_net_buf *rxq = &nvq->rxq;
+	struct tun_msg_ctl ctl = {
+		.type = TUN_MSG_CONSUME_PKTS,
+		.ptr = (void *) rxq->queue,
+		.num = VHOST_NET_BATCH,
+	};
+	struct msghdr msg = {
+		.msg_control = &ctl,
+	};
 
 	rxq->head = 0;
-	rxq->tail = ptr_ring_consume_batched(nvq->rx_ring, rxq->queue,
-					      VHOST_NET_BATCH);
+	rxq->tail = sock->ops->recvmsg(sock, &msg, 0, 0);
+	if (WARN_ON_ONCE(rxq->tail < 0))
+		rxq->tail = 0;
+
 	return rxq->tail;
 }
 
 static void vhost_net_buf_unproduce(struct vhost_net_virtqueue *nvq)
 {
+	struct vhost_virtqueue *vq = &nvq->vq;
+	struct socket *sock = vq->private_data;
 	struct vhost_net_buf *rxq = &nvq->rxq;
+	struct tun_msg_ctl ctl = {
+		.type = TUN_MSG_UNCONSUME_PKTS,
+		.ptr = (void *) (rxq->queue + rxq->head),
+		.num = vhost_net_buf_get_size(rxq),
+	};
+	struct msghdr msg = {
+		.msg_control = &ctl,
+	};
 
-	if (nvq->rx_ring && !vhost_net_buf_is_empty(rxq)) {
-		ptr_ring_unconsume(nvq->rx_ring, rxq->queue + rxq->head,
-				   vhost_net_buf_get_size(rxq),
-				   tun_ptr_free);
-		rxq->head = rxq->tail = 0;
-	}
+	if (!vhost_net_buf_is_empty(rxq))
+		sock->ops->recvmsg(sock, &msg, 0, 0);
+
+	rxq->head = rxq->tail = 0;
 }
 
 static int vhost_net_buf_peek_len(void *ptr)
@@ -1109,6 +1129,7 @@ static void handle_rx(struct vhost_net *net)
 		.flags = 0,
 		.gso_type = VIRTIO_NET_HDR_GSO_NONE
 	};
+	struct tun_msg_ctl ctl;
 	size_t total_len = 0;
 	int err, mergeable;
 	s16 headcount;
@@ -1166,8 +1187,11 @@ static void handle_rx(struct vhost_net *net)
 			goto out;
 		}
 		busyloop_intr = false;
-		if (nvq->rx_ring)
-			msg.msg_control = vhost_net_buf_consume(&nvq->rxq);
+		if (nvq->rx_ring) {
+			ctl.type = TUN_MSG_PKT;
+			ctl.ptr = vhost_net_buf_consume(&nvq->rxq);
+			msg.msg_control = &ctl;
+		}
 		/* On overrun, truncate and discard */
 		if (unlikely(headcount > UIO_MAXIOV)) {
 			iov_iter_init(&msg.msg_iter, READ, vq->iov, 1, 1);
@@ -1346,8 +1370,8 @@ static struct socket *vhost_net_stop_vq(struct vhost_net *n,
 	mutex_lock(&vq->mutex);
 	sock = vq->private_data;
 	vhost_net_disable_vq(n, vq);
-	vq->private_data = NULL;
 	vhost_net_buf_unproduce(nvq);
+	vq->private_data = NULL;
 	nvq->rx_ring = NULL;
 	mutex_unlock(&vq->mutex);
 	return sock;
@@ -1538,8 +1562,8 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 		}
 
 		vhost_net_disable_vq(n, vq);
-		vq->private_data = sock;
 		vhost_net_buf_unproduce(nvq);
+		vq->private_data = sock;
 		r = vhost_vq_init_access(vq);
 		if (r)
 			goto err_used;
diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
index 5bda8cf457b6..bb94843e3829 100644
--- a/include/linux/if_tun.h
+++ b/include/linux/if_tun.h
@@ -11,8 +11,26 @@
 
 #define TUN_XDP_FLAG 0x1UL
 
+/*
+ * tun_msg_ctl types
+ */
+
 #define TUN_MSG_UBUF 1
 #define TUN_MSG_PTR  2
+/*
+ * Used for passing a packet pointer from vhost to tun
+ */
+#define TUN_MSG_PKT  3
+/*
+ * Used for passing an array of pointer from vhost to tun.
+ * tun consumes packets from ptr ring and stores in pointer array.
+ */
+#define TUN_MSG_CONSUME_PKTS    4
+/*
+ * Used for passing an array of pointer from vhost to tun.
+ * tun consumes get pointer from array and puts back into ptr ring.
+ */
+#define TUN_MSG_UNCONSUME_PKTS  5
 struct tun_msg_ctl {
 	unsigned short type;
 	unsigned short num;
-- 
2.20.1


