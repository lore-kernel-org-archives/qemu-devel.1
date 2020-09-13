Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C3AC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 23:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A7521D1A
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 23:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwVgi/RE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A7521D1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHbiI-0007W0-Fj
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 19:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ameynarkhede03@gmail.com>)
 id 1kHbgM-0006AB-Ry
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 19:45:18 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33153)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ameynarkhede03@gmail.com>)
 id 1kHbgK-00027c-Pz
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 19:45:18 -0400
Received: by mail-pf1-x441.google.com with SMTP id c196so11169253pfc.0
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 16:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6C86PRe3PD1jHOlF067N6BH04+k7qnO7PTI/UUZDrl8=;
 b=fwVgi/RECgT/8vq1m9jYLNewQZTIXDYl+umVwrTcSAFPe5srlcSv+NU5C4oG1Cnvjy
 RjWHYYzVydhmGR7EHfBLwTMpYiLrTRhKsdpwGtiYO3LWfOepKc7e59cktkPdM10OXtfu
 TGwmDK9O88xaS7W9D7GqjiMbYKgPNvOBwvbeYRESxZsNLUtX17Zp6fGD/udiMRsV3Lmi
 WXFw4zjhUo0fqV7cgJJwU/lAjBaWlHdRxh9M1/fNkAiVn3338qbivDgQE2gFHvcXd4PV
 mtyG1S5OR6aNdUixDklGqy4d8RRwSXssL0uSpf0Ps6oZW3YXMdFtKJqHU4u9iVDVvOuU
 PJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6C86PRe3PD1jHOlF067N6BH04+k7qnO7PTI/UUZDrl8=;
 b=AblSiVmVyxRhQJr6Wr2pQkfHJsTrNfW6vaNgsWSgl1pl7/FZnNZFRR+cCbz1IKeoyX
 0/DBo+WLxKl7FgLqy7wilp8WZIZBtV/5+od0veGDiEWTBR2lXhGMOAB7j5sV9Ue2ohlx
 Fv5VBCz5yn25nXalZs9O7GLhinZGdr2j12VD0DjoCwCJh/2TXh/qkfQcwn2eY9YExjLX
 I5aDss6jOIFnzSeruxIwOER2A4ffjKDH1MUjjm+nNffcXusENd9GMp3fqeKWr4P3R0TK
 IsZWCc8k/3YrKSfSR8gE76m+aTim5S5A/XBXEoqcx0u7s1O41Lsyb7TRyxjXTPvU6cpP
 m1Yw==
X-Gm-Message-State: AOAM530RgsJlpYoyWtRCfwVjXvhYpSbzd+qbp9LNqm/DHbzBAqfSKbHQ
 xnimdUrNYPDRLFYGrq6L5y0zLdaGSLGfOHnt
X-Google-Smtp-Source: ABdhPJwK7aQ4/OhIh8mHcBQHdQoIFXqPgluaTDLStUow9zeez1C4eZbfJHSGiX7Xt1kYRBk2LjaRYQ==
X-Received: by 2002:a63:4451:: with SMTP id t17mr8654811pgk.92.1600040714887; 
 Sun, 13 Sep 2020 16:45:14 -0700 (PDT)
Received: from localhost.localdomain ([49.32.9.241])
 by smtp.googlemail.com with ESMTPSA id l1sm6768830pgo.11.2020.09.13.16.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2020 16:45:14 -0700 (PDT)
From: Amey Narkhede <ameynarkhede03@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/scsi/vmw_pvscsi.c: Fix wrong usage of gboolean types in
 PVSCSIState
Date: Mon, 14 Sep 2020 05:14:51 +0530
Message-Id: <20200913234451.170022-1-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=ameynarkhede03@gmail.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, pbonzini@redhat.com,
 Amey Narkhede <ameynarkhede03@gmail.com>, dmitry.fleytman@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

rings_info_valid, msg_ring_info_valid and use_msg fields of struct
PVSCSIState are using gboolean TRUE/FALSE values with the type uint8_t.
Change their type to bool along with the usage of initialization macro
VMSTATE_BOOL during initialization of vmstate_pvscsi and
pvscsi_properties.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 hw/scsi/vmw_pvscsi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index c071e0c7aa..86f00e3d7e 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -123,9 +123,9 @@ typedef struct {
     /* Collector for current command data */
     uint32_t curr_cmd_data[PVSCSI_MAX_CMD_DATA_WORDS];

-    uint8_t rings_info_valid;            /* Whether data rings initialized   */
-    uint8_t msg_ring_info_valid;         /* Whether message ring initialized */
-    uint8_t use_msg;                     /* Whether to use message ring      */
+    bool rings_info_valid;            /* Whether data rings initialized   */
+    bool msg_ring_info_valid;         /* Whether message ring initialized */
+    bool use_msg;                     /* Whether to use message ring      */

     uint8_t msi_used;                    /* For migration compatibility      */
     PVSCSIRingInfo rings;                /* Data transfer rings manager      */
@@ -349,8 +349,8 @@ pvscsi_reset_state(PVSCSIState *s)
     s->reg_command_status = PVSCSI_COMMAND_PROCESSING_SUCCEEDED;
     s->reg_interrupt_status = 0;
     pvscsi_ring_cleanup(&s->rings);
-    s->rings_info_valid = FALSE;
-    s->msg_ring_info_valid = FALSE;
+    s->rings_info_valid = false;
+    s->msg_ring_info_valid = false;
     QTAILQ_INIT(&s->pending_queue);
     QTAILQ_INIT(&s->completion_queue);
 }
@@ -792,7 +792,7 @@ pvscsi_on_cmd_setup_rings(PVSCSIState *s)
     pvscsi_dbg_dump_tx_rings_config(rc);
     pvscsi_ring_init_data(&s->rings, rc);

-    s->rings_info_valid = TRUE;
+    s->rings_info_valid = true;
     return PVSCSI_COMMAND_PROCESSING_SUCCEEDED;
 }

@@ -874,7 +874,7 @@ pvscsi_on_cmd_setup_msg_ring(PVSCSIState *s)
         if (pvscsi_ring_init_msg(&s->rings, rc) < 0) {
             return PVSCSI_COMMAND_PROCESSING_FAILED;
         }
-        s->msg_ring_info_valid = TRUE;
+        s->msg_ring_info_valid = true;
     }
     return sizeof(PVSCSICmdDescSetupMsgRing) / sizeof(uint32_t);
 }
@@ -1232,9 +1232,9 @@ static const VMStateDescription vmstate_pvscsi = {
         VMSTATE_UINT32(curr_cmd_data_cntr, PVSCSIState),
         VMSTATE_UINT32_ARRAY(curr_cmd_data, PVSCSIState,
                              ARRAY_SIZE(((PVSCSIState *)NULL)->curr_cmd_data)),
-        VMSTATE_UINT8(rings_info_valid, PVSCSIState),
-        VMSTATE_UINT8(msg_ring_info_valid, PVSCSIState),
-        VMSTATE_UINT8(use_msg, PVSCSIState),
+        VMSTATE_BOOL(rings_info_valid, PVSCSIState),
+        VMSTATE_BOOL(msg_ring_info_valid, PVSCSIState),
+        VMSTATE_BOOL(use_msg, PVSCSIState),

         VMSTATE_UINT64(rings.rs_pa, PVSCSIState),
         VMSTATE_UINT32(rings.txr_len_mask, PVSCSIState),
@@ -1255,7 +1255,7 @@ static const VMStateDescription vmstate_pvscsi = {
 };

 static Property pvscsi_properties[] = {
-    DEFINE_PROP_UINT8("use_msg", PVSCSIState, use_msg, 1),
+    DEFINE_PROP_BOOL("use_msg", PVSCSIState, use_msg, true),
     DEFINE_PROP_BIT("x-old-pci-configuration", PVSCSIState, compat_flags,
                     PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT, false),
     DEFINE_PROP_BIT("x-disable-pcie", PVSCSIState, compat_flags,
--
2.28.0

This is my first qemu patch. Let know if there are any mistakes

