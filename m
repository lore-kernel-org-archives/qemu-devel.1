Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D88C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 00:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E188D2076B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 00:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WCvepBfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E188D2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kILee-0002c3-1k
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 20:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kILb0-0006NM-Gn
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 20:46:50 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kILaz-0001XI-0G
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 20:46:50 -0400
Received: by mail-pf1-x442.google.com with SMTP id f18so2931871pfa.10
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 17:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JotyD3Qtuzk8QZcm87RVQJeRfD10PDp771HanSJw7Xg=;
 b=WCvepBfRMPAhNhxSYLySFjeWH23Gb/k9tSYZijeKnUJAm5d0DPCLx20bQfW5v5nf3H
 DznCfD03kdI8lR8Y+E5R+3wX9dJrot7KAryMuAbhAS54n0pNDDMjH1T1bUm+vL3T8iDl
 GzmqYwzbvf3jxTk9UH9b6DD7q6QKOJrNyS7jwwctgTBORK/b1pk/Grp/GI3h8IV8gYt1
 l//xb/UEZIn1PONl5mlknEOM+u4IVzUb8vHrTfuW5c6vgiyAARgpJvaTK7qHYX0RdPP6
 XnwFmTIkSOuv+e++AjYsCBZk7mu537tP/HMFdgGB0+l+CPCUxHvGEJ6/VYAX3x3/k8IU
 tPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JotyD3Qtuzk8QZcm87RVQJeRfD10PDp771HanSJw7Xg=;
 b=KZdgVNjiRl3PsfalLY0Xi784ZkkcYC4wZSmgyZR9fSvE1bwNK91X/ECXB2WrhA9VdS
 8lljx0jXCwOCYV/T/ALKQUfvUKOosWeQB7FN+KfWSUMLcuk1UEGbwEx4K2KyCqXof5Yr
 IGbDWsqQdOlMh3Qkatlt/wA08kcyZ4aRoFHsvUxwkfbncXWmrriGBHEwL3zJpzERQws7
 Wgsgw0yCEg0F9PUFfO840mb5KhvhHDkymQ7B+CR56c71n20gUrS9/4W4ZxF+JhbJGBR3
 3fQUyTAxhHdhypNZ3sfTZZ+W02boXUFLbc4cYQ3pfCon0kaxWyGZfZuEW9eE4R7PPgFE
 fC1g==
X-Gm-Message-State: AOAM533eD6aFKAm5jKKBUMMggin/rzRRqEEiUWEFhKHM4+kKc+DueFgH
 mhp6DVNpjGqSLy/Wk9J0430c4Sr2X19nCA==
X-Google-Smtp-Source: ABdhPJxtW12sqd7Nx8DbaNaAVpWw1KUhnfjuSStCia0lnsdFLWfQlBbPYZ8rY4BGfSJCwC1EWCpR8Q==
X-Received: by 2002:aa7:971d:0:b029:13e:d13d:a08a with SMTP id
 a29-20020aa7971d0000b029013ed13da08amr19528878pfg.33.1600217207482; 
 Tue, 15 Sep 2020 17:46:47 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id kf10sm611723pjb.2.2020.09.15.17.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 17:46:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/6] target/s390x: Set instance_align on S390CPU TypeInfo
Date: Tue, 15 Sep 2020 17:46:38 -0700
Message-Id: <20200916004638.2444147-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916004638.2444147-1-richard.henderson@linaro.org>
References: <20200916004638.2444147-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix alignment of CPUS390XState.vregs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Cc: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org
---
 target/s390x/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 749cd548f0..e350edc9f5 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -517,6 +517,7 @@ static const TypeInfo s390_cpu_type_info = {
     .name = TYPE_S390_CPU,
     .parent = TYPE_CPU,
     .instance_size = sizeof(S390CPU),
+    .instance_align = __alignof__(S390CPU),
     .instance_init = s390_cpu_initfn,
     .instance_finalize = s390_cpu_finalize,
     .abstract = true,
-- 
2.25.1


