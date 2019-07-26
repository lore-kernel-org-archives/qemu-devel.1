Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9A1C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:00:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D0F321842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KT+IyBJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0F321842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4WM-0001lO-Nm
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59160)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nc-00064d-0h
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NY-00010n-Cw
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:42 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39541)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4NV-0000th-SK
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:38 -0400
Received: by mail-pl1-x644.google.com with SMTP id b7so25061451pls.6
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7nWDfS+LdH5ciQPlK6I4CJ7o4VfuIN/4vlkt7Y4d8wE=;
 b=KT+IyBJ0sQ4gxsqcoF8Y9qFThtAqsqt8oEfZeIROZyIyzZKUae7CJfu664N7GDnRJR
 VNus7Haphr8QjZ3VWoiWV3y2OeZc2h/t4Nd592i/embtWuZOMiQ0+BWEi/4Dbd8lXvzK
 yI9e/vposoNleYJFWqVHuJr97CXVfhIy6Yu0gVwJ0LPgLgqpq/9QBp51adkG0U3TdsH6
 oEqfZuZ1C7FDV1Xw86XCdgfp9WbzIORxENAtj7NoUvNdoDkmGunOrJI17d19HiDr7Fu9
 QBW4vaqZQoY4cN0L+YjKLuFlBhqfkhM84usqbV/wM4KqFazgP/E0RLv54W2vB5O9yQhI
 O3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7nWDfS+LdH5ciQPlK6I4CJ7o4VfuIN/4vlkt7Y4d8wE=;
 b=PsyCsJlb00NyPSo6vDpi9kizU/tT/kN7DT/fgPIuV3Q1W5VMl85jOfv1sh0QFQy/QM
 0z5XmC1jQP71+r5IK/a5mgoH71jC09L7RXSqSHDfv2VyjZCDW54kbEllWudDPmAjr1sa
 Ndm5n/x3VZc6ng28jq9vUCa5byPc6bihQX3g/y0T4kJYa9Wni9+8vXVK9uW7II/G/hrN
 ZkbJ1vGxGGUCVA/LR7prMF1HlOsDd9xUTZe1KR9YJJWq4TBLosKSZGnoGodiK+VvgOhk
 wD//8NX5FT4HHJL86B/THoy1tzceSXS83QHd16enQSP3aNLzrCa1Cm1uc5FsJcfaUxMj
 dBag==
X-Gm-Message-State: APjAAAWM6nfm8oVnHG6SgKe0pWtBg7zNTwHDpYZwUWixPgMlVOShMcO2
 m2R5vipDcXphUO4RYpu5S+ITkB0d/Y0=
X-Google-Smtp-Source: APXvYqz/XR//yyEDJrSUkQ83RzDap/BP21UiaCQV+jkOkjV3VKvhMvpt/mN4vdvfZb8sjOUOLQKDZA==
X-Received: by 2002:a17:902:b48f:: with SMTP id
 y15mr99334283plr.268.1564163493700; 
 Fri, 26 Jul 2019 10:51:33 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.32
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:14 -0700
Message-Id: <20190726175032.6769-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH 49/67] target/arm: Convert T16 add/sub (3 low,
 2 low and imm)
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 26 ++------------------------
 target/arm/t16.decode  | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index f551fde3db..692891dbe0 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10580,31 +10580,9 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
              * 0b0001_1xxx_xxxx_xxxx
              *  - Add, subtract (three low registers)
              *  - Add, subtract (two low registers and immediate)
+             * In decodetree.
              */
-            rn = (insn >> 3) & 7;
-            tmp = load_reg(s, rn);
-            if (insn & (1 << 10)) {
-                /* immediate */
-                tmp2 = tcg_temp_new_i32();
-                tcg_gen_movi_i32(tmp2, (insn >> 6) & 7);
-            } else {
-                /* reg */
-                rm = (insn >> 6) & 7;
-                tmp2 = load_reg(s, rm);
-            }
-            if (insn & (1 << 9)) {
-                if (s->condexec_mask)
-                    tcg_gen_sub_i32(tmp, tmp, tmp2);
-                else
-                    gen_sub_CC(tmp, tmp, tmp2);
-            } else {
-                if (s->condexec_mask)
-                    tcg_gen_add_i32(tmp, tmp, tmp2);
-                else
-                    gen_add_CC(tmp, tmp, tmp2);
-            }
-            tcg_temp_free_i32(tmp2);
-            store_reg(s, rd, tmp);
+            goto illegal_op;
         } else {
             /* shift immediate */
             rm = (insn >> 3) & 7;
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 67476b30dc..965fb1bf6e 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -117,3 +117,19 @@ ADD_rri         10101 rd:3 ........ \
 
 STM             11000 ... ........              @ldstm
 LDM_t16         11001 ... ........              @ldstm
+
+# Add/subtract (three low registers)
+
+@addsub_3       ....... rm:3 rn:3 rd:3 \
+                &s_rrr_shi %s shim=0 shty=0
+
+ADD_rrri        0001100 ... ... ...             @addsub_3
+SUB_rrri        0001101 ... ... ...             @addsub_3
+
+# Add/subtract (two low registers and immediate)
+
+@addsub_2i      ....... imm:3 rn:3 rd:3 \
+                &s_rri_rot %s rot=0
+
+ADD_rri         0001 110 ... ... ...            @addsub_2i
+SUB_rri         0001 111 ... ... ...            @addsub_2i
-- 
2.17.1


