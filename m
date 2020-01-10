Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED50EC33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C178820721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C178820721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iprZq-0002Ip-UW
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 05:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iprUZ-0003en-Db
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:26:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iprUX-0007CQ-AD
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:26:11 -0500
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:37362)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iprUX-00078g-1m
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:26:09 -0500
Received: from player786.ha.ovh.net (unknown [10.108.16.88])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 2EE6711DF7D
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 11:26:07 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id 35135E3A07DF;
 Fri, 10 Jan 2020 10:25:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 5/5] misc/pca9552: Add qom set and get
Date: Fri, 10 Jan 2020 11:25:18 +0100
Message-Id: <20200110102518.4233-6-clg@kaod.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200110102518.4233-1-clg@kaod.org>
References: <20200110102518.4233-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 5854398043822197521
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdeifedgudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeekiedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgepud
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.39.154
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joel Stanley <joel@jms.id.au>

Following the pattern of the work recently done with the ASPEED GPIO
model, this adds support for inspecting and modifying the PCA9552 LEDs
from the monitor.

 (qemu) qom-set  /machine/unattached/device[17] led0 on
 (qemu) qom-set  /machine/unattached/device[17] led0 off
 (qemu) qom-set  /machine/unattached/device[17] led0 pwm0
 (qemu) qom-set  /machine/unattached/device[17] led0 pwm1

Signed-off-by: Joel Stanley <joel@jms.id.au>
[clg: - removed the "qom-get" examples from the commit log
      - merged memory leak fixes from Joel ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/misc/pca9552.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index 73be28d9369c..efd961e04148 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -15,12 +15,16 @@
 #include "hw/misc/pca9552.h"
 #include "hw/misc/pca9552_regs.h"
 #include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
=20
 #define PCA9552_LED_ON   0x0
 #define PCA9552_LED_OFF  0x1
 #define PCA9552_LED_PWM0 0x2
 #define PCA9552_LED_PWM1 0x3
=20
+static const char *led_state[] =3D {"on", "off", "pwm0", "pwm1"};
+
 static uint8_t pca9552_pin_get_config(PCA9552State *s, int pin)
 {
     uint8_t reg   =3D PCA9552_LS0 + (pin / 4);
@@ -169,6 +173,82 @@ static int pca9552_event(I2CSlave *i2c, enum i2c_eve=
nt event)
     return 0;
 }
=20
+static void pca9552_get_led(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    PCA9552State *s =3D PCA9552(obj);
+    int led, rc, reg;
+    uint8_t state;
+
+    rc =3D sscanf(name, "led%2d", &led);
+    if (rc !=3D 1) {
+        error_setg(errp, "%s: error reading %s", __func__, name);
+        return;
+    }
+    if (led < 0 || led > s->nr_leds) {
+        error_setg(errp, "%s invalid led %s", __func__, name);
+        return;
+    }
+    /*
+     * Get the LSx register as the qom interface should expose the devic=
e
+     * state, not the modeled 'input line' behaviour which would come fr=
om
+     * reading the INPUTx reg
+     */
+    reg =3D PCA9552_LS0 + led / 4;
+    state =3D (pca9552_read(s, reg) >> (led % 8)) & 0x3;
+    visit_type_str(v, name, (char **)&led_state[state], errp);
+}
+
+/*
+ * Return an LED selector register value based on an existing one, with
+ * the appropriate 2-bit state value set for the given LED number (0-3).
+ */
+static inline uint8_t pca955x_ledsel(uint8_t oldval, int led_num, int st=
ate)
+{
+        return (oldval & (~(0x3 << (led_num << 1)))) |
+                ((state & 0x3) << (led_num << 1));
+}
+
+static void pca9552_set_led(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    PCA9552State *s =3D PCA9552(obj);
+    Error *local_err =3D NULL;
+    int led, rc, reg, val;
+    uint8_t state;
+    char *state_str;
+
+    visit_type_str(v, name, &state_str, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    rc =3D sscanf(name, "led%2d", &led);
+    if (rc !=3D 1) {
+        error_setg(errp, "%s: error reading %s", __func__, name);
+        return;
+    }
+    if (led < 0 || led > s->nr_leds) {
+        error_setg(errp, "%s invalid led %s", __func__, name);
+        return;
+    }
+
+    for (state =3D 0; state < ARRAY_SIZE(led_state); state++) {
+        if (!strcmp(state_str, led_state[state])) {
+            break;
+        }
+    }
+    if (state >=3D ARRAY_SIZE(led_state)) {
+        error_setg(errp, "%s invalid led state %s", __func__, state_str)=
;
+        return;
+    }
+
+    reg =3D PCA9552_LS0 + led / 4;
+    val =3D pca9552_read(s, reg);
+    val =3D pca955x_ledsel(val, led % 4, state);
+    pca9552_write(s, reg, val);
+}
+
 static const VMStateDescription pca9552_vmstate =3D {
     .name =3D "PCA9552",
     .version_id =3D 0,
@@ -204,6 +284,7 @@ static void pca9552_reset(DeviceState *dev)
 static void pca9552_initfn(Object *obj)
 {
     PCA9552State *s =3D PCA9552(obj);
+    int led;
=20
     /* If support for the other PCA955X devices are implemented, these
      * constant values might be part of class structure describing the
@@ -211,6 +292,15 @@ static void pca9552_initfn(Object *obj)
      */
     s->max_reg =3D PCA9552_LS3;
     s->nr_leds =3D 16;
+
+    for (led =3D 0; led < s->nr_leds; led++) {
+        char *name;
+
+        name =3D g_strdup_printf("led%d", led);
+        object_property_add(obj, name, "bool", pca9552_get_led, pca9552_=
set_led,
+                            NULL, NULL, NULL);
+        g_free(name);
+    }
 }
=20
 static void pca9552_class_init(ObjectClass *klass, void *data)
--=20
2.21.1


