Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1792DC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0CF520BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBIi3akh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CF520BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJyh-00034g-Pr
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJsx-0000r4-Mo; Thu, 10 Sep 2020 06:33:01 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJsu-0003FM-MN; Thu, 10 Sep 2020 06:32:59 -0400
Received: by mail-pl1-x641.google.com with SMTP id c3so702584plz.5;
 Thu, 10 Sep 2020 03:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d4V5+f7th16w4eXVSrbBNtRXwx9t+794yZg73jLRtbY=;
 b=WBIi3akhold3nnkwriOk8R8ZZv7EoXy+jLRoDuFgjEnpOQROSaEsTJFLbeNqYKrSXR
 KaENTz6L5fMdZZdR2WbxJ0+VBvuHLpUuWqPmgfKSy8BQP7nu7m0ArJNN+zX+pFMXQpzt
 Eym0JMXgcOpGLFr8CPpof8nl5a77oCh6xUgNk7EWaLLDubVaQN0ysfGXKJGLW25SzEpG
 3L5uEBANq+mRVTn6AWkabybue8WCH0fCmhx7LBYviA5XS3QJCYvDim/HTEsIpekAZ/tv
 QG+5YaH9FA0ySfDpciF0l7OoSGDnYadjOYYHOfVUZJfez4rdJFPsad2KP+T8MJx/ykRU
 +SBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d4V5+f7th16w4eXVSrbBNtRXwx9t+794yZg73jLRtbY=;
 b=glQTFXsLQesDyNGu8xnCx9jyQ8ALIJJoxWlIL+dpI60kTgiRISB0EqHB1c7PvPsoG1
 DIu7x/x9eTzdTlRfbjudI7S3ZHwNO29AZF6xB9csWpBF1nQlTEPLiRD1jECiLhet3bdN
 z/MTRg4G4yXWMpMNK2uWP1Aj1OJYomuzEE4eBhqVMM7XG2VMW8i1u7fYczQApT5GnaGG
 Q+7n1WscHv4vztcsppFYDIHXsQxorqOrOgug6QhSW/UT76+uP1En1jUhTxkJqK/kVGU+
 tFJi5mWcCn4SUBkdvOi5lVESV1eDqYcim6QGJqFvfUI7g6vmtv+fnelwIA+9XN9NHQHy
 RD5Q==
X-Gm-Message-State: AOAM530k6wzTgpBecr/Ogc5IHx53xkjZV0UiKozLArkfS96rtAvFLTvO
 JBd0rkvRc3AnXwiu3fl7jGSdb5N8+x5299vG7wo=
X-Google-Smtp-Source: ABdhPJykQI3wCt8tiD4L6nfxaL5wigKHjpAonOrdnBqzblGKbxe281ggWSTM8t1GZvLdoS3uxTxFng==
X-Received: by 2002:a17:90a:ea0c:: with SMTP id
 w12mr4646656pjy.65.1599733974580; 
 Thu, 10 Sep 2020 03:32:54 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id g21sm2000203pfh.30.2020.09.10.03.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 03:32:53 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 16/25] vmstate: Fixes test-vmstate.c on msys2/mingw
Date: Thu, 10 Sep 2020 18:30:50 +0800
Message-Id: <20200910103059.987-17-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200910103059.987-1-luoyonggang@gmail.com>
References: <20200910103059.987-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x641.google.com
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
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/test-vmstate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index f8de709a0b..fc38e93d29 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -34,7 +34,6 @@
 #include "qemu/module.h"
 #include "io/channel-file.h"
 
-static char temp_file[] = "/tmp/vmst.test.XXXXXX";
 static int temp_fd;
 
 
@@ -1487,6 +1486,8 @@ static void test_tmp_struct(void)
 
 int main(int argc, char **argv)
 {
+    g_autofree char *temp_file = g_strdup_printf(
+        "%s/vmst.test.XXXXXX", g_get_tmp_dir());
     temp_fd = mkstemp(temp_file);
 
     module_call_init(MODULE_INIT_QOM);
-- 
2.28.0.windows.1


