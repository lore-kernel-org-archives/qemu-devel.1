Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDD0ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EACD720854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cCVBuCvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACD720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3gC-0006Ag-Kh
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qM-0004Xh-0q
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qK-0007lI-Uk
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:09 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36795)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qK-0007jQ-OD
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:08 -0400
Received: by mail-wr1-x443.google.com with SMTP id y19so20401301wrd.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=DKGrYcoSwF8i1yBqgJnCMl96wMrcE5OTnAG0MbPbFs4=;
 b=cCVBuCvyzKFvmJen8qHaWR3HQPgJukXqNRhsWrKlMOlX2ik7s3pk1ymd7uTZPRhG47
 iGI0BUFLYmDHUfMuggQDAM8TvknhO4ZVc+5E8dNkx0QO/TFVJ5weX3XqIncSzFhzt6Gj
 oWsfWFrEtbYqmFL4lrqlyuBTVo38AXmqG+UbJGguEGgcLeWwV/TtfN6v8StHY2VTlpF3
 bSXSig9lPooSo9iGK4xhmWDM4MmCYym5yF7DB6nrhWUTyoYhrt8cYy5UhOflSmmzsbf6
 jFRYgj4CAq7l8PVN819mn+elQliVFS58JG+NTpQCIkn8OSJxUEB08Wue+QKFqd2Zbsv6
 zZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DKGrYcoSwF8i1yBqgJnCMl96wMrcE5OTnAG0MbPbFs4=;
 b=Cnpyt7k3LOt7995X+nFwG5endMqX1+01ZdD7EvTBIrzF69WftB01ihkDgzA2wln98y
 Jo5kl/tXeMn3NYQqMUlf61jgVcZ4R2Ll7W1fqVaEv11hBBPnR0jzalRXqa2q4/jxuX4c
 42RS0miNBpZw9fTH0ft6atILeBiNbQfvfuvjBOGoLiUoVbZ8Krlf0YX7TzIeIFvYx1HT
 cAcek4Jb6yn0TWEZnXN0hl/YPuFSEBvvoTRAr+6YbBMs2j6RqnKfI1MTSNXs4sJgL7Md
 F/L3iRA1tN8JW/gLYWYvb6y++c/3LXV0qvhrAfBtVHEE0klJT0p/Crg9XPFm5MDKRxDf
 qByw==
X-Gm-Message-State: APjAAAUpZyHSq2lP0TCWaPxwGCpyuloP9hgFh4UJpQF4t1JbVtp0H7z9
 dQgy9JsO/ufogwA1QGPZyfJt3KfpYKc6rg==
X-Google-Smtp-Source: APXvYqye90yfJh7XrHjgEHEp/CXuiCrurp+rWKBQHaCLcZc7twY2VB773T1YzGsoj2bSNwuSr88BGQ==
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr12604292wrj.283.1571069107427; 
 Mon, 14 Oct 2019 09:05:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/68] target/arm/arm-semi: Factor out implementation of
 SYS_SEEK
Date: Mon, 14 Oct 2019 17:03:31 +0100
Message-Id: <20191014160404.19553-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

Factor out the implementation of SYS_SEEK via the new function
tables.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190916141544.17540-12-peter.maydell@linaro.org
---
 target/arm/arm-semi.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index ecd51338fd3..b5e1d73eb80 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -389,6 +389,8 @@ typedef uint32_t sys_writefn(ARMCPU *cpu, GuestFD *gf,
 typedef uint32_t sys_readfn(ARMCPU *cpu, GuestFD *gf,
                             target_ulong buf, uint32_t len);
 typedef uint32_t sys_isattyfn(ARMCPU *cpu, GuestFD *gf);
+typedef uint32_t sys_seekfn(ARMCPU *cpu, GuestFD *gf,
+                            target_ulong offset);
 
 static uint32_t host_closefn(ARMCPU *cpu, GuestFD *gf)
 {
@@ -442,6 +444,16 @@ static uint32_t host_isattyfn(ARMCPU *cpu, GuestFD *gf)
     return isatty(gf->hostfd);
 }
 
+static uint32_t host_seekfn(ARMCPU *cpu, GuestFD *gf, target_ulong offset)
+{
+    CPUARMState *env = &cpu->env;
+    uint32_t ret = set_swi_errno(env, lseek(gf->hostfd, offset, SEEK_SET));
+    if (ret == (uint32_t)-1) {
+        return -1;
+    }
+    return 0;
+}
+
 static uint32_t gdb_closefn(ARMCPU *cpu, GuestFD *gf)
 {
     return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
@@ -468,11 +480,18 @@ static uint32_t gdb_isattyfn(ARMCPU *cpu, GuestFD *gf)
     return arm_gdb_syscall(cpu, arm_semi_cb, "isatty,%x", gf->hostfd);
 }
 
+static uint32_t gdb_seekfn(ARMCPU *cpu, GuestFD *gf, target_ulong offset)
+{
+    return arm_gdb_syscall(cpu, arm_semi_cb, "lseek,%x,%x,0",
+                           gf->hostfd, offset);
+}
+
 typedef struct GuestFDFunctions {
     sys_closefn *closefn;
     sys_writefn *writefn;
     sys_readfn *readfn;
     sys_isattyfn *isattyfn;
+    sys_seekfn *seekfn;
 } GuestFDFunctions;
 
 static const GuestFDFunctions guestfd_fns[] = {
@@ -481,12 +500,14 @@ static const GuestFDFunctions guestfd_fns[] = {
         .writefn = host_writefn,
         .readfn = host_readfn,
         .isattyfn = host_isattyfn,
+        .seekfn = host_seekfn,
     },
     [GuestFDGDB] = {
         .closefn = gdb_closefn,
         .writefn = gdb_writefn,
         .readfn = gdb_readfn,
         .isattyfn = gdb_isattyfn,
+        .seekfn = gdb_seekfn,
     },
 };
 
@@ -656,15 +677,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return set_swi_errno(env, -1);
         }
 
-        if (use_gdb_syscalls()) {
-            return arm_gdb_syscall(cpu, arm_semi_cb, "lseek,%x,%x,0",
-                                   gf->hostfd, arg1);
-        } else {
-            ret = set_swi_errno(env, lseek(gf->hostfd, arg1, SEEK_SET));
-            if (ret == (uint32_t)-1)
-              return -1;
-            return 0;
-        }
+        return guestfd_fns[gf->type].seekfn(cpu, gf, arg1);
     case TARGET_SYS_FLEN:
         GET_ARG(0);
 
-- 
2.20.1


