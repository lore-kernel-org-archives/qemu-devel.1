Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E665CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16525205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lb4ex40A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16525205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYY0C-0003KZ-8u
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXvy-00068z-7b
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:10 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXvx-00060a-BK
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:09 -0400
Received: by mail-wr1-x441.google.com with SMTP id w7so16303880wre.13
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=miq5sxrk+TH5OlhT9tqJAy5fKLaSHjQ/CF8bIqx0AcI=;
 b=Lb4ex40AHjQhSCBPsVnhiyp6TueulsCNnYFWNqytO9xKqxoz/2rxsXrcOD2WFRlm37
 4axWh74I88NEiil1u0zk9iaEby+CtF3AUZXDt96juhbLoVujMj2xzZyIAJJQvWvJC+Xe
 xOUUNji1FU+QTRK/j5rEZnMAoUv3WeflNUa9ZHcDM7Xs6o/SBS47WF7QsoBbHAxjXerK
 TWji+5YT3CLgbTQ238ipttB/H3BSHKrYq/te9XKgtn8p7B+ZEPfZQUnexXoZ9PxAwk7t
 Y3nM5IGD7QkZW0GVjhc88R6NiofYyOPER2v4S/7eef5zcluiolfn2pwlSO3EYtiN4Fhi
 rAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=miq5sxrk+TH5OlhT9tqJAy5fKLaSHjQ/CF8bIqx0AcI=;
 b=kMKWmBJR0BlrA8aCmrfTxJYPsB49K9DpEFLziOYLSTq+PDUx9gXyFnkNl4NM7Nr2H7
 +I7RyHfJZoBJqpwzLXcaTD+YMUDHnF2gmt+xI58R/m28v65gNKLsLLgb0nbwejhk3lU4
 EPwB6wO+U99VV1k1ZmnmXy13IrohhUfrgm5jZHS9Kl+UM8FwTbnUnFo2QyJMdSkctTsg
 lDhWNgg12J26gf0WurGMJRAyw5LNIpX2tmb7vF5JdP6YU9adVYZo3M/L2nESyW0VFWza
 kQUShL6Nqt5jpTHc5lkOywkLJiyHAmEOvu0Y87jm8tVotVmq8W3y33G0ht93Hfs6cyYe
 SfzQ==
X-Gm-Message-State: AGi0PuZA6piH3TsIuFijOnizY2ilciK7pGcY3tFhcMeowDD0EGd8jlcL
 70TTujsGhgIey0noXRULBbhAsw==
X-Google-Smtp-Source: APiQypKte31wA5ZyOEiHXcbyqyBJalW2tp165aDnyV8XVwak3zVSjzBcMNQRh5+9HNa6QgRF2s6bKQ==
X-Received: by 2002:a5d:4806:: with SMTP id l6mr26389228wrq.121.1589301547908; 
 Tue, 12 May 2020 09:39:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o205sm18525981wmo.32.2020.05.12.09.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 09:39:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 01/17] target/arm: Convert Neon 3-reg-same
 VQRDMLAH/VQRDMLSH to decodetree
Date: Tue, 12 May 2020 17:38:48 +0100
Message-Id: <20200512163904.10918-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200512163904.10918-1-peter.maydell@linaro.org>
References: <20200512163904.10918-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon VQRDMLAH and VQRDMLSH insns in the 3-reg-same group
to decodetree.  These don't use do_3same() because they want to
operate on VFP double registers, whose offsets are different from the
neon_reg_offset() calculations do_3same does.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v1->v2: use do_3same() rather than custom do_vqrdlmah() function
---
 target/arm/neon-dp.decode       |  3 +++
 target/arm/translate-neon.inc.c | 15 +++++++++++++++
 target/arm/translate.c          | 14 ++------------
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 6b0b6566d60..04aff438410 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -89,3 +89,6 @@ VMLS_3s          1111 001 1 0 . .. .... .... 1001 . . . 0 .... @3same
 
 VMUL_3s          1111 001 0 0 . .. .... .... 1001 . . . 1 .... @3same
 VMUL_p_3s        1111 001 1 0 . .. .... .... 1001 . . . 1 .... @3same
+
+VQRDMLAH_3s      1111 001 1 0 . .. .... .... 1011 ... 1 .... @3same
+VQRDMLSH_3s      1111 001 1 0 . .. .... .... 1100 ... 1 .... @3same
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 099491b16f3..661b5fc4cf2 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -671,3 +671,18 @@ static bool trans_VMUL_p_3s(DisasContext *s, arg_3same *a)
     }
     return do_3same(s, a, gen_VMUL_p_3s);
 }
+
+#define DO_VQRDMLAH(INSN, FUNC)                                         \
+    static bool trans_##INSN##_3s(DisasContext *s, arg_3same *a)        \
+    {                                                                   \
+        if (!dc_isar_feature(aa32_rdm, s)) {                            \
+            return false;                                               \
+        }                                                               \
+        if (a->size != 1 && a->size != 2) {                             \
+            return false;                                               \
+        }                                                               \
+        return do_3same(s, a, FUNC);                                    \
+    }
+
+DO_VQRDMLAH(VQRDMLAH, gen_gvec_sqrdmlah_qc)
+DO_VQRDMLAH(VQRDMLSH, gen_gvec_sqrdmlsh_qc)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e3d37ef2e99..1f06cb5a87f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5450,12 +5450,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             if (!u) {
                 break;  /* VPADD */
             }
-            /* VQRDMLAH */
-            if (dc_isar_feature(aa32_rdm, s) && (size == 1 || size == 2)) {
-                gen_gvec_sqrdmlah_qc(size, rd_ofs, rn_ofs, rm_ofs,
-                                     vec_size, vec_size);
-                return 0;
-            }
+            /* VQRDMLAH : handled by decodetree */
             return 1;
 
         case NEON_3R_VFM_VQRDMLSH:
@@ -5466,12 +5461,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 }
                 break;
             }
-            /* VQRDMLSH */
-            if (dc_isar_feature(aa32_rdm, s) && (size == 1 || size == 2)) {
-                gen_gvec_sqrdmlsh_qc(size, rd_ofs, rn_ofs, rm_ofs,
-                                     vec_size, vec_size);
-                return 0;
-            }
+            /* VQRDMLSH : handled by decodetree */
             return 1;
 
         case NEON_3R_VABD:
-- 
2.20.1


