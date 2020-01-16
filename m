Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CFCC33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 21:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50CAE20661
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 21:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kvM93qUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CAE20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isCOE-0006s6-RZ
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 16:09:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isCKk-0002Zi-1W
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 16:05:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isCKi-0007Wd-Sr
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 16:05:41 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44212)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isCKi-0007W2-Mu
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 16:05:40 -0500
Received: by mail-pg1-x541.google.com with SMTP id x7so10501289pgl.11
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 13:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mwvRgQcQ/nPioMHiLOS0giLq/Ty193xjRxMFlibh2LA=;
 b=kvM93qUhSTD/C6wdIOndRAjqp1apYqeI0UBTUvLHB6s64Jbq++WTZUTC5npi34KitU
 CYBr8SR3+Kq1WMGzO+o1DDNiARvOMq3uPKQGHv+fatcS8kR1pKzq+gblKxftDGcoaF5o
 aSkm4akUF5Nk+QDhoAlDhi+DFgPzTtmonj6dzPpv73ddsLUyRXFrUWbyKN9EeNMIpyWX
 cJKX8YZ1eQhSWrQyk/JI+xtU38le7VN7GhTwz+h1YNtp6jk/koraf90ZtqsWgJKlQSS1
 Npkn+Z9o+jhzny4c9dA5z9W9mwR0GMg1/d4xtpOokwIV9tsgQF+8xp9BDzOMgA6JnGTI
 hiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mwvRgQcQ/nPioMHiLOS0giLq/Ty193xjRxMFlibh2LA=;
 b=UTxvEaV5ENqvV+SK3q2nJUfCr9OxHOXtRx+9xInnLsizd6p357yZro55bxk3J7cXw4
 AzODXX7igJPkC3fNRPM0C4SrMmN3ygxU4AOaGYrc079UobRPGwRv35iil+dAYG1LpviV
 BjOYGmgGlPTRDHBDZufWG/wHLK28c4jKfQPik5/f6IRl+fDa7ohktuYtDpsnO2GxDDI8
 DTp3LAnZED3F/xk1DHDrtpKNMM+UqOMcg732z5aqkxL4rNnKZT5IFaOIpNhmoWb4F3IC
 HQ/ALM6dXWz/lZ0zn5Kgc3nJ1TbYKDdheZrzkQnQPtTn3QTkIUR8/gho2UwQugFLiDYd
 USgw==
X-Gm-Message-State: APjAAAVmYgpDrQs+sfsed0p4ZgqBr2esYyo5Z65i5KZ03FK2y66xhpfx
 HMmH9QFV+3nBp51LNT7hI63sviKD6aA=
X-Google-Smtp-Source: APXvYqxv3s9N0djwe4jul7S2IyGuxCQXEeQ661t6vEaLmXrPuWEnIyv6xEYOnRlAP8+D6lkPa3yJ4w==
X-Received: by 2002:a63:cf41:: with SMTP id b1mr41122897pgj.53.1579208739432; 
 Thu, 16 Jan 2020 13:05:39 -0800 (PST)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id k21sm25494907pgt.22.2020.01.16.13.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 13:05:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] vl: Only choose enabled accelerators in
 configure_accelerators
Date: Thu, 16 Jan 2020 11:05:28 -1000
Message-Id: <20200116210528.31953-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116210528.31953-1-richard.henderson@linaro.org>
References: <20200116210528.31953-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, aleksandar.m.mail@gmail.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By choosing "tcg:kvm" when kvm is not enabled, we generate
an incorrect warning: "invalid accelerator kvm".

At the same time, use g_str_has_suffix rather than open-coding
the same operation.

Presumably the inverse is also true with --disable-tcg.

Fixes: 28a0961757fc
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Use g_str_has_suffix (ajb)
---
 vl.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/vl.c b/vl.c
index 8ae8a5d241..40ac9c5544 100644
--- a/vl.c
+++ b/vl.c
@@ -2764,21 +2764,26 @@ static void configure_accelerators(const char *progname)
 
         if (accel == NULL) {
             /* Select the default accelerator */
-            if (!accel_find("tcg") && !accel_find("kvm")) {
-                error_report("No accelerator selected and"
-                             " no default accelerator available");
-                exit(1);
-            } else {
-                int pnlen = strlen(progname);
-                if (pnlen >= 3 && g_str_equal(&progname[pnlen - 3], "kvm")) {
+            bool have_tcg = accel_find("tcg");
+            bool have_kvm = accel_find("kvm");
+
+            if (have_tcg && have_kvm) {
+                if (g_str_has_suffix(progname, "kvm")) {
                     /* If the program name ends with "kvm", we prefer KVM */
                     accel = "kvm:tcg";
                 } else {
                     accel = "tcg:kvm";
                 }
+            } else if (have_kvm) {
+                accel = "kvm";
+            } else if (have_tcg) {
+                accel = "tcg";
+            } else {
+                error_report("No accelerator selected and"
+                             " no default accelerator available");
+                exit(1);
             }
         }
-
         accel_list = g_strsplit(accel, ":", 0);
 
         for (tmp = accel_list; *tmp; tmp++) {
-- 
2.20.1


