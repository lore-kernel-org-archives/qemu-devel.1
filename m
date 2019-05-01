Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E52C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC53F2081C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gKoRIBrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC53F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36623 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLhmP-00083S-2i
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:27:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRi-0006i2-Vg
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRf-00032e-0p
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:18 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRd-000317-OX
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:14 -0400
Received: by mail-pg1-x541.google.com with SMTP id i21so4414981pgi.12
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=bE8JSPvg4RBd27AfEYsxgw0WnHCLv0Zk1q+/NsO1CmM=;
	b=gKoRIBrEw0+91rlVQu7QJGYH2DLmv4C/UHU1dl0NdT58C0KtdRquue3JZIcJGtlnl4
	KKBLDolHHckRR4CbtpGf3IO5vLGjvzOhW6y6EyBfxiPoEHyTjbXti8TwCY6O8IQQjjkz
	UWjSMO+223J7dO2LB7LiXT3uqLUtuZQ01Tbv+w/+hg07qygrdIfVnK4q6nlW8u8XEGDc
	zCgh/eUzNH9g/NEvvOCtGLoM6fUFtWrUzv39lKmcGP9CUXQ4S8wRovhSg5QO3XOGfbfk
	r29/YycDRRHSSxMZb5HLy/quz9C2P3E4XI++bCMAljIvEQy9qLFH072fDcy4Q9ITA0G3
	QteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=bE8JSPvg4RBd27AfEYsxgw0WnHCLv0Zk1q+/NsO1CmM=;
	b=Q3HtffVJmVb32+vy9Oj3We9hbZNjqBNBrhuOSrv3pPJ+wQUJrq6Q2oi9+rdVUSVmHF
	P+6nX6txm6E1Ii2ZTS3QCKJ8PRNJ+niJ9ziBDd07gtxsycXBjhPlDPG9GQvzDhmar6ZE
	deC8vIRcH1q5uS6zU4PqqtLa604jDRlBIhMt5VrX6Fz/pK61bqyaBRo0JlciH4XClF+Q
	Llb9pqJQUlNIYTazL9yropIWhcSy47y8k8wQH1UOKqDgJE4CGrCu3q2faXo1A8Sy48kY
	eLhRCo8BF17C18put337KM+b4+VssZTwnZY0w0r9RKU6nsukMc51RvGmqUSNZPdXwkWb
	hWMA==
X-Gm-Message-State: APjAAAV+xNmu1zEf47mL/ipczLPnQnmp/OUrqrHMLOIi8uvJQOfdFp/p
	gcwyVLZkArfdYGL6k2M+zU+HJA4SLso=
X-Google-Smtp-Source: APXvYqxe1TVUvO3uNHf9k31re4w/JMRSiZrpkkfNZX9RSShQdj9CVrDzrN7NohaoWoq77LrIQBgd6A==
X-Received: by 2002:aa7:8212:: with SMTP id k18mr75367635pfi.50.1556687171202; 
	Tue, 30 Apr 2019 22:06:11 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.06.09 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:06:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 22:05:29 -0700
Message-Id: <20190501050536.15580-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v2 22/29] tcg/aarch64: Support vector absolute
 value
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
Message-ID: <20190501050529.IxxlkXL0gLjhSCnpCkOPr3dbQPQND9ejp0-jWt9aWGA@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     | 2 +-
 tcg/aarch64/tcg-target.inc.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 21d06d928c..e43554c3c7 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -132,7 +132,7 @@ typedef enum {
 #define TCG_TARGET_HAS_orc_vec          1
 #define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          1
-#define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_abs_vec          1
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          1
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 61c2dbbff2..e7f8d96e21 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -554,6 +554,7 @@ typedef enum {
     I3617_CMGE0     = 0x2e208800,
     I3617_CMLE0     = 0x2e20a800,
     I3617_NOT       = 0x2e205800,
+    I3617_ABS       = 0x0e20b800,
     I3617_NEG       = 0x2e20b800,
 
     /* System instructions.  */
@@ -2209,6 +2210,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_neg_vec:
         tcg_out_insn(s, 3617, NEG, is_q, vece, a0, a1);
         break;
+    case INDEX_op_abs_vec:
+        tcg_out_insn(s, 3617, ABS, is_q, vece, a0, a1);
+        break;
     case INDEX_op_and_vec:
         tcg_out_insn(s, 3616, AND, is_q, 0, a0, a1, a2);
         break;
@@ -2320,6 +2324,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_andc_vec:
     case INDEX_op_orc_vec:
     case INDEX_op_neg_vec:
+    case INDEX_op_abs_vec:
     case INDEX_op_not_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_shli_vec:
@@ -2563,6 +2568,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &w_w_w;
     case INDEX_op_not_vec:
     case INDEX_op_neg_vec:
+    case INDEX_op_abs_vec:
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
-- 
2.17.1


