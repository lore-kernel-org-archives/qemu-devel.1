Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0942BC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9BDD20820
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4t46+YJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BDD20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51392 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfPTw-0002q7-4e
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 09:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41595)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGJ-0006jF-EU
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGG-0007ga-Sw
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:58 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:37790)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfPGG-0007Z0-JM
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:56 -0400
Received: by mail-wm1-x329.google.com with SMTP id f17so13456169wme.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sgFHUBki7irv0ZpoKsilsQQcYReZg1Ztcy4s6VB+Mlo=;
 b=F4t46+YJFn9aDyEA2g2iYs48FjwPQs9jrzySLiJj4eJSOMfBkPgIRZcHd4TRC/l4un
 wj5mHt3OQe+b3rjnmp7pQ/9nf4C2EQklCyD1l9qmEvr5cUGXZAcXELW+wshJcO4HNWZB
 /tN/zWD5hJpjbZaaG1WX1/9c7RMZeNXqiYg8V7u8J6PmsFI8D/lo2uJD/nihzvpYLcPo
 JgbY1eULIwzYwSjrfFF5KWzHGsk+Ydvry1cQBNpcmVk/ic/fCv4DdlcepXITjDCufUU5
 8dY90pmjW3Uab5/coteRczgAWfmQtnpjEoI/lPqsMd/1O8tonx/+/D5DMt2WyUinaIVL
 Ecxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sgFHUBki7irv0ZpoKsilsQQcYReZg1Ztcy4s6VB+Mlo=;
 b=UnsTV9/kgwEDMAb7a9MbmVt0HNYR3hBErPSTyvdwvS1xpWh4J5mgg1diOoPAW+7Zit
 jm73y21N1Nf+WUNtvAWuTuI7YHRv7VvKHlPkdeO0SBwXEmSTXScvYF8Vg23xR1TZdkPx
 h/FKHQ9pe0M7WR6w+WRVFPHMNf0RYXawPiujwGnX+d/XoDIChs5q41tm7iE5Hn4lpw2c
 9fNlgZ7/JMde5Y8Ll2TjBi9jLErZ9NieAU3Ql2SPxypriNHShlNT378BAdxtdmaL8Tm/
 4NjpLfxszZDljyR9s1HYlteH8YX4rrFtsyJ/Vx4eIWRRiFMkJuotsuzknTzri1STTR9v
 +Amw==
X-Gm-Message-State: APjAAAW7t5rYhL/OzaqGppMqZPDjBcQ8eCCxfyjNEPT+k/A4zcLjz3xo
 F82Q+r2VN/hbJfGx5zVlRfsIpA==
X-Google-Smtp-Source: APXvYqy2xCNc2j5W5ggwl8XgFQ2YqwEMyEx4PbJ6/kw3OimNvKs2+KR2iTebb7G9wipdFMNnrXwjZg==
X-Received: by 2002:a05:600c:2549:: with SMTP id
 e9mr16443711wma.46.1561383830792; 
 Mon, 24 Jun 2019 06:43:50 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id r2sm16154485wma.26.2019.06.24.06.43.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 06:43:48 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 252001FFA5;
 Mon, 24 Jun 2019 14:43:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 24 Jun 2019 14:43:37 +0100
Message-Id: <20190624134337.10532-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624134337.10532-1-alex.bennee@linaro.org>
References: <20190624134337.10532-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
Subject: [Qemu-devel] [PULL 19/19] target/i386: fix feature check in
 hyperv-stub.c
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 2d384d7c8 broken the build when built with:

  configure --without-default-devices --disable-user

The reason was the conversion of cpu->hyperv_synic to
cpu->hyperv_synic_kvm_only although the rest of the patch introduces a
feature checking mechanism. So I've fixed the KVM_EXIT_HYPERV_SYNIC in
hyperv-stub to do the same feature check as in the real hyperv.c

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>

diff --git a/target/i386/hyperv-stub.c b/target/i386/hyperv-stub.c
index fe548cbae2..0028527e79 100644
--- a/target/i386/hyperv-stub.c
+++ b/target/i386/hyperv-stub.c
@@ -15,7 +15,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
 {
     switch (exit->type) {
     case KVM_EXIT_HYPERV_SYNIC:
-        if (!cpu->hyperv_synic) {
+        if (!hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
             return -1;
         }
 
-- 
2.20.1


