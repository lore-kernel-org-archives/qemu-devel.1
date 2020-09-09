Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F9EC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:55:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8430821D79
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLVyoFZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8430821D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwoz-0002yF-F7
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwhT-0007J5-M2; Wed, 09 Sep 2020 05:47:36 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwhQ-0007lK-Vr; Wed, 09 Sep 2020 05:47:35 -0400
Received: by mail-pg1-x544.google.com with SMTP id j34so1679607pgi.7;
 Wed, 09 Sep 2020 02:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1H3XAjUyQVQg87Q3viZPdyOz1U48/GMRVDi4jjT6ZrI=;
 b=MLVyoFZbLRdUS6mWF0I/1V99HZZuuSbgP4lBJPZTjERGzbHBJ3VvpTujyPs3AbYDNK
 QS9VKq3gDT3T+FQGKfiuv/b00fnRZM4FV4EeVRj2JF2a+QEAsSbX5x/3P7kvPe5L5ggT
 Y43urd9FQpq8ZwvAfHBW+ufH9q6FeUfI2q9nVjmK+aplxX7JrLWtJHA40O8hMs9Qs2gC
 01PCMcSwfSUB+Zhevih9PCsAc+lkMol2CqVXS7LmISumRQJcKmmbjH/slarrs/o9YM7a
 SuyWKB7+hN4l07vamX3r35GRwUCoTibi2HvKqgPbHYj3WLZnl29ZRbKW52erPOLtrcu8
 pGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1H3XAjUyQVQg87Q3viZPdyOz1U48/GMRVDi4jjT6ZrI=;
 b=BsRl1R2e/F3psKkHrz26/4hVPyd9Y/YmAbkTnM+6/w7FoqpbAiN6rcAexAULkrOYsS
 UGnAvWMbLHmHN7GqtncHQ3/Mv7GkpbYppCfnot8V0Xj7AKaLOO9R8SniblyLTTgbhxEE
 yr/Ln1DX1Pf+6JTAa4z8ZvSgc+kxmffWqH69Y32USgbRuxoMa8cFoRMIPu8hfzqCn92t
 4aUndJZwHaVx6B+feWYk0BlOfq2Khn9OcRs2UbcX/rNN2kZE/4RN+yZz2b8WC3MvAQ9T
 9lWFuiJ7xyMrm7WN8WPler00V8oL4C4vFcY0NaLaqeARqDVfv/qmkAqyxqYYiZwpFPfx
 c13A==
X-Gm-Message-State: AOAM532FtQIwuXgDHE0MHbVawPCd9/0nSQkiryAr2YpbgSoy/msDhdoY
 DtFXuRKpLfQwXsKRSclMf4biRFX7d+RTDbnf
X-Google-Smtp-Source: ABdhPJxKy1jW8PzjttVOe+FiVdxzvit4xS+TLkq1yxB5GvOUlVHx8fwEAOGs7PExx1DNBpNDABQ3oA==
X-Received: by 2002:a63:4556:: with SMTP id u22mr25864pgk.248.1599644849123;
 Wed, 09 Sep 2020 02:47:29 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 64sm1708312pgi.90.2020.09.09.02.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 02:47:28 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/21] vmstate: Fixes test-vmstate.c on msys2/mingw
Date: Wed,  9 Sep 2020 17:46:09 +0800
Message-Id: <20200909094617.1582-14-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909094617.1582-1-luoyonggang@gmail.com>
References: <20200909094617.1582-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x544.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The vmstate are valid on win32, just need generate tmp path properly

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/test-vmstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index f8de709a0b..51fe8e8ec5 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -34,7 +34,6 @@
 #include "qemu/module.h"
 #include "io/channel-file.h"
 
-static char temp_file[] = "/tmp/vmst.test.XXXXXX";
 static int temp_fd;
 
 
@@ -1487,6 +1486,7 @@ static void test_tmp_struct(void)
 
 int main(int argc, char **argv)
 {
+    g_autofree char *temp_file = g_strdup_printf("%s/vmst.test.XXXXXX", g_get_tmp_dir());
     temp_fd = mkstemp(temp_file);
 
     module_call_init(MODULE_INIT_QOM);
-- 
2.28.0.windows.1


