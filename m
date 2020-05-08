Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9636FC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56B62207DD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YSTkmNdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B62207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5IA-00040v-8r
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5Aa-0007Zg-GR
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:44:12 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5AZ-00055t-N0
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:44:12 -0400
Received: by mail-pf1-x443.google.com with SMTP id 18so1129445pfx.6
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NN/QLBosnfSE6MOjBuSmBLZSNupnPgsxwETGi0A5VuM=;
 b=YSTkmNdPAb6KWVnRXBQOb9kH/kZiOxMSfb0NNfEwvv02MVv+Pqr48jnlkNBSdwnNmY
 TExxZ2xg10NLDylQc9LxuZ0eiqO6RPkST+QpMw1o+9WgsHrzGigAXskLlqM+MFz4/dHy
 Hd5b6BL+dsdLy0qH5dIpP9WWmeNAcxBnkqxycn41K8FM+EgYlu4CcBAhLFGsDIp6xCjd
 ID5/noCtmQrM13DOntYHdOIyiS5+er4T8aHmZkve0IQG5CiCLx81PaBGuSdNQhxKoGyd
 qHcQiRGNLAeRsAhFQcX06nynr2z/9HpvnunjFZTgENG6a0VbHqeV1qtL59MxZq0I1tuh
 zfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NN/QLBosnfSE6MOjBuSmBLZSNupnPgsxwETGi0A5VuM=;
 b=VA1t2R8wcjl2XayR1EgKUzb3BCCv9OsliAh3bhc8zz9SZ8ZzcTYUZf1XZVgAUYFJsL
 BiqoQl8xgjPXSiOVG3uobmT5zDeabpLx4zY8TcgchN1blOGFtx84i9tJF36NGDHpqamu
 skAoOh6Gw6uaDlFTINt5NeGoOmV1jR9dtgfh9GwwNCk6KcYutfHpzOtZBv9qzxXq+nqD
 jOURQaidgPomkZ1wKt7nS1LDEhNIKvS4bKFm+97wfweVd865Khju/1yuT7OK20ESKlPF
 kZ9Ocvj82seK5J/0hvVVSD9bUHLEZ/bG2H6FWxIP10LjL7Z3EmQhLcvT7yFiodIn9ddA
 /BlA==
X-Gm-Message-State: AGi0PuZSL3wnAQz0+gm4ahZPn655TTOnZRYBAAN2PULGiZ7msdY7gcHA
 e0lcukh8UnXsBsLK91Xddh28DqfiPVU=
X-Google-Smtp-Source: APiQypIC6J0oFvA9p/4SZ9TQwAcfvyE8hMGYIrjthbT/ZiuXhe2xCUCCuN2OCF5A6grH/ZvghAdCaQ==
X-Received: by 2002:a62:7c16:: with SMTP id x22mr3458266pfc.267.1588952650069; 
 Fri, 08 May 2020 08:44:10 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id o99sm2727662pjo.8.2020.05.08.08.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:44:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 02/19] exec: Fix cpu_watchpoint_address_matches address
 length
Date: Fri,  8 May 2020 08:43:42 -0700
Message-Id: <20200508154359.7494-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508154359.7494-1-richard.henderson@linaro.org>
References: <20200508154359.7494-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The only caller of cpu_watchpoint_address_matches passes
TARGET_PAGE_SIZE, so the bug is not currently visible.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 2874bb5088..5162f0d12f 100644
--- a/exec.c
+++ b/exec.c
@@ -1127,7 +1127,7 @@ int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
     int ret = 0;
 
     QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
-        if (watchpoint_address_matches(wp, addr, TARGET_PAGE_SIZE)) {
+        if (watchpoint_address_matches(wp, addr, len)) {
             ret |= wp->flags;
         }
     }
-- 
2.20.1


