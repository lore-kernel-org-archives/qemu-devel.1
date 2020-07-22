Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD89FC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:32:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8559420658
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jHGaLKEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8559420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy8IQ-0003nB-Lj
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 02:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8Fh-0007En-UE
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36725)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jy8Fg-0006vP-9V
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:29:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id 88so715718wrh.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 23:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YyRiXDgTkbk33Yj3Xqp8uu/l6zlWxTYX8kOGxgasWGE=;
 b=jHGaLKEyDYe70D+qWIBzD+FLQaBI6I2AZlS522As0ycmm35vNXAu4YP3OrrC0/OSnO
 jL9AHuw9OWDgz35ej7VDgJWrYRzZOu494xI5SLTR2dLamPSVoPy2MraCRC1eO4KtakoO
 0+gEFSpADy2LsZRgGduuI2XexBmhi/VrJwcnZFj9uTB5dRGFc6caZoCvHnUWMoTvyVCJ
 oExAibYGuXM5iWllE/SLkyu3ovU+6umVeIFz+iYR+tWiTLm6rAY0tozhH0gnSVcvkn6k
 5Z+mHCdLkObzAB5JSc4Z1fjcsNsj5Nel9KsWmGC8tP5No9kKth2U38QxqCMmzb1tWqh5
 za+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YyRiXDgTkbk33Yj3Xqp8uu/l6zlWxTYX8kOGxgasWGE=;
 b=Mw9/YQEbfLcPwai0B9hbqZgSINfGhOt2hDUlTeM6n0SoDKz/BnIFO0jA2QHp3W0w/h
 KXXCwwAB3dXqbQK3djTrJUuqXrkuSd7yM+1UcsHQfxgG46RqhWuSr1PC4s3/WAUIr58v
 YywNl19SlB8edn1MXvYv1GWDc5zfZBeC4jZODSSrYYPqsm0PrZVwhS42FVY9oADgDj5I
 Bkktpm6MgcvsUlFXzsf/TV1tAQx9gkTzzfsUEyNRe/fr/KDvrZRk6GxnUWJnTET/UYUK
 pU8jUMJyEJMNzaMIHjwvT6iOoqWuOwsyqTFEEGW95usz/tYtWobBcwy7pjJR56fBo4Ok
 ppPA==
X-Gm-Message-State: AOAM533LfMBl+3hYQOE1SUl4uVntXl5xIqZSUoDA9pWXkojQOYrqUpL8
 UDMN7WGycKw5e3oS3v6Iwva0xA==
X-Google-Smtp-Source: ABdhPJymAhrJDly9rOLg5dmifucr+R+YPDYCgh55zwc9+zrR3TQrN5/+poVBOdTJruIckc9Ofb2nNg==
X-Received: by 2002:a5d:608f:: with SMTP id w15mr28140898wrt.136.1595399354945; 
 Tue, 21 Jul 2020 23:29:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j6sm40145422wro.25.2020.07.21.23.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 23:29:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BA8101FF96;
 Wed, 22 Jul 2020 07:29:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/12] linux-user: don't use MAP_FIXED in
 pgd_find_hole_fallback
Date: Wed, 22 Jul 2020 07:28:58 +0100
Message-Id: <20200722062902.24509-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200722062902.24509-1-alex.bennee@linaro.org>
References: <20200722062902.24509-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Laurent Vivier <laurent@vivier.eu>, cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Plain MAP_FIXED has the undesirable behaviour of splatting exiting
maps so we don't actually achieve what we want when looking for gaps.
We should be using MAP_FIXED_NOREPLACE. As this isn't always available
we need to potentially check the returned address to see if the kernel
gave us what we asked for.

Fixes: ad592e3
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/osdep.h |  3 +++
 linux-user/elfload.c | 10 ++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index e44547fb33e..4f8b95619ef 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -173,6 +173,9 @@ extern int daemon(int, int);
 #ifndef MAP_ANONYMOUS
 #define MAP_ANONYMOUS MAP_ANON
 #endif
+#ifndef MAP_FIXED_NOREPLACE
+#define MAP_FIXED_NOREPLACE 0
+#endif
 #ifndef ENOMEDIUM
 #define ENOMEDIUM ENODEV
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 7e7f642332d..fe9dfe795dd 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2134,12 +2134,15 @@ static uintptr_t pgd_find_hole_fallback(uintptr_t guest_size, uintptr_t brk,
             /* we have run out of space */
             return -1;
         } else {
-            int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE | MAP_FIXED;
+            int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE |
+                MAP_FIXED_NOREPLACE;
             void * mmap_start = mmap((void *) align_start, guest_size,
                                      PROT_NONE, flags, -1, 0);
             if (mmap_start != MAP_FAILED) {
                 munmap((void *) align_start, guest_size);
-                return (uintptr_t) mmap_start + offset;
+                if (MAP_FIXED_NOREPLACE || mmap_start == (void *) align_start) {
+                    return (uintptr_t) mmap_start + offset;
+                }
             }
             base += qemu_host_page_size;
         }
@@ -2307,9 +2310,8 @@ static void pgb_reserved_va(const char *image_name, abi_ulong guest_loaddr,
     /* Widen the "image" to the entire reserved address space. */
     pgb_static(image_name, 0, reserved_va, align);
 
-#ifdef MAP_FIXED_NOREPLACE
+    /* osdep.h defines this as 0 if it's missing */
     flags |= MAP_FIXED_NOREPLACE;
-#endif
 
     /* Reserve the memory on the host. */
     assert(guest_base != 0);
-- 
2.20.1


