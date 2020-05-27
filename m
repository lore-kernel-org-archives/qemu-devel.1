Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CA7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DAF2084C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CbyLBUnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DAF2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxcG-00082F-4E
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 11:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxSc-00020J-FP
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:55:14 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54101)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxSa-0008FY-K5
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:55:14 -0400
Received: by mail-wm1-x341.google.com with SMTP id l26so3322211wme.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 07:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O14rdwBIfGRpuBDr9I2ETfU73nIhdtOBuqe+I2h5Fx0=;
 b=CbyLBUnvLVk7vdoH626HCWP6G+l08I9ZsdW26iA2YbqsfQ9K03Q/X/ELDuMmcCLTZK
 y/MyE3XJdGZYEHk7cjHY+QJH6JuqRmKytepkgjaG/tZL5Tmhre6ghGxmWQD/hXTuF40l
 k+yZEP0Yoid+wLU5l67xStImgqjsqcu1LoxELQPE8ClcVj1U+uKQMAHlu/mgwR4AXR+r
 XBLfCWJuXPEAg+EavnAAVWAzHO/wo1DNAhTDN1EsadkmBmJmsTX0MinrgSN3WwcmEXOu
 DXtmudFqNKLLwwHEeDzwZjGkfLp7k/K6kYCVwmMhjErbEl4qPNLHat+NCTNlx086jhgE
 L4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O14rdwBIfGRpuBDr9I2ETfU73nIhdtOBuqe+I2h5Fx0=;
 b=D149rrGpID8f1LTOz3WRdzKmw+B/lVILjVakx668Ujus9qRqDHo/IvaE1ENkPjqnon
 C47tjIRyZDGp4eW2pr/Z9mic3qmtDB1V9M8qqTDA8hfY1TQ8dgaMAxfIUDYihJr1SYZ9
 gpnIzMyd3ysyI4IrvWDBI/UDek045aWYZAepzoTHmiOxZoG3lPoVc70/C6lMPu4PuE30
 41W6gxeBvwV3uGnGrBkores2FYJ5VXxRB9qp2vC+BWE3U+NZNxyiz4wFBtcAZfC7l++y
 uoBCxPRViJ1oMz3y+TnXi1TknyOMMUqm10ge4Knazr3UfjgbwrjTH7m9+kmvLEisaWeZ
 RZ2Q==
X-Gm-Message-State: AOAM532QQTAI2BMR2Q4YpVirkkpOMYmqyPqOZ2t5eyJ/zxCGr7cM5Tzz
 7cmY9z+b9qpmNPxc+SPJ6BId8g==
X-Google-Smtp-Source: ABdhPJzighiTBQBmB3/r0ZArkqDnYzocaI3U46wPGZ0wZWrE8NN4hw85nLHmSgHnH3sy17ximOOxeQ==
X-Received: by 2002:a1c:4e0c:: with SMTP id g12mr4770362wmh.25.1590591311115; 
 Wed, 27 May 2020 07:55:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y4sm3103534wro.91.2020.05.27.07.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 07:55:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1507F1FF9A;
 Wed, 27 May 2020 15:54:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 11/12] linux-user: properly "unrealize" vCPU object
Date: Wed, 27 May 2020 15:54:54 +0100
Message-Id: <20200527145455.2550-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527145455.2550-1-alex.bennee@linaro.org>
References: <20200527145455.2550-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
 Markus Armbruster <armbru@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
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
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: Nikolay Igotti <igotti@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200520140541.30256-14-alex.bennee@linaro.org>

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


