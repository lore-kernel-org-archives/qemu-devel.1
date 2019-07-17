Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CD7C76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 05:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95DE22173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 05:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5U+ctfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DE22173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hncmj-0000BA-6j
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 01:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52133)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hncmV-00087Z-6J
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 01:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hncmU-0001ZK-23
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 01:47:11 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hncmR-0001Xj-PA; Wed, 17 Jul 2019 01:47:07 -0400
Received: by mail-pl1-x641.google.com with SMTP id k8so11359865plt.3;
 Tue, 16 Jul 2019 22:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d6z/VFzkc+E+tzTM4giE0MZX0TDQpyGL1Wz1LFCmAss=;
 b=G5U+ctfYpc04Oet4Stpr8F6vFjeP+LxpWMq4p5ZAfhfBr2jRZGTrA5Yw9l8+Mfighd
 taobcPlBzw2RsOt+AY98+lK/Y0LesqBlcxsJqj/hK3GocD7jRpLjSs9DkoZLIPutSsN9
 9dl7AD7WuaRksseTzcbKaHo97uRbrgICFVFL+kcRrcVippETaZnUGp7qus+4uV6WJFN6
 5bLudQfwQnG2iH4SJFeB1kP5Lz7EBzqvL5uU46fB+NZrZBGRY7/mXRomZ1Ee/PMpZmhE
 820WNu9t1KeLSh9Vn2YLJq/IJApXo4YqohLcx9+xMx0nmXqVvglWNMd/Jfs9w4D7Thbx
 YEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d6z/VFzkc+E+tzTM4giE0MZX0TDQpyGL1Wz1LFCmAss=;
 b=iHOd1QRbAbGKG2FcHDueVrB/6r8dxFX4rRrT8it3X7D8shYRi7fRO87eIBnpu4Q2pd
 5UldRnp1wI2YxvxNDw4RZpJ/S/BRv07V5/gFNqWdHWx9qeeb/xCq0WFUnRVI4544fs1i
 5Pd1+S00tMpu8fedi4WMxI44hKd8Pvc55UMG89jJpUW4R9BEbWQ7g68rvqPkI8hP0gvU
 +/pedQvzAumhMGog7+68PxlOK8euvDYTqpzE75VBgCuymmKtZ8uaIXIAcGtLKdupwP2C
 2deSnRiQf88m2rgqx3mjZPLIiqcyXvtGSpAyYbPjjVF2UjalgHsmiQkO9pGIXnZ77OjK
 BHeg==
X-Gm-Message-State: APjAAAX68X2JEd6n4Wr1cqK1MJQcybG3EPrq4TfaHGXfQhfqGZs0ZCZ/
 GvHNbkwxLwktXKIg4+cwS+g=
X-Google-Smtp-Source: APXvYqx17i0Rz0TxdUrFmrmgxQR4qtPZGFQMUiFnrcXoEg1pYDAYTqWEdHeYrxwcy6w6l+km/PGf/w==
X-Received: by 2002:a17:902:1566:: with SMTP id
 b35mr42000558plh.147.1563342426748; 
 Tue, 16 Jul 2019 22:47:06 -0700 (PDT)
Received: from bobo.local0.net ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id q69sm32573165pjb.0.2019.07.16.22.47.02
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 22:47:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 17 Jul 2019 15:46:55 +1000
Message-Id: <20190717054655.14104-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [RFC PATCH] Implement qemu_thread_yield for posix,
 use it in mttcg to handle EXCP_YIELD
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
Cc: Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a bit of proof of concept in case mttcg becomes more important
yield could be handled like this. You can have by accident or deliberately
force vCPUs onto the same physical CPU and cause inversion issues when the
lock holder was preempted by the waiter. This is lightly tested but not
to the point of measuring performance difference.

I really consider the previous confer/prod patches more important just to
provide a more complete guest environment and better test coverage, than
performance, but maybe someone wants to persue this.

Thanks,
Nick
---
 cpus.c                   |  6 ++++++
 hw/ppc/spapr_hcall.c     | 14 +++++++-------
 include/qemu/thread.h    |  1 +
 util/qemu-thread-posix.c |  5 +++++
 util/qemu-thread-win32.c |  4 ++++
 5 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/cpus.c b/cpus.c
index 927a00aa90..f036e062d9 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1760,6 +1760,12 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
                 qemu_mutex_unlock_iothread();
                 cpu_exec_step_atomic(cpu);
                 qemu_mutex_lock_iothread();
+                break;
+            case EXCP_YIELD:
+                qemu_mutex_unlock_iothread();
+                qemu_thread_yield();
+                qemu_mutex_lock_iothread();
+                break;
             default:
                 /* Ignore everything else? */
                 break;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 57c1ee0fe1..9c24a64dfe 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1162,13 +1162,13 @@ static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
             return H_SUCCESS;
         }
 
-        /*
-         * The targeted confer does not do anything special beyond yielding
-         * the current vCPU, but even this should be better than nothing.
-         * At least for single-threaded tcg, it gives the target a chance to
-         * run before we run again. Multi-threaded tcg does not really do
-         * anything with EXCP_YIELD yet.
-         */
+       /*
+        * The targeted confer does not do anything special beyond yielding
+        * the current vCPU, but even this should be better than nothing.
+        * For single-threaded tcg, it gives the target a chance to run
+        * before we run again, multi-threaded tcg will yield the CPU to
+        * another vCPU.
+        */
     }
 
     cs->exception_index = EXCP_YIELD;
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 55d83a907c..8525b0a70a 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -160,6 +160,7 @@ void qemu_thread_get_self(QemuThread *thread);
 bool qemu_thread_is_self(QemuThread *thread);
 void qemu_thread_exit(void *retval);
 void qemu_thread_naming(bool enable);
+void qemu_thread_yield(void);
 
 struct Notifier;
 /**
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 1bf5e65dea..91b12a1082 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -573,3 +573,8 @@ void *qemu_thread_join(QemuThread *thread)
     }
     return ret;
 }
+
+void qemu_thread_yield(void)
+{
+    pthread_yield();
+}
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 572f88535d..72fe406bef 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -442,3 +442,7 @@ bool qemu_thread_is_self(QemuThread *thread)
 {
     return GetCurrentThreadId() == thread->tid;
 }
+
+void qemu_thread_yield(void)
+{
+}
-- 
2.20.1


