Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C6EC38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89F3206F5
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6blrxJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89F3206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXtAV-0008Cr-S5
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 17:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt4z-0007JW-S5
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:47 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:42067)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt4z-00016T-4V
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:45 -0400
Received: by mail-ed1-x541.google.com with SMTP id s10so6189419edy.9
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 14:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BXdTrm0G7e8AJaMl1cQX+rO0kJVj/ZnPckUe++HqUug=;
 b=R6blrxJLXjFopvNoqjcbWyGA0Tx2C5Ho57LJOBFAsi+UIoBntgsouUwP4NedlHP+41
 FSR1g4zzpWnWamBjfUrzJHvI7kMXm+QqVRmPR568ef4cTn8xPjjhDl0o8wOox3piyp4q
 txJnM4lkPNs9egQm/EeJj1qdfllhzkx0pfQRxJOt7cxjI3UdWA1KJDOXi2JaNftCDxOj
 uM4j3gF8sf5nxRoaLvV9Oo0noJBA/hlaO/D7Ihc6R9zAm9dKtpsWTElFtApC5+orKIvq
 dsPO7Wgi4jPxaVFtX2Zn6OcFp/4+B96Vz4Rx2DRPWpw2h95kIv59HJKAqZUW2eq8hG0A
 0SYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BXdTrm0G7e8AJaMl1cQX+rO0kJVj/ZnPckUe++HqUug=;
 b=LE3FNNEzRSPBR51cRPOAxvqjmtaazhlTOx4m7x8zW/k1QdECdKA/+4GSDM0+nNW2uX
 6levq8PE/9TUxtTt2gnP3IhbDiHjWbXhGSYseq2Utq2dQf15T5FukXIWvEegciE2JcKB
 t14zGQLJfYW9LZxEj6pkkARGaSNATD06Dk3QpHKRHAxGgQvgwbzcm7O9a8jrCGDiw8ne
 AZtYkT+4AhpFo+U0vgNLp+wuS85hZTfzeM4V8lPV8cdcmRxNESy6I9pxNWNKXtRqG3Ty
 dAeNf974ObCMK/V2VQucwf7crp27TdUoIbLp9q6xIgTJusGU6F/HOILRPcTtrzcnLtBe
 glkQ==
X-Gm-Message-State: AGi0PuafQL3wtkPi+ZtKBstJNvmbWZYQWMXUwWygJQTZHfEYOHlRzq9X
 TO+97BPsewdUj5/6lY60ujK1+nwZ2iA=
X-Google-Smtp-Source: APiQypJd3X5j25RzbHX5+Dee748Upsxfeezlggd4uhxe70bm5KdIiYOjCNeBzNFcibw5/D/KWT5KXQ==
X-Received: by 2002:a05:6402:1d1c:: with SMTP id
 dg28mr10856953edb.315.1589144503742; 
 Sun, 10 May 2020 14:01:43 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id d15sm921152ejr.50.2020.05.10.14.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 14:01:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/12] hw/pci-host/bonito: Fix DPRINTF() format strings
Date: Sun, 10 May 2020 23:01:22 +0200
Message-Id: <20200510210128.18343-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200510210128.18343-1-f4bug@amsat.org>
References: <20200510210128.18343-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/bonito.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index b9bfe3c417..10ead31e4f 100644
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


