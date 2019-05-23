Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982E9C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A3E2081C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qx+qNk6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A3E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37450 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTofD-0003mk-Ht
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:25:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTodX-0002Wa-FT
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTodW-0006pa-06
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:03 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:39954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTodV-0006nx-Nv
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:01 -0400
Received: by mail-wm1-x330.google.com with SMTP id 15so5995176wmg.5
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=GWOxRv/DyhNDr3+OGIc40iczzclis5p5MGykNCNdjFE=;
	b=qx+qNk6RGzpErVHtUr7Vd0Dfz4OXlfxBnhsB9e8rjKMNJ6FDbdxmsi7yN6PUKrI/hG
	WwUFZBO1QvxO017dSA/L4D88EW1sYBtfedsKuJa53kwIJiK4szRVVrwC9eSTEwJUf8rz
	nTA1skNHpZSAKWRcKTkVg5CTuZwb5RlvY1v4oDiDzz78pNGhV1ARPc7qPgxKKudPfbUd
	/f6cw6cr/i7pqn15RpJOwks+tN3C60DVllz3PqBaTwQxsiI/VzpjZ+x1cXAW7/W2b+zc
	KXWrR7fhGgdvqxg9SuhvA8AJoH/CWTTOIPOtpoMg7r3J1U2x3dG7JQFne4ugHdgSUzGH
	9X0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=GWOxRv/DyhNDr3+OGIc40iczzclis5p5MGykNCNdjFE=;
	b=DkD8HzYgL2szmdE1D74MP5XRC2wbmpbo1pGfZqkNf4/JUcj9NV9E+GkE9K8SC7Q99s
	DFAiRXtC5wqYh+0ARf/TpsxQ2ZNOW1ojEsVwQ+u3nto8NG0+TblQZRMPTy/OvMU7nS07
	PVcHQeA8bO8gmmnkO8RO9tHUk43lDcmJqjyD6/WwhwsRReBBvGYHvCzyfJPKG2/GnPqN
	vOBhD5ztiikWh2Nw2tnEV3sLj6tGTXH0zTf43iMXF+i53LisKf9JuQR+fnhn5ISUb++n
	9imA6r539Bj74Rwz4EKu00F/FlMDsdJU+VeEtpKfCd2qSsmzdQ83qkKQF/xnlpK5u0si
	dTAw==
X-Gm-Message-State: APjAAAX8wrJ90QxgMRxguh3ygH+JP+M+Hfhs2DjTX+24ow35fQbLQrW4
	ZBKR3h8qfcLaXGkOMVMoJzwPQYGnOh+YYA==
X-Google-Smtp-Source: APXvYqz/qnKaXRuT1on7Lusm+rHPYibtltF1L9ACIHdBh7JBpXsvZUCB7ylQC+LScyd8k68QAJs5zg==
X-Received: by 2002:a1c:c7c8:: with SMTP id
	x191mr11056686wmf.126.1558621440436; 
	Thu, 23 May 2019 07:24:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id z5sm9700617wmi.34.2019.05.23.07.23.59
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 07:23:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 15:23:46 +0100
Message-Id: <20190523142357.5175-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523142357.5175-1-peter.maydell@linaro.org>
References: <20190523142357.5175-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::330
Subject: [Qemu-devel] [PULL 01/12] target/arm: Use extract2 for EXTR
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

From: Richard Henderson <richard.henderson@linaro.org>

This is, after all, how we implement extract2 in tcg/aarch64.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190514011129.11330-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b7c5a928b4a..2b135b938ce 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4114,25 +4114,27 @@ static void disas_extract(DisasContext *s, uint32_t insn)
             } else {
                 tcg_gen_ext32u_i64(tcg_rd, cpu_reg(s, rm));
             }
-        } else if (rm == rn) { /* ROR */
-            tcg_rm = cpu_reg(s, rm);
-            if (sf) {
-                tcg_gen_rotri_i64(tcg_rd, tcg_rm, imm);
-            } else {
-                TCGv_i32 tmp = tcg_temp_new_i32();
-                tcg_gen_extrl_i64_i32(tmp, tcg_rm);
-                tcg_gen_rotri_i32(tmp, tmp, imm);
-                tcg_gen_extu_i32_i64(tcg_rd, tmp);
-                tcg_temp_free_i32(tmp);
-            }
         } else {
-            tcg_rm = read_cpu_reg(s, rm, sf);
-            tcg_rn = read_cpu_reg(s, rn, sf);
-            tcg_gen_shri_i64(tcg_rm, tcg_rm, imm);
-            tcg_gen_shli_i64(tcg_rn, tcg_rn, bitsize - imm);
-            tcg_gen_or_i64(tcg_rd, tcg_rm, tcg_rn);
-            if (!sf) {
-                tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
+            tcg_rm = cpu_reg(s, rm);
+            tcg_rn = cpu_reg(s, rn);
+
+            if (sf) {
+                /* Specialization to ROR happens in EXTRACT2.  */
+                tcg_gen_extract2_i64(tcg_rd, tcg_rm, tcg_rn, imm);
+            } else {
+                TCGv_i32 t0 = tcg_temp_new_i32();
+
+                tcg_gen_extrl_i64_i32(t0, tcg_rm);
+                if (rm == rn) {
+                    tcg_gen_rotri_i32(t0, t0, imm);
+                } else {
+                    TCGv_i32 t1 = tcg_temp_new_i32();
+                    tcg_gen_extrl_i64_i32(t1, tcg_rn);
+                    tcg_gen_extract2_i32(t0, t0, t1, imm);
+                    tcg_temp_free_i32(t1);
+                }
+                tcg_gen_extu_i32_i64(tcg_rd, t0);
+                tcg_temp_free_i32(t0);
             }
         }
     }
-- 
2.20.1


