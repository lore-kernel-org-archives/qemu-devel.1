Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CB9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7715E2089D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OFm64wZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7715E2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfo0-0005fW-Pl
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEv-0004hR-27
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:58 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:40085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEr-0000PX-Ed
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:56 -0400
Received: by mail-qt1-x844.google.com with SMTP id i16so2752568qtr.7
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xM5F5VKH4+4sC5/UG8rh4cawXyjUH8jNOSP42/FFGNs=;
 b=OFm64wZNBrpW0k2TGETE/NApPmVP1ss5RBk7onAJHsQ7hcEsI6yN1SgiNrUrxHWD6J
 jYFFXroxefK9j4U+Fe0l9sR5wKekFRc1sW23R2+58zenplFK0YRODgS2w9pMy27xk8jL
 ZGNIfJtGlMGRN4N8U0x3cijwymopup+N2W6/P8Qlx92y4bqIKCYW2PBAvilqLXBP07AG
 XDSi0RMEblKmIye1sOOu4k1vm5jBSrRWE0B+8TIV1nUgqEEt4tRxIwd0tdrFCUmXpJPr
 wNkoEtWWW5e2K1Cj9S9JDFQXqNjygPb1PG18bNZjNHJTojEq5DVtfdDwlcC/pVEdNwOa
 B6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xM5F5VKH4+4sC5/UG8rh4cawXyjUH8jNOSP42/FFGNs=;
 b=sMO6d1kdjRw5JmbZ/jiISflmicjHDTt9vqbM+J+O4efsoW4Bo2JNDcsBc0ASvujYw0
 sFtidjbe1rPt74iLxX8kDxk1DKABf71yCBa/oBwr3K/rpfFfVcdsetgqTMppgqOH8ol/
 yqDuDD3RQvsr7ppqm6frC1TGlKNOsjqF/f8l+/Yu546oYHK6Zs0/fQEdyl75xXOk0HpX
 G1aMQWwcN2kFRazCpuUnUCG+XqTqfX79bWh4urckPehcdb2sxREhiL7V147B2Nx8QCVF
 IKriTQKo5U4nYxzdyp7a48t1K7UG5QlEZzUpluUyq/XebY8XF6VuTQN8NYnzUOFfxenm
 Ju6Q==
X-Gm-Message-State: AOAM530yOPZ2ZB7KUFqS41YdfbCO53Wx/8ZRBU6RKoxJvNR1YdzRRinm
 DNM2sm0HHdjlhkSdov/DFPY2PgvJbZVntw==
X-Google-Smtp-Source: ABdhPJxXNfGSfor+PGZaaz82a2xEBg66fJWgIH+uRokPLXiV+g87VSlNwu/Jwb2CAlA9ZVdI/bTCMw==
X-Received: by 2002:ac8:7a90:: with SMTP id x16mr1085647qtr.233.1592427892159; 
 Wed, 17 Jun 2020 14:04:52 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:51 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 67/73] sparc: convert to cpu_has_work_with_iothread_lock
Date: Wed, 17 Jun 2020 17:02:25 -0400
Message-Id: <20200617210231.4393-68-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x844.google.com
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
Cc: robert.foley@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 cota@braap.org, peter.puhov@linaro.org, alex.bennee@linaro.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Soon we will call cpu_has_work without the BQL.

Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/sparc/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index cef25238a5..3fa1a535d9 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -704,6 +704,8 @@ static bool sparc_cpu_has_work(CPUState *cs)
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
 
+    g_assert(qemu_mutex_iothread_locked());
+
     return (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
            cpu_interrupts_enabled(env);
 }
@@ -863,7 +865,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = sparc_cpu_class_by_name;
     cc->parse_features = sparc_cpu_parse_features;
-    cc->has_work = sparc_cpu_has_work;
+    cc->has_work_with_iothread_lock = sparc_cpu_has_work;
     cc->do_interrupt = sparc_cpu_do_interrupt;
     cc->cpu_exec_interrupt = sparc_cpu_exec_interrupt;
     cc->dump_state = sparc_cpu_dump_state;
-- 
2.17.1


