Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873E9C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B3C2071A
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngVPIuSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B3C2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpYST-0002Ef-KW
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 10:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1jpYIy-0005fe-Lb; Sun, 28 Jun 2020 10:29:12 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:42612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1jpYIx-0005Tz-3c; Sun, 28 Jun 2020 10:29:12 -0400
Received: by mail-ed1-x542.google.com with SMTP id z17so10711236edr.9;
 Sun, 28 Jun 2020 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZjKuW1mQwpJiy6HB5bGM9HstZflvVeFdcxiGRekmHQY=;
 b=ngVPIuStvwTnANyO6vMcKp3J1eVRVlMBoTIe0qiDzL73gKAm01b+PwM2ZkEFb7mhi9
 6kr0ZTNFubjwqelMfBMC+hynS13TZ+D0vlT3hHRf8uEAExC3VAnluZxFPvaBkpqnJmRQ
 wAxnggkmoYxvug/A8Q+OWdtNHQWATy6vhotvGN/hBEPtbLIe1i6N2VnOEpO4/gOrMd2G
 vYA+nwCzEGbc9HtrWp+Hj5VZy3IRI/mz7m/Yu8mFgNHPMuZs1FXOkYyiHdWtiVW/nXj8
 4lHmem3Ur7EWTts/aNpT3F7gyGLYnxMsbQF/n0lEF5CojQCAmspWLQtXJx7lCfMhZzsd
 qMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZjKuW1mQwpJiy6HB5bGM9HstZflvVeFdcxiGRekmHQY=;
 b=rk0Fq2IhWA5fn64bvSxtlBOFM/8lgT/bZ7oUg5CRW7Kr1g/2nvXYBkvh/ILPukZ/wM
 SazFptgouGIyqfjGcx5gIkZ+8siRsZNii6Am+/fvkqMnuUmb0Hkp8or8PDD5Jq9HewsM
 HI1yEGgNn1n6R5OpCOPMXuC2Ggjf5etpa9bzGttKzWOcogI1YRvWAcC9KtV5XG5sZQ78
 /RM6uQqZSJT2smfHpqs3fgyTa0pqRrCquuPjOvSmgBsXk2snN4TiMF8pu0Bi+3/HhCgc
 97SHKJKO0x45qDHP/pzNgR0Xv9cxhYcBu0Y1g7xh/HupbAGlXPrjLmlKZP49JaiKiMWH
 1XzA==
X-Gm-Message-State: AOAM533Adecu9ME/d3lMDIvM6MT2iwjVhsZAlrcSBF6MgLpKhdBQGMym
 XdotjYPyjBcHX2vH+7jhhFA=
X-Google-Smtp-Source: ABdhPJyfc9EvczjpeF+nbOV792W88dwi85PMpl8LlyBitnu4QvgE4tt+Qv8c0Hfw/YNgnkXb5SpW4g==
X-Received: by 2002:a50:cf05:: with SMTP id c5mr13511180edk.232.1593354549304; 
 Sun, 28 Jun 2020 07:29:09 -0700 (PDT)
Received: from Tank.localdomain (82-73-161-131.cable.dynamic.v4.ziggo.nl.
 [82.73.161.131])
 by smtp.gmail.com with ESMTPSA id kt4sm13025837ejb.48.2020.06.28.07.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 07:29:08 -0700 (PDT)
From: erik-smit <erik.lucas.smit@gmail.com>
To: erik.lucas.smit@gmail.com
Subject: [PATCH v2] ftgmac100: fix dblac write test
Date: Sun, 28 Jun 2020 16:26:59 +0200
Message-Id: <20200628142658.29264-1-erik.lucas.smit@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=erik.lucas.smit@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Jason Wang <jasowang@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test of the write of the dblac register was testing the old value
instead of the new value. This would accept the write of an invalid value
but subsequently refuse any following valid writes.

Signed-off-by: erik-smit <erik.lucas.smit@gmail.com>
---
Changes since v1:

Changed %ld to HWADDR_PRIx to fix building on mingw

 hw/net/ftgmac100.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 043ba61b86..b69e3dd14e 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -810,16 +810,18 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
         s->phydata = value & 0xffff;
         break;
     case FTGMAC100_DBLAC: /* DMA Burst Length and Arbitration Control */
-        if (FTGMAC100_DBLAC_TXDES_SIZE(s->dblac) < sizeof(FTGMAC100Desc)) {
+        if (FTGMAC100_DBLAC_TXDES_SIZE(value) < sizeof(FTGMAC100Desc)) {
             qemu_log_mask(LOG_GUEST_ERROR,
-                          "%s: transmit descriptor too small : %d bytes\n",
-                          __func__, FTGMAC100_DBLAC_TXDES_SIZE(s->dblac));
+                          "%s: transmit descriptor too small: %" HWADDR_PRIx
+                          " bytes\n", __func__,
+                          FTGMAC100_DBLAC_TXDES_SIZE(value));
             break;
         }
-        if (FTGMAC100_DBLAC_RXDES_SIZE(s->dblac) < sizeof(FTGMAC100Desc)) {
+        if (FTGMAC100_DBLAC_RXDES_SIZE(value) < sizeof(FTGMAC100Desc)) {
             qemu_log_mask(LOG_GUEST_ERROR,
-                          "%s: receive descriptor too small : %d bytes\n",
-                          __func__, FTGMAC100_DBLAC_RXDES_SIZE(s->dblac));
+                          "%s: receive descriptor too small : %" HWADDR_PRIx
+                          " bytes\n", __func__,
+                          FTGMAC100_DBLAC_RXDES_SIZE(value));
             break;
         }
         s->dblac = value;
-- 
2.25.1


