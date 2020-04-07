Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4351FC2D0EC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 19:10:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2B820748
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 19:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjNB9B+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2B820748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLtc1-0003w8-5G
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 15:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1jLtbP-0003XC-6I
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 15:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1jLtbO-0001hd-5I
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 15:09:39 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1jLtbO-0001hK-06
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 15:09:38 -0400
Received: by mail-pf1-x442.google.com with SMTP id n10so1239771pff.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 12:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pVPn1A8lH7D9dBMNrDxt3UTPqMe9uBm7OsqcSSTllH8=;
 b=mjNB9B+WwRhyEGpC7+CGl/PyCJb4aha1UpjFP8hdfqS+dZI0/c7+f2QLhSN9Fm1n8e
 KcJ+iAqJDtJQoTgHy4Foyc6XO8YvRP0YZqZhUpZOpFyRtzWKZ/O2kKdneNzJ8zE8CTdw
 LTfZxvMak2+sH5UIabsQ01maYh6pYRUCG63qYr9W5yH6qVTmCY78BOqve9s1WOrvohTV
 KM/alnkhMg6RZWkvnQGaDySNv66Yfu2W9XO8p7TmZwRN/tMt9/i9hVu51YMTLk/0ino/
 eG7ecx0/TJSwJ1sLF/YA3RdEBhgYLDYgqTjuFCvkDyFS+niXFad4Sedub1WLEnz20jok
 8cBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pVPn1A8lH7D9dBMNrDxt3UTPqMe9uBm7OsqcSSTllH8=;
 b=X+B8RfxFUTdXXFB/pm3TOxS94nKYd+UHn0g5SuSdHV/4aHwNQbIVI7e4Onxo2yEl/r
 z4UCUR6jypLqhKhIF0vwXQ8Ngf9GwUGA+m+61gygpd4s+LOSRTy4LbcMZ9yoq3MllUru
 CSzP2Mwkw1DFGWwr09Mri+2O7St8m+WlqNjipHeqWApowQGe/1V10gjemSOTRNSm0Xm0
 /5KC+aleWnz2XxLnfDe88X7peNuo4fYtGU6LU6jFHxOqhFqEHhNkhwc7V2EhHiEIvige
 Xl3SyqPkic1g4MCl3r+5/2N3nQ9uNTpz6Z/C7HRGi/rJ0bUDAIXoy8TJ7Cg/zzwq4T5X
 kVrQ==
X-Gm-Message-State: AGi0PuZBZNUzXuXXuaowa1sAvpU0+b6Wzi8HQ0RPdf4fV7EEspAVWwle
 Ji2N0fhYSnBTKdXoDc0ZZYrUXADYOg4=
X-Google-Smtp-Source: APiQypLhy7cdEvADN8ROf5hhUyWrkaVcmphBPZlSVVfastqPqd/aJYiktq55HfmS7tZ+wq7GXbLDOQ==
X-Received: by 2002:a63:af5c:: with SMTP id s28mr3445694pgo.21.1586286576530; 
 Tue, 07 Apr 2020 12:09:36 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:400:63f0:a487:3b8:7ffc:c9e4])
 by smtp.gmail.com with ESMTPSA id b3sm13852348pgs.69.2020.04.07.12.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 12:09:36 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/xtensa: statically allocate xtensa_insnbufs in
 DisasContext
Date: Tue,  7 Apr 2020 12:09:25 -0700
Message-Id: <20200407190925.4879-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than dynamically allocate, and risk failing to free
when we longjmp out of the translator, allocate the maximum
buffer size based on the maximum supported instruction length.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       |  3 +++
 target/xtensa/helper.c    |  1 +
 target/xtensa/translate.c | 17 ++---------------
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index c0d69fad96c5..7a46dccbe11b 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -213,6 +213,9 @@ enum {
 #define MEMCTL_IL0EN 0x1
 
 #define MAX_INSN_LENGTH 64
+#define MAX_INSNBUF_LENGTH \
+    ((MAX_INSN_LENGTH + sizeof(xtensa_insnbuf_word) - 1) / \
+     sizeof(xtensa_insnbuf_word))
 #define MAX_INSN_SLOTS 32
 #define MAX_OPCODE_ARGS 16
 #define MAX_NAREG 64
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 376a61f3397c..7073381f03b2 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -96,6 +96,7 @@ static void init_libisa(XtensaConfig *config)
 
     config->isa = xtensa_isa_init(config->isa_internal, NULL, NULL);
     assert(xtensa_isa_maxlength(config->isa) <= MAX_INSN_LENGTH);
+    assert(xtensa_insnbuf_size(config->isa) <= MAX_INSNBUF_LENGTH);
     opcodes = xtensa_isa_num_opcodes(config->isa);
     formats = xtensa_isa_num_formats(config->isa);
     regfiles = xtensa_isa_num_regfiles(config->isa);
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 37f65b1f0305..91c7776c2544 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -72,8 +72,8 @@ struct DisasContext {
     unsigned cpenable;
 
     uint32_t op_flags;
-    xtensa_insnbuf insnbuf;
-    xtensa_insnbuf slotbuf;
+    xtensa_insnbuf_word insnbuf[MAX_INSNBUF_LENGTH];
+    xtensa_insnbuf_word slotbuf[MAX_INSNBUF_LENGTH];
 };
 
 static TCGv_i32 cpu_pc;
@@ -1174,15 +1174,6 @@ static void xtensa_tr_init_disas_context(DisasContextBase *dcbase,
     dc->callinc = ((tb_flags & XTENSA_TBFLAG_CALLINC_MASK) >>
                    XTENSA_TBFLAG_CALLINC_SHIFT);
 
-    /*
-     * FIXME: This will leak when a failed instruction load or similar
-     * event causes us to longjump out of the translation loop and
-     * hence not clean-up in xtensa_tr_tb_stop
-     */
-    if (dc->config->isa) {
-        dc->insnbuf = xtensa_insnbuf_alloc(dc->config->isa);
-        dc->slotbuf = xtensa_insnbuf_alloc(dc->config->isa);
-    }
     init_sar_tracker(dc);
 }
 
@@ -1272,10 +1263,6 @@ static void xtensa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     reset_sar_tracker(dc);
-    if (dc->config->isa) {
-        xtensa_insnbuf_free(dc->config->isa, dc->insnbuf);
-        xtensa_insnbuf_free(dc->config->isa, dc->slotbuf);
-    }
     if (dc->icount) {
         tcg_temp_free(dc->next_icount);
     }
-- 
2.20.1


