Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77366C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:32:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C82224D2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bGT4ryWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C82224D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2LV-0006Oi-7f
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2Ap-0004Vn-Un
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2Ao-0005YM-QJ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:35 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38698)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iF2Ao-0005Y6-LE
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:34 -0400
Received: by mail-pl1-x643.google.com with SMTP id w8so3870101plq.5
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ayS7etBvRQ1aOAX0++NO+mX/JVf00a4W7Sr0mxG2vlw=;
 b=bGT4ryWcaWfGY2IQ6U/ewaIJWUPKhuhcOKMeIZNaY89lg2pkXvbSVCf2keGE1sXut5
 QrPUceuXVnN+SrwDFOeBKwcfRLY+XJ5WAp+UZjYvX9qtPaGb7xKhy9GXslZa647f7EOp
 W3DyZS0lmpDyYPtewbfkW872SEQNtPbOzdjSQjPHYZt+sNcx+zYSqQXKO4lY49QV1VHF
 CEW60AwcpwzH0AQP5efMUXo+AfkGxWE+lnyCgFu7jK5l0icmtfE6EVpysdk68chQgQPK
 E5Rkvv/BZ2A25LjvNmm+0vlBvrpXB9czM4RB3O/9D3MstVc5IoFhY9jDFgJyYDu9zoVK
 Yeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ayS7etBvRQ1aOAX0++NO+mX/JVf00a4W7Sr0mxG2vlw=;
 b=cnPU0qCNGGWveqrH6r8EHGLWJI3dIPItRMUQm1TB7P81JToRrRxliF00Xr5kCj+GiZ
 bMNIjqvXIZg/DZGtF+1QXX0nUDg4Y0TkgpKFaxVWCP2vlp3FEiohCSrNzeH7cp8ipnIm
 yXMmvs6o//FjXpCA+AjmGUznZj61OV9iQa8HcpkSyezz6velMvZ0Z8fFgRz7PyAtbetz
 troXjmZg5jUDEHRoIUmxH9YjyIFWx9BulAFnI0qMSJAYAnaA1MmXsSgUhiUfoRQ3HcjH
 PP5yaEZmxdzp5Y8JIYjIYwsNC/mi0CacNGY3OOtjjnAeozITXCWqihh4QbVzxbHJcH5c
 ijUw==
X-Gm-Message-State: APjAAAUCWi4YfthM+n+dAHZHmqXQTgrN0sgig+PP0nRZGOR0LWuylQNz
 EcwKDRq/8e+pV4rRJWi2VHexolyTJIc=
X-Google-Smtp-Source: APXvYqwQ5gLpswUC7AuLLWIa1odwhbZJzrevEyEN35ZeZwQtgCrIyFzrnb3W/icPkomvD5Hx6A+p5Q==
X-Received: by 2002:a17:902:fe16:: with SMTP id
 g22mr21874668plj.246.1569874893137; 
 Mon, 30 Sep 2019 13:21:33 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r28sm15336802pfg.62.2019.09.30.13.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:21:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 05/22] tcg/ppc: Replace HAVE_ISA_2_06
Date: Mon, 30 Sep 2019 13:21:08 -0700
Message-Id: <20190930202125.21064-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190930202125.21064-1-richard.henderson@linaro.org>
References: <20190930202125.21064-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: mark.cave-ayland@ilande.co.uk, amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is identical to have_isa_2_06, so replace it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 0bfaef9418..7cb0002c14 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -66,7 +66,6 @@ static tcg_insn_unit *tb_ret_addr;
 
 TCGPowerISA have_isa;
 
-#define HAVE_ISA_2_06  have_isa_2_06
 #define HAVE_ISEL      have_isa_2_06
 
 #ifndef CONFIG_SOFTMMU
@@ -1797,7 +1796,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is_64)
         }
     } else {
         uint32_t insn = qemu_ldx_opc[opc & (MO_BSWAP | MO_SSIZE)];
-        if (!HAVE_ISA_2_06 && insn == LDBRX) {
+        if (!have_isa_2_06 && insn == LDBRX) {
             tcg_out32(s, ADDI | TAI(TCG_REG_R0, addrlo, 4));
             tcg_out32(s, LWBRX | TAB(datalo, rbase, addrlo));
             tcg_out32(s, LWBRX | TAB(TCG_REG_R0, rbase, TCG_REG_R0));
@@ -1869,7 +1868,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
         }
     } else {
         uint32_t insn = qemu_stx_opc[opc & (MO_BSWAP | MO_SIZE)];
-        if (!HAVE_ISA_2_06 && insn == STDBRX) {
+        if (!have_isa_2_06 && insn == STDBRX) {
             tcg_out32(s, STWBRX | SAB(datalo, rbase, addrlo));
             tcg_out32(s, ADDI | TAI(TCG_REG_TMP1, addrlo, 4));
             tcg_out_shri64(s, TCG_REG_R0, datalo, 32);
-- 
2.17.1


