Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8001CC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D5D20675
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWM/s6IY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D5D20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54182 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he957-00048W-Gx
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 22:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41176)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8a4-0006cX-TZ
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8a2-0006dC-QS
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:08 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42213)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1he8a2-0006KR-BQ
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:06 -0400
Received: by mail-wr1-x443.google.com with SMTP id x17so4853465wrl.9
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 18:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=99rkvJmjgZNHPGZCddK8znZ7niUUbuJAuf+Rk2/QtO8=;
 b=HWM/s6IYXwS6XEvPQDKrLi1HGg+7Mq5vgCn4hR2rUYD3nWyz/7RlC59KZL/4axq68i
 iGr5DRrsZ2KKV93DxozwbO7TSs331PGG9tj9h5vqTnHOgwreS63FRXrJ0F7QWNn97Cm1
 O1rIv52VYd6SsTWyKXWwdsfWQPXYGOIjHYTK3dPvr8EGEP3GZICvOksWp5CaorWdRkz1
 gsUpuI0AyJaYg9g//CKv08Rmd1+9vWfZStH5+6CCHYDFO/OxzjYcQaDx7Y/A4XaepV+0
 BSs/ZYzXaghzq7KuCd3qoLSQjdzg0dq4vxpOHGmoKSJnh3or+65j3ZFpIBj0Y8GOz0Nx
 A0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=99rkvJmjgZNHPGZCddK8znZ7niUUbuJAuf+Rk2/QtO8=;
 b=jbG+Sf2EaMT48UVrkXqTzThl3oMefFpsf5t7eRmSdM8EezZcdXNqUgykOqfMUqTihu
 E3kLT4tzjTKJ9H7iFim/6bWt13g6G6zq5ZdsZ2u/UPXBCuvUnvx6U1mhoWiroR3PRNY4
 zzikvbNbE2fYZqY1STFlkKYxVqJc890ADVMx221XhPf9eG2SH00Afdx0/6Lm+OfqUIGN
 LeH1Ls6HqI8HagllV4x22ZKalxgAtBr13Y9QDLwKInEBti9XfsH296P2NpF5GWaJURCi
 xoqm/zmUgd9iq69Torj1z3NQsgD8tK45VLny5SIa4Lz+6aJWLsf0zqn7nor+7BQrMANH
 9Aug==
X-Gm-Message-State: APjAAAXhOKO69oVwlHGgxGMfMMvjTQRmHLCV0XBQoxlGRhDzYgzQU8fN
 K4aCpgxMO4Bjwe+nQGqymEvRR7qr
X-Google-Smtp-Source: APXvYqx1yJHEuwsu8m40oI7uyW0MZeHNFrvhWbJUS0wfYjyuIHeQ82WtAcLBIdZXQxQP8+7XCm4jeg==
X-Received: by 2002:a5d:4d84:: with SMTP id b4mr12694936wru.242.1561081366085; 
 Thu, 20 Jun 2019 18:42:46 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d1sm1123125wru.41.2019.06.20.18.42.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 18:42:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 03:42:18 +0200
Message-Id: <1561081350-3723-14-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
References: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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



