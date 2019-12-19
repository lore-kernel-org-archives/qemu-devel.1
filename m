Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F4BC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518F3222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ult61Fm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518F3222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtfM-0007Sx-Ak
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtWd-0003oB-6a
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:59:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtWb-0000tP-AS
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:59:22 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:33213)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtWb-0000nx-0z
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:59:21 -0500
Received: by mail-wm1-x32e.google.com with SMTP id d139so6769579wmd.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 02:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G90giGYO7nxhno/z+r32FbzYuyDm/iXKiuSb+w5/6TE=;
 b=Ult61Fm21X6ymHJREtKIA8UBETAmW2Icw7I366D2pGafyp1LJxA/R0HwNdoVb11Bb5
 zP4tECh/PmgT+hTPCbBsELje9aUI8Z+ul4SztgJ7o7Vb866u9oYhBZ4VmzlwIiWhdQtR
 P5PuBTNIyIYl/+bxUOwilqMGVSD9VGSanjhFxZoQlYaJMGSv/NXHaZsf0c29wZKUEPSl
 /mu5xZ/j135Ktw/2uH3Oxj0Jki+jyEt7HTvHbSZJKTXMnc3qXebniGE/VCFg9IqTnlov
 2TdoxvfCI4CayAOMoeTK5EjTPhxnkmNMEIo5uwdQtpqLvgU0Yo+FM9NJZZH90agUjCS3
 cQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=G90giGYO7nxhno/z+r32FbzYuyDm/iXKiuSb+w5/6TE=;
 b=WIjWJT9YgqqaCjopCTGYPXTK0MPFajcpQhdxc2oT8qPiWXCK6Ij2nesa2IPUrbdsV3
 6mm0kfbzxND9LhABZA4Ur43IhDZVqmaPYEEtmYqvzZUXRCwoF0hFutCLJ+AJqwcoImfl
 sd9So5cSLS3WGPZzYI86YepmpUgKN+33neJ5BuH3o9U0HArRWqF09bKhn2im7rk2tA+U
 oAwyqHog+2e98mofChVp/5LB3Mgh2XydS4z+6vfTRoOZsZyjEc7cPwUPa+XsbxUG72eh
 c9p9cs+uyPIOXwCJUSGRnYiJ/xo6oGl7OhTvhgEqX5KCnTYV+VbRmOrfdn50lkCwnd9B
 W9Yw==
X-Gm-Message-State: APjAAAVCXzHfuUCes/nLQHZSP1nETZJ9OJK5OqBKkZwKCudSQPiBX1ts
 7UF4AvejxB4B593GaEJHwjSZDQ==
X-Google-Smtp-Source: APXvYqwojuo0XdrLYS97dVXcCO/RMykts5+FBIqT9bOP62vXJ7HbqxAEBGJ3X7JluowcOsgJh9kyKw==
X-Received: by 2002:a05:600c:248:: with SMTP id
 8mr9583046wmj.175.1576753159844; 
 Thu, 19 Dec 2019 02:59:19 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g7sm6091077wrq.21.2019.12.19.02.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 02:59:16 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0725F1FFA3;
 Thu, 19 Dec 2019 10:49:36 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 16/25] Added tests for close and change of logfile.
Date: Thu, 19 Dec 2019 10:49:25 +0000
Message-Id: <20191219104934.866-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219104934.866-1-alex.bennee@linaro.org>
References: <20191219104934.866-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

One test ensures that the logfile handle is still valid even if
the logfile is changed during logging.
The other test validates that the logfile handle remains valid under
the logfile lock even if the logfile is closed.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191118211528.3221-7-robert.foley@linaro.org>

diff --git a/tests/test-logging.c b/tests/test-logging.c
index a12585f70af..1e646f045dc 100644
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
2.20.1


