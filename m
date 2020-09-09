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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D04C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:16:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D1D206A2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHDrZhyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D1D206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG2m7-0002jX-Jh
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 12:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG2kh-0000eV-Hw; Wed, 09 Sep 2020 12:15:19 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG2kg-0006YP-11; Wed, 09 Sep 2020 12:15:19 -0400
Received: by mail-pf1-x443.google.com with SMTP id c196so2717700pfc.0;
 Wed, 09 Sep 2020 09:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d4V5+f7th16w4eXVSrbBNtRXwx9t+794yZg73jLRtbY=;
 b=dHDrZhyc2nSb+EmbIXGGyf2KKRrhM7W/UvO8vF/vrmRb4BXULz8ooGOh3yRIhYAMLQ
 d5zy4U2QfhrOvPmfqLehiXtXTJ9d7HIFAYzGIJ/1iLdAmaP91M8bkvcfbHnJkgc5KcLr
 AhjXaCDe0cGh+MsIAdXOjrJBozSgi5z5VovjVCCwq263yRAE18dXRCmiDo/SMGkjEH/D
 UuxiRmhbmXnZR8SFyoVVJFDeWPjgij0N6QjS5GTiTLSEhu72YZA2A5IxJV1fP/vQkoUX
 jZRgdSTxYw+TUbUlhVV0SzsdDTA82TfCgv8NSBm/Z3/6Rwi0cLc0TliCvjnJVOageZRH
 9rlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d4V5+f7th16w4eXVSrbBNtRXwx9t+794yZg73jLRtbY=;
 b=cYPLpRF09PZuK2F0usIN7sKPwnXpgCwsXWONGq/RhjkyVvchpEFIMitmqEYCnJVckS
 xlejgOfBhvZZRAQUnI5s5EdxN6WOpMZgH/sHi3G9ufE0BOViyENoz1JPK5zzXjJIbJwY
 bneuxvWnoWV7h4JXc2dhcxom8ZATI8TkTNCJgWu5e+UccY+5C/kgd+xbnI0oJRH53c8o
 O+gIG254ivyq/4N/gAzUxnjRa8rkgj0bRvUmN2azcIZR7qpOeDmVH5q9w5b3+ve5s9wJ
 8ZiNXZUc/pP04+m3x26lyxUx6LluLhOdX+16GcvsT+PierXEwXuWjMyb0/JrbaWQJLQg
 LBlA==
X-Gm-Message-State: AOAM533x47/p1OIn6d+dd3v4VeeaSHP+okkCs9IYrhvCYvNVPyjFqszJ
 Y5Vr8VOvVoT9TvDb/qmyU7ZJVbvPgYX0JHjE
X-Google-Smtp-Source: ABdhPJxu88nvOjsGhrj7bsD3z1oRFWIPGVY7sRDk94a/jFfeJ+eFmKgYezLrYJQYKI8AHhNOtc6fCw==
X-Received: by 2002:a17:902:ed13:b029:d0:89f1:9e32 with SMTP id
 b19-20020a170902ed13b02900d089f19e32mr1665723pld.14.1599668114380; 
 Wed, 09 Sep 2020 09:15:14 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id l123sm2506987pgl.24.2020.09.09.09.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 09:15:13 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 15/24] vmstate: Fixes test-vmstate.c on msys2/mingw
Date: Thu, 10 Sep 2020 00:14:26 +0800
Message-Id: <20200909161430.1789-7-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909161430.1789-1-luoyonggang@gmail.com>
References: <20200909161430.1789-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x443.google.com
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
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
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


