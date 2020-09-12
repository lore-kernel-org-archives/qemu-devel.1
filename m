Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C6EC43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60EC0214F1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnSNChIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EC0214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHENX-0007SK-Fh
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 18:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHEHR-0003f2-At; Sat, 12 Sep 2020 18:46:01 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHEHN-0004Tr-2Z; Sat, 12 Sep 2020 18:46:00 -0400
Received: by mail-pf1-x442.google.com with SMTP id d9so9692250pfd.3;
 Sat, 12 Sep 2020 15:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cB+r+dkpxaxYLpmfHgr9Ib2dc/r134/ZQOU509IQ9fY=;
 b=SnSNChIMzAJ3Qda83+EybTQLUSwUWZEuD9B48pqRrljugAFnqSmjp4lYWbdratmqB/
 QbIXaTed3PA7KiqE/pXF0gdFDhwyY5pnKOicRIMCFfDTO4FIsL+1ErF+9dafxaN/pizH
 1yxmiK0AodAum2HhLFHb9pFMB/hMGIol+uBFvWBLGq5Tsvjqu2XZ7BkFAf6fllwvysxy
 Th3ow8Nj/Xe3cTZpv9zTaoaL7oGPrPXHuPMPAYbLKqkY5ju30VFJXIUCTIIFwfs69dFQ
 KakKXamJRCB0+/uPmKyQ2EM14xBCo4pi02AF6L43xVUoxLD8xaBJNhqV1E5OPBHR0a94
 uIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cB+r+dkpxaxYLpmfHgr9Ib2dc/r134/ZQOU509IQ9fY=;
 b=Zol0RjKXkzjjZ7GbVOTm8U7cYf0qc0yV2VfF4NGmiL/0kLziTEX+7QhmjAB4wr+g5l
 gtH5B7OYI3XHEpfSbn8GqvEf9CYFyt9xFrvSAVq8BlF3vrbHVgQIlFnEg+yVLbzZguf3
 2Gawt4zZ6AP9SRMhO6vWkzTQ68PcrFBAsqybFOJEshVw+LxwI5Ei7maE7M6qm737WW4H
 c0ubL7wCnmrSgn0aeVqEAPzmtS1jgGhCR5uY48ruJARuwQ2ghpLejQB6XrYSy9sHL3lN
 G+IqTkvrSwEY8d9buv170A4hrgMZSFaLBGFmKz2tofeQoW02gykLJ1Za3urc1egIVYm0
 3TQw==
X-Gm-Message-State: AOAM530ti0JLwTi40N9xnmIzZk0FRoGiFYKbnbV4RWEU1KCwH8wYDUuD
 79+CvquhPEQbLDEqi/hB+VhvomwlGlOEDAJeL6E=
X-Google-Smtp-Source: ABdhPJzhj5Z9iC+u0TXbRKNL3cNw7YGn97y6b+VROnwxOVA2nukLe6/lET0/wjgEr0pDb0P7MDu89g==
X-Received: by 2002:a63:ff06:: with SMTP id k6mr6042657pgi.321.1599950754886; 
 Sat, 12 Sep 2020 15:45:54 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id t10sm4639266pgp.15.2020.09.12.15.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 15:45:54 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 15/27] vmstate: Fixes test-vmstate.c on msys2/mingw
Date: Sun, 13 Sep 2020 06:44:19 +0800
Message-Id: <20200912224431.1428-16-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200912224431.1428-1-luoyonggang@gmail.com>
References: <20200912224431.1428-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x442.google.com
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
index 1c763015d0..ac38bfcfe8 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -34,7 +34,6 @@
 #include "qemu/module.h"
 #include "io/channel-file.h"
 
-static char temp_file[] = "/tmp/vmst.test.XXXXXX";
 static int temp_fd;
 
 
@@ -1484,6 +1483,8 @@ static void test_tmp_struct(void)
 
 int main(int argc, char **argv)
 {
+    g_autofree char *temp_file = g_strdup_printf(
+        "%s/vmst.test.XXXXXX", g_get_tmp_dir());
     temp_fd = mkstemp(temp_file);
 
     module_call_init(MODULE_INIT_QOM);
-- 
2.28.0.windows.1


