Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73633C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 20:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD5320724
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 20:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLt8axL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD5320724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsBem-0007ej-Gp
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 16:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsBXC-0004oI-Uz; Sun, 05 Jul 2020 16:46:46 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:39212)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsBXB-0000qM-Bm; Sun, 05 Jul 2020 16:46:46 -0400
Received: by mail-wr1-x432.google.com with SMTP id q5so38718653wru.6;
 Sun, 05 Jul 2020 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kNwib0BMo1+5Iu5sjaNj7HGTV7ZxsjSjKRCMexInxyg=;
 b=uLt8axL5DGUbglnhirInKZ6wy5zC9Rf5Nde7P2D3eB7Jtr8YcQDVOqywS9poHF1n8U
 jRwbs1GKuJne8DuQRWv5+EkIynR2wuywL5jY89HjKj+NukpaenXkttWWNu4F+PQtfJDU
 A3wtGiDRIy7p7jTSEwL0kLOlGM9/lDdB5famGENHUDmQu2HuNcxV4+0zJmHxkH08/5J5
 dtkI8jLYK2ALuf9Q3KhttqtvFGmB0+rw7NDzBcOw/N3PuE9SqbiY3edia3UiG67twD0O
 5tXAj01dPnDyYSr+rCcT8+wpfwUmCgP1BWHYaCoYqWB0w7upiOQmXnVNYSpOo156FrOU
 bNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=kNwib0BMo1+5Iu5sjaNj7HGTV7ZxsjSjKRCMexInxyg=;
 b=oTioSonD69o6BiFKtRs8ZyakOwIfauD8UEhgMCA3h9HAtW5fHbx9HmxRVOPN6AUZLl
 wOamKrZVZCBJAWzxk5B34b+1WgQS1QmhrTMb33qvn2Azp5bNF8gGeblurOeEzr1/BI+X
 051nK8XIeGEqxTx4G+Sl5tX4Xy7BIuHzJT2/dEKRDEfBZQ4NYEOK7s6TG+LxZETxq2u7
 vsK9STh91dWXw+5VXsKO20HARmpmjGxfOsqsSNO8KmbG6dzCOnrNwXfOcYGTBuZhJHW6
 dc9x7oluzwRVKvzQ4V9OK33vcAGygGST6vsCbDo5kEl4RW8xSC3NGW3TfEPiekBPQqiU
 7xng==
X-Gm-Message-State: AOAM531ve90X6IU61F6yBjP+i92X3e6MgsVbkTuPH/BcrUm16EFtr/Aq
 644I70GciISVql7ZlKvYHtf66rB3cT4=
X-Google-Smtp-Source: ABdhPJxZ+r34r9tSOXg1sfVhSImkPRW2+KzqKZ2GYiL68eTQhEjPjIygq6R/ElgZ/c9/2SzCSKB+mg==
X-Received: by 2002:adf:82a1:: with SMTP id 30mr48880977wrc.210.1593982003494; 
 Sun, 05 Jul 2020 13:46:43 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id g144sm51397817wme.2.2020.07.05.13.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 13:46:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 09/10] hw/sd/sdcard: make sd_data_ready() static
Date: Sun,  5 Jul 2020 22:46:29 +0200
Message-Id: <20200705204630.4133-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200705204630.4133-1-f4bug@amsat.org>
References: <20200705204630.4133-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x432.google.com
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
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alistair Francis <alistair.francis@xilinx.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

sd_data_ready() belongs to the legacy API. As its last user has
been converted to the SDBus API, make it static.

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-Id: <20180216022933.10945-7-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sd.h | 1 -
 hw/sd/sd.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index a84b8e274a..ace350e0e8 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -143,7 +143,6 @@ int sd_do_command(SDState *sd, SDRequest *req,
 void sd_write_data(SDState *sd, uint8_t value);
 uint8_t sd_read_data(SDState *sd);
 void sd_set_cb(SDState *sd, qemu_irq readonly, qemu_irq insert);
-bool sd_data_ready(SDState *sd);
 /* sd_enable should not be used -- it is only used on the nseries boards,
  * where it is part of a broken implementation of the MMC card slot switch
  * (there should be two card slots which are multiplexed to a single MMC
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 97a9d32964..54b1414131 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2059,7 +2059,7 @@ uint8_t sd_read_data(SDState *sd)
     return ret;
 }
 
-bool sd_data_ready(SDState *sd)
+static bool sd_data_ready(SDState *sd)
 {
     return sd->state == sd_sendingdata_state;
 }
-- 
2.21.3


