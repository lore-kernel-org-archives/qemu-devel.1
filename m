Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDDFC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7583206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c68dW8uT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7583206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51884 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMnvN-0000ey-Qj
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 02:13:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnc6-00084w-OK
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnc5-0004ZC-Qn
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:34 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnc5-0004Yj-LZ
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:33 -0400
Received: by mail-pf1-x443.google.com with SMTP id 10so3978639pfo.5
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=njZylfJYYv8BcxCOaRQsx2/xRladRXvgAJ8dZdaUUo4=;
	b=c68dW8uTjhOrYNSajL/NL7Ypw9kvNpq4F8rO8AJWJxD+JrnvY1VqEN8hyVyjVD4sJh
	oikgrddzh/mFpXvlnijlsDpjIXCvnPXqWkY0jySsVWG3QVcIyS4QWPzyoiaZG1LFUt7L
	6YRxphKIkf8n/l9ovZFnn3xxV7RPp3+M6iGdNQG+TxcPAcLmvZTGEiSXUtCAvDJj0108
	CgxHeocsbSWkQ55VyF5TzlzT3OdwDTtjnxJAEWJ5eL8BeOGkEx9/j1Y151gRNBBBpuSg
	HaiiVeT2h91h+5dqAnMPT1kiZ242b03Gs1qcjSKgeWEz3cmoEr9W1wuG7unB/h5h512K
	srDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=njZylfJYYv8BcxCOaRQsx2/xRladRXvgAJ8dZdaUUo4=;
	b=bh3djOOEIF042BcY77XMJoCBpvOWRl5vTv48mr07o0swD9yUQRbyU2TLYGtUzG6xxd
	xmb1+c1aKMyjOPe6j0SI8B/SNfC3TodP/b9paWoZq1k8yZ5PENtp1naDRSjsQ1P6RRnJ
	UtqNn1VmWPiYySYGmm2S0ofpAHgCtcmwdy190IfgbkY+9tZhiyZIKoFdkdS1iDoH3FiO
	RC/9ReEPcLJ3lLEIZ94/mWjTkhV3VXzhLjnmKslCfrBf20gzSHHDse4pkV4BsTB7LmPg
	rTbpBXBL2iGlTTl53/QSii3DNjRjMt7noC/EYpGojhPuJ20u4v1wK6qw4J5kEWBCyThw
	04uA==
X-Gm-Message-State: APjAAAWK3N3OEG9g0NDnSQlqtTtA1yxLUi6fIyk5f2OAuKRJ4vgYdVzT
	7y0zDCslFO6iWKlIIuyRwvgvBcRHgM4=
X-Google-Smtp-Source: APXvYqzNjj0I3XArr18UmrbdCrRAWs6NBMqrAW3LsgmKhXQSPP8eHRfi6ZD9G78loQwVhxRfJmJq8Q==
X-Received: by 2002:a63:5443:: with SMTP id e3mr15950418pgm.265.1556949212426; 
	Fri, 03 May 2019 22:53:32 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:54 -0700
Message-Id: <20190504055300.18426-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v3 25/31] target/cris: Use tcg_gen_abs_tl
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
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504055254.K3FbbGOlf7cx6i4mFLSqYWic4s7372RQOUsOJ4F6IeE@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/cris/translate.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index b005a5c20e..31b40a57f9 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -1686,18 +1686,11 @@ static int dec_cmp_r(CPUCRISState *env, DisasContext *dc)
 
 static int dec_abs_r(CPUCRISState *env, DisasContext *dc)
 {
-    TCGv t0;
-
     LOG_DIS("abs $r%u, $r%u\n",
             dc->op1, dc->op2);
     cris_cc_mask(dc, CC_MASK_NZ);
 
-    t0 = tcg_temp_new();
-    tcg_gen_sari_tl(t0, cpu_R[dc->op1], 31);
-    tcg_gen_xor_tl(cpu_R[dc->op2], cpu_R[dc->op1], t0);
-    tcg_gen_sub_tl(cpu_R[dc->op2], cpu_R[dc->op2], t0);
-    tcg_temp_free(t0);
-
+    tcg_gen_abs_tl(cpu_R[dc->op2], cpu_R[dc->op1]);
     cris_alu(dc, CC_OP_MOVE,
             cpu_R[dc->op2], cpu_R[dc->op2], cpu_R[dc->op2], 4);
     return 2;
-- 
2.17.1


