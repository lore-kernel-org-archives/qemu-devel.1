Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAD3C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F14206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEUoe9th"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F14206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAXn-0005LU-6y
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWD-0003ZL-0d
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWB-0004Bq-Sc
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:00 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:42673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWB-0004BL-MO
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:32:59 -0500
Received: by mail-wr1-x435.google.com with SMTP id q6so3157187wro.9
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mcf3x4qvRFnXt/JzGXBT9qpotUnB0PCEc7IeTyjDok0=;
 b=aEUoe9thOY5O2uX16d5s+KzacDxsYT+CNZ0m+WcpRWnivnNzLRZJqLdUHh3yYtUwsb
 CMnRNnXLzO9Z5eIWjc+8ya3bx4H220ojhYFzclARXoJjed4k0tO/fgjuV6HeLslZogk8
 N/3gNmU+RI67+o6897l0O7igQmhxXffJtqPK2aX6kuVJyd6XFDSNQul48A66G/jJsnHY
 zYEbSjLpO/1y6CKhnTvWyDXGe5lS12olknml7Kv8Yymin+sHgwcgHrUeVOUoD3X19vSy
 ERcT9Pyx8i9x+VgJnarC6By9IUBUYLXKsKD8r/bVJc0BeykAL9BnH8fCjeGU76Z+FPza
 LLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mcf3x4qvRFnXt/JzGXBT9qpotUnB0PCEc7IeTyjDok0=;
 b=io/vTQvOM11uTi00oT/lkf1RMFmw3HrE862xJHBPVzNre68vNXiU4hN2X1j6352SJk
 eSO//sJuYO9JAI3pnTAk7MonMERjFen6dka+gdX///i4DXC1tCeMpWiyrYr/KWBUaT+0
 /GDzDgyEa93fJigIsTXMlXssEUb1BIy5eupk1c7PsceCV3FIGqeTGFUkLd2PLtX2fup0
 YNclsVAM4dMQKOQku2m8DEXLMQVPin6j5G4tO+7+a1r5oAwKpnuUufRqKxf8TBRwVNOr
 sHeG2X9nuYQe/dCauXTJOidJbg76KnkM64Ddm5pUKeAc+O7SMyc2IjvDb+ZTNbWrSWND
 TaXg==
X-Gm-Message-State: APjAAAXjTWlup3eXihuoUgzG+S9WrhX1tCns0N4UkMHmsrpv0IYgf5JS
 axCPJjbhN9o89p8Hh4sZXdVCAVEk
X-Google-Smtp-Source: APXvYqy1hoF20pauo+Nf7KebetkMxrjdW2A/aPGTwV5+EnUe+ntXMesJbmGThB16t/ojxPlwrsrMcw==
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr4521273wrx.288.1578486778116; 
 Wed, 08 Jan 2020 04:32:58 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.32.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:32:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/38] x86: Check for machine state object class before
 typecasting it
Date: Wed,  8 Jan 2020 13:32:18 +0100
Message-Id: <1578486775-52247-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: Michal Privoznik <mprivozn@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michal Privoznik <mprivozn@redhat.com>

In ed9e923c3c ("x86: move SMM property to X86MachineState", 2019-12-17)
In v4.2.0-246-ged9e923c3c the SMM property was moved from PC
machine class to x86 machine class. Makes sense, but the change
was too aggressive: in target/i386/kvm.c:kvm_arch_init() it
altered check which sets SMRAM if given machine has SMM enabled.
The line that detects whether given machine object is class of
PC_MACHINE was removed from the check. This makes qemu try to
enable SMRAM for all machine types, which is not what we want.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Fixes: ed9e923c3c ("x86: move SMM property to X86MachineState", 2019-12-17)
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <7cc91bab3191bfd7e071bdd3fdf7fe2a2991deb0.1577692822.git.mprivozn@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 0b51190..7ee3202 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2173,6 +2173,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
+        object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE) &&
         x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
         smram_machine_done.notify = register_smram_listener;
         qemu_add_machine_init_done_notifier(&smram_machine_done);
-- 
1.8.3.1



