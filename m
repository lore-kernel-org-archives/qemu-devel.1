Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1F2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470622072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r0XxkTEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470622072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxhQ-0004D4-F8
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWl-0003I1-07
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:15 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:55379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWj-00059p-TP
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:14 -0400
Received: by mail-pj1-x1042.google.com with SMTP id k7so4289825pjs.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d+UUwp78+6taEfLoHDVuHhWwS3335HTdwAKjJ5tb8QA=;
 b=r0XxkTEbcMCW0ZnPa0sMlqDv9tHIfFEg8RqPdRx1jDj5ttWO7sBThKtDd9vKrt2Whv
 isJ0v/9eZlZddUq4p5VIbz1APqMGJFsuZWepg29Iyxgdn/JB5hOoNhWAndrn0T2dHdky
 T66ifuDKiSKFXTGyEVk8ck1mTqOcbluWLJ7eN2PceTC31OxEHECLexmQePRHyXQlgFmh
 A4zze19ove2EDi5eFs8bwnuSr8rlkTo+3V1y1D4gPvBFW6rwIzu84McYiutmh+3sfGNX
 7hRCN2iIaui+Ljzkh4C56B2EH0JPRxiJswCfzl8UCg+GyQvxMJHRld6IOMZ5DCpiIG4F
 yYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d+UUwp78+6taEfLoHDVuHhWwS3335HTdwAKjJ5tb8QA=;
 b=gSHPa+7VjzfLCeX7Jy+1utzkpGm6opHdXoZBQksdSGBTPD9F4wtp7hf+DT9qFCFwUK
 zsXGGEgJnJ7mO4YCxRSed7p2gfx5j6pegE3I99pfmbE1eu3Vp72i0DM7ocP+oZ6BSv52
 LkTzXr73OpS23rGo8eB3LZEYQUI/LdhF4birALFVEEgf3AjmzNP/DoWTFNOMOwvWHrXf
 YCqeYL6r9h+CESGg4GZffih8UjdFKaMBjlO6wCROCJtzp9wii3P/vhuYcKhXQ4Yxfe85
 jL69iQHWWC+OJQUMHk7hnxAzCDUnPcNhqyERxDUglK4Ye4whsXH4719pMGqRBH7Cvpz8
 OJpg==
X-Gm-Message-State: AOAM531DP2GR59WR1iOiW0lBThibijXaLv4IyNYPnzYzW0CyYr2DqFFU
 yhBcbpA205zfFV0VyIM2AnNKaMBKYUQ=
X-Google-Smtp-Source: ABdhPJwvEoRjo7jc0b2csa2g68YVtYLlBldTEkS6j3kA74vOzU2StDFHqwaT/U9avF8TaYYUol130Q==
X-Received: by 2002:a17:902:8303:: with SMTP id
 bd3mr12775649plb.217.1590114912196; 
 Thu, 21 May 2020 19:35:12 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:35:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 24/25] Remove return value from reginfo_dump
Date: Thu, 21 May 2020 19:34:39 -0700
Message-Id: <20200522023440.26261-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No uses actually checked the error indication.  Even if we wanted
to check ferror on the stream, we should do that generically rather
than per arch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.h                 | 4 ++--
 risu_reginfo_aarch64.c | 8 +++-----
 risu_reginfo_arm.c     | 6 ++----
 risu_reginfo_i386.c    | 6 ++----
 risu_reginfo_m68k.c    | 6 ++----
 risu_reginfo_ppc64.c   | 6 ++----
 6 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/risu.h b/risu.h
index 99f0d8e..6eceb9f 100644
--- a/risu.h
+++ b/risu.h
@@ -120,8 +120,8 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc);
 /* return 1 if structs are equal, 0 otherwise. */
 int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2);
 
-/* print reginfo state to a stream, returns 1 on success, 0 on failure */
-int reginfo_dump(struct reginfo *ri, FILE * f);
+/* print reginfo state to a stream */
+void reginfo_dump(struct reginfo *ri, FILE *f);
 
 /* reginfo_dump_mismatch: print mismatch details to a stream */
 void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);
diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index b443745..64e0e8b 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -258,8 +258,8 @@ static void sve_dump_zreg_diff(FILE *f, int vq, const uint64_t *za,
 }
 #endif
 
-/* reginfo_dump: print state to a stream, returns nonzero on success */
-int reginfo_dump(struct reginfo *ri, FILE * f)
+/* reginfo_dump: print state to a stream */
+void reginfo_dump(struct reginfo *ri, FILE * f)
 {
     int i;
     fprintf(f, "  faulting insn %08x\n", ri->faulting_insn);
@@ -303,7 +303,7 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
             sve_dump_preg(f, vq, p);
             fprintf(f, "\n");
         }
-        return !ferror(f);
+        return;
     }
 #endif
 
@@ -312,8 +312,6 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
                 (uint64_t) (ri->simd.vregs[i] >> 64),
                 (uint64_t) (ri->simd.vregs[i]));
     }
-
-    return !ferror(f);
 }
 
 void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
diff --git a/risu_reginfo_arm.c b/risu_reginfo_arm.c
index ba1035e..09813c4 100644
--- a/risu_reginfo_arm.c
+++ b/risu_reginfo_arm.c
@@ -161,8 +161,8 @@ int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
     return memcmp(r1, r2, sizeof(*r1)) == 0;    /* ok since we memset 0 */
 }
 
-/* reginfo_dump: print the state to a stream, returns nonzero on success */
-int reginfo_dump(struct reginfo *ri, FILE *f)
+/* reginfo_dump: print the state to a stream */
+void reginfo_dump(struct reginfo *ri, FILE *f)
 {
     int i;
     if (ri->faulting_insn_size == 2) {
@@ -179,8 +179,6 @@ int reginfo_dump(struct reginfo *ri, FILE *f)
                 i, (unsigned long long) ri->fpregs[i]);
     }
     fprintf(f, "  fpscr: %08x\n", ri->fpscr);
-
-    return !ferror(f);
 }
 
 void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
index 57e4c00..37506fa 100644
--- a/risu_reginfo_i386.c
+++ b/risu_reginfo_i386.c
@@ -310,8 +310,8 @@ static char get_vecletter(uint64_t features)
     }
 }
 
-/* reginfo_dump: print state to a stream, returns nonzero on success */
-int reginfo_dump(struct reginfo *ri, FILE *f)
+/* reginfo_dump: print state to a stream */
+void reginfo_dump(struct reginfo *ri, FILE *f)
 {
     uint64_t features;
     int i, j, n, w;
@@ -345,8 +345,6 @@ int reginfo_dump(struct reginfo *ri, FILE *f)
             fprintf(f, "  k%-5d: %016" PRIx64 "\n", i, ri->kregs[i]);
         }
     }
-
-    return !ferror(f);
 }
 
 void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
diff --git a/risu_reginfo_m68k.c b/risu_reginfo_m68k.c
index 29edce9..38d7dd3 100644
--- a/risu_reginfo_m68k.c
+++ b/risu_reginfo_m68k.c
@@ -92,8 +92,8 @@ int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
     return 1;
 }
 
-/* reginfo_dump: print state to a stream, returns nonzero on success */
-int reginfo_dump(struct reginfo *ri, FILE *f)
+/* reginfo_dump: print state to a stream */
+void reginfo_dump(struct reginfo *ri, FILE *f)
 {
     int i;
     fprintf(f, "  pc            \e[1;101;37m0x%08x\e[0m\n", ri->pc);
@@ -114,8 +114,6 @@ int reginfo_dump(struct reginfo *ri, FILE *f)
     }
 
     fprintf(f, "\n");
-
-    return !ferror(f);
 }
 
 void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
index e96dc48..134a152 100644
--- a/risu_reginfo_ppc64.c
+++ b/risu_reginfo_ppc64.c
@@ -112,8 +112,8 @@ int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
     return 1;
 }
 
-/* reginfo_dump: print state to a stream, returns nonzero on success */
-int reginfo_dump(struct reginfo *ri, FILE * f)
+/* reginfo_dump: print state to a stream */
+void reginfo_dump(struct reginfo *ri, FILE * f)
 {
     int i;
 
@@ -152,8 +152,6 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
                 ri->vrregs.vrregs[i][0], ri->vrregs.vrregs[i][1],
                 ri->vrregs.vrregs[i][2], ri->vrregs.vrregs[i][3]);
     }
-
-    return !ferror(f);
 }
 
 void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
-- 
2.20.1


