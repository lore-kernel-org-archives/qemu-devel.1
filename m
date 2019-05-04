Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B9FC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4491206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T64XIfr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4491206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51965 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMo0b-0004kK-1R
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 02:18:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMncA-000890-CP
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnc9-0004cg-ER
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:38 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnc9-0004ag-73
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:37 -0400
Received: by mail-pg1-x543.google.com with SMTP id z16so3752708pgv.11
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ceuwSjt3kxNVh2jVmVheMvD/TRbf+fHQnKrqah+IplI=;
	b=T64XIfr1ux7D7tmhGwSQM6aNFkKpgMT0dAgndGEzSJv4IjOXOPOzQDzP1AJwxk/jLU
	/Lgkj7hmOlteFzFjbKV0Vld1mSm1qSYt+0Ld/vALjyD0KfXtkIws8ju6r7PR9v7odcNE
	vhbcV+1MiVgmNYC0U8IdBe81MBc5b6xMqxfh6DeGGtREnJs+rnKzulxrwExpLCVU309W
	kGJEucwnS0aeKZY8Giphf7XDP9qK6Ffm99z3VavvwvGleBwyGCDZ0ufMSfobedgdGLx9
	vdczKigVHomUC+l45gOmESnRPSHEH82vUe/R7to3NRW7gVvPVWFUJ2uc+NxGiJs/TUgF
	JJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ceuwSjt3kxNVh2jVmVheMvD/TRbf+fHQnKrqah+IplI=;
	b=TJnc9GzHHFyztQQzFWP1EG2SA4t0EPBVYgp9p7p9QnBGiDyr/n94FuilHu3Jrcxspu
	6hSlZ4b8lbO2HZZXDPz8MhuUAmN3SCr9W1WnVRIyQdZlme7udDDI4vhFUQgJxAIBpgWI
	8OBr7DT5fm27FDBlqi1Y2Rn5IDK+SeAVw4hN/7cYzbHdD9HrL+ZTruED92F377UQco8Z
	YHQxU3VbAhAQnHOomxLBXIU324wKWdjHKLGv9nm6tRpg5D2uk3ORl2mgID+GK+N6OeHD
	KA9p09pkYp9P96G2MMUmOZnQz8j5ymn6TO6IptHqUccgDCSr0EFziw4CcU9Co7E3pWJ9
	bBZQ==
X-Gm-Message-State: APjAAAXY3IZQLgLWby9GvcCcr2aI/6lSGxmA9ciFfPXidjM/6fqgK6fk
	ZgG7dKb4/giCvXNIgEtlRvvIRt4s1aU=
X-Google-Smtp-Source: APXvYqxz6RQamqBt/tIP4cFDY1hXacPIaLUYMigdISkzBdCMyc3C/jdpFdLjWSPZeE7D+atvVT8LVA==
X-Received: by 2002:a63:ee01:: with SMTP id e1mr15731788pgi.20.1556949216024; 
	Fri, 03 May 2019 22:53:36 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:57 -0700
Message-Id: <20190504055300.18426-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v3 28/31] target/s390x: Use tcg_gen_abs_i64
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
Message-ID: <20190504055257.0Yp4Du1E4BKH9GvJp_O9zTcgYaArDpnS1kK-QWKC2eA@z>

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/translate.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index d4951836ad..e8e8a79b7d 100644
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


