Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A56C282E2
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F13421855
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jDXjecbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F13421855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38158 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkdW-0006BY-5x
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:42:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWU-0008NH-VX
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWU-0007iN-0L
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:54 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWT-0007gn-Qr
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:53 -0400
Received: by mail-pl1-x642.google.com with SMTP id o7so1289443pll.13
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=+m09nvTdIxOMcWt67/JzzqfApcaXJMaZOV8+XsA1b8w=;
	b=jDXjecbufA8HCLc4BVGrGoN6GM1C/2OHWdaiV7aLES35e77AWrQWx7HZoK/ljV26P+
	MBItbZtC+DszK3EgMQVElXCt9wnm/2TTEwAGgmRPS0wR5XYqItCQQygdHUIcitPH9hYL
	Pl6H4teYjzmKOYt52DE9gbH4DoraxRMIWhj9GkVnmGrJD8pKYLrA7GL25yvkPzmSNBHF
	R3D0isHI+q45sK0ZuZReA7LsdWkTopdNSaqwZkjgVLhw9PSENfAv/pll2n/VcRocUWts
	V746gSHcVEHa5CYdrNlPGBc5zci8MzpAkbEO3ME3/2+80iFXniebtJ0Mgu64L6LrZcI9
	mYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=+m09nvTdIxOMcWt67/JzzqfApcaXJMaZOV8+XsA1b8w=;
	b=HHuCHiKeIqdBcVbNFchj2aNi8ZobHz1hxR3bMwXjr5AV7/nRplkt+zB/0M333acop5
	7euSbMjGlDkz/qbDPqB5bItwxE6ZpzIKfAaMoKjCN6+RJA+6aIebLd53YENVQLWcQUHD
	F6o6UPTRuLLrdcQjtVfhlznEiRA8s1dDZnmtx1HLCNS/I90XDRooVEqLNQL+PyGAtoTX
	69dllwObpeDVRTPS06nVekP6V/vMRdFFqOJ4lyw5CsHpl6FOuux7ukpbkGCDhZFE29Fa
	csAr3nOiANbwmo9d5Ms1RgA1N5XH1jxptmVbNKYOQpZIAk9H9s2Zuy46mC4JE6ZLqLYH
	GvXA==
X-Gm-Message-State: APjAAAWKxEnwf95bZugS0pN7W3SFW7t7huCWZe0ZqfW6PqJoRbqff1ap
	5XLW/tru80ts6HqTRsqaEUoVgtXhIyA=
X-Google-Smtp-Source: APXvYqwgICDAbAmi47nvRWVwTybzOeZH3KuzJSXS/Pd4M5xXCafuPz5OOQAZ0yk9/rQiiVvF7DMBjw==
X-Received: by 2002:a17:902:b617:: with SMTP id
	b23mr7833382pls.73.1555745692591; 
	Sat, 20 Apr 2019 00:34:52 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.34.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:34:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:08 -1000
Message-Id: <20190420073442.7488-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH 04/38] tcg: Support cross-class moves without
 instruction support
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073408.wrXwIFzBqAag6ZATBpI3rmDj9uMaqnYeDuSjFFFIGDM@z>

PowerPC Altivec does not support direct moves between vector registers
and general registers.  So when tcg_out_mov fails, we can use the
backing memory for the temporary to perform the move.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index b083faacd2..d3dcfe3dca 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3373,7 +3373,18 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
                                          ots->indirect_base);
             }
             if (!tcg_out_mov(s, otype, ots->reg, ts->reg)) {
-                abort();
+                /* Cross register class move not supported.
+                   Store the source register into the destination slot
+                   and leave the destination temp as TEMP_VAL_MEM.  */
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
@@ -3475,7 +3486,11 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             reg = tcg_reg_alloc(s, arg_ct->u.regs, i_allocated_regs,
                                 o_preferred_regs, ts->indirect_base);
             if (!tcg_out_mov(s, ts->type, reg, ts->reg)) {
-                abort();
+                /* Cross register class move not supported.  Sync the
+                   temp back to its slot and load from there.  */
+                temp_sync(s, ts, i_allocated_regs, 0, 0);
+                tcg_out_ld(s, ts->type, reg,
+                           ts->mem_base->reg, ts->mem_offset);
             }
         }
         new_args[i] = reg;
@@ -3634,7 +3649,11 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
                 if (ts->reg != reg) {
                     tcg_reg_free(s, reg, allocated_regs);
                     if (!tcg_out_mov(s, ts->type, reg, ts->reg)) {
-                        abort();
+                        /* Cross register class move not supported.  Sync the
+                           temp back to its slot and load from there.  */
+                        temp_sync(s, ts, allocated_regs, 0, 0);
+                        tcg_out_ld(s, ts->type, reg,
+                                   ts->mem_base->reg, ts->mem_offset);
                     }
                 }
             } else {
-- 
2.17.1


