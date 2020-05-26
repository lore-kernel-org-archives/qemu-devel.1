Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52D8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB9E2089D
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+liUXVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB9E2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdXDE-0001P9-SM
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdX7X-0006wR-Qh
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:47:44 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:33749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdX7X-0002Ab-5c
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:47:43 -0400
Received: by mail-ed1-x544.google.com with SMTP id e10so17247812edq.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O0RMe/KIBJnQN5FAGIPVddGSupuK4ETk0arXsanrJz8=;
 b=H+liUXVl/w8SmXcvC+Ql+HMJplISn4a/nIfwYIH/UQZDe5YgTOitTCXbYiPyEB1FM9
 EPYWJxSMkvdRTksmn30MB3+MF0ZrOAl/7kHtPuM2lFz6KaiydwzJvI+splJODH3W83TY
 cfl9G7vwWQnvp4dE9MrFXceIVFb4lsmBCxk0PxOc3RZ82LZoPfcGqjLR/2j0V1pdVtsc
 NB/sGC1HXRXeClbeEKhPk5stPSgDu/5gVuoJHJlNpIBxIP3wX+M7uefc7AC4a8LuUiKY
 IW0C7td/RIaAUOdSswxE+TgMril0PhTEp2o3bfE8DhDzdh8GrKUCP2307ZNdAC6wXMV+
 T2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=O0RMe/KIBJnQN5FAGIPVddGSupuK4ETk0arXsanrJz8=;
 b=DbktyWtkpQM+0B2EgsUY6mI1FsHFVvTg+MwRTHM6AVcIzTMy6R1145yLg1ztz4K0JM
 xPkOIpJVPGE4fJajDTw++CUpl20X0DTJCxAz/vcH5gijlxrGFPwF3fi8haMu/IQXmnaC
 /kkEkWUGPfZeKwvDjTC33apgAF7eXh0O8ac+kDZ18iTqPH4on1m6iprNNXXqKYjOYcmO
 v2epgpRQ042p+YbZVHc8P8LittJ4V7cRGcroBjQG/9zgzmM7254VWKJ5QF0FXakK15Z+
 zAjWTj+pE69oeevn52uhB7Dt/Mz8nrU8RRhGRblHmZYCGWUp4loOY+qXOUmR1U2cmXMs
 M6iQ==
X-Gm-Message-State: AOAM533hhmTeIITlkoA7LoMBb+yV2kza14siB1iHsA5WOXSeuQVrIYA1
 HFy0DnHWZsu4Ue3S1fxU9huC+wontVw=
X-Google-Smtp-Source: ABdhPJyyAHRwvz1QFqRke0gd34JWn3GXI8WomKQHJsrtEZW5IitbO859IkEZ7qbYfUjNEdXttrAzog==
X-Received: by 2002:a50:955a:: with SMTP id v26mr19533154eda.5.1590490061184; 
 Tue, 26 May 2020 03:47:41 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id c27sm3342597ejd.19.2020.05.26.03.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 03:47:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/14] hw/mips/fuloong2e: Move code and update a comment
Date: Tue, 26 May 2020 12:47:21 +0200
Message-Id: <20200526104726.11273-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526104726.11273-1-f4bug@amsat.org>
References: <20200526104726.11273-1-f4bug@amsat.org>
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


