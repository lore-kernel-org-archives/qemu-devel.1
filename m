Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49919C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E9A20679
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="brjyj0pQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E9A20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvfG-0000YR-3w
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 10:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iIvRG-0008Gr-Ef
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iIvRF-0000Xv-0l
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:58:38 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:39270)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iIvRE-0000Xb-Om
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:58:36 -0400
Received: by mail-ed1-x542.google.com with SMTP id a15so8767190edt.6
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nNPD57i+zdP3HSzedsX84NREYpBQ/HXdziN+13fyCCQ=;
 b=brjyj0pQCvV4N1+yy5EwxCMUOSFqyqdMeQnXYvYdMnTiEQsca4UC2rGkVK2n8VGTCn
 /PLYWLHyVI5yrrPpcgHHjWm1suxNwoZn0r897Ta2OKFRmPLHngH7TkuVNdzAcq+2MskF
 uzGsJ8I2pcmlI4uksh/y14TcGUgITiDZEczZDswWiTmnM3txR4L+B+ICT7lGxJwxLwn5
 WsHfy4oYq5g44N6WASeoUJGW+2FNqm9BrHUytnf6oovl3kuuFh/0XSNsx24ptpOvHtkg
 FXE7xwAFP3Km70R4cuu1DfnwZGjlxWRwgVMt1tHMrJR3HTpOLENNPHFJLmn/HKGmtdk1
 +Bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nNPD57i+zdP3HSzedsX84NREYpBQ/HXdziN+13fyCCQ=;
 b=nIcgHz8wxLfr4ZolGGS9CJYe2nCZeq24+nr/Mn02oqxY2m0A4CCaObAASYRJqPs+vy
 vUeOtIqDvHs3CPZQSxKyvRBFntCnPYLVrvA6scypLtMKuFuhzqeWtIKuruxDUOntqCCR
 0w9wS/9KGFd0cmJ1sGrPscBsPZSiebENB6s/GtJ/qnT/AXXlwuSZMH+WyXbvszcjZaes
 fRC6cig+fOnY5eZHdT9bOQFOaIT4Di6w7P/o2ajApzrisvEvCILdDz1DLhe1vl0m/z37
 Lw0CIf5yHBDgd8lIGMtPqz/8N7MeZJ5UOuhdTuR9+Wok8eR2nVUwfEN/CS2s/SEqgV8L
 d65Q==
X-Gm-Message-State: APjAAAXmc3PzdwKKinbKyC0AB5ZNN0d/6DbfpubD5aPRRrA4BWwNBMKh
 YqxM6nat3scjCVTTit0KYEqntQ==
X-Google-Smtp-Source: APXvYqwpj+rnC0j9t1hvN8td1G/OYp4PoDR0Sw0ZDRUAOhw9Ox3IxA0sAeKwMIdXMHoSx35eKR0Pnw==
X-Received: by 2002:a17:906:3385:: with SMTP id
 v5mr13914224eja.154.1570802315775; 
 Fri, 11 Oct 2019 06:58:35 -0700 (PDT)
Received: from msennikovskii2.pb.local
 ([2001:1438:4010:2558:9cc:2ca5:45db:2acf])
 by smtp.googlemail.com with ESMTPSA id 36sm1547982edz.92.2019.10.11.06.58.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 11 Oct 2019 06:58:34 -0700 (PDT)
From: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com, dgilbert@redhat.com, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 2/2] virtio-net: prevent offloads reset on migration
Date: Fri, 11 Oct 2019 15:58:04 +0200
Message-Id: <1570802284-3064-2-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570802284-3064-1-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
References: <1570802284-3064-1-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
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
Cc: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently offloads disabled by guest via the VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET
command are not preserved on VM migration.
Instead all offloads reported by guest features (via VIRTIO_PCI_GUEST_FEATURES)
get enabled.
What happens is: first the VirtIONet::curr_guest_offloads gets restored and offloads
are getting set correctly:

 #0  qemu_set_offload (nc=0x555556a11400, csum=1, tso4=0, tso6=0, ecn=0, ufo=0) at net/net.c:474
 #1  virtio_net_apply_guest_offloads (n=0x555557701ca0) at hw/net/virtio-net.c:720
 #2  virtio_net_post_load_device (opaque=0x555557701ca0, version_id=11) at hw/net/virtio-net.c:2334
 #3  vmstate_load_state (f=0x5555569dc010, vmsd=0x555556577c80 <vmstate_virtio_net_device>, opaque=0x555557701ca0, version_id=11)
     at migration/vmstate.c:168
 #4  virtio_load (vdev=0x555557701ca0, f=0x5555569dc010, version_id=11) at hw/virtio/virtio.c:2197
 #5  virtio_device_get (f=0x5555569dc010, opaque=0x555557701ca0, size=0, field=0x55555668cd00 <__compound_literal.5>) at hw/virtio/virtio.c:2036
 #6  vmstate_load_state (f=0x5555569dc010, vmsd=0x555556577ce0 <vmstate_virtio_net>, opaque=0x555557701ca0, version_id=11) at migration/vmstate.c:143
 #7  vmstate_load (f=0x5555569dc010, se=0x5555578189e0) at migration/savevm.c:829
 #8  qemu_loadvm_section_start_full (f=0x5555569dc010, mis=0x5555569eee20) at migration/savevm.c:2211
 #9  qemu_loadvm_state_main (f=0x5555569dc010, mis=0x5555569eee20) at migration/savevm.c:2395
 #10 qemu_loadvm_state (f=0x5555569dc010) at migration/savevm.c:2467
 #11 process_incoming_migration_co (opaque=0x0) at migration/migration.c:449

However later on the features are getting restored, and offloads get reset to
everything supported by features:

 #0  qemu_set_offload (nc=0x555556a11400, csum=1, tso4=1, tso6=1, ecn=0, ufo=0) at net/net.c:474
 #1  virtio_net_apply_guest_offloads (n=0x555557701ca0) at hw/net/virtio-net.c:720
 #2  virtio_net_set_features (vdev=0x555557701ca0, features=5104441767) at hw/net/virtio-net.c:773
 #3  virtio_set_features_nocheck (vdev=0x555557701ca0, val=5104441767) at hw/virtio/virtio.c:2052
 #4  virtio_load (vdev=0x555557701ca0, f=0x5555569dc010, version_id=11) at hw/virtio/virtio.c:2220
 #5  virtio_device_get (f=0x5555569dc010, opaque=0x555557701ca0, size=0, field=0x55555668cd00 <__compound_literal.5>) at hw/virtio/virtio.c:2036
 #6  vmstate_load_state (f=0x5555569dc010, vmsd=0x555556577ce0 <vmstate_virtio_net>, opaque=0x555557701ca0, version_id=11) at migration/vmstate.c:143
 #7  vmstate_load (f=0x5555569dc010, se=0x5555578189e0) at migration/savevm.c:829
 #8  qemu_loadvm_section_start_full (f=0x5555569dc010, mis=0x5555569eee20) at migration/savevm.c:2211
 #9  qemu_loadvm_state_main (f=0x5555569dc010, mis=0x5555569eee20) at migration/savevm.c:2395
 #10 qemu_loadvm_state (f=0x5555569dc010) at migration/savevm.c:2467
 #11 process_incoming_migration_co (opaque=0x0) at migration/migration.c:449

Fix this by preserving the state in saved_guest_offloads field and
pushing out offload initialization to the new post load hook.

Signed-off-by: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
---
 hw/net/virtio-net.c            | 27 ++++++++++++++++++++++++---
 include/hw/virtio/virtio-net.h |  2 ++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b9e1cd7..6adb0fe 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2330,9 +2330,13 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
         n->curr_guest_offloads = virtio_net_supported_guest_offloads(n);
     }
 
-    if (peer_has_vnet_hdr(n)) {
-        virtio_net_apply_guest_offloads(n);
-    }
+    /*
+     * curr_guest_offloads will be later overwritten by the
+     * virtio_set_features_nocheck call done from the virtio_load.
+     * Here we make sure it is preserved and restored accordingly
+     * in the virtio_net_post_load_virtio callback.
+     */
+    n->saved_guest_offloads = n->curr_guest_offloads;
 
     virtio_net_set_queues(n);
 
@@ -2367,6 +2371,22 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
     return 0;
 }
 
+static int virtio_net_post_load_virtio(VirtIODevice *vdev)
+{
+    VirtIONet *n = VIRTIO_NET(vdev);
+    /*
+     * The actual needed state is now in saved_guest_offloads,
+     * see virtio_net_post_load_device for detail.
+     * Restore it back and apply the desired offloads.
+     */
+    n->curr_guest_offloads = n->saved_guest_offloads;
+    if (peer_has_vnet_hdr(n)) {
+        virtio_net_apply_guest_offloads(n);
+    }
+
+    return 0;
+}
+
 /* tx_waiting field of a VirtIONetQueue */
 static const VMStateDescription vmstate_virtio_net_queue_tx_waiting = {
     .name = "virtio-net-queue-tx_waiting",
@@ -2909,6 +2929,7 @@ static void virtio_net_class_init(ObjectClass *klass, void *data)
     vdc->guest_notifier_mask = virtio_net_guest_notifier_mask;
     vdc->guest_notifier_pending = virtio_net_guest_notifier_pending;
     vdc->legacy_features |= (0x1 << VIRTIO_NET_F_GSO);
+    vdc->post_load = virtio_net_post_load_virtio;
     vdc->vmsd = &vmstate_virtio_net_device;
 }
 
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index b96f0c6..07a9319 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -182,6 +182,8 @@ struct VirtIONet {
     char *netclient_name;
     char *netclient_type;
     uint64_t curr_guest_offloads;
+    /* used on saved state restore phase to preserve the curr_guest_offloads */
+    uint64_t saved_guest_offloads;
     AnnounceTimer announce_timer;
     bool needs_vnet_hdr_swap;
     bool mtu_bypass_backend;
-- 
2.7.4


