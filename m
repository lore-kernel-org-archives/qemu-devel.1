Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6090BC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 160F521D79
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="XbZ00S9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160F521D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmp.felk.cvut.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvK8B-0003xi-9T
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 08:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <autobot.majer@seznam.cz>)
 id 1jvK5J-00024d-SL
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:30:57 -0400
Received: from mxa2.seznam.cz ([2a02:598:2::90]:55943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <autobot.majer@seznam.cz>)
 id 1jvK5G-0000Ct-OQ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:30:57 -0400
Received: from email.seznam.cz
 by email-smtpc3b.ng.seznam.cz (email-smtpc3b.ng.seznam.cz [10.23.13.75])
 id 0c4405e1cefb1aa00936e1d5; Tue, 14 Jul 2020 14:30:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
 t=1594729852; bh=06ExxRwFfVYECg6tEOJT7fnHUiiS6UGecvZs8hF0y7E=;
 h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding;
 b=XbZ00S9Gg3okUymmmBo4cs5T3PgZ0sUYPSpzOZ166uj4UbA8LVQYWI1rSSjGqRJHs
 0qLm04YRDp3wu4SiReAmgDBlJXuzCo3YUHPJs28XdHGmk4Fg2NVxEpqOKzks2XHIZe
 9JExGTVaGQvA9VGA1u74gSkL+/utDuGpGJceK2Aw=
Received: from hathi.duckdns.org (2001:718:2:1654:e269:95ff:fec3:1c81
 [2001:718:2:1654:e269:95ff:fec3:1c81])
 by email-relay2.ng.seznam.cz (Seznam SMTPD 1.3.119) with ESMTP;
 Tue, 14 Jul 2020 14:30:47 +0200 (CEST)  
From: pisa@cmp.felk.cvut.cz
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 4/6] hw/net/can/ctucafd: Add CTU CAN FD core register
 definitions.
Date: Tue, 14 Jul 2020 14:20:17 +0200
Message-Id: <df0b5f85bba0bd566332bf7954ef258b89b3ff21.1594725647.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1594725647.git.pisa@cmp.felk.cvut.cz>
References: <cover.1594725647.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:598:2::90;
 envelope-from=autobot.majer@seznam.cz; helo=mxa2.seznam.cz
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>,
 Jiri Novak <jnovak@fel.cvut.cz>, Stefan Hajnoczi <stefanha@gmail.com>,
 Deniz Eren <deniz.eren@icloud.com>, Markus Armbruster <armbru@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Konrad Frederic <frederic.konrad@adacore.com>,
 Jan Charvat <charvj10@fel.cvut.cz>, Jan Kiszka <jan.kiszka@siemens.com>,
 Ondrej Ille <ondrej.ille@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jan Charvat <charvj10@fel.cvut.cz>

Definitions of registers and CAN FD frame message box of CTU CAN FD
IP core are generated the specification in CACTUS/IP-XACT format.

CTU CAN FD IP core repository

  https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core

The location of the CTU CAN IP core specification within
IP core design

  spec/CTU/ip/CAN_FD_IP_Core/2.1/CAN_FD_IP_Core.2.1.xml

The header files are generated by pyXact_generator designed
by Ondrej Ille which is based on ipyxact_parser.

The specification is source of header files for driver and emulation,
documentation and VHDL registers map implementation.

Signed-off-by: Jan Charvat <charvj10@fel.cvut.cz>
Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
---
 hw/net/can/ctu_can_fd_frame.h | 190 +++++++
 hw/net/can/ctu_can_fd_regs.h  | 972 ++++++++++++++++++++++++++++++++++
 2 files changed, 1162 insertions(+)
 create mode 100644 hw/net/can/ctu_can_fd_frame.h
 create mode 100644 hw/net/can/ctu_can_fd_regs.h

diff --git a/hw/net/can/ctu_can_fd_frame.h b/hw/net/can/ctu_can_fd_frame.h
new file mode 100644
index 0000000000..d1d6f8ef24
--- /dev/null
+++ b/hw/net/can/ctu_can_fd_frame.h
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*******************************************************************************
+ *
+ * CTU CAN FD IP Core
+ * Copyright (C) 2015-2018
+ *
+ * Authors:
+ *     Ondrej Ille <ondrej.ille@gmail.com>
+ *     Martin Jerabek <martin.jerabek01@gmail.com>
+ *     Jaroslav Beran <jara.beran@gmail.com>
+ *
+ * Project advisors:
+ *     Jiri Novak <jnovak@fel.cvut.cz>
+ *     Pavel Pisa <pisa@cmp.felk.cvut.cz>
+ *
+ * Department of Measurement         (http://meas.fel.cvut.cz/)
+ * Faculty of Electrical Engineering (http://www.fel.cvut.cz)
+ * Czech Technical University        (http://www.cvut.cz/)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ ******************************************************************************/
+
+/* This file is autogenerated, DO NOT EDIT! */
+
+#ifndef __CTU_CAN_FD_CAN_FD_FRAME_FORMAT__
+#define __CTU_CAN_FD_CAN_FD_FRAME_FORMAT__
+
+/* CAN_Frame_format memory map */
+enum ctu_can_fd_can_frame_format {
+	CTU_CAN_FD_FRAME_FORM_W        = 0x0,
+	CTU_CAN_FD_IDENTIFIER_W        = 0x4,
+	CTU_CAN_FD_TIMESTAMP_L_W       = 0x8,
+	CTU_CAN_FD_TIMESTAMP_U_W       = 0xc,
+	CTU_CAN_FD_DATA_1_4_W         = 0x10,
+	CTU_CAN_FD_DATA_5_8_W         = 0x14,
+	CTU_CAN_FD_DATA_61_64_W       = 0x4c,
+};
+
+
+/* Register descriptions: */
+union ctu_can_fd_frame_form_w {
+	uint32_t u32;
+	struct ctu_can_fd_frame_form_w_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* FRAME_FORM_W */
+		uint32_t dlc                     : 4;
+		uint32_t reserved_4              : 1;
+		uint32_t rtr                     : 1;
+		uint32_t ide                     : 1;
+		uint32_t fdf                     : 1;
+		uint32_t reserved_8              : 1;
+		uint32_t brs                     : 1;
+		uint32_t esi_rsv                 : 1;
+		uint32_t rwcnt                   : 5;
+		uint32_t reserved_31_16         : 16;
+#else
+		uint32_t reserved_31_16         : 16;
+		uint32_t rwcnt                   : 5;
+		uint32_t esi_rsv                 : 1;
+		uint32_t brs                     : 1;
+		uint32_t reserved_8              : 1;
+		uint32_t fdf                     : 1;
+		uint32_t ide                     : 1;
+		uint32_t rtr                     : 1;
+		uint32_t reserved_4              : 1;
+		uint32_t dlc                     : 4;
+#endif
+	} s;
+};
+
+enum ctu_can_fd_frame_form_w_rtr {
+	NO_RTR_FRAME       = 0x0,
+	RTR_FRAME          = 0x1,
+};
+
+enum ctu_can_fd_frame_form_w_ide {
+	BASE           = 0x0,
+	EXTENDED       = 0x1,
+};
+
+enum ctu_can_fd_frame_form_w_fdf {
+	NORMAL_CAN       = 0x0,
+	FD_CAN           = 0x1,
+};
+
+enum ctu_can_fd_frame_form_w_brs {
+	BR_NO_SHIFT       = 0x0,
+	BR_SHIFT          = 0x1,
+};
+
+enum ctu_can_fd_frame_form_w_esi_rsv {
+	ESI_ERR_ACTIVE       = 0x0,
+	ESI_ERR_PASIVE       = 0x1,
+};
+
+union ctu_can_fd_identifier_w {
+	uint32_t u32;
+	struct ctu_can_fd_identifier_w_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* IDENTIFIER_W */
+		uint32_t identifier_ext         : 18;
+		uint32_t identifier_base        : 11;
+		uint32_t reserved_31_29          : 3;
+#else
+		uint32_t reserved_31_29          : 3;
+		uint32_t identifier_base        : 11;
+		uint32_t identifier_ext         : 18;
+#endif
+	} s;
+};
+
+union ctu_can_fd_timestamp_l_w {
+	uint32_t u32;
+	struct ctu_can_fd_timestamp_l_w_s {
+  /* TIMESTAMP_L_W */
+		uint32_t time_stamp_31_0        : 32;
+	} s;
+};
+
+union ctu_can_fd_timestamp_u_w {
+	uint32_t u32;
+	struct ctu_can_fd_timestamp_u_w_s {
+  /* TIMESTAMP_U_W */
+		uint32_t timestamp_l_w          : 32;
+	} s;
+};
+
+union ctu_can_fd_data_1_4_w {
+	uint32_t u32;
+	struct ctu_can_fd_data_1_4_w_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* DATA_1_4_W */
+		uint32_t data_1                  : 8;
+		uint32_t data_2                  : 8;
+		uint32_t data_3                  : 8;
+		uint32_t data_4                  : 8;
+#else
+		uint32_t data_4                  : 8;
+		uint32_t data_3                  : 8;
+		uint32_t data_2                  : 8;
+		uint32_t data_1                  : 8;
+#endif
+	} s;
+};
+
+union ctu_can_fd_data_5_8_w {
+	uint32_t u32;
+	struct ctu_can_fd_data_5_8_w_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* DATA_5_8_W */
+		uint32_t data_5                  : 8;
+		uint32_t data_6                  : 8;
+		uint32_t data_7                  : 8;
+		uint32_t data_8                  : 8;
+#else
+		uint32_t data_8                  : 8;
+		uint32_t data_7                  : 8;
+		uint32_t data_6                  : 8;
+		uint32_t data_5                  : 8;
+#endif
+	} s;
+};
+
+union ctu_can_fd_data_61_64_w {
+	uint32_t u32;
+	struct ctu_can_fd_data_61_64_w_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* DATA_61_64_W */
+		uint32_t data_61                 : 8;
+		uint32_t data_62                 : 8;
+		uint32_t data_63                 : 8;
+		uint32_t data_64                 : 8;
+#else
+		uint32_t data_64                 : 8;
+		uint32_t data_63                 : 8;
+		uint32_t data_62                 : 8;
+		uint32_t data_61                 : 8;
+#endif
+	} s;
+};
+
+#endif
diff --git a/hw/net/can/ctu_can_fd_regs.h b/hw/net/can/ctu_can_fd_regs.h
new file mode 100644
index 0000000000..a3b3b5c374
--- /dev/null
+++ b/hw/net/can/ctu_can_fd_regs.h
@@ -0,0 +1,972 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*******************************************************************************
+ *
+ * CTU CAN FD IP Core
+ * Copyright (C) 2015-2018
+ *
+ * Authors:
+ *     Ondrej Ille <ondrej.ille@gmail.com>
+ *     Martin Jerabek <martin.jerabek01@gmail.com>
+ *     Jaroslav Beran <jara.beran@gmail.com>
+ *
+ * Project advisors:
+ *     Jiri Novak <jnovak@fel.cvut.cz>
+ *     Pavel Pisa <pisa@cmp.felk.cvut.cz>
+ *
+ * Department of Measurement         (http://meas.fel.cvut.cz/)
+ * Faculty of Electrical Engineering (http://www.fel.cvut.cz)
+ * Czech Technical University        (http://www.cvut.cz/)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ ******************************************************************************/
+
+/* This file is autogenerated, DO NOT EDIT! */
+
+#ifndef __CTU_CAN_FD_CAN_FD_REGISTER_MAP__
+#define __CTU_CAN_FD_CAN_FD_REGISTER_MAP__
+
+/* CAN_Registers memory map */
+enum ctu_can_fd_can_registers {
+	CTU_CAN_FD_DEVICE_ID             = 0x0,
+	CTU_CAN_FD_VERSION               = 0x2,
+	CTU_CAN_FD_MODE                  = 0x4,
+	CTU_CAN_FD_SETTINGS              = 0x6,
+	CTU_CAN_FD_STATUS                = 0x8,
+	CTU_CAN_FD_COMMAND               = 0xc,
+	CTU_CAN_FD_INT_STAT             = 0x10,
+	CTU_CAN_FD_INT_ENA_SET          = 0x14,
+	CTU_CAN_FD_INT_ENA_CLR          = 0x18,
+	CTU_CAN_FD_INT_MASK_SET         = 0x1c,
+	CTU_CAN_FD_INT_MASK_CLR         = 0x20,
+	CTU_CAN_FD_BTR                  = 0x24,
+	CTU_CAN_FD_BTR_FD               = 0x28,
+	CTU_CAN_FD_EWL                  = 0x2c,
+	CTU_CAN_FD_ERP                  = 0x2d,
+	CTU_CAN_FD_FAULT_STATE          = 0x2e,
+	CTU_CAN_FD_REC                  = 0x30,
+	CTU_CAN_FD_TEC                  = 0x32,
+	CTU_CAN_FD_ERR_NORM             = 0x34,
+	CTU_CAN_FD_ERR_FD               = 0x36,
+	CTU_CAN_FD_CTR_PRES             = 0x38,
+	CTU_CAN_FD_FILTER_A_MASK        = 0x3c,
+	CTU_CAN_FD_FILTER_A_VAL         = 0x40,
+	CTU_CAN_FD_FILTER_B_MASK        = 0x44,
+	CTU_CAN_FD_FILTER_B_VAL         = 0x48,
+	CTU_CAN_FD_FILTER_C_MASK        = 0x4c,
+	CTU_CAN_FD_FILTER_C_VAL         = 0x50,
+	CTU_CAN_FD_FILTER_RAN_LOW       = 0x54,
+	CTU_CAN_FD_FILTER_RAN_HIGH      = 0x58,
+	CTU_CAN_FD_FILTER_CONTROL       = 0x5c,
+	CTU_CAN_FD_FILTER_STATUS        = 0x5e,
+	CTU_CAN_FD_RX_MEM_INFO          = 0x60,
+	CTU_CAN_FD_RX_POINTERS          = 0x64,
+	CTU_CAN_FD_RX_STATUS            = 0x68,
+	CTU_CAN_FD_RX_SETTINGS          = 0x6a,
+	CTU_CAN_FD_RX_DATA              = 0x6c,
+	CTU_CAN_FD_TX_STATUS            = 0x70,
+	CTU_CAN_FD_TX_COMMAND           = 0x74,
+	CTU_CAN_FD_TX_PRIORITY          = 0x78,
+	CTU_CAN_FD_ERR_CAPT             = 0x7c,
+	CTU_CAN_FD_ALC                  = 0x7e,
+	CTU_CAN_FD_TRV_DELAY            = 0x80,
+	CTU_CAN_FD_SSP_CFG              = 0x82,
+	CTU_CAN_FD_RX_FR_CTR            = 0x84,
+	CTU_CAN_FD_TX_FR_CTR            = 0x88,
+	CTU_CAN_FD_DEBUG_REGISTER       = 0x8c,
+	CTU_CAN_FD_YOLO_REG             = 0x90,
+	CTU_CAN_FD_TIMESTAMP_LOW        = 0x94,
+	CTU_CAN_FD_TIMESTAMP_HIGH       = 0x98,
+	CTU_CAN_FD_TXTB1_DATA_1        = 0x100,
+	CTU_CAN_FD_TXTB1_DATA_2        = 0x104,
+	CTU_CAN_FD_TXTB1_DATA_20       = 0x14c,
+	CTU_CAN_FD_TXTB2_DATA_1        = 0x200,
+	CTU_CAN_FD_TXTB2_DATA_2        = 0x204,
+	CTU_CAN_FD_TXTB2_DATA_20       = 0x24c,
+	CTU_CAN_FD_TXTB3_DATA_1        = 0x300,
+	CTU_CAN_FD_TXTB3_DATA_2        = 0x304,
+	CTU_CAN_FD_TXTB3_DATA_20       = 0x34c,
+	CTU_CAN_FD_TXTB4_DATA_1        = 0x400,
+	CTU_CAN_FD_TXTB4_DATA_2        = 0x404,
+	CTU_CAN_FD_TXTB4_DATA_20       = 0x44c,
+};
+
+
+/* Register descriptions: */
+union ctu_can_fd_device_id_version {
+	uint32_t u32;
+	struct ctu_can_fd_device_id_version_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* DEVICE_ID */
+		uint32_t device_id              : 16;
+  /* VERSION */
+		uint32_t ver_minor               : 8;
+		uint32_t ver_major               : 8;
+#else
+		uint32_t ver_major               : 8;
+		uint32_t ver_minor               : 8;
+		uint32_t device_id              : 16;
+#endif
+	} s;
+};
+
+enum ctu_can_fd_device_id_device_id {
+	CTU_CAN_FD_ID    = 0xcafd,
+};
+
+union ctu_can_fd_mode_settings {
+	uint32_t u32;
+	struct ctu_can_fd_mode_settings_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* MODE */
+		uint32_t rst                     : 1;
+		uint32_t lom                     : 1;
+		uint32_t stm                     : 1;
+		uint32_t afm                     : 1;
+		uint32_t fde                     : 1;
+		uint32_t reserved_6_5            : 2;
+		uint32_t acf                     : 1;
+		uint32_t tstm                    : 1;
+		uint32_t reserved_15_9           : 7;
+  /* SETTINGS */
+		uint32_t rtrle                   : 1;
+		uint32_t rtrth                   : 4;
+		uint32_t ilbp                    : 1;
+		uint32_t ena                     : 1;
+		uint32_t nisofd                  : 1;
+		uint32_t pex                     : 1;
+		uint32_t reserved_31_25          : 7;
+#else
+		uint32_t reserved_31_25          : 7;
+		uint32_t pex                     : 1;
+		uint32_t nisofd                  : 1;
+		uint32_t ena                     : 1;
+		uint32_t ilbp                    : 1;
+		uint32_t rtrth                   : 4;
+		uint32_t rtrle                   : 1;
+		uint32_t reserved_15_9           : 7;
+		uint32_t tstm                    : 1;
+		uint32_t acf                     : 1;
+		uint32_t reserved_6_5            : 2;
+		uint32_t fde                     : 1;
+		uint32_t afm                     : 1;
+		uint32_t stm                     : 1;
+		uint32_t lom                     : 1;
+		uint32_t rst                     : 1;
+#endif
+	} s;
+};
+
+enum ctu_can_fd_mode_lom {
+	LOM_DISABLED       = 0x0,
+	LOM_ENABLED        = 0x1,
+};
+
+enum ctu_can_fd_mode_stm {
+	STM_DISABLED       = 0x0,
+	STM_ENABLED        = 0x1,
+};
+
+enum ctu_can_fd_mode_afm {
+	AFM_DISABLED       = 0x0,
+	AFM_ENABLED        = 0x1,
+};
+
+enum ctu_can_fd_mode_fde {
+	FDE_DISABLE       = 0x0,
+	FDE_ENABLE        = 0x1,
+};
+
+enum ctu_can_fd_mode_acf {
+	ACF_DISABLED       = 0x0,
+	ACF_ENABLED        = 0x1,
+};
+
+enum ctu_can_fd_settings_rtrle {
+	RTRLE_DISABLED       = 0x0,
+	RTRLE_ENABLED        = 0x1,
+};
+
+enum ctu_can_fd_settings_ilbp {
+	INT_LOOP_DISABLED       = 0x0,
+	INT_LOOP_ENABLED        = 0x1,
+};
+
+enum ctu_can_fd_settings_ena {
+	CTU_CAN_DISABLED       = 0x0,
+	CTU_CAN_ENABLED        = 0x1,
+};
+
+enum ctu_can_fd_settings_nisofd {
+	ISO_FD           = 0x0,
+	NON_ISO_FD       = 0x1,
+};
+
+enum ctu_can_fd_settings_pex {
+	PROTOCOL_EXCEPTION_DISABLED       = 0x0,
+	PROTOCOL_EXCEPTION_ENABLED        = 0x1,
+};
+
+union ctu_can_fd_status {
+	uint32_t u32;
+	struct ctu_can_fd_status_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* STATUS */
+		uint32_t rxne                    : 1;
+		uint32_t dor                     : 1;
+		uint32_t txnf                    : 1;
+		uint32_t eft                     : 1;
+		uint32_t rxs                     : 1;
+		uint32_t txs                     : 1;
+		uint32_t ewl                     : 1;
+		uint32_t idle                    : 1;
+		uint32_t reserved_31_8          : 24;
+#else
+		uint32_t reserved_31_8          : 24;
+		uint32_t idle                    : 1;
+		uint32_t ewl                     : 1;
+		uint32_t txs                     : 1;
+		uint32_t rxs                     : 1;
+		uint32_t eft                     : 1;
+		uint32_t txnf                    : 1;
+		uint32_t dor                     : 1;
+		uint32_t rxne                    : 1;
+#endif
+	} s;
+};
+
+union ctu_can_fd_command {
+	uint32_t u32;
+	struct ctu_can_fd_command_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+		uint32_t reserved_1_0            : 2;
+  /* COMMAND */
+		uint32_t rrb                     : 1;
+		uint32_t cdo                     : 1;
+		uint32_t ercrst                  : 1;
+		uint32_t rxfcrst                 : 1;
+		uint32_t txfcrst                 : 1;
+		uint32_t reserved_31_7          : 25;
+#else
+		uint32_t reserved_31_7          : 25;
+		uint32_t txfcrst                 : 1;
+		uint32_t rxfcrst                 : 1;
+		uint32_t ercrst                  : 1;
+		uint32_t cdo                     : 1;
+		uint32_t rrb                     : 1;
+		uint32_t reserved_1_0            : 2;
+#endif
+	} s;
+};
+
+union ctu_can_fd_int_stat {
+	uint32_t u32;
+	struct ctu_can_fd_int_stat_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* INT_STAT */
+		uint32_t rxi                     : 1;
+		uint32_t txi                     : 1;
+		uint32_t ewli                    : 1;
+		uint32_t doi                     : 1;
+		uint32_t fcsi                    : 1;
+		uint32_t ali                     : 1;
+		uint32_t bei                     : 1;
+		uint32_t ofi                     : 1;
+		uint32_t rxfi                    : 1;
+		uint32_t bsi                     : 1;
+		uint32_t rbnei                   : 1;
+		uint32_t txbhci                  : 1;
+		uint32_t reserved_31_12         : 20;
+#else
+		uint32_t reserved_31_12         : 20;
+		uint32_t txbhci                  : 1;
+		uint32_t rbnei                   : 1;
+		uint32_t bsi                     : 1;
+		uint32_t rxfi                    : 1;
+		uint32_t ofi                     : 1;
+		uint32_t bei                     : 1;
+		uint32_t ali                     : 1;
+		uint32_t fcsi                    : 1;
+		uint32_t doi                     : 1;
+		uint32_t ewli                    : 1;
+		uint32_t txi                     : 1;
+		uint32_t rxi                     : 1;
+#endif
+	} s;
+};
+
+union ctu_can_fd_int_ena_set {
+	uint32_t u32;
+	struct ctu_can_fd_int_ena_set_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* INT_ENA_SET */
+		uint32_t int_ena_set            : 12;
+		uint32_t reserved_31_12         : 20;
+#else
+		uint32_t reserved_31_12         : 20;
+		uint32_t int_ena_set            : 12;
+#endif
+	} s;
+};
+
+union ctu_can_fd_int_ena_clr {
+	uint32_t u32;
+	struct ctu_can_fd_int_ena_clr_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* INT_ENA_CLR */
+		uint32_t int_ena_clr            : 12;
+		uint32_t reserved_31_12         : 20;
+#else
+		uint32_t reserved_31_12         : 20;
+		uint32_t int_ena_clr            : 12;
+#endif
+	} s;
+};
+
+union ctu_can_fd_int_mask_set {
+	uint32_t u32;
+	struct ctu_can_fd_int_mask_set_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* INT_MASK_SET */
+		uint32_t int_mask_set           : 12;
+		uint32_t reserved_31_12         : 20;
+#else
+		uint32_t reserved_31_12         : 20;
+		uint32_t int_mask_set           : 12;
+#endif
+	} s;
+};
+
+union ctu_can_fd_int_mask_clr {
+	uint32_t u32;
+	struct ctu_can_fd_int_mask_clr_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* INT_MASK_CLR */
+		uint32_t int_mask_clr           : 12;
+		uint32_t reserved_31_12         : 20;
+#else
+		uint32_t reserved_31_12         : 20;
+		uint32_t int_mask_clr           : 12;
+#endif
+	} s;
+};
+
+union ctu_can_fd_btr {
+	uint32_t u32;
+	struct ctu_can_fd_btr_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* BTR */
+		uint32_t prop                    : 7;
+		uint32_t ph1                     : 6;
+		uint32_t ph2                     : 6;
+		uint32_t brp                     : 8;
+		uint32_t sjw                     : 5;
+#else
+		uint32_t sjw                     : 5;
+		uint32_t brp                     : 8;
+		uint32_t ph2                     : 6;
+		uint32_t ph1                     : 6;
+		uint32_t prop                    : 7;
+#endif
+	} s;
+};
+
+union ctu_can_fd_btr_fd {
+	uint32_t u32;
+	struct ctu_can_fd_btr_fd_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* BTR_FD */
+		uint32_t prop_fd                 : 6;
+		uint32_t reserved_6              : 1;
+		uint32_t ph1_fd                  : 5;
+		uint32_t reserved_12             : 1;
+		uint32_t ph2_fd                  : 5;
+		uint32_t reserved_18             : 1;
+		uint32_t brp_fd                  : 8;
+		uint32_t sjw_fd                  : 5;
+#else
+		uint32_t sjw_fd                  : 5;
+		uint32_t brp_fd                  : 8;
+		uint32_t reserved_18             : 1;
+		uint32_t ph2_fd                  : 5;
+		uint32_t reserved_12             : 1;
+		uint32_t ph1_fd                  : 5;
+		uint32_t reserved_6              : 1;
+		uint32_t prop_fd                 : 6;
+#endif
+	} s;
+};
+
+union ctu_can_fd_ewl_erp_fault_state {
+	uint32_t u32;
+	struct ctu_can_fd_ewl_erp_fault_state_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* EWL */
+		uint32_t ew_limit                : 8;
+  /* ERP */
+		uint32_t erp_limit               : 8;
+  /* FAULT_STATE */
+		uint32_t era                     : 1;
+		uint32_t erp                     : 1;
+		uint32_t bof                     : 1;
+		uint32_t reserved_31_19         : 13;
+#else
+		uint32_t reserved_31_19         : 13;
+		uint32_t bof                     : 1;
+		uint32_t erp                     : 1;
+		uint32_t era                     : 1;
+		uint32_t erp_limit               : 8;
+		uint32_t ew_limit                : 8;
+#endif
+	} s;
+};
+
+union ctu_can_fd_rec_tec {
+	uint32_t u32;
+	struct ctu_can_fd_rec_tec_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* REC */
+		uint32_t rec_val                 : 9;
+		uint32_t reserved_15_9           : 7;
+  /* TEC */
+		uint32_t tec_val                 : 9;
+		uint32_t reserved_31_25          : 7;
+#else
+		uint32_t reserved_31_25          : 7;
+		uint32_t tec_val                 : 9;
+		uint32_t reserved_15_9           : 7;
+		uint32_t rec_val                 : 9;
+#endif
+	} s;
+};
+
+union ctu_can_fd_err_norm_err_fd {
+	uint32_t u32;
+	struct ctu_can_fd_err_norm_err_fd_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* ERR_NORM */
+		uint32_t err_norm_val           : 16;
+  /* ERR_FD */
+		uint32_t err_fd_val             : 16;
+#else
+		uint32_t err_fd_val             : 16;
+		uint32_t err_norm_val           : 16;
+#endif
+	} s;
+};
+
+union ctu_can_fd_ctr_pres {
+	uint32_t u32;
+	struct ctu_can_fd_ctr_pres_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* CTR_PRES */
+		uint32_t ctpv                    : 9;
+		uint32_t ptx                     : 1;
+		uint32_t prx                     : 1;
+		uint32_t enorm                   : 1;
+		uint32_t efd                     : 1;
+		uint32_t reserved_31_13         : 19;
+#else
+		uint32_t reserved_31_13         : 19;
+		uint32_t efd                     : 1;
+		uint32_t enorm                   : 1;
+		uint32_t prx                     : 1;
+		uint32_t ptx                     : 1;
+		uint32_t ctpv                    : 9;
+#endif
+	} s;
+};
+
+union ctu_can_fd_filter_a_mask {
+	uint32_t u32;
+	struct ctu_can_fd_filter_a_mask_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* FILTER_A_MASK */
+		uint32_t bit_mask_a_val         : 29;
+		uint32_t reserved_31_29          : 3;
+#else
+		uint32_t reserved_31_29          : 3;
+		uint32_t bit_mask_a_val         : 29;
+#endif
+	} s;
+};
+
+union ctu_can_fd_filter_a_val {
+	uint32_t u32;
+	struct ctu_can_fd_filter_a_val_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* FILTER_A_VAL */
+		uint32_t bit_val_a_val          : 29;
+		uint32_t reserved_31_29          : 3;
+#else
+		uint32_t reserved_31_29          : 3;
+		uint32_t bit_val_a_val          : 29;
+#endif
+	} s;
+};
+
+union ctu_can_fd_filter_b_mask {
+	uint32_t u32;
+	struct ctu_can_fd_filter_b_mask_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* FILTER_B_MASK */
+		uint32_t bit_mask_b_val         : 29;
+		uint32_t reserved_31_29          : 3;
+#else
+		uint32_t reserved_31_29          : 3;
+		uint32_t bit_mask_b_val         : 29;
+#endif
+	} s;
+};
+
+union ctu_can_fd_filter_b_val {
+	uint32_t u32;
+	struct ctu_can_fd_filter_b_val_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* FILTER_B_VAL */
+		uint32_t bit_val_b_val          : 29;
+		uint32_t reserved_31_29          : 3;
+#else
+		uint32_t reserved_31_29          : 3;
+		uint32_t bit_val_b_val          : 29;
+#endif
+	} s;
+};
+
+union ctu_can_fd_filter_c_mask {
+	uint32_t u32;
+	struct ctu_can_fd_filter_c_mask_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* FILTER_C_MASK */
+		uint32_t bit_mask_c_val         : 29;
+		uint32_t reserved_31_29          : 3;
+#else
+		uint32_t reserved_31_29          : 3;
+		uint32_t bit_mask_c_val         : 29;
+#endif
+	} s;
+};
+
+union ctu_can_fd_filter_c_val {
+	uint32_t u32;
+	struct ctu_can_fd_filter_c_val_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* FILTER_C_VAL */
+		uint32_t bit_val_c_val          : 29;
+		uint32_t reserved_31_29          : 3;
+#else
+		uint32_t reserved_31_29          : 3;
+		uint32_t bit_val_c_val          : 29;
+#endif
+	} s;
+};
+
+union ctu_can_fd_filter_ran_low {
+	uint32_t u32;
+	struct ctu_can_fd_filter_ran_low_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* FILTER_RAN_LOW */
+		uint32_t bit_ran_low_val        : 29;
+		uint32_t reserved_31_29          : 3;
+#else
+		uint32_t reserved_31_29          : 3;
+		uint32_t bit_ran_low_val        : 29;
+#endif
+	} s;
+};
+
+union ctu_can_fd_filter_ran_high {
+	uint32_t u32;
+	struct ctu_can_fd_filter_ran_high_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* FILTER_RAN_HIGH */
+		uint32_t bit_ran_high_val       : 29;
+		uint32_t reserved_31_29          : 3;
+#else
+		uint32_t reserved_31_29          : 3;
+		uint32_t bit_ran_high_val       : 29;
+#endif
+	} s;
+};
+
+union ctu_can_fd_filter_control_filter_status {
+	uint32_t u32;
+	struct ctu_can_fd_filter_control_filter_status_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* FILTER_CONTROL */
+		uint32_t fanb                    : 1;
+		uint32_t fane                    : 1;
+		uint32_t fafb                    : 1;
+		uint32_t fafe                    : 1;
+		uint32_t fbnb                    : 1;
+		uint32_t fbne                    : 1;
+		uint32_t fbfb                    : 1;
+		uint32_t fbfe                    : 1;
+		uint32_t fcnb                    : 1;
+		uint32_t fcne                    : 1;
+		uint32_t fcfb                    : 1;
+		uint32_t fcfe                    : 1;
+		uint32_t frnb                    : 1;
+		uint32_t frne                    : 1;
+		uint32_t frfb                    : 1;
+		uint32_t frfe                    : 1;
+  /* FILTER_STATUS */
+		uint32_t sfa                     : 1;
+		uint32_t sfb                     : 1;
+		uint32_t sfc                     : 1;
+		uint32_t sfr                     : 1;
+		uint32_t reserved_31_20         : 12;
+#else
+		uint32_t reserved_31_20         : 12;
+		uint32_t sfr                     : 1;
+		uint32_t sfc                     : 1;
+		uint32_t sfb                     : 1;
+		uint32_t sfa                     : 1;
+		uint32_t frfe                    : 1;
+		uint32_t frfb                    : 1;
+		uint32_t frne                    : 1;
+		uint32_t frnb                    : 1;
+		uint32_t fcfe                    : 1;
+		uint32_t fcfb                    : 1;
+		uint32_t fcne                    : 1;
+		uint32_t fcnb                    : 1;
+		uint32_t fbfe                    : 1;
+		uint32_t fbfb                    : 1;
+		uint32_t fbne                    : 1;
+		uint32_t fbnb                    : 1;
+		uint32_t fafe                    : 1;
+		uint32_t fafb                    : 1;
+		uint32_t fane                    : 1;
+		uint32_t fanb                    : 1;
+#endif
+	} s;
+};
+
+union ctu_can_fd_rx_mem_info {
+	uint32_t u32;
+	struct ctu_can_fd_rx_mem_info_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* RX_MEM_INFO */
+		uint32_t rx_buff_size           : 13;
+		uint32_t reserved_15_13          : 3;
+		uint32_t rx_mem_free            : 13;
+		uint32_t reserved_31_29          : 3;
+#else
+		uint32_t reserved_31_29          : 3;
+		uint32_t rx_mem_free            : 13;
+		uint32_t reserved_15_13          : 3;
+		uint32_t rx_buff_size           : 13;
+#endif
+	} s;
+};
+
+union ctu_can_fd_rx_pointers {
+	uint32_t u32;
+	struct ctu_can_fd_rx_pointers_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* RX_POINTERS */
+		uint32_t rx_wpp                 : 12;
+		uint32_t reserved_15_12          : 4;
+		uint32_t rx_rpp                 : 12;
+		uint32_t reserved_31_28          : 4;
+#else
+		uint32_t reserved_31_28          : 4;
+		uint32_t rx_rpp                 : 12;
+		uint32_t reserved_15_12          : 4;
+		uint32_t rx_wpp                 : 12;
+#endif
+	} s;
+};
+
+union ctu_can_fd_rx_status_rx_settings {
+	uint32_t u32;
+	struct ctu_can_fd_rx_status_rx_settings_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* RX_STATUS */
+		uint32_t rxe                     : 1;
+		uint32_t rxf                     : 1;
+		uint32_t reserved_3_2            : 2;
+		uint32_t rxfrc                  : 11;
+		uint32_t reserved_15             : 1;
+  /* RX_SETTINGS */
+		uint32_t rtsop                   : 1;
+		uint32_t reserved_31_17         : 15;
+#else
+		uint32_t reserved_31_17         : 15;
+		uint32_t rtsop                   : 1;
+		uint32_t reserved_15             : 1;
+		uint32_t rxfrc                  : 11;
+		uint32_t reserved_3_2            : 2;
+		uint32_t rxf                     : 1;
+		uint32_t rxe                     : 1;
+#endif
+	} s;
+};
+
+enum ctu_can_fd_rx_settings_rtsop {
+	RTS_END       = 0x0,
+	RTS_BEG       = 0x1,
+};
+
+union ctu_can_fd_rx_data {
+	uint32_t u32;
+	struct ctu_can_fd_rx_data_s {
+  /* RX_DATA */
+		uint32_t rx_data                : 32;
+	} s;
+};
+
+union ctu_can_fd_tx_status {
+	uint32_t u32;
+	struct ctu_can_fd_tx_status_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* TX_STATUS */
+		uint32_t tx1s                    : 4;
+		uint32_t tx2s                    : 4;
+		uint32_t tx3s                    : 4;
+		uint32_t tx4s                    : 4;
+		uint32_t reserved_31_16         : 16;
+#else
+		uint32_t reserved_31_16         : 16;
+		uint32_t tx4s                    : 4;
+		uint32_t tx3s                    : 4;
+		uint32_t tx2s                    : 4;
+		uint32_t tx1s                    : 4;
+#endif
+	} s;
+};
+
+enum ctu_can_fd_tx_status_tx1s {
+	TXT_RDY        = 0x1,
+	TXT_TRAN       = 0x2,
+	TXT_ABTP       = 0x3,
+	TXT_TOK        = 0x4,
+	TXT_ERR        = 0x6,
+	TXT_ABT        = 0x7,
+	TXT_ETY        = 0x8,
+};
+
+union ctu_can_fd_tx_command {
+	uint32_t u32;
+	struct ctu_can_fd_tx_command_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* TX_COMMAND */
+		uint32_t txce                    : 1;
+		uint32_t txcr                    : 1;
+		uint32_t txca                    : 1;
+		uint32_t reserved_7_3            : 5;
+		uint32_t txb1                    : 1;
+		uint32_t txb2                    : 1;
+		uint32_t txb3                    : 1;
+		uint32_t txb4                    : 1;
+		uint32_t reserved_31_12         : 20;
+#else
+		uint32_t reserved_31_12         : 20;
+		uint32_t txb4                    : 1;
+		uint32_t txb3                    : 1;
+		uint32_t txb2                    : 1;
+		uint32_t txb1                    : 1;
+		uint32_t reserved_7_3            : 5;
+		uint32_t txca                    : 1;
+		uint32_t txcr                    : 1;
+		uint32_t txce                    : 1;
+#endif
+	} s;
+};
+
+union ctu_can_fd_tx_priority {
+	uint32_t u32;
+	struct ctu_can_fd_tx_priority_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* TX_PRIORITY */
+		uint32_t txt1p                   : 3;
+		uint32_t reserved_3              : 1;
+		uint32_t txt2p                   : 3;
+		uint32_t reserved_7              : 1;
+		uint32_t txt3p                   : 3;
+		uint32_t reserved_11             : 1;
+		uint32_t txt4p                   : 3;
+		uint32_t reserved_31_15         : 17;
+#else
+		uint32_t reserved_31_15         : 17;
+		uint32_t txt4p                   : 3;
+		uint32_t reserved_11             : 1;
+		uint32_t txt3p                   : 3;
+		uint32_t reserved_7              : 1;
+		uint32_t txt2p                   : 3;
+		uint32_t reserved_3              : 1;
+		uint32_t txt1p                   : 3;
+#endif
+	} s;
+};
+
+union ctu_can_fd_err_capt_alc {
+	uint32_t u32;
+	struct ctu_can_fd_err_capt_alc_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* ERR_CAPT */
+		uint32_t err_pos                 : 5;
+		uint32_t err_type                : 3;
+		uint32_t reserved_15_8           : 8;
+  /* ALC */
+		uint32_t alc_bit                 : 5;
+		uint32_t alc_id_field            : 3;
+		uint32_t reserved_31_24          : 8;
+#else
+		uint32_t reserved_31_24          : 8;
+		uint32_t alc_id_field            : 3;
+		uint32_t alc_bit                 : 5;
+		uint32_t reserved_15_8           : 8;
+		uint32_t err_type                : 3;
+		uint32_t err_pos                 : 5;
+#endif
+	} s;
+};
+
+enum ctu_can_fd_err_capt_err_pos {
+	ERC_POS_SOF         = 0x0,
+	ERC_POS_ARB         = 0x1,
+	ERC_POS_CTRL        = 0x2,
+	ERC_POS_DATA        = 0x3,
+	ERC_POS_CRC         = 0x4,
+	ERC_POS_ACK         = 0x5,
+	ERC_POS_EOF         = 0x6,
+	ERC_POS_ERR         = 0x7,
+	ERC_POS_OVRL        = 0x8,
+	ERC_POS_OTHER      = 0x1f,
+};
+
+enum ctu_can_fd_err_capt_err_type {
+	ERC_BIT_ERR        = 0x0,
+	ERC_CRC_ERR        = 0x1,
+	ERC_FRM_ERR        = 0x2,
+	ERC_ACK_ERR        = 0x3,
+	ERC_STUF_ERR       = 0x4,
+};
+
+enum ctu_can_fd_alc_alc_id_field {
+	ALC_RSVD            = 0x0,
+	ALC_BASE_ID         = 0x1,
+	ALC_SRR_RTR         = 0x2,
+	ALC_IDE             = 0x3,
+	ALC_EXTENSION       = 0x4,
+	ALC_RTR             = 0x5,
+};
+
+union ctu_can_fd_trv_delay_ssp_cfg {
+	uint32_t u32;
+	struct ctu_can_fd_trv_delay_ssp_cfg_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* TRV_DELAY */
+		uint32_t trv_delay_value         : 7;
+		uint32_t reserved_15_7           : 9;
+  /* SSP_CFG */
+		uint32_t ssp_offset              : 8;
+		uint32_t ssp_src                 : 2;
+		uint32_t reserved_31_26          : 6;
+#else
+		uint32_t reserved_31_26          : 6;
+		uint32_t ssp_src                 : 2;
+		uint32_t ssp_offset              : 8;
+		uint32_t reserved_15_7           : 9;
+		uint32_t trv_delay_value         : 7;
+#endif
+	} s;
+};
+
+enum ctu_can_fd_ssp_cfg_ssp_src {
+	SSP_SRC_MEAS_N_OFFSET       = 0x0,
+	SSP_SRC_NO_SSP              = 0x1,
+	SSP_SRC_OFFSET              = 0x2,
+};
+
+union ctu_can_fd_rx_fr_ctr {
+	uint32_t u32;
+	struct ctu_can_fd_rx_fr_ctr_s {
+  /* RX_FR_CTR */
+		uint32_t rx_fr_ctr_val          : 32;
+	} s;
+};
+
+union ctu_can_fd_tx_fr_ctr {
+	uint32_t u32;
+	struct ctu_can_fd_tx_fr_ctr_s {
+  /* TX_FR_CTR */
+		uint32_t tx_fr_ctr_val          : 32;
+	} s;
+};
+
+union ctu_can_fd_debug_register {
+	uint32_t u32;
+	struct ctu_can_fd_debug_register_s {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+  /* DEBUG_REGISTER */
+		uint32_t stuff_count             : 3;
+		uint32_t destuff_count           : 3;
+		uint32_t pc_arb                  : 1;
+		uint32_t pc_con                  : 1;
+		uint32_t pc_dat                  : 1;
+		uint32_t pc_stc                  : 1;
+		uint32_t pc_crc                  : 1;
+		uint32_t pc_crcd                 : 1;
+		uint32_t pc_ack                  : 1;
+		uint32_t pc_ackd                 : 1;
+		uint32_t pc_eof                  : 1;
+		uint32_t pc_int                  : 1;
+		uint32_t pc_susp                 : 1;
+		uint32_t pc_ovr                  : 1;
+		uint32_t pc_sof                  : 1;
+		uint32_t reserved_31_19         : 13;
+#else
+		uint32_t reserved_31_19         : 13;
+		uint32_t pc_sof                  : 1;
+		uint32_t pc_ovr                  : 1;
+		uint32_t pc_susp                 : 1;
+		uint32_t pc_int                  : 1;
+		uint32_t pc_eof                  : 1;
+		uint32_t pc_ackd                 : 1;
+		uint32_t pc_ack                  : 1;
+		uint32_t pc_crcd                 : 1;
+		uint32_t pc_crc                  : 1;
+		uint32_t pc_stc                  : 1;
+		uint32_t pc_dat                  : 1;
+		uint32_t pc_con                  : 1;
+		uint32_t pc_arb                  : 1;
+		uint32_t destuff_count           : 3;
+		uint32_t stuff_count             : 3;
+#endif
+	} s;
+};
+
+union ctu_can_fd_yolo_reg {
+	uint32_t u32;
+	struct ctu_can_fd_yolo_reg_s {
+  /* YOLO_REG */
+		uint32_t yolo_val               : 32;
+	} s;
+};
+
+union ctu_can_fd_timestamp_low {
+	uint32_t u32;
+	struct ctu_can_fd_timestamp_low_s {
+  /* TIMESTAMP_LOW */
+		uint32_t timestamp_low          : 32;
+	} s;
+};
+
+union ctu_can_fd_timestamp_high {
+	uint32_t u32;
+	struct ctu_can_fd_timestamp_high_s {
+  /* TIMESTAMP_HIGH */
+		uint32_t timestamp_high         : 32;
+	} s;
+};
+
+#endif
-- 
2.20.1


