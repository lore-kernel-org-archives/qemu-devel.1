Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C211C5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6842076E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6842076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEU90-0000Pd-GC
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 04:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jEU85-000808-3Y
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1jEU83-0005IN-AK
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:32:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:46255)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1jEU83-00040T-0c
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:32:43 -0400
IronPort-SDR: eWxcqK4N6oUYBLXzpsJNnBAW8NUGeLRfsI+Lbz/kNn7JBvgjuCWzZguCXR+dkq0Nfyewes/vXt
 P92T6N+myyvg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2020 01:32:33 -0700
IronPort-SDR: ouvqwv44+YEd0nUH2IF+6YFxEFtZEwpph+fo9GD+Fa+jHzx0yZn7tWVfcgyGd+QhYUDjGmj4n8
 qZ2VpW6WZpJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,566,1574150400"; d="scan'208";a="444090113"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2020 01:32:31 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH v2 1/2] net/colo-compare.c: Expose "compare_timeout" to users
Date: Wed, 18 Mar 2020 16:23:19 +0800
Message-Id: <20200318082320.20768-2-chen.zhang@intel.com>
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

The "compare_timeout" determines the maximum time to hold the primary net packet.
This patch expose the "compare_timeout", make user have ability to
adjest the value according to application scenarios.

QMP command demo:
    { "execute": "qom-get",
         "arguments": { "path": "/objects/comp0",
                        "property": "compare_timeout" } }

    { "execute": "qom-set",
         "arguments": { "path": "/objects/comp0",
                        "property": "compare_timeout",
                        "value": 5000} }

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 net/colo-compare.c | 47 ++++++++++++++++++++++++++++++++++++++++++++--
 qemu-options.hx    |  8 +++++---
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 7ee17f2cf8..ec09b2a524 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -50,6 +50,7 @@ static NotifierList colo_compare_notifiers =
 
 /* TODO: Should be configurable */
 #define REGULAR_PACKET_CHECK_MS 3000
+#define DEFAULT_TIME_OUT_MS 3000
 
 static QemuMutex event_mtx;
 static QemuCond event_complete_cond;
@@ -92,6 +93,7 @@ typedef struct CompareState {
     SocketReadState sec_rs;
     SocketReadState notify_rs;
     bool vnet_hdr;
+    uint32_t compare_timeout;
 
     /*
      * Record the connection that through the NIC
@@ -607,10 +609,9 @@ static int colo_old_packet_check_one_conn(Connection *conn,
                                           CompareState *s)
 {
     GList *result = NULL;
-    int64_t check_time = REGULAR_PACKET_CHECK_MS;
 
     result = g_queue_find_custom(&conn->primary_list,
-                                 &check_time,
+                                 &s->compare_timeout,
                                  (GCompareFunc)colo_old_packet_check_one);
 
     if (result) {
@@ -984,6 +985,39 @@ static void compare_set_notify_dev(Object *obj, const char *value, Error **errp)
     s->notify_dev = g_strdup(value);
 }
 
+static void compare_get_timeout(Object *obj, Visitor *v,
+                                const char *name, void *opaque,
+                                Error **errp)
+{
+    CompareState *s = COLO_COMPARE(obj);
+    uint32_t value = s->compare_timeout;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void compare_set_timeout(Object *obj, Visitor *v,
+                                const char *name, void *opaque,
+                                Error **errp)
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
+    s->compare_timeout = value;
+
+out:
+    error_propagate(errp, local_err);
+}
+
 static void compare_pri_rs_finalize(SocketReadState *pri_rs)
 {
     CompareState *s = container_of(pri_rs, CompareState, pri_rs);
@@ -1090,6 +1124,11 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
+    if (!s->compare_timeout) {
+        /* Set default value to 3000 MS */
+        s->compare_timeout = DEFAULT_TIME_OUT_MS;
+    }
+
     if (find_and_check_chardev(&chr, s->pri_indev, errp) ||
         !qemu_chr_fe_init(&s->chr_pri_in, chr, errp)) {
         return;
@@ -1185,6 +1224,10 @@ static void colo_compare_init(Object *obj)
                             compare_get_notify_dev, compare_set_notify_dev,
                             NULL);
 
+    object_property_add(obj, "compare_timeout", "uint32",
+                        compare_get_timeout,
+                        compare_set_timeout, NULL, NULL, NULL);
+
     s->vnet_hdr = false;
     object_property_add_bool(obj, "vnet_hdr_support", compare_get_vnet_hdr,
                              compare_set_vnet_hdr, NULL);
diff --git a/qemu-options.hx b/qemu-options.hx
index 962a5ebaa6..9e48e13b26 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4615,7 +4615,7 @@ SRST
         stored. The file format is libpcap, so it can be analyzed with
         tools such as tcpdump or Wireshark.
 
-    ``-object colo-compare,id=id,primary_in=chardevid,secondary_in=chardevid,outdev=chardevid,iothread=id[,vnet_hdr_support][,notify_dev=id]``
+    ``-object colo-compare,id=id,primary_in=chardevid,secondary_in=chardevid,outdev=chardevid,iothread=id[,vnet_hdr_support][,notify_dev=id][,compare_timeout=@var{ms}]``
         Colo-compare gets packet from primary\_inchardevid and
         secondary\_inchardevid, than compare primary packet with
         secondary packet. If the packets are same, we will output
@@ -4624,8 +4624,10 @@ SRST
         outdevchardevid. In order to improve efficiency, we need to put
         the task of comparison in another thread. If it has the
         vnet\_hdr\_support flag, colo compare will send/recv packet with
-        vnet\_hdr\_len. If you want to use Xen COLO, will need the
-        notify\_dev to notify Xen colo-frame to do checkpoint.
+        vnet\_hdr\_len. Then compare\_timeout=@var{ms} determines the
+        maximum delay colo-compare wait for the packet.
+        If you want to use Xen COLO, will need the notify\_dev to
+        notify Xen colo-frame to do checkpoint.
 
         we must use it with the help of filter-mirror and
         filter-redirector.
-- 
2.17.1


