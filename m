Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261FDC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:12:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5DED21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KPIl2Wx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DED21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55353 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6a14-0004NN-37
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcP-0005Rx-GF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcM-0007DC-H9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:20 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44005)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6ZcM-0007Cu-Ab
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:18 -0500
Received: by mail-wr1-x442.google.com with SMTP id r11so14577904wrq.10
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ehZlOYl+k4JKKy2JqV4YRUh/kizfHcJPE/yTLG5OZt4=;
 b=KPIl2Wx+5QDyiLya+M8sfCr4gzw3NbTs5Cn9cbMIvPOA3VP+MG8KUQFREknhuG1nfr
 BVW31z7t3sdoxUXAbJjJ92FaP375jlHp38MmqKeCE39E6cr0QEzjBNX+jRLpPhe4t5NQ
 qdu+INCYb4dHyc/QBL0sHC3iPcIK8Xhx+IuFbrosvalV1sh0eYnD2Y59AbL2SUejUDWQ
 GV3zU2lWE4k9QsRfKWK+AroDSZbQuejmJrZc3WJNOKcfvmCOEWU3IcwjX1LZJgNGx07u
 lDBF39xvmM1tOFNoXa8S5iitpxlhB4R628w7W5Wi6b9Q1WzXJ1zfmSgeBwN5pOUzt7KC
 LPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ehZlOYl+k4JKKy2JqV4YRUh/kizfHcJPE/yTLG5OZt4=;
 b=CIDA3jkUkEJ1OJ7p0r6slHcWv43ZSY7RLSp+W/GrkT70st+ejdp5kGKLnQy5j/xWPk
 rxkFG6NRctUR+J/atI6TnKSyAT5ENjy6eAlSmi2q8MANbzZ/NUj+u0FM+UbPVxTMGswo
 uz5bKZNiSThrHDucuZs8LIXYAnJbDQMMDB5RfxbRWQ1a/bOqK+LEOczsOR3gPU5++ZBk
 pTaJLNIETYVXJS3b9uTur19XgStkEITBmVpqMIZLCudoEBrqSbaxCJ3pJo2S7Xb6i5Yi
 QsdXbPLXOAhJ0xTTm+F2BFM8DetrH9rvd/CxxVYwtSfQSeduBH9F1rzBMzzMAuAkOTBN
 i6oQ==
X-Gm-Message-State: APjAAAWNT7RjXa+wugxK5bTgvjB5CBAf2UXnVFcLujau1A7kZxBKt39u
 ATE8aXzwt3evnBo+0+stS4/+Sg==
X-Google-Smtp-Source: APXvYqwnt3+dj8I6mwg3kBxLNQgMlzk7kNMq5AJqhAK8VVdY7ybb5C+E2Fx7QCrQlDdCrbIsIYFIhg==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr74678723wrp.203.1582634837236; 
 Tue, 25 Feb 2020 04:47:17 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w1sm24513111wro.72.2020.02.25.04.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 04:47:14 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9F5471FF91;
 Tue, 25 Feb 2020 12:47:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/19] tests/rcutorture: mild documenting refactor of
 update thread
Date: Tue, 25 Feb 2020 12:46:55 +0000
Message-Id: <20200225124710.14152-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225124710.14152-1-alex.bennee@linaro.org>
References: <20200225124710.14152-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is mainly to help with reasoning what the test is trying to do.
We can move rcu_stress_idx to a local variable as there is only ever
one updater thread. I've also added an assert to catch the case where
we end up updating the current structure to itself which is the only
way I can see the mberror cases we are seeing on Travis.

We shall see if the rcutorture test failures go away now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

---
v3
  - explicit atomic_read/set
  - rename pipe_count to age
  - fix whitespace
---
 tests/rcutorture.c | 55 +++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/tests/rcutorture.c b/tests/rcutorture.c
index 256d24ed5ba..732f03abdaa 100644
--- a/tests/rcutorture.c
+++ b/tests/rcutorture.c
@@ -230,13 +230,12 @@ static void uperftest(int nupdaters, int duration)
 #define RCU_STRESS_PIPE_LEN 10
 
 struct rcu_stress {
-    int pipe_count;
+    int age;  /* how many update cycles while not rcu_stress_current */
     int mbtest;
 };
 
 struct rcu_stress rcu_stress_array[RCU_STRESS_PIPE_LEN] = { { 0 } };
 struct rcu_stress *rcu_stress_current;
-int rcu_stress_idx;
 int n_mberror;
 
 /* Updates protected by counts_mutex */
@@ -261,7 +260,7 @@ static void *rcu_read_stress_test(void *arg)
     while (goflag == GOFLAG_RUN) {
         rcu_read_lock();
         p = atomic_rcu_read(&rcu_stress_current);
-        if (p->mbtest == 0) {
+        if (atomic_read(&p->mbtest) == 0) {
             n_mberror++;
         }
         rcu_read_lock();
@@ -269,7 +268,7 @@ static void *rcu_read_stress_test(void *arg)
             garbage++;
         }
         rcu_read_unlock();
-        pc = p->pipe_count;
+        pc = atomic_read(&p->age);
         rcu_read_unlock();
         if ((pc > RCU_STRESS_PIPE_LEN) || (pc < 0)) {
             pc = RCU_STRESS_PIPE_LEN;
@@ -288,32 +287,52 @@ static void *rcu_read_stress_test(void *arg)
     return NULL;
 }
 
+/*
+ * Stress Test Updater
+ *
+ * The updater cycles around updating rcu_stress_current to point at
+ * one of the rcu_stress_array_entries and resets it's age. It
+ * then increments the age of all the other entries. The age
+ * will be read under an rcu_read_lock() and distribution of values
+ * calculated. The final result gives an indication of how many
+ * previously current rcu_stress entries are in flight until the RCU
+ * cycle complete.
+ */
 static void *rcu_update_stress_test(void *arg)
 {
-    int i;
-    struct rcu_stress *p;
+    int i, rcu_stress_idx = 0;
+    struct rcu_stress *cp = atomic_read(&rcu_stress_current);
 
     rcu_register_thread();
-
     *(struct rcu_reader_data **)arg = &rcu_reader;
+
     while (goflag == GOFLAG_INIT) {
         g_usleep(1000);
     }
+
     while (goflag == GOFLAG_RUN) {
-        i = rcu_stress_idx + 1;
-        if (i >= RCU_STRESS_PIPE_LEN) {
-            i = 0;
+        struct rcu_stress *p;
+        rcu_stress_idx++;
+        if (rcu_stress_idx >= RCU_STRESS_PIPE_LEN) {
+            rcu_stress_idx = 0;
         }
-        p = &rcu_stress_array[i];
-        p->mbtest = 0;
+        p = &rcu_stress_array[rcu_stress_idx];
+        /* catching up with ourselves would be a bug */
+        assert(p != cp);
+        atomic_set(&p->mbtest, 0);
         smp_mb();
-        p->pipe_count = 0;
-        p->mbtest = 1;
+        atomic_set(&p->age, 0);
+        atomic_set(&p->mbtest, 1);
         atomic_rcu_set(&rcu_stress_current, p);
-        rcu_stress_idx = i;
+        cp = p;
+        /*
+         * New RCU structure is now live, update pipe counts on old
+         * ones.
+         */
         for (i = 0; i < RCU_STRESS_PIPE_LEN; i++) {
             if (i != rcu_stress_idx) {
-                rcu_stress_array[i].pipe_count++;
+                atomic_set(&rcu_stress_array[i].age,
+                           rcu_stress_array[i].age + 1);
             }
         }
         synchronize_rcu();
@@ -346,7 +365,7 @@ static void stresstest(int nreaders, int duration)
     int i;
 
     rcu_stress_current = &rcu_stress_array[0];
-    rcu_stress_current->pipe_count = 0;
+    rcu_stress_current->age = 0;
     rcu_stress_current->mbtest = 1;
     for (i = 0; i < nreaders; i++) {
         create_thread(rcu_read_stress_test);
@@ -376,7 +395,7 @@ static void gtest_stress(int nreaders, int duration)
     int i;
 
     rcu_stress_current = &rcu_stress_array[0];
-    rcu_stress_current->pipe_count = 0;
+    rcu_stress_current->age = 0;
     rcu_stress_current->mbtest = 1;
     for (i = 0; i < nreaders; i++) {
         create_thread(rcu_read_stress_test);
-- 
2.20.1


