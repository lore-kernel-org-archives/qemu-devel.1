Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A510CC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:22:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6796221743
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oQ4UOnvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6796221743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36451 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLhhV-0003Hk-Hq
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:22:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRm-0006lZ-7f
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRj-00035Y-6M
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:22 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRj-00034Q-1K
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:19 -0400
Received: by mail-pf1-x442.google.com with SMTP id z26so4260388pfg.6
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=dHRZSoCZAzfR/lJhx25t08WJnqWrvEbTqWzKUdTUjVE=;
	b=oQ4UOnvRZLHrm8iHTtPm7Ft6kkLTLZgR0AJ9rA5wNI93ZiF53CaCj77qYMobiBZwAw
	uZuCMOc10I7JRzb+N+ufYpwZ5WXm5ZIFRvXmgOwgwsxxm6FShFTV4qg073MQEtU6wniP
	bsOks//5vC3N8kopoa+tGBhxu9o9z95HmBGy0SVoldredlQ7sjnbBom5qTGkTqy19hdB
	yamE7G41r2iv2aXefpsjHQ7/7iPqa8ETfnVAPtiguoLx+qW2GUI/R0vLgUBrnlBRBtR1
	zg3PipVJk5JibeoCVY9HUe7Tl8R+V5B/wxxPbNhRAC4oh2CNDLqMyKdvyqLG7CHaKoBQ
	/pZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=dHRZSoCZAzfR/lJhx25t08WJnqWrvEbTqWzKUdTUjVE=;
	b=ewgqPCqPgRV10ckZPBln0HIiL8nbUBuMeuX8KYryDlU5ula1oCws/jW2S4R6kxNKxw
	hb29dt0ubRR1jEy2M6SLDaHal3ounhWHQae57GNg72UOg0Z+gaf2CDHixkywmnL6Ve6y
	hlBQ4ba8U2hxN7jQVaDYAPt/zH4YM4oEJQ6F8YYPRThPrp1AjQtfxpfdnl4kKuPn/AQS
	qaX3AtIZDXyP58YdlXFzNDb394DGVfjptPtzcqX5YgNnEpNHyPQOzFuEZ1rnil/jGwP9
	ZEa3qOg5A+nHJ9So+x6WVFZSLVZ3jV+4QQutUPDI4knK+Si5AK5hDxmxa0Q8bpo9Mv40
	R79g==
X-Gm-Message-State: APjAAAWrImi47cold7aHLEiS8+mXepolnmEWi3I2F6YZbbDcH7OVlHat
	yZHKqYxUk1SWezBNPvpiSqiDGrx8Ehw=
X-Google-Smtp-Source: APXvYqwN4eaiHOVjjSQGCwsTND8StAoY6DoiG+sj8/UOyGuKzxmHNCxGXi2BqFHwqNGcI+GvKExvBA==
X-Received: by 2002:a62:d205:: with SMTP id c5mr18822438pfg.219.1556687177435; 
	Tue, 30 Apr 2019 22:06:17 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.06.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:06:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 22:05:34 -0700
Message-Id: <20190501050536.15580-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v2 27/29] target/s390x: Use tcg_gen_abs_i64
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
Cc: David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501050534.veuUz-j4gNDF7tnZKfZp-eopuAqCik6ofLQe5J_KlMI@z>

Cc: David Hildenbrand <david@redhat.com>
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


