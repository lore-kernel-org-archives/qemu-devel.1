Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10E3C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C3942070E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpUVHzsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3942070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXXf-0007qD-Ap
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4o-00039p-NI
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4n-0004qu-6L
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:06 -0500
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:41709)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4n-0004qX-2V; Mon, 06 Jan 2020 13:26:05 -0500
Received: by mail-qt1-x842.google.com with SMTP id k40so43186289qtk.8;
 Mon, 06 Jan 2020 10:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jkWrhgPSptvUdoRpBvu+nZPt4DG/CCW6P9e4SvO3R4Y=;
 b=PpUVHzsymhP0qmvWWvSH988bOE8R/TWD2utS/aX3eog494DPlrx06/rLaIj/20bdOD
 5cw7BvX+je2pcnvWwYaAt0BlnD8JeZEhq4YaZ2fjSBW0E+Aq/GrFCHEcEDTNyLogntj1
 4LgtKWaFgsSfXKgXLvi5hnn4YuWWrd89zF2VI8qK0yFs3EKSllP9i35mywAVXz4knxtK
 /ZoIxnj2xzEYMgDe8c5ThzuPJd+M4atCl3zbtmXUaA0o0mDwkqGPo3Zxet287hcMM0m9
 cL8S0bQwL4eYsHUxhEDrEH3nEp23MUUNQzwb9N+Div5n48JnD3bFUbKI25aWssVDp7/3
 fhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jkWrhgPSptvUdoRpBvu+nZPt4DG/CCW6P9e4SvO3R4Y=;
 b=uKzQZEN4LUMYBF2rPtnWCNxrIqPduI4FaE2HSd3EGPiS/Y8my5Cpjvy9o/S4VS0YS3
 idh/NHfHFjHHP08DWLXC+xv7m6vmuRgtYf6FN0HTcHVlCZt7BSbn+By8S95BzOOjJXZK
 BUNmhbglhaBFe090MoCY7HD4I7NMBmME+mYI80jtUfbXK/q7Z9S2BTYc6y3m+TZCOYbV
 zj0yG0tW3FebmarxqT5Ayzj0N5643wMFurkAb6D7A/UubE4aBGmzftdcPB0gHejsjjK6
 vtSVLcuWVTZOPmPV5H11TcaF+AhLOqjVOqTtEw9XY2kkOnrqvN9aTzyHV8E2U1y6p6br
 JR7A==
X-Gm-Message-State: APjAAAWR+HatDfD6WYQuILLeeLlmM2u7shvghX4IQ1bm9PIerm5SYl20
 DJEJXYMfu//IXlBkh1e1RPGM9uVe
X-Google-Smtp-Source: APXvYqyfAVd/QYltAIZUHmuLgfKU7232NaaldQUa3oK+LsgJIaAp0wBAPCDwRaSixBJh8RVGfnZ/Eg==
X-Received: by 2002:ac8:404e:: with SMTP id j14mr67129587qtl.312.1578335164489; 
 Mon, 06 Jan 2020 10:26:04 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:26:04 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 40/59] hsb/hcd-ehci.c: remove unneeded labels
Date: Mon,  6 Jan 2020 15:24:06 -0300
Message-Id: <20200106182425.20312-41-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Label 'out' in ehci_state_fetchentry(), ehci_state_waitlisthead(),
ehci_state_fetchqh() and ehci_state_execute() can be replaced
by 'return' with the appropriate value.

CC: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/usb/hcd-ehci.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 56ab2f457f..d8103102d6 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -1511,7 +1511,6 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  int async)
 {
     EHCIqh qh;
     int i = 0;
-    int again = 0;
     uint32_t entry = ehci->asynclistaddr;
 
     /* set reclamation flag at start event (4.8.6) */
@@ -1536,8 +1535,7 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  int async)
 
             ehci_set_fetch_addr(ehci, async, entry);
             ehci_set_state(ehci, async, EST_FETCHENTRY);
-            again = 1;
-            goto out;
+            return 1;
         }
 
         entry = qh.next;
@@ -1550,8 +1548,7 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  int async)
 
     ehci_set_state(ehci, async, EST_ACTIVE);
 
-out:
-    return again;
+    return 0;
 }
 
 
@@ -1565,7 +1562,7 @@ static int ehci_state_fetchentry(EHCIState *ehci, int async)
 
     if (NLPTR_TBIT(entry)) {
         ehci_set_state(ehci, async, EST_ACTIVE);
-        goto out;
+        return 0;
     }
 
     /* section 4.8, only QH in async schedule */
@@ -1597,7 +1594,6 @@ static int ehci_state_fetchentry(EHCIState *ehci, int async)
         return -1;
     }
 
-out:
     return again;
 }
 
@@ -1617,14 +1613,12 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
     if (q->seen > 1) {
         /* we are going in circles -- stop processing */
         ehci_set_state(ehci, async, EST_ACTIVE);
-        q = NULL;
-        goto out;
+        return NULL;
     }
 
     if (get_dwords(ehci, NLPTR_GET(q->qhaddr),
                    (uint32_t *) &qh, sizeof(EHCIqh) >> 2) < 0) {
-        q = NULL;
-        goto out;
+        return NULL;
     }
     ehci_trace_qh(q, NLPTR_GET(q->qhaddr), &qh);
 
@@ -1658,8 +1652,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
             DPRINTF("FETCHQH:  QH 0x%08x. H-bit set, reclamation status reset"
                        " - done processing\n", q->qhaddr);
             ehci_set_state(ehci, async, EST_ACTIVE);
-            q = NULL;
-            goto out;
+            return NULL;
         }
     }
 
@@ -1688,7 +1681,6 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
         ehci_set_state(ehci, async, EST_ADVANCEQUEUE);
     }
 
-out:
     return q;
 }
 
@@ -1932,8 +1924,7 @@ static int ehci_state_execute(EHCIQueue *q)
     /* 4.10.3, bottom of page 82, go horizontal on transaction counter == 0 */
     if (!q->async && q->transact_ctr == 0) {
         ehci_set_state(q->ehci, q->async, EST_HORIZONTALQH);
-        again = 1;
-        goto out;
+        return 1;
     }
 
     if (q->async) {
@@ -1942,7 +1933,7 @@ static int ehci_state_execute(EHCIQueue *q)
 
     again = ehci_execute(p, "process");
     if (again == -1) {
-        goto out;
+        return -1;
     }
     if (p->packet.status == USB_RET_ASYNC) {
         ehci_flush_qh(q);
@@ -1954,14 +1945,11 @@ static int ehci_state_execute(EHCIQueue *q)
         } else {
             again = 1;
         }
-        goto out;
+        return again;
     }
 
     ehci_set_state(q->ehci, q->async, EST_EXECUTING);
-    again = 1;
-
-out:
-    return again;
+    return 1;
 }
 
 static int ehci_state_executing(EHCIQueue *q)
-- 
2.24.1


