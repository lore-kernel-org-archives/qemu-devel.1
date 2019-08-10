Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E33AC32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:16:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670B02054F
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVplSbDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670B02054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIno-0005at-K2
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34788)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIkv-0005kQ-87
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIku-0004MR-BO
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:25 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42323)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIku-0004MI-7G
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:24 -0400
Received: by mail-ot1-x342.google.com with SMTP id l15so140514396otn.9
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n4ayeLooNp0fm7Wh5HpoXhexlt7VndsDJ81PF2rUFA0=;
 b=DVplSbDCgX7onjD5puxpTGLnxluQ0jX+43UGtWkzo3STsfRWvDI4tvUMJ0yKtpHrED
 PRapDVmeoH98/k2wifF+7Fh3KxYm62PrCfWFJet0RG+xXU/fBip7ZStBBBvZl9S8VKvm
 cKtHqDbKW0fPvFjIVYLzy0zB+WRpkggKcldD1mMZz/YHfFHrwYkofEH8bkxIUbVbtk9P
 KIKo+wMAX3fqZbSk3cAh3lNrlV774oZuKVOFbq9QjgP9do9bjTcoWHMnyOxtvqGjMDA1
 RYooEPchLLy4mmtdpff9fR3qhjO5AtATL4wu31QXfIIy8yzpXR1PtgK+C12DD0s97zfv
 aJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n4ayeLooNp0fm7Wh5HpoXhexlt7VndsDJ81PF2rUFA0=;
 b=QNz2AEOlkVno57vQU47RRtOiDI9iUSFUc6s/jbk1/XtaUYPldiHwbxPGYKuxpOqYRJ
 C7//R2YeEjnAHvIQwQ9cuk+azffRKxH50/xx4qdkbucHHmDilJ3YIiRZyOQhBUz42MI3
 F3SRmm34SowG6V7hGXrvLAgnuZlHwbF5x18iGknSvmMw7nhXtJRoF+GKVnRMT+DgWLUS
 ZpJCTyFZBflk8d3/hdVF9bTtb3K3wQLu81MjdSWT0AdE+4mzD8VZcg3lJ78RUXy9eaPG
 edTdlcpfI5vieCj47J12M/gqRPXdxGyIb9z21FjII8i+e/3gQOg61xxamrFZG/52gAxY
 +jrw==
X-Gm-Message-State: APjAAAUyZOV0ky5FVMoEQqaDgKTGGdYtTUE0LRgHPMSaPJqemetGwkee
 suukHPjd+NEEqsxYyG7u/LixRgAT
X-Google-Smtp-Source: APXvYqzMJ7XmCqdQnhh6kKPYbuRkepa1HG9DtTu/UEZb315ATUEtYxpMK5ufmGoTtGcmhw1TgiD90w==
X-Received: by 2002:a9d:6a95:: with SMTP id l21mr3725154otq.192.1565410403539; 
 Fri, 09 Aug 2019 21:13:23 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:23 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:33 -0400
Message-Id: <20190810041255.6820-18-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: [Qemu-devel] [RFC PATCH v2 17/39] target/i386: introduce helpers
 for decoding modrm fields
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The old code uses bitshifts and bitwise-and all over the place for
decoding ModR/M fields. Avoid doing that by introducing proper
decoding macros.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 109e4922eb..4a2dae6238 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4500,6 +4500,21 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
 #define tcg_gen_gvec_cmpgt(vece, dofs, aofs, bofs, oprsz, maxsz)        \
     tcg_gen_gvec_cmp(TCG_COND_GT, vece, dofs, aofs, bofs, oprsz, maxsz)
 
+#define decode_modrm_mod(env, s, modrm)         \
+    (((modrm) >> 6) & 3)
+
+#define decode_modrm_reg_norexr(env, s, modrm)  \
+    (((modrm) >> 3) & 7)
+#define decode_modrm_reg_rexr(env, s, modrm)    \
+    (decode_modrm_reg_norexr(env, s, modrm)     \
+     | REX_R(s))
+
+#define decode_modrm_rm_norexb(env, s, modrm)   \
+    ((modrm) & 7)
+#define decode_modrm_rm_rexb(env, s, modrm)     \
+    (decode_modrm_rm_norexb(env, s, modrm)      \
+     | REX_B(s))
+
 enum {
     CK_CPUID_MMX = 1,
     CK_CPUID_3DNOW,
-- 
2.20.1


