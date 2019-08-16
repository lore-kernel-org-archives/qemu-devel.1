Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E05C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10FF320644
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LBklE436"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FF320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyc97-00058A-HM
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6i-0003Jn-Hq
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6g-0005LI-Oo
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:28 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:39642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc6g-0005Jz-Hy
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:26 -0400
Received: by mail-wm1-x32f.google.com with SMTP id i63so4044228wmg.4
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=t9Ek+ekeSYweoP2VH/IkoFx1+ZoWgv5D/JzyljNNHF0=;
 b=LBklE436q0nOX4scy4tN92qPN/wW0js02g+90adt6XqcWsEajlIFBHmGq3LnT6o5zZ
 0fd8uNJcKOjMVXXgoak5CjqIrljXywhcR71ECXKn+SnYKbK3k6HrW1yJnrtVV5L1rmzB
 0VngVLAOmRudE7mRye7eL0HvKDCU0XlM147VUPGCBRt8ooyFur1F64JfX+qnZOoKn9Th
 4g/gqxAFfBcmVlj3SRzna5N5mGMMEviRpUVgqN7rBbZuGhpGjtE58VdvGAeCxCFZMemU
 721PA6znL7kfkjpsksUaMp914aBuOzZrDoXTdPy8v5E9XiwRY4tVbXRQFU2uvdJ8Kfi9
 BFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t9Ek+ekeSYweoP2VH/IkoFx1+ZoWgv5D/JzyljNNHF0=;
 b=Rz8neocuCUO6OIlJ9YgNXsnPDaaYr/vPsg0XWXQr3fdwnbrzoPiYgrS/+0H045tSj1
 xN0ByXHr2Kj9Cnk/TQM2Sx/hMUWqZ9fXS3RQlGZetH7i+lpO5cskGv0GDUT2H5MacQNG
 k+XdeS8x4pvWSlGGa6M5rTkVOEv3XFzuGachtmQH2wmg0q0enfC44k9tE/ChTYCYulM/
 61MkjCOOfiCy6AS++q5Mf4OQ9kOF5Gk3LOisopvD6FCf23EG9AQwZSu8yVYaMep7elOe
 okqVJOZpzPHPR31Rz3+mBS/umhYp3CcxL1Cj2sVpcjbb6JnNA4xfo4/BbqICOZtMzM8e
 /8Vg==
X-Gm-Message-State: APjAAAUx8VwY5FqTRm6w0/xymDur5D4iKInai//QMxCSHF6ed9V02NR4
 U47uB9/ohFkc/+zDwRrH/OECETQM1ROiRA==
X-Google-Smtp-Source: APXvYqz9n6dBO/GDyLXcQisapigYTBBmAQjTTU6EdGUIDwiM/ZoJ8BGSYLucwdr5/vXrmTqjVfeZXA==
X-Received: by 2002:a05:600c:2111:: with SMTP id
 u17mr7816768wml.64.1565961444882; 
 Fri, 16 Aug 2019 06:17:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:16:53 +0100
Message-Id: <20190816131719.28244-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
Subject: [Qemu-devel] [PULL 03/29] Set ENET_BD_BDU in I.MX FEC controller
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

From: Aaron Hill <aa1ronham@gmail.com>

This commit properly sets the ENET_BD_BDU flag once the emulated FEC controller
has finished processing the last descriptor. This is done for both transmit
and receive descriptors.

This allows the QNX 7.0.0 BSP for the Sabrelite board (which can be
found at http://blackberry.qnx.com/en/developers/bsp) to properly
control the FEC. Without this patch, the BSP ethernet driver will never
re-use FEC descriptors, as the unset ENET_BD_BDU flag will cause
it to believe that the descriptors are still in use by the NIC.

Note that Linux does not appear to use this field at all, and is
unaffected by this patch.

Without this patch, QNX will think that the NIC is still processing its
transaction descriptors, and won't send any more data over the network.

For reference:

On page 1192 of the I.MX 6DQ reference manual revision (Rev. 5, 06/2018),
which can be found at https://www.nxp.com/products/processors-and-microcontrollers/arm-based-processors-and-mcus/i.mx-applications-processors/i.mx-6-processors/i.mx-6quad-processors-high-performance-3d-graphics-hd-video-arm-cortex-a9-core:i.MX6Q?&tab=Documentation_Tab&linkline=Application-Note

the 'BDU' field is described as follows for the 'Enhanced transmit
buffer descriptor':

'Last buffer descriptor update done. Indicates that the last BD data has been updated by
uDMA. This field is written by the user (=0) and uDMA (=1).'

The same description is used for the receive buffer descriptor.

Signed-off-by: Aaron Hill <aa1ronham@gmail.com>
Message-id: 20190805142417.10433-1-aaron.hill@alertinnovation.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/imx_fec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 404154ebbf7..4693bfb2464 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -590,6 +590,8 @@ static void imx_enet_do_tx(IMXFECState *s, uint32_t index)
             if (bd.option & ENET_BD_TX_INT) {
                 s->regs[ENET_EIR] |= int_txf;
             }
+            /* Indicate that we've updated the last buffer descriptor. */
+            bd.last_buffer = ENET_BD_BDU;
         }
         if (bd.option & ENET_BD_TX_INT) {
             s->regs[ENET_EIR] |= int_txb;
@@ -1239,6 +1241,8 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
             /* Last buffer in frame.  */
             bd.flags |= flags | ENET_BD_L;
             FEC_PRINTF("rx frame flags %04x\n", bd.flags);
+            /* Indicate that we've updated the last buffer descriptor. */
+            bd.last_buffer = ENET_BD_BDU;
             if (bd.option & ENET_BD_RX_INT) {
                 s->regs[ENET_EIR] |= ENET_INT_RXF;
             }
-- 
2.20.1


