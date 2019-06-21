Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF9BC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:44:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C6982083B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETuZ9czV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6982083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59938 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heHxd-0003kL-Hl
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 07:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49136)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHkh-0000mt-JV
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHke-0005uU-G4
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:43 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1heHkc-0005iZ-Dc
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:40 -0400
Received: by mail-wm1-x344.google.com with SMTP id u8so6233411wmm.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 04:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=99rkvJmjgZNHPGZCddK8znZ7niUUbuJAuf+Rk2/QtO8=;
 b=ETuZ9czVUM9QoW0n8GyxMVbnsF/IT9BI9bDUX+Y+4eiUFZk/rdLfxAKTjTDXw+yG2M
 hOmjifn2vdgXN4fMHoz6EnGuffvirhz+sUO3UWbYqDEPBFFKfEsEOjSVglIAaXB/NRba
 x+J1ASqGsydLoLPyB7zOfaa4qSMKZvl4g3dpw5bGLW7sGDuFYNh2/8A3zZRpefzwD3rC
 NwNeijdiAJ5ifOcwIFSfaL3v0bwzSv20/ZfjjIdsagzjqqoGT4urJ2pGDLunQF79Ll8j
 lvvE+N9h9EmOH2anawha2IATNUFqVe9+/MwuzqIxjOlYfQrD3H/Bo/4ABTIUBNa3dnb0
 3q/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=99rkvJmjgZNHPGZCddK8znZ7niUUbuJAuf+Rk2/QtO8=;
 b=EQdiD+NBQrdxdSiWm2qixkxin0Is7XTvaM1YVR8VvMTc5qt+q6bW59wwFEZLojSlb6
 9agDpTxYB30noVMwzH733BcPx/kLDUi2qn1U0O1sgS8DyfNW2SBTtHts7NNLXkT7j+4n
 I0Ujyhta+dqoXBs6e3CrMFOTy3DWHx7ei/7RISOEXj69NZHHceGA4XXd9fkI+BtxY/xf
 WjJctuKu5n5VCXpd8esNvEhK1TD6dULycnMuky/JVj67xZJrZKTZN2ADclhnzivlHpT9
 r7sDZL/CSl1IGlXujt1o1mRxH2skyEeHTV92hY0hqs+SThvZ2qtPNv0jxx4pmSJjWFQ5
 BDfw==
X-Gm-Message-State: APjAAAUA+y6p+Q9EuUGMiFWD/t//XPXEVGkYAeqI+h/oxQY21O48ZKP3
 P9Osy9JH9jPn4GSkzU9opB1UYor5
X-Google-Smtp-Source: APXvYqwZCG8ueP1BpgML4Ecnqhh4gjqkh2ZDmrittIJg7lJY2n5dvFGaMrNLmZWr6ESZ5yxW/LTHDw==
X-Received: by 2002:a1c:238e:: with SMTP id j136mr3594829wmj.4.1561116635418; 
 Fri, 21 Jun 2019 04:30:35 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id r3sm2712851wrr.61.2019.06.21.04.30.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 04:30:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 13:30:08 +0200
Message-Id: <1561116620-22245-14-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PULL 13/25] target/i386: kvm: Delete VMX migration
 blocker on vCPU init failure
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
Cc: Liran Alon <liran.alon@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

Commit d98f26073beb ("target/i386: kvm: add VMX migration blocker")
added migration blocker for vCPU exposed with Intel VMX because QEMU
doesn't yet contain code to support migration of nested virtualization
workloads.

However, that commit missed adding deletion of the migration blocker in
case init of vCPU failed. Similar to invtsc_mig_blocker. This commit fix
that issue.

Fixes: d98f26073beb ("target/i386: kvm: add VMX migration blocker")
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Maran Wilson <maran.wilson@oracle.com>
Message-Id: <20190619162140.133674-2-liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 279f99a..c5cbead 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1333,7 +1333,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     r = kvm_arch_set_tsc_khz(cs);
     if (r < 0) {
-        goto fail;
+        return r;
     }
 
     /* vcpu's TSC frequency is either specified by user, or following
@@ -1622,7 +1622,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
             if (local_err) {
                 error_report_err(local_err);
                 error_free(invtsc_mig_blocker);
-                return r;
+                goto fail2;
             }
         }
     }
@@ -1673,6 +1673,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
  fail:
     migrate_del_blocker(invtsc_mig_blocker);
+ fail2:
+    migrate_del_blocker(vmx_mig_blocker);
+
     return r;
 }
 
-- 
1.8.3.1



