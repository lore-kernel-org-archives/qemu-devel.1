Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4BDC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B53B32087B
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MT+oLvLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53B32087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38321 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkpc-0008Bw-04
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:54:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXI-0000kt-8K
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXE-0000JG-2Y
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:42 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXB-0008Uw-Sv
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:38 -0400
Received: by mail-pg1-x543.google.com with SMTP id v12so3609682pgq.1
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=o+cYp+5ys6XsltkQeTLvq7AcmzszeQmf5jssa+GAZ9E=;
	b=MT+oLvLpOzp5uYF1oMT4e1K81r2Ji7eRVeo9UvbPKZ9fwr06fJxGnIB65UmL5O3Tmo
	EVDpG7KFA2gevzmcaknkxweS39KrN0+OkYh/IW9thmdPABmou7gIjG01/MaFUpCv+DXe
	VrfQaWiJfmli0AzARASryV/eWI+nU86RrJkn1qCOTOOjRXa4/OhgF+Hdhsl7/5NKwimo
	vmAV/URnxlVPfkht5snutgD4eb8cv4Ii2ux1FPeSDbVImUTJOvOc833jiTETDYWEr6Wy
	jlSJ7uNWHOyGhPLgX3axi8IBcgYIET/cyOlZSagsy0HLTwef1GP/B1gv/KOY3nORpXEW
	p+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=o+cYp+5ys6XsltkQeTLvq7AcmzszeQmf5jssa+GAZ9E=;
	b=OWezX7OxZZu30nTsZu1NmPFBPKSien3eryuLklqkIEoyBmCICadLdglE1huAPzMD32
	cS0rnqXD82A+5Gj4sNRBAPAfsHvBPdNQMntq2RA+f1N6fV0semxUdEsxbQKl8ROMJiKh
	nEmU0CAIRme+DaP8NLJoLtGvn0d4jqLTl/YYNhoOuBFd6VHObxKW+Rv6ali2MFqcd2Zl
	ZprWL/zPHNeVVeb++J34k/LopH2wStEfL+sWIw2FXNSELrPhpwThld2Y7HLgLEpJWQ0l
	1udHjMSNAtpD/Ao+G4sB4THOvHHeDiQBLSHt54OhKotVp3UnPqMsVjlY8DNIQYxZBYN/
	HbTA==
X-Gm-Message-State: APjAAAUZHJxfaVDxdpJBdIoVk7i5cwh+jPdU8sl8fO8eeIVJFcOoNPRX
	euCg7ot23sHum5gBvEm3dSLTeaUiyGE=
X-Google-Smtp-Source: APXvYqyI3I3x2mWZeu2cpADf0s6onMgs9RNXgarvpdnd5M0zi/LPZXdxCxuCcrCauVG8VTTxKyPvwg==
X-Received: by 2002:aa7:8494:: with SMTP id u20mr1377517pfn.76.1555745724610; 
	Sat, 20 Apr 2019 00:35:24 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:28 -1000
Message-Id: <20190420073442.7488-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH 24/38] target/s390x: Use tcg_gen_abs_i64
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073428.OhyF0wCie8bLwzE8xUjNhp4dN5E-Wadst7AAO4udJMw@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/translate.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 0afa8f7ca5..030129acbb 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1407,13 +1407,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
 
 static DisasJumpType op_abs(DisasContext *s, DisasOps *o)
 {
-    TCGv_i64 z, n;
-    z = tcg_const_i64(0);
-    n = tcg_temp_new_i64();
-    tcg_gen_neg_i64(n, o->in2);
-    tcg_gen_movcond_i64(TCG_COND_LT, o->out, o->in2, z, n, o->in2);
-    tcg_temp_free_i64(n);
-    tcg_temp_free_i64(z);
+    tcg_gen_abs_i64(o->out, o->in2);
     return DISAS_NEXT;
 }
 
-- 
2.17.1


