Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3218EC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:48:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B7B21D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B7B21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD8ah-0000dR-6l
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 10:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iD8MQ-0003YK-O8
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iD8MP-0000cc-KV
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:33:42 -0400
Received: from 2.mo1.mail-out.ovh.net ([178.32.119.250]:41193)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iD8MP-0000bi-Ey
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:33:41 -0400
Received: from player786.ha.ovh.net (unknown [10.109.143.220])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id AFA38191363
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 16:33:39 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id 23A48A4D3D1E;
 Wed, 25 Sep 2019 14:33:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 05/23] aspeed/timer: Add support for control register 3
Date: Wed, 25 Sep 2019 16:32:30 +0200
Message-Id: <20190925143248.10000-6-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925143248.10000-1-clg@kaod.org>
References: <20190925143248.10000-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 8845914096798960401
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedvgdejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.119.250
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The AST2500 timer has a third control register that is used to
implement a set-to-clear feature for the main control register.

This models the behaviour expected by the AST2500 while maintaining
the same behaviour for the AST2400.

The vmstate version is not increased yet because the structure is
modified again in the following patches.

Based on previous work from Joel Stanley.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/timer/aspeed_timer.h |  1 +
 hw/timer/aspeed_timer.c         | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/hw/timer/aspeed_timer.h b/include/hw/timer/aspeed_ti=
mer.h
index a791fee276f4..1e0288ebc49f 100644
--- a/include/hw/timer/aspeed_timer.h
+++ b/include/hw/timer/aspeed_timer.h
@@ -58,6 +58,7 @@ typedef struct AspeedTimerCtrlState {
=20
     uint32_t ctrl;
     uint32_t ctrl2;
+    uint32_t ctrl3;
     AspeedTimer timers[ASPEED_TIMER_NR_TIMERS];
=20
     AspeedSCUState *scu;
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index c78bc1bd2d25..d70e78a0293e 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -498,6 +498,8 @@ static uint64_t aspeed_2500_timer_read(AspeedTimerCtr=
lState *s, hwaddr offset)
=20
     switch (offset) {
     case 0x38:
+        value =3D s->ctrl3 & BIT(0);
+        break;
     case 0x3C:
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx =
"\n",
@@ -511,9 +513,24 @@ static uint64_t aspeed_2500_timer_read(AspeedTimerCt=
rlState *s, hwaddr offset)
 static void aspeed_2500_timer_write(AspeedTimerCtrlState *s, hwaddr offs=
et,
                                     uint64_t value)
 {
+    const uint32_t tv =3D (uint32_t)(value & 0xFFFFFFFF);
+    uint8_t command;
+
     switch (offset) {
     case 0x38:
+        command =3D (value >> 1) & 0xFF;
+        if (command =3D=3D 0xAE) {
+            s->ctrl3 =3D 0x1;
+        } else if (command =3D=3D 0xEA) {
+            s->ctrl3 =3D 0x0;
+        }
+        break;
     case 0x3C:
+        if (s->ctrl3 & BIT(0)) {
+            aspeed_timer_set_ctrl(s, s->ctrl & ~tv);
+        }
+        break;
+
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx =
"\n",
                 __func__, offset);
@@ -574,6 +591,7 @@ static void aspeed_timer_reset(DeviceState *dev)
     }
     s->ctrl =3D 0;
     s->ctrl2 =3D 0;
+    s->ctrl3 =3D 0;
 }
=20
 static const VMStateDescription vmstate_aspeed_timer =3D {
@@ -597,6 +615,7 @@ static const VMStateDescription vmstate_aspeed_timer_=
state =3D {
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT32(ctrl, AspeedTimerCtrlState),
         VMSTATE_UINT32(ctrl2, AspeedTimerCtrlState),
+        VMSTATE_UINT32(ctrl3, AspeedTimerCtrlState),
         VMSTATE_STRUCT_ARRAY(timers, AspeedTimerCtrlState,
                              ASPEED_TIMER_NR_TIMERS, 1, vmstate_aspeed_t=
imer,
                              AspeedTimer),
--=20
2.21.0


