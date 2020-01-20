Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C10C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D29D217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnlhiTFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D29D217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itagX-0000Di-Vm
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 12:17:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1itaWW-0005sH-Fo
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:07:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1itaWU-0001hQ-Pd
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:07:36 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:41606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1itaWU-0001gY-KG
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:07:34 -0500
Received: by mail-oi1-x22d.google.com with SMTP id i1so29069028oie.8
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 09:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mQCnOs0DasZCx15BvzrZGXuwOubDqdp3HufF8qDnOq0=;
 b=pnlhiTFx/3MugHFxA5GJwND3D/VFmm9YogyPVFBWy70XlYDZztb6FSEOfSyCaF2K2D
 3T1gjbCL8dx2uRr/jhHTlNmrV9CIzTh4x4wfGBRhGpmMJpBNJCG8WUmytFIIGi9XSqRM
 pQJrsUkiF1FIU/kcs10cTAxtIyQNqEWt+Fe6UVNGWumLwIf8A4Ekto98z2UFCq+4rG/X
 ZNE06z075REy/QMNW70c1nhGG7Wo+ECxEc6AqHAITpPKD0/3kg+/bA3kkZi3FJD+uvS6
 VTRxliW2NFrG6gnFqCgvmcDhRU8hYFJJIad977OO2+YgN3UqTvNx/DzoG8WAVap53Pfj
 M7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mQCnOs0DasZCx15BvzrZGXuwOubDqdp3HufF8qDnOq0=;
 b=jxUcXe++XDrgUHi+leC7BdRuXIEwg1flMfL9lw0eZD+7bfPb2mfvBjNTqYMstp1SMA
 omHyOrx2ET63btbWy4Bh7RRWGhdWpk7sBvXnVX1OD4Gt9bjsVdnnGpdjLY++l/ZoszW5
 rE3hmeiPS0Jz/GCmT8x2fTLvr5OY4/9sws5TCNP/EDinex0EFl7+I0NeWnyosHk0nFv4
 2fXSt9jTBPxwin68NLLwBlVX284XXrS1ociCg2+nyf5jkRLW4ICJS0BYv7BmMbWdZx1Y
 9n7JXAvShugSME7Q2mr6WA2wrdXKFBarc24TJnypY4v43FrR3HseM2v9AHAR7pCERsDS
 1uqA==
X-Gm-Message-State: APjAAAXXiXS1rim5GHb01RVd1qJXdpLJglHWgehsT9unAsTT1h23AcXh
 sRz7RFmj5YcPiD7kD0uRzzckQpw=
X-Google-Smtp-Source: APXvYqwSanX/FiI1lha6ojZ97a9TiG3PUJeQHKMnnVWiNYVvbbzznsyTobMAsihpHYQBXF3xMZtbBQ==
X-Received: by 2002:aca:c386:: with SMTP id t128mr246203oif.32.1579540053128; 
 Mon, 20 Jan 2020 09:07:33 -0800 (PST)
Received: from serve.minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id t23sm11086770oic.28.2020.01.20.09.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 09:07:32 -0800 (PST)
Received: from t560.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:9c9c:d583:ce3d:f87a])
 by serve.minyard.net (Postfix) with ESMTPA id 88523180053;
 Mon, 20 Jan 2020 17:07:31 +0000 (UTC)
From: minyard@acm.org
To: QEMU Developers <qemu-devel@nongnu.org>
Subject: [PATCH 3/5] ipmi: add SET_SENSOR_READING command
Date: Mon, 20 Jan 2020 11:07:23 -0600
Message-Id: <20200120170725.24935-4-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120170725.24935-1-minyard@acm.org>
References: <20200120170725.24935-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cédric Le Goater <clg@kaod.org>

SET_SENSOR_READING is a complex IPMI command (see IPMI spec 35.17)
which enables the host software to set the reading value and the event
status of sensors supporting it.

Below is a proposal for all the operations (reading, assert, deassert,
event data) with the following limitations :

 - No event are generated for threshold-based sensors.
 - The case in which the BMC needs to generate its own events is not
   supported.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Corey Minyard <cminyard@mvista.com>
Message-Id: <20191118092429.16149-1-clg@kaod.org>
[Moved the break statement for case SENSOR_GEN_EVENT_DATA above the
 closing brace to keep the indention consistent.]
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 223 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 223 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 6670cf039d..611a0095df 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -49,6 +49,7 @@
 #define IPMI_CMD_GET_SENSOR_READING       0x2d
 #define IPMI_CMD_SET_SENSOR_TYPE          0x2e
 #define IPMI_CMD_GET_SENSOR_TYPE          0x2f
+#define IPMI_CMD_SET_SENSOR_READING       0x30
 
 /* #define IPMI_NETFN_APP             0x06 In ipmi.h */
 
@@ -1747,6 +1748,227 @@ static void get_sensor_type(IPMIBmcSim *ibs,
     rsp_buffer_push(rsp, sens->evt_reading_type_code);
 }
 
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
+    uint8_t evd1 = 0;
+    uint8_t evd2 = 0;
+    uint8_t evd3 = 0;
+    uint8_t new_reading = 0;
+    uint16_t new_assert_states = 0;
+    uint16_t new_deassert_states = 0;
+    bool change_reading = false;
+    bool change_assert = false;
+    bool change_deassert = false;
+    enum {
+        SENSOR_GEN_EVENT_NONE,
+        SENSOR_GEN_EVENT_DATA,
+        SENSOR_GEN_EVENT_BMC,
+    } do_gen_event = SENSOR_GEN_EVENT_NONE;
+
+    if ((cmd[2] >= MAX_SENSORS) ||
+            !IPMI_SENSOR_GET_PRESENT(ibs->sensors + cmd[2])) {
+        rsp_buffer_set_error(rsp, IPMI_CC_REQ_ENTRY_NOT_PRESENT);
+        return;
+    }
+
+    sens = ibs->sensors + cmd[2];
+
+    /* [1:0] Sensor Reading operation */
+    switch ((cmd[3]) & 0x3) {
+    case 0: /* Do not change */
+        break;
+    case 1: /* write given value to sensor reading byte */
+        new_reading = cmd[4];
+        if (sens->reading != new_reading) {
+            change_reading = true;
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
+            new_deassert_states = cmd[7];
+            change_deassert = true;
+        }
+        if (cmd_len > 8) {
+            new_deassert_states |= (cmd[8] << 8);
+        }
+        break;
+
+    case 2: /* mask on */
+        if (cmd_len > 7) {
+            new_deassert_states = (sens->deassert_states | cmd[7]);
+            change_deassert = true;
+        }
+        if (cmd_len > 8) {
+            new_deassert_states |= (sens->deassert_states | (cmd[8] << 8));
+        }
+        break;
+
+    case 3: /* mask off */
+        if (cmd_len > 7) {
+            new_deassert_states = (sens->deassert_states & cmd[7]);
+            change_deassert = true;
+        }
+        if (cmd_len > 8) {
+            new_deassert_states |= (sens->deassert_states & (cmd[8] << 8));
+        }
+        break;
+    }
+
+    if (change_deassert && (new_deassert_states == sens->deassert_states)) {
+        change_deassert = false;
+    }
+
+    /* [5:4] Assertion bits operation */
+    switch ((cmd[3] >> 4) & 0x3) {
+    case 0: /* Do not change */
+        break;
+    case 1: /* write given value */
+        if (cmd_len > 5) {
+            new_assert_states = cmd[5];
+            change_assert = true;
+        }
+        if (cmd_len > 6) {
+            new_assert_states |= (cmd[6] << 8);
+        }
+        break;
+
+    case 2: /* mask on */
+        if (cmd_len > 5) {
+            new_assert_states = (sens->assert_states | cmd[5]);
+            change_assert = true;
+        }
+        if (cmd_len > 6) {
+            new_assert_states |= (sens->assert_states | (cmd[6] << 8));
+        }
+        break;
+
+    case 3: /* mask off */
+        if (cmd_len > 5) {
+            new_assert_states = (sens->assert_states & cmd[5]);
+            change_assert = true;
+        }
+        if (cmd_len > 6) {
+            new_assert_states |= (sens->assert_states & (cmd[6] << 8));
+        }
+        break;
+    }
+
+    if (change_assert && (new_assert_states == sens->assert_states)) {
+        change_assert = false;
+    }
+
+    if (cmd_len > 9) {
+        evd1 = cmd[9];
+    }
+    if (cmd_len > 10) {
+        evd2 = cmd[10];
+    }
+    if (cmd_len > 11) {
+        evd3 = cmd[11];
+    }
+
+    /* [7:6] Event Data Bytes operation */
+    switch ((cmd[3] >> 6) & 0x3) {
+    case 0: /*
+             * Don’t use Event Data bytes from this command. BMC will
+             * generate it's own Event Data bytes based on its sensor
+             * implementation.
+             */
+        evd1 = evd2 = evd3 = 0x0;
+        do_gen_event = SENSOR_GEN_EVENT_BMC;
+        break;
+    case 1: /*
+             * Write given values to event data bytes including bits
+             * [3:0] Event Data 1.
+             */
+        do_gen_event = SENSOR_GEN_EVENT_DATA;
+        break;
+    case 2: /*
+             * Write given values to event data bytes excluding bits
+             * [3:0] Event Data 1.
+             */
+        evd1 &= 0xf0;
+        do_gen_event = SENSOR_GEN_EVENT_DATA;
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
+    if (do_gen_event == SENSOR_GEN_EVENT_DATA && cmd_len < 10) {
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+        return;
+    }
+
+    /* commit values */
+    if (change_reading) {
+        sens->reading = new_reading;
+    }
+
+    if (change_assert) {
+        sens->assert_states = new_assert_states;
+    }
+
+    if (change_deassert) {
+        sens->deassert_states = new_deassert_states;
+    }
+
+    /* TODO: handle threshold sensor */
+    if (!IPMI_SENSOR_IS_DISCRETE(sens)) {
+        return;
+    }
+
+    switch (do_gen_event) {
+    case SENSOR_GEN_EVENT_DATA: {
+        unsigned int bit = evd1 & 0xf;
+        uint16_t mask = (1 << bit);
+
+        if (sens->assert_states & mask & sens->assert_enable) {
+            gen_event(ibs, cmd[2], 0, evd1, evd2, evd3);
+        }
+
+        if (sens->deassert_states & mask & sens->deassert_enable) {
+            gen_event(ibs, cmd[2], 1, evd1, evd2, evd3);
+        }
+        break;
+    }
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
 
 static const IPMICmdHandler chassis_cmds[] = {
     [IPMI_CMD_GET_CHASSIS_CAPABILITIES] = { chassis_capabilities },
@@ -1768,6 +1990,7 @@ static const IPMICmdHandler sensor_event_cmds[] = {
     [IPMI_CMD_GET_SENSOR_READING] = { get_sensor_reading, 3 },
     [IPMI_CMD_SET_SENSOR_TYPE] = { set_sensor_type, 5 },
     [IPMI_CMD_GET_SENSOR_TYPE] = { get_sensor_type, 3 },
+    [IPMI_CMD_SET_SENSOR_READING] = { set_sensor_reading, 5 },
 };
 static const IPMINetfn sensor_event_netfn = {
     .cmd_nums = ARRAY_SIZE(sensor_event_cmds),
-- 
2.17.1


