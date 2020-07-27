Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48017C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 115FB2074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJ5LGBBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115FB2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02FB-0005r9-Bb
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02At-00075N-D4
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02Ar-0006Qx-IW
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:11 -0400
Received: by mail-wr1-x441.google.com with SMTP id a14so14694294wra.5
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 05:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=376gksLE0t2X1o47gQBQYWuWEK67vP0MVufWmCqpGJE=;
 b=pJ5LGBBmooA25MiX7uQOM2uAseNIGPbCjcRpIe3XrAAc8OQgw/6Kvh31AlzcMpUotr
 qTcnjS3UZUmfNdcwj1ZLhxfIqUiBKQTXjrEKbbIBllz3qFxIvjDQ5GTKVwfgFq9Ej3lF
 ckVj4JDbA3xhHZospNZFTGa2m4N9Icx54mSxVdjLICdHkxf7OJuFtc+1HIWcLkoEpanc
 EBg2Bfz4cZiT8mszclI6Se6qAenSkeznH5R7qI/8CfIu2ygbHsHg4hSWaSCpAA/vQOnR
 b8tsH5NrresCklGtwBt2Y14Yb1f4TTKE2SPxyjd6Bbmp+oTeSZdEYiJDtcxgor+YhuIF
 NW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=376gksLE0t2X1o47gQBQYWuWEK67vP0MVufWmCqpGJE=;
 b=oZ98ORQsZcCJ6+KSE0D1HddVWY48bQJnCjeACdW2ZbtywVpDIzZpqGuBY1BzVMJHo0
 LOV6hYNqmXGB2kB3MlH1US5T+xLdaCY+hQkAJEbmqTlWsEczNng7KkRZL8t/GnkfIXMD
 3xPQEBtuUKqZQFcAh6cK+vniA3vqKKjykGD2+t0rp+gN8mXSI3UMyE8N2QWUIYr5XILP
 1Xby/6Gh/88y0rwm9GQsDetMDfidMLLQo8ue3zOWVmjmMwRQ+PYXZ2QqBeSBjwZqPsFc
 40qlxTI2jDVBu007BZ/xZ7L7hBT+uXrmt2PfZuMy478ruQskMoBJBT94TraBNz/IBc6G
 p2rQ==
X-Gm-Message-State: AOAM530rdxqC7XSvH6xYf8nPPjdr9DjJtZWsKrNO2f3dDYehnNux51uL
 w5mqJyDOrH7KBnOfSbx+5erI2A==
X-Google-Smtp-Source: ABdhPJzVvYsbG26G9MtzkryvkyqBz6s8Mst+OApfrb98hxmyWXHTtu9hcOAA5uDH/wDPgyJDVi8WEA==
X-Received: by 2002:a5d:5710:: with SMTP id a16mr12623788wrv.217.1595852648232; 
 Mon, 27 Jul 2020 05:24:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x204sm22274048wmg.2.2020.07.27.05.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 05:24:03 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2735F1FF96;
 Mon, 27 Jul 2020 13:23:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 08/16] linux-user: don't use MAP_FIXED in pgd_find_hole_fallback
Date: Mon, 27 Jul 2020 13:23:49 +0100
Message-Id: <20200727122357.31263-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727122357.31263-1-alex.bennee@linaro.org>
References: <20200727122357.31263-1-alex.bennee@linaro.org>
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Plain MAP_FIXED has the undesirable behaviour of splatting exiting
maps so we don't actually achieve what we want when looking for gaps.
We should be using MAP_FIXED_NOREPLACE. As this isn't always available
we need to potentially check the returned address to see if the kernel
gave us what we asked for.

Fixes: ad592e37dfc ("linux-user: provide fallback pgd_find_hole for bare chroots")
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200724064509.331-9-alex.bennee@linaro.org>

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 0b1298b3c91..20872e793e4 100644
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


