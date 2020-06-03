Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4088CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0152E20679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTHGmDYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0152E20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUrv-0004X7-5U
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1jgUlO-0007RQ-7c; Wed, 03 Jun 2020 10:53:06 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1jgUlN-0000XH-Bd; Wed, 03 Jun 2020 10:53:05 -0400
Received: by mail-pg1-x544.google.com with SMTP id d10so1924123pgn.4;
 Wed, 03 Jun 2020 07:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Kr3HUN5/YkECxPtjDxbpJDVaFQAB0Lcue4RVnkTaxI4=;
 b=FTHGmDYx15mPMYum2iUIhLJjAnlYqWq5IaLMBXrbMHu4Xm0PULiknnnuuR00P9+rsn
 iSUQhpn/6fLIsmSaH1nZMRACpDodQ6Y03AFKdqphOO8huPdzFom8ln6wjnWFW4FQKCfG
 jVQBCAo9ZbVrv6DkhG9t4sn2obDMFLcrnEGwhB0MxfsHAVIMICJXvVZMKi5ahvW/YXS1
 xpylBEvsnO544QxUxv95pIJ66tO+CKtIuQ1P5r9bNwypO4/yvs+6tOjP/IbLo1KUWygb
 awM9JtJXe35VAXOdfIqa0w3/hX/m5Izsomd6jpx9aycVapjlmvfGtirUZ2x596NLaBtJ
 ZNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Kr3HUN5/YkECxPtjDxbpJDVaFQAB0Lcue4RVnkTaxI4=;
 b=JnwVObRdNTp7H9KlFJ5ABzOuVIHxi3ZwOCKWmlmDhCfd9L8/mh9VFenVtNsz+ZCeEK
 kMmIA0avn/N00R6AisbveBg2Ii2GnDPukorxjXA5SXR5vdTntvobCYyaRymLo+7vUxcM
 CInVPNXqiPnaJF/oCvo6BmvRcBNAVYwSbaaVrdKCEhKEbDlNoNmtq3zOCadvx02+0R4c
 XTjJzGve1DIlYl701B53XG0AFEn12aOaXYY8X+ffn8vHiJeth9mY8qx/9/UVgxkZ1eEL
 gxIXseBcmUuf4tjG9JV9uURbLPFjL4ihdQ7fGL5VJlSzezbtAagq8Rz3mSQCuqslycos
 muDg==
X-Gm-Message-State: AOAM532DcgpMuxuxzE3bmTo2VYKKGWjFgdy0+xSMBum7SIBAUf+SmczR
 EQTpsweC8PmTYZTdINZyJHg=
X-Google-Smtp-Source: ABdhPJx7dCZhPOf7/dogx3NdQyPWlsYb0KRH8Kg4gmXSsvNSgCbMfPnO+SFKuYP3dBkbkH3FypgTuA==
X-Received: by 2002:a63:e454:: with SMTP id i20mr28733828pgk.440.1591195983522; 
 Wed, 03 Jun 2020 07:53:03 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id e124sm2141068pfh.140.2020.06.03.07.53.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 03 Jun 2020 07:53:03 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 1/2] sd: sdhci: Implement basic vendor specific register
 support
Date: Wed,  3 Jun 2020 07:52:57 -0700
Message-Id: <20200603145258.195920-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603145258.195920-1-linux@roeck-us.net>
References: <20200603145258.195920-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Linux kernel's IMX code now uses vendor specific commands.
This results in endless warnings when booting the Linux kernel.

sdhci-esdhc-imx 2194000.usdhc: esdhc_wait_for_card_clock_gate_off:
	card clock still not gate off in 100us!.

Implement support for the vendor specific command implemented in IMX hardware
to be able to avoid this warning.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added Philippe's Tested-by: and Reviewed-by: tags

 hw/sd/sdhci-internal.h |  5 +++++
 hw/sd/sdhci.c          | 18 +++++++++++++++++-
 include/hw/sd/sdhci.h  |  5 +++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index e7c8a523b5..e8c753d6d1 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -75,6 +75,7 @@
 #define SDHC_CMD_INHIBIT               0x00000001
 #define SDHC_DATA_INHIBIT              0x00000002
 #define SDHC_DAT_LINE_ACTIVE           0x00000004
+#define SDHC_IMX_CLOCK_GATE_OFF        0x00000080
 #define SDHC_DOING_WRITE               0x00000100
 #define SDHC_DOING_READ                0x00000200
 #define SDHC_SPACE_AVAILABLE           0x00000400
@@ -289,7 +290,10 @@ extern const VMStateDescription sdhci_vmstate;
 
 
 #define ESDHC_MIX_CTRL                  0x48
+
 #define ESDHC_VENDOR_SPEC               0xc0
+#define ESDHC_IMX_FRC_SDCLK_ON          (1 << 8)
+
 #define ESDHC_DLL_CTRL                  0x60
 
 #define ESDHC_TUNING_CTRL               0xcc
@@ -326,6 +330,7 @@ extern const VMStateDescription sdhci_vmstate;
 #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
     DEFINE_PROP_UINT8("sd-spec-version", _state, sd_spec_version, 2), \
     DEFINE_PROP_UINT8("uhs", _state, uhs_mode, UHS_NOT_SUPPORTED), \
+    DEFINE_PROP_UINT8("vendor", _state, vendor, SDHCI_VENDOR_NONE), \
     \
     /* Capabilities registers provide information on supported
      * features of this specific host controller implementation */ \
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 1b75d7bab9..eb2be6529e 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1569,11 +1569,13 @@ static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
         }
         break;
 
+    case ESDHC_VENDOR_SPEC:
+        ret = s->vendor_spec;
+        break;
     case ESDHC_DLL_CTRL:
     case ESDHC_TUNE_CTRL_STATUS:
     case ESDHC_UNDOCUMENTED_REG27:
     case ESDHC_TUNING_CTRL:
-    case ESDHC_VENDOR_SPEC:
     case ESDHC_MIX_CTRL:
     case ESDHC_WTMK_LVL:
         ret = 0;
@@ -1596,7 +1598,21 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
     case ESDHC_UNDOCUMENTED_REG27:
     case ESDHC_TUNING_CTRL:
     case ESDHC_WTMK_LVL:
+        break;
+
     case ESDHC_VENDOR_SPEC:
+        s->vendor_spec = value;
+        switch (s->vendor) {
+        case SDHCI_VENDOR_IMX:
+            if (value & ESDHC_IMX_FRC_SDCLK_ON) {
+                s->prnsts &= ~SDHC_IMX_CLOCK_GATE_OFF;
+            } else {
+                s->prnsts |= SDHC_IMX_CLOCK_GATE_OFF;
+            }
+            break;
+        default:
+            break;
+        }
         break;
 
     case SDHC_HOSTCTL:
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index c6868c9699..5d9275f3d6 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -74,6 +74,7 @@ typedef struct SDHCIState {
     uint16_t acmd12errsts; /* Auto CMD12 error status register */
     uint16_t hostctl2;     /* Host Control 2 */
     uint64_t admasysaddr;  /* ADMA System Address Register */
+    uint16_t vendor_spec;  /* Vendor specific register */
 
     /* Read-only registers */
     uint64_t capareg;      /* Capabilities Register */
@@ -96,8 +97,12 @@ typedef struct SDHCIState {
     uint32_t quirks;
     uint8_t sd_spec_version;
     uint8_t uhs_mode;
+    uint8_t vendor;        /* For vendor specific functionality */
 } SDHCIState;
 
+#define SDHCI_VENDOR_NONE       0
+#define SDHCI_VENDOR_IMX        1
+
 /*
  * Controller does not provide transfer-complete interrupt when not
  * busy.
-- 
2.17.1


