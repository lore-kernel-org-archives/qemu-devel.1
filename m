Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E56C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1226F205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ngKMFjy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1226F205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbPaT-0001lu-7s
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPMF-0000N5-13
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:06:07 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:32870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPME-00022V-18
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:06:06 -0400
Received: by mail-ej1-x643.google.com with SMTP id n24so3988681ejd.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 07:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z8jXpAxep38NH+tQtqiVR0PvMkfpz3aIN7XElkKMn28=;
 b=ngKMFjy9TO80XtZGn7uw142jNG5nWlbLPqGX4DdQkMMcM7q7jNMvyYpTGezLwpMKgJ
 PwjEyr4Trv1+fWaVw7Dlq0z2FJOmAUh6Qi9EN2ljfPHhBwcMwMLKR2YUN+l1HrhIYMVA
 NRQvcQdwE7WPgNTcLVjmjsTnuU5q5oXstqAoHYCczWtei3dOZOd5CyTgDGTu1IeqJoQC
 KhzpefSQ5WelDOtLP1ezZaa35zST+Fi6+KkVfSx8C5EUY5UCvFDneyvVR2TX2fG3ULOd
 aVOYFRNduRMTbG8Lgofmn2auhkZpBZdeCU9QnQdPH7f4AbXMZ8xnh1bQF6XEgDrO7LSL
 +PZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z8jXpAxep38NH+tQtqiVR0PvMkfpz3aIN7XElkKMn28=;
 b=rGd4BDcdKSB3wpFU+KDDkjWgp6YC5bL8g8tKqExWj3Ui63qtreKlHHY9HHeMgiyoO4
 BaJ9tjGuMVDpxsJxdNeoqw359WAqwU2YyWIaLVBjp9dKDYNLZbUkBzQdZtGeLhIZV1BF
 hWUWbArb8wpScbShNSMLnng+tUZVj1kgLuLYB1oXnKJdnVBX5B9o2FB63Oz5N4v3Pq+s
 HubGbPJ1CwxHJB+iEr5LweTICtQx9NP7vTXXTcfPP+kGcDzkyUk5fgHdo04r+vkzxcMJ
 tNjKs/IeKXk72smutEOVj1wZVaEpAj4sO/yr9/fJliEki0B+mUe4g9ZmWPA2swCWJNyG
 E6cg==
X-Gm-Message-State: AOAM532FN2vY77ziXAuecH09+vnghKjGDyQx/o8r5tkIJPPMchbjEVdt
 4t9FAqNdVXvVS9Xs5I8v8decyQ==
X-Google-Smtp-Source: ABdhPJxTFGWlThngj7dQBp306RPHEuVe+eJcBB5lKFJPiS1Fv3EX/GFQbr0VXvCE/TgpQn4utf9OAw==
X-Received: by 2002:a17:906:ce39:: with SMTP id
 sd25mr3749331ejb.482.1589983564722; 
 Wed, 20 May 2020 07:06:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m5sm1965236ejk.27.2020.05.20.07.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 07:05:54 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5E95E1FF9C;
 Wed, 20 May 2020 15:05:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 13/15] linux-user: properly "unrealize" vCPU object
Date: Wed, 20 May 2020 15:05:39 +0100
Message-Id: <20200520140541.30256-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200520140541.30256-1-alex.bennee@linaro.org>
References: <20200520140541.30256-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Nikolay Igotti <igotti@gmail.com>,
 Riku Voipio <riku.voipio@iki.fi>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We shouldn't be messing around with the CPU list in linux-user save
for the very special case of do_fork(). When threads end we need to
properly follow QOM object lifetime handling and allow the eventual
cpu_common_unrealizefn to both remove the CPU and ensure any clean-up
actions are taken place, for example calling plugin exit hooks.

There is still a race condition to avoid so use the linux-user
specific clone_lock instead of the cpu_list_lock to avoid it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Nikolay Igotti <igotti@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>

---
v2
  - expand Cc list to QOM/QMP object lifetime experts
---
 linux-user/syscall.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff0..7f6700c54e3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7635,30 +7635,33 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             return -TARGET_ERESTARTSYS;
         }
 
-        cpu_list_lock();
+        pthread_mutex_lock(&clone_lock);
 
         if (CPU_NEXT(first_cpu)) {
-            TaskState *ts;
+            TaskState *ts = cpu->opaque;
 
-            /* Remove the CPU from the list.  */
-            QTAILQ_REMOVE_RCU(&cpus, cpu, node);
+            object_property_set_bool(OBJECT(cpu), false, "realized", NULL);
+            object_unref(OBJECT(cpu));
+            /*
+             * At this point the CPU should be unrealized and removed
+             * from cpu lists. We can clean-up the rest of the thread
+             * data without the lock held.
+             */
 
-            cpu_list_unlock();
+            pthread_mutex_unlock(&clone_lock);
 
-            ts = cpu->opaque;
             if (ts->child_tidptr) {
                 put_user_u32(0, ts->child_tidptr);
                 do_sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
                           NULL, NULL, 0);
             }
             thread_cpu = NULL;
-            object_unref(OBJECT(cpu));
             g_free(ts);
             rcu_unregister_thread();
             pthread_exit(NULL);
         }
 
-        cpu_list_unlock();
+        pthread_mutex_unlock(&clone_lock);
         preexit_cleanup(cpu_env, arg1);
         _exit(arg1);
         return 0; /* avoid warning */
-- 
2.20.1


