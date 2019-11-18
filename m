Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8382C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83E07222DD
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dad+0U01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E07222DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWoVo-0002Hg-Jw
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 16:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iWoNI-0000F5-6L
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iWoNE-0005nz-AR
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:15:56 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:40687)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iWoNE-0005ne-4w
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:15:52 -0500
Received: by mail-pj1-x1041.google.com with SMTP id ep1so1854423pjb.7
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 13:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nB9UJp1tY01vA+O7nUtpyswqmIH2jEdG/Vc4ku6hyfs=;
 b=Dad+0U01jzs2l4tt+VDm7bNGm06VFMSN2gcaWsVewISGT50ZsTxtEMmdJoMNOBdLME
 14wjs6q6YKCuP0/aS2uAlHSHbrJpmoXXG+m4oqjsRJr+LT2eGgIQ/eI3zdVRaBCfBeCU
 T6uVavywPilx9/22qrtXaVjThUjH67zAFdYRkoTfRFbAQehB2YeUghi5xhmV4S4eEQZE
 3evmP65xUAmD7o2IaTnz35RkO8VVzmQvNqboJGZ57p4G/8QmcuroaGvjLNPp6IAt3xsm
 vE/ynRBl3wtJdw8Um/bo53S6L9eEzLSIvmM3OALDhEWB0dbiSncEsIDo3glWeNlewovV
 dAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nB9UJp1tY01vA+O7nUtpyswqmIH2jEdG/Vc4ku6hyfs=;
 b=sQzpIcJOugrSKlag5rwSYQTDDe196/ChKazlpWI7co15+iUT7vMpA/5YRrwIP0mglW
 xOlyGgOrA5pWR/4z3WqpQRV56q+AGUinrJefAxwrw+zzcjpxq8Eu4fDhaRDY6+ltDGYL
 tYlJZFcsg3vRQmSi5dwIxWfb4XqwEuPO0bYE44RED/9u0QxIFZMSg3gIlPQ2rGiH3VoC
 DBJDULfq4Zi9VfRYUTy/9AWCwylRlWyjLvClN3ZkZ9BRZnWqyyDVye9/UAHfXatzz6s/
 KJS+9zGydmqOgXF+oFOvAxmKqmsyVnWQOVhf20ollQoIF8Q5IYvz4K62VPfoUHp7ucAT
 avIw==
X-Gm-Message-State: APjAAAWBSJgT8udLscB0NrhZ38rTlhCmWO7lw6ZGTlkWXiU25FAXmrYk
 rETyMhpKVJnGjTmrXpBKeW88O+nJ4tU=
X-Google-Smtp-Source: APXvYqyVtr2sZWVI2ooQO2n9rEbDfeDy8xJIbUlQkz5AY9NBYyNkxCyseL2TzspWPrZRhGvpPZV/sw==
X-Received: by 2002:a17:90a:a405:: with SMTP id
 y5mr1439885pjp.102.1574111750942; 
 Mon, 18 Nov 2019 13:15:50 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id v15sm22301728pfe.44.2019.11.18.13.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 13:15:50 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/6] Added tests for close and change of logfile.
Date: Mon, 18 Nov 2019 16:15:28 -0500
Message-Id: <20191118211528.3221-7-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191118211528.3221-1-robert.foley@linaro.org>
References: <20191118211528.3221-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: richard.henderson@linaro.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

One test ensures that the logfile handle is still valid even if
the logfile is changed during logging.
The other test validates that the logfile handle remains valid under
the logfile lock even if the logfile is closed.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
v1
    - Changes for first round of code review comments.
    - Added in use of g_autofree, removed the g_free()s.
    - Added in use of logfile2 and changed sequence of asserts.
---
 tests/test-logging.c | 80 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tests/test-logging.c b/tests/test-logging.c
index a12585f70a..1e646f045d 100644
--- a/tests/test-logging.c
+++ b/tests/test-logging.c
@@ -108,6 +108,82 @@ static void test_parse_path(gconstpointer data)
     error_free_or_abort(&err);
 }
 
+static void test_logfile_write(gconstpointer data)
+{
+    QemuLogFile *logfile;
+    QemuLogFile *logfile2;
+    gchar const *dir = data;
+    Error *err = NULL;
+    g_autofree gchar *file_path;
+    g_autofree gchar *file_path1;
+    FILE *orig_fd;
+
+    /*
+     * Before starting test, set log flags, to ensure the file gets
+     * opened below with the call to qemu_set_log_filename().
+     * In cases where a logging backend other than log is used,
+     * this is needed.
+     */
+    qemu_set_log(CPU_LOG_TB_OUT_ASM);
+    file_path = g_build_filename(dir, "qemu_test_log_write0.log", NULL);
+    file_path1 = g_build_filename(dir, "qemu_test_log_write1.log", NULL);
+
+    /*
+     * Test that even if an open file handle is changed,
+     * our handle remains valid due to RCU.
+     */
+    qemu_set_log_filename(file_path, &err);
+    g_assert(!err);
+    rcu_read_lock();
+    logfile = atomic_rcu_read(&qemu_logfile);
+    orig_fd = logfile->fd;
+    g_assert(logfile && logfile->fd);
+    fprintf(logfile->fd, "%s 1st write to file\n", __func__);
+    fflush(logfile->fd);
+
+    /* Change the logfile and ensure that the handle is still valid. */
+    qemu_set_log_filename(file_path1, &err);
+    g_assert(!err);
+    logfile2 = atomic_rcu_read(&qemu_logfile);
+    g_assert(logfile->fd == orig_fd);
+    g_assert(logfile2->fd != logfile->fd);
+    fprintf(logfile->fd, "%s 2nd write to file\n", __func__);
+    fflush(logfile->fd);
+    rcu_read_unlock();
+}
+
+static void test_logfile_lock(gconstpointer data)
+{
+    FILE *logfile;
+    gchar const *dir = data;
+    Error *err = NULL;
+    g_autofree gchar *file_path;
+
+    file_path = g_build_filename(dir, "qemu_test_logfile_lock0.log", NULL);
+
+    /*
+     * Test the use of the logfile lock, such
+     * that even if an open file handle is closed,
+     * our handle remains valid for use due to RCU.
+     */
+    qemu_set_log_filename(file_path, &err);
+    logfile = qemu_log_lock();
+    g_assert(logfile);
+    fprintf(logfile, "%s 1st write to file\n", __func__);
+    fflush(logfile);
+
+    /*
+     * Initiate a close file and make sure our handle remains
+     * valid since we still have the logfile lock.
+     */
+    qemu_log_close();
+    fprintf(logfile, "%s 2nd write to file\n", __func__);
+    fflush(logfile);
+    qemu_log_unlock(logfile);
+
+    g_assert(!err);
+}
+
 /* Remove a directory and all its entries (non-recursive). */
 static void rmdir_full(gchar const *root)
 {
@@ -134,6 +210,10 @@ int main(int argc, char **argv)
 
     g_test_add_func("/logging/parse_range", test_parse_range);
     g_test_add_data_func("/logging/parse_path", tmp_path, test_parse_path);
+    g_test_add_data_func("/logging/logfile_write_path",
+                         tmp_path, test_logfile_write);
+    g_test_add_data_func("/logging/logfile_lock_path",
+                         tmp_path, test_logfile_lock);
 
     rc = g_test_run();
 
-- 
2.17.1


