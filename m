Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DD2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991BE2053B
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mk0PGW4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991BE2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvG6-0006sJ-3O
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 13:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvEq-0004jR-2C
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:32:12 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46718)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvEp-0007m8-4A
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:32:11 -0400
Received: by mail-wr1-x444.google.com with SMTP id w7so401788wre.13
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 10:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Gdil8t+xOr7TCjqgJyVIpfNS5QGic/4oGQPhUYY1lwY=;
 b=Mk0PGW4BIra3cS2PmzSYNrVkdPGBRV8SVZaCqfq3vq6bVcstAaROI1pszAwikYGSsE
 TABTuaPO8dcIPnw+KIVPuayAZ74+Ee8C5we2skVc3UidC2FUrVbdGFYAyK6kPoAcs/sa
 63FiyyTPadcyjIAMJnG30EuPaHzMowRQwdLDf8a2t0ywzKWQtcwCsBQsKQyIUUhAP7ce
 M2W44Feha5Jb5GYaCOntV4Ufc5SKrdFABO3/cjsc+twW2Cbnm2DR5b6aWEQrqGvu91/i
 77VNQd8UrIF9y5DpHeBLPiUi4QDBlIy1xK9cJSvtfzgddm0yosxxqmm9APmdQ+wJdJqe
 X5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Gdil8t+xOr7TCjqgJyVIpfNS5QGic/4oGQPhUYY1lwY=;
 b=LrsLrXydAr7uwuqsxmOjbw3oWDFmCFq8ZHfVyFwjMlgH58V6Rn98nHXy09Wn+3wvtp
 DpPK/l1gAIibMR5wg48eVclkphji72u9f0dyDfocXCfwMwgpuAkNpsGhZ6rwK1pdGVgF
 3oMPQv0GSgAO/2yp6vqehAOk+T1erdiW1pYTcNAERzob+e6PVeWtrAdoAn+rP16mvWWn
 k7gijUOetfPebiL7t8BXoOdOnWLZW1dqTpn4sq0glBycdF4R2dXqdOVjPAGXQeHINY5U
 8Fc7u9WGsEX+VGteYh37JoVeFzNdlzHE0hgKKcsgkf2WeQrZeQu9jC3gnncQFG75MkVN
 5Vcw==
X-Gm-Message-State: AOAM5314F65i2Ufv98+kLwQR9LDQxS3DN1mEqip5FobSn9hVOp6fBpGV
 boeUv+PdKht3pI/x65zqFLZr9Rq7h3I=
X-Google-Smtp-Source: ABdhPJwL0ElNpBW71yX/nSVyEYQJla9seuk4DtygfC/oZNJJWWx+M2Yj9iDWUOyAf1Iwf4HsqDriOg==
X-Received: by 2002:adf:97d9:: with SMTP id t25mr438902wrb.176.1589391129690; 
 Wed, 13 May 2020 10:32:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b14sm25207574wmb.18.2020.05.13.10.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 10:32:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5727D1FF91;
 Wed, 13 May 2020 18:32:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 5/8] cpus-common: ensure auto-assigned cpu_indexes don't
 clash
Date: Wed, 13 May 2020 18:31:57 +0100
Message-Id: <20200513173200.11830-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513173200.11830-1-alex.bennee@linaro.org>
References: <20200513173200.11830-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Nikolay Igotti <igotti@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Basing the cpu_index on the number of currently allocated vCPUs fails
when vCPUs aren't removed in a LIFO manner. This is especially true
when we are allocating a cpu_index for each guest thread in
linux-user where there is no ordering constraint on their allocation
and de-allocation.

[I've dropped the assert which is there to guard against out-of-order
removal as this should probably be caught higher up the stack. Maybe
we could just ifdef CONFIG_SOFTTMU it?]

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Nikolay Igotti <igotti@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
---
 cpus-common.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 55d5df89237..5a7d2f6132b 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -61,13 +61,14 @@ static bool cpu_index_auto_assigned;
 static int cpu_get_free_index(void)
 {
     CPUState *some_cpu;
-    int cpu_index = 0;
+    int max_cpu_index = 0;
 
     cpu_index_auto_assigned = true;
     CPU_FOREACH(some_cpu) {
-        cpu_index++;
+        max_cpu_index = MAX(some_cpu->cpu_index, max_cpu_index);
     }
-    return cpu_index;
+    max_cpu_index++;
+    return max_cpu_index;
 }
 
 void cpu_list_add(CPUState *cpu)
@@ -90,8 +91,6 @@ void cpu_list_remove(CPUState *cpu)
         return;
     }
 
-    assert(!(cpu_index_auto_assigned && cpu != QTAILQ_LAST(&cpus)));
-
     QTAILQ_REMOVE_RCU(&cpus, cpu, node);
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
 }
-- 
2.20.1


