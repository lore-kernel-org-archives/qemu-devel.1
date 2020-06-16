Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD80C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:33:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68D832080D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jv1c5gsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D832080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCe9-0001pB-Im
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPe-00022B-L7; Tue, 16 Jun 2020 10:18:07 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:36739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPc-0006dv-Le; Tue, 16 Jun 2020 10:18:06 -0400
Received: by mail-oo1-xc41.google.com with SMTP id 18so4114476ooy.3;
 Tue, 16 Jun 2020 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vyfdFEZo9wjCtOzFIY4Rui8H5p83Ort5DNNjf/+2Umc=;
 b=Jv1c5gsVp22bBuHlahsGlVrPfcszZxv6m5FdLoLldeQOMYGfsr0zRMy0ZUpC2H3vro
 EGy+q6a0TMu8nZa6vXfH4ygN3kiUQ1pSWHYeW8GVCuMfXsjCdWgr9/buzzHQjgRyojUY
 VN/yssP1wdbIFe5VwdVPovFS/HdUL/twXpnYg+ndkpa8x/KsRdHYV+mEqbNBizPhp+JF
 ELq923flVnhS5CbNrNkINM/LWFQJqBveWu2YZE9BSK2YjcWzHsgOgInG0qLHMRQ04UlM
 geIo+sRpxXvdktW/ILIxh/EouvStk8au5GWl+ofT5WdhQeiGn/FfOxCZfwzMpX2Z4JEZ
 aCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=vyfdFEZo9wjCtOzFIY4Rui8H5p83Ort5DNNjf/+2Umc=;
 b=G12TyICBfoV58o4gYbPiGzPLqDl6bEJUg8En1TGCHAMUDTjqEmoIhkMJZL9O5sN40B
 r0Tfr4q2qE78tuxw6gr8K9uaRiOKgcHGc8xYA5yLrNQaKgh9j5yYa2dQ5v3dWwtg3JlQ
 Y1sF3na2tSCWunBqP5rwMKeFPGwvqnhSoP6NWZdXygLn0Qs6gKWj/6Ub6I82Uuuh3dMQ
 AHxXOk8TW8P+VGytLu1ebaqa2enTbKJ9wKg9D1BJ6Zpt1YEMlR7cpRo5/5IgWMykQXym
 k5K2R6KYb3d/RWUAVQKEAAV/yWgwBauXChhYERS8jZ+KueUe3nhEpr36bdnwecGXWlg8
 SIiQ==
X-Gm-Message-State: AOAM532v6GyAImg7sbBXksHC4BlsPe4Jg0ss9futbBw7l9RzYad1AAB5
 67EijEU1nWmaEy2n5cloEbsx5coG
X-Google-Smtp-Source: ABdhPJyLWoo5hI5bJXmSp8BD0YLcRxZUGZk9VEXEmvcLDPG1sOHNF5ML6WOMb7rio72DozCVqo5vmg==
X-Received: by 2002:a4a:8143:: with SMTP id p3mr2462712oog.49.1592317082522;
 Tue, 16 Jun 2020 07:18:02 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id h27sm2128482otg.23.2020.06.16.07.18.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:01 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 27/78] dp8393x: Mask EOL bit from descriptor addresses
Date: Tue, 16 Jun 2020 09:14:56 -0500
Message-Id: <20200616141547.24664-28-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc41.google.com
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

The Least Significant bit of a descriptor address register is used as
an EOL flag. It has to be masked when the register value is to be used
as an actual address for copying memory around. But when the registers
are to be updated the EOL bit should not be masked.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 88f632fbb1b3d31d5b6978d28f8735a6ed18b8f5)
 Conflicts:
	hw/net/dp8393x.c
*drop context dep. on 19f70347731
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/dp8393x.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 3d991af163..7ca6a6dd46 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -145,6 +145,9 @@ do { printf("sonic ERROR: %s: " fmt, __func__ , ## __VA_ARGS__); } while (0)
 #define SONIC_ISR_PINT   0x0800
 #define SONIC_ISR_LCD    0x1000
 
+#define SONIC_DESC_EOL   0x0001
+#define SONIC_DESC_ADDR  0xFFFE
+
 #define TYPE_DP8393X "dp8393x"
 #define DP8393X(obj) OBJECT_CHECK(dp8393xState, (obj), TYPE_DP8393X)
 
@@ -197,7 +200,8 @@ static uint32_t dp8393x_crba(dp8393xState *s)
 
 static uint32_t dp8393x_crda(dp8393xState *s)
 {
-    return (s->regs[SONIC_URDA] << 16) | s->regs[SONIC_CRDA];
+    return (s->regs[SONIC_URDA] << 16) |
+           (s->regs[SONIC_CRDA] & SONIC_DESC_ADDR);
 }
 
 static uint32_t dp8393x_rbwc(dp8393xState *s)
@@ -217,7 +221,8 @@ static uint32_t dp8393x_tsa(dp8393xState *s)
 
 static uint32_t dp8393x_ttda(dp8393xState *s)
 {
-    return (s->regs[SONIC_UTDA] << 16) | s->regs[SONIC_TTDA];
+    return (s->regs[SONIC_UTDA] << 16) |
+           (s->regs[SONIC_TTDA] & SONIC_DESC_ADDR);
 }
 
 static uint32_t dp8393x_wt(dp8393xState *s)
@@ -507,7 +512,7 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
                              (4 + 3 * s->regs[SONIC_TFC]) * width,
                 MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
             s->regs[SONIC_CTDA] = dp8393x_get(s, width, 0) & ~0x1;
-            if (dp8393x_get(s, width, 0) & 0x1) {
+            if (dp8393x_get(s, width, 0) & SONIC_DESC_EOL) {
                 /* EOL detected */
                 break;
             }
@@ -763,13 +768,13 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     /* XXX: Check byte ordering */
 
     /* Check for EOL */
-    if (s->regs[SONIC_LLFA] & 0x1) {
+    if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
         /* Are we still in resource exhaustion? */
         size = sizeof(uint16_t) * 1 * width;
         address = dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
         address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
                          (uint8_t *)s->data, size, 0);
-        if (dp8393x_get(s, width, 0) & 0x1) {
+        if (dp8393x_get(s, width, 0) & SONIC_DESC_EOL) {
             /* Still EOL ; stop reception */
             return -1;
         } else {
@@ -827,7 +832,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
     s->regs[SONIC_LLFA] = dp8393x_get(s, width, 0);
-    if (s->regs[SONIC_LLFA] & 0x1) {
+    if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
         /* EOL detected */
         s->regs[SONIC_ISR] |= SONIC_ISR_RDE;
     } else {
-- 
2.17.1


