Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBA0C04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D87A921734
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BcO4IuGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87A921734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36881 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQLIP-0001zZ-4e
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 20:27:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQL7R-0004h8-6N
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKxc-0003mq-44
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:09:07 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:34087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKxV-0003dS-UB
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:19 -0400
Received: by mail-pf1-x42e.google.com with SMTP id n19so8073676pfa.1
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=9WOXKtEi3L6ImDw3IdIaNV2poL0/GbDzfb9Cr5a6LGc=;
	b=BcO4IuGF3sq8sDLavMBragVBFJkuFI2xWHFaRRAgOE/Zoz2Oed3+OxkbQwUvfUkF9V
	q0c1KTXldd+IX0Fa9nqJprLCU7qjbzNXTdBItQ55L0VD97IBOFQK6zEGTCBXTgVmvwwm
	RaOS8nu/j6PrMeOznjVhoxuCfHzaTu670vwwkA73vhcLQ0rxeorRpDIEbkl6lVigG7Dh
	nOBjKMBHz0gX5otG3NPW7siCqlKvCNtlmqkmUjgy7oI4LQvTCFkok7VcDboqiIIunM4d
	guh/g1c/eANCvDgCqps5fnHafYVpxBN847jgEbWcuP15/FK6gosnzTAaUFOXb4bRzBCI
	+lKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=9WOXKtEi3L6ImDw3IdIaNV2poL0/GbDzfb9Cr5a6LGc=;
	b=lzt4Nb47S4Yw5wGk6J2kb/gmgZ83YZ8KrtP1PNrpcX0KXDMwwG/pIhB/Ft/nbEEj5X
	rh9OwP70kO9b+5SBIrQj+ZycNjpkaVawUOp2TUFQUybwPLMdK+v8zESPvgXLLb7ComVG
	BQHDEX2kqM3i+Jmt0Bufi9usWfXfa1epZU9s5HmnHxGowBRs8cDnsqq0o48xTXYY66NF
	Y4lX00pt+GexI7ASxXZFSo0UwOFHU6Z9bksu1LHfXlLoTlwneHOo/H+x3jtA9ZqDsZx/
	ZXXc+znprcqK1+Doy0BSGD6Njrv0Jm+IJXKYYKo0I0sDyqO9M/H5fR7DoQKX7bXvtTvB
	/6gg==
X-Gm-Message-State: APjAAAUQHJVnEA02bzOIwC3axqKF9iwU2TPqZDovqfDluMfWpBSnOjSe
	esV+gYp3bEj0USj+SKUUYEWHlKVO08s=
X-Google-Smtp-Source: APXvYqw+qnWqOFY2B5YTWS5MEDdLVxYJawQi+EhVkwELjX9RqfV6c1tB3q03aDoZHb79/AF1Bz6rsQ==
X-Received: by 2002:aa7:8096:: with SMTP id v22mr37297927pff.94.1557792372969; 
	Mon, 13 May 2019 17:06:12 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.06.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:06:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:32 -0700
Message-Id: <20190514000540.4313-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
References: <20190514000540.4313-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42e
Subject: [Qemu-devel] [PULL 23/31] tcg/aarch64: Support vector absolute value
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
Cc: peter.maydell@linux.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
index df123c07f1..1248dfd04c 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -552,6 +552,7 @@ typedef enum {
     I3617_CMGE0     = 0x2e208800,
     I3617_CMLE0     = 0x2e20a800,
     I3617_NOT       = 0x2e205800,
+    I3617_ABS       = 0x0e20b800,
     I3617_NEG       = 0x2e20b800,
 
     /* System instructions.  */
@@ -2208,6 +2209,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_neg_vec:
         tcg_out_insn(s, 3617, NEG, is_q, vece, a0, a1);
         break;
+    case INDEX_op_abs_vec:
+        tcg_out_insn(s, 3617, ABS, is_q, vece, a0, a1);
+        break;
     case INDEX_op_and_vec:
         tcg_out_insn(s, 3616, AND, is_q, 0, a0, a1, a2);
         break;
@@ -2319,6 +2323,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_andc_vec:
     case INDEX_op_orc_vec:
     case INDEX_op_neg_vec:
+    case INDEX_op_abs_vec:
     case INDEX_op_not_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_shli_vec:
@@ -2562,6 +2567,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &w_w_w;
     case INDEX_op_not_vec:
     case INDEX_op_neg_vec:
+    case INDEX_op_abs_vec:
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
-- 
2.17.1


