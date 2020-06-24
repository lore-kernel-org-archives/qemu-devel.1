Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E0CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 07:54:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09C52085B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 07:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09C52085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo0EJ-0006LP-Vu
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 03:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jo0D8-0004U6-Ci
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 03:52:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jo0D4-0006er-8q
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 03:52:45 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05O7YUWp159575
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 03:52:40 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31ux0a6y9q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 03:52:40 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05O7YcoJ160161
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 03:52:39 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31ux0a6y94-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2020 03:52:39 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05O7poBM028302;
 Wed, 24 Jun 2020 07:52:37 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma06ams.nl.ibm.com with ESMTP id 31uusjgbdv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2020 07:52:37 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05O7qZw258720292
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2020 07:52:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5260FA4053;
 Wed, 24 Jun 2020 07:52:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B700CA404D;
 Wed, 24 Jun 2020 07:52:34 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jun 2020 07:52:34 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 02/12] pc-bios: s390x: Consolidate timing functions into
 time.h
Date: Wed, 24 Jun 2020 03:52:16 -0400
Message-Id: <20200624075226.92728-3-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624075226.92728-1-frankja@linux.ibm.com>
References: <20200624075226.92728-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-24_04:2020-06-24,
 2020-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 cotscore=-2147483648 clxscore=1015 bulkscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=1 priorityscore=1501 phishscore=0 mlxlogscore=910
 impostorscore=0 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240055
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:52:40
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: borntraeger@de.ibm.com, thuth@redhat.com, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's consolidate timing related functions into one header.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/menu.c        |  1 +
 pc-bios/s390-ccw/netmain.c     | 15 +++------------
 pc-bios/s390-ccw/s390-ccw.h    |  8 ++++----
 pc-bios/s390-ccw/s390-time.h   | 23 +++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-net.c  |  1 +
 pc-bios/s390-ccw/virtio-scsi.c |  1 +
 pc-bios/s390-ccw/virtio.c      | 18 +++---------------
 7 files changed, 36 insertions(+), 31 deletions(-)
 create mode 100644 pc-bios/s390-ccw/s390-time.h

diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index ce3815b201..de8260a5d6 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -12,6 +12,7 @@
 #include "libc.h"
 #include "s390-ccw.h"
 #include "sclp.h"
+#include "s390-time.h"
 
 #define KEYCODE_NO_INP '\0'
 #define KEYCODE_ESCAPE '\033'
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 309ffa30d9..f1ee63577a 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -35,6 +35,7 @@
 #include "s390-ccw.h"
 #include "cio.h"
 #include "virtio.h"
+#include "s390-time.h"
 
 #define DEFAULT_BOOT_RETRIES 10
 #define DEFAULT_TFTP_RETRIES 20
@@ -57,24 +58,14 @@ static SubChannelId net_schid = { .one = 1 };
 static uint8_t mac[6];
 static uint64_t dest_timer;
 
-static uint64_t get_timer_ms(void)
-{
-    uint64_t clk;
-
-    asm volatile(" stck %0 " : : "Q"(clk) : "memory");
-
-    /* Bit 51 is incremented each microsecond */
-    return (clk >> (63 - 51)) / 1000;
-}
-
 void set_timer(int val)
 {
-    dest_timer = get_timer_ms() + val;
+    dest_timer = get_time_ms() + val;
 }
 
 int get_timer(void)
 {
-    return dest_timer - get_timer_ms();
+    return dest_timer - get_time_ms();
 }
 
 int get_sec_ticks(void)
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 21f27e7990..fae1de363f 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -74,8 +74,6 @@ unsigned long virtio_load_direct(ulong rec_list1, ulong rec_list2,
 bool virtio_is_supported(SubChannelId schid);
 void virtio_blk_setup_device(SubChannelId schid);
 int virtio_read(ulong sector, void *load_addr);
-u64 get_clock(void);
-ulong get_second(void);
 
 /* bootmap.c */
 void zipl_load(void);
@@ -153,11 +151,13 @@ static inline void yield(void)
 
 #define MAX_SECTOR_SIZE 4096
 
+#include "s390-time.h"
+
 static inline void sleep(unsigned int seconds)
 {
-    ulong target = get_second() + seconds;
+    ulong target = get_time_seconds() + seconds;
 
-    while (get_second() < target) {
+    while (get_time_seconds() < target) {
         yield();
     }
 }
diff --git a/pc-bios/s390-ccw/s390-time.h b/pc-bios/s390-ccw/s390-time.h
new file mode 100644
index 0000000000..ed6d982371
--- /dev/null
+++ b/pc-bios/s390-ccw/s390-time.h
@@ -0,0 +1,23 @@
+#ifndef TIME_H
+#define TIME_H
+
+static inline u64 get_clock(void)
+{
+    u64 r;
+
+    asm volatile("stck %0" : "=Q" (r) : : "cc");
+    return r;
+}
+
+static inline u64 get_time_ms(void)
+{
+    /* Bit 51 is incremented each microsecond */
+    return (get_clock() >> 12) / 1000;
+}
+
+static inline u64 get_time_seconds(void)
+{
+    return get_time_ms() / 1000;
+}
+
+#endif
diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index ff7f4dad25..a13f3b6fb9 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -19,6 +19,7 @@
 #include <ethernet.h>
 #include "s390-ccw.h"
 #include "virtio.h"
+#include "s390-time.h"
 
 #ifndef DEBUG_VIRTIO_NET
 #define DEBUG_VIRTIO_NET 0
diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index 4fe4b9d261..7bf0be4ffa 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -14,6 +14,7 @@
 #include "virtio.h"
 #include "scsi.h"
 #include "virtio-scsi.h"
+#include "s390-time.h"
 
 static ScsiDevice default_scsi_device;
 static VirtioScsiCmdReq req;
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index fb40ca9828..ab49840db8 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -15,6 +15,7 @@
 #include "virtio-scsi.h"
 #include "bswap.h"
 #include "helper.h"
+#include "s390-time.h"
 
 #define VRING_WAIT_REPLY_TIMEOUT 30
 
@@ -157,19 +158,6 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags)
     }
 }
 
-u64 get_clock(void)
-{
-    u64 r;
-
-    asm volatile("stck %0" : "=Q" (r) : : "cc");
-    return r;
-}
-
-ulong get_second(void)
-{
-    return (get_clock() >> 12) / 1000000;
-}
-
 int vr_poll(VRing *vr)
 {
     if (vr->used->idx == vr->used_idx) {
@@ -194,7 +182,7 @@ int vr_poll(VRing *vr)
  */
 int vring_wait_reply(void)
 {
-    ulong target_second = get_second() + vdev.wait_reply_timeout;
+    ulong target_second = get_time_seconds() + vdev.wait_reply_timeout;
 
     /* Wait for any queue to be updated by the host */
     do {
@@ -207,7 +195,7 @@ int vring_wait_reply(void)
         if (r) {
             return 0;
         }
-    } while (!vdev.wait_reply_timeout || (get_second() < target_second));
+    } while (!vdev.wait_reply_timeout || (get_time_seconds() < target_second));
 
     return 1;
 }
-- 
2.25.1


