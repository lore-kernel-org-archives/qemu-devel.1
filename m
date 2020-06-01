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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264E0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:51:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E50BF20679
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/SPzpS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50BF20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfjur-0007UK-6e
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 08:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjmy-0006BP-6v
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:43:36 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:45945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjmx-00056Q-F7
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:43:35 -0400
Received: by mail-wr1-x42f.google.com with SMTP id c3so11295330wru.12
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 05:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aNhfYIaY3OUVVYH83lAIrkbP3NWpAGizZOAzH/eH6ZY=;
 b=N/SPzpS0QF4aYs3+nSvt1Z2rBWWbxebQ4yvlmvVoTnirt+Re6W1F8sxiV1ahhU78xL
 oA68VDM5ozJwGXZtajRunLnMwB4AVgs6ChnCwJodHi4FnYN689cMjGRZHuBkeGpAI5E7
 HRzfh67+BQIC5pZbdWN3s7t56Da56Gea9Zl45f1doSKOg/+R2/Ahtr6M75vYJm0rttL+
 llWeoN0h/vQiP6M8/pTZ53XleL5mx6IvG7Nbe4ipMX62wYW1l6wQOkgeeqITDlHUfhU8
 AkzZK9gpf0XTTMaDJItnCizrbkh/wriiwsNqBLaMjm12StwLgANJQhNO3n4Srn23O84M
 F1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aNhfYIaY3OUVVYH83lAIrkbP3NWpAGizZOAzH/eH6ZY=;
 b=KInZRxPwGLY33ddiimh54amK4I8Mfslfm10Cry/3Y+c5HEFqu/f8Wk0j7xuJnTwIHD
 dP9uR4SiJiF5lgKfZs63OLCSrhU8gSsCAkhHlZNuvB211J0htaLzb66pIg8v5vlQtonJ
 HJuKi8dj8YRTTtWchDI6XQMdnsme7UKiaZTz98EWwsWXDLPk5v802cWx7JIj/oyvwq6F
 Wk3ExRJ0/15xCAKbQKhHVCz6Ntbx/DcAygjfwtR1nup2X6V8VWP32HVKCMTPYvkImV/Q
 SJjA730cwEwwTLUmSXqDen0Qt6zpXchIsNaOsGHSW2pnLcFAAB7aTHHFgyfZ9Ud+CvVl
 B5xg==
X-Gm-Message-State: AOAM5332FEko46TtvqzDihLnIEV8CJFgsF2+beDzQ6LpjuiJeHS+QMBE
 mE4rAC6/XtmTcXM2zZQTp67Q/6VPon0=
X-Google-Smtp-Source: ABdhPJxeJKLlv0d0Io7p4iohL4w4GIXNw7te6nZPoD3mXU/HSWMcj9sM1VzpnEHeyDKPGvugu48VOQ==
X-Received: by 2002:a05:6000:108d:: with SMTP id
 y13mr23234834wrw.180.1591015410659; 
 Mon, 01 Jun 2020 05:43:30 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id n23sm10948474wmc.0.2020.06.01.05.43.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2020 05:43:30 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/6] hw/mips: fuloong2e: Set preferred page size to 16KB
Date: Mon,  1 Jun 2020 14:43:25 +0200
Message-Id: <1591015405-19651-7-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591015405-19651-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591015405-19651-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42f.google.com
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


