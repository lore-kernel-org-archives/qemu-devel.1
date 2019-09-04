Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E1BC3A5AA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A03208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A03208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5d6l-00067p-Sw
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i5cBr-00006Q-39
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i5cBp-00013h-CJ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:47:42 -0400
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:43057)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i5cBp-0000z0-47
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:47:41 -0400
Received: from player691.ha.ovh.net (unknown [10.109.160.23])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 10CD21097D3
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 22:47:39 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id 0BF9698B2814;
 Wed,  4 Sep 2019 20:47:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Wed,  4 Sep 2019 22:46:48 +0200
Message-Id: <20190904204659.13878-5-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190904204659.13878-1-clg@kaod.org>
References: <20190904204659.13878-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 2516104820903217937
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejhedgudehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.61.98
Subject: [Qemu-devel] [RFC PATCH 04/15] aspeed/timer: Add support for AST2600
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

The AST2600 timer has a third control register that is used to
implement a set-to-clear feature for the main control register.

On the AST2600, it is not configurable via 0x38 (control register 3)
as it is on the AST2500.

Based on previous work from Joel Stanley.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/timer/aspeed_timer.h |  1 +
 hw/timer/aspeed_timer.c         | 51 +++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/hw/timer/aspeed_timer.h b/include/hw/timer/aspeed_ti=
mer.h
index 1e0288ebc49f..69b1377af01e 100644
--- a/include/hw/timer/aspeed_timer.h
+++ b/include/hw/timer/aspeed_timer.h
@@ -30,6 +30,7 @@
 #define TYPE_ASPEED_TIMER "aspeed.timer"
 #define TYPE_ASPEED_2400_TIMER TYPE_ASPEED_TIMER "-ast2400"
 #define TYPE_ASPEED_2500_TIMER TYPE_ASPEED_TIMER "-ast2500"
+#define TYPE_ASPEED_2600_TIMER TYPE_ASPEED_TIMER "-ast2600"
=20
 #define ASPEED_TIMER_NR_TIMERS 8
=20
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index d70e78a0293e..7f73d0c75337 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -538,6 +538,40 @@ static void aspeed_2500_timer_write(AspeedTimerCtrlS=
tate *s, hwaddr offset,
     }
 }
=20
+static uint64_t aspeed_2600_timer_read(AspeedTimerCtrlState *s, hwaddr o=
ffset)
+{
+    uint64_t value;
+
+    switch (offset) {
+    case 0x38:
+    case 0x3C:
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx =
"\n",
+                __func__, offset);
+        value =3D 0;
+        break;
+    }
+    return value;
+}
+
+static void aspeed_2600_timer_write(AspeedTimerCtrlState *s, hwaddr offs=
et,
+                                    uint64_t value)
+{
+    const uint32_t tv =3D (uint32_t)(value & 0xFFFFFFFF);
+
+    switch (offset) {
+    case 0x3C:
+        aspeed_timer_set_ctrl(s, s->ctrl & ~tv);
+        break;
+
+    case 0x38:
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx =
"\n",
+                __func__, offset);
+        break;
+    }
+}
+
 static void aspeed_init_one_timer(AspeedTimerCtrlState *s, uint8_t id)
 {
     AspeedTimer *t =3D &s->timers[id];
@@ -674,11 +708,28 @@ static const TypeInfo aspeed_2500_timer_info =3D {
     .class_init =3D aspeed_2500_timer_class_init,
 };
=20
+static void aspeed_2600_timer_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    AspeedTimerClass *awc =3D ASPEED_TIMER_CLASS(klass);
+
+    dc->desc =3D "ASPEED 2600 Timer";
+    awc->read =3D aspeed_2600_timer_read;
+    awc->write =3D aspeed_2600_timer_write;
+}
+
+static const TypeInfo aspeed_2600_timer_info =3D {
+    .name =3D TYPE_ASPEED_2600_TIMER,
+    .parent =3D TYPE_ASPEED_TIMER,
+    .class_init =3D aspeed_2600_timer_class_init,
+};
+
 static void aspeed_timer_register_types(void)
 {
     type_register_static(&aspeed_timer_info);
     type_register_static(&aspeed_2400_timer_info);
     type_register_static(&aspeed_2500_timer_info);
+    type_register_static(&aspeed_2600_timer_info);
 }
=20
 type_init(aspeed_timer_register_types)
--=20
2.21.0


