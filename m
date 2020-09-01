Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9D9C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A1F206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A1F206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7A7-0003O5-Rd
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zO-0005b4-CX; Tue, 01 Sep 2020 10:10:22 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:33775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zI-0003pi-Vv; Tue, 01 Sep 2020 10:10:22 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N95mR-1kgcFZ0Ycx-0167sw; Tue, 01 Sep 2020 16:10:02 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 07/44] hw: Remove superfluous breaks
Date: Tue,  1 Sep 2020 16:09:17 +0200
Message-Id: <20200901140954.889743-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:t63RMrUKsw4I4AGu9+476NG7a2x8lGtHq+oLVzOVu54VVLPzXN4
 ezRzqPNE/qX1prkyJhz5IvL9aJT6ydIwRGxWXUUA61k+6HfUH+YESfSdtsFWCZdjXl5mxAc
 9j+6dSkSj7I/LtTkJCRnNavpUig+1Kuz6qnSuJs0C8gXjJQuXNwhy0yvepLpAOsdJw3Ufa6
 bWKtd+Wt5V8UwQQLOdseQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RH8Cs9s60wc=:xlG43TXzRqsPVIghZnAQTB
 zKfAYdG22YUcMotdjCy2fD36pYTi5F270WOC8wlz4f4R6r4eLscfkPzHIeCjXUSVi/ksaY/En
 wuV2IluQCCFqoIHTzFdWY1D4d9GvwoNxFyDsQU+Xagc7nT55pruaLC3ap+Fi4dnjia58lRIpj
 QlJ4/Je3j6pIWPnsdoVljHzI2i075fHKBsDDkHI6OVihSFDTha7o2CumeH2k61ondse0sF2YP
 2gCYM3H1nXeumitCgCkxibKkY2szmr+tQrFDc0uRoRyh7TR36oB1tWn0Rf07BAXtXOHnAnQTK
 ad8EmGTz0DmRL9ZGumP4s5ZPmBHwHDE30690TtsZLl/zZT8rjsHWyCQTJvbJv/37YBh6s4xdk
 EO/dMmfMpVVTnbCYIBKTJflA19tEnaJ30YSZkW6jXCBdpPYpO1EzsM+7VHCurhEIiE4DTkjj/
 Zbm2v3li6fn8UB3ZtDIjMxUKjPxt/bhbQIFliBD3kpQPDA/2Ar1c71h0Ff5ulwIUxLXtlYYOC
 o6Dw/04TQ/Pjqw5mdmy5AjkqEJDIuv61TutNfQFvROegj/MCmUJ6ig7cFa5LLgOWC8aBhOABx
 2Y5wVLO63vfI6KO7u03z3cHmjLfmyZ0QXQelGW5WejUvXRkmtrGUfBZ0BxFGl7Sv938L9Jwl2
 gPpABBCrj85XpbPhJr+HIEymqolZLm3botswqhIf0XE4ZDwtw07Wbcm4AaGN2XVqRj8eyNW1v
 I6v7FbrbMzphP8tPpcEwYSEFS01ban1GE1HCrFq9RNvlr3MtuQVdIC7/EL+En2/fiu54JN34k
 /EWJik36TUmhFAjka5lIh9CTLbtbxiXt2GylWIQaW+TvFfWg1FPaksSqsG0vwNSmK6wy0Ee
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:09:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Yi Wang <wang.yi59@zte.com.cn>, Thomas Huth <thuth@redhat.com>,
 qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Remove superfluous breaks, as there is a "return" before them.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1594631126-36631-1-git-send-email-wang.yi59@zte.com.cn>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/block/pflash_cfi01.c     |  1 -
 hw/display/cirrus_vga.c     |  1 -
 hw/display/qxl-logger.c     |  2 --
 hw/gpio/max7310.c           |  3 ---
 hw/i386/intel_iommu.c       |  1 -
 hw/input/pxa2xx_keypad.c    | 10 ----------
 hw/intc/armv7m_nvic.c       |  1 -
 hw/net/lan9118.c            |  2 --
 hw/usb/ccid-card-emulated.c |  1 -
 9 files changed, 22 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 8ab1d66310b4..f0fcd63f84e8 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -213,7 +213,6 @@ static uint32_t pflash_devid_query(PFlashCFI01 *pfl, hwaddr offset)
     default:
         trace_pflash_device_info(offset);
         return 0;
-        break;
     }
     /* Replicate responses for each device in bank. */
     if (pfl->device_width < pfl->bank_width) {
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 212d6f5e6145..02d9ed0bd465 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -1637,7 +1637,6 @@ static int cirrus_vga_read_cr(CirrusVGAState * s, unsigned reg_index)
 	return s->vga.cr[s->vga.cr_index];
     case 0x26:			// Attribute Controller Index Readback (R)
 	return s->vga.ar_index & 0x3f;
-	break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "cirrus: inport cr_index 0x%02x\n", reg_index);
diff --git a/hw/display/qxl-logger.c b/hw/display/qxl-logger.c
index 2ec6d8fa3d6c..c15175bce322 100644
--- a/hw/display/qxl-logger.c
+++ b/hw/display/qxl-logger.c
@@ -161,7 +161,6 @@ static int qxl_log_cmd_draw(PCIQXLDevice *qxl, QXLDrawable *draw, int group_id)
     switch (draw->type) {
     case QXL_DRAW_COPY:
         return qxl_log_cmd_draw_copy(qxl, &draw->u.copy, group_id);
-        break;
     }
     return 0;
 }
@@ -180,7 +179,6 @@ static int qxl_log_cmd_draw_compat(PCIQXLDevice *qxl, QXLCompatDrawable *draw,
     switch (draw->type) {
     case QXL_DRAW_COPY:
         return qxl_log_cmd_draw_copy(qxl, &draw->u.copy, group_id);
-        break;
     }
     return 0;
 }
diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
index bebb4030d276..4f78774dc8f2 100644
--- a/hw/gpio/max7310.c
+++ b/hw/gpio/max7310.c
@@ -51,11 +51,9 @@ static uint8_t max7310_rx(I2CSlave *i2c)
     switch (s->command) {
     case 0x00:	/* Input port */
         return s->level ^ s->polarity;
-        break;
 
     case 0x01:	/* Output port */
         return s->level & ~s->direction;
-        break;
 
     case 0x02:	/* Polarity inversion */
         return s->polarity;
@@ -65,7 +63,6 @@ static uint8_t max7310_rx(I2CSlave *i2c)
 
     case 0x04:	/* Timeout */
         return s->status;
-        break;
 
     case 0xff:	/* Reserved */
         return 0xff;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5284bb68b6e4..0d7c4303b4bc 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3168,7 +3168,6 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
                               index, entry->irte.sid_vtype);
             /* Take this as verification failure. */
             return -VTD_FR_IR_SID_ERR;
-            break;
         }
     }
 
diff --git a/hw/input/pxa2xx_keypad.c b/hw/input/pxa2xx_keypad.c
index 62aa6f6b15a0..7f2f739fb335 100644
--- a/hw/input/pxa2xx_keypad.c
+++ b/hw/input/pxa2xx_keypad.c
@@ -192,10 +192,8 @@ static uint64_t pxa2xx_keypad_read(void *opaque, hwaddr offset,
             s->kpc &= ~(KPC_DI);
         qemu_irq_lower(s->irq);
         return tmp;
-        break;
     case KPDK:
         return s->kpdk;
-        break;
     case KPREC:
         tmp = s->kprec;
         if(tmp & KPREC_OF1)
@@ -207,31 +205,23 @@ static uint64_t pxa2xx_keypad_read(void *opaque, hwaddr offset,
         if(tmp & KPREC_UF0)
             s->kprec &= ~(KPREC_UF0);
         return tmp;
-        break;
     case KPMK:
         tmp = s->kpmk;
         if(tmp & KPMK_MKP)
             s->kpmk &= ~(KPMK_MKP);
         return tmp;
-        break;
     case KPAS:
         return s->kpas;
-        break;
     case KPASMKP0:
         return s->kpasmkp[0];
-        break;
     case KPASMKP1:
         return s->kpasmkp[1];
-        break;
     case KPASMKP2:
         return s->kpasmkp[2];
-        break;
     case KPASMKP3:
         return s->kpasmkp[3];
-        break;
     case KPKDI:
         return s->kpkdi;
-        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 277a98b87b91..7876c1ba07ec 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1290,7 +1290,6 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
     case 0xd90: /* MPU_TYPE */
         /* Unified MPU; if the MPU is not present this value is zero */
         return cpu->pmsav7_dregion << 8;
-        break;
     case 0xd94: /* MPU_CTRL */
         return cpu->env.v7m.mpu_ctrl[attrs.secure];
     case 0xd98: /* MPU_RNR */
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 8e2a432179cb..e35f00fb9fea 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -931,10 +931,8 @@ static uint32_t do_mac_read(lan9118_state *s, int reg)
                | (s->conf.macaddr.a[2] << 16) | (s->conf.macaddr.a[3] << 24);
     case MAC_HASHH:
         return s->mac_hashh;
-        break;
     case MAC_HASHL:
         return s->mac_hashl;
-        break;
     case MAC_MII_ACC:
         return s->mac_mii_acc;
     case MAC_MII_DATA:
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 7d6105ef34d5..0f1afd66be1c 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -350,7 +350,6 @@ static void *event_thread(void *arg)
         case VEVENT_LAST: /* quit */
             vevent_delete(event);
             return NULL;
-            break;
         default:
             break;
         }
-- 
2.26.2


