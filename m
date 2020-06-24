Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5143C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 01:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D091206EB
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 01:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D091206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnuIY-0001VG-OX
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 21:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jnuGz-0000EQ-Qj
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 21:32:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:58217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jnuGx-0002af-AD
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 21:32:21 -0400
IronPort-SDR: LuR3P0MInfLU/J8JRRzRzfYJsD0yGjEwnLgS15mw/r4GKtJeRQ2nwn12vw+GQnxCWqF9dfue8H
 2kAY6rkWJJ0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="144319727"
X-IronPort-AV: E=Sophos;i="5.75,273,1589266800"; d="scan'208";a="144319727"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2020 18:32:14 -0700
IronPort-SDR: VoDCI8H/nIAzDa+L1ilJIv3Jh9WOK+9LOqnTDOrbiA5SJoIi/Q6m2Bi9INrZ7OyBMNa3fmCsD6
 3Pngvc01kDlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,273,1589266800"; d="scan'208";a="301458055"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by fmsmga004.fm.intel.com with ESMTP; 23 Jun 2020 18:32:12 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V2 1/2] net/colo-compare.c: Expose compare "max_queue_size" to
 users
Date: Wed, 24 Jun 2020 09:20:41 +0800
Message-Id: <20200624012042.29355-2-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624012042.29355-1-chen.zhang@intel.com>
References: <20200624012042.29355-1-chen.zhang@intel.com>
Received-SPF: pass client-ip=134.134.136.65; envelope-from=chen.zhang@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 21:32:13
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, FROM_ADDR_WS=1,
 FROM_WSP_TRAIL=1, HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Zhang Chen <chen.zhang@intel.com>, qemu-dev <qemu-devel@nongnu.org>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

This patch allow users to set the "max_queue_size" according
to their environment.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 net/colo-compare.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 qemu-options.hx    |  5 +++--
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index f15779dedc..ed9cf5d3c4 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -59,6 +59,7 @@ static bool colo_compare_active;
 static QemuMutex event_mtx;
 static QemuCond event_complete_cond;
 static int event_unhandled_count;
+static uint32_t max_queue_size;
 
 /*
  *  + CompareState ++
@@ -222,7 +223,7 @@ static void fill_pkt_tcp_info(void *data, uint32_t *max_ack)
  */
 static int colo_insert_packet(GQueue *queue, Packet *pkt, uint32_t *max_ack)
 {
-    if (g_queue_get_length(queue) <= MAX_QUEUE_SIZE) {
+    if (g_queue_get_length(queue) <= max_queue_size) {
         if (pkt->ip->ip_p == IPPROTO_TCP) {
             fill_pkt_tcp_info(pkt, max_ack);
             g_queue_insert_sorted(queue,
@@ -1144,6 +1145,37 @@ out:
     error_propagate(errp, local_err);
 }
 
+static void get_max_queue_size(Object *obj, Visitor *v,
+                               const char *name, void *opaque,
+                               Error **errp)
+{
+    uint32_t value = max_queue_size;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void set_max_queue_size(Object *obj, Visitor *v,
+                               const char *name, void *opaque,
+                               Error **errp)
+{
+    Error *local_err = NULL;
+    uint32_t value;
+
+    visit_type_uint32(v, name, &value, &local_err);
+    if (local_err) {
+        goto out;
+    }
+    if (!value) {
+        error_setg(&local_err, "Property '%s.%s' requires a positive value",
+                   object_get_typename(obj), name);
+        goto out;
+    }
+    max_queue_size = value;
+
+out:
+    error_propagate(errp, local_err);
+}
+
 static void compare_pri_rs_finalize(SocketReadState *pri_rs)
 {
     CompareState *s = container_of(pri_rs, CompareState, pri_rs);
@@ -1261,6 +1293,11 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
         s->expired_scan_cycle = REGULAR_PACKET_CHECK_MS;
     }
 
+    if (!max_queue_size) {
+        /* Set default queue size to 1024 */
+        max_queue_size = MAX_QUEUE_SIZE;
+    }
+
     if (find_and_check_chardev(&chr, s->pri_indev, errp) ||
         !qemu_chr_fe_init(&s->chr_pri_in, chr, errp)) {
         return;
@@ -1380,6 +1417,10 @@ static void colo_compare_init(Object *obj)
                         compare_get_expired_scan_cycle,
                         compare_set_expired_scan_cycle, NULL, NULL);
 
+    object_property_add(obj, "max_queue_size", "uint32",
+                        get_max_queue_size,
+                        set_max_queue_size, NULL, NULL);
+
     s->vnet_hdr = false;
     object_property_add_bool(obj, "vnet_hdr_support", compare_get_vnet_hdr,
                              compare_set_vnet_hdr);
diff --git a/qemu-options.hx b/qemu-options.hx
index 93bde2bbc8..3ee19a4b0d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4639,7 +4639,7 @@ SRST
         stored. The file format is libpcap, so it can be analyzed with
         tools such as tcpdump or Wireshark.
 
-    ``-object colo-compare,id=id,primary_in=chardevid,secondary_in=chardevid,outdev=chardevid,iothread=id[,vnet_hdr_support][,notify_dev=id][,compare_timeout=@var{ms}][,expired_scan_cycle=@var{ms}``
+    ``-object colo-compare,id=id,primary_in=chardevid,secondary_in=chardevid,outdev=chardevid,iothread=id[,vnet_hdr_support][,notify_dev=id][,compare_timeout=@var{ms}][,expired_scan_cycle=@var{ms}][,max_queue_size=@var{size}]``
         Colo-compare gets packet from primary\_inchardevid and
         secondary\_inchardevid, than compare primary packet with
         secondary packet. If the packets are same, we will output
@@ -4651,7 +4651,8 @@ SRST
         vnet\_hdr\_len. Then compare\_timeout=@var{ms} determines the
         maximum delay colo-compare wait for the packet.
         The expired\_scan\_cycle=@var{ms} to set the period of scanning
-        expired primary node network packets.
+        expired primary node network packets. The max\_queue\_size=@var{size}
+        is to set the max compare queue size depend on user environment.
         If you want to use Xen COLO, will need the notify\_dev to
         notify Xen colo-frame to do checkpoint.
 
-- 
2.17.1


