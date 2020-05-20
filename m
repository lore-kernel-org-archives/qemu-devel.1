Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DEFC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9520207F9
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tCnOefJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9520207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbPSt-00041W-Ui
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPM7-0000Dl-7c
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:59 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:45592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPM6-0001zr-BQ
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:58 -0400
Received: by mail-ed1-x544.google.com with SMTP id s19so3151565edt.12
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 07:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+LGH6cEsciAiwVyXb+MVUWk2m7FbTfgK1AGU3Atbb6c=;
 b=tCnOefJAPSgNssrx7Mqr6fwaYfBkYwjbKjD01MQnAfIMEpCA+h3AcWI6YIGsu4AnJL
 1wKPAlaCQszIXvxzyunpgiJ2NcwV5HxN3e83fzrYcAcWo/oXhmDl0TVFFKOEgI7CwF6h
 R7XG9OD9ZjPTP0PcbDLbztZ6gU5U4cKOzCCAOYAZ8zEh/dtijjoRvNWzlhYAf4V3nnTL
 243rLu16SSQr0cdXn6KYpPfedN4lypsvvA7MGR+gyiYretHRPq4F69XkMzOXDz0XIN1c
 oE5znS/0Dpsy5OLO+2p9gapwgryMOwEhIssR2h+vhRblx4fo//1GqZRw37tR/ULDnVTK
 3T1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+LGH6cEsciAiwVyXb+MVUWk2m7FbTfgK1AGU3Atbb6c=;
 b=fKsODiwd3O3erfyRydXNgfQj3xQMUVSMDzt2rMe9J26obIOtSxqCY1sPis442Q+WD7
 PBqCNfpvoVH3xy4UISEsaNzVH8SZlQOZLJnaCFKsUz4HIqnYm4Fa+M3pYFA2HAiVM556
 toBlBA5AU6SiGUbDKnjQPZFxotv1gccIKDtpKvgA6gvC6EKvlVHIT+DvILBsdYUk61A/
 aQfZ7tcqaVrsDIjfJk2+SeYTvlEjI4tNQ+J1nJlTjSpUyTopF93qij/lp+cv7GdlRa2u
 v64Gw0JO0GvA+T0Upz8+Kzfi8uYPWAugE/HIEYB4Tv/4a9xDksO4vtAmbYyZ8KWeQVWJ
 v6bQ==
X-Gm-Message-State: AOAM533hOqpOdwWReXHlPPP4HWx9trp9rYTA2oOplvBQ4Kcav+D5kEdV
 IgD+38APpQOhep9z0fZ0i3Zbww==
X-Google-Smtp-Source: ABdhPJzXChu7WUg33jAUbSnVdxrNsc3I5vPU5OeuwFMApBq5gFFSpkMmrrXcJ4Hifp6RcYdwjpkWcw==
X-Received: by 2002:a05:6402:c87:: with SMTP id
 cm7mr3452099edb.96.1589983557054; 
 Wed, 20 May 2020 07:05:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id ch8sm1994503ejb.53.2020.05.20.07.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 07:05:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 490351FF9B;
 Wed, 20 May 2020 15:05:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 12/15] cpus-common: ensure auto-assigned cpu_indexes don't
 clash
Date: Wed, 20 May 2020 15:05:38 +0100
Message-Id: <20200520140541.30256-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200520140541.30256-1-alex.bennee@linaro.org>
References: <20200520140541.30256-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x544.google.com
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
v2
  - slightly tweak the index algorithm to preserve cpu_index = 0
---
 cpus-common.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 55d5df89237..70a9d12981a 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -61,13 +61,15 @@ static bool cpu_index_auto_assigned;
 static int cpu_get_free_index(void)
 {
     CPUState *some_cpu;
-    int cpu_index = 0;
+    int max_cpu_index = 0;
 
     cpu_index_auto_assigned = true;
     CPU_FOREACH(some_cpu) {
-        cpu_index++;
+        if (some_cpu->cpu_index >= max_cpu_index) {
+            max_cpu_index = some_cpu->cpu_index + 1;
+        }
     }
-    return cpu_index;
+    return max_cpu_index;
 }
 
 void cpu_list_add(CPUState *cpu)
@@ -90,8 +92,6 @@ void cpu_list_remove(CPUState *cpu)
         return;
     }
 
-    assert(!(cpu_index_auto_assigned && cpu != QTAILQ_LAST(&cpus)));
-
     QTAILQ_REMOVE_RCU(&cpus, cpu, node);
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
 }
-- 
2.20.1


