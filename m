Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262DFC38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30B020801
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqoXu9wZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30B020801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXtFr-0005Rv-6Z
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 17:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt5C-0007kB-II
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:58 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:36225)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt5B-00017b-Qy
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:58 -0400
Received: by mail-ej1-x643.google.com with SMTP id z5so5393187ejb.3
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 14:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1cJ5MBtfm5U9bUfRE1+Uv1c5Y0Ygwr9qTN/mJlJtXvc=;
 b=WqoXu9wZb/bqTgN4dO+eKuvahc49X6gJY9xAGr/unrFae8yxJ/yDRx/O093EC0LoV5
 te9oLVY7qA8QcfsYB9b/vXtlbniJPFz/oDbtglZwkdqeOvW07gNPckykztCRY6nxe5BQ
 zEOH3d+sJaEDb+gVQiFzzTu6GgoL9LetaWj6+3ZN8V319zYQbmkV8iGAsoXljN0bC2lL
 dIy9/2xCd9EkCfSTcLIfHz7W4XbrYpm8Xad9z3uk8hWlapnBzmIuDfKf5E9+jO3ZALPd
 q8BwCNS8wqpeo1vhOzh6zrq1ZDdljyvT1ohfsu8iIBjTyjF0+wU/0zi1Axg3JU96PHUE
 rakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1cJ5MBtfm5U9bUfRE1+Uv1c5Y0Ygwr9qTN/mJlJtXvc=;
 b=aBYxZMUuq4Ks6IaPD0dme6vt+/7I+ufcnTx+C6YXlDFGvMbiYe94f/baYkmG3Jh/zU
 9HOtKNNQrDemzSlsXC4rgS//Q9YZmnAV8g3mgeEcn/c7As7pa/0OzGnxiRvmnuVn4Idn
 SMntJ8owKOpxQ43yzK7t9h2PEfqI8AOR96cERon4T1JgKoKZ/ApYRsssxjWyHAjnd3GR
 m7trWb4Vvfpb+zXeHL5RdLTfK3d+slEreHEnYG1Eejwkx3DTlTbZyMy7FmQ035WYftlZ
 T9dnEuPf95KJLnVhhRfit5eUtVbVopJ8zA6jjmZRViMWOfZ3qY8iJ0UNpYWjA0KXsif9
 xODw==
X-Gm-Message-State: AOAM5313/3+CizE1lIGQXKTc+wHFwmfXNHUWFVB8ECROR/f9MCmDbcmK
 jLJfYl+3nCk5A9voyM2uwr+fm0Nja8Y=
X-Google-Smtp-Source: ABdhPJyElAPPG067++3HlLFky7vz1MCCrjzsGj7ynYZU6lV2wqqXVY148M3Q8RfnO5hEwMeACnBEig==
X-Received: by 2002:a17:907:1189:: with SMTP id uz9mr42717ejb.53.1589144516285; 
 Sun, 10 May 2020 14:01:56 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id d15sm921152ejr.50.2020.05.10.14.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 14:01:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [NOTFORMERGE PATCH 12/12] POC hw/pci-host/bonito: Fix BONGENCFG value
 after a warm-reset
Date: Sun, 10 May 2020 23:01:28 +0200
Message-Id: <20200510210128.18343-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200510210128.18343-1-f4bug@amsat.org>
References: <20200510210128.18343-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Damien Hedde <damien.hedde@greensocs.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CPUSELFRESET bit should only be set on COLD reset.
To have the PMON firmware behave correctly after WARM
reset, we need to clear this bit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/pci-host/bonito.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 86aceb333a..60eab867f0 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -586,6 +586,12 @@ static int pci_bonito_map_irq(PCIDevice *pci_dev, int irq_num)
     }
 }
 
+static ResetType bonito_reset_type(PCIBonitoState *s)
+{
+    /* TODO: Use resettable_get_type(s) to also return RESET_TYPE_WARM */
+    return RESET_TYPE_COLD;
+}
+
 static void bonito_reset(void *opaque)
 {
     PCIBonitoState *s = opaque;
@@ -598,7 +604,8 @@ static void bonito_reset(void *opaque)
     val = FIELD_DP32(val, BONGENCFG, WRITEBEHIND, 1);
     val = FIELD_DP32(val, BONGENCFG, PREFETCH, 1);
     val = FIELD_DP32(val, BONGENCFG, UNCACHED, 1);
-    val = FIELD_DP32(val, BONGENCFG, CPUSELFRESET, 1);
+    val = FIELD_DP32(val, BONGENCFG, CPUSELFRESET,
+                     bonito_reset_type(s) == RESET_TYPE_COLD);
     s->regs[BONITO_BONGENCFG] = val;
 
     s->regs[BONITO_IODEVCFG] = 0x2bff8010;
-- 
2.21.3


