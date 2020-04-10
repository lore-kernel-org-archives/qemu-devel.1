Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937BEC2BA19
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 02:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ACD620730
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 02:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="LSYgdn4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACD620730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMj0X-00056E-Ir
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 22:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dereksu@qnap.com>) id 1jMiyt-0003ov-3E
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 22:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dereksu@qnap.com>) id 1jMiyr-0005jV-Vq
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 22:01:19 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38640)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dereksu@qnap.com>) id 1jMiyr-0005il-Qq
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 22:01:17 -0400
Received: by mail-pj1-x1044.google.com with SMTP id t40so256080pjb.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 19:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mMXD71z/Ccdb4LRFHGzamc1anIpuoOHtQv1un+B2Q3s=;
 b=LSYgdn4BkDz5auHKMqWh5BsByo1BAsYUurqTQoBlufnvW5jiuLTMPB7kWJ/mwy7i4o
 seH6FrpMa+4PlcDa+lhKQwokN/v8y4tlFTQSYcGphgi2E71rZubCd9WNas/1RmmSZo/T
 WVxnHC4ytFK4+Dgq/UjCrrPU2Vxp+PyR+aXec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mMXD71z/Ccdb4LRFHGzamc1anIpuoOHtQv1un+B2Q3s=;
 b=Kl5wloc8qBl+TC6iZm5/o+1HoBpmkn3FQixRfMoArNiUXIA/HsUxeDtpl4MUFuGB3M
 uIIGeZ+EsdiTDdTO4njOXnZke5HndsfxlstCC6MZyFAwLjSRze8lm/4aKZ/lTxaprono
 sUq/PTSv0AU8PwsnFykitmV2knJG8HzJAGl95+wcgTCXMz0hfJr1a5k4zoUCS5tCXdh/
 0I1WzZshAL0HT36MsdQlTip/DIVx8IJGHWldV1esAQ9Y5g1sIzRYrQZxL3NXgeczHcHp
 XnjuRsuiowu/gPezy/VOiWPuZ0q+XJ+4T/vAQyIn94+1zIIkdVE1I7hdG0sGamjVbbcC
 Qd4w==
X-Gm-Message-State: AGi0PuadVYF5SnMk+J8YmLdrD+aGUBimMQnuTqwy38FHCpRXAOTbwZwX
 p6Q2fO7Cv0EPkQrPr8aB3gQSTswBVUI=
X-Google-Smtp-Source: APiQypKwOrjcx6B1rIhDTKoX0s0euikQbBr1jreaUhbrwV3CdSzYONnlmkl97VwRM/nXr53JyPxj6Q==
X-Received: by 2002:a17:902:a985:: with SMTP id
 bh5mr2472343plb.163.1586484076386; 
 Thu, 09 Apr 2020 19:01:16 -0700 (PDT)
Received: from localhost.localdomain (202-39-79-13.HINET-IP.hinet.net.
 [202.39.79.13])
 by smtp.gmail.com with ESMTPSA id l15sm360884pgk.59.2020.04.09.19.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 19:01:15 -0700 (PDT)
From: Derek Su <dereksu@qnap.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 1/1] colo-compare: Fix memory leak in packet_enqueue()
Date: Fri, 10 Apr 2020 10:00:56 +0800
Message-Id: <20200410020056.12104-2-dereksu@qnap.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200410020056.12104-1-dereksu@qnap.com>
References: <20200410020056.12104-1-dereksu@qnap.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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

The patch is to fix the "pkt" memory leak in packet_enqueue().
The allocated "pkt" needs to be freed if the colo compare
primary or secondary queue is too big.

Replace the error_report of full queue with a trace event.

Signed-off-by: Derek Su <dereksu@qnap.com>
---
 net/colo-compare.c | 23 +++++++++++++++--------
 net/trace-events   |  1 +
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 10c0239f9d..035e11d4d3 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -122,6 +122,10 @@ enum {
     SECONDARY_IN,
 };
 
+static const char *colo_mode[] = {
+    [PRIMARY_IN] = "primary",
+    [SECONDARY_IN] = "secondary",
+};
 
 static int compare_chr_send(CompareState *s,
                             const uint8_t *buf,
@@ -217,6 +221,7 @@ static int packet_enqueue(CompareState *s, int mode, Connection **con)
     ConnectionKey key;
     Packet *pkt = NULL;
     Connection *conn;
+    int ret;
 
     if (mode == PRIMARY_IN) {
         pkt = packet_new(s->pri_rs.buf,
@@ -245,16 +250,18 @@ static int packet_enqueue(CompareState *s, int mode, Connection **con)
     }
 
     if (mode == PRIMARY_IN) {
-        if (!colo_insert_packet(&conn->primary_list, pkt, &conn->pack)) {
-            error_report("colo compare primary queue size too big,"
-                         "drop packet");
-        }
+        ret = colo_insert_packet(&conn->primary_list, pkt, &conn->pack);
     } else {
-        if (!colo_insert_packet(&conn->secondary_list, pkt, &conn->sack)) {
-            error_report("colo compare secondary queue size too big,"
-                         "drop packet");
-        }
+        ret = colo_insert_packet(&conn->secondary_list, pkt, &conn->sack);
     }
+
+    if (!ret) {
+        trace_colo_compare_drop_packet(colo_mode[mode],
+            "queue size too big, drop packet");
+        packet_destroy(pkt, NULL);
+        pkt = NULL;
+    }
+
     *con = conn;
 
     return 0;
diff --git a/net/trace-events b/net/trace-events
index 02c13fd0ba..fa49c71533 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -12,6 +12,7 @@ colo_proxy_main(const char *chr) ": %s"
 
 # colo-compare.c
 colo_compare_main(const char *chr) ": %s"
+colo_compare_drop_packet(const char *queue, const char *chr) ": %s: %s"
 colo_compare_udp_miscompare(const char *sta, int size) ": %s = %d"
 colo_compare_icmp_miscompare(const char *sta, int size) ": %s = %d"
 colo_compare_ip_info(int psize, const char *sta, const char *stb, int ssize, const char *stc, const char *std) "ppkt size = %d, ip_src = %s, ip_dst = %s, spkt size = %d, ip_src = %s, ip_dst = %s"
-- 
2.17.1


