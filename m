Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD01BC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 19:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B27224EE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 19:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fT2RtDL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B27224EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF1P6-00030a-Cc
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 15:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iF1MX-0001Wo-GC
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 15:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iF1MV-00068A-Hr
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 15:29:37 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38541)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iF1MV-00067I-6j
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 15:29:35 -0400
Received: by mail-pf1-x444.google.com with SMTP id h195so6160105pfe.5
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 12:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=6VIxvhctHYn2HNudFB87sMQ9fY/awxBLo6cIK/aR/R0=;
 b=fT2RtDL7jzboIO3JgHW4S0G208NT1qzYITZ/YwugSaaVD++lkNGVrJqhWpZh7qFaf4
 4GeFA8TEdT7/8aPigXGqVKBs9abeC9LLyEWnyjKKrRIl7gx6cuzNwH0IfSeWFT0y/Jow
 iBx3dKLWg+tPntXMpqs7FXPXwlR89zYAqG/ePLTKUIg6sSA86lVfT0NCahZ9+zzK0vEp
 iPZklwOjkzFSrbTKSRjsJGQprv9jniSQLsnA8L7gPBNRL4A4cPRKDri0iUwOs/jElSaM
 kN8mvn8AWo4S7DxHBc2VbnTuq9n2wURRVDDCMcvRBtLbzZ7qAUzwZIy+RgLd30cK2IRJ
 1/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=6VIxvhctHYn2HNudFB87sMQ9fY/awxBLo6cIK/aR/R0=;
 b=EHYpZXh6D16dL+c4PsDnZHqF9LrseM+utdGYiZWrqUsMVQIuDohSfOv/UISMTS4USj
 ic4hW6pDQNeeGFddhgAOl06zr8IvkEs+cihg2G2N6cG3HtgoHvr0k0CA8vv0yhD5Adut
 TgQciLUw3Jh10ybSlSLDDy9dZ7gfsTSWb1YuKoOwa01AsmFtgKkRCG89D0+XTohXz4bA
 tnJy8wVL+awgrBsZ4FkDUScbp9NOjrz0DOjIYvIEsvg7N8Bla1isl+X4o6aXVblB1eqY
 AHjv/jKuRYH67r3i0Gl0ilv9mIt80U+hTUlxa4BZVVhkP0cPH7pAXzBVhVF0hK7dsmEt
 9GqA==
X-Gm-Message-State: APjAAAU0L7V111duJF65ARkcOmj4Wj+kUku4FAAsqlDJAIOm1likUUg9
 DNdYTz+1DDLZ3pBQyReRe+zn1O0LWkw=
X-Google-Smtp-Source: APXvYqyoAw48T/NaiPe3NQQXH8BzZtGtW8vH7vMZ8ivxJ6Iqf19Op3rIHmPdhcIcoEjt3zqqIvFnTg==
X-Received: by 2002:aa7:81d3:: with SMTP id c19mr23340598pfn.85.1569871773196; 
 Mon, 30 Sep 2019 12:29:33 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id l189sm18330145pgd.46.2019.09.30.12.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 12:29:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] user-exec: Do not filter the signal on si_code
Date: Mon, 30 Sep 2019 12:29:31 -0700
Message-Id: <20190930192931.20509-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: laurent@vivier.eu, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a workaround for a ppc64le host kernel bug.

For the test case linux-test, we have an instruction trace

IN: sig_alarm
...

IN:
0x400080ed28:  380000ac  li       r0, 0xac
0x400080ed2c:  44000002  sc

IN: __libc_nanosleep
0x1003bb4c:  7c0802a6  mflr     r0
0x1003bb50:  f8010010  std      r0, 0x10(r1)

Our signal return trampoline has, rightly, changed the guest
stack page read-only.  Which, rightly, faults on the store of
a return address into a stack frame.

Checking the host /proc/pid/maps, we see the expected state:

4000800000-4000810000 r--p 00000000 00:00 0

However, the host kernel has supplied si_code == SEGV_MAPERR,
which is obviously incorrect.

By dropping this check, we may have an extra walk of the page
tables, but this should be inexpensive.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

FWIW, filed as

  https://bugzilla.redhat.com/show_bug.cgi?id=1757189

out of habit and then

  https://bugs.centos.org/view.php?id=16499

when I remembered that the system is running Centos not RHEL.

---
 accel/tcg/user-exec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 71c4bf6477..31ef091a70 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -143,9 +143,12 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
      * for some other kind of fault that should really be passed to the
      * guest, we'd end up in an infinite loop of retrying the faulting
      * access.
+     *
+     * XXX: At least one host kernel, ppc64le w/Centos 7 4.14.0-115.6.1,
+     * incorrectly reports SEGV_MAPERR for a STDX write to a read-only page.
+     * Therefore, do not test info->si_code.
      */
-    if (is_write && info->si_signo == SIGSEGV && info->si_code == SEGV_ACCERR &&
-        h2g_valid(address)) {
+    if (is_write && info->si_signo == SIGSEGV && h2g_valid(address)) {
         switch (page_unprotect(h2g(address), pc)) {
         case 0:
             /* Fault not caused by a page marked unwritable to protect
-- 
2.17.1


