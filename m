Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4768C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5AE20775
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="dAKNpkhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5AE20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH2dj-0000ys-L8
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 05:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dereksu@qnap.com>) id 1jH2aV-0005ba-Rd
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dereksu@qnap.com>) id 1jH2aT-0005MY-Ne
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:44:39 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:40912)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dereksu@qnap.com>) id 1jH2aS-0005LX-IJ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:44:37 -0400
Received: by mail-pj1-x1042.google.com with SMTP id kx8so787616pjb.5
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 02:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=f6sHN97Z5k0H0NePRruYOF0pxNWEQGvMVIWCmlh8Qaw=;
 b=dAKNpkhHdKFwwtJD9gHiZzoTaadLQLebbglx8HullToL1uXLMEoz4cLRvpwjWv2Zxp
 BqxOoqfmXf8F4W7exCLa/WjIzOovj76YrfmnXSbuQX68EylHcnvrMCf/zogat7uFRTmU
 oh0EfOhed3x3nQ+gML6gDpKQZIe/vsClv7ud0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=f6sHN97Z5k0H0NePRruYOF0pxNWEQGvMVIWCmlh8Qaw=;
 b=LtK+PHf+I74nAqPEN2KZiv4bqFxFn3N0shX2HC/IRDu4ZSVahGpxWxYq6dziSgtDAa
 hnURVO+ImF7Xyw2F9iYrXqaWsoHDDTbrdGh7Mf/fQ8VxpyHSb5ZOTaYrTK9ZykFW0Fel
 qsUucYAPsxj75rIz683gE6IL2yxr5Ptsn3LovRb4Ye7HZEYrdfmEbhVTxYreBkhfdY23
 VJOPGCvWgLHBU71dtcT/9Uq8DIWFUWeUgLIp+Mz+mtXVXka2XAn7TX/siW/B4sD8j0rH
 ugiFXaU31qUy/pP2bsU5MpATSDJfFgMRe6bJHEg5QSvf0vqgr1cr5PXCnynPLrCFQFPn
 57Fg==
X-Gm-Message-State: ANhLgQ3BnvzurtwIAHJWlX3l4CWOrAPxkurQ/EIlY2rsl0XqfDepuvWE
 nYUcjL+KDoRaIUiWl3eFfC+hSR99hsA=
X-Google-Smtp-Source: ADFU+vtoQJmpC+bfRDfoaXivYNCSAIXN1tlvpZQTZDB4ZFuLcvnCl2EEE4zgKo6F3QgUHlW+jOeYxw==
X-Received: by 2002:a17:90a:8403:: with SMTP id j3mr2787213pjn.8.1585129475007; 
 Wed, 25 Mar 2020 02:44:35 -0700 (PDT)
Received: from localhost.localdomain (202-39-79-13.HINET-IP.hinet.net.
 [202.39.79.13])
 by smtp.gmail.com with ESMTPSA id j126sm18090602pfg.60.2020.03.25.02.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 02:44:34 -0700 (PDT)
From: Derek Su <dereksu@qnap.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] net/colo-compare.c: Fix memory leak in packet_enqueue()
Date: Wed, 25 Mar 2020 17:43:53 +0800
Message-Id: <20200325094354.19677-2-dereksu@qnap.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200325094354.19677-1-dereksu@qnap.com>
References: <20200325094354.19677-1-dereksu@qnap.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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


