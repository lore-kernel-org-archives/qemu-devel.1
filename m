Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAE3C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 465602083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465602083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgv4E-0005r2-J2
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54628)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hguka-0008JH-Um
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgukW-0000G6-60
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgukV-0008VM-Rh
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so3319055pff.8
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=nCqKF3oInYRXPwJWI7RpGGCzJlHRvb4E4bj4yY7JdO8=;
 b=PAzVKVQAnFykGAC8X+bosAE9p1mfmRflAlTigU9uAoAK2K8Gue+krUkaE0Lgr1EctK
 MeQKUB94YNEGo+k1nQmHh5lVz3Q6ooSTzNWWgQV+DNm88EeHmzNDmut1SpdjXkPHklfY
 YRy12cRRnq7THd9xc+2oFKYjd+fbCHJTMQdhAox7FHf246At3T85f+fCGZlv60Rd+dTQ
 e95gZ2GTpMAqEpqr6nJ94KMLK4oZwujyAYJO+WDOo1HYH66QIEazq0C66kFekzvLBUJz
 W21dvl+dyY7uxGlXVnTuk20wdxvjpK45nFyYpzewN1VgaxIQRsIFYJZo0MvZ28H+nBpq
 WLqA==
X-Gm-Message-State: APjAAAU80L59AZ3nw2PIznIZ7zjixuc/NWVoneUDvZK4VyeEEhev+Xxk
 EjeM5tKxRK4K9SoiIDfU1mOLzqGfgukamQyl
X-Google-Smtp-Source: APXvYqzgzJFIpQlqKh088wUJ+eQ8NK73bPGYsVO4ItnZRvBG2zWyfBsDucC6zbo4Jzqk54fO8jWk+g==
X-Received: by 2002:a17:90a:30aa:: with SMTP id
 h39mr14627606pjb.32.1561743185398; 
 Fri, 28 Jun 2019 10:33:05 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id g8sm2783839pfi.8.2019.06.28.10.33.04
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 10:33:04 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:32:02 -0700
Message-Id: <20190628173227.31925-10-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628173227.31925-1-palmer@sifive.com>
References: <20190628173227.31925-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.196
Subject: [Qemu-devel] [PULL 09/34] RISC-V: Fix a PMP bug where it succeeds
 even if PMP entry is off
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>

The current implementation returns 1 (PMP check success) if the address is in
range even if the PMP entry is off. This is a bug.

For example, if there is a PMP check in S-Mode which is in range, but its PMP
entry is off, this will succeed, which it should not.

The patch fixes this bug by only checking the PMP permissions if the address is
in range and its corresponding PMP entry it not off. Otherwise, it will keep
the ret = -1 which will be checked and handled correctly at the end of the
function.

Signed-off-by: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/pmp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 5944f4cb6607..958c7502a0e0 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -258,11 +258,12 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
         /* fully inside */
         const uint8_t a_field =
             pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
-        if ((s + e) == 2) {
-            if (PMP_AMATCH_OFF == a_field) {
-                return 1;
-            }
 
+        /*
+         * If the PMP entry is not off and the address is in range, do the priv
+         * check
+         */
+        if (((s + e) == 2) && (PMP_AMATCH_OFF != a_field)) {
             allowed_privs = PMP_READ | PMP_WRITE | PMP_EXEC;
             if ((mode != PRV_M) || pmp_is_locked(env, i)) {
                 allowed_privs &= env->pmp_state.pmp[i].cfg_reg;
-- 
2.21.0


