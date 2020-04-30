Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE30C8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F2420787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgsUcN3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F2420787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU6OP-0000kz-Fb
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 06:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jU6IY-0008Dd-97
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jU6IT-00018b-2u
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:20:06 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c]:44836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jU6IS-00017x-JZ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:20:00 -0400
Received: by mail-lf1-x12c.google.com with SMTP id d25so738744lfi.11
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 03:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H+LlnR11EGsPQDlPMcEJH7+ri0Xqw8l/GkcrB28PjIQ=;
 b=LgsUcN3Pi1rFmJAQC4KL0ptX0ErKAdH11Bor9CRVFBxjvIFz+DYtmRxtRyiXF6RN/4
 fCl7MoQtn/HfPEejf3P8RdaIN6T2xinhW5/yAkvtG0kcyexLJY2ShCE/W5SsTeQLwzHf
 mYaM5F+I3plF/j4Ejggb0IL48qR33ZXGzDBRYJdZ+wEUGq2nApa2Y4uT2PxaWBxw8M0h
 VkBJFzq2wzsMuCOYyQc+Rm15sTq0MsGJOPRHOwdnIF9TTvaXkhH1htP2ShcbQsW7a6wo
 0fXC9I0Qy77+exJmqcXK8PvMWh7jR2j9LkYAp+LEVM4sVNRBDnbebuDbZ/SL6+WO1SiW
 H+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H+LlnR11EGsPQDlPMcEJH7+ri0Xqw8l/GkcrB28PjIQ=;
 b=kgsdiRK/awGY9LDMGcnG+HWYrln3OjKwYEahtqFaGBi62zeg4SN8HscZXmw+BlnyxV
 TDhptRV6xv899gq0uvDuphteOrcjNH1NdzGPUA4lew9bp9JQ9nV/JbVwQVF48pzbIf7w
 FCjJiW2+SXiNPeH0s/j8tSdvdO7mSfWJtwIc42y0xCY8sZLoG5FhWthsZ12VCttQ+KIV
 6m7Gv/pR2Cda3CRWn2/XDk6iXL6X98pEyqdJU616cNcMb8qZtg2NwRz3R2y6x/GbdNQc
 VrSE/cTi7nvwPbyWcLEAFjXpK+2CArCObNT6Yci7TcWKXHigr2cVE0WHfdGYjS7mTkQK
 EJpQ==
X-Gm-Message-State: AGi0PuZUx4Sk2ZUiPlCOo87nhgnR9kvLX8ztM7J8sUm1zaUY8puYnbH/
 amoHjw6mWw1spfNDSlp7+iBf/vCdJ/s=
X-Google-Smtp-Source: APiQypJhksrB0uY3QYRfNoPf1R3vis4aUiKeL2odqkf8KGjlsuyp8mzo7wKpUpzXA5rDwXTYJ2Fq8w==
X-Received: by 2002:a05:6512:1109:: with SMTP id
 l9mr1731682lfg.12.1588241998767; 
 Thu, 30 Apr 2020 03:19:58 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id s8sm4534166lfd.61.2020.04.30.03.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 03:19:57 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 5/6] target/microblaze: Add the pvr-user1 property
Date: Thu, 30 Apr 2020 12:19:48 +0200
Message-Id: <20200430101949.7754-6-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430101949.7754-1-edgar.iglesias@gmail.com>
References: <20200430101949.7754-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12c.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::12c
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add the pvr-user1 property to control the user-defined
PVR0 User1 field.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.h | 1 +
 target/microblaze/cpu.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index ef9081db40..7bb5a3d6c6 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -307,6 +307,7 @@ struct MicroBlazeCPU {
         bool opcode_0_illegal;
         bool div_zero_exception;
         bool unaligned_exceptions;
+        uint8_t pvr_user1;
         char *version;
         uint8_t pvr;
     } cfg;
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 585e60e817..df5ee21dd6 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -193,7 +193,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                         (cpu->cfg.use_mmu ? PVR0_USE_MMU_MASK : 0) |
                         (cpu->cfg.endi ? PVR0_ENDI_MASK : 0) |
                         (version_code << PVR0_VERSION_SHIFT) |
-                        (cpu->cfg.pvr == C_PVR_FULL ? PVR0_PVR_FULL_MASK : 0);
+                        (cpu->cfg.pvr == C_PVR_FULL ? PVR0_PVR_FULL_MASK : 0) |
+                        cpu->cfg.pvr_user1;
 
     env->pvr.regs[2] |= (cpu->cfg.use_fpu ? PVR2_USE_FPU_MASK : 0) |
                         (cpu->cfg.use_fpu > 1 ? PVR2_USE_FPU2_MASK : 0) |
@@ -292,6 +293,7 @@ static Property mb_properties[] = {
                      cfg.opcode_0_illegal, false),
     DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
     DEFINE_PROP_UINT8("pvr", MicroBlazeCPU, cfg.pvr, C_PVR_FULL),
+    DEFINE_PROP_UINT8("pvr-user1", MicroBlazeCPU, cfg.pvr_user1, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.20.1


