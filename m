Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E83C04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD6821473
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YM3lIN7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD6821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36735 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQL8N-0002tr-80
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 20:17:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQL3u-0004h8-8j
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKxe-0003qE-25
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:07:31 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKxb-0003iS-Ri
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:25 -0400
Received: by mail-pg1-x544.google.com with SMTP id t187so7586535pgb.13
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ceuwSjt3kxNVh2jVmVheMvD/TRbf+fHQnKrqah+IplI=;
	b=YM3lIN7ecRVVN96Zqwn3iTt3ZilJW4YCEcNw5L5LEGAKSF5X+pauae51nAl5dcRL8E
	BjwMplzL5TxfrmjPO5jP15Zx23/Dja9ESWt5syivIbsNp9q6BipXveJAkLNmyWEgpfYZ
	4+3x9R72QAhSaNZgmUTnofXdkw+YPCnVSQ/tsjWbegNCHWJrgi9BC3TtfYG5DLoXrnjD
	i8V6HKagriz2SjyW8tx4Wql41bez/4I8hCBKQz/1SX/hvckrK7ffhoZBFbxqg61hRf/Q
	ehD1ZUQq/YTMgoYCR/00gxPSpFK9pdl7sxdrrXafCJFqJycW3U898CjUxO0mE2XnhBut
	Sz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ceuwSjt3kxNVh2jVmVheMvD/TRbf+fHQnKrqah+IplI=;
	b=mk2Nsa2Y91dC21LjLDKL8gMPC6hotPhkI3/wh0SIt+HHReuKYsL4XdquPQjlP/xXtC
	O/Jgim1Lbu0kEi5AHL+UIRtXhFsghDp7bmYbYQRtTyiIXkKqwpauLglVnM4OEZF7o+qA
	3VmZK6XoWKIl1bYZezV6VaoJ5HTeFTF+WzzzJVG66RSEHxctZPjgGNcse/tMRrF63IXy
	g9vMmpiAyEWT9IQyXHxPdoOs0WDiAxIyWPA2fBW+gHtM2quf2zL+umkNDePU9vvAi55o
	+X/ZnbbjIuYiI+n+lMaQKIHaaMgo/a4RNCEEtLv1QLHAmTtbO5ROf0HrjpJNcyB5oxIH
	Tehw==
X-Gm-Message-State: APjAAAWwvSQjP6HcAn6lN/cqfuirDFjrQvuBVU5lAefZrNYHTHQ6wVJS
	O5bS0XfUWHEtQ5whZEFwkfq9M+hTSkk=
X-Google-Smtp-Source: APXvYqxwyA2VgIdG3t+IEyO3fyrwwSCFxhpJPX7G73pAcqF216VCMDK0WlYlCtNv9fjCFzdFBhdnFw==
X-Received: by 2002:a63:7c55:: with SMTP id l21mr10588783pgn.121.1557792378991;
	Mon, 13 May 2019 17:06:18 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.06.17
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:06:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:37 -0700
Message-Id: <20190514000540.4313-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
References: <20190514000540.4313-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PULL 28/31] target/s390x: Use tcg_gen_abs_i64
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


