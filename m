Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19976C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D88A020737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z8oriZLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88A020737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfYp-0002YJ-1C
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jOfUr-0002Db-DU
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jOfUq-00038D-9f
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:42:21 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39953)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jOfUq-00037t-2u
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:42:20 -0400
Received: by mail-wm1-x343.google.com with SMTP id a81so18368554wmf.5
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xbro/RkD78CkyyXw+NBefFNc/SpIU1l0Ej5jYONi0ms=;
 b=Z8oriZLafPy1iDQxG3Fe9GeQv78TtU963w4AhWk6iHSTB9iK7i334CwDJSsL1HAIZ8
 R5SsYqQ/Yzgs18TP1rGfzSybzphIRIAdttoj5M0IfYn5oHPa57+nGy8HIb0pRx1AmPkM
 9+QuJOOgtJ8u8oERT4F/ss6WcSm/Y2RLafTr8S0XqePZc0WWk5wjK/7a9jXb3ylRPtC4
 hUfWtWoxizcsdQDfZRBI1pjN/tU7uRgdY72hly0j76/Cu2glTi8EQRPnwP59PLIVOnLp
 K9SJB0aA7gUTcMQd7X/Nc6zzQJMWx26kuOSb730B6w+R1MR9gBG/vNVa7nkSFPYVsTgB
 QJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xbro/RkD78CkyyXw+NBefFNc/SpIU1l0Ej5jYONi0ms=;
 b=A9ICF1nPbhAvSyXZa3zlrgXd27qFu+oOTyCQ4c4hDjQ09Np9z1fkASiNOL34MhRYJU
 sxfgfmpzfyO/VB6WtuvVC/D/gnzLA5ETBa3o5z6tSouaa1+Qk9I7z2Z6FluC7qBqM+WH
 JtkN15Gi4zsRVPbVLrP0nhl4Se+e5evrNA6cFp0I/7EfpyiykvjSPLQsCOYToRIs8Glo
 vdNgK4GPw8NffPqKwf/sOTGCn72HJL0/xh6QGOHMt7t5pJ+BkL/mVpl+3TEMSy2mbIMj
 JWlvJWwsbI/Koyjet1mOnwUXFmjH2RuF5VffWUth6KZTnIsVoN48jDKToh+S7VZ27UXe
 Zh9A==
X-Gm-Message-State: AGi0PuaTKddSmC3qxyr7T6tOeQdyd+xCamGoH7iuxiyuACzB3BKHlPWx
 I4JAHQTug2UCtRhK3rHTbpoAfw==
X-Google-Smtp-Source: APiQypICNbw5c2xGu4wILI6O2VWgnWV1pnQQ5vHgstO9uTNEL4QbB+Im7Ng25Bxj1P5cZog1CB3kFQ==
X-Received: by 2002:a7b:c755:: with SMTP id w21mr4465467wmk.120.1586947339104; 
 Wed, 15 Apr 2020 03:42:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r27sm3810254wra.83.2020.04.15.03.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2020 03:42:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5689F1FF90;
 Wed, 15 Apr 2020 11:42:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 4/8] linux-user: fix /proc/self/stat handling
Date: Wed, 15 Apr 2020 11:42:07 +0100
Message-Id: <20200415104211.9388-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415104211.9388-1-alex.bennee@linaro.org>
References: <20200415104211.9388-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Brice Goglin <Brice.Goglin@inria.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the original bug report long files names in Guix caused
/proc/self/stat be truncated without the trailing ") " as specified in
proc manpage which says:
    (2) comm  %s
           The  filename of the executable, in parentheses.  This
           is visible whether or not the  executable  is  swapped
           out.

In the kernel this is currently done by do_task_stat calling
proc_task_name() which uses a structure limited by TASK_COMM_LEN (16).

Additionally it should only be reporting the executable name rather
than the full path. Fix both these failings while cleaning up the code
to use GString to build up the reported values. As the whole function
is cleaned up also adjust the white space to the current coding style.

Message-ID: <fb4c55fa-d539-67ee-c6c9-de8fb63c8488@inria.fr>
Reported-by: Brice Goglin <Brice.Goglin@inria.fr>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200414200631.12799-10-alex.bennee@linaro.org>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6495ddc4cda..674f70e70a5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7295,34 +7295,29 @@ static int open_self_stat(void *cpu_env, int fd)
 {
     CPUState *cpu = env_cpu((CPUArchState *)cpu_env);
     TaskState *ts = cpu->opaque;
-    abi_ulong start_stack = ts->info->start_stack;
+    g_autoptr(GString) buf = g_string_new(NULL);
     int i;
 
     for (i = 0; i < 44; i++) {
-      char buf[128];
-      int len;
-      uint64_t val = 0;
-
-      if (i == 0) {
-        /* pid */
-        val = getpid();
-        snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
-      } else if (i == 1) {
-        /* app name */
-        snprintf(buf, sizeof(buf), "(%s) ", ts->bprm->argv[0]);
-      } else if (i == 27) {
-        /* stack bottom */
-        val = start_stack;
-        snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
-      } else {
-        /* for the rest, there is MasterCard */
-        snprintf(buf, sizeof(buf), "0%c", i == 43 ? '\n' : ' ');
-      }
+        if (i == 0) {
+            /* pid */
+            g_string_printf(buf, FMT_pid " ", getpid());
+        } else if (i == 1) {
+            /* app name */
+            gchar *bin = g_strrstr(ts->bprm->argv[0], "/");
+            bin = bin ? bin + 1 : ts->bprm->argv[0];
+            g_string_printf(buf, "(%.15s) ", bin);
+        } else if (i == 27) {
+            /* stack bottom */
+            g_string_printf(buf, TARGET_ABI_FMT_ld " ", ts->info->start_stack);
+        } else {
+            /* for the rest, there is MasterCard */
+            g_string_printf(buf, "0%c", i == 43 ? '\n' : ' ');
+        }
 
-      len = strlen(buf);
-      if (write(fd, buf, len) != len) {
-          return -1;
-      }
+        if (write(fd, buf->str, buf->len) != buf->len) {
+            return -1;
+        }
     }
 
     return 0;
-- 
2.20.1


