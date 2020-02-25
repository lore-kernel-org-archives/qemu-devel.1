Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2C7C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B14121556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqAiEllT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B14121556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZSK-0007ge-Ij
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z08-0003Qp-9l
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z07-0003Sj-Az
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:48 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:38931)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z07-0003Ra-4H
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:47 -0500
Received: by mail-wr1-x429.google.com with SMTP id y17so5623095wrn.6
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O1qhX1Ps76szem3mO23rokiaDRG68axNgB/K7kmH7go=;
 b=AqAiEllTZiWcWR3hDTzTRLNlk44InMCQcPS5K92B0J0LitIoVcUfJ8B+Jun0B/j+EH
 BNwMuE/8wuAe0mX6Dg2RfcZDQfKZPLKNJzusL9ve7gVU8+wZPdPJc30RxIcanhqe7YGi
 NTI1cMYnNoeg/YnaCNAj02HxpaqmTEs22jNkR1cZOS2K1BmlQzm6My2pmx+IWDOToiyz
 MtBNd9GvcXxzbrU3hJ0jU7HWWJMu1adJQh79QlQCvKqDbdRA8Qv79M3dWWlOHnYCjjcD
 MJxVRUzD4T6xjgz1p6RdPV0P9L0VzcxKhVMDrjMIbhdlEuKhcJcVuIVgw62/KweX9nu9
 4dBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=O1qhX1Ps76szem3mO23rokiaDRG68axNgB/K7kmH7go=;
 b=JgOeEcvADNz6DrvUmfZYXXOYpgIfqoB3Q685ulM7/x047tgwo48w42DbM62mYhJY6j
 20ZVYukWSsW/uC3aZv1vL7FOAatQoOGDJadEnAf1seCR9rRcvYNsxkiImDd1lm8I4Ak5
 QQmIIJe/PTfcNIaDqDIWWfd6ogHJApra6BrG0wGzIdMzCEdnjyLFfTyjv3wEvuqKTVbJ
 UboGDzHWEPnFJsFwxET1Et+iSqkKpuNCLpDmSpPpp+IFlcupw2ZgG/6Srs2Lc+wtGiLL
 qTePsBrVlJE0FaWA5AMcPo1Xkzw3ZfrCFvfJVp0tHeHGrQuj5fXokvN1Uox00f6gDVNN
 7lLQ==
X-Gm-Message-State: APjAAAU+SZcuWUqIlYzNgLpmoZGI2Ae9buBzpRWQrJaj3mAVVqmQ7qSn
 ktIf8nEUulFxQYlyD3ONsu1oEF+O
X-Google-Smtp-Source: APXvYqyGUBFEr0XYmsk9zb2qJlxbleH7Yn0ILCD3VNoRbLnP42K3fRXt5h3yvMVo0MTsFKUMTPzVgQ==
X-Received: by 2002:adf:f581:: with SMTP id f1mr73493786wro.264.1582632464760; 
 Tue, 25 Feb 2020 04:07:44 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.07.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:07:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 111/136] hw/sh4: Use memory_region_init_rom() with read-only
 regions
Date: Tue, 25 Feb 2020 13:07:09 +0100
Message-Id: <1582632454-16491-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-14-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 hw/sh4/shix.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
index 2fc2915..56c7d29 100644
--- a/hw/sh4/shix.c
+++ b/hw/sh4/shix.c
@@ -53,8 +53,7 @@ static void shix_init(MachineState *machine)
     cpu = SUPERH_CPU(cpu_create(machine->cpu_type));
 
     /* Allocate memory space */
-    memory_region_init_ram(rom, NULL, "shix.rom", 0x4000, &error_fatal);
-    memory_region_set_readonly(rom, true);
+    memory_region_init_rom(rom, NULL, "shix.rom", 0x4000, &error_fatal);
     memory_region_add_subregion(sysmem, 0x00000000, rom);
     memory_region_init_ram(&sdram[0], NULL, "shix.sdram1", 0x01000000,
                            &error_fatal);
-- 
1.8.3.1



