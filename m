Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822CDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C36F21556
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7NNgrZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C36F21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlg00-0003z3-GY
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEw-0004hb-0b
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:58 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:41381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEs-0000Pj-JN
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:57 -0400
Received: by mail-qk1-x743.google.com with SMTP id n11so3491772qkn.8
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FcchR0Kiy3cS07PsythDlOBOqbmqT9MEDX8/TYIcoYY=;
 b=b7NNgrZrFNuqVFOfuDQ849a9QCbO8DRNYzIhM0lVUGYEd5ZmLEzBXc9iDl2xxSdRNX
 wyvClhDSJmiqfoawmvHf63Ivq9hJxSUryarsthN6PgF0Hj7roHiy7732Pgu2AVqtU/lk
 vD8P9EvZtlR5KoVsJgd3YqI6z0Q+alrUH6ZazunfyvHsYdPmBtk7k6CQuMCPhFPtgBR5
 s5Ygr9YbIarzbNs3cTe6gAMyptKJNna9j30UF3Mm6ORtQqqKGkbRYd95Q4G2jxOxJUTY
 sElUgc1sLzdzOWctyz+lGbsc9YsLVV7/bCZ/URBv4iSO9rYAJOMRz+nfIuxbA00d6K/b
 IWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FcchR0Kiy3cS07PsythDlOBOqbmqT9MEDX8/TYIcoYY=;
 b=THiEuTHk/drK9Xbdq6dnf4R57thrWQCC3KDn838q8h4JUlUigTn7K7JYU/fKuTYbT8
 cXnihemOaeID1NiFmRXGhwrJolEWn5Bx+jGABibUX5yAGsKtyDTRN3nLfXisF8izR5zR
 2D8m29Q1HSZEQF7rQL+2dAKzIFafqiBOHoK11B/bijLhOquWqKUA+KcXtseYCRTDio8c
 gnj7K02VDmJY33PCEfHvFfUL98O0CVilC44sIEP9GFqEbFK0swgptWeGLq96jDIDCxrr
 Thn16YWnyWK9e/NqyARexWlQagyYs5hGGgbEJBF3TpLhE8zhikqwdESi415G6uf4tpoQ
 ppsQ==
X-Gm-Message-State: AOAM533fmG1MZi7GqIBsjISbnBczfdF3pbC0XxuDdbCtEkUAiqOJ5Uog
 K6npnLfcbx0jnCixXdpC7cU1IX/aSW+qzw==
X-Google-Smtp-Source: ABdhPJyx+9aPp6NjMgmMg2Jpy2x8+7rtzrr2M4IIVCw7aqzUu3jyOAym+42n5ip9HKdguY35gz62Dg==
X-Received: by 2002:a37:a84c:: with SMTP id r73mr336144qke.0.1592427893463;
 Wed, 17 Jun 2020 14:04:53 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:52 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 68/73] xtensa: convert to cpu_has_work_with_iothread_lock
Date: Wed, 17 Jun 2020 17:02:26 -0400
Message-Id: <20200617210231.4393-69-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x743.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Soon we will call cpu_has_work without the BQL.

Cc: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/xtensa/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index fda4a73722..0f96483563 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -47,6 +47,8 @@ static bool xtensa_cpu_has_work(CPUState *cs)
 #ifndef CONFIG_USER_ONLY
     XtensaCPU *cpu = XTENSA_CPU(cs);
 
+    g_assert(qemu_mutex_iothread_locked());
+
     return !cpu->env.runstall && cpu->env.pending_irq_level;
 #else
     return true;
@@ -187,7 +189,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
     device_class_set_parent_reset(dc, xtensa_cpu_reset, &xcc->parent_reset);
 
     cc->class_by_name = xtensa_cpu_class_by_name;
-    cc->has_work = xtensa_cpu_has_work;
+    cc->has_work_with_iothread_lock = xtensa_cpu_has_work;
     cc->do_interrupt = xtensa_cpu_do_interrupt;
     cc->cpu_exec_interrupt = xtensa_cpu_exec_interrupt;
     cc->dump_state = xtensa_cpu_dump_state;
-- 
2.17.1


