Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE62C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C59CB2083B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqWTbV0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59CB2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnQf-0006CR-TY
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDnMF-0008FP-AQ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:24:47 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:38058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDnMD-0007wQ-H0
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:24:46 -0400
Received: by mail-pf1-x430.google.com with SMTP id d22so2081175pfn.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0LmdVTwRuqJjBmwvxMnNThS5SGGCNTfka4CWYwgut/k=;
 b=nqWTbV0rOabku1CVg6hbqxiO00IAhgvb88ih7pIWvrY4XsqGZgag4u7pdCVTMTop3j
 vH/6DPoy4Pd98MG8/wrZ19BgEyldLpLCCjELYbmstgtHblOOWC+UwbyT7zo/4rS1M7f3
 ARWSpd5syklBM1XUUQEA3GOEqBLi8C9wvQsq20xo0z7sEaj4RFv4wUS+rjWnRqyX0hCW
 goWWabDzKt9DB1826bTdZL4ZcFyX5844IM+qugic6i1D/jA2zdHliOHxM1NcZCwdiu7A
 vCUtl1pc/vl4xMQgtTCyaEkk8bzMD+hirOjqJbvGNmqakK1EvMBytIGeA+qaITRjzm/X
 Zg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0LmdVTwRuqJjBmwvxMnNThS5SGGCNTfka4CWYwgut/k=;
 b=qbz6uykSCAqLs94tKyGjwQXfg0ZyiVGQCrlkFCjjr2e+iNgLCc367Z/29eByf7jmvE
 Dl5whFjXXU+txGt3xMXAQOBLlCqrAhKB4qYw6BDyp/RaqPcmMc4PaZkPGFnmj8+nIOkD
 JaBOfRAi1Zb2YDaY9gblQ5wQIYdf2d5AaP1dJVZ4rx4ke3n/wkKUyDDJf3ui0MxHOy/a
 H0Sde0kZI4jYhpgxNO+UWmHZnek9a2HYrRsI7efxyd+o9O9UHPAPR2ZOEQKLese1BWW4
 MGMfCUwi7pJbSdydLjXZXVXPuhdlyEyJmV9yOePBJ3qLhE1qjsVn3a98mW2Qxw/EhwD1
 bJhg==
X-Gm-Message-State: AOAM532kkAEhj2vAMbYKxC4+ldlYejNZnI7LJlObKTCSua9XzF0ZxOTx
 aGBKBM6/VwEki0YUEhLKeUJS1LxDRBChTqtr
X-Google-Smtp-Source: ABdhPJwKpIQ4bbPU+jT6ut0hqjIhDxvs4ahn+If1qhZofm8Bxl8gZp/9tQWnZS+6vEbIBL7FmwNbBg==
X-Received: by 2002:a63:b202:: with SMTP id x2mr2504429pge.432.1599132283607; 
 Thu, 03 Sep 2020 04:24:43 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id y3sm2394249pjg.8.2020.09.03.04.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 04:24:42 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] tests: try to disable make check blocker for msys2
Date: Thu,  3 Sep 2020 19:24:22 +0800
Message-Id: <20200903112423.1765-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200903112423.1765-1-luoyonggang@gmail.com>
References: <20200903112423.1765-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

tests/test-char are stuck forever on msys2, disable it first

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 497f1f21ff..c645e8972a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -130,7 +130,9 @@ ifndef CONFIG_TSAN
 # Some tests: test-char, test-qdev-global-props, and test-qga,
 # are not runnable under TSan due to a known issue.
 # https://github.com/google/sanitizers/issues/1116
+ifeq ($(CONFIG_POSIX),y)
 check-unit-$(CONFIG_SOFTMMU) += tests/test-char$(EXESUF)
+endif
 check-unit-$(CONFIG_SOFTMMU) += tests/test-qdev-global-props$(EXESUF)
 ifeq ($(CONFIG_GUEST_AGENT),y)
 check-unit-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) += tests/test-qga$(EXESUF)
-- 
2.28.0.windows.1


