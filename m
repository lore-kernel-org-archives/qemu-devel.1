Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0E0C55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF2720809
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvwyJshD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF2720809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXBzm-0008Ub-Rn
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 19:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXBwX-0003H8-Ae
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 19:30:25 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:38745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXBwR-0000LW-Ky
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 19:30:20 -0400
Received: by mail-ej1-x62f.google.com with SMTP id ce10so16481129ejc.5
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 16:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pEqSKEMY04puZYBT7KxO2knLfSLveelIAXH747evHJ0=;
 b=MvwyJshDxZ7tllBWWiu5xhHIL9RNwRAgI4uwjqbfbGzpZ/IWd5K7angs5wbpSQ9+Lv
 s5hYBNlY2/yoOZ3RpSjBhr/qGv6UbO+NsJW1XN0JUUtuKLUJ7vZntIfx8ykQSESk2aUM
 /kCdvka9J8xwaHlX8Su+cnH2mzkswJD3wkXcJmwRxCvQ0BxcjrDxTU3TgsjlRQWfUZ6Q
 xQ7dP6aRamwnnpsre4q/5NJ7MjZ9+WTpVUelLq0spSuEbarGHzD4JJvrMWg50pwZ36pX
 9f3sLzYk1hveFeFgftzGw/Qx6SuYkYbw99mK7XwV3eW9LMXS0gTKIjjgGj0KYopW87gq
 3jWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pEqSKEMY04puZYBT7KxO2knLfSLveelIAXH747evHJ0=;
 b=ERJcVN/Nd2wjOQdV4VstC/r7F+Ljgk7hnIif3U2xi4BZLmII5g/hMZRhjOVyFLeri1
 NYCOZs4rs3gAxay5Vdt08CoRkmXKR0psq+CDp7+4PT4Ot0tr6dCwxyrc2Og1PxgeJdML
 L8o0dS88yRCyc4HduhAXUW9F5KHeFugpBydnJrcThkcaQhYHi7TtZxWMRISKWXXZgag7
 fPkfwzzjfruQKxxT/KQg2a8OEelUozlk5HIP7YtZLX2uafYOx2quhjuGucWaUJ9HH3bH
 c+SXuupqUK9TcJfQXWSVwGt7wWS1UQFLs6Qj0dTR2BVZRPFtMPo4jTeU5tBGAvCQsYXp
 p0cA==
X-Gm-Message-State: AOAM532yYraiZSdNmVIcEPvugRLzXgrEGZfakCy0VAbdzFM+kg1LVykt
 kh9N0IgXll8k5G0lpXqB2+5Mep7XVK4=
X-Google-Smtp-Source: ABdhPJxNvylgZNUJpuhj3ahISda1unkvX7kRgyYwiHTUo5YBfCKnAe+6VQm2N0fIGUZLhoh9VOSmhA==
X-Received: by 2002:a17:906:824b:: with SMTP id
 f11mr17585521ejx.16.1603755016520; 
 Mon, 26 Oct 2020 16:30:16 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id m11sm5970344edv.14.2020.10.26.16.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 16:30:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/8] target/rx: Fix some comment spelling errors
Date: Tue, 27 Oct 2020 00:29:34 +0100
Message-Id: <20201026232935.92777-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026232935.92777-1-f4bug@amsat.org>
References: <20201026232935.92777-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x62f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: David Edmondson <david.edmondson@oracle.com>,
 Lichang Zhao <zhaolichang@huawei.com>, Magnus Damm <magnus.damm@gmail.com>,
 Philippe Mathieu-Daude <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lichang Zhao <zhaolichang@huawei.com>

There are many spelling errors in the comments of target/rx.
Use spellcheck to check the spelling errors, then fix them.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
Reviewed-by: Philippe Mathieu-Daude<f4bug@amsat.org>
Message-Id: <20201009064449.2336-5-zhaolichang@huawei.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/rx/op_helper.c | 2 +-
 target/rx/translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index f89d294f2b2..59389f49921 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -318,7 +318,7 @@ void helper_swhile(CPURXState *env, uint32_t sz)
     env->psw_c = (tmp <= env->regs[2]);
 }
 
-/* accumlator operations */
+/* accumulator operations */
 void helper_rmpa(CPURXState *env, uint32_t sz)
 {
     uint64_t result_l, prev;
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 482278edd25..9ea941c6302 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -1089,7 +1089,7 @@ static void rx_sub(TCGv ret, TCGv arg1, TCGv arg2)
     tcg_gen_xor_i32(temp, arg1, arg2);
     tcg_gen_and_i32(cpu_psw_o, cpu_psw_o, temp);
     tcg_temp_free_i32(temp);
-    /* CMP not requred return */
+    /* CMP not required return */
     if (ret) {
         tcg_gen_mov_i32(ret, cpu_psw_s);
     }
-- 
2.26.2


