Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C96C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 09:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B47120663
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 09:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoB161Ck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B47120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhUkZ-00029f-Ci
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 05:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1jhUk1-0001eg-Es; Sat, 06 Jun 2020 05:03:49 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:33743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1jhUjz-0007mJ-1y; Sat, 06 Jun 2020 05:03:49 -0400
Received: by mail-oo1-xc42.google.com with SMTP id v1so2508520ooh.0;
 Sat, 06 Jun 2020 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=aJSIM0Z9sIJMF9VtNRIinXv3BNbJBl+t4C0Ved9wjUM=;
 b=LoB161Ckl5eZl+tD68AZB0uVF7VT36yVt9KAbcALvcj9seH+XY2cFkg3m492RKwM9k
 XQViZUPcg2XuDlS+597g2o3maRzs892Ig7F0oWDmjZbSk6h4eN6qoPAUbdv+uPm4xNtu
 boKrk1IvaiFf5nQ0WAUorvmkLCcEoDHt4nXSw0bOOf8i/m25rHpJ2tOC16mN+6Se8PMX
 zX8Ta53vYwpPhHxv0go4bqcpvj1m67dcqdA67RkmSzvpcqd2ekE5xPEbQ67fJatckw8b
 /0pOqhqEvXIL6/hXkfHYZjbMuhqElOw5N0G4vr/ajeXIW4N4d4sWuRWASd1zgx1C1ETv
 RY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=aJSIM0Z9sIJMF9VtNRIinXv3BNbJBl+t4C0Ved9wjUM=;
 b=ApegGi5JRdUOoHJdH6J5B00PNWtl/RfuLPLTtYUX7iYRU8/Tjx94j4pex2IYorDj3g
 IL8yJBpbd50cxEl0L+wm9smwhM1oCcAG0LEfciIGhbOnWMNfhCezutX0W9DAAB6KFEVD
 AX6MGhNRrMNTDMx4l7M70Q+xVswLRrnE4LJujkhjbIa+B7Ves1S/q6qbm+R/YHSHCZdn
 pv7yLGyDt9IjDhC5k32CrPPXc4NMltDJ32T5wErGTE12kUze29sYN/EmDbH916+b4IYe
 aSDcO3WBjBSBe/Y4DRB5QyE0KIqApgFsHdmCBqIGtWyBULaTfZPEm9/kq14bTjoNJqDQ
 Dtlg==
X-Gm-Message-State: AOAM530HhJUecduRtVPdiNj/89BAyVHbu1yLkUfJ8toIhazPPs6SNSBB
 YyoRaPrQ/S1eUN9rCIT31fnHGzZ4ThBIbp2NNJ8=
X-Google-Smtp-Source: ABdhPJzyxgqF6ExuOdkrtDA1K5q4sXqb7MFZ/q3V/OQOlS7kDFBdOQUDsAqlPqMTWio2fMYkBCfQjTcxLqMfPjWIIAg=
X-Received: by 2002:a4a:5744:: with SMTP id u65mr10748812ooa.1.1591434224736; 
 Sat, 06 Jun 2020 02:03:44 -0700 (PDT)
MIME-Version: 1.0
From: Erik Smit <erik.lucas.smit@gmail.com>
Date: Sat, 6 Jun 2020 11:03:34 +0200
Message-ID: <CA+MHfovYq1UAQQ341MnyGas7ScskWyjR=QE0D-RS7+zxF2mtsw@mail.gmail.com>
Subject: [PATCH v2] Implement configurable descriptor size in ftgmac100
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, 
 Joel Stanley <joel@jms.id.au>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=erik.lucas.smit@gmail.com; helo=mail-oo1-xc42.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The hardware supports configurable descriptor sizes, configured in the DBLAC
register.

Most drivers use the default 4 word descriptor, which is currently hardcoded,
but Aspeed SDK configures 8 words to store extra data.

---
The implementation of the driver in Supermicro BMC SMT_X11_158 adds 4 extra
word entries:
https://github.com/ya-mouse/openwrt-linux-aspeed/blob/master/drivers/net/ftgmac100_26.h#L387-L391

And sets DBLAC to 0x44f97:
https://github.com/ya-mouse/openwrt-linux-aspeed/blob/master/drivers/net/ftgmac100_26.c#L449

There's not a lot of public documentation on this hardware, but the
current linux driver shows the meaning of these registers:

https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/faraday/ftgmac100.c#L280-L281

        iowrite32(FTGMAC100_DBLAC_RXDES_SIZE(2) |   /* 2*8 bytes RX descs */
                  FTGMAC100_DBLAC_TXDES_SIZE(2) |   /* 2*8 bytes TX descs */

Without this patch, networking in SMT_X11_158 fails after the first packet.

changes since previous version:

- moved "* 8" into {R,T}XDES_SIZE macro
- removed the RXFIFO and RX_THR_EN defines as they're AST2400-only and not used
- test setting of DBLAC register for validness

Signed-off-by: Erik Smit <erik.lucas.smit@gmail.com>
---
 hw/net/ftgmac100.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 25ebee7ec2..83058497c4 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -79,6 +79,16 @@
 #define FTGMAC100_APTC_TXPOLL_CNT(x)        (((x) >> 8) & 0xf)
 #define FTGMAC100_APTC_TXPOLL_TIME_SEL      (1 << 12)

+/*
+ * DMA burst length and arbitration control register
+ */
+#define FTGMAC100_DBLAC_RXBURST_SIZE(x)     (((x) >> 8) & 0x3)
+#define FTGMAC100_DBLAC_TXBURST_SIZE(x)     (((x) >> 10) & 0x3)
+#define FTGMAC100_DBLAC_RXDES_SIZE(x)       ((((x) >> 12) & 0xf) * 8)
+#define FTGMAC100_DBLAC_TXDES_SIZE(x)       ((((x) >> 16) & 0xf) * 8)
+#define FTGMAC100_DBLAC_IFG_CNT(x)          (((x) >> 20) & 0x7)
+#define FTGMAC100_DBLAC_IFG_INC             (1 << 23)
+
 /*
  * PHY control register
  */
@@ -553,7 +563,7 @@ static void ftgmac100_do_tx(FTGMAC100State *s,
uint32_t tx_ring,
         if (bd.des0 & s->txdes0_edotr) {
             addr = tx_ring;
         } else {
-            addr += sizeof(FTGMAC100Desc);
+            addr += (FTGMAC100_DBLAC_TXDES_SIZE(s->dblac));
         }
     }

@@ -800,6 +810,18 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
         s->phydata = value & 0xffff;
         break;
     case FTGMAC100_DBLAC: /* DMA Burst Length and Arbitration Control */
+        if (FTGMAC100_DBLAC_TXDES_SIZE(s->dblac) < sizeof(FTGMAC100Desc)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: transmit descriptor too small : %d bytes\n",
+                          __func__, FTGMAC100_DBLAC_TXDES_SIZE(s->dblac));
+            break;
+        }
+        if (FTGMAC100_DBLAC_RXDES_SIZE(s->dblac) < sizeof(FTGMAC100Desc)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: receive descriptor too small : %d bytes\n",
+                          __func__, FTGMAC100_DBLAC_RXDES_SIZE(s->dblac));
+            break;
+        }
         s->dblac = value;
         break;
     case FTGMAC100_REVR:  /* Feature Register */
@@ -982,7 +1004,7 @@ static ssize_t ftgmac100_receive(NetClientState
*nc, const uint8_t *buf,
         if (bd.des0 & s->rxdes0_edorr) {
             addr = s->rx_ring;
         } else {
-            addr += sizeof(FTGMAC100Desc);
+            addr += (FTGMAC100_DBLAC_RXDES_SIZE(s->dblac));
         }
     }
     s->rx_descriptor = addr;
--
2.25.1

