Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17466C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2DC9208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="njosnHao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2DC9208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBagm-0003yF-28
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBach-0004af-7T
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:39 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:50883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacf-0004KD-GI
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id t2so305747wma.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ytws2G2vdwDCedoP9AQB1YpWX7L6H56Ji0Orxd+JfWk=;
 b=njosnHaoF5qbbFedi+pCml+nZyxJQM0Tou5qZ3ubvbCe1fIQPZkOBKAE/n8LdbhUwm
 rYCQBaVZadL+ob8e/16AigtLbLVFCSS6CR1+eulcFaKH9lHv1fP/ZnB+pccWXK4K+69m
 NUBDuzKtPLfOF7rgE//MukQvCJxH+baJLIERNTFkeSFe0BDPDxKakBRz8DGDKlyxlhL3
 RMWpYy0yqH+z/a8MQ29V3Km5n9Jka/kQyAEPaRMANDYagdBodrXTg9wFXnhT4hGFCZ+6
 nweUZXuGPFuAtIB2jcLA5/KDzillOqIWS8ackcHfKNprRKajc667HgBKrviaVvRtgxjM
 se+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ytws2G2vdwDCedoP9AQB1YpWX7L6H56Ji0Orxd+JfWk=;
 b=mPS0awflGA+5wMoMG1lBZ18uHDZsGreuvbCaq/JEC0rTv7wo294/JjCCVQ3uOzWsWu
 1ObkcjJX3+9aSSLN33nfdrfqMa/hbTMeSoN/QBuQaqGDinvLyE8UF+0EnAIfUMoYgoil
 pBAzEdNujvuR7VTLQmI/RL3+Smwv27L8ZKuRtEHx6lctxcZu7aPx5JDT+CsftJyeDS39
 Ge6MxlwsMMHpYzb0w8o1IE9TkOHPUVi+1W4HAwEUBdo59E2Xl2yvH5gv5MEkpdp4R1qz
 +Q8u/6EtYMSPwa7/UO8miJhfPitnwK3h9s5o+XZVlIL0n+SPCe/NHBKrcMbQ1rFJTV06
 B9Lg==
X-Gm-Message-State: AOAM531MyWB1QBiHbIjsdkxPLpqlae/KFZ1NekxYtaW808w8crXPV091
 klLWdUK7FvKfCJdvRtqTMAzubuep3BqTrMkc
X-Google-Smtp-Source: ABdhPJxdl9g5yvKtjqkeW0Ylp09NbGFjPacZW8jxhxXMmVT2KRrlak1cA3dGMrm982GiAIVIvvo+vQ==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr726819wmh.95.1598606675794;
 Fri, 28 Aug 2020 02:24:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/35] armsse: Define ARMSSEClass correctly
Date: Fri, 28 Aug 2020 10:23:56 +0100
Message-Id: <20200828092413.22206-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

TYPE_ARM_SSE is a TYPE_SYS_BUS_DEVICE subclass, but
ARMSSEClass::parent_class is declared as DeviceClass.

It never caused any problems by pure luck:

We were not setting class_size for TYPE_ARM_SSE, so class_size of
TYPE_SYS_BUS_DEVICE was being used (sizeof(SysBusDeviceClass)).
This made the system allocate enough memory for TYPE_ARM_SSE
devices even though ARMSSEClass was too small for a sysbus
device.

Additionally, the ARMSSEClass::info field ended up at the same
offset as SysBusDeviceClass::explicit_ofw_unit_address.  This
would make sysbus_get_fw_dev_path() crash for the device.
Luckily, sysbus_get_fw_dev_path() never gets called for
TYPE_ARM_SSE devices, because qdev_get_fw_dev_path() is only used
by the boot device code, and TYPE_ARM_SSE devices don't appear at
the fw_boot_order list.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-id: 20200826181006.4097163-1-ehabkost@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/armsse.h | 2 +-
 hw/arm/armsse.c         | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index 84080c22993..b10173beabd 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -220,7 +220,7 @@ typedef struct ARMSSE {
 typedef struct ARMSSEInfo ARMSSEInfo;
 
 typedef struct ARMSSEClass {
-    DeviceClass parent_class;
+    SysBusDeviceClass parent_class;
     const ARMSSEInfo *info;
 } ARMSSEClass;
 
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index dcbff9bd8f4..6381bbd94d6 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -1160,6 +1160,7 @@ static const TypeInfo armsse_info = {
     .name = TYPE_ARMSSE,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(ARMSSE),
+    .class_size = sizeof(ARMSSEClass),
     .instance_init = armsse_init,
     .abstract = true,
     .interfaces = (InterfaceInfo[]) {
-- 
2.20.1


