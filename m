Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CC3C388F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE49B22280
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tPdezbc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE49B22280
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka0DF-000610-1H
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 12:35:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ka0A0-0001ak-EH; Tue, 03 Nov 2020 12:31:56 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:42342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ka09w-0007cn-Tv; Tue, 03 Nov 2020 12:31:55 -0500
Received: by mail-wr1-x42d.google.com with SMTP id w14so19361911wrs.9;
 Tue, 03 Nov 2020 09:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=foVWc9r1HLdO6p7KIENhYlJk5TO0X5g97/2uwPfPPpU=;
 b=tPdezbc1n/7FgU5soWgfOfxx7A1MGkzMndrq1LMmGVfF/x5VqKU/QTeZB8jths/pqg
 BUXUz/A/y+v+iMkJNBN3vIHbngVb6xSVdnsrU45ujRvMhhV/NJ5FXYbcpXxRisQ82MBn
 IIOjk2Ss72J4goucFk/2EBLv85txKUBm/Tw/ZLEjEt3m3aVX7vGv9JAv2F0HNeOkbJcD
 vEiLEB+owCDzzjQ9suud2WpJHW7Ssti3nIpmUKpLpk10p9UZkzNtsEDRXWcJ1ETTMDio
 SvzPxrqRTHdaWGMHfS/mMy8dTXLYiXwEd/rgeEfOru3VvcXoQf+ijGHDY5rPsTiGB1p0
 raJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=foVWc9r1HLdO6p7KIENhYlJk5TO0X5g97/2uwPfPPpU=;
 b=Nbp4t7fCUBnzZ5B3mCrR6UuAIgS2O/+TnA604oZbCOgCIvJ4xxClp/ktUCLXLRej1F
 tCa6o0tn+N76ZFDN3jh1i0AkqpJzg+rGHCuCx1Lc5hiFk7r2kf7ppaLhK8SP9dWZz7NB
 5AE94xm/HNAusIO2NqdSKT7HKUxgwEWBB/Rbv1wfqLgZrZwdFURwS71ujuq8+kQr0qq0
 Ic7fQ7w0+TgB+oIfbMwWH48ULPzRF9+rvW/cAGeQz56SxMDpFZwJRc0b3hgSZrmTTIeP
 7b5j/nw5vgguBZF0+zfsIGk1QbKBUw8t3DUlZPGrEhoMBQtWTz6P6GSQihMHEW8VfQ+N
 L6TQ==
X-Gm-Message-State: AOAM532aj35AwJnlUwnEEFVbRhpciEtuHIahh5WVKFa0+j3+xekpR+Kw
 8sedFy/qh55V/Mt83UF91vP7aP9DWBo=
X-Google-Smtp-Source: ABdhPJyQKtbepnTGklAK/im/LjZLVxerUBaDgLC7W9fp0ilK2rCBdCDV4yFrPYGkdsvlFRur0qpE9A==
X-Received: by 2002:a5d:4b12:: with SMTP id v18mr27108339wrq.259.1604424710951; 
 Tue, 03 Nov 2020 09:31:50 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id x10sm25986458wrp.62.2020.11.03.09.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 09:31:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/6] hw/intc/loongson: Fix incorrect 'core' calculation in
 liointc_read/write
Date: Tue,  3 Nov 2020 18:31:25 +0100
Message-Id: <20201103173127.2704256-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103173127.2704256-1-f4bug@amsat.org>
References: <20201103173127.2704256-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Paul Burton <paulburton@kernel.org>,
 libvir-list@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Euler Robot <euler.robot@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, AlexChen <alex.chen@huawei.com>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: AlexChen <alex.chen@huawei.com>

According to the loongson spec
(http://www.loongson.cn/uploadfile/cpu/3B1500/Loongson_3B1500_cpu_user_1.pdf)
and the macro definition(#define R_PERCORE_ISR(x) (0x40 + 0x8 * x)), we know
that the ISR size per CORE is 8, so here we need to divide
(addr - R_PERCORE_ISR(0)) by 8, not 4.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Alex Chen <alex.chen@huawei.com>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <5FA12391.8090400@huawei.com>
[PMD: Shortened subject]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/intc/loongson_liointc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/loongson_liointc.c b/hw/intc/loongson_liointc.c
index 30fb375b721..fbbfb57ee9c 100644
--- a/hw/intc/loongson_liointc.c
+++ b/hw/intc/loongson_liointc.c
@@ -130,7 +130,7 @@ liointc_read(void *opaque, hwaddr addr, unsigned int size)
 
     if (addr >= R_PERCORE_ISR(0) &&
         addr < R_PERCORE_ISR(NUM_CORES)) {
-        int core = (addr - R_PERCORE_ISR(0)) / 4;
+        int core = (addr - R_PERCORE_ISR(0)) / 8;
         r = p->per_core_isr[core];
         goto out;
     }
@@ -173,7 +173,7 @@ liointc_write(void *opaque, hwaddr addr,
 
     if (addr >= R_PERCORE_ISR(0) &&
         addr < R_PERCORE_ISR(NUM_CORES)) {
-        int core = (addr - R_PERCORE_ISR(0)) / 4;
+        int core = (addr - R_PERCORE_ISR(0)) / 8;
         p->per_core_isr[core] = value;
         goto out;
     }
-- 
2.26.2


