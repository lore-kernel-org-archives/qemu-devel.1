Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16863C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5A821783
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQsAbqbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5A821783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX68i-0008Kw-Kq
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 11:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63n-0001no-Ag
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63m-00063v-1c
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:08:59 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:36305)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iX63l-00063P-Rg
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:08:57 -0500
Received: by mail-wm1-x331.google.com with SMTP id c22so4362898wmd.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 08:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sBQlJETMYugVSeDk54+9qbskMtGOF34Hx0TwffurVig=;
 b=WQsAbqbzJCKVssGPbRpeEdaidHG+YJpwbUQ2u5MufL9cje89zhlfhguUe/jWZVWPVK
 40DiQVbb3P2QHVD9r+1iV+gyaHy9JE29a9ZTUV4FKBlphj7QZVNUBJrzaAMez1YQomcP
 y0RG5UHZJaNqtCLmfH37kbWlbvJFnXs3Ai2Q9c5hyzPNWeb69i9HG0dx9quY+erqud2S
 KDiN+iZawRWvaUxOnbGQ8hjnvCl7GgfX5ON4rXUV2flDWsU3VIVS1hsqJxx/AMhHjYfl
 gIm4DWS9m+JVjYAKUA9xR6fRocA3AthxMJ/GfRdadkB6yyrN7OLEBuDBJr8/Un44yayx
 zvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sBQlJETMYugVSeDk54+9qbskMtGOF34Hx0TwffurVig=;
 b=a+t/VOMSELeDxMe8pOARko2bgBfMBPlpMOX2M6s8nEYGyGqUcRQ8GlEivqedNtNCqj
 CdcU0QxEx2TPf7hyY3fRdulkBVcGNn5LOkBun3Uta1TXtV3goseJJ/BDCYM8Xf0xDCHR
 bPS8vHkJvG/cZhzyItF9vZN3EbE+MM962kQEONaq27jhHEGE/a282V1cgdFIZxwBHzfI
 TCizOAGppBrms+c1jnzH6M+gSwArB45l6fyGeEksefrjHXcHIpCbNzu6VRUEKkiFhPpK
 zRn+oybg7gb2GHDx6It7W1gWKLji4Y1Ed9OyjdeX4DytDicrxKqmh2Kvfav9SeFx4/AO
 vssg==
X-Gm-Message-State: APjAAAURuG5zR79dKYwkRgYfoz2Q05zR8g0lk/KO2w1fzJpMoUvooyql
 bgo7CRjj3sp7DSdCoZo+pS+13UZp
X-Google-Smtp-Source: APXvYqwNpZWeTZWy4Pg6dg9vk05jArKssdsqKsfk5SfsGGzQ+oMdfBHUMgtvGH69aO6NZQ9Zzw6Ayw==
X-Received: by 2002:a05:600c:2102:: with SMTP id
 u2mr6600993wml.49.1574179736546; 
 Tue, 19 Nov 2019 08:08:56 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n13sm3442203wmi.25.2019.11.19.08.08.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 08:08:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/12] hw/i386: Fix compiler warning when CONFIG_IDE_ISA is
 disabled
Date: Tue, 19 Nov 2019 17:08:41 +0100
Message-Id: <1574179728-35535-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
References: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

When CONFIG_IDE_ISA is disabled, compilation currently fails:

 hw/i386/pc_piix.c: In function ‘pc_init1’:
 hw/i386/pc_piix.c:81:9: error: unused variable ‘i’ [-Werror=unused-variable]

Move the variable declaration to the right code block to avoid
this problem.

Fixes: 4501d317b50e ("hw/i386/pc: Extract pc_i8259_create()")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191115145049.26868-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 2aefa3b..849ee12 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -78,7 +78,6 @@ static void pc_init1(MachineState *machine,
     X86MachineState *x86ms = X86_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
-    int i;
     PCIBus *pci_bus;
     ISABus *isa_bus;
     PCII440FXState *i440fx_state;
@@ -253,7 +252,8 @@ static void pc_init1(MachineState *machine,
     }
 #ifdef CONFIG_IDE_ISA
 else {
-        for(i = 0; i < MAX_IDE_BUS; i++) {
+        int i;
+        for (i = 0; i < MAX_IDE_BUS; i++) {
             ISADevice *dev;
             char busname[] = "ide.0";
             dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
-- 
1.8.3.1



