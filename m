Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC08C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C92420882
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQ3NVeyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C92420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCiW-0001iF-HV
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQ5-0002kj-Rz; Tue, 16 Jun 2020 10:18:33 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45187)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQ0-0006ld-Qu; Tue, 16 Jun 2020 10:18:30 -0400
Received: by mail-oi1-x243.google.com with SMTP id p70so19332861oic.12;
 Tue, 16 Jun 2020 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qcWsL2KIfdI2kngmV8gNKMtUukl2dRM3BMTPN7eKsAU=;
 b=BQ3NVeyrEnHkbHQuzqwtxTqejfKBEGVs3jp/5xrgC38RoCqayw0LFR1qCXBfF0MTj9
 0Eiw1uRbd7XFGsTcHYX6NBwjM96N4ftO44/FEv0h17eioyGDFAwIb0GZ1tMojFZ8zh2u
 Vhr5eGldO86OXNSWr1bjm1njRr2DcfvaKzVosFBNGUTvn3IkIa3ouwEmZlXsCu8EtSad
 Up8rHhzE+hpXKa9LeQnvRmtMGQnbX+R39YYLcwIUEyLxpm2XKeyLYVS5s7oca4E6VI0R
 iKf2d7M5lFlL2Eqqm7sNmJxqqDTP77DebndY5UA18gB1xul3n6pXnP3nCWWQYOqO0w5L
 ZB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=qcWsL2KIfdI2kngmV8gNKMtUukl2dRM3BMTPN7eKsAU=;
 b=qQ+0EDWrHoDroJb0lxqDdgOB6X7yR0pqNV6lMDU+GSKDYZrLUx4wDyYbFG7mt9VtVB
 uUOJr+7aLz/I1p78a+KwAXI4bAC05Ur32dXfPtd4RJroBHkSdUndIq/ldinpmZbh6sQE
 5dKvVz/9nTyDMajCSOqArJPL2kd1Waaj/satOIv/1MxVr+COxQM+rtpeZVMwD6oUg3iG
 SXIWob5MWJUNFJq4WgJ2V72iSTc1t2P7H9uTUYVNg1+shkCuiHL4ZJFOeXaSvFPtUg6F
 4bqG8nulBjzSEM0WXjPk71ZRZ+eiuI1PvCRj7k7e2mqA1eqyl+vuLngazkfnhCVZaPDY
 OVXw==
X-Gm-Message-State: AOAM531hQUj4C80jgjCUFNSgzH9SGLiSbjCnT+7nCySRodszOwxaoRtu
 jIJeQ2+MS2Jzr85ZMiziy5TaxPiq
X-Google-Smtp-Source: ABdhPJzi7HAqP3KDdSSr9uGDEKWD6BZDvywDEhGH/bMjF6HBB/TYEBWoSlC1krS35QE+05x0LRonCw==
X-Received: by 2002:aca:48e:: with SMTP id 136mr3499569oie.18.1592317106807;
 Tue, 16 Jun 2020 07:18:26 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id s69sm4062386otb.4.2020.06.16.07.18.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:25 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 40/78] dp8393x: Don't stop reception upon RBE interrupt
 assertion
Date: Tue, 16 Jun 2020 09:15:09 -0500
Message-Id: <20200616141547.24664-41-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org,
 Finn Thain <fthain@telegraphics.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Finn Thain <fthain@telegraphics.com.au>

Section 3.4.7 of the datasheet explains that,

    The RBE bit in the Interrupt Status register is set when the
    SONIC finishes using the second to last receive buffer and reads
    the last RRA descriptor. Actually, the SONIC is not truly out of
    resources, but gives the system an early warning of an impending
    out of resources condition.

RBE does not mean actual receive buffer exhaustion, and reception should
not be stopped. This is important because Linux will not check and clear
the RBE interrupt until it receives another packet. But that won't
happen if can_receive returns false. This bug causes the SONIC to become
deaf (until reset).

Fix this with a new flag to indicate actual receive buffer exhaustion.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit c2279bd0a19b35057f2e4c3b4df9a915717d1142)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/dp8393x.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index d33f21bd0b..44f77c5d3c 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -158,6 +158,7 @@ typedef struct dp8393xState {
     /* Hardware */
     uint8_t it_shift;
     bool big_endian;
+    bool last_rba_is_full;
     qemu_irq irq;
 #ifdef DEBUG_SONIC
     int irq_level;
@@ -347,12 +348,15 @@ static void dp8393x_do_read_rra(dp8393xState *s)
         s->regs[SONIC_RRP] = s->regs[SONIC_RSA];
     }
 
-    /* Check resource exhaustion */
+    /* Warn the host if CRBA now has the last available resource */
     if (s->regs[SONIC_RRP] == s->regs[SONIC_RWP])
     {
         s->regs[SONIC_ISR] |= SONIC_ISR_RBE;
         dp8393x_update_irq(s);
     }
+
+    /* Allow packet reception */
+    s->last_rba_is_full = false;
 }
 
 static void dp8393x_do_software_reset(dp8393xState *s)
@@ -659,9 +663,6 @@ static void dp8393x_write(void *opaque, hwaddr addr, uint64_t data,
                 dp8393x_do_read_rra(s);
             }
             dp8393x_update_irq(s);
-            if (dp8393x_can_receive(s->nic->ncs)) {
-                qemu_flush_queued_packets(qemu_get_queue(s->nic));
-            }
             break;
         /* The guest is required to store aligned pointers here */
         case SONIC_RSA:
@@ -721,8 +722,6 @@ static int dp8393x_can_receive(NetClientState *nc)
 
     if (!(s->regs[SONIC_CR] & SONIC_CR_RXEN))
         return 0;
-    if (s->regs[SONIC_ISR] & SONIC_ISR_RBE)
-        return 0;
     return 1;
 }
 
@@ -773,6 +772,10 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     s->regs[SONIC_RCR] &= ~(SONIC_RCR_PRX | SONIC_RCR_LBK | SONIC_RCR_FAER |
         SONIC_RCR_CRCR | SONIC_RCR_LPKT | SONIC_RCR_BC | SONIC_RCR_MC);
 
+    if (s->last_rba_is_full) {
+        return pkt_size;
+    }
+
     rx_len = pkt_size + sizeof(checksum);
     if (s->regs[SONIC_DCR] & SONIC_DCR_DW) {
         width = 2;
@@ -786,8 +789,8 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         DPRINTF("oversize packet, pkt_size is %d\n", pkt_size);
         s->regs[SONIC_ISR] |= SONIC_ISR_RBAE;
         dp8393x_update_irq(s);
-        dp8393x_do_read_rra(s);
-        return pkt_size;
+        s->regs[SONIC_RCR] |= SONIC_RCR_LPKT;
+        goto done;
     }
 
     packet_type = dp8393x_receive_filter(s, buf, pkt_size);
@@ -899,17 +902,23 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
     }
 
+    dp8393x_update_irq(s);
+
     s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) |
                          ((s->regs[SONIC_RSC] + 1) & 0x00ff);
 
+done:
+
     if (s->regs[SONIC_RCR] & SONIC_RCR_LPKT) {
-        /* Read next RRA */
-        dp8393x_do_read_rra(s);
+        if (s->regs[SONIC_RRP] == s->regs[SONIC_RWP]) {
+            /* Stop packet reception */
+            s->last_rba_is_full = true;
+        } else {
+            /* Read next resource */
+            dp8393x_do_read_rra(s);
+        }
     }
 
-    /* Done */
-    dp8393x_update_irq(s);
-
     return pkt_size;
 }
 
-- 
2.17.1


