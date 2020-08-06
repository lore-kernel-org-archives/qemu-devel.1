Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520A6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1810922D00
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ldy2CiQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1810922D00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3axz-00048N-5s
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 04:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3ax4-0002Rd-6g; Thu, 06 Aug 2020 04:08:38 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:33003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3ax1-0005gW-8w; Thu, 06 Aug 2020 04:08:37 -0400
Received: by mail-wr1-x42b.google.com with SMTP id p20so8172512wrf.0;
 Thu, 06 Aug 2020 01:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Jz0WDn0HteYxXs7mrN9I12dBppq/lF1r2frSPkCB9xM=;
 b=Ldy2CiQiR4hg0J5ePsfDdxpmqS4ktlMVnziOHNwPTC6Kz19sUtDV1UVgRhnjzycVdE
 kJSqL7/rEuAoLvH7yQlyE2UecAc/2fErsv0LwLK0XRl+Noa6+nlGfxoGxBKHQ7N4XzMn
 FkQZRBlvfZwmt16hh0/VKtfs8Lfz+Dlkgou7B2a921qXBuxvuhpr53RS9KakV7HaOaom
 uYJDXfs+1Eq2g7EaCl35SSebhCOZDIokHiTDYtLHbQuAZgogUlA/5RMZQ4p9rOEX644A
 qwiFlU0xSqWOPH5SV0wx3Hw9Mf6hq5fvchI1zRrS1M1tRUy09HLxCo7BZXOax+ErMqNB
 6rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Jz0WDn0HteYxXs7mrN9I12dBppq/lF1r2frSPkCB9xM=;
 b=XQYZ3I+SFNEOW/rMkTkn7wI2rigyX9+YhssLhbHNBtCKvPTDgAhK06e3qvDxXL1mSb
 li+p3OOeFVSCd8N5ATRLjCWfP5rFLRiZtMST+ITpoF809RiDTASn1M9uHnWFQcwp/zhj
 uhus6OmWJPCZqDUu4gD6Zk7vhghzA6LHBtWKwO5RzU3CzM+u1/9knUwPwlJ1oY8yNrgH
 P0r867do2B19D6Wsk5w9s2/PQi8gfCfa7PSVNdHAW/48jK/5SU9JAHYXU5myc7RwzSBF
 ej4RI9Vj3zQ7iEtNqjxMPxlkt4Ab9IE6oPmeK0rAlgJP+alHvWw0MC8DmEqhm0pc5jpS
 sZEA==
X-Gm-Message-State: AOAM531BxmhjIQSytohZ9433UNUMN3+V7aIJnvhKX4H38/1lWOG7oX8I
 NWihcMviMn6fu1hSXAwr9Dhv+eIx
X-Google-Smtp-Source: ABdhPJyAWuwofRGqutjHXh+I76xWr1LqPcbju6RKVxiCJEcnSwabQJhJ/qFk0p2HYvFw6aOJEgxbsg==
X-Received: by 2002:adf:ea92:: with SMTP id s18mr6288388wrm.269.1596701313036; 
 Thu, 06 Aug 2020 01:08:33 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id w2sm6039587wre.5.2020.08.06.01.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 01:08:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 5/7] hw/block/fdc: Drop pointless FLOPPY_DPRINTF() call
Date: Thu,  6 Aug 2020 10:08:22 +0200
Message-Id: <20200806080824.21567-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200806080824.21567-1-f4bug@amsat.org>
References: <20200806080824.21567-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove not very helpful debug call.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/block/fdc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index f9f3f3c079..278220ed29 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2636,7 +2636,6 @@ static void fdctrl_realize_common(DeviceState *dev, FDCtrl *fdctrl,
         }
     }
 
-    FLOPPY_DPRINTF("init controller\n");
     fdctrl->fifo = qemu_memalign(512, FD_SECTOR_LEN);
     memset(fdctrl->fifo, 0, FD_SECTOR_LEN);
     fdctrl->fifo_size = 512;
-- 
2.21.3


