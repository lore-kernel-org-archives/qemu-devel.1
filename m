Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BE7C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:45:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71C262067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oubnBGzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C262067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAhx-0004Jx-UI
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWI-0003dF-Py
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWH-0004FW-J8
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:06 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35421)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWH-0004Ev-DB; Wed, 08 Jan 2020 07:33:05 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so2337044wmb.0;
 Wed, 08 Jan 2020 04:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xX2tRJTI+oPA1urf0BIrcVPxBfzc8Z7IkhMGTh2h8oY=;
 b=oubnBGzoqJYXygw7vH57BllD6KPV4kb4x8fvEpf5gDT+wzXnbIlLHmQ0q0wzVgEDCL
 sTkYMUnZuNrmobxqKgRN+KrTUmzMmk6HfA0dMKonvuG0/hjX94h40Pmnctxfh0VxTdPW
 N1onMvS1V024XP5NuOKmSB0FkMmJIuSzWEDLVWKw7hgwPxXVvdwjPVPtlUoZO5MaaIoy
 /O7rzudjqI5n3+dIWb4ei9wgBK3Sgx76PzQuD+OKGFVXlZr969sPWaI87YiZEA5E0QTJ
 zmqjpDEXJsXWovR2fKLz/FMuGZEvOy7slSKEh9lpUCaNpw7r/1dO7hnYAVgl91SoCyxc
 ND6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=xX2tRJTI+oPA1urf0BIrcVPxBfzc8Z7IkhMGTh2h8oY=;
 b=hrfzYIsfKLXAdCz2wkx6lG3vMJSbLdqIX/xusuRirZG6sHOENpfnJsi4BxK8AYVjPJ
 OmwyhfVzzepPk0orPVa/e23XuITnUbxIQxg6T/NQYOip7+ekGp/qK2LYxmnJ+NiQixmZ
 3vAmtxDtRBPJHhiasT1tWo+BmUo4ySYn+3f98rXj61+2DhaSczUlTQA0F7sasaECCdjx
 4WhauzFdy2+kXiF8j4haXkBQHMio6D1mOGM7XyaoBKKADuqQ8QnotGWvJOXG1+aKYK0V
 TIN7qh6PxPHHI5q9rnpeyzcQEiZi6TiTseTy4sIEDyGVvF2K3LqDI0+8CbVBI3JnGwBU
 zJ6A==
X-Gm-Message-State: APjAAAV/4eacelQpJ3YtLHNC3/gLYoPano7zke3aF+E66BOsWQTwlnV2
 mI6FakIQ4w/VfiYBXHG6q9TsNUrb
X-Google-Smtp-Source: APXvYqzNk+hfybzP45nD1wMCqOSTJ1To9GBdYcn3zrzG3esqurbgyq7LUoIKPgbX6jEMq/pOQtk0rQ==
X-Received: by 2002:a7b:c957:: with SMTP id i23mr3671995wml.49.1578486784205; 
 Wed, 08 Jan 2020 04:33:04 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/38] hw/i386/pc: fix regression in parsing vga cmdline
 parameter
Date: Wed,  8 Jan 2020 13:32:24 +0100
Message-Id: <1578486775-52247-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Peter Wu <peter@lekensteyn.nl>, Sergio Lopez <slp@redhat.com>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Wu <peter@lekensteyn.nl>

When the 'vga=' parameter is succeeded by another parameter, QEMU 4.2.0
would refuse to start with a rather cryptic message:

    $ qemu-system-x86_64 -kernel /boot/vmlinuz-linux -append 'vga=792 quiet'
    qemu: can't parse 'vga' parameter: Invalid argument

It was not clear whether this applied to the '-vga std' parameter or the
'-append' one. Fix the parsing regression and clarify the error.

Fixes: 133ef074bd ("hw/i386/pc: replace use of strtol with qemu_strtoui in x86_load_linux()")
Cc: Sergio Lopez <slp@redhat.com>
Signed-off-by: Peter Wu <peter@lekensteyn.nl>
Message-Id: <20191221162124.1159291-1-peter@lekensteyn.nl>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/x86.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index d8bb5c2..9b9a4d5 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -612,6 +612,7 @@ void x86_load_linux(X86MachineState *x86ms,
     vmode = strstr(kernel_cmdline, "vga=");
     if (vmode) {
         unsigned int video_mode;
+        const char *end;
         int ret;
         /* skip "vga=" */
         vmode += 4;
@@ -622,10 +623,9 @@ void x86_load_linux(X86MachineState *x86ms,
         } else if (!strncmp(vmode, "ask", 3)) {
             video_mode = 0xfffd;
         } else {
-            ret = qemu_strtoui(vmode, NULL, 0, &video_mode);
-            if (ret != 0) {
-                fprintf(stderr, "qemu: can't parse 'vga' parameter: %s\n",
-                        strerror(-ret));
+            ret = qemu_strtoui(vmode, &end, 0, &video_mode);
+            if (ret != 0 || (*end && *end != ' ')) {
+                fprintf(stderr, "qemu: invalid 'vga=' kernel parameter.\n");
                 exit(1);
             }
         }
-- 
1.8.3.1



