Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3AAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ADB722CE3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 18:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ppsj5mQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADB722CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3OAf-0006Er-Lj
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 14:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3NzB-0004zb-RM
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:57 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k3Nz9-0006XG-Ub
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 14:17:57 -0400
Received: by mail-pl1-x641.google.com with SMTP id f10so830885plj.8
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 11:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=f4dp87j0JbOgZeF9Q5qKD4L3G1MqZ8pb/SPlrQlUp44=;
 b=ppsj5mQYzg/Kr8tUEwM3tmcuTjfMRCrWF4RrbFmBPoemT/+eavST4FAzusKdk2UUAI
 bIfBxQRoMLAgPliH+m1CrXTBld+ILPMjtZkOkw3LwwDHYdWPGlPvRsqMg3yBy/Y/5B5v
 6foe2wskP6azX/c+GclfKEOTZ+QDlKCxgHhSJ9ZryXg6nX0zUo6m66BjGAYWQcbcVYnj
 VlhTt0K8b/nnkg+FCSsVNIwfkVqNMfiE4kLTlQY0qEK3euuNZz+fIIvylURCsF9ItYDf
 /zt/sqEC3+Sq8CzrYnJlGW626qVn5JhjZWiQB6SXvbQotfp0GWo5jFQON1pDjvD2A2q/
 7L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=f4dp87j0JbOgZeF9Q5qKD4L3G1MqZ8pb/SPlrQlUp44=;
 b=GiZ2LE3AZ+6uLliPTgb4RA7sXN3cHWe2O08c6BMrv+REOzMk5Nq6ul+/jH9LcZ+iMN
 uRLHdh6c0zXvuxcE5LaZgzlad91A1LfBh2HrlwlmUk0aii57DOhLJe/A2dGaoIZeUW02
 0xpQuxGB5UoNl9yooXwzcdvzFxxKI+ETDVKm8c9QQbVN4rs6Kx0Zrz2tVV0Lu3/xQEiV
 lLVVoXFxMjzPCT0NNU68wxUfvckrXFFwSK0/7dVLtamdkJ22C+k5At1Oqt0agjyDsLlz
 pdMhTU7YpqTznaTeiIZqUz0RuV1t7tQ1xhHuRYtehFDJBVgGQr9ru0TIC0LTre1GQqYm
 nsJw==
X-Gm-Message-State: AOAM531RfA2MloInkold5lBcSRnA5IvYvtGYY3H7bN6FOfqFgxTcfa1I
 +wd2e5WXz8/+TbzolrvAqEVwwpNV8x8=
X-Google-Smtp-Source: ABdhPJwS1OZeyatJagggET6+gLKyYY5uNtT278Rqy94M+Vb+2QkJSIHtUyrEiVlQJrhsHVleqfPKeA==
X-Received: by 2002:a17:90b:14d1:: with SMTP id
 jz17mr33704pjb.98.1596651474313; 
 Wed, 05 Aug 2020 11:17:54 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:38ab:50b1:ff8a:26ef])
 by smtp.gmail.com with ESMTPSA id a15sm3670196pfo.185.2020.08.05.11.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 11:17:53 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 21/21] target/xtensa: add BQL to do_interrupt and
 cpu_exec_interrupt
Date: Wed,  5 Aug 2020 14:13:03 -0400
Message-Id: <20200805181303.7822-22-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805181303.7822-1-robert.foley@linaro.org>
References: <20200805181303.7822-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: robert.foley@linaro.org, Max Filippov <jcmvbkbc@gmail.com>, cota@braap.org,
 peter.puhov@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is part of a series of changes to remove the implied BQL
from the common code of cpu_handle_interrupt and
cpu_handle_exception.  As part of removing the implied BQL
from the common code, we are pushing the BQL holding
down into the per-arch implementation functions of
do_interrupt and cpu_exec_interrupt.

The purpose of this set of changes is to set the groundwork
so that an arch could move towards removing
the BQL from the cpu_handle_interrupt/exception paths.

This approach was suggested by Paolo Bonzini.
For reference, here are two key posts in the discussion, explaining
the reasoning/benefits of this approach.
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08731.html
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00044.html

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/xtensa/exc_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index 01d1e56feb..fd33a56847 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -200,6 +200,7 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
     XtensaCPU *cpu = XTENSA_CPU(cs);
     CPUXtensaState *env = &cpu->env;
 
+    qemu_mutex_lock_iothread();
     if (cs->exception_index == EXC_IRQ) {
         qemu_log_mask(CPU_LOG_INT,
                       "%s(EXC_IRQ) level = %d, cintlevel = %d, "
@@ -252,6 +253,7 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
         break;
     }
     check_interrupts(env);
+    qemu_mutex_unlock_iothread();
 }
 #else
 void xtensa_cpu_do_interrupt(CPUState *cs)
-- 
2.17.1


