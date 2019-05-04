Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB20C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 05:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373C220675
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 05:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2h62x35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373C220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51656 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMngG-0002ka-Fo
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 01:57:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbn-0007jo-5Y
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbm-0004BK-4H
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:15 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnbl-0004Ay-Uc
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:14 -0400
Received: by mail-pl1-x644.google.com with SMTP id bi2so3708742plb.13
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=jMr4oVpt08WI1vYqrX0gvWFc/UY/0FSsdcwMQYw/C7U=;
	b=c2h62x35D0tEWBi2wiev0uihBeIGg8XZ+w/BZ1QRezzO7FksJClkwfZqzWhUG0GAEG
	t2lSdH9/XP/lN0IRV1HvMC1+QA8bJD7yE88NWJ9eonmTqyOcUY4qKjBCSe4VD64LrYms
	POAb9MxSB4HXGKZAHWlGYtQ+RwRCNNrflpa0uw9yK83FjPg0eid97z2c8xlTvxj8cGDB
	xcVl0+So2ghcTP5dpMj6uaUNsqNZsed0LPI89+HhsB+Mg5Eh0lFYt7BYYN0jMVtRnG0y
	7CpDPq7+3AVAWsXUZt+Ii4MI1PWsvGYJD1mgnzzbtp6JmRlfKqS6xZ1QTpd2nBt2/PsG
	FxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=jMr4oVpt08WI1vYqrX0gvWFc/UY/0FSsdcwMQYw/C7U=;
	b=pARQgvDlVTp4JHppqeH4L75z2T1rR5wchNKxyNVAvQKm5s6g8yk72zxoJr7SF8rcq2
	1CeETSERyqMLLQzAfXCtR2VfIQXWxUBaib/jenUAvpGtTUDrwcH9Mn/rN9yzEBMj12FM
	gxcXCRHAUvmKLPcDfJEujmHTS4OkYV60I9+DYyfJdnaFTPRY6QmDtSLNCUDyWrTISaPd
	v0mCvRlTfb0CvJxuR2TSlsOw1aQTmfam6S61OfgwkuMtjSQC9q2vxK22KGeaNNb//sK3
	7ghZXT66MP1a75hTRSyz5Er1GdfNZDPyw8BtKCvZOEEdPpXzAwZ4EWrFerIIBthh5Z0x
	cu+g==
X-Gm-Message-State: APjAAAV+8WNRESp72Ds4bsgfJk1MY3KZtMnWtJ67pirGQRxjlhG1vkY+
	uRdQpma6wcgeBA+VCeJ3KnJQ2kcYayM=
X-Google-Smtp-Source: APXvYqwqOShI7Ak9xrxfANm6sPEq+RWwpCihVPvjBI+XNCFhvfnUkfbJ8nCvGOsJLbhp8dgvyHojmg==
X-Received: by 2002:a17:902:820c:: with SMTP id
	x12mr15656378pln.199.1556949192547; 
	Fri, 03 May 2019 22:53:12 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:37 -0700
Message-Id: <20190504055300.18426-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v3 08/31] tcg: Support cross-class moves
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
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504055237.IW3wpq1KrdJNc1_bWMfqDeHWBg-YD8pOc0YEe7tX9No@z>

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


