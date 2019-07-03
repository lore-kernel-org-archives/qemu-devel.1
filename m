Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB76C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0422C20645
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0422C20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiazQ-00078L-9c
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 04:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51271)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hiapU-0005kj-4n
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hiapT-0006g8-3P
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43014)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hiapS-0006dc-T3
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id j29so1141008lfk.10
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=nCqKF3oInYRXPwJWI7RpGGCzJlHRvb4E4bj4yY7JdO8=;
 b=Xa1BcQEpV9Ql3U6hLuhxUVoQY1nI5IYKOoeePWukrzhEmRMGmjNgkpqTYk1DbHX9rd
 x2fLXOWNgZd9fWq2Ik05YIX98AjoQxcLMPkGs5DXbUmumnvwNNh0DXVZfcBP9yt/4XOl
 b0JGJeC5rzZRA4jzxD7B6FocW6aIk44Eq4FDG/bSW7jOYjBiVaWnQ0Y1VtyhSO5ngbNK
 m4Ywe6eZqYpDgkt2wtuOHl4/EHARmm+IHow7xoxwkqkBrnYvvkxhpMEbFWaepnnlkIlM
 IbxY26rPCtJFzahK+GUe2AuE2yge2On+ORMkWGZ14Oa5gTCdThyuSvqERLGMeVwlkc4J
 E9cQ==
X-Gm-Message-State: APjAAAXcsefPmkIAP9qWtbNJAJ1gmTOWVWcDJ117SX6dLc2zgqbFyivN
 o23wGxxcyJocjaawoEKAsDIP1or7vPiWUg==
X-Google-Smtp-Source: APXvYqyRU+zxSbZ41d5AKVMigjLA1PkS/hfi3yA30k/5GJhvpUBBAVNbkLahl9xbuY42wTrnpEJuKQ==
X-Received: by 2002:a19:9111:: with SMTP id t17mr3361466lfd.113.1562143285062; 
 Wed, 03 Jul 2019 01:41:25 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id w8sm291009lfq.62.2019.07.03.01.41.24
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:41:24 -0700 (PDT)
Date: Wed,  3 Jul 2019 01:40:25 -0700
Message-Id: <20190703084048.6980-10-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703084048.6980-1-palmer@sifive.com>
References: <20190703084048.6980-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.65
Subject: [Qemu-devel] [PULL 09/32] RISC-V: Fix a PMP bug where it succeeds
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


