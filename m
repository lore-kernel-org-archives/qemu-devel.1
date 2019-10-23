Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E8ACA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 17:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC072086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 17:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="spWfgZhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC072086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNK0w-00084o-GW
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 13:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNIp4-0004lR-5S
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNIp3-0005Zj-31
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:18 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730]:41354)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNIp2-0005Wg-Uy
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:17 -0400
Received: by mail-qk1-x730.google.com with SMTP id p10so20175533qkg.8
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=c7P4icDHFNd0mEdVm74bSlE92DJndGlIMYmWQpTcLCI=;
 b=spWfgZhKpuPn2IsUtYCPi7864OHr4cq5CqGow2D5RkOD7mZHHJQ7K+SGj9an4k9GSu
 mrUIOnZOw/HHyXmTaEmPpWuqr12wWdjQd9qrFyOic85uFl52oJzAFbXViVRAP/e4sLW2
 TSDvGQmnCl/NVCDzSGpXm04rVN2IYgS+HVfLMWxJrVGfLgTRIR/YoG3omnP+K80pCPx8
 3Z7e3K9TJoepvdSz2PbnGy2HmPBvub/tCOz10vYKwc2Oa1hbjyH9/BuTU4lwI8U14rvZ
 NElFgUXr9m7L5segePxBAhlbvuC4IoyvF2Nv3itMjjuL0LK45ZMq4apnKVYPz3h5fCky
 ME8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=c7P4icDHFNd0mEdVm74bSlE92DJndGlIMYmWQpTcLCI=;
 b=e+Gfm8iMxQ4rMcBf65E3VD/tFbDExds/Cd2eiYxAMb+5e45IO7yC4oEz8DSTjikyTa
 I86MblWtX1nkpNeoWvDvYX+FaG9/vj84em0wu2UfwZS7udUGKdKisg+I0ay2Wg5dF7Zo
 FmY63h4pMmp2Mzojm/hz047TMzbp3r6kX+vAwFdkqc3mNRKBz5qUSZM+9Kswa/wpGx35
 iEEfu6bliGjsOlS6fL2aPgx3ZccmZDax/5w0RcHaOwIS60eRnJyBHWxOsY6iUboo0KC7
 doBTlpBfAzj4EeiafD6Jw+D97AA1wq3cjDT026OXQ+YFf3DhAfaFkEmFBy8QTXnOuO5M
 94Rg==
X-Gm-Message-State: APjAAAUMLDR73zAxLv+wGnOdYX2zBnYYATummb0Pz0YhaXcnTroGw0yg
 3lLs/9sJz+qDBXp8Z/RyjQF1L7ZxFfU=
X-Google-Smtp-Source: APXvYqyk86RJyqvah5hKMrKLYCaOfMHi5vjNKRedYdTHSp0OA7YPO3t5ZqzbpQ9mkpCzykutZnE2eA==
X-Received: by 2002:a37:85c1:: with SMTP id h184mr8893826qkd.195.1571845515036; 
 Wed, 23 Oct 2019 08:45:15 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id o1sm2456272qtb.82.2019.10.23.08.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:45:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/7] exec: Promote TARGET_PAGE_MASK to target_long
Date: Wed, 23 Oct 2019 11:45:04 -0400
Message-Id: <20191023154505.30521-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023154505.30521-1-richard.henderson@linaro.org>
References: <20191023154505.30521-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::730
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are some uint64_t uses that expect TARGET_PAGE_MASK to
extend for a 32-bit, so this must continue to be a signed type.
Define based on TARGET_PAGE_BITS not TARGET_PAGE_SIZE; this
will make a following patch more clear.

This should not have a functional effect so far.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index d3e4660d50..ba6d3306bf 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -229,7 +229,7 @@ extern TargetPageBits target_page;
 #endif
 
 #define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
-#define TARGET_PAGE_MASK ~(TARGET_PAGE_SIZE - 1)
+#define TARGET_PAGE_MASK ((target_long)-1 << TARGET_PAGE_BITS)
 #define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
 
 /* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
-- 
2.17.1


