Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69455C31E44
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 00:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2B620866
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 00:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQTNWfv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2B620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57858 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbwvb-0006XL-Hb
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 20:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60496)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hbwmh-0000Wk-L2
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hbwmf-0004IS-QX
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:43:07 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36723)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hbwmf-0004Ef-Jg
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:43:05 -0400
Received: by mail-wr1-x442.google.com with SMTP id n4so4239106wrs.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 17:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VSAtqp8UmPIPF0lSVxm2zpXVeEB/VlNEVkegW+jAWto=;
 b=mQTNWfv0MEeJAID9VISf9tlh2krgWNY10ceVQev+Hm/iZO4lQpqgIOchNWLdpmugFr
 qWZvzWhubVIBEG0W855fIxBosd2AxQIBlkBfQjwfdKFNnJZ/g4PY0VfpUu1VsjDw6/wS
 H5Vpo702rKHbk4T0I5LmY1ADdyLpFXiDNkIrlj8OCPDcZmQs9HQMUvzsupDls080bmFa
 Rh55XjONxktyYFNGQqvFkGGAxqjoFJ1Ys3nAKuYo5xzOwwuUeDUiNOqc+TtVcWJEwX2O
 X+YyqyJXZ123m1XRdBw6uHSvqUuYR8W+GosfcA/ZXqWJTKNAUBN9vtygBHWWs2ygIAaO
 jzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=VSAtqp8UmPIPF0lSVxm2zpXVeEB/VlNEVkegW+jAWto=;
 b=VY/mIwyOnCUNCLlZ670fXu8u9xCY0SBE9vlXw846+rxc1tMrpIqkfiXQu2QiMSy9tt
 JKW6oLaiO5JdY6J9KRt1j5OhCGPjC1qNH8sLEixiwjLAxN4fFDTCGt+zR5Jy1ciqd9BE
 cjL2qFzWeBuI/TvbbDcwXfGnm+ebGZnnz4VDlNs4Cpl3KnX2ivEdx3tuFbTRcE5usWB7
 w5oFw+GTAFFjiJ+Qj7YX1qEIf9ee39KApUHnKwlPnrY/ImG7gCRlHpPi/vc9nlluhcmM
 iDnrLMv1JVCWtXMkt8o5FFOyn9GWZBdvVd0Tz0Zl8CzGqVFyF9ZkywH0mWcKOam5RjLL
 fkVA==
X-Gm-Message-State: APjAAAUFLRmL7s+NHxX/KTB7GKIhu0pD+0qJ38FzFtGBe3Hr6WKAipbu
 1ygAfisozBYX6STXH/pE5eQHrxfe
X-Google-Smtp-Source: APXvYqzNc2/szIx/XDP5SmVIdxaeA2yT35FduiOPnQCZXnk7NIIKdTeFgaxstApzGiIP7a6wg9YGeg==
X-Received: by 2002:adf:9dcc:: with SMTP id q12mr16787543wre.93.1560559383028; 
 Fri, 14 Jun 2019 17:43:03 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:1da0:213e:1763:a1a8])
 by smtp.gmail.com with ESMTPSA id m21sm3774234wmc.1.2019.06.14.17.43.01
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 17:43:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 15 Jun 2019 02:42:56 +0200
Message-Id: <20190615004256.16367-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190615004256.16367-1-pbonzini@redhat.com>
References: <20190615004256.16367-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 7/7] Revert "target/i386: kvm: add VMX
 migration blocker"
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
Cc: liran.alon@oracle.com, nikita.leshchenko@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

This reverts commit d98f26073bebddcd3da0ba1b86c3a34e840c0fb8.
The commit should be reverted because we now support nVMX migration.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index d48fafa22b..0a01f40e73 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -943,7 +943,6 @@ static int hyperv_init_vcpu(X86CPU *cpu)
 }
 
 static Error *invtsc_mig_blocker;
-static Error *vmx_mig_blocker;
 
 #define KVM_MAX_CPUID_ENTRIES  100
 
@@ -1308,17 +1307,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
                                   !!(c->ecx & CPUID_EXT_SMX);
     }
 
-    if ((env->features[FEAT_1_ECX] & CPUID_EXT_VMX) && !vmx_mig_blocker) {
-        error_setg(&vmx_mig_blocker,
-                   "Nested VMX virtualization does not support live migration yet");
-        r = migrate_add_blocker(vmx_mig_blocker, &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-            error_free(vmx_mig_blocker);
-            return r;
-        }
-    }
-
     if (env->mcg_cap & MCG_LMCE_P) {
         has_msr_mcg_ext_ctl = has_msr_feature_control = true;
     }
-- 
2.21.0


