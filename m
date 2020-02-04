Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6639DC3524D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 02:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3330221582
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 02:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NCxNYYC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3330221582
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyoOn-00075J-CT
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 21:57:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60929)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <38dw4XgMKCoYtu9qyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--jkz.bounces.google.com>)
 id 1iyoMN-0002bm-UX
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:54:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <38dw4XgMKCoYtu9qyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--jkz.bounces.google.com>)
 id 1iyoMM-0003Xi-Vt
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:54:43 -0500
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a]:38179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <38dw4XgMKCoYtu9qyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--jkz.bounces.google.com>)
 id 1iyoMM-0003Sd-PN
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:54:42 -0500
Received: by mail-pf1-x44a.google.com with SMTP id 203so1977765pfx.5
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 18:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=SpvOvcICtqptiM7uvVhQLga1sT0u1zsTnuHopeVscGY=;
 b=NCxNYYC+/xwn6BOTMOY79tZ8p3knIB26MAbp/fFkbzWPJKbHDaXVZmVv1q0IbPxE7G
 XcBaBqUQTiYUrK63jQu1y4YSXIfNLeOU7jZI5fR/FdwqFWdfwWZ4tTmNEKnVuqMwa5WL
 WH0dNVgOyaDEY/+GJ56t2E+EBVBpRNX/pg0+d9FGwLk8hG6KNR1z1HrIBwGi1sEnH7zh
 EwEldTTLRXOKo8sH0RzRC9vcWDetDY4TauJFE5RBoXhvIOA101C5NwCcBhj08ncSOh4D
 A+NmJzlbgtUbj8L2lawPVN6sDYCRAH/q7p4yw1Oufe4FMmwTgUlCsMUY7Qsof/rzMJI+
 Qn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=SpvOvcICtqptiM7uvVhQLga1sT0u1zsTnuHopeVscGY=;
 b=EOACpp8Zq5rLOc4jVhcm/yg7T5uTpFnlB7L/gjtXvWv6/SCNQSr4+Yeml1ixjR7/fH
 h0x2elJVE5YR0VmT4yKYOhbwHs9jMMYnVHNa8Y107aI66scR/qPUWqzKXo8HXp06VnOz
 10pdy8YCKDqDtco5MdYdoHG6xi4eym9nVwJOxATuEOhn4GN8UWlF+RjzPc9UK1A01dH7
 51MhYW+mn0AeVYE9E+Y2ifvMuErJ6IaVQuI2HdQZ6aG+LO6/BLYUilXJxjGRC3nFPu8L
 dae6bPCF8XADOsG1o3kNTzDq/+1o6pK8yDXzfm6TugUPVorcQd9F2rmPOtUqHXhyAfQ/
 iMVw==
X-Gm-Message-State: APjAAAVfWNR85eyoyt23C1h7AJApw1Zxu/Fpw+foUgykWf6JcxggTQ1R
 b32UB0TSPp+pE2suaarPCx4IDVymMjMlUutZqFeytcUkCdiXyKEhD/CbuLTwDaHY5MHCQuDpu8z
 jODRvFogZ0vA7De35zP6iywPMXxALH2UF6PFpZrRMhMLEBaYZ+NGw
X-Google-Smtp-Source: APXvYqyk+028ZOpfUPNtq4K1JELkY9So3R48ZvuLlrmh/lD3kb+7oKCvJoAhmOSSrKODGi2KGB/j66o=
X-Received: by 2002:a63:de4c:: with SMTP id y12mr28194164pgi.107.1580784881405; 
 Mon, 03 Feb 2020 18:54:41 -0800 (PST)
Date: Mon,  3 Feb 2020 18:54:15 -0800
In-Reply-To: <20200204025416.111409-1-jkz@google.com>
Message-Id: <20200204025416.111409-4-jkz@google.com>
Mime-Version: 1.0
References: <20200204025416.111409-1-jkz@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v3 3/4] linux-user: remove gemu_log from the linux-user tree
From: Josh Kunz <jkz@google.com>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, alex.bennee@linaro.org, 
 armbru@redhat.com, imp@bsdimp.com, Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::44a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that all uses have been migrated to `qemu_log' it is no longer
needed.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Josh Kunz <jkz@google.com>
---
 linux-user/main.c | 9 ---------
 linux-user/qemu.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 8f1d07cdd6..22578b1633 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -112,15 +112,6 @@ const char *qemu_uname_release;
    by remapping the process stack directly at the right place */
 unsigned long guest_stack_size = 8 * 1024 * 1024UL;
 
-void gemu_log(const char *fmt, ...)
-{
-    va_list ap;
-
-    va_start(ap, fmt);
-    vfprintf(stderr, fmt, ap);
-    va_end(ap);
-}
-
 #if defined(TARGET_I386)
 int cpu_get_pic_interrupt(CPUX86State *env)
 {
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 2421dc7afd..792c74290f 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -211,7 +211,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                     abi_long arg2, abi_long arg3, abi_long arg4,
                     abi_long arg5, abi_long arg6, abi_long arg7,
                     abi_long arg8);
-void gemu_log(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 extern __thread CPUState *thread_cpu;
 void cpu_loop(CPUArchState *env);
 const char *target_strerror(int err);
-- 
2.25.0.341.g760bfbb309-goog


