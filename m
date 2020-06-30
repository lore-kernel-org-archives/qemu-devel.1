Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22C4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D17F2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaBtUbZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D17F2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDFs-0002WH-Pj
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD7H-0002MO-4L; Tue, 30 Jun 2020 06:03:51 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:46400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD7F-0004cO-DD; Tue, 30 Jun 2020 06:03:50 -0400
Received: by mail-ej1-x642.google.com with SMTP id p20so19862446ejd.13;
 Tue, 30 Jun 2020 03:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NATlEi/FrWfP9Y28UrUe6cx6ZnLH5i2MWU0fBA6ejkY=;
 b=DaBtUbZ9gQ88fJaCqg1W2vOGMyqIY/9D/whz1+fvljvv1DGQZXPRecMSCQB8I4LO3A
 r1JHT8ZHOM+IntqKUBny8DzCLc8c7rj4EO8kiPgAQ7lBiCmThOPpIV/ro369cSwStcX7
 pnhii1XAwHubcxz4hSbMSwON4ZC8dKHTsFY7Hk5KtDlNyUdvZ3ZD6lA6NNZvhBpD8dsw
 9N8uPLFbtNSBq/pjEeAgSKqv61NPT2Hlk58GwYrQRWKK0ycUkHbhMIKbCUXenl3BOWpJ
 WAB71hNDjQYp8YbvUGMMHen6hN1gY6N+xZi6fMUys8mFlFSVWx6hlMemoY0LOeq2tJHk
 Krsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NATlEi/FrWfP9Y28UrUe6cx6ZnLH5i2MWU0fBA6ejkY=;
 b=uoZ++opG6Aed8/PqXj1BFr8U+YXh0R3/W1YM9Z24mFGDQ38LrVB/V6XnQqmMLQD5Bc
 7QK/iRiuMCJnbUCXC91j2Mw2+kEj0CZcp1gVRfEiq6Gb0yMcDtCC9HkispeOB1m2HOvd
 BPMASZ1EaBvOz0LzVxynozgRucdedE9zPvDV5trq916MOCRzdojrxvSArsRorwsJitnj
 Yd63f0GmB73iQI0e0e2lWMkRsfB3mXlRJDy8vjdoZ1a6OTDBUCEdg10Ob2DCBlYBKeqe
 6nOzlAxVtwcmERhEw5mbX8de5NAJkABanuWGzsgBivg/xU/XhU7C4JNcykjWZetlcxLF
 Sclg==
X-Gm-Message-State: AOAM533mCDaRk6WqeW1BlkpkmDRAAnvloeTtl4GQ1icdLcWNnYSWajvo
 3AZdcaiKMUFCSq7ecSt7lh9U6vxHibE=
X-Google-Smtp-Source: ABdhPJzP5hbnifycIYAq6uohBTkH9kecJs1Q+ATL2L901J0kDbBlEhlRLxiPVzjNjvz+voZOW7PqZw==
X-Received: by 2002:a17:906:f1d5:: with SMTP id
 gx21mr17183822ejb.121.1593511427426; 
 Tue, 30 Jun 2020 03:03:47 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h2sm2304697edk.54.2020.06.30.03.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 03:03:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 03/15] hw/sd/sdcard: Move some definitions to use them
 earlier
Date: Tue, 30 Jun 2020 12:03:30 +0200
Message-Id: <20200630100342.27625-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630100342.27625-1-f4bug@amsat.org>
References: <20200630100342.27625-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move some definitions to use them earlier.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index cac8d7d828..4816b4a462 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -80,6 +80,12 @@ enum SDCardStates {
     sd_disconnect_state,
 };
 
+#define HWBLOCK_SHIFT   9                       /* 512 bytes */
+#define SECTOR_SHIFT    5                       /* 16 kilobytes */
+#define WPGROUP_SHIFT   7                       /* 2 megs */
+#define CMULT_SHIFT     9                       /* 512 times HWBLOCK_SIZE */
+#define WPGROUP_SIZE    (1 << (HWBLOCK_SHIFT + SECTOR_SHIFT + WPGROUP_SHIFT))
+
 struct SDState {
     DeviceState parent_obj;
 
@@ -367,12 +373,6 @@ static void sd_set_cid(SDState *sd)
     sd->cid[15] = (sd_crc7(sd->cid, 15) << 1) | 1;
 }
 
-#define HWBLOCK_SHIFT	9			/* 512 bytes */
-#define SECTOR_SHIFT	5			/* 16 kilobytes */
-#define WPGROUP_SHIFT	7			/* 2 megs */
-#define CMULT_SHIFT	9			/* 512 times HWBLOCK_SIZE */
-#define WPGROUP_SIZE	(1 << (HWBLOCK_SHIFT + SECTOR_SHIFT + WPGROUP_SHIFT))
-
 static const uint8_t sd_csd_rw_mask[16] = {
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfc, 0xfe,
-- 
2.21.3


