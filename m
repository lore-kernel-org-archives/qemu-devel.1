Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62DEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:34:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752AA2080D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6p5Hdl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752AA2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCfe-00057F-Mm
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPg-00022r-Cr; Tue, 16 Jun 2020 10:18:09 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPe-0006eE-Q5; Tue, 16 Jun 2020 10:18:08 -0400
Received: by mail-ot1-x342.google.com with SMTP id u23so16055694otq.10;
 Tue, 16 Jun 2020 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tiuSDaEqW3kbDlPMBjGlHoEXpr31IQ14PK/IvjYjrxs=;
 b=S6p5Hdl7w3Fzj/w4gkT3PfB7tcbGKzokKVEoFV28MW7tpYEiqbUmaT8jGuCKaRoORg
 PQlO72RbVBJZBgY5FdHzYHZfLslVnQSwr8XMndKKKOowiblTkcp+FyONorM1ePVDK0Oo
 viLhhrareZQOs1yw5Pj09+mEBDMsRA3rU7UBXmsbT/WOWIFv1QoJlcpU2v4z1roMtz3U
 GXTRQofk6UAijeTsWcw6NGWgwLhsk8wTHtleHxANrI6DMs/Jlt9aTZ+25pJrXotD2/+l
 nNor9ero6cdIzILv5/Uw+/vciJsEajiGVYsm6pHBEr3JDi6VvssbZRTa1TgubmaNE+LF
 9sMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=tiuSDaEqW3kbDlPMBjGlHoEXpr31IQ14PK/IvjYjrxs=;
 b=Z44qboLwbpunBl8fFkcfnzQogCqUyE038czgiY52UN0F7cBBKsgj+tKtkKe919SEW9
 ia+eUQ2why9F1b8JLOxsspRvLS1vWBAjj6UcStcjyLTFVZnyx4U3+XWyTIPTIAm1+h8d
 mHBFB4Ixn30GJn66zgIEMyzdFk3hjv6h8OJhEBDgJukTssLwAr3ryzrMVnWax+iaIvyw
 AuMmg7pUydJ8REpJBVoEvpRxneo59NRagTwphVdyiU+i6CfRt9hlwZ8okoNDbcccz+Bl
 QaP4aqYX71lKKU8Tz46SNoGOo2kUsxr9EUxO2eTlnlyraYlh0imAE4phTD/T69KZdnR4
 7m/w==
X-Gm-Message-State: AOAM5322u5MNTr+cDm+uwC1s9JLzqPksAI9aKBdvFIZOj43jhOfMeRQ7
 L47TLbtr7DsemASo6FkNZfqfjtr8
X-Google-Smtp-Source: ABdhPJyF2FhcF58eRlTr8Hxwh3R0Fq1qGjXnwYKzZW9iikpYbXyKk+m3X5YpLJwSpUYF3BZGYJCX0g==
X-Received: by 2002:a9d:6188:: with SMTP id g8mr730233otk.43.1592317083933;
 Tue, 16 Jun 2020 07:18:03 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id t77sm4251595oih.11.2020.06.16.07.18.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:03 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 28/78] dp8393x: Always use 32-bit accesses
Date: Tue, 16 Jun 2020 09:14:57 -0500
Message-Id: <20200616141547.24664-29-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x342.google.com
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

The DP83932 and DP83934 have 32 data lines. The datasheet says,

    Data Bus: These bidirectional lines are used to transfer data on the
    system bus. When the SONIC is a bus master, 16-bit data is transferred
    on D15-D0 and 32-bit data is transferred on D31-D0. When the SONIC is
    accessed as a slave, register data is driven onto lines D15-D0.
    D31-D16 are held TRI-STATE if SONIC is in 16-bit mode. If SONIC is in
    32-bit mode, they are driven, but invalid.

Always use 32-bit accesses both as bus master and bus slave.

Force the MSW to zero in bus master mode.

This gets the Linux 'jazzsonic' driver working, and avoids the need for
prior hacks to make the NetBSD 'sn' driver work.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 3fe9a838ec3eae1374ced16b63bf56894b2ffbe6)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/dp8393x.c | 47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 7ca6a6dd46..49c304ee20 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -246,9 +246,19 @@ static void dp8393x_put(dp8393xState *s, int width, int offset,
                         uint16_t val)
 {
     if (s->big_endian) {
-        s->data[offset * width + width - 1] = cpu_to_be16(val);
+        if (width == 2) {
+            s->data[offset * 2] = 0;
+            s->data[offset * 2 + 1] = cpu_to_be16(val);
+        } else {
+            s->data[offset] = cpu_to_be16(val);
+        }
     } else {
-        s->data[offset * width] = cpu_to_le16(val);
+        if (width == 2) {
+            s->data[offset * 2] = cpu_to_le16(val);
+            s->data[offset * 2 + 1] = 0;
+        } else {
+            s->data[offset] = cpu_to_le16(val);
+        }
     }
 }
 
@@ -588,7 +598,7 @@ static uint64_t dp8393x_read(void *opaque, hwaddr addr, unsigned int size)
 
     DPRINTF("read 0x%04x from reg %s\n", val, reg_names[reg]);
 
-    return val;
+    return s->big_endian ? val << 16 : val;
 }
 
 static void dp8393x_write(void *opaque, hwaddr addr, uint64_t data,
@@ -596,13 +606,14 @@ static void dp8393x_write(void *opaque, hwaddr addr, uint64_t data,
 {
     dp8393xState *s = opaque;
     int reg = addr >> s->it_shift;
+    uint32_t val = s->big_endian ? data >> 16 : data;
 
-    DPRINTF("write 0x%04x to reg %s\n", (uint16_t)data, reg_names[reg]);
+    DPRINTF("write 0x%04x to reg %s\n", (uint16_t)val, reg_names[reg]);
 
     switch (reg) {
         /* Command register */
         case SONIC_CR:
-            dp8393x_do_command(s, data);
+            dp8393x_do_command(s, val);
             break;
         /* Prevent write to read-only registers */
         case SONIC_CAP2:
@@ -615,36 +626,36 @@ static void dp8393x_write(void *opaque, hwaddr addr, uint64_t data,
         /* Accept write to some registers only when in reset mode */
         case SONIC_DCR:
             if (s->regs[SONIC_CR] & SONIC_CR_RST) {
-                s->regs[reg] = data & 0xbfff;
+                s->regs[reg] = val & 0xbfff;
             } else {
                 DPRINTF("writing to DCR invalid\n");
             }
             break;
         case SONIC_DCR2:
             if (s->regs[SONIC_CR] & SONIC_CR_RST) {
-                s->regs[reg] = data & 0xf017;
+                s->regs[reg] = val & 0xf017;
             } else {
                 DPRINTF("writing to DCR2 invalid\n");
             }
             break;
         /* 12 lower bytes are Read Only */
         case SONIC_TCR:
-            s->regs[reg] = data & 0xf000;
+            s->regs[reg] = val & 0xf000;
             break;
         /* 9 lower bytes are Read Only */
         case SONIC_RCR:
-            s->regs[reg] = data & 0xffe0;
+            s->regs[reg] = val & 0xffe0;
             break;
         /* Ignore most significant bit */
         case SONIC_IMR:
-            s->regs[reg] = data & 0x7fff;
+            s->regs[reg] = val & 0x7fff;
             dp8393x_update_irq(s);
             break;
         /* Clear bits by writing 1 to them */
         case SONIC_ISR:
-            data &= s->regs[reg];
-            s->regs[reg] &= ~data;
-            if (data & SONIC_ISR_RBE) {
+            val &= s->regs[reg];
+            s->regs[reg] &= ~val;
+            if (val & SONIC_ISR_RBE) {
                 dp8393x_do_read_rra(s);
             }
             dp8393x_update_irq(s);
@@ -657,17 +668,17 @@ static void dp8393x_write(void *opaque, hwaddr addr, uint64_t data,
         case SONIC_REA:
         case SONIC_RRP:
         case SONIC_RWP:
-            s->regs[reg] = data & 0xfffe;
+            s->regs[reg] = val & 0xfffe;
             break;
         /* Invert written value for some registers */
         case SONIC_CRCT:
         case SONIC_FAET:
         case SONIC_MPT:
-            s->regs[reg] = data ^ 0xffff;
+            s->regs[reg] = val ^ 0xffff;
             break;
         /* All other registers have no special contrainst */
         default:
-            s->regs[reg] = data;
+            s->regs[reg] = val;
     }
 
     if (reg == SONIC_WT0 || reg == SONIC_WT1) {
@@ -678,8 +689,8 @@ static void dp8393x_write(void *opaque, hwaddr addr, uint64_t data,
 static const MemoryRegionOps dp8393x_ops = {
     .read = dp8393x_read,
     .write = dp8393x_write,
-    .impl.min_access_size = 2,
-    .impl.max_access_size = 2,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.17.1


