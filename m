Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C26C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC3A205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NOSgJ89B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC3A205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvJ7-00038F-Un
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 13:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvEt-0004pu-6C
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:32:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvEs-0007nB-7s
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:32:14 -0400
Received: by mail-wr1-x443.google.com with SMTP id l11so496533wru.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 10:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AurL0SAZRHpkVWbSIjSJmyFw3W3Or7KduKRq6WmTvNA=;
 b=NOSgJ89BSMgdetJsU+IaXENbLCZyAC8NzNSwJDcpivO8AkDsH2Spgd5q6zhAIrTF0f
 VQloZO6Pq+h7VPfuzZjMRf/55WoM9Cmm6DV6NHEN84c6PC5qBx5K/1itP4bqYycqg1Le
 wvAjioxDwCbrhraHXdt1yx+Lq60wCRYi2xxP2e0dqb/UUx9A7LDhRt465dTktF4V+KYq
 1P1iHSPCJZah1zVh48pbseJuEb5/FMD9HI56mwBMTs+AzmDcR9vI+c63YJ+Bc5Ho5lsc
 4vXVvI4KLBbYkEqK7j/eJz3iZGKfmt0QvzTFh9+rPkwcVsCKHGjN8qbyj7xRi0fXyczr
 kzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AurL0SAZRHpkVWbSIjSJmyFw3W3Or7KduKRq6WmTvNA=;
 b=o5Yh/OPPR8zeim4p/1T+10clCGU3C6wjDV8hZj9nOgd2M5SkkvRlEXSMPtrW7D2LEC
 GmvyAiClWVrUTyywVSzmVAm2ZF41HX/SzZ5tw2TpzpJeXD9v6fXRzVtjBjUzb/wtNV7o
 qlShszes7ztgR7kydUsqhr88LHYXM+vd9ySflwzrn5SbqCrFuhriwzDX4xUwTFGmCGpu
 HA9JgGtgQpIMP9Bssuq9GMPtTAa9fXQ6wf8DZt2Sxukxkm4cQHBVQE0HRuuJY5B1GgaN
 gjs179DCWyZjxb/kQekfpHyfgAcAk9FPFeEWNuMbeouJ7FcQIqbDpFuzCd0ggCv3rOt2
 Z/jw==
X-Gm-Message-State: AOAM533Lob9kNe/Nr8AhrscDe4iWZApYKvnX9uZk42WT21utPxJ6WTtU
 zP/5CW6HCbv8aQrAXpNoWQrqUQ==
X-Google-Smtp-Source: ABdhPJyUHp4evpHBWv8Wc8iM9jFH7MZkmLJDCDtUbVy7y+mQKvoCrFRhgR5+0VKWKpAM9PLlGzD2pg==
X-Received: by 2002:a5d:460d:: with SMTP id t13mr469692wrq.280.1589391132861; 
 Wed, 13 May 2020 10:32:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y3sm210170wrm.64.2020.05.13.10.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 10:32:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6DA8E1FF92;
 Wed, 13 May 2020 18:32:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 6/8] linux-user: properly "unrealize" vCPU object
Date: Wed, 13 May 2020 18:31:58 +0100
Message-Id: <20200513173200.11830-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513173200.11830-1-alex.bennee@linaro.org>
References: <20200513173200.11830-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Nikolay Igotti <igotti@gmail.com>
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


