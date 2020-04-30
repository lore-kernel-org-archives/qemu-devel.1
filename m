Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD49C83006
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 02:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F33620B80
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 02:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GxJFd+wc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F33620B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTyar-0000Yh-9e
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 22:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTyZ0-0006yX-Dt
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:04:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTyXm-0004kn-1r
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:04:34 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030]:39182)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jTyXl-0004kX-KM
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:03:17 -0400
Received: by mail-pj1-x1030.google.com with SMTP id e6so58735pjt.4
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 19:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cjohu6TAlmU+sTz6uKGa1YpUWk5EN4khFj5+kP1VER4=;
 b=GxJFd+wcptgvAc8o9Ug5rgfsc1jheKv+QDYG0qSsTRtI39VYzF+cfv1yu3naRPepH2
 z225AslqQcljfFqUOH9a6cFn5KvX28h3PPlx3scj4tB0/HQV0/0bdFR0poZJ3k+fThiF
 VhleY6+krAAsE3Dv1o3eXuq/BKsDIbiGPIUvexBXYmL73uj1o0vfNzCE19KnBOSmccSn
 +dD1ZwmmCt2mSrtSFp7j7Kbmrc3GGcHZCsxhAG9NB+LH9geqoXle9sgJRhK/P/jAYsi/
 UbdSLvPNrj+sC6wMlvVg6qFLcAALWGFNlZA7RjP0/aoa8gA+RejSlLaukC2NiiQ6XKir
 fMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cjohu6TAlmU+sTz6uKGa1YpUWk5EN4khFj5+kP1VER4=;
 b=SlfRCYsikS/yaQtewTIP7g4ArrNEeYixYQrS0UzKSQkhO0PffnQaDhCrnrMZ/U+yej
 Zu393/mQRFbYm610P9FvJR1XMwtaKyPvDTdZnRODSYr/xsoAgh832dyGnY9sPeRHrXix
 9bBVoZ+Iv9yLpme/L4BaJtYVS7gFL5xM+7RSUmgUHQgdra/JqU43EoEC6C0GArzzMZWS
 JvjrKcKuVA4yP8KxbyCeT8fpOwt2IlH8y/CmjupjqdrXeD7k0ln60q4caGduLf+MVVP9
 qPXpvGRAo3yJLbWl1KAgRHb0zCCA8+9M0/XqXVjxHLKlVTUR+oHOr+EjElyaAEVkwRwK
 lOUg==
X-Gm-Message-State: AGi0PuZ4pxxK0EcMI6Vt/p2t/3JaT91AhIPf+XvZoyE+K23qy5RmFXih
 yaxJ1VV2m4wXcMdT8V6U8E90ITTXoFs=
X-Google-Smtp-Source: APiQypLLu2XUN/Ey7L9FIRyCMlO0CVSq/1VzmQnSlqtp4BzJGdSaWEiqqukbkXlhf4xsjgUOFXByeQ==
X-Received: by 2002:a17:902:bd42:: with SMTP id
 b2mr1313782plx.219.1588212195960; 
 Wed, 29 Apr 2020 19:03:15 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id y3sm409284pjb.41.2020.04.29.19.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 19:03:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 9/9] target/arm: Implement SVE2 crypto constructive binary
 operations
Date: Wed, 29 Apr 2020 19:03:03 -0700
Message-Id: <20200430020303.20264-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430020303.20264-1-richard.henderson@linaro.org>
References: <20200430020303.20264-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1030
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
Cc: steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  5 +++++
 target/arm/sve.decode      |  4 ++++
 target/arm/translate-sve.c | 20 ++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4f09dd42ba..0a7c68843b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3870,6 +3870,11 @@ static inline bool isar_feature_aa64_sve2_bitperm(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, BITPERM) != 0;
 }
 
+static inline bool isar_feature_aa64_sve2_sha3(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SHA3) != 0;
+}
+
 static inline bool isar_feature_aa64_sve2_sm4(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SM4) != 0;
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 149de7949b..3cf824bac5 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1564,3 +1564,7 @@ AESMC           01000101 00 10000011100 decrypt:1 00000 rd:5
 AESE            01000101 00 10001 0 11100 0 ..... .....  @rdn_rm_e0
 AESD            01000101 00 10001 0 11100 1 ..... .....  @rdn_rm_e0
 SM4E            01000101 00 10001 1 11100 0 ..... .....  @rdn_rm_e0
+
+# SVE2 crypto constructive binary operations
+SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
+RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 91e71882d6..a8e57ea5f4 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -8233,3 +8233,23 @@ static bool trans_SM4E(DisasContext *s, arg_rrr_esz *a)
 {
     return do_sm4(s, a, gen_helper_crypto_sm4e);
 }
+
+static bool trans_SM4EKEY(DisasContext *s, arg_rrr_esz *a)
+{
+    return do_sm4(s, a, gen_helper_crypto_sm4ekey);
+}
+
+static bool trans_RAX1(DisasContext *s, arg_rrr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2_sha3, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3(vec_full_reg_offset(s, a->rd),
+                       vec_full_reg_offset(s, a->rn),
+                       vec_full_reg_offset(s, a->rm),
+                       vsz, vsz, &rax1_op);
+    }
+    return true;
+}
-- 
2.20.1


