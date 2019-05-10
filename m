Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC20BC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6985E217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhA+pXlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6985E217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47629 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9Wu-00019q-JG
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:41:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MR-0007Pg-CV
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MQ-00065I-5V
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:07 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP9MP-000653-VI
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:06 -0400
Received: by mail-pf1-x444.google.com with SMTP id g3so3586230pfi.4
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=CCvph4F0+gsWZSKZYyRUd00rEVqCU0cysWzx7Ki8dAo=;
	b=XhA+pXlR8e0RNUXPWtWVNimjmg3Im0ATqmR7L1NDpEcJFBVuCMDLyB+9tdR1cESaJc
	klGlyzU6AopnoZbNqxUG4f3T/lKayuqZB7r/ud0Wn99QDfyK4/xNtnsolmBYODXLsgy0
	a8gths3Pz6XLS/kbvrlH49ry9+51SZy80svCFITgsgU0JWJCHXNSYgWKYhEjkdR+4Fuf
	y5pBBi4u9OLJ3l6lL+WNUMlEkSrDqrWYam7cbQLRMN6N0O43A/SeLyJ7FJ4SZWE72aF2
	RGoZ0A+VMiypiEc5gz6wDOjsS26LpUXf+cNK6JDsRpLFyUPTyUdNk09UuBozIZoxg1dL
	InnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=CCvph4F0+gsWZSKZYyRUd00rEVqCU0cysWzx7Ki8dAo=;
	b=SNdjOtyEV1X5CwrV7U0nB0XLkYlDPyZDQor/fDofa0/laHpgZhPEGEwrddPO8e34vw
	N+db8Ljb8hDOv7kxZZHXUIlzIEVS50z0WxsRnX8QAY3/qe0bQULgWrRqyBiMTossZxRh
	cBuh8KR6ifBgtGL0UYzVE+6cv4Ab0Dm9BsOOjPxi75Dk9lB1bdeMnsoIQjOOxrxInBU0
	F4jMTBIE6D1mBAmBuAnvI5R7ZvhIvaj7VLUapjuCfNtSouynIw9CLqSFmNfuwXTxy2QN
	V4RD4JOlj1OIYeq/v94DKA6nic82FcWyzOpxznj8drFZkzCQyV94/yv5V2icBlr/EN3D
	dXmg==
X-Gm-Message-State: APjAAAXxJNT9RmJOb/h7fbMehwuWK/Ek5zUJgn0pHpCzR5jrV2gElOHq
	ESlKGiHC0kuKtbu38SAf03ouvCQROJI=
X-Google-Smtp-Source: APXvYqzMEDDCikaTwJ1q0Gy0XhKXaqmIIVQxzrr7B53K2Ly49WSpKUNPOASYkYSMr7biGYEUfb5zyg==
X-Received: by 2002:a62:604:: with SMTP id 4mr16094082pfg.38.1557509464762;
	Fri, 10 May 2019 10:31:04 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	v64sm7936792pfv.106.2019.05.10.10.31.03 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 10:31:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 10:30:35 -0700
Message-Id: <20190510173049.28171-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510173049.28171-1-richard.henderson@linaro.org>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v6 11/25] cpus: Initialize pseudo-random seeds
 for all guest cpus
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the -seed option is given, call qemu_guest_random_seed_main,
putting the subsystem into deterministic mode.  Pass derived seeds
to each cpu created; which is a no-op unless the subsystem is in
deterministic mode.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qom/cpu.h |  1 +
 cpus.c            |  9 +++++++++
 vl.c              |  4 ++++
 qemu-options.hx   | 10 ++++++++++
 4 files changed, 24 insertions(+)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 08abcbd3fe..9793ec39bc 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -369,6 +369,7 @@ struct CPUState {
     int singlestep_enabled;
     int64_t icount_budget;
     int64_t icount_extra;
+    uint64_t random_seed;
     sigjmp_buf jmp_env;
 
     QemuMutex work_mutex;
diff --git a/cpus.c b/cpus.c
index e58e7ab0f6..ffc57119ca 100644
--- a/cpus.c
+++ b/cpus.c
@@ -50,6 +50,7 @@
 #include "qemu/option.h"
 #include "qemu/bitmap.h"
 #include "qemu/seqlock.h"
+#include "qemu/guest-random.h"
 #include "tcg.h"
 #include "hw/nmi.h"
 #include "sysemu/replay.h"
@@ -1276,6 +1277,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
     /* signal CPU creation */
     cpu->created = true;
     qemu_cond_signal(&qemu_cpu_cond);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
         if (cpu_can_run(cpu)) {
@@ -1319,6 +1321,7 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
     /* signal CPU creation */
     cpu->created = true;
     qemu_cond_signal(&qemu_cpu_cond);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
         qemu_mutex_unlock_iothread();
@@ -1478,6 +1481,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
     cpu->created = true;
     cpu->can_do_io = 1;
     qemu_cond_signal(&qemu_cpu_cond);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     /* wait for initial kick-off after machine start */
     while (first_cpu->stopped) {
@@ -1592,6 +1596,7 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
 
     hax_init_vcpu(cpu);
     qemu_cond_signal(&qemu_cpu_cond);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
         if (cpu_can_run(cpu)) {
@@ -1631,6 +1636,7 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
     /* signal CPU creation */
     cpu->created = true;
     qemu_cond_signal(&qemu_cpu_cond);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
         if (cpu_can_run(cpu)) {
@@ -1671,6 +1677,7 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
     /* signal CPU creation */
     cpu->created = true;
     qemu_cond_signal(&qemu_cpu_cond);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
         if (cpu_can_run(cpu)) {
@@ -1724,6 +1731,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
     cpu->can_do_io = 1;
     current_cpu = cpu;
     qemu_cond_signal(&qemu_cpu_cond);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     /* process any pending work */
     cpu->exit_request = 1;
@@ -2071,6 +2079,7 @@ void qemu_init_vcpu(CPUState *cpu)
     cpu->nr_cores = smp_cores;
     cpu->nr_threads = smp_threads;
     cpu->stopped = true;
+    cpu->random_seed = qemu_guest_random_seed_thread_part1();
 
     if (!cpu->as) {
         /* If the target cpu hasn't set up any address spaces itself,
diff --git a/vl.c b/vl.c
index b6709514c1..e1d75a047f 100644
--- a/vl.c
+++ b/vl.c
@@ -128,6 +128,7 @@ int main(int argc, char **argv)
 #include "qapi/qapi-commands-ui.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/iothread.h"
+#include "qemu/guest-random.h"
 
 #define MAX_VIRTIO_CONSOLES 1
 
@@ -3347,6 +3348,9 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_DFILTER:
                 qemu_set_dfilter_ranges(optarg, &error_fatal);
                 break;
+            case QEMU_OPTION_seed:
+                qemu_guest_random_seed_main(optarg, &error_fatal);
+                break;
             case QEMU_OPTION_s:
                 add_device_config(DEV_GDB, "tcp::" DEFAULT_GDBSTUB_PORT);
                 break;
diff --git a/qemu-options.hx b/qemu-options.hx
index 51802cbb26..0191ef8b1e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3601,6 +3601,16 @@ the 0x200 sized block starting at 0xffffffc000080000 and another 0x1000 sized
 block starting at 0xffffffc00005f000.
 ETEXI
 
+DEF("seed", HAS_ARG, QEMU_OPTION_seed, \
+    "-seed number       seed the pseudo-random number generator\n",
+    QEMU_ARCH_ALL)
+STEXI
+@item -seed @var{number}
+@findex -seed
+Force the guest to use a deterministic pseudo-random number generator, seeded
+with @var{number}.  This does not affect crypto routines within the host.
+ETEXI
+
 DEF("L", HAS_ARG, QEMU_OPTION_L, \
     "-L path         set the directory for the BIOS, VGA BIOS and keymaps\n",
     QEMU_ARCH_ALL)
-- 
2.17.1


