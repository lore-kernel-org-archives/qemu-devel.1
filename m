Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF1BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 08:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E65E207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 08:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEvsr0TY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E65E207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbgnP-0003BS-RM
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 04:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1jbgmh-0002eR-O7; Thu, 21 May 2020 04:42:35 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1jbgmg-0000C2-AX; Thu, 21 May 2020 04:42:35 -0400
Received: by mail-wm1-x343.google.com with SMTP id n18so5530288wmj.5;
 Thu, 21 May 2020 01:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QQeyNMYyr6h5PfngvnfF/86Fl3mYVL82wgSLqkkAHQg=;
 b=eEvsr0TYeas0gkH7cs4SLzulzE/hE25fjLhZ3vlqQNRpavLhHzN3PmKPITKmlWDE42
 D8VJdiJkpMsuGDoXA3pa3BtnPHKtJFDT0mezGHMmdc2Q8H5LGNG1DRS4llbdDFuYzARl
 begsAP7HPb5prFzzVIyniedYoPYgSDa2yBapWAJG6K1tHXwbAyTnKZksUyOgudo1ntJH
 sA+fha3pXU86vddpdGer20DF+CkDaaP1bCiRdhWkvFVoTBlDSm762BOeHOa4DNUFQUeu
 lHhFmwHr+ECZ0OXzIYVONK6iR7ZXjwLHTKLYZ7Rh8BrgiBgSGtMNDebuc9vgi9TVZJzh
 PdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=QQeyNMYyr6h5PfngvnfF/86Fl3mYVL82wgSLqkkAHQg=;
 b=hyQBTT41VMkznhi3Pq7Jq8JQNGde7TpB7rDtaNIe3lw/JB2LKGFfNtkgpQUn7QatMP
 g14vg+gRxLxpu+gOE57vSFaiLxMyeMViV52g72jSoU/hImEtEtnqo9lD3exerktTYcJU
 v3eF7AK9vvt4rGoyNfgI704XnFN7zCKITDhBfKH9HK9DsoZza/qX51n7DdmvRgVKDL5+
 8UKmL3Z3GSMRAGeFRwuLD+HudHIJrXqfE+SaqWynAFWTUf1z1jRt2iKtMvC6dZ2UVY7I
 h1sdf9nCRqBLdqXnsE2gJiFqi7U5+z7B8HOyOGhAULL0KeFYoqZlLG7LIrgx2DWUsnvD
 VdiA==
X-Gm-Message-State: AOAM532sJp9G/cv8kkQrrjwCTQ2y9ZR3xI4ZJZRHXpOQ5J9f18jiPHV6
 /avdmVjN+Ko49AA7oKjb5Kd+pbbs
X-Google-Smtp-Source: ABdhPJxiU7svautQk2/DqO/wP74cYWHQVLPY32vIvIkil7RT/dnJruvfdHHoyROxI/1bOXkIgc/Xqg==
X-Received: by 2002:a7b:cbc5:: with SMTP id n5mr8152828wmi.110.1590050551464; 
 Thu, 21 May 2020 01:42:31 -0700 (PDT)
Received: from donizetti.redhat.com ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id t14sm5153398wrb.56.2020.05.21.01.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 01:42:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target-i386: do not force-expose WAITPKG if -overcommit
 cpu-pm=on
Date: Thu, 21 May 2020 10:42:29 +0200
Message-Id: <20200521084229.13235-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: ehabkost@redhat.com, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By force-enabling the WAITPKG bit whenever -overcommit cpu-pm=on is used,
commit 67192a298f ("x86/cpu: Add support for UMONITOR/UMWAIT/TPAUSE",
2019-10-23) broke that option is the host processor does not have
WAITPKG or the host kernel is too old.  This is because TPAUSE, UMWAIT
and UMONITOR are not NOPs on older processors (though perhaps they should
have been!).

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6513584948..6554fdef3c 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -408,9 +408,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
             ret &= ~(CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_HLE);
         }
     } else if (function == 7 && index == 0 && reg == R_ECX) {
-        if (enable_cpu_pm) {
-            ret |= CPUID_7_0_ECX_WAITPKG;
-        } else {
+        if (!enable_cpu_pm) {
             ret &= ~CPUID_7_0_ECX_WAITPKG;
         }
     } else if (function == 7 && index == 0 && reg == R_EDX) {
-- 
2.25.4


