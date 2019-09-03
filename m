Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7CEC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:00:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18E9722CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4QFAkZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E9722CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BE3-00010A-PJ
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5Are-0003B2-0q
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5Arc-000668-IE
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:37:01 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5Arc-00065U-BR
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:37:00 -0400
Received: by mail-wr1-x443.google.com with SMTP id h7so16669879wrt.13
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ajJo8M0JKSN4/WIzHMm40PvDhk2VCRR0BAjSpMU/81k=;
 b=P4QFAkZQ0uPKN9bmnYswYYaDaeqzSk3Kd6jvJn7CT+qdusrc1gJxROdlmQITrBdLma
 S+pewE9V4UF4QfRPzghDME6hBwVf6/se0pOWMcpQfDvttaZUExuPk79DgrUBXZt3BOna
 C+n5iXtcS7jK9kzrr+W2dwBG1B3iT01lfZvSFMMz7GjWG4Ezvr1n02ECuYgeHtNZaBMc
 rOlK3H0XLGII0EpKnLZtAlhyE18qgcV5O9AILyZfKxEa/hdqcNjuusQJGsnA+5rhPXHf
 D7qUbqRX+nFf0kpZckGlRFKudms75YmjvU1/pEfPo0L8PpaM/xLlWFkutJERp/JeIhQ5
 IcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ajJo8M0JKSN4/WIzHMm40PvDhk2VCRR0BAjSpMU/81k=;
 b=cfYpRKZzBIBQWe7DsEssCnZNgpWQNxa5mpy+9OBUPZbVy/38s+9fHxYfaVHKg181Xf
 59IzRdO/iWcsGN3yLC9aD2by3q9HX9x4oIsqK18kqc82MGTPhdMSa6/V6i4R+cVeD5aZ
 2tTczPVAJNOf9HzTXPqqY5Hq33lnIAcCsfdSokdFCkfHIrWYZM6afRKrFlDWb8pV59HH
 JvMPfK8ebzzHGMm4BMzDqmwsaVlBcsigwfTVNi2UjrP7KRNn5m/TqlVjc+Gu7dh+crvw
 DivAZpIjebyQwkwgnBG+Tp64ts31q8UTYvmOlAKZzf+I5s5+mgpfiW2+AMZwUApC2h8X
 JWOg==
X-Gm-Message-State: APjAAAUfb5mhTx87qKh+XYOiMIydC5FBeQlI/1SUDjskj3LeI2cWQzTv
 8RRYNqHL4/+dRGgYUi+HpDEPk9Dtu9gdLg==
X-Google-Smtp-Source: APXvYqxxpHq0YVSRLmNmMQh1+Fs3gEcwzmEU65xBoVMiSBtxJGqUzk0xEx4O3tOmymtgroue2D70sg==
X-Received: by 2002:adf:eec5:: with SMTP id a5mr43743729wrp.352.1567525019151; 
 Tue, 03 Sep 2019 08:36:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a18sm24435188wrt.18.2019.09.03.08.36.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 08:36:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:36:33 +0100
Message-Id: <20190903153633.6651-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903153633.6651-1-peter.maydell@linaro.org>
References: <20190903153633.6651-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PULL 21/21] target/arm: Don't abort on M-profile
 exception return in linux-user mode
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

An attempt to do an exception-return (branch to one of the magic
addresses) in linux-user mode for M-profile should behave like
a normal branch, because linux-user mode is always going to be
in 'handler' mode. This used to work, but we broke it when we added
support for the M-profile security extension in commit d02a8698d7ae2bfed.

In that commit we allowed even handler-mode calls to magic return
values to be checked for and dealt with by causing an
EXCP_EXCEPTION_EXIT exception to be taken, because this is
needed for the FNC_RETURN return-from-non-secure-function-call
handling. For system mode we added a check in do_v7m_exception_exit()
to make any spurious calls from Handler mode behave correctly, but
forgot that linux-user mode would also be affected.

How an attempted return-from-non-secure-function-call in linux-user
mode should be handled is not clear -- on real hardware it would
result in return to secure code (not to the Linux kernel) which
could then handle the error in any way it chose. For QEMU we take
the simple approach of treating this erroneous return the same way
it would be handled on a CPU without the security extensions --
treat it as a normal branch.

The upshot of all this is that for linux-user mode we should never
do any of the bx_excret magic, so the code change is simple.

This ought to be a weird corner case that only affects broken guest
code (because Linux user processes should never be attempting to do
exception returns or NS function returns), except that the code that
assigns addresses in RAM for the process and stack in our linux-user
code does not attempt to avoid this magic address range, so
legitimate code attempting to return to a trampoline routine on the
stack can fall into this case. This change fixes those programs,
but we should also look at restricting the range of memory we
use for M-profile linux-user guests to the area that would be
real RAM in hardware.

Cc: qemu-stable@nongnu.org
Reported-by: Christophe Lyon <christophe.lyon@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190822131534.16602-1-peter.maydell@linaro.org
Fixes: https://bugs.launchpad.net/qemu/+bug/1840922
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index cfebd35d268..615859e23c5 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -915,10 +915,27 @@ static inline void gen_bx(DisasContext *s, TCGv_i32 var)
     store_cpu_field(var, thumb);
 }
 
-/* Set PC and Thumb state from var. var is marked as dead.
+/*
+ * Set PC and Thumb state from var. var is marked as dead.
  * For M-profile CPUs, include logic to detect exception-return
  * branches and handle them. This is needed for Thumb POP/LDM to PC, LDR to PC,
  * and BX reg, and no others, and happens only for code in Handler mode.
+ * The Security Extension also requires us to check for the FNC_RETURN
+ * which signals a function return from non-secure state; this can happen
+ * in both Handler and Thread mode.
+ * To avoid having to do multiple comparisons in inline generated code,
+ * we make the check we do here loose, so it will match for EXC_RETURN
+ * in Thread mode. For system emulation do_v7m_exception_exit() checks
+ * for these spurious cases and returns without doing anything (giving
+ * the same behaviour as for a branch to a non-magic address).
+ *
+ * In linux-user mode it is unclear what the right behaviour for an
+ * attempted FNC_RETURN should be, because in real hardware this will go
+ * directly to Secure code (ie not the Linux kernel) which will then treat
+ * the error in any way it chooses. For QEMU we opt to make the FNC_RETURN
+ * attempt behave the way it would on a CPU without the security extension,
+ * which is to say "like a normal branch". That means we can simply treat
+ * all branches as normal with no magic address behaviour.
  */
 static inline void gen_bx_excret(DisasContext *s, TCGv_i32 var)
 {
@@ -926,10 +943,12 @@ static inline void gen_bx_excret(DisasContext *s, TCGv_i32 var)
      * s->base.is_jmp that we need to do the rest of the work later.
      */
     gen_bx(s, var);
+#ifndef CONFIG_USER_ONLY
     if (arm_dc_feature(s, ARM_FEATURE_M_SECURITY) ||
         (s->v7m_handler_mode && arm_dc_feature(s, ARM_FEATURE_M))) {
         s->base.is_jmp = DISAS_BX_EXCRET;
     }
+#endif
 }
 
 static inline void gen_bx_excret_final_code(DisasContext *s)
-- 
2.20.1


