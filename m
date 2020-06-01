Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AF7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D889C2077D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjYjN99J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D889C2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfjSa-0005Fe-1G
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 08:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjOc-0007vj-IJ
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:18:26 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:40444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjOb-0007mV-Iz
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:18:26 -0400
Received: by mail-wr1-x435.google.com with SMTP id h5so5351884wrc.7
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 05:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aNhfYIaY3OUVVYH83lAIrkbP3NWpAGizZOAzH/eH6ZY=;
 b=RjYjN99J60wg0pQClHpv0+L7oNHibkCqoI+724iehOzAc/Ys2uujdLskNCWtsVFU5W
 95LPQiqJ6ySf8c3KclmHd1jPkkDgWFqpVgCv/PoCyNYBe031gDeP8oYY5QnBqatCQ4LP
 0+KnaVQyDTrUaW1MhNl82ZfaBy+Jb9yyYK0Sh6Epbt05Fige0wPFoWBycLLfBxAe7VAA
 YXDgk3IkiLcmPvmgkWjHu7tZnZuxUrzfaX9n7C7eVnMvPQsgHZK4RvrdAU5KsBnSw0Sn
 hDXWTlWrcQNnwutfdx7/wlsfscd4cMzU6P6xUuLos0LPN1+2SoJ0XhguSDKlRjwAC61x
 DXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aNhfYIaY3OUVVYH83lAIrkbP3NWpAGizZOAzH/eH6ZY=;
 b=sjD0+KGngsLju/NcCe+fBbxVZM2XQEB+bEwfzNEAfX+Q/4iQ+DJiRiM1Cy9rWTa622
 cKNmm75abO0mHPRbcnKzgVUzX/YXqoCAhm3ADInGEl/OJExtpuaAp//R+yrC5ZI/tOv2
 xPXF9YOyHa67C59Gcwoqxjw7vLY9jlvvVb8nLxzmzlFXXZbRCyubhc/E+nZvQSsiwxQC
 Iv9yv/WMNRWH/ggVCqWr8yyKEMb3PhgOPAEris4UUtS4afi2DJNOdrVgBUEo1glUNzew
 kcbGLqyhzb2dD1sVxi+QhatLNagMfYWI4/XhBbTQ4n1P+9RlS093J578Nu2PthIbfrPt
 M4cQ==
X-Gm-Message-State: AOAM533RJ/+zXy5ABoOVgC2l5krADf+Yt/7O09y2tjQdwSI59YACV0mG
 cNE8Pwc7dpmWue1tF1FXoX5rFdiFRJg=
X-Google-Smtp-Source: ABdhPJzf7dBQbHj6/4atDp9na+5oZFgVmjbSJdw3wi0R5IhpALMaaNQCWMdhCqkGi9Ha8XiQzT4QiQ==
X-Received: by 2002:a05:6000:10d2:: with SMTP id
 b18mr21509361wrx.366.1591013904320; 
 Mon, 01 Jun 2020 05:18:24 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id y185sm12332136wmy.11.2020.06.01.05.18.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2020 05:18:23 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/6] hw/mips: fuloong2e: Set preferred page size to 16KB
Date: Mon,  1 Jun 2020 14:18:18 +0200
Message-Id: <1591013898-23391-7-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591013898-23391-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591013898-23391-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: peter.maydell@linaro.org, aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Huacai Chen <chenhc@lemote.com>

Loongson processor prefers 16KB page size in system emulator, so let's
define mc->minimum_page_bits to 14.

Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <1586337380-25217-2-git-send-email-chenhc@lemote.com>
---
 hw/mips/fuloong2e.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index f583c44..7a65166 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -392,6 +392,7 @@ static void mips_fuloong2e_machine_init(MachineClass *mc)
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("Loongson-2E");
     mc->default_ram_size = 256 * MiB;
     mc->default_ram_id = "fuloong2e.ram";
+    mc->minimum_page_bits = 14;
 }
 
 DEFINE_MACHINE("fuloong2e", mips_fuloong2e_machine_init)
-- 
2.7.4


