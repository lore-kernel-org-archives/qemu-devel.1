Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331B2C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F7820863
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bBpNxCm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F7820863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDwC9-0001Au-BG
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 15:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5v-0003TM-2G
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5s-0006a2-Fu
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:58 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDw5r-0006Yu-QT
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:56 -0400
Received: by mail-pf1-x444.google.com with SMTP id v4so2135049pff.6
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 12:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vmomdltG4SHs0hB1D0S9fmCLBesupAAj+oL64yYCJ5w=;
 b=bBpNxCm3tlmRASePBTIFSk9X2pDzqK5qGbUCpg9yJpMWgpWwc+KL+WAn4BKmm1oWIU
 niao6NK7nItkHpwzJg6W6R/fWpGXRAa9C+3Adha/gvyifryNMyS6TSfD/2wmCMkrGaR+
 wJP8dGf6+B+D89ODr9cj4qeYjrU+/PyZ5DR85Mk88a27zi8heKcggY5+ULFt860dn7AE
 74ZgWogpkmUNUzId2e1ngZGLlzyK3vsjygyPX13AGXwA+dL5PUt8KqYS5YOx5L6revH1
 77bQri6xhw9xrEOADdTwD983Jek72dgPiMKRUrumMd45uc/iSdyVktvpIHVzIvutzDsh
 EOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vmomdltG4SHs0hB1D0S9fmCLBesupAAj+oL64yYCJ5w=;
 b=Afwlbs+/U162rzb+7VD/NxZkdAnZGIAjoWspJwsJDpEgDR1EVWhmMh7195yNjvVxlR
 3sk2YfugsiFuZmuXCOrYC6/wai6XSdUKYSEF3TacUx7DXrJdlCaR7D6NrDzYEb8hDVcg
 Zs/gVHnUnXtRv3txrx8pAEvrvY1hmLNSrG6r/IDFpbj9MbiC1/fjPCIQN0/ixQxyd3sU
 uKsCVq0/tqE64FrE49gS5hkHm8A+SZtMLlJPBctu06uSYYW/R3lh7vrAhZ6GalOA6PUq
 312zsIdhpUbroA8qyWWMxBDf+MFGAHPiKjAp43YAgOydd5IoUh8tMdG9B6OmzJzlo9S1
 deBQ==
X-Gm-Message-State: APjAAAUuc0BFVHYjUQitiEzbRqgN2ICHnRYRTuM531DHEkMwvPRK1/20
 BqDoqPfg6V9SDYNiYQAWT+4x2Kzyif0=
X-Google-Smtp-Source: APXvYqx9Rw+7JUDAtL7Tig8qyuMGQH8dwN9BiY5YeV1SdPzTd9q5Viv015iCDazN4I4cNxvJLT6KVw==
X-Received: by 2002:a17:90a:9d87:: with SMTP id
 k7mr12106460pjp.103.1569613194228; 
 Fri, 27 Sep 2019 12:39:54 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
 by smtp.gmail.com with ESMTPSA id 192sm3676403pfb.110.2019.09.27.12.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 12:39:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 14/18] target/s390x: Rely on unwinding in
 s390_cpu_virt_mem_rw
Date: Fri, 27 Sep 2019 12:39:21 -0700
Message-Id: <20190927193925.23567-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927193925.23567-1-richard.henderson@linaro.org>
References: <20190927193925.23567-1-richard.henderson@linaro.org>
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
Cc: qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For TCG, we will always call s390_cpu_virt_mem_handle_exc,
which will go through the unwinder to set ILEN.  For KVM,
we do not go through do_program_interrupt, so this argument
is unused.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/mmu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 98ac58574c..437e211366 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -511,7 +511,7 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 
     ret = translate_pages(cpu, laddr, nr_pages, pages, is_write, &tec);
     if (ret) {
-        trigger_access_exception(&cpu->env, ret, ILEN_AUTO, tec);
+        trigger_access_exception(&cpu->env, ret, ILEN_UNWIND, tec);
     } else if (hostbuf != NULL) {
         /* Copy data by stepping through the area page by page */
         for (i = 0; i < nr_pages; i++) {
-- 
2.17.1


