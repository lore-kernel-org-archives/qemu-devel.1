Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CF5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F5420707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kPlwuwWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F5420707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8a3-0004rv-DV
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LW-0007l1-Jh
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:34 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:47086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LU-00044D-P9
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:34 -0400
Received: by mail-wr1-x42b.google.com with SMTP id x6so20041870wrm.13
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=lDQ3expnbb4U9BUDOaeYoPi9En+3zAAg59F+UjXfZYI=;
 b=kPlwuwWZGBx9W/lvkbXgad1I+DGRrLyPGztE/Hn0O85yNNQYxDsGhzyUh5QeMLoYaH
 zb3a77wf+UZiDWqCldIJq8jCMbvvpYMJbgo3XQJZY9mKc/kAVxlzIMYoCfWeQXEdeTAE
 gdxB181n52FzmCIE9uDDwMFaCWoCG/czpAZsCW8D6WHc2emCkwRbZlo2cVx+TwB8U+KA
 M7Uy9zJqxw+ARmxvgrfO+JOSGy9kvVWE62vapLEhW8hKnshNk/+E3di5G9qi/poFeGNP
 rB7sBGajikyb4K9nNsK0VXIMQITRaNOWB89zUXlCEbQofGwiC1lGgEy6xzIdlwDskkUC
 zeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lDQ3expnbb4U9BUDOaeYoPi9En+3zAAg59F+UjXfZYI=;
 b=de2mSpAEI92KAGSMGUe2FF0ncww9me1BtgSOYkitvQknz/gPQmRriIaTjtK1+TUw9r
 4gdGxXhtn+yJKZd008b9jHuK+jVg7w8a+0EFsW/sS26HI8ichaXOsCL9cChfI2GnFS2N
 lthwsSrUEyb7fAAj2oySSMPTwe1cuNg5mx68dz1vXy1dqON6iYDylEBscmR15kgqtZf3
 o43ZQCfV21ToAvq3Z53HuOUXylnNCfuJAxKJBBhZknX+iJdiBSxGMeGU6zSCqRMDfPh6
 j6ofVWQFzrbYx1TS+yXB90HskaHtNHXtLhbTYoHEibonCD/pxYcxeFg1RiuRmAbOGNPi
 m5yw==
X-Gm-Message-State: AOAM533kNxkaP/1LCnpYIPraTg/4s0Runos60tX5UMCtGMT86AuIdQTP
 8kQyCU2tPmo7/ICpr4TtG0uueFJYNVjZpw==
X-Google-Smtp-Source: ABdhPJzXjvbCQ3yrvbmCv73MLWFejcdIV3dBBxnWXSFtq98u6L2bzau35OmNLtKj0hyxukk5dvymNQ==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr2143393wrv.162.1592301450918; 
 Tue, 16 Jun 2020 02:57:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z12sm31090851wrg.9.2020.06.16.02.57.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:57:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/23] sd: sdhci: Implement basic vendor specific register
 support
Date: Tue, 16 Jun 2020 10:57:01 +0100
Message-Id: <20200616095702.25848-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616095702.25848-1-peter.maydell@linaro.org>
References: <20200616095702.25848-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

From: Guenter Roeck <linux@roeck-us.net>

The Linux kernel's IMX code now uses vendor specific commands.
This results in endless warnings when booting the Linux kernel.

sdhci-esdhc-imx 2194000.usdhc: esdhc_wait_for_card_clock_gate_off:
	card clock still not gate off in 100us!.

Implement support for the vendor specific command implemented in IMX hardware
to be able to avoid this warning.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200603145258.195920-2-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sdhci-internal.h |  5 +++++
 include/hw/sd/sdhci.h  |  5 +++++
 hw/sd/sdhci.c          | 18 +++++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index e7c8a523b51..e8c753d6d1e 100644
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
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index c6868c96994..5d9275f3d6c 100644
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
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 1b75d7bab93..eb2be6529e9 100644
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
-- 
2.20.1


