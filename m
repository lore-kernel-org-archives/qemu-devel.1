Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F1CECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9460F2190F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Npxz1//4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9460F2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLuR-0002Hq-J9
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlF-0001ZV-4q
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlE-0005WX-2B
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:29 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFLlD-0005W8-TD
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:28 -0400
Received: by mail-pf1-x444.google.com with SMTP id y5so8478500pfo.4
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sktqWg5A8zjUbfven4iBrOAszFjwQxlijBBfeL/atZo=;
 b=Npxz1//4lid0KwxCCmNDovvDWsv2rSMBCNlhQbg3zchGPzVsf/K+7RABN/NmOYBt49
 NdRgXveZUNznRXU1p9a66p1jVcO2ouhBhpXkAdMbmfk0EmPaHH/RPaHaOu+yg06KSPxj
 ZgfCc0Y+BdVSexmM/52q0trA1CKLL4qTOdQJH8Jp6qsNRNCFTj6RB9YLDN1NZIJosioQ
 vu4k8f+FY4nM+IbAEEm3dVZWuCurVfeAT9u7HLo7uGknFjkzHFbwZ05g2GVTcMm47efD
 rduyHbE/NLdYXaX6zFmKGW4BcwDFT6ffnlx1y/BS7ObY/O8NoOSmKuZSBsxKwJtCzkhW
 Uw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sktqWg5A8zjUbfven4iBrOAszFjwQxlijBBfeL/atZo=;
 b=CltCJtrwJnkEfFTairs+4uEteyAtEDjXB9A1Z+ewKmcSG8iiwof//hNaF7l/SOFIMf
 hpCvvpNCQgPM9doJ7Kklay0VY4FXJloB9x1FNw1fM/VgOoacDXGms3XB6ZRbxZpdFkqV
 YSfWLTNQS7gfV3E5A3rsvC5fZx7VSRiGrfVAXvpXDlcrdrBuuwD1tnauu9bWrJd/jPyJ
 DoQzAW9+rYfc5vAAh9jUdPg2n0jyW/Ts+yldMH3qLGy8+Denk/alJTDrdbnDDElKfQ5S
 ovNVM21H+qvPv/QTm185Yp5DxoSBxtdDyOGAmkv9a0YcSAEninuuK1cP+MgGzqJ7ySnL
 Aq3A==
X-Gm-Message-State: APjAAAW+DLoW8ofsnDwrpfQcyar0SGA+70xWNziL7oDUjb/VrKhQNyxt
 bDiyijEUDicSTUFobsFh8tz0tsTNmx8=
X-Google-Smtp-Source: APXvYqwoMvz5En7llVRZMtk9DJKJTrPW9/VGmzwep+DVcApjNUBMFVonuOucTIdxyTSrRITM5RcKXQ==
X-Received: by 2002:a62:7a88:: with SMTP id
 v130mr29654194pfc.184.1569950186503; 
 Tue, 01 Oct 2019 10:16:26 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w7sm2863568pjn.1.2019.10.01.10.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 10:16:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 08/18] target/s390x: Remove exc argument to
 mmu_translate_asce
Date: Tue,  1 Oct 2019 10:16:04 -0700
Message-Id: <20191001171614.8405-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001171614.8405-1-richard.henderson@linaro.org>
References: <20191001171614.8405-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that mmu_translate_asce returns the exception instead of
raising it, the argument is unused.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/mmu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index e8281d4413..e57d762f45 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -116,7 +116,7 @@ static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
 
 static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
                               uint64_t asc, uint64_t asce, target_ulong *raddr,
-                              int *flags, int rw, bool exc)
+                              int *flags, int rw)
 {
     const bool edat1 = (env->cregs[0] & CR0_EDAT) &&
                        s390_has_feat(S390_FEAT_EDAT);
@@ -423,7 +423,7 @@ int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
     }
 
     /* perform the DAT translation */
-    r = mmu_translate_asce(env, vaddr, asc, asce, raddr, flags, rw, exc);
+    r = mmu_translate_asce(env, vaddr, asc, asce, raddr, flags, rw);
     if (unlikely(r)) {
         if (exc) {
             trigger_access_exception(env, r, ilen, tec);
-- 
2.17.1


