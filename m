Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AA8C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:18:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49D220879
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Al34NMFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49D220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49961 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWl2-0003Pl-Sq
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:18:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOp-0008Lh-J4
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWCJ-00086c-Ok
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:45 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:45287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWCH-00085b-QA
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:41 -0400
Received: by mail-yb1-xb44.google.com with SMTP id e128so1238846ybc.12
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ooMVwgAp+U7g50/jmMWyVcKo6lX9ghcSSdE6Ahl0IEA=;
	b=Al34NMFFwEg5EiVi2K6FEftXDJw4RmI3y58uV7JjVoeXT2YQzGaA7a2sI8uHT1Ufab
	U2oeO515vhz01R8i+RXsiywWmqInSvMYEr9Tit10iSzdDgc94MbrDHL+XikJ2SAb+hlh
	2CPBsFB5vjp+QvMc3C4DLB9l9llXgBXCD/EVmAEe3phGSPIXX4flxGM8sZKFMW2Ig6qC
	czN43c+45twodRlBzvQ/0MS8nFHyYcY9q5rGCtcRmgo4IxZrrKT+CBwVcZx3d5bv4LIG
	M0p7m/sdKYWZ2ESbM0ozrzRDMxjL/BLTa8/EfCPbCXljYKg/JKHCcnhAl27Dt7rtFg7c
	HbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ooMVwgAp+U7g50/jmMWyVcKo6lX9ghcSSdE6Ahl0IEA=;
	b=ueE+2qgoAh83Cf1K6q9KFzJyAUBrLtEbp6TlIA16N122ASdhdZ/7Vp3jqcAJeQFiAx
	ic/EzkaKR/Yesoqt6jAnPCyfSv0jIPmBfcNfUeGZdBBnT8EEJWvABCP10ypOKRMEhvhc
	zQ+W75PqFDV2VTWjXv/cA/zhWMoQGKmW+s8Ay+X2/rXYSGmKZClXQmTWTZRj3Y3fk1Gi
	lGZFyDXftEwaVnWI1BA7uDE0hlRC/FmRc36F8NdlbaDq1bcmo8rfB358lkMGN+NCe5Xc
	yeOLBanTUhKdL8dPQsV5jtROoviQYdqzABjCwYlVUDFSgOtZcb9AxhHvNXJ0YdyvA+F6
	3AdA==
X-Gm-Message-State: APjAAAV8ixJmhiqH8fK/bzaaPf3SH3x6gwxED8GauLv5pgMJVD2upB5q
	07OvqwTVLnY/PbqzH+hEOAx4G0H5YkY=
X-Google-Smtp-Source: APXvYqyIZJVcRYU8Adotx95rMJayIEPS2/faSvVPEpjqinPgPrj6FWIf+amKSBXKiqStJ+Rm1gYqTA==
X-Received: by 2002:a5b:c8e:: with SMTP id i14mr5679911ybq.12.1558550560144;
	Wed, 22 May 2019 11:42:40 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:12 -0400
Message-Id: <20190522184226.17871-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [PULL 11/25] cpus: Initialize pseudo-random seeds for
 all guest cpus
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
Cc: peter.maydell@linaro.org
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
index 32983f27c3..98e12d914c 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -375,6 +375,7 @@ struct CPUState {
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
index 201144b162..5550bd7693 100644
--- a/vl.c
+++ b/vl.c
@@ -128,6 +128,7 @@ int main(int argc, char **argv)
 #include "qapi/qapi-commands-ui.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/iothread.h"
+#include "qemu/guest-random.h"
 
 #define MAX_VIRTIO_CONSOLES 1
 
@@ -3349,6 +3350,9 @@ int main(int argc, char **argv, char **envp)
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
index 5daa5a8fb0..7ae3373a00 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3641,6 +3641,16 @@ the 0x200 sized block starting at 0xffffffc000080000 and another 0x1000 sized
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


