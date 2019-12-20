Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D67BC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 410F720866
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410F720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiQ1x-00014w-91
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 16:41:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iiQ1C-0000VH-C3
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:41:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iiQ1A-0007oA-Hx
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:41:06 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:33005)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iiQ1A-0007m5-63; Fri, 20 Dec 2019 16:41:04 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MOiU5-1iJQkY2Hbr-00QChy; Fri, 20 Dec 2019 22:40:57 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] mos6522: remove anh register
Date: Fri, 20 Dec 2019 22:40:54 +0100
Message-Id: <20191220214054.76525-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QWud1jyLQfXmQl+m+wbeYLby1Vy2ySQW3t25qeDl50Sy4utHdXM
 O9h3X/w9ok5CMehMHZPYdDdnPYQ6AuAFJr6oFbpOfT0MVUqFoMqKSr+6HwI0EFeDQrmCigA
 +oeQ8cp3MNgzxwyetSUl5kDjRRFw6AXI/GYzmvTsZe/C3kozmPsbTNJEQJdjorwqFLD7eqp
 EOV1QLjmmLmdG2fy0c4vg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BR8MsWSJLSo=:3efHz0gZVy/mWV0RC+DpOD
 kS64LlqfP50EdFcFxNfX+wWEVUNgz3wTiOVZjmi1gGFwOAlv2mwSR9VSNDDcaH1lgyFcB2Zm/
 FP3GH/6zGSrtSW/kTIbhp9GMbuhLafXK/op3y9kUD7m1ESJu+WxkiVAWqwQumQao1EtYDTSsc
 xWgL4abCX31TT3LfXH16TkWWf9Ybgb3TmM1K4co09dAEEw0AtIP/0jNskQ1Age+6lz6y3cIWo
 n7qpNSPjBPVIQwevhdJWS4QLH3SNbFf4qCfIMFcD7/dVXoCAQKJVSogXcwcFrWjbByxujW0EB
 dsKqTtXRoBHHLFOrmiD9jWS0Toh0deBZlf9P+G0PH7Eln+SIKeG3FEMZd+pT6iRBf4zybfbDK
 Grj9jsoRqArrxKjs+20rL6okhuCQjItF1Ei+udGpyyeUg6Ar7/s8U95/tXPKq2XX+3Ptw4FNE
 7Wid+MHOUql6cZjZDQcGluGDMVp9/MtDtbvULM+0LkzKnd4ryku8tNflO68Q8HosDK9cLxh+C
 XeLTzWxHwWDRswG/nR4rRCxBMqFz1hrkvH+ospqU8Xq8UGRuHLxw3YYIBHqQdpkQFG64Z5445
 o1Q9E8E5S7FJhmnltoGDVAODmsrT7A5bt5PhVUp9whjYDxZyWecQuos/J6mBFv2lp64mq7tNe
 akYEzD9rhyxS81BK4+HQi6wuLTbFblzWiS0EDmdv5/owlHPHoJ9ME9JfPYsubYw4Jg4OOzfGp
 O5cO9jHujI8rRUxEuxl3QIzkSkQZmAdMlQeTOGz2NKZAf0cFkvRv9hD4+NXGgR2SjirBesOjS
 EUJtN92jsO553i00uinG2jaofgLXtK6mf2H0FPv9VSeJbbhF0EDbKvGlURfpEhjPvdjiFexNQ
 pg22jhueWcLtTPM/taAw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.74
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Register addr 1 is defined as buffer A with handshake (vBufAH),
register addr 15 is also defined as buffer A without handshake (vBufA).

As both addresses access the same register, remove the definition of
'anh' and use only 'a' (with VIA_REG_ANH and VIA_REG_A).

Fixes: 51f233ec92cd ("misc: introduce new mos6522 VIA device and enable it for ppc builds")
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v2: update commit message (remove reference to linux)
        add LOG_UNIMP for VIA_REG_A access

 hw/misc/mos6522.c         | 16 ++++++++--------
 include/hw/misc/mos6522.h |  1 -
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index cecf0be59e..10b85bf751 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -244,6 +244,9 @@ uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size)
         val = s->b;
         break;
     case VIA_REG_A:
+       qemu_log_mask(LOG_UNIMP, "Read access to register A with handshake");
+       /* fall through */
+    case VIA_REG_ANH:
         val = s->a;
         break;
     case VIA_REG_DIRB:
@@ -297,9 +300,7 @@ uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size)
         val = s->ier | 0x80;
         break;
     default:
-    case VIA_REG_ANH:
-        val = s->anh;
-        break;
+        g_assert_not_reached();
     }
 
     if (addr != VIA_REG_IFR || val != 0) {
@@ -322,6 +323,9 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
         mdc->portB_write(s);
         break;
     case VIA_REG_A:
+       qemu_log_mask(LOG_UNIMP, "Write access to register A with handshake");
+       /* fall through */
+    case VIA_REG_ANH:
         s->a = (s->a & ~s->dira) | (val & s->dira);
         mdc->portA_write(s);
         break;
@@ -395,9 +399,7 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
                               qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
         break;
     default:
-    case VIA_REG_ANH:
-        s->anh = val;
-        break;
+        g_assert_not_reached();
     }
 }
 
@@ -439,7 +441,6 @@ const VMStateDescription vmstate_mos6522 = {
         VMSTATE_UINT8(pcr, MOS6522State),
         VMSTATE_UINT8(ifr, MOS6522State),
         VMSTATE_UINT8(ier, MOS6522State),
-        VMSTATE_UINT8(anh, MOS6522State),
         VMSTATE_STRUCT_ARRAY(timers, MOS6522State, 2, 0,
                              vmstate_mos6522_timer, MOS6522Timer),
         VMSTATE_END_OF_LIST()
@@ -460,7 +461,6 @@ static void mos6522_reset(DeviceState *dev)
     s->ifr = 0;
     s->ier = 0;
     /* s->ier = T1_INT | SR_INT; */
-    s->anh = 0;
 
     s->timers[0].frequency = s->frequency;
     s->timers[0].latch = 0xffff;
diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
index 493c907537..97384c6e02 100644
--- a/include/hw/misc/mos6522.h
+++ b/include/hw/misc/mos6522.h
@@ -115,7 +115,6 @@ typedef struct MOS6522State {
     uint8_t pcr;
     uint8_t ifr;
     uint8_t ier;
-    uint8_t anh;
 
     MOS6522Timer timers[2];
     uint64_t frequency;
-- 
2.24.1


