Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4568CC76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1340A21955
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKbsioal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1340A21955
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpb0C-0005uC-4Y
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 12:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33520)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hpazm-0004dv-4W
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hpazk-0006RA-VV
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:17:02 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:34649)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hpazk-0006PL-O6
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:17:00 -0400
Received: by mail-wm1-x331.google.com with SMTP id w9so29130390wmd.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 09:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AdVUU+R8Ux7jmIt6GoFxhTDhy7zQnJVp6dVmD0rp2YU=;
 b=fKbsioali0XnQrJd9t8tVedx3xe8rCU7kp0nWaH3Qe9PD8WK+ntsc2jOkYyb8N9N1N
 mj6Wmh4zor5b6bdLxDHut5YhTyxpaMXzaCholy4OFxvfCL8ehUhaqX3jzCNO3u42GWiM
 fHOnW1rGAwyROL1MOyejV5QlYFL1Vc46KBb3Nnhtncdy82YaH5Wsv3zjJO+VK4Mq74Gk
 W8PtVmz1Kp0viX6x6s5BlxnC797spfzqJStXEwHrHjWPRGW6iL5oL57HRlCHyJma8WCE
 wx36ztIunIi2JintIkyq55Bcg4iomldYnBQ1rIfbaJo67SbULo9D097oFXLc4QMcsJeK
 cmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=AdVUU+R8Ux7jmIt6GoFxhTDhy7zQnJVp6dVmD0rp2YU=;
 b=S0UbsE3WsubpYQ6NiT27scJ44rj6AI2Cx5yeRc4xkJFB3M5c/nVeFE11nctSXbERIa
 06MmiQBfqedRR1CYpSeDzp1sINLAxibca7fNG+ULYtebrP9bXjTGITGEIZn9dxEIAq8b
 IXispyNPColrPya9WpoipXXrK3T1pJkRMWLKfTZVLjcklZuuzT+VsO1f+a7FNA6HGNXf
 BVHxJ9OtFtYXA+ETTSHPHRTENQzAHPbfj35uh6frMzYwxbVBfkE38sZjA2fW+C003Of/
 eWTkzA2tSityRJdKgapGFl2ykTCqWavhEXjO/CeZiGkfqY+wXl9Ksf2d9t5kvHMf7+Lk
 HBXQ==
X-Gm-Message-State: APjAAAU9Erm8lwN+4cUnj0z7bZcctvDVCIImXDwE8iB3vWjGNrGyuSxV
 eU4ljmR6kxNMTF5/9kw+Ll3OzNPQBPs=
X-Google-Smtp-Source: APXvYqyTmqxZbsjocdoMcwCqim69VqmiT6iiRxoUS2pnEfsbBcdr6UEFX8kkbvRKLzR4Lx9CHd5+uA==
X-Received: by 2002:a7b:ce18:: with SMTP id m24mr62460427wmc.126.1563812219411; 
 Mon, 22 Jul 2019 09:16:59 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:10f7:67c8:abb4:8512])
 by smtp.gmail.com with ESMTPSA id o6sm77717501wra.27.2019.07.22.09.16.58
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 22 Jul 2019 09:16:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Jul 2019 18:16:57 +0200
Message-Id: <20190722161657.8188-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722161657.8188-1-pbonzini@redhat.com>
References: <20190722161657.8188-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
Subject: [Qemu-devel] [PULL 2/2] i386/kvm: Do not sync nested state during
 runtime
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Writing the nested state e.g. after a vmport access can invalidate
important parts of the kernel-internal state, and it is not needed as
well. So leave this out from KVM_PUT_RUNTIME_STATE.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Message-Id: <bdd53f40-4e60-f3ae-7ec6-162198214953@siemens.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index ada89d27cc..dbbb13772a 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3563,12 +3563,12 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
 
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
 
-    ret = kvm_put_nested_state(x86_cpu);
-    if (ret < 0) {
-        return ret;
-    }
-
     if (level >= KVM_PUT_RESET_STATE) {
+        ret = kvm_put_nested_state(x86_cpu);
+        if (ret < 0) {
+            return ret;
+        }
+
         ret = kvm_put_msr_feature_control(x86_cpu);
         if (ret < 0) {
             return ret;
-- 
2.21.0


