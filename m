Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E90C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A84320866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WyzpWnIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A84320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36225 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLhTO-0007iq-EE
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:08:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRM-0006Mf-Hf
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRJ-0002qF-GM
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:56 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRJ-0002pw-Au
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:53 -0400
Received: by mail-pg1-x541.google.com with SMTP id i21so4414707pgi.12
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=jMr4oVpt08WI1vYqrX0gvWFc/UY/0FSsdcwMQYw/C7U=;
	b=WyzpWnIkM6OoVIcEy9MNoYvfc4GGBMTeDDMHf8BmCxFcNXkJJMjcJNGvBjuWh5oCFT
	NlUyXMWNcWA9BFwbcS9Ls4wq1ceJk+gU8Cu5PzlaxzPoxsNrSJDVAlVFCPctq7ogusb5
	71HXXHUyzGN3geHqn5gr32APhh28mIg+e15QsZWt1fuPm8GOMArjp28+EgjqvVeJ9erJ
	40oANmDEWP7u25UzmNo2pu+SqO5zBG8RAifyTtZA9h+CzydmohSo5NKnfdDfr1aMz5PU
	x/aARQBhFU4C88ZAEZ7cux7CuSXhwL3ILFB2Y0ieFA/waDGA03Ztp3GsP+BQl1fld86d
	mnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=jMr4oVpt08WI1vYqrX0gvWFc/UY/0FSsdcwMQYw/C7U=;
	b=Vh++sISGmZbO4OgsEX+7vj53zWMoDWfIrc+LOc2UBzoG9Ba8OCmoHx3RSOH1vN3zgH
	c/JIC2JSscHS6qpcx+UdNk1IQbORN3fwZ9EAJqJTn17caod6pBzGbPudNvaIuprgFE1B
	PGEnzpKFAfZWoaHme82sXv53S5LzEvrvLCZPw2QknbYJbwPX3/qC7rI3gixrYrxqD8np
	0gGQbJvbAO2C530Vn24hP3Neru9nHjAtzWap9E992+4ii6RlgI4fbP3Uy1Jd/JRQwsAh
	dGGwAlBJYV8VlNlvY1Nh1g0fzhaGQqAbSQGdEP08w8/jzXijpXJ3E1YF/C6SSM9aPjwQ
	Grjg==
X-Gm-Message-State: APjAAAU3xoTiCMtzTNcXuMYNY4m/N6slbPJtcaGqSKB63vFOqckQ22dW
	RZPIpCW7iCfvbkANaHUpv891TcvU5nY=
X-Google-Smtp-Source: APXvYqwuTnvnBlACEbatQcqLauDhuC6ge3qZ2tuacJIMb/fD2KP40zbq3ExtDokU4GzriGuxUZUEhg==
X-Received: by 2002:a63:6ac1:: with SMTP id f184mr73578421pgc.25.1556687152067;
	Tue, 30 Apr 2019 22:05:52 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.05.51 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:05:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 22:05:14 -0700
Message-Id: <20190501050536.15580-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v2 07/29] tcg: Support cross-class moves
 without instruction support
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501050514.fOTkpdFMJqGq4uoTNdZdc7db-MsIPVuRYdO02dtj9FI@z>

PowerPC Altivec does not support direct moves between vector registers
and general registers.  So when tcg_out_mov fails, we can use the
backing memory for the temporary to perform the move.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 8ed7cb8654..68d86361e2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3368,7 +3368,20 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
                                          ots->indirect_base);
             }
             if (!tcg_out_mov(s, otype, ots->reg, ts->reg)) {
-                abort();
+                /*
+                 * Cross register class move not supported.
+                 * Store the source register into the destination slot
+                 * and leave the destination temp as TEMP_VAL_MEM.
+                 */
+                assert(!ots->fixed_reg);
+                if (!ts->mem_allocated) {
+                    temp_allocate_frame(s, ots);
+                }
+                tcg_out_st(s, ts->type, ts->reg,
+                           ots->mem_base->reg, ots->mem_offset);
+                ots->mem_coherent = 1;
+                temp_free_or_dead(s, ots, -1);
+                return;
             }
         }
         ots->val_type = TEMP_VAL_REG;
@@ -3470,7 +3483,13 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             reg = tcg_reg_alloc(s, arg_ct->u.regs, i_allocated_regs,
                                 o_preferred_regs, ts->indirect_base);
             if (!tcg_out_mov(s, ts->type, reg, ts->reg)) {
-                abort();
+                /*
+                 * Cross register class move not supported.  Sync the
+                 * temp back to its slot and load from there.
+                 */
+                temp_sync(s, ts, i_allocated_regs, 0, 0);
+                tcg_out_ld(s, ts->type, reg,
+                           ts->mem_base->reg, ts->mem_offset);
             }
         }
         new_args[i] = reg;
@@ -3631,7 +3650,13 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
                 if (ts->reg != reg) {
                     tcg_reg_free(s, reg, allocated_regs);
                     if (!tcg_out_mov(s, ts->type, reg, ts->reg)) {
-                        abort();
+                        /*
+                         * Cross register class move not supported.  Sync the
+                         * temp back to its slot and load from there.
+                         */
+                        temp_sync(s, ts, allocated_regs, 0, 0);
+                        tcg_out_ld(s, ts->type, reg,
+                                   ts->mem_base->reg, ts->mem_offset);
                     }
                 }
             } else {
-- 
2.17.1


