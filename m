Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96983C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67E3D22D02
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hJHoDV5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E3D22D02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3di4-0006N5-Pi
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dRM-0001rC-Vy
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:05 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:34967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dRL-0007lQ-9k
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:04 -0400
Received: by mail-pj1-x1043.google.com with SMTP id t6so6294640pjr.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=T2zFAscQb8E+SK8j3wK1kVNT/OC9AVAafjFqeCT4gx8=;
 b=hJHoDV5BJmvrDR+qfDIwjA7IC8JZCu41XvnnCGnUxh1W8gMX+VfgUnPj6d6/OoZ0Wt
 RobM8XqFU0s6kBET/XvxauGgrVLIlfQmn0lgJSSA7tS9ZA0UisHshi64AW0xbi4pD1TM
 wLzFpdDkV9e4BQxdhvX83pT3WiKmlcVW8NAyQ5XSObBozen7uQpOVTlCCXJiNv5ZQ4a4
 vNLP2gDgWYyw6RaMvpWulZspEgQQI7CnQ+ze3xT5jVXjeFStX7NiEcy4/5Xbd3DCEjBo
 Dh8Y1EGDWrF1UhOjpT5q0I8hrBDibUiuqW0kNKP7Msw8d/QwFNf1OaOscewcuXiR4eLi
 WtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=T2zFAscQb8E+SK8j3wK1kVNT/OC9AVAafjFqeCT4gx8=;
 b=n4csX/RLK6gMZp80wg8UTDCsZzG9vCFkElOZopjJwbdCCcgeIutPyp5jCP+i9ko5tQ
 AokIL3wn5eNuke7iqQmxhXq6uxQ/j1N7ZDualmEdnucytx/R2LrW0/UmJW1m3mZ8pJXN
 He1sIkZaIoYNSq9L6updFbLMdv/nRAsWV6mEg1ryrmby7aOA+iD+WtGAKKoMyoh8LzVq
 wTkcMZ+ToeiW4Z6mdcbtLCIXqnHSqZsiWm7rcYoZIVJzbjRbONgx6EgZDgMqok3VWyRa
 6o3TAwSAy536E3nlcj7XRqhGGiTNpY5mdoqvXwR2YcPZ3SRdPkJYVE6f7+4OtrubZFUz
 os6A==
X-Gm-Message-State: AOAM533DEef8xp692FL9Hfzl4MYZPwTbMLVkfu01DyxqE0oF2ELAGny7
 87R+5tq0ym5/zptG0uuq8eyLdRgvaNs=
X-Google-Smtp-Source: ABdhPJxI5ZKlWRLp1t93Q3Wn0chiLKpaBE9U7jKrPC9lSPk+jRVC+BiGZX8GstBdD8ha1BIbreplXQ==
X-Received: by 2002:a17:902:aa93:: with SMTP id
 d19mr6958337plr.272.1596710881750; 
 Thu, 06 Aug 2020 03:48:01 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:48:01 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 16/71] target/riscv: add fp16 nan-box check generator function
Date: Thu,  6 Aug 2020 18:46:13 +0800
Message-Id: <20200806104709.13235-17-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

If a 16-bit input is not properly nanboxed, then the input is replaced
with the default qnan.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/translate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 24026f901d1..95921296a56 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -110,6 +110,16 @@ static void gen_nanbox_s(TCGv_i64 out, TCGv_i64 in)
  *
  * Here, the result is always nan-boxed, even the canonical nan.
  */
+static void gen_check_nanbox_h(TCGv_i64 out, TCGv_i64 in)
+{
+    TCGv_i64 t_max = tcg_const_i64(0xffffffffffff0000ull);
+    TCGv_i64 t_nan = tcg_const_i64(0xffffffffffff7e00ull);
+
+    tcg_gen_movcond_i64(TCG_COND_GEU, out, in, t_max, in, t_nan);
+    tcg_temp_free_i64(t_max);
+    tcg_temp_free_i64(t_nan);
+}
+
 static void gen_check_nanbox_s(TCGv_i64 out, TCGv_i64 in)
 {
     TCGv_i64 t_max = tcg_const_i64(0xffffffff00000000ull);
-- 
2.17.1


