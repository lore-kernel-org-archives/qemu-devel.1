Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764ACC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37DDB2068D
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeKsOi4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DDB2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZnd-0001qc-9r
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhZ-0006bY-Gu
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:33:05 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:33866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhY-0005pQ-P6
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:33:05 -0400
Received: by mail-ej1-x644.google.com with SMTP id l27so1708301ejc.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 06:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O0RMe/KIBJnQN5FAGIPVddGSupuK4ETk0arXsanrJz8=;
 b=PeKsOi4qumjPbV79TcUs8QYuLx0iKu8XeX74K5v6mDbdyxph6+FkMf/YaF3eHtHYoX
 IyjwhYZVotyp5zH9K+wero2Z172bIRKUxTtOvyP3cB17XrX7XBsevL1m6cLi7eg7p55c
 OK9eAaOwZAdAcYsgvN5LbWOeDH1mVCrtig8SEF33zcEmVNR4G7pVGOgD5LeZ3oCgkfO7
 ASQ3QNqm4gECTTAx84Ir3JV98fIL1lbAeSe32/EYQG6+r8CG76yulZ4QAuMWu/9U+0qA
 z1tv4jQPILAqZA6fBA592b+HNBdE+Q+9xG5qwXBjGA1a6x9i6BYICKrlKID2FgmJVVDR
 D5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=O0RMe/KIBJnQN5FAGIPVddGSupuK4ETk0arXsanrJz8=;
 b=CRf+TKIxzSde8pQmzsw7yqOScjoU1TGFHCDgB5bhPmcqQU4KrV7c3vUbJsLHT74fVQ
 R+uedPcU5qLUTdYsI94h1cBDm9qSyvIqNPhIlhIpkyby0NyHcYWGuM4yWdKYB4kiQN0L
 UJo9h5cvy+0lSy1c9TsYEMbu66TiGXu8hlGVGUJkU/5hwxNW1u3z8H5LVytjTsxgBcW2
 F4oVDZpyPC9JaGMTWqKoSFu7x1FKo8RBYBXsbjipH7PVmHEPVjvJ2X8Kn3Gad8185NMv
 DRqogUbWV2/bfLC9qTgyylvNvFPxuop/j6On0Upn6U4F2qioV6jY5mK8LuS4zQdHf5df
 yKQQ==
X-Gm-Message-State: AOAM532kImJ9SeSJy1gvNZsi4ygQ3Vk7dmy91XtqC6sF7WxEfrQj/7yI
 zH/bSdhzji9+iMNUtC6UVqYnoaStYcU=
X-Google-Smtp-Source: ABdhPJxj4QYezkhS7+Sy+MlLzKtbDDpFMGDXmjmG0CfPbQKHZgOgtGgOjALCwDSmxrI6+t6Nf1iFDw==
X-Received: by 2002:a17:906:f84b:: with SMTP id
 ks11mr1190807ejb.114.1590499983197; 
 Tue, 26 May 2020 06:33:03 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id n25sm1623084edo.56.2020.05.26.06.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 06:33:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/14] hw/mips/fuloong2e: Move code and update a comment
Date: Tue, 26 May 2020 15:32:42 +0200
Message-Id: <20200526133247.13066-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526133247.13066-1-f4bug@amsat.org>
References: <20200526133247.13066-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
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

Move the RAM-related call closer to the RAM creation block,
rename the ROM comment.

Reviewed-by: Huacai Chen <chenhc@lemote.com>
Message-id: <20200510210128.18343-4-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/mips_fulong2e.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 05b9efa516..6996f5e3d1 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -315,12 +315,11 @@ static void mips_fulong2e_init(MachineState *machine)
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


