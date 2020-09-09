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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EDBC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 654B521D79
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1WD9oKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654B521D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwkn-00049d-CH
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwh6-00071s-FF; Wed, 09 Sep 2020 05:47:12 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:39506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwh3-0007iZ-Vx; Wed, 09 Sep 2020 05:47:12 -0400
Received: by mail-pj1-x1043.google.com with SMTP id s2so1072946pjr.4;
 Wed, 09 Sep 2020 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tUjxHhiaHU9hEAJ1XQZ8uS7Hz0JekKVDba8C4SdQqRg=;
 b=D1WD9oKHPDt5fEFr7qqlZtzuRS3FOLxPJQ1HpaUZU82BZ/oo7GsAO3do/fF7aXzb9w
 4/N7+DHBglSPhDASLaUaJr1xjrWRtI+szdTNEflWVPn0H8zaRwx364vUedCjUV2ZmTrG
 8S+CtUY8ZDQx/qANKzm2sOgzOANbEHzmiIl8y+tIv1WT4P75AJJt3DXHyUrVQGUkCFy7
 TzOff4ZVHG3JmQE3AjPmeDpw8eEarA3zqJlmLFRCv1jr8gWO9k+5RSY1b/cR3hFEe0nA
 crgsDnHQ8lhLLHPkXbPKZIj8swcbfTau8uvS3dUO2yBkv955ruYB+JCB+lVuehoRfLSL
 fATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tUjxHhiaHU9hEAJ1XQZ8uS7Hz0JekKVDba8C4SdQqRg=;
 b=KzEOENvAR+AU9t6p8QaY+g/uSfmdHD3URBmv76o495ZP3ivgNtImnS0/sTSTe7dMy8
 9N6ZAu3dUuo6vU6TvZzeGNl3tK3sAvqp6kOShYBz5N3PdSYdtd1lTbhM8c0d4P+i9QU3
 lyG2VJRM7IvI3mPaCCSg+BY+UwtxSNjXvwqn0255w6OCtwnpM/pe/kjKPq8pWv1sshKa
 Dn9/mBlscD7Rt5GrY+RYTslXdTKX3yMBebb3XRlsCp+8IwjUvJLLSbz/3dfXHO7+6E/R
 RCuydx1LR9kO9HZCCK7dndvgQHZO6HB5pyzdix+Nqs5fez0rjIaxkdCasm1UM7IUQHpg
 Bm3A==
X-Gm-Message-State: AOAM532L/PjjF0uDb0SsLji4ikpw5TbYdBLD5Bfbt+Kj7/S9QwlrUe25
 XBfvrRIAvzRL9KHZE5gpNDOFZB84xFoPqa56
X-Google-Smtp-Source: ABdhPJx6RjhzTIUeQOwzAOnamw+FkD0CxZJ06NvkuE+a9TW8g3a57osbIqajFjG48TtH+035BGQ0mw==
X-Received: by 2002:a17:90a:aa94:: with SMTP id l20mr92561pjq.95.1599644827751; 
 Wed, 09 Sep 2020 02:47:07 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 64sm1708312pgi.90.2020.09.09.02.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 02:47:07 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/21] tests: test-replication disable
 /replication/secondary/* on msys2/mingw.
Date: Wed,  9 Sep 2020 17:46:04 +0800
Message-Id: <20200909094617.1582-9-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909094617.1582-1-luoyonggang@gmail.com>
References: <20200909094617.1582-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1043.google.com
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
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

They cause failure on msys2/mingw, that's because file-win32.c not implement
.bdrv_reopen_prepare/commit/abort yet.

> $ ./tests/test-replication.exe
> # random seed: R02S3f4d1c01af2b0a046990e0235c481faf
> 1..13
> # Start of replication tests
> # Start of primary tests
> ok 1 /replication/primary/read
> ok 2 /replication/primary/write
> ok 3 /replication/primary/start
> ok 4 /replication/primary/stop
> ok 5 /replication/primary/do_checkpoint
> ok 6 /replication/primary/get_error_all
> # End of primary tests
> # Start of secondary tests
> ok 7 /replication/secondary/read
> ok 8 /replication/secondary/write
> Unexpected error in bdrv_reopen_prepare() at ../block.c:4191:
> Block format 'file' used by node '#block4287' does not support reopening
> files

Can you try to find out what reopen this is?

I assume it's for switching between read-write and read-only. In this
case an implementation of .bdrv_reopen_prepare/commit/abort that can do
this switch is required.

This is more serious development work, so I can't propose a quick fix.

Alternatively, we could just declare replication unsupported on Windows
and let configure make sure that CONFIG_REPLICATION is never set for it.

<stefanha> luoyonggang: That might be missing functionality in block/file-win32.c.
* davidgiluk yawns and looks up
<stefanha> luoyonggang: The block/file-posix.c block driver supports .bdrv_reopen_*()
while block/file-win32.c does not. It's probably because no one has tried to implement it.
<luoyonggang> OK, I got the direction,
<luoyonggang> Just need implement .bdrv_reopen_*() functions in file-win32.c

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-replication.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/test-replication.c b/tests/test-replication.c
index e7cbd6b144..b067240add 100644
--- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -392,6 +392,7 @@ static void test_secondary_write(void)
     teardown_secondary();
 }
 
+#ifndef _WIN32
 static void test_secondary_start(void)
 {
     BlockBackend *top_blk, *local_blk;
@@ -546,6 +547,7 @@ static void test_secondary_get_error_all(void)
 
     teardown_secondary();
 }
+#endif
 
 static void sigabrt_handler(int signo)
 {
@@ -597,6 +599,7 @@ int main(int argc, char **argv)
     /* Secondary */
     g_test_add_func("/replication/secondary/read",  test_secondary_read);
     g_test_add_func("/replication/secondary/write", test_secondary_write);
+#ifndef _WIN32
     g_test_add_func("/replication/secondary/start", test_secondary_start);
     g_test_add_func("/replication/secondary/stop",  test_secondary_stop);
     g_test_add_func("/replication/secondary/continuous_replication",
@@ -605,6 +608,7 @@ int main(int argc, char **argv)
                     test_secondary_do_checkpoint);
     g_test_add_func("/replication/secondary/get_error_all",
                     test_secondary_get_error_all);
+#endif
 
     ret = g_test_run();
 
-- 
2.28.0.windows.1


