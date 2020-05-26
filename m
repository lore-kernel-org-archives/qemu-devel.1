Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A8FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FDAC207FB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sd2LZmIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDAC207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZif-0008PE-Gn
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhQ-0006C9-PV
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:32:56 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535]:35146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhQ-0005oD-3N
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:32:56 -0400
Received: by mail-ed1-x535.google.com with SMTP id be9so17660716edb.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 06:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ggaqUitOgObz+chiNuLJcGpCPcKRZm0Lw0VDsUASAl4=;
 b=Sd2LZmIzfNaVBV0EncmpM1ek7MxgANDkzCTUU953CaHF73YiBjykEhNocREkUtnamg
 5WQ6M5uS06nmxiHFGyJxIHdPjLeFQ9VMFmg/NvtioM/ny0KITodQOluqp5kJkL4utiQC
 ExoPv9jpc/Ps9FbUBsGqn9+h917KogfbxgaQcCJmb8tSS2gdQWyo8w1Q08MhXau1iygW
 d/BGzpcfWP8hmkXcgkB5lVdPZf1HfD0kB3h/7fLqaWSJqtxoR8c1UkvuWCoRLcVufruL
 D6Tn1j1gmVeIFxn9mwqXDEkyp54vKnJreXRfdveVO/JcV8voLZM/Y5RxS/I5nkxHYF1r
 1zow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ggaqUitOgObz+chiNuLJcGpCPcKRZm0Lw0VDsUASAl4=;
 b=XTqWT2ms2h3uZQUYA8MTmt5nzAkNFpmCa2g05M0rixzfuqlo3usnWlgtaGTNSgtpyc
 /t6Xv+LHgsDB14Sl6skmDe3Nny6+s+br9jJI26itgvtjLUOPWhVhcd6vBbP060QdbtLB
 +2qylFdPV84OH3rBCQomoYoRH6aQ6txiV3e1AeVC960m3LZsA6z/CPrt9M3+mNCfevUg
 jIRQv8XnnNjYBH+hDflflT6gv17b4TMfiOITry/xTysJFo7oaPv0ih05FwiFeuaIDBUJ
 ZuHT4j2XxFu52VpCaJR3kGMHyBErTa+Pj258AnkSRK8c8NsLgESB8L0c2TtTZRK13CEV
 WE9A==
X-Gm-Message-State: AOAM5315WRe0mPEtjZf7ykcV5RrXUZ5cEhmiKVjHozQxocH4JCw8dYzp
 5oQe0VsT7QQKi4tRwapBgCvBYf+eSP4=
X-Google-Smtp-Source: ABdhPJzlU0PKXICjatTn4uD6jpLoOSgvHPjzWWlceZm8/iHTSrsNzMzNa/Ad9XKj7ed9QUV48aI65Q==
X-Received: by 2002:a05:6402:22d9:: with SMTP id
 dm25mr20402790edb.380.1590499974015; 
 Tue, 26 May 2020 06:32:54 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id n25sm1623084edo.56.2020.05.26.06.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 06:32:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/14] hw/pci-host/bonito: Fix DPRINTF() format strings
Date: Tue, 26 May 2020 15:32:36 +0200
Message-Id: <20200526133247.13066-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526133247.13066-1-f4bug@amsat.org>
References: <20200526133247.13066-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x535.google.com
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


