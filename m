Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DEAC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB0F2071E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDmJ5hD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB0F2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZWlR-0005qC-KO
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 04:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iZWhA-0001xU-TH
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:59:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iZWh9-000357-TZ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:59:40 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:39942)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iZWh9-00034n-Mg
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:59:39 -0500
Received: by mail-wm1-x330.google.com with SMTP id y5so2302168wmi.5
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 00:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nvwgnhJ1IncIfrBZs8zzFkY601J2cmeUNpe2I65/og4=;
 b=UDmJ5hD7Mw3c/5cP76KU4Y4Q9DofP43OttL04RviUiu4CO/38uGTMHI3EZwrNEjcVT
 9kJjWytHtEmtOASB33CM12nHv6qXcYDoNqfbL7TMCkZlE7ghpbIAVMaLlUcbZmeNIa7w
 kXbdKtAnCbrTyfEW1NwQ0bSvL9Ku2UIQX6AiFhWIguGsXR5Si8W75xeUloWrufXRi/iU
 7Zflvbnqp3+ZNLL2Ggv5jIT8k9yoSAEcSjUsAQ3kYH82mdOL9qPF+1ZqbP1LBpGRuHTs
 Bne06epEH0Q61X5H2fnCgJohL8p3d/lEEymaJsKRGS4CnWOyL03QogGxEY80pBfpf9bG
 s/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nvwgnhJ1IncIfrBZs8zzFkY601J2cmeUNpe2I65/og4=;
 b=lMootm9Jg+oV8aHmo9ezFMkmiDOXSZwPfLo0qHeIBFuzWPSZGLRd2P4q7zWJJ/WHt8
 5q9MWhOx3EHBYeWur0QfQl3E0REt3kGMdkTxRenm8y5kta+T+QvDz5vtttAXSrnD7Za0
 qSwScltAVfYdizhqGK98VcNqvArSCAyEkAhjZdxVMryMPL+mFFg9vzOkRxecGm8fAbNu
 ZGit/J0SfiJCRBQVwCwZSngcXAORMejzs1vle4o4RsYt2/HvKRl0Oyuv5raNu57sttCX
 97cHcuhMdHmpeRml1o7u9kQJS0sP7At5c4Zhgv6iKy2FhOnTw9BFxnKZ8Bibf+U0VjbV
 hKNA==
X-Gm-Message-State: APjAAAXiUgoyWSSQ1ajdD6LFToCHhubvy1AcmYtgEcEyZy/KMfixArCn
 KzZznRqqvQxQTCUrxDcTCI1esDMC
X-Google-Smtp-Source: APXvYqyD89KK5m6343w/mmFiLShWrWaq7bPrzte06rbCcy11S9Dqz9IKuL+QGYXErxIFXOivZVeCMA==
X-Received: by 2002:a1c:998f:: with SMTP id b137mr3213514wme.104.1574758778276; 
 Tue, 26 Nov 2019 00:59:38 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:5454:a592:5a0a:75c])
 by smtp.gmail.com with ESMTPSA id a206sm2349172wmf.15.2019.11.26.00.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 00:59:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] target/i386: add two missing VMX features for Skylake and
 CascadeLake Server
Date: Tue, 26 Nov 2019 09:59:32 +0100
Message-Id: <20191126085936.1689-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191126085936.1689-1-pbonzini@redhat.com>
References: <20191126085936.1689-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

They are present in client (Core) Skylake but pasted wrong into the server
SKUs.

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 730fb28b67..69f518a21a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3006,7 +3006,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
              VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
              VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
              VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
-             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+             VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Skylake)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -3131,7 +3132,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
              VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
              VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
              VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
-             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+             VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Cascadelake)",
         .versions = (X86CPUVersionDefinition[]) {
-- 
2.21.0



