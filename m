Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D14C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:19:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9347021D43
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vocityjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9347021D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYqt-0008QW-Mr
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 04:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYlC-0005fH-Ca
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:50 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:33702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYlA-0000RN-ID
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:49 -0400
Received: by mail-pf1-x42f.google.com with SMTP id c196so4851145pfc.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 01:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vE/7atJFFNMf4U1vrclSfvdzLU1YHOKY7LV5LqTlxi8=;
 b=VocityjnqEGnIw5Y2AYa4Mi3SdhHy79dxnKzkUvZOM3vl7gT5anhbUd7cycj60/iE0
 6f2hlHJShVjmzBv+n3TXzmCqSVFvW8Ws85vsg7NF7wBIAFsScW6WmZDXxG5++h6jeYD5
 PVvv10jusCN39YEBm2w9NRUyB0d4FhFxwCn0249CoBRNN5+Iy3Xr3VcDA8mAg8MFzUfs
 Ofn1W4F1TvYngP2zQAAATdHYm9gTw4hEkAG6GFoGyOu+Y5+9q89WKfbjf8ugQzNYzuOQ
 ZPBLcvk9KeVMxZaykqJ+/0DEMNhKE0BRwGaQrXmTDCHwIsR14gRiHf6GfOA/wLQJtaVj
 T8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vE/7atJFFNMf4U1vrclSfvdzLU1YHOKY7LV5LqTlxi8=;
 b=FjOhrKZRfGtFCjL5A+h23rsm4C7hQV356JPDSrOqfnrNUINnsAfsObBfmRjhX8XGio
 cdhIXq+OZykVGn+C3N3YdhN6OH1i3ZrCOuDx8n6gbrGIjSdPUEY93No0vDTlAAPuHqP3
 0uyNxk4itEqdLTySIZBEhdsdjPaqw/vrccCqhsPuriJ3xRdPgUCEftKTnIRJ/auD6Rdm
 5FxDU/+9rYwpB2OiVkHvLoeGskHTMC9iOlm5pmWRLIFTvrM0fc5xAHmUKuk2iOfzHdEe
 GkNVrFFXy/KdiErXP9qQ/FF6NojfJXnqkhczBfyYdn6EOf6f+9d+AtqDOFNCE0FpSkn9
 ks0g==
X-Gm-Message-State: AOAM532P330fp6Qqd89o3i1t3s3TbE8fTA2G8ltv7RuQjQcEmzichYgY
 j17r0VzY/mScHxKynzTo1xXh
X-Google-Smtp-Source: ABdhPJyujUzTLCCFFkWhLzFL3oeEftWrE4zVsyuKPzKyCRWRHXbBzdYjiEE+8PJErQmX4iiov0dhzw==
X-Received: by 2002:a63:d409:: with SMTP id a9mr18751991pgh.312.1599552827222; 
 Tue, 08 Sep 2020 01:13:47 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id m190sm16934788pfm.184.2020.09.08.01.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 01:13:46 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v2 04/12] target/arm: spe: Only enable SPE from 5.2 compat
 machines.
Date: Tue,  8 Sep 2020 08:13:22 +0000
Message-Id: <7ed8b1ff7a61132c6520f87213c61784ab0c331b.1599549462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599549462.git.haibo.xu@linaro.org>
References: <cover.1599549462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=haibo.xu@linaro.org; helo=mail-pf1-x42f.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, Haibo Xu <haibo.xu@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
---
 hw/arm/virt.c         | 7 +++++++
 include/hw/arm/virt.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index acf9bfbece..3f6d26c531 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1830,6 +1830,10 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "pmu", false, NULL);
         }
 
+        if (vmc->no_spe && object_property_find(cpuobj, "spe", NULL)) {
+            object_property_set_bool(cpuobj, "spe", false, NULL);
+        }
+
         if (object_property_find(cpuobj, "reset-cbar", NULL)) {
             object_property_set_int(cpuobj, "reset-cbar",
                                     vms->memmap[VIRT_CPUPERIPHS].base,
@@ -2553,8 +2557,11 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 2)
 
 static void virt_machine_5_1_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_5_2_options(mc);
     compat_props_add(mc->compat_props, hw_compat_5_1, hw_compat_5_1_len);
+    vmc->no_spe = true;
 }
 DEFINE_VIRT_MACHINE(5, 1)
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index dff67e1bef..72c269aaa5 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -126,6 +126,7 @@ typedef struct {
     bool no_ged;   /* Machines < 4.2 has no support for ACPI GED device */
     bool kvm_no_adjvtime;
     bool acpi_expose_flash;
+    bool no_spe;
 } VirtMachineClass;
 
 typedef struct {
-- 
2.17.1


