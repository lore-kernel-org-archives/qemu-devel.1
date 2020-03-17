Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC76C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD6020674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXoB5wxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD6020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEHU4-0000Q0-S8
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 15:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jEHRr-0007Bv-DI
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:00:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jEHRq-00046G-66
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:00:19 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:36486)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jEHRp-000408-VK
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:00:18 -0400
Received: by mail-pl1-x636.google.com with SMTP id g2so7512203plo.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 12:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wcSaDLPBm27zUZG4KbOwcxrAEQmHL3Xru2iiSqgStcQ=;
 b=NXoB5wxBCgZQNc7gAazD6xA7pEoA0CDon+/SeDGlPyIzjkKl8NQ41rg0YXOsUmrv9n
 3q/zZ32ZYTnmqou0M0Nn5vDpXqZJ19jyH1eGg0K4k0cn7U+px7/Twq8m1wBVzQUYcE4D
 21PgKbgLlymNQLLD9h2eppDpzz0IAqpssGeI5ELD3qQSSQEzfLxirhxsyE86SdijhLE9
 rWv0etWYXw46agSPG5SCqRJyqQIwmbsj3jZXg+xRxzfvKQRzy+dgshReLUlWcF0DePLi
 8j0eStbBs+cOPEDjn+Oqz8GP9RT9IP/cF3u1P2/PQgRDrrulpYIPX6Bq0eli97z4RXU3
 ksfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wcSaDLPBm27zUZG4KbOwcxrAEQmHL3Xru2iiSqgStcQ=;
 b=HWmO2Ywqg4NkimM6SgdUwHH8ukI5UJQ8P/7gcrJDGMrOCndmpatYpoTKi5l5twFdnH
 xng6h2JAlcBJKj85aFj6aRMUPaoIA7fB7xjGNJNfg16P3ErlO+foJjTA51VdEi283bg2
 qaBDi6KglzdjHuLAamWOCTbQ2dyyu2bVHK6N1rnZPedeawe0t6G/koXqd/F8MuJCGBVK
 BXlEiqnissnaKRUgns2S34q9xz4wAMAe0DHdR5AgviR2r4uRMfwnt3jl1FL4sadg1JXm
 JFLAqr21ebEsYnYLzXVnafuovWYdqRQUQ+M903vPllj8x9PbbJRZ6DbHqoV9FM3UubyK
 b0Uw==
X-Gm-Message-State: ANhLgQ0HwQoU51gIvYwvUuw95yJUraqtqDt7kc7pPMh2QYkOYaCAJgA9
 t5uqNmlfBTKoLOzACWuOgkms7nVkqjM=
X-Google-Smtp-Source: ADFU+vtssH8Gu45wIj1dihNU+Ce8hTsrippWP9u0aYjZpPS85LxEB95ej/cdA6+p7FYHE3oX9a8yIw==
X-Received: by 2002:a17:902:444:: with SMTP id 62mr88213ple.109.1584471616598; 
 Tue, 17 Mar 2020 12:00:16 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id y13sm3738411pfp.88.2020.03.17.12.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 12:00:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] tcg/i386: Bound shift count expanding sari_vec
Date: Tue, 17 Mar 2020 12:00:09 -0700
Message-Id: <20200317190013.25036-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317190013.25036-1-richard.henderson@linaro.org>
References: <20200317190013.25036-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::636
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A given RISU testcase for SVE can produce

tcg-op-vec.c:511: do_shifti: Assertion `i >= 0 && i < (8 << vece)' failed.

because expand_vec_sari gave a shift count of 32 to a MO_32
vector shift.

In 44f1441dbe1, we changed from direct expansion of vector opcodes
to re-use of the tcg expanders.  So while the comment correctly notes
that the hw will handle such a shift count, we now have to take our
own sanity checks into account.  Which is easy in this particular case.

Fixes: 44f1441dbe1
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index cdedcb2b25..223dba9c8c 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -3391,12 +3391,15 @@ static void expand_vec_sari(TCGType type, unsigned vece,
 
     case MO_64:
         if (imm <= 32) {
-            /* We can emulate a small sign extend by performing an arithmetic
+            /*
+             * We can emulate a small sign extend by performing an arithmetic
              * 32-bit shift and overwriting the high half of a 64-bit logical
-             * shift (note that the ISA says shift of 32 is valid).
+             * shift.  Note that the ISA says shift of 32 is valid, but TCG
+             * does not, so we have to bound the smaller shift -- we get the
+             * same result in the high half either way.
              */
             t1 = tcg_temp_new_vec(type);
-            tcg_gen_sari_vec(MO_32, t1, v1, imm);
+            tcg_gen_sari_vec(MO_32, t1, v1, MIN(imm, 31));
             tcg_gen_shri_vec(MO_64, v0, v1, imm);
             vec_gen_4(INDEX_op_x86_blend_vec, type, MO_32,
                       tcgv_vec_arg(v0), tcgv_vec_arg(v0),
-- 
2.20.1


