Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE21C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 08:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA16C2073B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 08:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxvE9MO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA16C2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icQUo-0002dg-3S
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 03:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <catherine.hecx@gmail.com>) id 1icQOg-0000zX-A6
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:52:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <catherine.hecx@gmail.com>) id 1icQOb-000490-9a
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:52:30 -0500
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:42431)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
 id 1icQOb-0003cC-2P
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:52:29 -0500
Received: by mail-qt1-x842.google.com with SMTP id j5so6932601qtq.9
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 00:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=EOhS8JDsg867aMPTPPeteOvbmqqjsw5vk6vXxMRaXi4=;
 b=pxvE9MO5f9p/yUNdCgDLZQPjNTm3GpliVlCjX11Hc+NODaKH6B35Fyscwpgn+cqcL7
 zgpfCuNw51xheY4xzL8Y/cgbvP6WlKdZaPbxpSYadkpH0eOPZyVMUet8SINxpFRAT5C5
 8j1P+Zuhjznd1SmYvp+uwrQ1JYs6dhjkzGCBzq9SbfWoGrSeZbbJrHDRuqLjtbZMrLtJ
 qkg6dWhdASyMNvhH2pr3ApZYbmEXt5U2Zn/8K3L2ljh7h/hrcc0+R+vHa0C7+5xaH6LU
 AM5skbDP2Holn90xSPgdwTNonumP/m7RHu92H28cMcYVjPihj0ltD2J+iW6sO6ZjRqWP
 MQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=EOhS8JDsg867aMPTPPeteOvbmqqjsw5vk6vXxMRaXi4=;
 b=ERO8PryI2Z4WCXQ194pbs7viyd1/9c5UQrTIrFgmIbymA4uoTjgLmLLmGTrFFyB7B+
 JSUU3uJomCubOqQdPXSWdLqQ60Db/tda1hGg1tCylJVu6ZTH4Z1MMYt51tH37t7s2Uo4
 tcKjOsv6pEmdANQhYlH0PTLXRKeOR1Cz3bNg3qd1C5A0yP1OlVcuCfhMYGEUrrN3mncZ
 Eqc/wh8uKYZOaugBiTJ+KTPhKkOmKlEGADCfkNdU7Hd7b/DTBxEhbkJLVPYzpgxPLKqy
 7KK6lnutDIRDxq4X5w0jVEOTD5NFxxfDFWYumu1TEShTkLihRvwdkX6V53zO/hrYvWOR
 omoA==
X-Gm-Message-State: APjAAAXHqw7OnPEEZgTQQlidGujjH1eh9QQCTst+YmY6aUOUOkR7Tco1
 o0WmN3LbKu3kYYeol47Okj4=
X-Google-Smtp-Source: APXvYqzTEn4f5QtgZACc5msyimnIHXttn0a0OY37DJuQ0hHUQX9gHuGApLqlXXYZrGFZEr/p65/7TQ==
X-Received: by 2002:ac8:23a5:: with SMTP id q34mr1570560qtq.83.1575449539835; 
 Wed, 04 Dec 2019 00:52:19 -0800 (PST)
Received: from host.localdomain (104.129.187.94.16clouds.com. [104.129.187.94])
 by smtp.gmail.com with ESMTPSA id q187sm3351795qkd.92.2019.12.04.00.52.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 04 Dec 2019 00:52:19 -0800 (PST)
From: Catherine Ho <catherine.hecx@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH] target/i386: relax assert when old host kernels don't include
 msrs
Date: Wed,  4 Dec 2019 03:50:30 -0500
Message-Id: <1575449430-23366-1-git-send-email-catherine.hecx@gmail.com>
X-Mailer: git-send-email 1.7.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Catherine Ho <catherine.hecx@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 20a78b02d315 ("target/i386: add VMX features") unconditionally
add vmx msr entry although older host kernels don't include them.

But old host kernel + newest qemu will cause a qemu crash as follows:
qemu-system-x86_64: error: failed to set MSR 0x480 to 0x0
target/i386/kvm.c:2932: kvm_put_msrs: Assertion `ret ==
cpu->kvm_msr_buf->nmsrs' failed.

This fixes it by relaxing the condition.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
---
 target/i386/kvm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index bf16556..a8c44bf 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2936,7 +2936,7 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
                      (uint32_t)e->index, (uint64_t)e->data);
     }
 
-    assert(ret == cpu->kvm_msr_buf->nmsrs);
+    assert(ret <= cpu->kvm_msr_buf->nmsrs);
     return 0;
 }
 
-- 
1.7.1


