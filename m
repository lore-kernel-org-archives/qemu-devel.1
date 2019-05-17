Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792DCC04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:50:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E2120815
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qjApryCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E2120815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40267 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRSxU-00063P-GR
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 22:50:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmd-0005WX-NL
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmc-00027o-GR
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:43 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRSmb-00027N-UL
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:42 -0400
Received: by mail-pg1-x543.google.com with SMTP id z16so2503294pgv.11
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=CCvph4F0+gsWZSKZYyRUd00rEVqCU0cysWzx7Ki8dAo=;
	b=qjApryCP2LiyI2c1MBtLiZFcwSc658Nu0QXBtzXRPzb5BPMlnligMPuSq//UMthzQC
	Tw+jRxJ978ezjWi2H8wD/WIstBzSv5xmuvf6GI+saiOtGv0tcX69Zf1MJFMUALEcxFEv
	ch03G4K6/zN5xcqNTDb5ZFt4HQ4+PzYq3ZwkgnSEhczF2M71LPaCFJBz8Q8vQ53J2lyr
	fs+NoSRPU6jlgImfEs6diB2Y0pNKFSosh8xSlYZsXZmfKvJf1Op97Dw/JUBb2JArZf+O
	1G1dgjpRBCb+9OhTlPBf3Hi+n7rvQ3mCnJwdB0adyHgTVeFmI3nBYYsDUWU7CdHQA7Rx
	4KPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=CCvph4F0+gsWZSKZYyRUd00rEVqCU0cysWzx7Ki8dAo=;
	b=HvjFAl0pjSqEu0gMvrEiu00LIVmV5JI6UH31agBwrpdddV0HAJRi7n5aXETduhHbzL
	21dxl20jUMkn+/5zIIW8EClAu0XxIjbPAblLtFfohrYj4WhMX0dZHlt5I1jSqNyUh1/H
	cUtXOpiaRIs03Sm8kRT9iEoq3W+SkqBeJodwQq2te3E3YBrn5pwbwv/EKY8hALMk5vV2
	BaappD2LK/eGX15aQgy5KJgj3kHkdcvPcILQ4jagdnbPCLdJ03xYf+MASq5wUhboHp3O
	8czcEyBSfKJi5q9EeIxGf/lmwSDHQlQ35fZnrpIgmxvPAih3Y7Q7umghsi6U1FRQzv1J
	8sWw==
X-Gm-Message-State: APjAAAVN0aa0AXqtIlPNb+NPlVYABpt4i+ImF4aXp/8L6XMVc1Rq0bqA
	AKNY6inIDGH6i40zNobog/cKwzuTKaI=
X-Google-Smtp-Source: APXvYqzyJzub+wwoikBsXuOaP+Hp08xApHMuwtQmDA6kGhFrQxYlfJvgOgbBR2kviFPtcnPWd12XTA==
X-Received: by 2002:a63:ed03:: with SMTP id d3mr53763499pgi.7.1558060780502;
	Thu, 16 May 2019 19:39:40 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id w6sm6984152pge.30.2019.05.16.19.39.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:39:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 19:39:10 -0700
Message-Id: <20190517023924.1686-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517023924.1686-1-richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v8 11/25] cpus: Initialize pseudo-random seeds
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


