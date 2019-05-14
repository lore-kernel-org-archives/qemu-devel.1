Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EA2C04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D61AA217F5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eakOqkHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61AA217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36812 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQLDL-00072d-46
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 20:22:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQL2y-0004h8-OR
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKxi-0003ur-Bn
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:11:22 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKxg-0003gW-4v
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:30 -0400
Received: by mail-pg1-x543.google.com with SMTP id j26so7598220pgl.5
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=YokYl3JyovfmDfQXuf+lxigUFluEl1v9bGn/sssho6E=;
	b=eakOqkHpFvRoos90HDt/mJSzWzOkf6TeNWGb6U+t7AYbYhpBGpznvBLcJllDjgWgo4
	suqLrP6NRLM6WluiwQBpsRh4JQ+B6iHUBtucBnS9PtIJxOQsUTfDeAHbELsqEykvH66j
	QFoY2K9olf0LgpvLArkkoyVvKmUOXQtESfDmYtX1oCCuPInvXe6wga92DBCr8SmFVfqx
	CLaq4jEDt4LeZUoZndpgyCkGh/h/nqYcTHCuHqH/UAVJ9j8DpmmiITwgfOyRS7otBuyr
	1rZNLDS6tGCZfZnzZ9+i81Pt9O4skgYFYykfk3Y4Jo/l8EcRVvLolb/H9x4NbEA2z67y
	yKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=YokYl3JyovfmDfQXuf+lxigUFluEl1v9bGn/sssho6E=;
	b=X0VVEusuDrieKCrGbiLIxHv19cG8lQ+AbuWRvugHs+fCSAKPvbME4MYZDGr+l3/X2Y
	Ma4DoMN+gYCtyAHdE4jnk3pg5+J9MWzOJVf+MM++H8wh8M9dqojg2cHNmOtYwXLqRaq0
	Zxq7/9cUGCHTC/8KOtGVzFDnwuYT+d60ZktxXbzq60xsDBt0tWP4pnVs9+w9nWpNhqGZ
	NqO1oKdrc9wnKIjTetJVQgRtUAniTJeVY+N4Bp5n8sP9kVEkv5UCSooI3EE79MNfijw/
	YCJ3RAs5h3GA9EKaswWJVNyJa/gQ4qwplHxngu1eDGhXBXOjzv6iQhuxvqEvyi6uDsHR
	j7UQ==
X-Gm-Message-State: APjAAAXJkRtrwh+e93LqLBA5lAaNirsREt6s8w2gGV9l2FSWI3U3ke4V
	k56sMu34QlM5TGyhTRq7YtA4fMvGjrw=
X-Google-Smtp-Source: APXvYqziIRn8Vfim1I3ObfdUdgFfe+nhT+6KP6TCJJ5i6cu9EQFrjcz59aN92fdfPRsYUPdipakmQg==
X-Received: by 2002:a63:a84c:: with SMTP id i12mr35515549pgp.115.1557792375444;
	Mon, 13 May 2019 17:06:15 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.06.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:06:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:34 -0700
Message-Id: <20190514000540.4313-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
References: <20190514000540.4313-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PULL 25/31] target/cris: Use tcg_gen_abs_tl
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


