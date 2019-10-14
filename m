Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B30C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:31:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E0472089C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pWNsaieJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0472089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3Fj-00041v-Cd
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2q8-0004JO-HO
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2q7-0007VX-Bm
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:56 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:37686)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2q7-0007Un-5f
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:55 -0400
Received: by mail-wr1-x436.google.com with SMTP id p14so20380090wro.4
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=eSVt+eEc+RrJyKcS0K2MVccKihJyivwdaMosLyCjfLA=;
 b=pWNsaieJHXzyY/1CJuNQ3JczuJQQdW/vbtSK+/km143Sy/vDQ489rMDbUOtg1jYLdM
 /ESCNA47BdZ22UGHYVMieQcGTZr354b6PDIs3SUcKiuVl1Vss22swytLCBCPtVmcSTrp
 g0rSKwY94Vx6eVGZmmlRjRStACwdr+2tYbycYHGCyOT5i0UDtS2EBa2Ow3tJkz+9ZwVe
 951H4lHZ5czLIo1Q+cmsMEdINxHrcTq/3jLx0Cv/fUwSN5iUK7MaqV4xy4ftbiAno/r0
 +KW5K+go8O6hHFfdehwSn/05iBpXamqvGE6K/5/0e20rHiYaylM+WZZr/hHoNxBnEj1L
 korQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eSVt+eEc+RrJyKcS0K2MVccKihJyivwdaMosLyCjfLA=;
 b=a2eNY596sm8oZocBEdh6NeN0zkWYR4A4W1+60KRUcuzcNHqA1lWMJ2pFdH7F+e0udM
 0pwD0+uK2SNnPidnrM1LdhxwC2zVxclUuRQW/YV7pPZxjajDdBAdXJ+jHIiVj1Kw8AIJ
 TGVJrcllvfYPcYEJlMysw5V0ikDuPlVEK/7IL9DmWbrRhN8q1m6LdyA5FvebVo3atYKY
 9yWqM3RNKlx/Swn00/Zb9q4YHmvrbb7OUFg6Ss8wEHAAoacovKHBN2GDXXeG3DF26Qq0
 KQoAxh/k4SVpDUDWPmTAX2oyFZFbWr6/GX1k0HlrJ6ZgtM0QioIN+/goH+9XY4ZfA/KR
 WgMA==
X-Gm-Message-State: APjAAAXABh/9Bna1eneYjxDBMWLlMyqgX+zu10kIC1e3AvN7IjGGqQpm
 9AIRguxB1bd6dibydKzhTbaNHOWIyLEPMg==
X-Google-Smtp-Source: APXvYqwxkyH+2Xh4RBSCgm6/aYzkSB1GMqOE64nl9NeTyzlF7tJ6uV6IPQgctSoJl4aeKSNLq/VxdQ==
X-Received: by 2002:a5d:5052:: with SMTP id h18mr18759676wrt.143.1571069093935; 
 Mon, 14 Oct 2019 09:04:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/68] target/arm/arm-semi: Capture errno in softmmu version of
 set_swi_errno()
Date: Mon, 14 Oct 2019 17:03:21 +0100
Message-Id: <20191014160404.19553-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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

The set_swi_errno() function is called to capture the errno
from a host system call, so that we can return -1 from the
semihosting function and later allow the guest to get a more
specific error code with the SYS_ERRNO function. It comes in
two versions, one for user-only and one for softmmu. We forgot
to capture the errno in the softmmu version; fix the error.

(Semihosting calls directed to gdb are unaffected because
they go through a different code path that captures the
error return from the gdbstub call in arm_semi_cb() or
arm_semi_flen_cb().)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190916141544.17540-2-peter.maydell@linaro.org
---
 target/arm/arm-semi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 90423a35deb..03e60105c05 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -114,8 +114,13 @@ static inline uint32_t set_swi_errno(TaskState *ts, uint32_t code)
     return code;
 }
 #else
+static target_ulong syscall_err;
+
 static inline uint32_t set_swi_errno(CPUARMState *env, uint32_t code)
 {
+    if (code == (uint32_t)-1) {
+        syscall_err = errno;
+    }
     return code;
 }
 
@@ -124,10 +129,6 @@ static inline uint32_t set_swi_errno(CPUARMState *env, uint32_t code)
 
 static target_ulong arm_semi_syscall_len;
 
-#if !defined(CONFIG_USER_ONLY)
-static target_ulong syscall_err;
-#endif
-
 static void arm_semi_cb(CPUState *cs, target_ulong ret, target_ulong err)
 {
     ARMCPU *cpu = ARM_CPU(cs);
-- 
2.20.1


