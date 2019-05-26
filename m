Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FD0C07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:30:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330802075E
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330802075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49098 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUhzS-0005Ae-AZ
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:30:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxB-0003HK-LH
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhgQ-0006Vy-Li
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhgP-0006Uw-Jd
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so5626143plm.6
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=A46qd+Lun1Jqp2LnJV4/8L0u1a2QnjICpRUQ7yaJbfA=;
	b=tqd3iChUPr1PWszWMyZ1ddLN9OI9xXfVeW9rAT4Wi45hoimNweb35LC0cS+dJ1213l
	GiO2SmfKO2986oCPWKkePlJ75C/zpREcWl9tvUs68A+kRGI59R0l+af4CeEAKSyegvnu
	ESYZQuNjx/vLBr2Lw+GPBEywKRfLHHRke+KrI8qEaSOaCw0IAhQvUHb/q/MbV38zBAS1
	3ujtN7Pky7ZzrzWWtf1o0ove45/HMXsH+e6B1xZY3iTDG8+E0vIxD84yhYgalCL19ZQe
	2aG40y6Xw6nDGFkSCkLsjbx4VdEGao5c6pt/Go8eun4g9+qdV33csUSQLtIgTSkIvXm7
	0J3Q==
X-Gm-Message-State: APjAAAWLfosC5ZWzLJJ0ML6LgJmBSqa7wfvkIaNtnDdxJYYK9ZQMoEb6
	i2+dHb0BzuDK6N9/SABM+Yb6dA==
X-Google-Smtp-Source: APXvYqzaNy5hjqks01TxmcWVh9IxZfM7eBnQf8DhxI0B6Ypgf3FLewhzsozAtYWXl2GyT+ahZVq7qQ==
X-Received: by 2002:a17:902:8ec4:: with SMTP id
	x4mr16380382plo.249.1558833039887; 
	Sat, 25 May 2019 18:10:39 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	p16sm6813182pff.35.2019.05.25.18.10.38
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:38 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:47 -0700
Message-Id: <20190526010948.3923-29-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.214.193
Subject: [Qemu-devel] [PULL 28/29] target/riscv: More accurate handling of
 `sip` CSR
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jonathan Behrens <jonathan@fintelia.io>, Palmer Dabbelt <palmer@sifive.com>,
	qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jonathan Behrens <jonathan@fintelia.io>

According to the spec, "All bits besides SSIP, USIP, and UEIP in the sip
register are read-only." Further, if an interrupt is not delegated to mode x,
then "the corresponding bits in xip [...] should appear to be hardwired to
zero. This patch implements both of those requirements.

Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/csr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e6d68a99560d..0f51c7eae241 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -237,6 +237,7 @@ static const target_ulong sstatus_v1_9_mask = SSTATUS_SIE | SSTATUS_SPIE |
 static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
     SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
     SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD;
+static const target_ulong sip_writable_mask = SIP_SSIP | MIP_USIP | MIP_UEIP;
 
 #if defined(TARGET_RISCV32)
 static const char valid_vm_1_09[16] = {
@@ -682,8 +683,10 @@ static int write_sbadaddr(CPURISCVState *env, int csrno, target_ulong val)
 static int rmw_sip(CPURISCVState *env, int csrno, target_ulong *ret_value,
                    target_ulong new_value, target_ulong write_mask)
 {
-    return rmw_mip(env, CSR_MSTATUS, ret_value, new_value,
-                   write_mask & env->mideleg);
+    int ret = rmw_mip(env, CSR_MSTATUS, ret_value, new_value,
+                      write_mask & env->mideleg & sip_writable_mask);
+    *ret_value &= env->mideleg;
+    return ret;
 }
 
 /* Supervisor Protection and Translation */
-- 
2.21.0


