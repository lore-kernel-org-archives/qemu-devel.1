Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99284C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F062087E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F062087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6A3-0002xD-2L
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5pc-0001Mn-E0
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5pZ-0002Ru-8W
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48068
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iS5pY-00026i-Nl; Tue, 05 Nov 2019 15:53:36 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA5KpX12040540; Tue, 5 Nov 2019 15:53:16 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3eegm8tg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:15 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xA5KqfIU042871;
 Tue, 5 Nov 2019 15:53:15 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3eegm8t7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:15 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA5KnxfZ018313;
 Tue, 5 Nov 2019 20:53:18 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma01wdc.us.ibm.com with ESMTP id 2w11e7177p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 20:53:18 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xA5KrE2G54264224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2019 20:53:14 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 816D612405B;
 Tue,  5 Nov 2019 20:53:14 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B7FB124058;
 Tue,  5 Nov 2019 20:53:14 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2019 20:53:14 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 48/55] virtio-net: prevent offloads reset on migration
Date: Tue,  5 Nov 2019 14:52:36 -0600
Message-Id: <20191105205243.3766-49-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
References: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-05_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050170
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: Jason Wang <jasowang@redhat.com>,
 Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>

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

Cc: qemu-stable@nongnu.org
Signed-off-by: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 7788c3f2e21e35902d45809b236791383bbb613e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/virtio-net.c            | 27 ++++++++++++++++++++++++---
 include/hw/virtio/virtio-net.h |  2 ++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b9e1cd71cf..6adb0fe252 100644
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
index b96f0c643f..07a9319f4b 100644
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
2.17.1


