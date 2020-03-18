Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4597BC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 190BE20753
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190BE20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEUAE-00023x-9t
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 04:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jEU85-000809-5Q
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1jEU83-0005M6-Pn
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:32:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:46253)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1jEU83-0003Vo-FL
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:32:43 -0400
IronPort-SDR: jkkGYon9wY4sCxNhXGUOlUG433YTc+4S4pXh/gwSFDXbUYoI6jVeGnU5ZcxUBVzFG9MGX5Ajsf
 C23wwwx3gY0Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2020 01:32:35 -0700
IronPort-SDR: gcpwduy7/xVQ691lnH5R8vbHIhNt7AMz14haTlnXOU9HJN3WHKVeUlBGzaDvJWdOYmAzEEPNGZ
 21zkFWmLSW4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,566,1574150400"; d="scan'208";a="444090117"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2020 01:32:32 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH v2 2/2] net/colo-compare.c: Expose "expired_scan_cycle" to
 users
Date: Wed, 18 Mar 2020 16:23:20 +0800
Message-Id: <20200318082320.20768-3-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318082320.20768-1-chen.zhang@intel.com>
References: <20200318082320.20768-1-chen.zhang@intel.com>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.31
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
Cc: Daniel Cho <danielcho@qnap.com>, Zhang Chen <chen.zhang@intel.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

The "expired_scan_cycle" determines period of scanning expired
primary node net packets.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 net/colo-compare.c | 48 +++++++++++++++++++++++++++++++++++++++++++---
 qemu-options.hx    |  4 +++-
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index ec09b2a524..10c0239f9d 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -48,7 +48,6 @@ static NotifierList colo_compare_notifiers =
 #define COLO_COMPARE_FREE_PRIMARY     0x01
 #define COLO_COMPARE_FREE_SECONDARY   0x02
 
-/* TODO: Should be configurable */
 #define REGULAR_PACKET_CHECK_MS 3000
 #define DEFAULT_TIME_OUT_MS 3000
 
@@ -94,6 +93,7 @@ typedef struct CompareState {
     SocketReadState notify_rs;
     bool vnet_hdr;
     uint32_t compare_timeout;
+    uint32_t expired_scan_cycle;
 
     /*
      * Record the connection that through the NIC
@@ -823,7 +823,7 @@ static void check_old_packet_regular(void *opaque)
     /* if have old packet we will notify checkpoint */
     colo_old_packet_check(s);
     timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
-                REGULAR_PACKET_CHECK_MS);
+              s->expired_scan_cycle);
 }
 
 /* Public API, Used for COLO frame to notify compare event */
@@ -853,7 +853,7 @@ static void colo_compare_timer_init(CompareState *s)
                                 SCALE_MS, check_old_packet_regular,
                                 s);
     timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
-                    REGULAR_PACKET_CHECK_MS);
+              s->expired_scan_cycle);
 }
 
 static void colo_compare_timer_del(CompareState *s)
@@ -1018,6 +1018,39 @@ out:
     error_propagate(errp, local_err);
 }
 
+static void compare_get_expired_scan_cycle(Object *obj, Visitor *v,
+                                           const char *name, void *opaque,
+                                           Error **errp)
+{
+    CompareState *s = COLO_COMPARE(obj);
+    uint32_t value = s->expired_scan_cycle;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void compare_set_expired_scan_cycle(Object *obj, Visitor *v,
+                                           const char *name, void *opaque,
+                                           Error **errp)
+{
+    CompareState *s = COLO_COMPARE(obj);
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
+    s->expired_scan_cycle = value;
+
+out:
+    error_propagate(errp, local_err);
+}
+
 static void compare_pri_rs_finalize(SocketReadState *pri_rs)
 {
     CompareState *s = container_of(pri_rs, CompareState, pri_rs);
@@ -1129,6 +1162,11 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
         s->compare_timeout = DEFAULT_TIME_OUT_MS;
     }
 
+    if (!s->expired_scan_cycle) {
+        /* Set default value to 3000 MS */
+        s->expired_scan_cycle = REGULAR_PACKET_CHECK_MS;
+    }
+
     if (find_and_check_chardev(&chr, s->pri_indev, errp) ||
         !qemu_chr_fe_init(&s->chr_pri_in, chr, errp)) {
         return;
@@ -1228,6 +1266,10 @@ static void colo_compare_init(Object *obj)
                         compare_get_timeout,
                         compare_set_timeout, NULL, NULL, NULL);
 
+    object_property_add(obj, "expired_scan_cycle", "uint32",
+                        compare_get_expired_scan_cycle,
+                        compare_set_expired_scan_cycle, NULL, NULL, NULL);
+
     s->vnet_hdr = false;
     object_property_add_bool(obj, "vnet_hdr_support", compare_get_vnet_hdr,
                              compare_set_vnet_hdr, NULL);
diff --git a/qemu-options.hx b/qemu-options.hx
index 9e48e13b26..16debd03cb 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4615,7 +4615,7 @@ SRST
         stored. The file format is libpcap, so it can be analyzed with
         tools such as tcpdump or Wireshark.
 
-    ``-object colo-compare,id=id,primary_in=chardevid,secondary_in=chardevid,outdev=chardevid,iothread=id[,vnet_hdr_support][,notify_dev=id][,compare_timeout=@var{ms}]``
+    ``-object colo-compare,id=id,primary_in=chardevid,secondary_in=chardevid,outdev=chardevid,iothread=id[,vnet_hdr_support][,notify_dev=id][,compare_timeout=@var{ms}][,expired_scan_cycle=@var{ms}``
         Colo-compare gets packet from primary\_inchardevid and
         secondary\_inchardevid, than compare primary packet with
         secondary packet. If the packets are same, we will output
@@ -4626,6 +4626,8 @@ SRST
         vnet\_hdr\_support flag, colo compare will send/recv packet with
         vnet\_hdr\_len. Then compare\_timeout=@var{ms} determines the
         maximum delay colo-compare wait for the packet.
+        The expired\_scan\_cycle=@var{ms} to set the period of scanning
+        expired primary node network packets.
         If you want to use Xen COLO, will need the notify\_dev to
         notify Xen colo-frame to do checkpoint.
 
-- 
2.17.1


