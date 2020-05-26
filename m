Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675A9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CD320776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnGgMoG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CD320776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdXBF-0005QF-72
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdX7O-0006dO-Jk
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:47:34 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:33747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdX7N-00028S-T3
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:47:34 -0400
Received: by mail-ed1-x543.google.com with SMTP id e10so17247515edq.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 03:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ggaqUitOgObz+chiNuLJcGpCPcKRZm0Lw0VDsUASAl4=;
 b=EnGgMoG4ttoSuhw8w2FpjnXtuX7DCMSL1yKasNWGULFouKNII8OhBN29Iqrkjsgz4Q
 nsICaD56mBMrYQVAH+wTeRnJHPieWemcjo+UpjD83ZdB8YtEj8BXoByl+ksqHctzDfFN
 iVYOGpbn/2hDHcVYYztVyde6lzyZKIeSrS5sTbJOKbqcRCUxTgPHG0sylYmKvJDxsLOn
 ooxr7TD7QEAvaZzEIKbeHHmrW+NK1pQ0nkall+h22Ilcx13vjE7gGV4f5PdgGWrzzGEk
 MDezow3fYvoXKc7ICP1L1O1mp1XvOtaxMe9JbIVqjNiBfu+HZvlkbkESa9KhqNylfgeS
 0eGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ggaqUitOgObz+chiNuLJcGpCPcKRZm0Lw0VDsUASAl4=;
 b=PKJwe4YVe7SVQ20Ww8TGJHlzUFjcb6octLThWAfYq5WbURAECHala8hlnrWmvoPbCb
 ech2czu57SricfXUDvWY6SZjVh7An6Gdt1UF7rjV4QvmjPBp2ntcKaoR6wpJcL3mRBAp
 w4EPBOB5uj9xJ0j8+D+KD2Ey2ebSvxVolXC5Pgl4m74f79t3ATm3weZqiyuUFYWCqCWu
 CKrdNcMsPexF6ZcqzekcjLYwELcHrdIH71ITUkspI3rRkhjRvtaNQyJhR0tpIVPsNcpO
 AFaoPXVNGu3UGVB1M6dA0AWUci2PfKAydvrN9GWLm6/EiufDhSsQgsBbBYTrw8CP1muX
 nnqA==
X-Gm-Message-State: AOAM532jJ44EzNkWYk0oM+zDoamzQnibb2NG3XvgXyDMNeF73jzliATg
 /kHNgV2fc1kioXQ6LaIIbpR5UhSTpl8=
X-Google-Smtp-Source: ABdhPJxy5Yt4QNhV3OrxDn1sBvjeygkmnp3F2ZNlxu6gBtX2nm7wc63EgImf+9mXXhiPNaXynTIxZQ==
X-Received: by 2002:a50:fa8d:: with SMTP id w13mr18251047edr.280.1590490052422; 
 Tue, 26 May 2020 03:47:32 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id c27sm3342597ejd.19.2020.05.26.03.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 03:47:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/14] hw/pci-host/bonito: Fix DPRINTF() format strings
Date: Tue, 26 May 2020 12:47:15 +0200
Message-Id: <20200526104726.11273-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526104726.11273-1-f4bug@amsat.org>
References: <20200526104726.11273-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Huacai Chen <chenhc@lemote.com>
Message-id: <20200510210128.18343-7-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/bonito.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index f212796044..b874468ea6 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -239,7 +239,7 @@ static void bonito_writel(void *opaque, hwaddr addr,
 
     saddr = addr >> 2;
 
-    DPRINTF("bonito_writel "TARGET_FMT_plx" val %x saddr %x\n",
+    DPRINTF("bonito_writel "TARGET_FMT_plx" val %lx saddr %x\n",
             addr, val, saddr);
     switch (saddr) {
     case BONITO_BONPONCFG:
@@ -327,7 +327,7 @@ static void bonito_pciconf_writel(void *opaque, hwaddr addr,
     PCIBonitoState *s = opaque;
     PCIDevice *d = PCI_DEVICE(s);
 
-    DPRINTF("bonito_pciconf_writel "TARGET_FMT_plx" val %x\n", addr, val);
+    DPRINTF("bonito_pciconf_writel "TARGET_FMT_plx" val %lx\n", addr, val);
     d->config_write(d, addr, val, 4);
 }
 
@@ -474,7 +474,7 @@ static void bonito_spciconf_write(void *opaque, hwaddr addr, uint64_t val,
     uint32_t pciaddr;
     uint16_t status;
 
-    DPRINTF("bonito_spciconf_write "TARGET_FMT_plx" size %d val %x\n",
+    DPRINTF("bonito_spciconf_write "TARGET_FMT_plx" size %d val %lx\n",
             addr, size, val);
 
     pciaddr = bonito_sbridge_pciaddr(s, addr);
-- 
2.21.3


