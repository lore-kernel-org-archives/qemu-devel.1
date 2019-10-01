Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F201ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1852190F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAzB//66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1852190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLw4-0004F9-95
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlN-0001il-NZ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlM-0005bT-79
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:37 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFLlM-0005b5-1t
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:36 -0400
Received: by mail-pg1-x544.google.com with SMTP id x10so10101325pgi.5
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cLTjP6H3sgR48Oz4OVwXv1gsVIS4CDtO8U+Cy7bE7UQ=;
 b=DAzB//66IIybNmiWG+r8vxmmqgUOmg4ljfxR1ZsuCFmhfuLtVaCTBYNcxhbJsj4Yfh
 66pe8+B2xjt+5PG8tPlRYpGaUp3wLw9M9uhDTMBEj/m6IDWiuUflaI+xBssW7IQ7U3/c
 JBjog5vI6+dg91XagDmh4qobvPIJIeQv2T1k8HuMp7EmVNy1L84lSnZ75aar/v2zAiCO
 HbEEhrDDFSbV9M0FOZCci2fhFny0+n1aflqGfzvrRM9NkQJRoNygnUpmwyYnjSd0Oukf
 VggHSpqgUutz0BPqPSbV93NU7t3lb+aO6UWYK4SImcqa7iLWKKoF3qPYw6nCwdRietA4
 FLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cLTjP6H3sgR48Oz4OVwXv1gsVIS4CDtO8U+Cy7bE7UQ=;
 b=tdrYEIEzeXmfZCLcE/+3He6xVJrW8ZYP9geFlBY1+0fh2pSNRORnFqHQhPIjKXzN8Q
 OxPJfhYQN8CP1JkuZGnFkJiGjLGtNV15v0IhTb5ktH4Gon2k0N9sQSaTWSGUmX1RX3Sz
 niQRh1dVJbBp1dhf1PG166lFFC+BTa/uasEb4jAdupvg+b7s6Z3Kl2UDj6H+2BCEFAQE
 aGbx4yV2wqFqxtCOyB+rfGQoMDyxkkr7Uk/uChSNovaNo3BLVzUo8b6/7waQA3Jx4h06
 MTmqukNNQMgGU/oR1zZ/l8gKt06q6N5+dDsnvu5HkPWw0f0NOFEWeB9voGrVN3iL3DeL
 i/Qg==
X-Gm-Message-State: APjAAAVzHfm2LllXbYKgfz0GDap+EVWPT28yC5WB57kwwGENM6YvOJA+
 9LbFKnnDB+IiylMrgFSCXymHAi0Sjvg=
X-Google-Smtp-Source: APXvYqy5wuG4piUjVXnpdy8Dwp14YJYhU2v159v8FkZXHxpSZOEutuy6XX8zwONtvY/ilOkR/Faqcg==
X-Received: by 2002:a17:90a:1b48:: with SMTP id
 q66mr6701030pjq.79.1569950194770; 
 Tue, 01 Oct 2019 10:16:34 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w7sm2863568pjn.1.2019.10.01.10.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 10:16:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 14/18] target/s390x: Rely on unwinding in
 s390_cpu_virt_mem_rw
Date: Tue,  1 Oct 2019 10:16:10 -0700
Message-Id: <20191001171614.8405-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001171614.8405-1-richard.henderson@linaro.org>
References: <20191001171614.8405-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
index 869debd30a..df58fb73ba 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -510,7 +510,7 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 
     ret = translate_pages(cpu, laddr, nr_pages, pages, is_write, &tec);
     if (ret) {
-        trigger_access_exception(&cpu->env, ret, ILEN_AUTO, tec);
+        trigger_access_exception(&cpu->env, ret, ILEN_UNWIND, tec);
     } else if (hostbuf != NULL) {
         /* Copy data by stepping through the area page by page */
         for (i = 0; i < nr_pages; i++) {
-- 
2.17.1


