Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A874CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66BB22072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FTMsvZlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66BB22072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbot2-0007XL-IV
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJJ-0004eF-5b
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:45 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:34595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJI-0006pe-AF
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:44 -0400
Received: by mail-qt1-x844.google.com with SMTP id a23so6026633qto.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JFBVbjLhWvz//NfxtqcWhFsd9jqQkkiik7lq07yLP/0=;
 b=FTMsvZlOso8oYjZX/jmcx9fwfOIyj7GdWbF+mpCOnbWKcNISDe51SA/G+Sd61s5Rnh
 TvQ1rDtZsDu2dJIOjrM/lO9l4o+pyLWX/yLm7e1A2iJveDcBi0lbflWV+NMLLjRrQ0kh
 S1nB2vn0P/goDYLLn7jSp7Uq0ZpwaT1YY9KJSSzVEedjixm8hmGmZ5xn1rYxYi34/pgM
 UOQn0kWKPsi5+cyszesRgHLvrwMjMhoMhbHKP0agP4Os1Rdy91OvXo5F8H61n48dFV0U
 YrQxXG0QdhR6ZCCC3eVRMZb7pIlVRlLs3ypdfrP4jvUPInluw3hu6DkZ/9ZxDGxkz3+v
 gBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JFBVbjLhWvz//NfxtqcWhFsd9jqQkkiik7lq07yLP/0=;
 b=kteZZKuNSMWkYt9QF6DBocro41dG6mOTIsfbuLXj2p5E+mYT+t9V+KMBA5RKOfJnLZ
 0ffLjz4oah5pFpksoQUKAvnvrPZVJEfegL19ZPKnWbjGJl+CZtgqBObdODKn/eVuzgDb
 ZYmV0HDD6iXgVXtAysp2/He+dDwP8GdtTFF+5E9fX2ExF6tK8ZXJRLLcVM6d67isJca7
 W3DpS3uCy6DCf76a/YiecjWPL4m4wGY0cmVqWqcFJCETPwZ2i4bhshmguObT/2OLwRzQ
 JKOET8s9usREeVIbbqRYu9wDQXDa6k2s1EuzKig7LyPSTef5tC3Gp0VkE8TtcCccuVhh
 I+0w==
X-Gm-Message-State: AOAM531fWwDNz2alCxo9tl3uklzCxCV/uJF2j2GMC8fZJCFNJJJLfWBJ
 VoaSOlGfBUD+OU6Pr9ryRDYzaIvYpvPRDg==
X-Google-Smtp-Source: ABdhPJxNSiyYPNp4rWI7ciQinjtzUAF7aqML7mIt6wtirdZz2ZEii8kXa14B2f2xea9LFo9NkjIFZQ==
X-Received: by 2002:ac8:3f5d:: with SMTP id w29mr11407970qtk.192.1590079483088; 
 Thu, 21 May 2020 09:44:43 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:42 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 66/74] s390x: convert to cpu_has_work_with_iothread_lock
Date: Thu, 21 May 2020 12:40:03 -0400
Message-Id: <20200521164011.638-67-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x844.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: robert.foley@linaro.org, David Hildenbrand <david@redhat.com>,
 richard.henderson@linaro.org, qemu-s390x@nongnu.org, cota@braap.org,
 peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Soon we will call cpu_has_work without the BQL.

Cc: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/s390x/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 490644e12b..e9a014bd02 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -59,6 +59,8 @@ static bool s390_cpu_has_work(CPUState *cs)
 {
     S390CPU *cpu = S390_CPU(cs);
 
+    g_assert(qemu_mutex_iothread_locked());
+
     /* STOPPED cpus can never wake up */
     if (s390_cpu_get_state(cpu) != S390_CPU_STATE_LOAD &&
         s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING) {
@@ -491,7 +493,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
 #endif
     scc->reset = s390_cpu_reset;
     cc->class_by_name = s390_cpu_class_by_name,
-    cc->has_work = s390_cpu_has_work;
+    cc->has_work_with_iothread_lock = s390_cpu_has_work;
 #ifdef CONFIG_TCG
     cc->do_interrupt = s390_cpu_do_interrupt;
 #endif
-- 
2.17.1


