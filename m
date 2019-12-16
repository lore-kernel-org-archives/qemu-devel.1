Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78E2C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:42:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FBDB206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MkO8NnPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBDB206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igolb-0001l4-Kx
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:42:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1igoMt-0008LD-KB
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1igoMr-0001nC-Jt
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:16:51 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1igoMr-0001n2-Ct
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:16:49 -0500
Received: by mail-wr1-x443.google.com with SMTP id g17so6765963wro.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=grODXrfR2eDYomrBneZAL5WCQ1lKy+6FvdP9RcaBhKY=;
 b=MkO8NnPv5nJs0dw0z4AvYiSy1S6AqnbUZgCLXANN7kQgiuAJwqjuGCU39UdC4KfuhO
 BtecRYohSZ5RsIS/aDEBjqSWuN8I2de36NPe6PtgGcsDRmYKj56E7I1HDfCtzYy05HyS
 Fi53QlDXVYIMIPAThjpDWvhbvQzwGQ/QrfKDuIRI7ugFYyRxaXDe8KM7ITwv09UxcuUK
 8VfjAnp/oKoJqqIin3lgWd4jqTFzW6MW4iqKcApMOrhnOPlHuTLNw+ZmU8H/+gRbX2Tp
 0VRwVsuiqx3hUhJPUMD18f9ndD/bAqwRtKtTzOejga1wj4JBY9421KGMtkl+lgBCzD7k
 jIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=grODXrfR2eDYomrBneZAL5WCQ1lKy+6FvdP9RcaBhKY=;
 b=Nm8WSZTxhyEfalPIv22OJ1aAJdD9/MMqmFe+hn+ILf57HGDpdipvnXTg2Jk0Z7iQRO
 I+SIjpceeHlveWn+ubgnudw0M/6G92m+6sva3D8DHjJATcTKlp/vDZzwzdp7opXQ7F7I
 14lwsRJnJxeIG0BFU6MHUJP6RVc0rKXJRxyfXNq94xllraunA21J55srVigtg93WsBGk
 +Vl78HU8khydL6C7j5sF1CZKHuJE6OTHWKE8XnjA7QaOYNoGu6Od0KAJG2ituxynKrN0
 go1IeNCyvpDpCddK67Pne8HVLQLvuIpTenddn09ON/My+Y2sq6yR9xl6xgKv1jKfHtoE
 G7vg==
X-Gm-Message-State: APjAAAU2bvVQxoHn2x5hYPyjnLWNo4B5RJeECjYVi1CHYhqA2IZ5b62E
 yP2r1Z/3wTTnu5HNUTgA18EYow==
X-Google-Smtp-Source: APXvYqyrg1GDKGS97POE8EDL0BisOKidO4cPMN8hApEXr2wP05uixQseoUdY7Bo9wLYdzcr14GnEYg==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr28539684wrp.71.1576495008071; 
 Mon, 16 Dec 2019 03:16:48 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x26sm20353391wmc.30.2019.12.16.03.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:16:46 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B4F921FFA3;
 Mon, 16 Dec 2019 11:07:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 16/16] Added tests for close and change of logfile.
Date: Mon, 16 Dec 2019 11:07:32 +0000
Message-Id: <20191216110732.24027-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110732.24027-1-alex.bennee@linaro.org>
References: <20191216110732.24027-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
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
---
 tests/test-logging.c | 80 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

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


