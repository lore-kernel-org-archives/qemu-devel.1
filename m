Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4287DC2BC11
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E202920658
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pz4IkLjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E202920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFjiu-0003mt-1g
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 15:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjcV-0006o6-4s; Tue, 08 Sep 2020 15:49:35 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjcT-0002YP-GL; Tue, 08 Sep 2020 15:49:34 -0400
Received: by mail-pf1-x441.google.com with SMTP id d6so27495pfn.9;
 Tue, 08 Sep 2020 12:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9VMmLATL4hLY9MeoSmcNwnDOjnsVNymdFAgQMcXeglM=;
 b=pz4IkLjK8gQWUXjVwDneCTJm3Owd5jgTCAkilSbIlKyREL3bW3t+9SJfpJBJ3jKjcr
 6M5GXy09Kf7xPlsg1ltYDJnbDuFp+SLzhuToSQQAlOznmAQKdFvWn8Le5+XyP5AEL2Hc
 kU5UYgevfWRTX7Z5bhOC1SSDJXGz847EnHaINBuIoyhdKosu1h8fdYwAPI2ZFKveO4+/
 lXGHYUgSsgyirlmEcVQwuav0GUfIr4YxB39REK5oxpnPUseXOliyTAJYCRZfS4qPjKq0
 WyKCnQghts/YmgPHxaNpPMEZXjZdA70rMPXmtSheIpIxkNVQj0tn+KRup7lSUHPHA6jO
 zneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9VMmLATL4hLY9MeoSmcNwnDOjnsVNymdFAgQMcXeglM=;
 b=SgjRBPQp7dFo9ZpvVh3oS90L2YIXQXF3mH1dBEcSHgFIFVRGATjEdKahN40u/moYj2
 qF0FLLFZmbngF33QgaM8WXDQpPhrPNQVunUsXEUrXr4GxBaGDhEMh9fkSvfzQ2lg1mJT
 ecnfu9rnX/e6viWmmDiwaqJR62IkwVCIuMQIEpKnewpyv1tjBCmdyJ6aKlXWRn9FAOKs
 mHXfnXn2Hz9Jh4L0isAo+K2MvmG9epzsoDA1ST9RzKslr6iMm3hqLv2j+v/HwRwIc54Y
 CspDpOrPa5gfhcOE1dUvW094njwyWEfFjsa3h37tQfHC8atkmj/p5OSO9MCkHZ4j/iu5
 0OKQ==
X-Gm-Message-State: AOAM5334FqFNS8yz7X8rn6wu1rtSxBrNmrfhkzIIVBIhtQOiCLUIt9Tp
 vip6ZBoGGVcQNNDxSCo8iIBMFtaLY3/ctyme
X-Google-Smtp-Source: ABdhPJzIgvb3QM/Xr6VxZDXvFm5dAVucnZ+CTpDQylrdcso2aEW8cYsdFy7sm7klA8XklHvzRvPOmg==
X-Received: by 2002:a63:b44f:: with SMTP id n15mr280153pgu.282.1599594571379; 
 Tue, 08 Sep 2020 12:49:31 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id n127sm216922pfn.155.2020.09.08.12.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 12:49:30 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/16] vmstate: Fixes test-vmstate.c on msys2/mingw
Date: Wed,  9 Sep 2020 03:48:17 +0800
Message-Id: <20200908194820.702-14-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908194820.702-1-luoyonggang@gmail.com>
References: <20200908194820.702-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x441.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The vmstate are valid on win32, just need generate tmp path properly

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/test-vmstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index f8de709a0b..4c453575bb 100644
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
+    g_autofree char* temp_file = g_strdup_printf("%s/vmst.test.XXXXXX", g_get_tmp_dir());
     temp_fd = mkstemp(temp_file);
 
     module_call_init(MODULE_INIT_QOM);
-- 
2.28.0.windows.1


