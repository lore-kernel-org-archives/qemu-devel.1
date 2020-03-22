Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50355C4332B
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 17:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D28206C3
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 17:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+fVZLKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D28206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG4is-0000u4-8W
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 13:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jwsu1986@gmail.com>) id 1jG4hp-0008Lx-KB
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 13:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jwsu1986@gmail.com>) id 1jG4ho-0005yQ-HW
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 13:48:13 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33005)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jwsu1986@gmail.com>) id 1jG4ho-0005xp-C4
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 13:48:12 -0400
Received: by mail-pl1-x642.google.com with SMTP id g18so4874961plq.0
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 10:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=f6sHN97Z5k0H0NePRruYOF0pxNWEQGvMVIWCmlh8Qaw=;
 b=o+fVZLKb4Ww9+uxkUvNJcwuPxpurrzDwhubdccAbY4dj2pZ7JGVnw1fxMylCafYmH7
 zPu8keQea/UO/808JQhIhQffE9/dG3Om1L54Ae1YFKco7FjRZSZTYxA00HfKal7UzaW0
 R2fpXAAXYGjuZfyEdvdSfeD9JlvLHZR3jFIN3nMj/m+LybWpbKLL1QuAHT/lnLVqnT8f
 eTP+LaviHLQ7dS0ITWkVksBKD8iZvYzymPITFfhVaUbx2+NHDFvplVJC4oZkRH99jJg4
 dBLDjZD70OuroiXfGyMOpBOuscyyQ1JOGshnUUFlzioNx0w3K31eokCUYAufDj8cNHWR
 9ZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=f6sHN97Z5k0H0NePRruYOF0pxNWEQGvMVIWCmlh8Qaw=;
 b=OW0Vo40c93qPIk9v8d1JdbUfpb6+xeCj6p8UY3sS2umqHkU0tPlUp+/JlOn82Axa8H
 GKapvL6Unohw4MzyESFO//590VNQK4i8msZOaYXAIKaZ1cKNOMc9xixT+YWLvAvCwW3Y
 SfND94TfUuwh3VOuW6qLueFKvirCcjsgCzRab5LlUMY4a2LSr06jtQU+9yQMsGfDhRK7
 QHJmT7UyVYUexGKr8bAaiusz4UboXSzZc7SelCNymFANR3DLIq6B6Y/DSQ6wF+Rb/j0X
 XTs/sWZKNh5vZyhjcAwTht0gE1Kv3JGWhy8m9qEkmXeqT1VRx+bje5SIWIpG/PUEr3qc
 kyPA==
X-Gm-Message-State: ANhLgQ1ya9UJmMzhd801ddVBLrUIRXWeONE+eREbNKKXK6obe93+/He5
 Np+QDitWULUyjNxIzdeRuRSgXpoGP6Bf0g==
X-Google-Smtp-Source: ADFU+vtNKajIGzjlUJutSCCfnnl3TDtujJghpX55vdm0+ULF7j6DR4itYV6MqNThWDv3PDkZyrmYDA==
X-Received: by 2002:a17:902:7c86:: with SMTP id
 y6mr5714234pll.49.1584899291171; 
 Sun, 22 Mar 2020 10:48:11 -0700 (PDT)
Received: from localhost.localdomain (1-161-253-93.dynamic-ip.hinet.net.
 [1.161.253.93])
 by smtp.gmail.com with ESMTPSA id w19sm10460410pgm.27.2020.03.22.10.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2020 10:48:10 -0700 (PDT)
From: Derek Su <jwsu1986@gmail.com>
X-Google-Original-From: Derek Su <dereksu@qnap.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/1] net/colo-compare.c: Fix memory leak in packet_enqueue()
Date: Mon, 23 Mar 2020 01:47:51 +0800
Message-Id: <20200322174751.12559-2-dereksu@qnap.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200322174751.12559-1-dereksu@qnap.com>
References: <20200322174751.12559-1-dereksu@qnap.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: dereksu@qnap.com, chen.zhang@intel.com, jasowang@redhat.com,
 lizhijian@cn.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patch is to fix the "pkt" memory leak in packet_enqueue().
The allocated "pkt" needs to be freed if the colo compare
primary or secondary queue is too big.

Signed-off-by: Derek Su <dereksu@qnap.com>
---
 net/colo-compare.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 7ee17f2cf8..cdd87b2aa8 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -120,6 +120,10 @@ enum {
     SECONDARY_IN,
 };
 
+static const char *colo_mode[] = {
+    [PRIMARY_IN] = "primary",
+    [SECONDARY_IN] = "secondary",
+};
 
 static int compare_chr_send(CompareState *s,
                             const uint8_t *buf,
@@ -215,6 +219,7 @@ static int packet_enqueue(CompareState *s, int mode, Connection **con)
     ConnectionKey key;
     Packet *pkt = NULL;
     Connection *conn;
+    int ret;
 
     if (mode == PRIMARY_IN) {
         pkt = packet_new(s->pri_rs.buf,
@@ -243,16 +248,18 @@ static int packet_enqueue(CompareState *s, int mode, Connection **con)
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
+        error_report("colo compare %s queue size too big,"
+                     "drop packet", colo_mode[mode]);
+        packet_destroy(pkt, NULL);
+        pkt = NULL;
+    }
+
     *con = conn;
 
     return 0;
-- 
2.17.1


