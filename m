Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B7CC10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 05:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED26920873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 05:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xP5KUi1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED26920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBtpG-00076J-36
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 01:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBtoU-0005kd-H4
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 01:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBtoT-0007Il-7G
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 01:21:50 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46257)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBtoS-0007G7-Uj
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 01:21:49 -0400
Received: by mail-pl1-x644.google.com with SMTP id w12so500068pll.13
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 22:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id;
 bh=hNUEbJfvomucF6BiwKE6lNUf29qT7mZn2g8flH0nQ3M=;
 b=xP5KUi1o/4+iZpMdMXzVUUNmLiGbBcOgAhPcpiKrleyqSXxYIxmm7qwjvCyNSeJVAd
 qoD53sXGhKrT+Gx7BzW+RemqnEC+8KWBaHX20px02idaHptnIApzJHfLkPj97VItDCda
 L3CzmUcUdVMsSwb0xozlYlxilh7ENLZkzzklZOs3X4+p82Zlah+FxLXpOJUG0hmAjKTk
 fBxcP/is7xxE6qATneLgLffTTA2/wLeGcZm958hLNTzfbO+3jM8WQfe4fG7q4k0OsA6l
 xh52oYgj67yZ4fs+la6Pj4bwlkLtNi1M/CKLiixIoN0lmeBLLiyPRfW5Blwx4ysYCOxc
 Ys5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=hNUEbJfvomucF6BiwKE6lNUf29qT7mZn2g8flH0nQ3M=;
 b=hiruJLgICBYmqm5LjxR3YHIrxQyqCFE8R5R59bmKqM7HQD8Zvg1z+KESYbiApJLPoh
 fmjObxCgcsQLRpQJ06jux5zF3rBuCbdrHdSKv5I9TtLeJpOCf2e0C7vsUH7rghLwsppE
 J41lOqGW8atq7ZjtKO/+/q3fDMYgAfUrJz+PhtCK5xkTxRGMvruTBwoKOxDWNC/r27Fj
 /7GvB9Dyo9FN+nR3XYEhwxsPYwPfXWq6D+NgbLvCbgl/WDZqHFDXeknLrbifJOuZn/ie
 PCdx4YoNu9oNRNW40J56IAzvGGAlCO6nXG7UOvzFClVgkMReUBICwhCohxQKC1YrVvr1
 lEIw==
X-Gm-Message-State: ANhLgQ0OysXT3a23quvQFVnY0YKH74VmKxmXxCsloPiYR5C1YG5rk9Mi
 j7LuvqDSYPsn9xCRJUTZT3z5JiTch90=
X-Google-Smtp-Source: ADFU+vssgWb0m6z1I2PuulYEwZ6AjbMiA/5PrwYUuFf0vlPdGh7pVTVqXb4+0p92avl//n50G7/UBw==
X-Received: by 2002:a17:90b:238e:: with SMTP id
 mr14mr1583249pjb.146.1583904107009; 
 Tue, 10 Mar 2020 22:21:47 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id w17sm7276332pfi.59.2020.03.10.22.21.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 22:21:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tcg/i386: Bound shift count expanding sari_vec
Date: Tue, 10 Mar 2020 22:21:45 -0700
Message-Id: <20200311052145.14004-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
2.17.1


