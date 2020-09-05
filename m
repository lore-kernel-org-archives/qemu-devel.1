Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D480C433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E61A020797
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th41kNbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61A020797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kERr7-0005JB-Rc
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 02:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERqL-0004tc-0O
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 02:38:33 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:37808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERqJ-00059l-H1
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 02:38:32 -0400
Received: by mail-pf1-x430.google.com with SMTP id w7so5798521pfi.4
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 23:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XNYSamI+iIMf0aV+bExJz9RJkd68vYHfLwHJYVN/lQs=;
 b=Th41kNbWoz5Ib+YqW1zTTylx/aChU32gL8OfeNQEHfkgw24ycWjoNcgM3mDUAjnWjd
 pqZ8chFKjpKh4BcVg1z38WscRFiCdQG7U5JVWM05MQHkJS2feKTLj4/RhZSaphXw8nDr
 h+s5TmrGpfNIUYN9AHg3aigH7SiIliA9m5FC2YiEfFFwiegpC8LpxqgXQ4ODW8L7X/Zo
 SvUT/UBGv6aCagSx/WNxmaIWZgdi9JHJ47SZd6LK+68oimOK5gqXw4MbFnwZwQYhbi7H
 CLYNKjAnB7xatP6FzYoKsoOW4L9LZIQNMbhDfhtvjwpdNcw4YG7zX9m7PjB4hC6jF1AS
 bwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XNYSamI+iIMf0aV+bExJz9RJkd68vYHfLwHJYVN/lQs=;
 b=JV9SIh7Ugia9jmKNO7UPU2ZhGoGBWZkhcsOeeexaRBKV4LYfhn4nir5ZZKqbD+cnHZ
 4heicHXlE/48yBDt5cIJ/gR+GdQTGv9u/BUU5Q30T12uIS3Z7wECafFGUdnGW+0oA6RG
 UZ6y0oPJyPT8/BllnAKK560VnEBS1LTyl38QnBE+4MqUk0mhBCmVArh/9zbCTw/PPYId
 z/VN18xFJiheL6h1G3DiiFDJMy8dUfDdJ0wxLLT6b4Lzk8EmPz2xPMH/gXis+c5a2cI6
 RaP9ZkxdATsXlV/xhgqPKa4rFL4SjKmMMwiVbeRVJcIrqLRMznDlAVO212AzcoIwKCuD
 b8qg==
X-Gm-Message-State: AOAM531QkyuMTicJAlxbpaoo4VPhpAiTpjCKg5w2w2TyTiwuMn1Z9q+i
 KgoJGsywOtUESdfvPC4arOGtO2D+7PlYXmL/
X-Google-Smtp-Source: ABdhPJx3m0YBDVIo4xvYNMIwqxzPuMW9cxjmg7WcufZmZ9BLE8bMyqrXnbLTQus7SFBoBN8+KVIm/Q==
X-Received: by 2002:a62:80c2:: with SMTP id j185mr2975283pfd.2.1599287909722; 
 Fri, 04 Sep 2020 23:38:29 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 193sm8213918pfu.169.2020.09.04.23.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 23:38:28 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests: fixes test-vmstate.c compile error on msys2
Date: Sat,  5 Sep 2020 14:38:13 +0800
Message-Id: <20200905063813.1875-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

../tests/test-vmstate.c: In function 'int_cmp':
../tests/test-vmstate.c:884:5: error: unknown type name 'uint'; did you mean 'uInt'?
  884 |     uint ua = GPOINTER_TO_UINT(a);
      |     ^~~~
      |     uInt
../tests/test-vmstate.c:885:5: error: unknown type name 'uint'; did you mean 'uInt'?
  885 |     uint ub = GPOINTER_TO_UINT(b);
      |     ^~~~
      |     uInt
make: *** [Makefile.ninja:5461：tests/test-vmstate.exe.p/test-vmstate.c.obj] 错误 1

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-vmstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index f7b3868881..f8de709a0b 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -881,8 +881,8 @@ static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
 /* ID comparison function */
 static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
 {
-    uint ua = GPOINTER_TO_UINT(a);
-    uint ub = GPOINTER_TO_UINT(b);
+    guint ua = GPOINTER_TO_UINT(a);
+    guint ub = GPOINTER_TO_UINT(b);
     return (ua > ub) - (ua < ub);
 }
 
-- 
2.28.0.windows.1


