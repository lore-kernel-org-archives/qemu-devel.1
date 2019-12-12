Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046C4C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 19:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC4802073B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 19:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC4802073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifUZe-0004DZ-0o
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 14:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ifUNg-0007VR-9k
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 14:44:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ifUNf-0006oQ-4b
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 14:44:12 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:58415)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1ifUNb-0006cT-P2; Thu, 12 Dec 2019 14:44:08 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MUY9w-1iFC6L3TX6-00QSTU; Thu, 12 Dec 2019 20:44:02 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH] mos6522: remove anh register
Date: Thu, 12 Dec 2019 20:43:59 +0100
Message-Id: <20191212194359.13508-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TkbCZicbBO8E00QHGiYTY59pahKYt1llB7ucbZMACFczBXbjEqS
 1kWKgZIRl544qCYqof2RrM9G4ZZ7xcos/kTfCm3MjIZGvZM7EEgxNfbV5dhigF5nw8U/td5
 DV+6sfdRHQ0GunBV7jqOjQE1MYHEgwuNB40o2MYrumgOFXmecLKpnauAQHlNjHoLRI8iRQ9
 LkbyRVH3GGNqXsDu3tuaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V8W02lgdepM=:oVl7cbaGVrOa9161g3Oz0I
 LrkBQYL5+K9MHgK7OxK8xK/scyr28aad36oq5x/EGRNYu5ft7IYwakD7B3HRPpkvu2XPDGJ+f
 YGeQWmQMu4n5cZTnPKN5kxFY01DN5hAYEGAKKNM03zWLmdSMF+Rxz7GcBivX+bw7QJFR9uBAr
 XpUCoGvJYJszS3ebTCJOQIuA1CXVO+PwVQJkmXRMJQTO+Fa1rB7pmDgwIHdi3jUdExUPDnAAf
 7XG5szWC54NXNhr2u4AyS6ezvUWAo24V/SB66I7shQq71vIbhH2APGkw6B3w0xltnVD48H3mp
 kzQFT1FcD1LdFvWGoA8dhJhox27gPZW7gPy0+GRxkLbmKW44xAC/vv2/KK9c1Luj0lM8iAY51
 geyiMsYBoB87QPum1sLtuqYG7rdNXXlKFd1nHyH8070zkMBl6JcHvMoEJucuETXUYx7bhCJNx
 e8afkFyro/ohJS+03R4qH+z30uQqfz7x9aM/9/+EndaN5TmtcSCcnLKQq4cP3heATwpS4WSyY
 OXW7LL2HAL1kgU6Fb3eesRsh4B9Upb1VsbhGaBXfDLpY6ptB/7YSTXC7416Fz5nnA+p0q1JCo
 y9wHZH4vCfiB5DEsdDJc4WQq7n/V6RzWtSOG6vQQu/Kc4qZVLmVteDPNaFiS+0PoKKH9f18aQ
 qgTMrMO/t4jMptT8yZFgRfssIBvKNKWJ4EpGbeK4Hr2B7Tqs7kxJGVa5YARBf4GBhVOx818d+
 73N3zQc/rekOirtTpL30tvWC4lWhdYTSsEaqBfsDzT9d8Ay9KXnqiW/FP3JcYzxrLvzHWZZY0
 GjtWZtG9RO6dZmuo+zhtMLrxMfphi78UFABuasss9TS5hIDgD/GhIUvRsvmq5HYWgdnaUMbWn
 uZasYjU2AYrjv/keu3Iw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.135
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
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Register addr 1 is defined as buffer A with handshake (vBufAH),
register addr 15 is also defined as buffer A without handshake (vBufA).

Linux kernel has a big "DON'T USE!" next to the register 1 addr
definition (vBufAH), and only uses register 15 (vBufA).

So remove the definition of 'anh' and use only 'a' (with VIA_REG_ANH and
VIA_REG_A).

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/mos6522.c         | 12 ++++--------
 include/hw/misc/mos6522.h |  1 -
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index cecf0be59e..86ede4005c 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -244,6 +244,7 @@ uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size)
         val = s->b;
         break;
     case VIA_REG_A:
+    case VIA_REG_ANH:
         val = s->a;
         break;
     case VIA_REG_DIRB:
@@ -297,9 +298,7 @@ uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size)
         val = s->ier | 0x80;
         break;
     default:
-    case VIA_REG_ANH:
-        val = s->anh;
-        break;
+        g_assert_not_reached();
     }
 
     if (addr != VIA_REG_IFR || val != 0) {
@@ -322,6 +321,7 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
         mdc->portB_write(s);
         break;
     case VIA_REG_A:
+    case VIA_REG_ANH:
         s->a = (s->a & ~s->dira) | (val & s->dira);
         mdc->portA_write(s);
         break;
@@ -395,9 +395,7 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
                               qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
         break;
     default:
-    case VIA_REG_ANH:
-        s->anh = val;
-        break;
+        g_assert_not_reached();
     }
 }
 
@@ -439,7 +437,6 @@ const VMStateDescription vmstate_mos6522 = {
         VMSTATE_UINT8(pcr, MOS6522State),
         VMSTATE_UINT8(ifr, MOS6522State),
         VMSTATE_UINT8(ier, MOS6522State),
-        VMSTATE_UINT8(anh, MOS6522State),
         VMSTATE_STRUCT_ARRAY(timers, MOS6522State, 2, 0,
                              vmstate_mos6522_timer, MOS6522Timer),
         VMSTATE_END_OF_LIST()
@@ -460,7 +457,6 @@ static void mos6522_reset(DeviceState *dev)
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
2.23.0


