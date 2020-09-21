Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58914C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 03:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D423820719
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 03:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqFk3RfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D423820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKCqW-0001hi-TS
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 23:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKCni-0006Oz-9g; Sun, 20 Sep 2020 23:47:38 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKCnf-0001wC-JH; Sun, 20 Sep 2020 23:47:37 -0400
Received: by mail-wm1-x342.google.com with SMTP id l9so11044255wme.3;
 Sun, 20 Sep 2020 20:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gjFOw5Zj9oE5Q4kDhKw5pc8BNx41CMef2pSlNT1oQak=;
 b=PqFk3RfYkE2fEY9sQUESGF65cG8IP119Nf4csUpfi7MtCsn4Xtg18uhd1j0e3cOqMb
 jIHpLvJHxlcNe0d8X2tfNGl+wZhsVbzeP3c+QkfiTVHpPKx03E9j9JA2QmVM/3rgcIk9
 RSZwdJADuz9vcZw79UaGBO5Oj8FbGleRTN3FEo2Yw5OlztJScQ4Vdqv9m2b5+3uf8EJ6
 4y2uZh7vqoJFLUIyxEBqsEgms+uCi5v41Vsn+vEocURaAoh0q9uzocWcX88XYT40cXag
 oEIK6dr3TpkXJXEGohSJA+6TXpikEsJ43HhzlKRy5pgg53+tk7f4eo3O2OiIQkMpliIN
 j8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gjFOw5Zj9oE5Q4kDhKw5pc8BNx41CMef2pSlNT1oQak=;
 b=So5vL5c25CerhcA/gyDOe+OOu1RrErYWb09q91e4h6XlLTyDdu6aIwIwxl9wKD5uXW
 t6ji+VLc/rANh1uisZWrOG6po5jDuVqEukUwUInAVNx71We8eKWgyoXS7/yFgXjVFYXi
 MFqqKc+TIGtjltgsqEk2l3sEx/WCSsb02JWx0LsBwTx/jOPPdN1hkRwZmDllrI0ILG0h
 LU8BJ7emRLIISj924INGC8zZjjLnJ+4IAlNp3odasYOYBqmQwyckEDdF2YeCnVmwNBJo
 I9HOrW7VelLWzopO7FCiRmMuP4S7CFqc8wNn7HkEeZ0TKz9R23gpJJ50se0mLsQC4qVG
 2fZA==
X-Gm-Message-State: AOAM532rcITJ8p2VGR1AqE2xRguQzq084rpI1vzVuDlcU0UvdEPyPGct
 lWMRmwM7Uugqx3tca1we0zlRUD4l2g8=
X-Google-Smtp-Source: ABdhPJwPIRGpy2AfIzFVhHI1+Yxk1V6zMZRSV5kganUbl/5TBTptK9Wlx7cXxhCY7AWTi5hGrLgiEQ==
X-Received: by 2002:a05:600c:410e:: with SMTP id
 j14mr29335293wmi.13.1600660052083; 
 Sun, 20 Sep 2020 20:47:32 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u63sm11751440wmb.13.2020.09.20.20.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2020 20:47:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] hw/arm/raspi: Define various blocks base addresses
Date: Mon, 21 Sep 2020 05:47:27 +0200
Message-Id: <20200921034729.432931-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921034729.432931-1-f4bug@amsat.org>
References: <20200921034729.432931-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Raspberry firmware is closed-source. While running it, it
accesses various I/O registers. Logging these accesses as UNIMP
(unimplemented) help to understand what the firmware is doing
(ideally we want it able to boot a Linux kernel).

Document various blocks we might use later.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/raspi_platform.h | 51 +++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 61b04a1bd4a..c7f50b260f6 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -20,20 +20,29 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * Various undocumented addresses and names come from Herman Hermitage's VC4
+ * documentation:
+ * https://github.com/hermanhermitage/videocoreiv/wiki/MMIO-Register-map
  */
 
 #ifndef HW_ARM_RASPI_PLATFORM_H
 #define HW_ARM_RASPI_PLATFORM_H
 
 #define MSYNC_OFFSET            0x0000   /* Multicore Sync Block */
-#define IC0_OFFSET              0x2000
+#define CCPT_OFFSET             0x1000   /* Compact Camera Port 2 TX */
+#define INTE_OFFSET             0x2000   /* VC Interrupt controller */
 #define ST_OFFSET               0x3000   /* System Timer */
+#define TXP_OFFSET              0x4000   /* Transposer */
+#define JPEG_OFFSET             0x5000
 #define MPHI_OFFSET             0x6000   /* Message-based Parallel Host Intf. */
 #define DMA_OFFSET              0x7000   /* DMA controller, channels 0-14 */
-#define ARM_OFFSET              0xB000   /* BCM2708 ARM control block */
+#define ARBA_OFFSET             0x9000
+#define BRDG_OFFSET             0xa000
+#define ARM_OFFSET              0xB000   /* ARM control block */
 #define ARMCTRL_OFFSET          (ARM_OFFSET + 0x000)
 #define ARMCTRL_IC_OFFSET       (ARM_OFFSET + 0x200) /* Interrupt controller */
-#define ARMCTRL_TIMER0_1_OFFSET (ARM_OFFSET + 0x400) /* Timer 0 and 1 */
+#define ARMCTRL_TIMER0_1_OFFSET (ARM_OFFSET + 0x400) /* Timer 0 and 1 (SP804) */
 #define ARMCTRL_0_SBM_OFFSET    (ARM_OFFSET + 0x800) /* User 0 (ARM) Semaphores
                                                       * Doorbells & Mailboxes */
 #define CPRMAN_OFFSET           0x100000 /* Power Management, Watchdog */
@@ -42,24 +51,50 @@
 #define AVS_OFFSET              0x103000 /* Audio Video Standard */
 #define RNG_OFFSET              0x104000
 #define GPIO_OFFSET             0x200000
-#define UART0_OFFSET            0x201000
-#define MMCI0_OFFSET            0x202000
-#define I2S_OFFSET              0x203000
-#define SPI0_OFFSET             0x204000
+#define UART0_OFFSET            0x201000 /* PL011 */
+#define MMCI0_OFFSET            0x202000 /* Legacy MMC */
+#define I2S_OFFSET              0x203000 /* PCM */
+#define SPI0_OFFSET             0x204000 /* SPI master */
 #define BSC0_OFFSET             0x205000 /* BSC0 I2C/TWI */
+#define PIXV0_OFFSET            0x206000
+#define PIXV1_OFFSET            0x207000
+#define DPI_OFFSET              0x208000
+#define DSI0_OFFSET             0x209000 /* Display Serial Interface */
+#define PWM_OFFSET              0x20c000
+#define PERM_OFFSET             0x20d000
+#define TEC_OFFSET              0x20e000
 #define OTP_OFFSET              0x20f000
+#define SLIM_OFFSET             0x210000 /* SLIMbus */
+#define CPG_OFFSET              0x211000
 #define THERMAL_OFFSET          0x212000
-#define BSC_SL_OFFSET           0x214000 /* SPI slave */
+#define AVSP_OFFSET             0x213000
+#define BSC_SL_OFFSET           0x214000 /* SPI slave (bootrom) */
 #define AUX_OFFSET              0x215000 /* AUX: UART1/SPI1/SPI2 */
 #define EMMC1_OFFSET            0x300000
+#define EMMC2_OFFSET            0x340000
+#define HVS_OFFSET              0x400000
 #define SMI_OFFSET              0x600000
+#define DSI1_OFFSET             0x700000
+#define UCAM_OFFSET             0x800000
+#define CMI_OFFSET              0x802000
 #define BSC1_OFFSET             0x804000 /* BSC1 I2C/TWI */
 #define BSC2_OFFSET             0x805000 /* BSC2 I2C/TWI */
+#define VECA_OFFSET             0x806000
+#define PIXV2_OFFSET            0x807000
+#define HDMI_OFFSET             0x808000
+#define HDCP_OFFSET             0x809000
+#define ARBR0_OFFSET            0x80a000
 #define DBUS_OFFSET             0x900000
 #define AVE0_OFFSET             0x910000
 #define USB_OTG_OFFSET          0x980000 /* DTC_OTG USB controller */
+#define V3D_OFFSET              0xc00000
 #define SDRAMC_OFFSET           0xe00000
+#define L2CC_OFFSET             0xe01000 /* Level 2 Cache controller */
+#define L1CC_OFFSET             0xe02000 /* Level 1 Cache controller */
+#define ARBR1_OFFSET            0xe04000
 #define DMA15_OFFSET            0xE05000 /* DMA controller, channel 15 */
+#define DCRC_OFFSET             0xe07000
+#define AXIP_OFFSET             0xe08000
 
 /* GPU interrupts */
 #define INTERRUPT_TIMER0               0
-- 
2.26.2


