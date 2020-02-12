Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07782C3F68F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F7920714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCL+tnsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F7920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1v5r-0004up-St
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1v4z-0003DZ-J2
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1v4y-0001cv-Hh
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:37 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:34583)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j1v4y-0001bp-Bz
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:36 -0500
Received: by mail-wr1-x42a.google.com with SMTP id n10so1246279wrm.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 08:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CWJvAvx0dchzpGCPANbmzUz7ah1bBr5dRqjSpIoNg1Q=;
 b=hCL+tnsLmT+AXe6cFASvJyq49VQuOT+HhdcGF/IDzpSys96fGMg9cwwXd+meWrHIWn
 UGomxzzRyJInJEVQUcgIhDFBr3naI/BnMrlXL9nfkYUGe7fqrb/GWQvfESoDZNr442/d
 gLnrXOrz6Cj+ihdiTYlf57XfYg09U9Ux/qEdpjGD78g+H4TWDgp1LpaHleNBD4y5LMZY
 D/k4Qf9P0C6m+LlT7PY7kyZjuYa5GFiEi8IJ6kGEFgO2znhoVMGlYEgB8+7GJWMAqmse
 G9RZtvMrYY+lB27owQ2ON8cYfe3Bog3t7CjAL+2MLWUUYZGz65ZfsN5qlk5Jm5mK4wrS
 Y6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CWJvAvx0dchzpGCPANbmzUz7ah1bBr5dRqjSpIoNg1Q=;
 b=RDYL6XSpH79HcLR8Mw4027APcz1A3dx+ns5yF6peBykj5HS4idLApLzPfsbVoji1XW
 LEgW1r+g0uKskF7ONvigPGEAr8clHklDSN2t7Wc5lNxbEglWLkrl5zqK4JqUt0OF7FLS
 lHd+UqVSMVtwZkar1R7VX/J2NZojOgvMeGJLuEjl7LD47/DV/4iztNkxqMWJPtC9figM
 m4QY+ZAJCU4zLKCnDwLQ/bvAlLxeFftEFX/ILSLQlRCNOKh24OBG0cjFVDjJVT0EXM9C
 bfqa4/xUvhEXie+fB51Cz2hn9sF/mRjfyojrf+yjCRSW6kxpR9YTN8T+8JxFLP/waAwV
 YE+Q==
X-Gm-Message-State: APjAAAV0ufCm5B39gSa5NY9f9WEvN3/u5zoW/rxJGdPqO8aA83RG/ahb
 AQ66L7BCeGdvvJ/Knn/GhdCuyD4S
X-Google-Smtp-Source: APXvYqylJOEOG4noTE7X1DesW0JAviLRllHXiugDWYnLVCvxPvjnXZLCgbXeksCEcjz0wtyicls5bQ==
X-Received: by 2002:adf:f302:: with SMTP id i2mr16087362wro.21.1581525695112; 
 Wed, 12 Feb 2020 08:41:35 -0800 (PST)
Received: from donizetti.fritz.box ([151.30.86.140])
 by smtp.gmail.com with ESMTPSA id a16sm1195122wrt.30.2020.02.12.08.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 08:41:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/9] Remove support for CLOCK_MONOTONIC not being defined
Date: Wed, 12 Feb 2020 17:41:23 +0100
Message-Id: <20200212164129.6968-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200212164129.6968-1-pbonzini@redhat.com>
References: <20200212164129.6968-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Some older parts of QEMU's codebase assume that CLOCK_MONOTONIC
might not be defined by the host OS, and have workarounds to
deal with this. However, more recently (notably in commit
50290c002c045280f8d for qemu-img in mid-2019, but also much
earlier in 2011 in commit 22795174a37e0 for ui/spice-display.c)
we've written code that assumes CLOCK_MONOTONIC is always
defined. The only host OS anybody's ever noticed this on
is OSX 10.11 and earlier, which we don't support.

So we can assume that all our host OSes have the #define,
and we can remove some now-unnecessary ifdefs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200201172252.6605-1-peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/timer.h     |  5 +----
 util/qemu-timer-common.c | 11 ++++-------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 85bc6eb00b..6a8b48b5a9 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -838,14 +838,11 @@ extern int use_rt_clock;
 
 static inline int64_t get_clock(void)
 {
-#ifdef CLOCK_MONOTONIC
     if (use_rt_clock) {
         struct timespec ts;
         clock_gettime(CLOCK_MONOTONIC, &ts);
         return ts.tv_sec * 1000000000LL + ts.tv_nsec;
-    } else
-#endif
-    {
+    } else {
         /* XXX: using gettimeofday leads to problems if the date
            changes, so it should be avoided. */
         return get_clock_realtime();
diff --git a/util/qemu-timer-common.c b/util/qemu-timer-common.c
index 06d084d364..baf3317f74 100644
--- a/util/qemu-timer-common.c
+++ b/util/qemu-timer-common.c
@@ -49,14 +49,11 @@ int use_rt_clock;
 
 static void __attribute__((constructor)) init_get_clock(void)
 {
+    struct timespec ts;
+
     use_rt_clock = 0;
-#ifdef CLOCK_MONOTONIC
-    {
-        struct timespec ts;
-        if (clock_gettime(CLOCK_MONOTONIC, &ts) == 0) {
-            use_rt_clock = 1;
-        }
+    if (clock_gettime(CLOCK_MONOTONIC, &ts) == 0) {
+        use_rt_clock = 1;
     }
-#endif
 }
 #endif
-- 
2.21.0



