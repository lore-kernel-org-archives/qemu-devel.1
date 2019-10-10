Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DD9C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB2FF2064A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="f2Y3EBWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2FF2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXmz-0002OI-CI
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iIXIg-0005gU-UB
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iIXIf-00024D-LF
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:12:10 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:37745)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iIXIf-00023j-6o
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:12:09 -0400
Received: by mail-ed1-x544.google.com with SMTP id r4so5246975edy.4
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 05:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=O05afTw00yJcZG1EFAC8CfJufdnfwcI7yyhOpKWurQA=;
 b=f2Y3EBWtW39HjwSfQ/iRVm976oQ6/A+jwY6KSpbBmLkStIy6559VgbSvd+ZxtCIC+e
 kYcpSJ5zQU6PhDCDOHOSain23mqP3zw70LYZ5fmYIM59R0gAFkQspUQDQmG+wvSXQ5Lp
 /+KD0TO6j6dSRHSxTe9uCGXc06fHFfHoklHGKZWAldHIgVl8jI8nvzrM5Sxelcw84gri
 ePID/2Hl/0AxIkNilJyH8RTi9NX9Tzrw7hpLNvdp/gs3fqRMsZVVufe9hm6wePN7+JRJ
 wE4ET34pdwPnNfX8B6qlALn9taxr5U1QOyMomd6wo6NFedZufQ4M2CvJA31ZdlSFS206
 6RsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=O05afTw00yJcZG1EFAC8CfJufdnfwcI7yyhOpKWurQA=;
 b=D4Z/+9QnvfHaXMOVLM5EKaIT5qu38mD5K23VNcQpmrE1Y301NPsmG4nLgOBAp2w239
 YV/au9uHUz98FNf/7pp1GK8Z/0JJdiVVrUiOJy41p4Da0rwr+WjdlebJfq4goYojFwmc
 z7+b7ibMb7vcPVJZLhTfp0MOEyQntCQCG/bGcXXJaRNM7976aa8MpF8hsCVwb6tUls9D
 RCPAA3a7Am/0sf1gkp0NvPZpwElI/NdK/TEikr/VkVm1OFyjGQpcgBZhKxwvKhYZzso6
 i/ZCKLpuqB0Ij2fybMN/Vquh1rIq9vk6BG93h1jFSpCU67n/xg7mEJiPbdZZv0C523B4
 3JKg==
X-Gm-Message-State: APjAAAUUsbZiXkHt3wl3JeusJH1gqLr3V6/Stdkgv4djyQHDx+s5r8nb
 8+FMNQHhBU8EE+BlTmmDm9VHPBL/nE4=
X-Google-Smtp-Source: APXvYqwQa6RxW1XPv+X3yDdM8QYFtxTI9MY7LgAje4I6iuThRWfn4ULgs6cwWUz/5RGzRvUmZq5yIQ==
X-Received: by 2002:a50:afa1:: with SMTP id h30mr7733758edd.126.1570709527019; 
 Thu, 10 Oct 2019 05:12:07 -0700 (PDT)
Received: from msennikovskii2.pb.local
 ([2001:1438:4010:2558:31c1:ae55:82cf:3681])
 by smtp.googlemail.com with ESMTPSA id c22sm949157edc.9.2019.10.10.05.12.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 10 Oct 2019 05:12:06 -0700 (PDT)
From: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
To: qemu-devel@nongnu.org, jasowang@redhat.com, stefanha@redhat.com,
 mst@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v3] virtio-net: prevent offloads reset on migration
Date: Thu, 10 Oct 2019 14:11:15 +0200
Message-Id: <1570709475-32073-2-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570709475-32073-1-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
References: <1570709475-32073-1-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
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
What happens is: first the VirtIONet::curr_guest_offloads gets restored
and offloads are getting set correctly:

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

Fix this by making the virtio_net_set_features not reset
the curr_guest_offloads in case the VM runstate is RUN_STATE_INMIGRATE

Signed-off-by: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
---
 hw/net/virtio-net.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b9e1cd7..49be172 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -767,7 +767,14 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
     n->rsc6_enabled = virtio_has_feature(features, VIRTIO_NET_F_RSC_EXT) &&
         virtio_has_feature(features, VIRTIO_NET_F_GUEST_TSO6);
 
-    if (n->has_vnet_hdr) {
+    /*
+     * In case of RUN_STATE_INMIGRATE the virtio_net_set_features
+     * is called as part of VM state restore process.
+     * At this stage we do not want the curr_guest_offloads to be reset,
+     * i.e. want to preserve them in the same state as was set
+     * by the guest on the source machine.
+     */
+    if (n->has_vnet_hdr && !runstate_check(RUN_STATE_INMIGRATE)) {
         n->curr_guest_offloads =
             virtio_net_guest_offloads_by_features(features);
         virtio_net_apply_guest_offloads(n);
-- 
2.7.4


