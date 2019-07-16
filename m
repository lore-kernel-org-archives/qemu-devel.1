Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E85C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 11:01:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF307206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 11:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u33ZmDmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF307206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnLCc-0005tn-M3
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 07:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58008)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rfried.dev@gmail.com>) id 1hnLCR-0005TW-C6
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 07:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rfried.dev@gmail.com>) id 1hnLCQ-0005oP-As
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 07:00:47 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37995)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rfried.dev@gmail.com>)
 id 1hnLCQ-0005nn-3k; Tue, 16 Jul 2019 07:00:46 -0400
Received: by mail-wm1-x341.google.com with SMTP id s15so18229246wmj.3;
 Tue, 16 Jul 2019 04:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Zp2PUu/AWHv4Ey8MIvSoqx4r9Y7qfrZOD7/iZct9ZPY=;
 b=u33ZmDmKQI4TJY/7UlTTYmYmooa888KZzfsFyxT//joEefLqDf6Xu4mqM0hfihiVub
 vfXk6Mcc1yinThP6mUGQHgWjtATQTRQ/t7lvHTsZOk/P7pjKfa5iXKp/TCESLkai6xvy
 susSM8o3bINB7bRPQqg+2V4HFWIAU4hPB+8TX3oevx78IRbrTc1khf3MwXS1XsypqC26
 +Iph7QzVGwU61lahgKtGRxkQDVo+cyxE+jb0hX3sZyE98pFvlqkmgEKbLFnp5T+8EvUX
 0oep/D0DI3kiEWbSgJg8w1dDRJA63tAczbuqiIO7RrlqsxhLHff9f05d3hx8USoLWvjj
 Ej+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Zp2PUu/AWHv4Ey8MIvSoqx4r9Y7qfrZOD7/iZct9ZPY=;
 b=LrjIA9xoSv/JI8ClAqVu/frFOEeD8Aaku/oqXlz45MMgEusGu+TGJwPBltAg3HNJHC
 zLLOal2fx42nga7p2ng6KAXWNCPVww2Sehvh+hPJsnUrI7GG3FcRTIYlvHEg/8GSnNip
 OuKDmj10Nh9V47HsOcSw0x7J9VKSgjBZP2SP2ziSTe2y9kixH8M35O91zD6bmgh1I2GL
 YtWfpqMe9Yq+Fqu8JFRDWi5vb6v+U0tDUYF0PV/gxJeniHJ76Ewp2RL0qogKPzKEtXGN
 jG7aaf+rOwWZElOrAOrLdHERho3Nf0MdX3gwsdbTNoJCrYuwKeYY4NWuClYq/tnw05Qa
 WJGg==
X-Gm-Message-State: APjAAAVOeim5jU1MbM2UHAetk3W+bK+8boHPU4OrohZ1uHQoHdwUDJJD
 uxekzcLhQ7opEXbZV2TO/wOnyzY6sM4=
X-Google-Smtp-Source: APXvYqwW5P8PHsdP9x3/0V5gP75o7o4Us1DM8C/3BZPbaCW8N97wVqgsneOH+VVyeitR3+RyXQsGtw==
X-Received: by 2002:a7b:cae2:: with SMTP id t2mr29781529wml.157.1563274844774; 
 Tue, 16 Jul 2019 04:00:44 -0700 (PDT)
Received: from localhost.localdomain ([141.226.31.91])
 by smtp.gmail.com with ESMTPSA id e3sm19289127wrt.93.2019.07.16.04.00.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 04:00:44 -0700 (PDT)
From: Ramon Fried <rfried.dev@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 13:59:51 +0300
Message-Id: <20190716105951.25446-1-rfried.dev@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v2] net: cadence_gem: clear RX control
 descriptor
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, alistair@alistair23.me,
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 Ramon Fried <rfried.dev@gmail.com>, edgar.iglesias@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The RX ring descriptors control field is used for setting
SOF and EOF (start of frame and end of frame).
The SOF and EOF weren't cleared from the previous descriptors,
causing inconsistencies in ring buffer.
Fix that by clearing the control field of every descriptors we're
processing.

Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

---
v2:
  * change function name to rx_desc_clear_control as proposed by
    Jason Wang
  * Move the function call above the comment, as proposed by
    Philippe Mathieu-Daudé

 hw/net/cadence_gem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index ecee22525c..cca3ce7f56 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -406,6 +406,11 @@ static inline void rx_desc_set_sof(uint32_t *desc)
     desc[1] |= DESC_1_RX_SOF;
 }
 
+static inline void rx_desc_clear_control(uint32_t *desc)
+{
+    desc[1]  = 0;
+}
+
 static inline void rx_desc_set_eof(uint32_t *desc)
 {
     desc[1] |= DESC_1_RX_EOF;
@@ -993,6 +998,8 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
         rxbuf_ptr += MIN(bytes_to_copy, rxbufsize);
         bytes_to_copy -= MIN(bytes_to_copy, rxbufsize);
 
+        rx_desc_clear_control(s->rx_desc[q]);
+
         /* Update the descriptor.  */
         if (first_desc) {
             rx_desc_set_sof(s->rx_desc[q]);
-- 
2.22.0


