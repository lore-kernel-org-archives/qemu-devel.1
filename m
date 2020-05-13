Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6A0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5AD205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Za6nCZ2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5AD205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvYq-0002Y0-7J
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 13:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvXl-0000qK-Dy
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:51:45 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvXk-0004yO-2a
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:51:45 -0400
Received: by mail-wr1-x441.google.com with SMTP id i15so497294wrx.10
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 10:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bhfhYkItu0rqms7vA34WYfwwnNQGZCVSd2qUpQYXdFA=;
 b=Za6nCZ2Z4dF899st7vJkN/HoIC7eG9JHSqVaZIIJTwBLf+ns3fszMWEEDzckl2v5Fh
 0zUwDlPDdRk8UE1/GMoxgLa7Il8k8vktCJwT7B6PBxVi9GGwNcSEgVwMbsPdsv7Wpang
 x6i6913KTew5J99MVfSOjFkikcGB2bw2Gb3EyDlbm4rdyVv7TdUOwKz403ysXc+4Hmo4
 lnJVC3LwTQ+vWKGy/WunbQRoLjBF6jXQeKUyB1XB7Lk9Vw9EBrOmmslfqXfQooVMObCx
 KLiUAXKe6c6+lJJZ/tGapoxoBKFPet6vsJ8hykLVyLYQHXLKQ6Tp1nN+J7XuZ8eqZGyy
 P45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bhfhYkItu0rqms7vA34WYfwwnNQGZCVSd2qUpQYXdFA=;
 b=MgxPIoZHc3OvWUQhuBN0abdH0taCm6VU26nUw94uHtrByO+iVxlcGL92UGUUuUDWR3
 lUhAp861ID7XhTmdqkFPWXwAW0xNqXS+df+LOZMSCst84WlwvIf8rbYmT0C+RHmFyv1a
 T+PfwuRDjsS1mf6eG1iFdIkEAgiLTwcKvf4dMn29Eb+r0n5J7xOsy4sUzYFLOL0tIpW6
 zl5i1Yu9kqWwwLJ//r8b9rTfMih5Gcahl+kFspN1XcivxLHpEy9DgEEwCvEvAUe4qXOt
 133NkjRqOZpoU0xVVoBMasn7BDIk2S+1aw0qlg+Ixj3gK6wuFVq6zDKi9PIyOSyPC+40
 vC2g==
X-Gm-Message-State: AOAM532z2rr+Vn7ytIxeXltBNw/w0TMhhCJM2GdGvwwIcldJCLxDkedP
 +Sk5cjly8qtfS7vf/cVYPUkMaQ==
X-Google-Smtp-Source: ABdhPJzOWyc8Pvadx49Ee/35c2nAd0fx2I6BYBB/uPQmPmfxvU91rDKrP/pDCl0S3WQY+HgfvpjXsQ==
X-Received: by 2002:a5d:604b:: with SMTP id j11mr483272wrt.193.1589392302566; 
 Wed, 13 May 2020 10:51:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r9sm19625722wmg.47.2020.05.13.10.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 10:51:39 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5078A1FF91;
 Wed, 13 May 2020 18:51:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 05/10] exec/cpu-all: Use bool for have_guest_base
Date: Wed, 13 May 2020 18:51:29 +0100
Message-Id: <20200513175134.19619-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513175134.19619-1-alex.bennee@linaro.org>
References: <20200513175134.19619-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/exec/cpu-all.h | 2 +-
 bsd-user/main.c        | 4 ++--
 linux-user/main.c      | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 43ddcf024c6..0895a57881a 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -159,7 +159,7 @@ static inline void tswap64s(uint64_t *s)
  * This allows the guest address space to be offset to a convenient location.
  */
 extern unsigned long guest_base;
-extern int have_guest_base;
+extern bool have_guest_base;
 extern unsigned long reserved_va;
 
 #if HOST_LONG_BITS <= TARGET_VIRT_ADDR_SPACE_BITS
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 28f122b80e6..0bfe46cff93 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -42,7 +42,7 @@
 int singlestep;
 unsigned long mmap_min_addr;
 unsigned long guest_base;
-int have_guest_base;
+bool have_guest_base;
 unsigned long reserved_va;
 
 static const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
@@ -828,7 +828,7 @@ int main(int argc, char **argv)
             }
         } else if (!strcmp(r, "B")) {
            guest_base = strtol(argv[optind++], NULL, 0);
-           have_guest_base = 1;
+           have_guest_base = true;
         } else if (!strcmp(r, "drop-ld-preload")) {
             (void) envlist_unsetenv(envlist, "LD_PRELOAD");
         } else if (!strcmp(r, "bsd")) {
diff --git a/linux-user/main.c b/linux-user/main.c
index e18c1fb9523..3597e99bb10 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -59,7 +59,7 @@ static const char *cpu_type;
 static const char *seed_optarg;
 unsigned long mmap_min_addr;
 unsigned long guest_base;
-int have_guest_base;
+bool have_guest_base;
 
 /*
  * Used to implement backwards-compatibility for the `-strace`, and
@@ -334,7 +334,7 @@ static void handle_arg_cpu(const char *arg)
 static void handle_arg_guest_base(const char *arg)
 {
     guest_base = strtol(arg, NULL, 0);
-    have_guest_base = 1;
+    have_guest_base = true;
 }
 
 static void handle_arg_reserved_va(const char *arg)
-- 
2.20.1


