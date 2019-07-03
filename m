Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806B5C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A7620645
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A7620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiaxO-00043U-Hv
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 04:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51115)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hiapJ-0005HC-4d
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hiapH-0006ED-Rd
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39307)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hiapH-0006Bp-Ix
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id v18so1469195ljh.6
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=TZ7LklPK8UvVtDwbEWjV8Myyoa+ER/F09z/DtS5QZ9Q=;
 b=qWOWBG2cl69Un14fuzPjriTR9EcL4LBRrbbebcUZfyHDDQT4RwgWAE4sxpmEnYmncy
 3lqZYSwC/2jXrnVF+NC80OC++xai/yxSzrfJN7Zl9lLD1vcvIDwswGjXHelAL7fHqWl1
 CmIMJ7Y/qGTfdidzFGX824iqDxOYmBexNzFzZqsGIvTd3EWU5A51IXEvuJrnEnBIJHGj
 +2HRUDwQQowQPwdZiFcIpmb2R2z3Y/e0hCK4itd4FRofVmJZg/4Gs6HSkbOvp3tLzd4D
 EiNnJCxsU+cNNZWjxGlcY/est0Z+ftQBja2MlaT8LPINSAwgZOEMJircPJ2MESbkNpR2
 H9nQ==
X-Gm-Message-State: APjAAAU06SQ4oRORowY8TYpAdA1FpgWxvPtAb8EdK7ZiqyX0LmqaP/l8
 YT5fh+g+b9gkNmm8xn5JrQzyqnsx0yguVw==
X-Google-Smtp-Source: APXvYqzktnSmwseN5NP8Lnu343kymcH1R7z28pqLm1HdYbLw4LmYVYvWKhkLDgIBrToVxqUxG7ZpZw==
X-Received: by 2002:a2e:12dc:: with SMTP id 89mr20693838ljs.40.1562143273831; 
 Wed, 03 Jul 2019 01:41:13 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id 11sm340283ljc.66.2019.07.03.01.41.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:41:13 -0700 (PDT)
Date: Wed,  3 Jul 2019 01:40:19 -0700
Message-Id: <20190703084048.6980-4-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703084048.6980-1-palmer@sifive.com>
References: <20190703084048.6980-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.194
Subject: [Qemu-devel] [PULL 03/32] target/riscv: Fix PMP range boundary
 address bug
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
Cc: qemu-riscv@nongnu.org, Dayeol Lee <dayeol@berkeley.edu>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 Michael Clark <mjc@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dayeol Lee <dayeol@berkeley.edu>

A wrong address is passed to `pmp_is_in_range` while checking if a
memory access is within a PMP range.
Since the ending address of the pmp range (i.e., pmp_state.addr[i].ea)
is set to the last address in the range (i.e., pmp base + pmp size - 1),
memory accesses containg the last address in the range will always fail.

For example, assume that a PMP range is 4KB from 0x87654000 such that
the last address within the range is 0x87654fff.
1-byte access to 0x87654fff should be considered to be fully inside the
PMP range.
However the access now fails and complains partial inclusion because
pmp_is_in_range(env, i, addr + size) returns 0 whereas
pmp_is_in_range(env, i, addr) returns 1.

Signed-off-by: Dayeol Lee <dayeol@berkeley.edu>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/pmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index fed1c3c0301b..e0fe2064074a 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -245,7 +245,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
          from low to high */
     for (i = 0; i < MAX_RISCV_PMPS; i++) {
         s = pmp_is_in_range(env, i, addr);
-        e = pmp_is_in_range(env, i, addr + size);
+        e = pmp_is_in_range(env, i, addr + size - 1);
 
         /* partially inside */
         if ((s + e) == 1) {
-- 
2.21.0


