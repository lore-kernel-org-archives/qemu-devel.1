Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6B6C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F6FF20727
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6FF20727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWdHh-0002tt-7r
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 04:25:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iWdGy-0002H2-Sj
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:24:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iWdGx-0000WT-9c
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:24:40 -0500
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:41154)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iWdGx-0000Vr-0U
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:24:39 -0500
Received: from player734.ha.ovh.net (unknown [10.108.54.9])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 920EF122684
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 10:24:36 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id 8D4BEC24FEFC;
 Mon, 18 Nov 2019 09:24:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Corey Minyard <cminyard@mvista.com>
Subject: [PATCH] ipmi: add SET_SENSOR_READING command
Date: Mon, 18 Nov 2019 10:24:29 +0100
Message-Id: <20191118092429.16149-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 7157345709182651320
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeghedgtdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.111.180
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
Cc: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SET_SENSOR_READING is a complex IPMI command (see IPMI spec 35.17)
which enables the host software to set the reading value and the event
status of sensors supporting it.

Below is a proposal for all the operations (reading, assert, deassert,
event data) with the following limitations :

 - No event are generated for threshold-based sensors.
 - The case in which the BMC needs to generate its own events is not
   supported.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 223 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 223 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 6670cf039d1a..b6cf7b123f74 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -49,6 +49,7 @@
 #define IPMI_CMD_GET_SENSOR_READING       0x2d
 #define IPMI_CMD_SET_SENSOR_TYPE          0x2e
 #define IPMI_CMD_GET_SENSOR_TYPE          0x2f
+#define IPMI_CMD_SET_SENSOR_READING       0x30
=20
 /* #define IPMI_NETFN_APP             0x06 In ipmi.h */
=20
@@ -1747,6 +1748,227 @@ static void get_sensor_type(IPMIBmcSim *ibs,
     rsp_buffer_push(rsp, sens->evt_reading_type_code);
 }
=20
+/*
+ * bytes   parameter
+ *    1    sensor number
+ *    2    operation (see below for bits meaning)
+ *    3    sensor reading
+ *  4:5    assertion states (optional)
+ *  6:7    deassertion states (optional)
+ *  8:10   event data 1,2,3 (optional)
+ */
+static void set_sensor_reading(IPMIBmcSim *ibs,
+                               uint8_t *cmd, unsigned int cmd_len,
+                               RspBuffer *rsp)
+{
+    IPMISensor *sens;
+    uint8_t evd1 =3D 0;
+    uint8_t evd2 =3D 0;
+    uint8_t evd3 =3D 0;
+    uint8_t new_reading =3D 0;
+    uint16_t new_assert_states =3D 0;
+    uint16_t new_deassert_states =3D 0;
+    bool change_reading =3D false;
+    bool change_assert =3D false;
+    bool change_deassert =3D false;
+    enum {
+        SENSOR_GEN_EVENT_NONE,
+        SENSOR_GEN_EVENT_DATA,
+        SENSOR_GEN_EVENT_BMC,
+    } do_gen_event =3D SENSOR_GEN_EVENT_NONE;
+
+    if ((cmd[2] >=3D MAX_SENSORS) ||
+            !IPMI_SENSOR_GET_PRESENT(ibs->sensors + cmd[2])) {
+        rsp_buffer_set_error(rsp, IPMI_CC_REQ_ENTRY_NOT_PRESENT);
+        return;
+    }
+
+    sens =3D ibs->sensors + cmd[2];
+
+    /* [1:0] Sensor Reading operation */
+    switch ((cmd[3]) & 0x3) {
+    case 0: /* Do not change */
+        break;
+    case 1: /* write given value to sensor reading byte */
+        new_reading =3D cmd[4];
+        if (sens->reading !=3D new_reading) {
+            change_reading =3D true;
+        }
+        break;
+    case 2:
+    case 3:
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+        return;
+    }
+
+    /* [3:2] Deassertion bits operation */
+    switch ((cmd[3] >> 2) & 0x3) {
+    case 0: /* Do not change */
+        break;
+    case 1: /* write given value */
+        if (cmd_len > 7) {
+            new_deassert_states =3D cmd[7];
+            change_deassert =3D true;
+        }
+        if (cmd_len > 8) {
+            new_deassert_states |=3D (cmd[8] << 8);
+        }
+        break;
+
+    case 2: /* mask on */
+        if (cmd_len > 7) {
+            new_deassert_states =3D (sens->deassert_states | cmd[7]);
+            change_deassert =3D true;
+        }
+        if (cmd_len > 8) {
+            new_deassert_states |=3D (sens->deassert_states | (cmd[8] <<=
 8));
+        }
+        break;
+
+    case 3: /* mask off */
+        if (cmd_len > 7) {
+            new_deassert_states =3D (sens->deassert_states & cmd[7]);
+            change_deassert =3D true;
+        }
+        if (cmd_len > 8) {
+            new_deassert_states |=3D (sens->deassert_states & (cmd[8] <<=
 8));
+        }
+        break;
+    }
+
+    if (change_deassert && (new_deassert_states =3D=3D sens->deassert_st=
ates)) {
+        change_deassert =3D false;
+    }
+
+    /* [5:4] Assertion bits operation */
+    switch ((cmd[3] >> 4) & 0x3) {
+    case 0: /* Do not change */
+        break;
+    case 1: /* write given value */
+        if (cmd_len > 5) {
+            new_assert_states =3D cmd[5];
+            change_assert =3D true;
+        }
+        if (cmd_len > 6) {
+            new_assert_states |=3D (cmd[6] << 8);
+        }
+        break;
+
+    case 2: /* mask on */
+        if (cmd_len > 5) {
+            new_assert_states =3D (sens->assert_states | cmd[5]);
+            change_assert =3D true;
+        }
+        if (cmd_len > 6) {
+            new_assert_states |=3D (sens->assert_states | (cmd[6] << 8))=
;
+        }
+        break;
+
+    case 3: /* mask off */
+        if (cmd_len > 5) {
+            new_assert_states =3D (sens->assert_states & cmd[5]);
+            change_assert =3D true;
+        }
+        if (cmd_len > 6) {
+            new_assert_states |=3D (sens->assert_states & (cmd[6] << 8))=
;
+        }
+        break;
+    }
+
+    if (change_assert && (new_assert_states =3D=3D sens->assert_states))=
 {
+        change_assert =3D false;
+    }
+
+    if (cmd_len > 9) {
+        evd1 =3D cmd[9];
+    }
+    if (cmd_len > 10) {
+        evd2 =3D cmd[10];
+    }
+    if (cmd_len > 11) {
+        evd3 =3D cmd[11];
+    }
+
+    /* [7:6] Event Data Bytes operation */
+    switch ((cmd[3] >> 6) & 0x3) {
+    case 0: /*
+             * Don=E2=80=99t use Event Data bytes from this command. BMC=
 will
+             * generate it's own Event Data bytes based on its sensor
+             * implementation.
+             */
+        evd1 =3D evd2 =3D evd3 =3D 0x0;
+        do_gen_event =3D SENSOR_GEN_EVENT_BMC;
+        break;
+    case 1: /*
+             * Write given values to event data bytes including bits
+             * [3:0] Event Data 1.
+             */
+        do_gen_event =3D SENSOR_GEN_EVENT_DATA;
+        break;
+    case 2: /*
+             * Write given values to event data bytes excluding bits
+             * [3:0] Event Data 1.
+             */
+        evd1 &=3D 0xf0;
+        do_gen_event =3D SENSOR_GEN_EVENT_DATA;
+        break;
+    case 3:
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+        return;
+    }
+
+    /*
+     * Event Data Bytes operation and parameter are inconsistent. The
+     * Specs are not clear on that topic but generating an error seems
+     * correct.
+     */
+    if (do_gen_event =3D=3D SENSOR_GEN_EVENT_DATA && cmd_len < 10) {
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+        return;
+    }
+
+    /* commit values */
+    if (change_reading) {
+        sens->reading =3D new_reading;
+    }
+
+    if (change_assert) {
+        sens->assert_states =3D new_assert_states;
+    }
+
+    if (change_deassert) {
+        sens->deassert_states =3D new_deassert_states;
+    }
+
+    /* TODO: handle threshold sensor */
+    if (!IPMI_SENSOR_IS_DISCRETE(sens)) {
+        return;
+    }
+
+    switch (do_gen_event) {
+    case SENSOR_GEN_EVENT_DATA: {
+        unsigned int bit =3D evd1 & 0xf;
+        uint16_t mask =3D (1 << bit);
+
+        if (sens->assert_states & mask & sens->assert_enable) {
+            gen_event(ibs, cmd[2], 0, evd1, evd2, evd3);
+        }
+
+        if (sens->deassert_states & mask & sens->deassert_enable) {
+            gen_event(ibs, cmd[2], 1, evd1, evd2, evd3);
+        }
+    }
+        break;
+    case SENSOR_GEN_EVENT_BMC:
+        /*
+         * TODO: generate event and event data bytes depending on the
+         * sensor
+         */
+        break;
+    case SENSOR_GEN_EVENT_NONE:
+        break;
+    }
+}
=20
 static const IPMICmdHandler chassis_cmds[] =3D {
     [IPMI_CMD_GET_CHASSIS_CAPABILITIES] =3D { chassis_capabilities },
@@ -1768,6 +1990,7 @@ static const IPMICmdHandler sensor_event_cmds[] =3D=
 {
     [IPMI_CMD_GET_SENSOR_READING] =3D { get_sensor_reading, 3 },
     [IPMI_CMD_SET_SENSOR_TYPE] =3D { set_sensor_type, 5 },
     [IPMI_CMD_GET_SENSOR_TYPE] =3D { get_sensor_type, 3 },
+    [IPMI_CMD_SET_SENSOR_READING] =3D { set_sensor_reading, 5 },
 };
 static const IPMINetfn sensor_event_netfn =3D {
     .cmd_nums =3D ARRAY_SIZE(sensor_event_cmds),
--=20
2.21.0


