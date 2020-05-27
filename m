Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE59C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 771732088E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOuJUfkk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771732088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxWT-0001Mw-K7
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxSa-0001wZ-QZ
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:55:12 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:43627)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxSY-0008DY-2f
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:55:12 -0400
Received: by mail-wr1-x434.google.com with SMTP id l10so1538000wrr.10
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 07:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aitRg9If761W1gcoFA+t9rMfX6i5VN1JLB5FFhcpUdo=;
 b=sOuJUfkkKq21pQOAkTABGqsTn0BnRJRVoham3SoPFFyazh1d0/l6Kt1j7KNJpSJCnA
 vsO3UNMZmR+0AfTd4CPnSro5JLqPSPVxNoJn1aBHPjDF6WABOwl+xfbc4CmCSCtnPMfs
 ayHL27lqrTE94Jo1Cm7MCUOkTuC94SDZjqi3DdfpAc4ks5HYAZ15fa3+k26zZhyIqK4z
 jdzArH3sJW1PLIRAMQgJ+x1h+nRd4xb+sNM1Vs8999uoK18LNKAgkbTwZc5R/VgLxaAU
 rH4TZS2K63EO0CG61vMUKdziakvYrBrfIELPmFfdnrqoSIF7YSFMOHIUDrUHDGaScQk4
 dOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aitRg9If761W1gcoFA+t9rMfX6i5VN1JLB5FFhcpUdo=;
 b=B8+V4fHzQoZtSUe+bSTuzB7I8ilkNrDffOCugTnPdp4c804nxQ42bDTYCswwuAgOwR
 2svUDjRWl9fPWKOY3i2pX1XscRaxWfgieDGzgaF5SZxBmyeAX0l7yqdH6aWwXkPrIfsD
 nXXFAMvFSIRwxfnkYpaPCy9JSWS1VSOjfcb+jleGRKBSi/QwoJgOlGAytu/0e5nGxpO8
 8YwLs9+aGyLnuAKOLqKMB+t4Qjh4EOsQYF2DW8aS1GyNHLmBzDFmM3TaVm6vHuHDWheM
 mkHauKE9IqR5rUGICMii8j+TtsDI5u1pSJQAN0G2Tmu/bI0c84ywJyvWbc60n8dkLLkw
 z2xA==
X-Gm-Message-State: AOAM533dUys3LWqjEtVEBItG5bNYpMTCPU8Mi38SeqOjg/sxahIMPqkL
 IWpO0tKAoAYSNvrjW0/U22FI3A==
X-Google-Smtp-Source: ABdhPJxZmCOOrz7N+olHlbIzzfs0mHjZkUY8mnW9KQIB9wdPGGzwv12ZHz3Fvv84cFqLOVZJWBC8uw==
X-Received: by 2002:adf:a399:: with SMTP id l25mr24502400wrb.212.1590591308201; 
 Wed, 27 May 2020 07:55:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x186sm3268618wmg.8.2020.05.27.07.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 07:55:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 001111FF99;
 Wed, 27 May 2020 15:54:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 10/12] cpus-common: ensure auto-assigned cpu_indexes don't clash
Date: Wed, 27 May 2020 15:54:53 +0100
Message-Id: <20200527145455.2550-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527145455.2550-1-alex.bennee@linaro.org>
References: <20200527145455.2550-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Igor Mammedow <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Igor Mammedow <imammedo@redhat.com>
Cc: Nikolay Igotti <igotti@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20200520140541.30256-13-alex.bennee@linaro.org>

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


