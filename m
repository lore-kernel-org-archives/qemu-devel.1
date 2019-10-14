Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17924ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1E2217D9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRktgzp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1E2217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3KT-0001Mj-ON
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qL-0004XV-1D
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qJ-0007j2-S3
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45257)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qJ-0007i2-Lm
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:07 -0400
Received: by mail-wr1-x444.google.com with SMTP id r5so20332055wrm.12
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Y5VQqjurmSOPO5D0mi4+9crSz45jTLCKyLfSh1xje4c=;
 b=GRktgzp3izxBf3fPcIzVVB9HTrZftHVXMc9R2ISWAAu1CmDhl8aM6f/SSHEo/ywAAx
 T/NVUFbhpCNJ3N8BxWmIebmY/9xO4KKblb6QgeccWVjNkelkfbKjwdHRbLe1E9v8rsKH
 3/E9t78baapQUDRH21lGLMYNmQYbolm2sBIDHybgM9locm8L2Zs02QQGFzBW6qFdJ5DQ
 XeeiyKdGugtQcGRYqiz86j9GBhQ5Ts2mTV4zDWGvxo1yBUeG6e3UESI1UCJ7LRiOIQap
 Ec+WG9wIsfNLt2pLqZWSeF0GFn47frrswBNYvOuJjcL+VxIgMpznmfDZ9Y0hcjsTDpri
 zByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y5VQqjurmSOPO5D0mi4+9crSz45jTLCKyLfSh1xje4c=;
 b=CRUZut7pyeRLJijyIJwEup9+KQpDLO6oHNfrv2LKguSsHlKDgest6EE0es65GttBjn
 NTME9sjRa022sE8PUmps2SLvtSlLIBEhVPbUHObMBzDBqxprTKVAwTSpJda9UhuLenn4
 p0taXlurSHx1Nd/p/e1JIZNiY4iCS0JaZkKqrK3xnJma3MBbpOpRsBsYJ0vbBJd3SztW
 RRAX6zSE/lCYbU3sZyc3TGKonHlnZcpsBkYtKcTaspTpb4BriE3mQx0KzY6wbzRMmvV+
 SKAw/Juiaw5AyRWaLC9D34Dqfx+g7b2X4iFcAzuWQdnr5GLOeT0o2FWxv6kWh/JSevWj
 1cZQ==
X-Gm-Message-State: APjAAAUehtSmx1ElQqAezfJwtIXfKE+bnq5shM7ArNr6dLWMItoEvmBy
 LXRw5u6XQAXIWCWnQgw8kHo+kwwPDHT8QQ==
X-Google-Smtp-Source: APXvYqwl+7A5jV2X0LyfT0t7RFgOmPxjr1qAYRjAPRR9zrQLP7YpC00UI2DpE/6RvwRWSp0jJlqWdQ==
X-Received: by 2002:adf:e688:: with SMTP id r8mr28620319wrm.342.1571069106020; 
 Mon, 14 Oct 2019 09:05:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/68] target/arm/arm-semi: Factor out implementation of
 SYS_ISTTY
Date: Mon, 14 Oct 2019 17:03:30 +0100
Message-Id: <20191014160404.19553-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

Factor out the implementation of SYS_ISTTY via the new function
tables.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190916141544.17540-11-peter.maydell@linaro.org
---
 target/arm/arm-semi.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 958083a105c..ecd51338fd3 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -388,6 +388,7 @@ typedef uint32_t sys_writefn(ARMCPU *cpu, GuestFD *gf,
                              target_ulong buf, uint32_t len);
 typedef uint32_t sys_readfn(ARMCPU *cpu, GuestFD *gf,
                             target_ulong buf, uint32_t len);
+typedef uint32_t sys_isattyfn(ARMCPU *cpu, GuestFD *gf);
 
 static uint32_t host_closefn(ARMCPU *cpu, GuestFD *gf)
 {
@@ -436,6 +437,11 @@ static uint32_t host_readfn(ARMCPU *cpu, GuestFD *gf,
     return len - ret;
 }
 
+static uint32_t host_isattyfn(ARMCPU *cpu, GuestFD *gf)
+{
+    return isatty(gf->hostfd);
+}
+
 static uint32_t gdb_closefn(ARMCPU *cpu, GuestFD *gf)
 {
     return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
@@ -457,10 +463,16 @@ static uint32_t gdb_readfn(ARMCPU *cpu, GuestFD *gf,
                            gf->hostfd, buf, len);
 }
 
+static uint32_t gdb_isattyfn(ARMCPU *cpu, GuestFD *gf)
+{
+    return arm_gdb_syscall(cpu, arm_semi_cb, "isatty,%x", gf->hostfd);
+}
+
 typedef struct GuestFDFunctions {
     sys_closefn *closefn;
     sys_writefn *writefn;
     sys_readfn *readfn;
+    sys_isattyfn *isattyfn;
 } GuestFDFunctions;
 
 static const GuestFDFunctions guestfd_fns[] = {
@@ -468,11 +480,13 @@ static const GuestFDFunctions guestfd_fns[] = {
         .closefn = host_closefn,
         .writefn = host_writefn,
         .readfn = host_readfn,
+        .isattyfn = host_isattyfn,
     },
     [GuestFDGDB] = {
         .closefn = gdb_closefn,
         .writefn = gdb_writefn,
         .readfn = gdb_readfn,
+        .isattyfn = gdb_isattyfn,
     },
 };
 
@@ -631,11 +645,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return set_swi_errno(env, -1);
         }
 
-        if (use_gdb_syscalls()) {
-            return arm_gdb_syscall(cpu, arm_semi_cb, "isatty,%x", gf->hostfd);
-        } else {
-            return isatty(gf->hostfd);
-        }
+        return guestfd_fns[gf->type].isattyfn(cpu, gf);
     case TARGET_SYS_SEEK:
         GET_ARG(0);
         GET_ARG(1);
-- 
2.20.1


