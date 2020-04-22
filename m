Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C268C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED8A206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xCQ6CuP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED8A206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR48t-0006jI-BQ
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR417-00018q-S3
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR417-0001N1-9r
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:33 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39735)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR416-0001Hg-St
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:32 -0400
Received: by mail-pg1-x541.google.com with SMTP id o10so254408pgb.6
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=glPDdkgy28ft6bPZXYEAIgcEtYEuVNy5yrxjCgISMLo=;
 b=xCQ6CuP/gKB2yOA3mvie6kntOunz4gv/LF/AMwEIiLevfe4eBjD5DMICvmJ1S/ktvL
 3KiZm3F+8sjmH4G0VUgsy7xHbvKUeOKvLFAK4iVCrWoFBiFdzsd9C/OidpRAWVAb0t5N
 KafwFpMHjmrZomIWz518AGf3nUBaLBA2lmgblrvWFCfBTTwIl6Y5Ka4nryvj4VgvlvRb
 XRveLJNbm2kOo7C7HjSSZM+Ux0qs4+n6ETi0tOAOhEkkHNQiPDCtwntZGLQKR7YXv8C3
 rDV+JtahpCFYxpiLK2MwYO+0L/PytH4F7SzsWGMxav30dHbtOrhayR1rJme1kDH96A3R
 egoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=glPDdkgy28ft6bPZXYEAIgcEtYEuVNy5yrxjCgISMLo=;
 b=G1nXTofX/VtGINlc27uVCm4XTSF5zTLVJQLyv1RVzjzBa2ZKVK30PCfbClQLS2UL/N
 2UuwMG37xQE2IcjeeYGSJhn4gqcZLroJrjQFRD2TNQ3jJP5VBfkjY7I0LBd8JOxEXtHj
 w20X3+GcpJqajyOE1Sp9nsRYDC0XmHUwAZAldE9Q24NAJwx4pORAczdgNO9WHfNxJqnc
 OjxVnDu/d/5aLTDYumRvJqbi4CHGi96jPEyz7Kimr8+YzBPhCCN0pi/04oBZWf7iukeC
 eo0Gp5WIeZi+TWMfRBWqOcLQSKJa9rtR36BJJ/SwGoX/HiPwn3tyLnQCVsANGs8BYYcz
 Iaqg==
X-Gm-Message-State: AGi0PuYJBjW8CwfrnzRyQamCIB02zw1pitxU1jpoDUjzt11Y5V6ElYT1
 aO8DTQFAWtIp1QRJ4tTnVGn8l+nOgkA=
X-Google-Smtp-Source: APiQypJu8K80/UCxyC+9ri7cM/Oei+Evt6yLBY2rSbKs/G2pEeQ0UcMUZ1NinnhBxw6yngQ+X/S1yg==
X-Received: by 2002:aa7:8a92:: with SMTP id a18mr5201366pfc.0.1587518251069;
 Tue, 21 Apr 2020 18:17:31 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/36] tcg: Use tcg_gen_gvec_dup_imm in logical
 simplifications
Date: Tue, 21 Apr 2020 18:16:51 -0700
Message-Id: <20200422011722.13287-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: alex.bennee@linaro.org, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the outgoing interface.

Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 593bb4542e..de16c027b3 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -2326,7 +2326,7 @@ void tcg_gen_gvec_xor(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
 
     if (aofs == bofs) {
-        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, 0);
+        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, 0);
     } else {
         tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
     }
@@ -2343,7 +2343,7 @@ void tcg_gen_gvec_andc(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
 
     if (aofs == bofs) {
-        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, 0);
+        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, 0);
     } else {
         tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
     }
@@ -2360,7 +2360,7 @@ void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
 
     if (aofs == bofs) {
-        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, -1);
+        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, -1);
     } else {
         tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
     }
@@ -2411,7 +2411,7 @@ void tcg_gen_gvec_eqv(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
 
     if (aofs == bofs) {
-        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, -1);
+        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, -1);
     } else {
         tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
     }
-- 
2.20.1


