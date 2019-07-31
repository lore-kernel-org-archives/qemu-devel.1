Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF3FC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:22:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09852206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mcWF+Vuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09852206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrNO-00065X-54
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42496)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrGA-00066j-Cp
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG9-0004Co-Ay
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:26 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrG9-0004CP-3i
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:25 -0400
Received: by mail-wm1-x341.google.com with SMTP id p74so61416665wme.4
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KsjX33kvThYIDWRhxE9xiNalYsaeNYqt8GFqXTwRIQ4=;
 b=mcWF+VuzfacZ4sDjA64W2nMGZhyaeJT1PCRRBvE7OWcChgcBsuqT/j0uNMTyiCMa8u
 IoYAml+vnU6yxWnJS5gBW1s/ehk7wo/+pn/1rdmOaKvfMLvvg1aRhvXhCj7bZS7JzVrc
 8L74rY86WKNo9ZVUEjJbQSRciK/zph8oNH8S56QQ6DRevXHOKlIRK1TAzrwiGLA4Ug1J
 ydMWXOJzl7GL1J2OvgL2o01rAs7S12t1AGN790oO7wxYBUDd861vutOUFAsCyBQPlxLH
 qtoBnMRH6uHccE3PG3jHTGdnq7CoQ5V78PD2jF9jimw7EhWgHS/XTsdWCPOaKJD9tR0T
 +p9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KsjX33kvThYIDWRhxE9xiNalYsaeNYqt8GFqXTwRIQ4=;
 b=cZpsKTeD6ta2pDsD35f63mCfyV5RZ1JpRXIug0it77y7PN8naiYKF8m/BfKr4Zrov1
 QOk1eSQJivYvWnT2Qq8DSTHuaqr3co01rFVwpX7w1mLiLi6dNUxO4dmD4TsChTQT8lR4
 uxF+2PpQCPdEQVZ7Hbjv1SbbWRehc+e42cHFmTB1Cl4biR1RhKKOZ/6/DsYN7EPa3RXn
 CGvvBTo3D4teL5wSbJQty25hAPX8UCrlUN/JMjGYvjH6arDOu1+Q3v87APy/DT1v2+s/
 kCNpYi6ALH/d/ClcfF+Fy52Bd5qH+6arSBtldFauEUxyze6IoB1LknP9KWHmFSkoUu+M
 Jd/A==
X-Gm-Message-State: APjAAAVBvbzk54ugfc7uG5txFhoUv+bpaPv4vi0fJjL2fA29aBQtvZNk
 BmAmUTV2Xok+KMTaunJgrZgh/g==
X-Google-Smtp-Source: APXvYqw4k5EyDnVJzwPQ8fptRlyI2X/Rke3Qv8DmFMGyhV++BQrYC2CQxVOOvtjTBQfCiNywZCeynQ==
X-Received: by 2002:a1c:f918:: with SMTP id x24mr10734467wmh.132.1564589724044; 
 Wed, 31 Jul 2019 09:15:24 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id u186sm122762892wmu.26.2019.07.31.09.15.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:15:22 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D9A591FFAC;
 Wed, 31 Jul 2019 17:07:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:50 +0100
Message-Id: <20190731160719.11396-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v4 25/54] translate-all: notify plugin code of
 tb_flush
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, bobby.prani@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Plugins might allocate per-TB data that then they get passed each
time a TB is executed (via the *userdata pointer).

Notify plugin code every time a code cache flush occurs, so
that plugins can then reclaim the memory of the per-TB data.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/translate-all.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 9c5c60ed964..7379df8f19c 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1231,6 +1231,8 @@ static gboolean tb_host_size_iter(gpointer key, gpointer value, gpointer data)
 /* flush all the translation blocks */
 static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 {
+    bool did_flush = false;
+
     mmap_lock();
     /* If it is already been done on request of another CPU,
      * just retry.
@@ -1238,6 +1240,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
     if (tb_ctx.tb_flush_count != tb_flush_count.host_int) {
         goto done;
     }
+    did_flush = true;
 
     if (DEBUG_TB_FLUSH_GATE) {
         size_t nb_tbs = tcg_nb_tbs();
@@ -1262,6 +1265,9 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 
 done:
     mmap_unlock();
+    if (did_flush) {
+        qemu_plugin_flush_cb();
+    }
 }
 
 void tb_flush(CPUState *cpu)
-- 
2.20.1


