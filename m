Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F98FC54E8D
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:03:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A362080C
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nd0VSjkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A362080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXt6c-0001A2-A2
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 17:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt4v-0007Bl-Ec
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:42 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:44021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt4t-00015x-V0
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:41 -0400
Received: by mail-ed1-x544.google.com with SMTP id g9so1683301edw.10
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 14:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+ZxNxslkecYKX5bxxdVY39Xg+MqGP6GRs661eU+PrOc=;
 b=nd0VSjkOzx4wZE4yfHeg48nPpmhdlQY+3MC+d7MMVNeqtSqE9+z9MkO62ibInFBuKk
 +c95ytRjX5gJbsKNo+BkWXkaTjL+6vy84iYf8K5Bksg2B5V4RgjNCzSTs4CACmxkNEYR
 iIEreaP4PS641abVl8l5LYkioe55raCklnXtZP7yfXexDkd3EnJovP8Qs9i8hu8pTD+Q
 GJN0qTQucPS38AXwm2CSikwqC3IizEaqc7+ncZ9G8RaQ6HetbckytRT9OBNp0xzkT5w0
 qjkBMfPG3r5BPL7QLdiXf16giWPPwWhiSmTkfbQ+8oAOwiv6cRPqpRfuXgxzToyUil6i
 2MMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+ZxNxslkecYKX5bxxdVY39Xg+MqGP6GRs661eU+PrOc=;
 b=Bbt5shhzOo+VvHAk5x2fK0gosYC69nl2q57up+2js+3a4LyqsD/wkVhVBhnn5zCTX+
 yzFKtaYgYLBecRU12DHjivoDw9w7dBWo3KwGBd59N1YlZL5mD8SH3GiSKiDYG0Qer9yN
 B5BdrY3h6WurYaGkx+is603RejoHrEGynXm6S4oxFC1qvgl7ACztk4CA8y4r0udctZ4l
 oys/xYBSjKU5T1I+ZNQu/BYhRrXmNooPPJHNt1LsOmZKfTZRNbioCQdouxj5Bu3DMHYe
 PjMYQHGaewskfdhO1JK9tgZfswgcsIwyf5ylH8a/JSWyp9YUcexni3MoXPP4/3KIJKrT
 tJzg==
X-Gm-Message-State: AGi0Pua39few++SBtx0ccvmrRKzLPRM7n7ALbyw/FjW+2Gm8TZIIEBHk
 VbzPF6X1DKz7fHmZlAMRjO8Bu5zv8fA=
X-Google-Smtp-Source: APiQypKRqF9l2r5+e9JdH3s/YQq+YwyrzzCNfUrOxujBOvnWWx7bOmuw0cznetegtXdLkQvxuu068Q==
X-Received: by 2002:a50:d0d7:: with SMTP id g23mr4850665edf.163.1589144498141; 
 Sun, 10 May 2020 14:01:38 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id d15sm921152ejr.50.2020.05.10.14.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 14:01:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/12] hw/mips/fuloong2e: Move code and update a comment
Date: Sun, 10 May 2020 23:01:19 +0200
Message-Id: <20200510210128.18343-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200510210128.18343-1-f4bug@amsat.org>
References: <20200510210128.18343-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
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

Move the RAM-related call closer to the RAM creation block,
rename the ROM comment.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/mips_fulong2e.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index f067fa9720..4e1a3646af 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -316,12 +316,11 @@ static void mips_fulong2e_init(MachineState *machine)
         error_report("Invalid RAM size, should be 256MB");
         exit(EXIT_FAILURE);
     }
+    memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
-    /* allocate RAM */
+    /* Boot ROM */
     memory_region_init_rom(bios, NULL, "fulong2e.bios", BIOS_SIZE,
                            &error_fatal);
-
-    memory_region_add_subregion(address_space_mem, 0, machine->ram);
     memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
 
     /*
-- 
2.21.3


