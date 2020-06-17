Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F226C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E144D21548
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EOHgITnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E144D21548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfyK-0008Lp-5g
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEt-0004ge-VY
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:56 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:41180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEo-0000Ou-E7
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:55 -0400
Received: by mail-qt1-x843.google.com with SMTP id w90so2751525qtd.8
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9h9/kdng7d5/XyPKaeEfDSBMXGQEDWBnIMh8jIPDb5s=;
 b=EOHgITnTlH58unySKZbtDoTPHEK2dDpC/Gtmrde6cCSG6qN91j/e6Wc8xugGiyMW0Y
 aWbVM6z1y7CLV6VkMIKEuYpr4xJXFKN+WNdu6UmpyfyoR027BeM1+giuAFsGReSzuHFm
 25DEXXNX4cC/PYZn+8JECZlnzGb1fkr7Hebi10zYnGZC5kBUmnAWMTnkE5KXMYL0aqXt
 0TqTsv+crkoS3h+WhA4i6zkayEDU7y/ON+3maOBj7OwABKtPBdRX3OlFLizYRyU52cB1
 KUnOn5AwjGGXU/D/K/lRgigLztlsb0gCdyqyfGvmtMRuUpGB2dZIrMUnjxD/itry2i/X
 qciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9h9/kdng7d5/XyPKaeEfDSBMXGQEDWBnIMh8jIPDb5s=;
 b=g5fhUQ05rBk00UMICRQ/HhRmRIQnr3wHN4t8oEYlQYIr/AJ+HlmaFdnB/MBQ4sSLz/
 RDwb1buTLStZlMGJqlDp7NQoLkR7IcoqZ+YHwcXnmGJStnSvKQzFSkdbESHnChIC3uJp
 a2A3Xu+h92qOE/S5/Z9il0xF+jRoyXmtjN81pr7XgNT1QxkHF2OrlzD4DM/Uwq468RTE
 20O7YeFXtoA2hmTYPV6ppPwIl1dSM4Pz4vuPzeUZaCxYFWnkAw60F3Ik2mflAcgfUGGS
 zDVqI+odoCuyyiAEBq4bRTFNvE6U28YsA58jKcKPEys7LwnVEnpQGRXLFfbAft66hMpm
 IccQ==
X-Gm-Message-State: AOAM530OlAIrCn+2tRkSIGBatBS5YjgIz+S4sENdawBHngi6XHvG9sp3
 EO4UHbLsWdiQvWV2iqV7ptQFBdogozmbjw==
X-Google-Smtp-Source: ABdhPJxDbZZsWRpQ7oF8CF81oaCZXwgMXStQtX0RyCVG9VnqlMOGfaaP92E8zJYNCy5eo6zgd8WcDA==
X-Received: by 2002:ac8:341a:: with SMTP id u26mr1167704qtb.36.1592427889282; 
 Wed, 17 Jun 2020 14:04:49 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:48 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 65/73] s390x: convert to cpu_has_work_with_iothread_lock
Date: Wed, 17 Jun 2020 17:02:23 -0400
Message-Id: <20200617210231.4393-66-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x843.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, robert.foley@linaro.org,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org, cota@braap.org, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
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
index d157dbb7a9..4d0d323cf9 100644
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
@@ -489,7 +491,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
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


