Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414F2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:43:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC93820671
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKQG5mdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC93820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmQ2-0001zM-4W
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jbmP6-00015B-W5; Thu, 21 May 2020 10:42:37 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jbmP6-0001en-3B; Thu, 21 May 2020 10:42:36 -0400
Received: by mail-pf1-x441.google.com with SMTP id b190so3414981pfg.6;
 Thu, 21 May 2020 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=E1WM1GTwjC97SemUEzITVuRwA3aWFXXeChe1zgeDZq8=;
 b=PKQG5mdopsLIk7V+7KV1JcCzOCQVdx4Yqm/CaHGINg2gzyVPF4OvnhSbqXWLU2Hq4J
 xUJRpyIkiW3SztYG75jq+8WULJOsHSFFU7jxAWUNzDXslq1ExABrbFTAzmoz9qrgTUAP
 wqUlZMcPi45wDv+jmgzv7EHiHq8ty+LmcNqV2wZSE+s8cF+MrLauZdJA27dMq9iEc6O9
 nf8MLLjjnfHVNw6OWWMedCEeNDUTcQ2jkqZUIyQPezs6lFsZsMtzb9R05kksjX4TQzZn
 jjDlcmFAGieb66IGl0FLz0zjrSsanKS2Pn/fj7PanObP4fM9LWK6aArqMMyBHsP2E6uY
 KYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=E1WM1GTwjC97SemUEzITVuRwA3aWFXXeChe1zgeDZq8=;
 b=C5h6+Ijgfet6PaWxAJ47YqJwS3sgi+YlCrvq1GNIIwLaZYxaoteMLp4X5GJGgDmQT0
 MS6+Zk/t6Su+rnc4CFtTWCXgiPXVcdYBt7izojLIKV5ZqJ69fOUWi9aHC/KGLU03aMfb
 J8u7PfPz8XfTWbZmFqWPlCEyfkl4O04usXXdLB5O8aeagd5b7dy2n9Cg1A4t9RRVKqQU
 SA8TTtcDhubbpomaobeGP8pBk2nYEbvbiUh2sBOfHOkXp9JBaRvd57yAWcT9ILF2xJfZ
 7LilIMoTTM1SahcXRrqgD8Uunf3eEPtedgpJeRgbFCAgyNj7P68RMluXP3aQAOnI7gWE
 qO8w==
X-Gm-Message-State: AOAM533PXzKkTIsrLfULBNSWANu17uuDf61dMiIgMGPPvV9cbnfC3PR1
 cLLFgej/6/i5BXxCGXTAfKg=
X-Google-Smtp-Source: ABdhPJyYprOveY0rzzzUBbPHeretLF/K7zxPw/PQrRk/x3bHVccvhuBEuVHRHIEl8ijZkcQgkCSFOA==
X-Received: by 2002:a63:e550:: with SMTP id z16mr8840051pgj.92.1590072154321; 
 Thu, 21 May 2020 07:42:34 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v1sm4335820pgl.11.2020.05.21.07.42.32
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 21 May 2020 07:42:33 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 1/2] hw/riscv: sifive_u: Remove the riscv_ prefix of the soc*
 functions
Date: Thu, 21 May 2020 07:42:26 -0700
Message-Id: <1590072147-13035-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

To keep consistency with the machine* functions, remove the riscv_
prefix of the soc* functions.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/sifive_u.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 4299bdf..f9fef2b 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -481,7 +481,7 @@ static void sifive_u_machine_init_register_types(void)
 
 type_init(sifive_u_machine_init_register_types)
 
-static void riscv_sifive_u_soc_init(Object *obj)
+static void sifive_u_soc_instance_init(Object *obj)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     SiFiveUSoCState *s = RISCV_U_SOC(obj);
@@ -520,7 +520,7 @@ static void riscv_sifive_u_soc_init(Object *obj)
                           TYPE_CADENCE_GEM);
 }
 
-static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
+static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     SiFiveUSoCState *s = RISCV_U_SOC(dev);
@@ -635,32 +635,32 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
 }
 
-static Property riscv_sifive_u_soc_props[] = {
+static Property sifive_u_soc_props[] = {
     DEFINE_PROP_UINT32("serial", SiFiveUSoCState, serial, OTP_SERIAL),
     DEFINE_PROP_END_OF_LIST()
 };
 
-static void riscv_sifive_u_soc_class_init(ObjectClass *oc, void *data)
+static void sifive_u_soc_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    device_class_set_props(dc, riscv_sifive_u_soc_props);
-    dc->realize = riscv_sifive_u_soc_realize;
+    device_class_set_props(dc, sifive_u_soc_props);
+    dc->realize = sifive_u_soc_realize;
     /* Reason: Uses serial_hds in realize function, thus can't be used twice */
     dc->user_creatable = false;
 }
 
-static const TypeInfo riscv_sifive_u_soc_type_info = {
+static const TypeInfo sifive_u_soc_type_info = {
     .name = TYPE_RISCV_U_SOC,
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(SiFiveUSoCState),
-    .instance_init = riscv_sifive_u_soc_init,
-    .class_init = riscv_sifive_u_soc_class_init,
+    .instance_init = sifive_u_soc_instance_init,
+    .class_init = sifive_u_soc_class_init,
 };
 
-static void riscv_sifive_u_soc_register_types(void)
+static void sifive_u_soc_register_types(void)
 {
-    type_register_static(&riscv_sifive_u_soc_type_info);
+    type_register_static(&sifive_u_soc_type_info);
 }
 
-type_init(riscv_sifive_u_soc_register_types)
+type_init(sifive_u_soc_register_types)
-- 
2.7.4


