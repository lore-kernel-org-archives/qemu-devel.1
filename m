Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DD2C43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 12:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B4B206E6
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 12:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="Qt55up7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B4B206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIAud-0008GD-Pv
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 08:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dereksu@qnap.com>) id 1jIAsH-00067p-QW
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 08:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dereksu@qnap.com>) id 1jIAsF-00082g-Qy
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 08:47:41 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44552)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dereksu@qnap.com>) id 1jIAsE-00081t-QX
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 08:47:38 -0400
Received: by mail-pf1-x443.google.com with SMTP id b72so5924348pfb.11
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2020 05:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=muXHoLZL0Cd7IjD57+5HkvVOZyFuGtQkFYQQmjWk/0I=;
 b=Qt55up7/sYJX4Ga7+hPIVe4j0FGRom9MXq9TcoTVhqIrmJGrY/eAYT+r/+QYyZkaU4
 O6DX9OCQt7NijTuUAXNV/QbakezK7xpS7Pf9SRjL/ULA+YMQapQPGwZZEJ5fmRSFV2t0
 Kcc2x6be5CzxMMzuswI2+m9zupmarZOKAnHqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=muXHoLZL0Cd7IjD57+5HkvVOZyFuGtQkFYQQmjWk/0I=;
 b=hS+ZBpKv28NuNGA9cho4+DKChmrFH6P910D+iDjfoiBN8+gwg69U6+z5C69Jg61Ay8
 qkbAGbUk137ZRjPzl6pFESMYSEAkE4HfUbhOdcP0ZKGf4UqRiemK4/ZGvZz62KU5qvpy
 SjS6eVCo5hB7tc4LKPDTThYFRYlYfh4zCKjymXeK865hTiK6az/gqzfE77IuH1f7nukd
 CBMRiAJjuR9ftJsw/oac2YcBi9Q+qeGzHt+qUzJCYcDJgWOVZ26dFB9HkibJ48vkxHU9
 TI7ZEPOLRRWwkDV6m2erpO8kpbotfjaDyzrTGrNLLurfcXzT1IoxQfRMo/5q/Th9Yg07
 UkBA==
X-Gm-Message-State: ANhLgQ0x47n54mGt5Qhy8St+M/xAR+o9YVA2wkKs71B8Ym/1xm6N1sbR
 kjMxeLlEGmSNI2x30OczJco+DXgQsrY=
X-Google-Smtp-Source: ADFU+vvjPIth6UyxZv8q/Rv+GQPcweGBpJ2fgqHxj4p3WXQCXe5EjVCfPv+tgYqdHSzNEin76vOX5A==
X-Received: by 2002:a62:1bd6:: with SMTP id b205mr4301220pfb.242.1585399657493; 
 Sat, 28 Mar 2020 05:47:37 -0700 (PDT)
Received: from localhost.localdomain (202-39-79-13.HINET-IP.hinet.net.
 [202.39.79.13])
 by smtp.gmail.com with ESMTPSA id k14sm10176468pje.3.2020.03.28.05.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2020 05:47:36 -0700 (PDT)
From: Derek Su <dereksu@qnap.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/2] net/colo-compare.c: handling of the full primary or
 secondary queue
Date: Sat, 28 Mar 2020 20:46:46 +0800
Message-Id: <20200328124646.7778-3-dereksu@qnap.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200328124646.7778-1-dereksu@qnap.com>
References: <20200328124646.7778-1-dereksu@qnap.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: lizhijian@cn.fujitsu.com, chyang@qnap.com, Derek Su <dereksu@qnap.com>,
 jasowang@redhat.com, ctcheng@qnap.com, chen.zhang@intel.com,
 jwsu1986@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The pervious handling of the full primary or queue is only dropping
the packet. If there are lots of clients to the guest VM,
the "drop" will lead to the lost of the networking connection
until next checkpoint.

To address the issue, this patch drops the packet firstly.
Then, do checkpoint and flush packets.

Signed-off-by: Derek Su <dereksu@qnap.com>
---
 net/colo-compare.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index cdd87b2aa8..fe8779cf2d 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -125,6 +125,12 @@ static const char *colo_mode[] = {
     [SECONDARY_IN] = "secondary",
 };
 
+enum {
+    QUEUE_INSERT_ERR = -1,
+    QUEUE_INSERT_OK = 0,
+    QUEUE_INSERT_FULL = 1,
+};
+
 static int compare_chr_send(CompareState *s,
                             const uint8_t *buf,
                             uint32_t size,
@@ -211,8 +217,10 @@ static int colo_insert_packet(GQueue *queue, Packet *pkt, uint32_t *max_ack)
 }
 
 /*
- * Return 0 on success, if return -1 means the pkt
- * is unsupported(arp and ipv6) and will be sent later
+ * Return QUEUE_INSERT_OK on success.
+ * If return QUEUE_INSERT_FULL means list is full, and
+ * QUEUE_INSERT_ERR means the pkt is unsupported(arp and ipv6) and
+ * will be sent later
  */
 static int packet_enqueue(CompareState *s, int mode, Connection **con)
 {
@@ -234,7 +242,7 @@ static int packet_enqueue(CompareState *s, int mode, Connection **con)
     if (parse_packet_early(pkt)) {
         packet_destroy(pkt, NULL);
         pkt = NULL;
-        return -1;
+        return QUEUE_INSERT_ERR;
     }
     fill_connection_key(pkt, &key);
 
@@ -258,11 +266,12 @@ static int packet_enqueue(CompareState *s, int mode, Connection **con)
                      "drop packet", colo_mode[mode]);
         packet_destroy(pkt, NULL);
         pkt = NULL;
+        return QUEUE_INSERT_FULL;
     }
 
     *con = conn;
 
-    return 0;
+    return QUEUE_INSERT_OK;
 }
 
 static inline bool after(uint32_t seq1, uint32_t seq2)
@@ -995,17 +1004,21 @@ static void compare_pri_rs_finalize(SocketReadState *pri_rs)
 {
     CompareState *s = container_of(pri_rs, CompareState, pri_rs);
     Connection *conn = NULL;
+    int ret;
 
-    if (packet_enqueue(s, PRIMARY_IN, &conn)) {
+    ret = packet_enqueue(s, PRIMARY_IN, &conn);
+    if (ret == QUEUE_INSERT_OK) {
+        /* compare packet in the specified connection */
+        colo_compare_connection(conn, s);
+    } else if (ret == QUEUE_INSERT_FULL) {
+        colo_compare_inconsistency_notify(s);
+    } else {
         trace_colo_compare_main("primary: unsupported packet in");
         compare_chr_send(s,
                          pri_rs->buf,
                          pri_rs->packet_len,
                          pri_rs->vnet_hdr_len,
                          false);
-    } else {
-        /* compare packet in the specified connection */
-        colo_compare_connection(conn, s);
     }
 }
 
@@ -1013,12 +1026,16 @@ static void compare_sec_rs_finalize(SocketReadState *sec_rs)
 {
     CompareState *s = container_of(sec_rs, CompareState, sec_rs);
     Connection *conn = NULL;
+    int ret;
 
-    if (packet_enqueue(s, SECONDARY_IN, &conn)) {
-        trace_colo_compare_main("secondary: unsupported packet in");
-    } else {
+    ret = packet_enqueue(s, SECONDARY_IN, &conn);
+    if (ret == QUEUE_INSERT_OK) {
         /* compare packet in the specified connection */
         colo_compare_connection(conn, s);
+    } else if (ret == QUEUE_INSERT_FULL) {
+        colo_compare_inconsistency_notify(s);
+    } else {
+        trace_colo_compare_main("secondary: unsupported packet in");
     }
 }
 
-- 
2.17.1


