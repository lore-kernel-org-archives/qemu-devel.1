Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C68C5DF65
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8E92187F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8E92187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJSB-0001Yu-8e
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSJPn-0007zb-0y
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSJPl-0000ax-GL
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:23:54 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:53651)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSJPl-0000Wy-6I
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:23:53 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MpDVx-1i9AlR1gCt-00qfsc; Wed, 06 Nov 2019 12:23:46 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] dp8393x: fix dp8393x_receive()
Date: Wed,  6 Nov 2019 12:23:41 +0100
Message-Id: <20191106112341.23735-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106112341.23735-1-laurent@vivier.eu>
References: <20191106112341.23735-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0PIFKXPD3UsSAG/Kc9+8KDCfUadMQ9t8rToZmYjA38xfCheWdYc
 yPbLf0GuoVyxJWB8K3qbdZyFOwDSzmTGgA3ECJehQoHTQlXEdUoaF9cfIfAs1joEHaB9+4T
 A6Be/TzOEIAtDOxqoZ07lW3XM7DPz/b3RFCjwtsey/1vlio/+0ccAsbzOBJtewC+V0/aocX
 aOnVmYgg6vPeBMQwSrBMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xkeuSi1oVO8=:s/uztf8lNxDlcztR4qEyeH
 X0vdDe+mo70FDOBv4a9t5hKqTlyG2w/SiaJH/tY/ElbDYo39sowDsCQ3qeUW455OIp4caDNSG
 1rIp1AE2fpKXREeQfza9y1GhaQxpWKaTyhWQzIcMst0apnyrgaspKrGvXmN+RN0/w34cSSecM
 24IKdkgmcx2Zb1RHhvqveTmuhU266YpyLpDddeoCd2KH97NK6toSKIzR2ccb1rfEMZiwjigWJ
 lO3Yu7JtNC6t8Qaul6TfiNn+g57UrlxnwUH3+uf621yzUk26HODD/YzfGfrP69f+q8S4yaaQZ
 z3FQBuAVr5hBEbxlSzIJx3cTgHSue0f7KMeZLJn7h2h/wE10hOsR8EML75zPL5InEx3m+uLjF
 vZbGWkGgvYxodPA+Ddl3vfarFsmjTvMyS52/tRsRB2lDuZ60cpV1ziY1ZfxGbAV7dQaUD5eNW
 zXsyOamEypnyK+r1yKH9OcVXOm/bjlLKS7v5JdpmwgkXLJT/2MUogfV84aP82zUHmu8A/cg9N
 IW2PB6U3QuuUSn4ZenkcJZWf/FhxIHBp3xuq5zLxShgPNjX/ySb+DrzWlgpmpW+1w7x7hmjKi
 p4Sy0Q0BVU7pIVE+mibviaBQEfd14l3KQOgdq93p8I3Ew4iZ8dk+F+YByFPAHaCvTjgIpG2So
 2r3r5gWVOTW4jbYeg3WbGqdowojCHFh8jYn8jKmzeLAfFCmTVtwMq4XU6JRtymKjI+vqDF5aV
 mSnoBC8Ciihs3nD7662KbyL4jMoB966RDDckK/fP+V25N+qyOpTbXnui/eyI0xcn3SdGEOkfX
 6meMXxopVdS9275I/D9u0j11qEMlS8ZT4eoM3driBd7sn+HVABDwWFhxdh46kWqiYYf3LnICL
 6wBTItUHAfuIJnHRxkRw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.73
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
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RXpkt.in_use is always 16 bit wide, but when the bus access mode is 32bit
and the endianness is big, we must access the second word and not the
first. This patch adjusts the offset according to the size and endianness.

This fixes DHCP for Q800 guest.

Fixes: be9208419865 ("dp8393x: manage big endian bus")
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Hervé Poussineau <hpoussin@reactos.org>
---

Notes:
    v2: adjust the offset, not the size

 hw/net/dp8393x.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 85d3f3788e..3d991af163 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -831,9 +831,15 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         /* EOL detected */
         s->regs[SONIC_ISR] |= SONIC_ISR_RDE;
     } else {
-        dp8393x_put(s, width, 0, 0); /* in_use */
-        address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 6 * width,
-            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, sizeof(uint16_t), 1);
+        /* Clear in_use, but it is always 16bit wide */
+        int offset = dp8393x_crda(s) + sizeof(uint16_t) * 6 * width;
+        if (s->big_endian && width == 2) {
+            /* we need to adjust the offset of the 16bit field */
+            offset += sizeof(uint16_t);
+        }
+        s->data[0] = 0;
+        address_space_rw(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
+                         (uint8_t *)s->data, sizeof(uint16_t), 1);
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
         s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
-- 
2.21.0


