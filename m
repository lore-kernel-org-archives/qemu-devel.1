Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80F1C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D912166E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jEtx2Jdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D912166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53062 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQd5f-0003Cu-LA
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:27:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvH-0002Uj-FS
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvG-0006r4-BV
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:11 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQcvG-0006qd-53
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:10 -0400
Received: by mail-pg1-x544.google.com with SMTP id 145so38402pgg.9
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 12:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=CCvph4F0+gsWZSKZYyRUd00rEVqCU0cysWzx7Ki8dAo=;
	b=jEtx2JdfSEnx9wg7IUoABEvgcTiDkClNISLTjxkFd1xs3ygY/erYGhuPNuKzbok7wY
	9zg1++DiysYh58F6krddQ06B7PN/nODTb0wihz5dV5XmVMzW5yePW70gCx7sySeES1AJ
	e0PEmUzBuai1f62E6AtPzQSVx5TFy4C5iRATdKryKLJkuI2W7Vwq55Pd0O79qxxAl1CA
	wDWbrMGI3IjAfhJ6Nm6f3YGU5vLsOimPN7kvGn881rk7x+fGwcR42lqtK7LH2eTBE4Cj
	MTMSjMOtOZQpRClbC4MHR5zcESZpfKuA55f1avXEFCKf4y4mfs83rdpTg8AAkgUokhSw
	KX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=CCvph4F0+gsWZSKZYyRUd00rEVqCU0cysWzx7Ki8dAo=;
	b=n59hbWQNVm/VOsLTyvZFr6u1bNQyuI6YB3/OKag09BvtuNiVsQpyv2X5VfUcN2aBji
	mzG5NoIZ2CBafDjsyzmLc8I1OhS//RrGze2OKfWYHEwfIzUnxsSdvfI13epGxA97QIkX
	XXF6LLUEuU6/pgCD6/lEXRufQfu7YkibZe4J8duGBkBNPAiLp168ZyXyjTv3n3g3dqCA
	jtwZpl9HBrOQilb2xP+bEZvVeUQrIklmp7CyuODDXgXjXAZ3dvO/QFAhCa071CFRuQyZ
	+W982rMi6VLzrQHoCQTGJqIhoFswDDIxLiVCzvdHqejIMgZPJNDsq9lO3EIHmcVnYbrz
	gw/g==
X-Gm-Message-State: APjAAAWcGQJ7xDTzzt4aIA9l6V/11FFP9bqwnBUStpKfbeF+F0y2KCVd
	aL2nC+jYY+I0N9lVw2Kxy2B7I8ARioQ=
X-Google-Smtp-Source: APXvYqyWcnHHVLdPBhA/OkZqiRX5q8MX0hJ6z9sQpE4ypTnMaFpduH91axDmmNxBx3Ex5x6XAuPwrQ==
X-Received: by 2002:a63:5cb:: with SMTP id 194mr40132251pgf.294.1557861428923; 
	Tue, 14 May 2019 12:17:08 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	o6sm18682982pfa.88.2019.05.14.12.17.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 12:17:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:16:39 -0700
Message-Id: <20190514191653.31488-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514191653.31488-1-richard.henderson@linaro.org>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v7 10/24] cpus: Initialize pseudo-random seeds
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
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
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


