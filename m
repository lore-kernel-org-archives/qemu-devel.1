Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA65C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:29:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2732086A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2732086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=yifanlu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fiX-0003y8-Jh
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j2faF-0006BZ-Ql
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:21:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j2faE-0004es-Ba
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:20:59 -0500
Received: from indium.canonical.com ([91.189.90.7]:47328)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j2faE-0004ea-5Q
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:20:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j2faC-00086c-Dw
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 18:20:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3808A2E80C9
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 18:20:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Feb 2020 18:09:23 -0000
From: Yifan <me@yifanlu.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=alex.bennee@linaro.org; 
X-Launchpad-Bug-Tags: mttcg tcg
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee yifanlu
X-Launchpad-Bug-Reporter: Yifan (yifanlu)
X-Launchpad-Bug-Modifier: Yifan (yifanlu)
References: <158154486735.14935.3370403781300872079.malonedeb@soybean.canonical.com>
Message-Id: <158170376390.15247.4694343664393297579.malone@soybean.canonical.com>
Subject: [Bug 1863025] Re: Use-after-free after flush in TCG accelerator
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 32c4e667c55e19910ae226bd0ad33cfe5ee9dd07
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1863025 <1863025@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found it just by launching Ubuntu 19.10 live cd with QXL driver. I
will re-test this weekend.

The workaround I had is to check the number of TLB flushes and to re-try
obtaining the TB if the number changes. There is a penalty for the case
where TLB is flushed but should not degrade performance in most cases. I
think obtaining the lock earlier will slow down the VM if EXCP_ATOMIC is
used often.

Of course, I am assuming TLB flush is the only way to cause this bug.

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index d1c2b6ea1fd..d83b578299b 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -250,8 +250,11 @@ void cpu_exec_step_atomic(CPUState *cpu)
     uint32_t flags;
     uint32_t cflags =3D 1;
     uint32_t cf_mask =3D cflags & CF_HASH_MASK;
+    unsigned flush_count;
 =

     if (sigsetjmp(cpu->jmp_env, 0) =3D=3D 0) {
+retry:
+        flush_count =3D tb_flush_count();
         tb =3D tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, cf_mask);
         if (tb =3D=3D NULL) {
             mmap_lock();
@@ -260,6 +263,11 @@ void cpu_exec_step_atomic(CPUState *cpu)
         }
 =

         start_exclusive();
+        /* do_tb_flush() might run and make tb invalid */
+        if (flush_count !=3D tb_flush_count()) {
+            end_exclusive();
+            goto retry;
+        }
 =

         /* Since we got here, we know that parallel_cpus must be true.  */
         parallel_cpus =3D false;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 4ed9d0abaf2..ecf7d3b53ff 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2696,6 +2696,11 @@ void tcg_flush_softmmu_tlb(CPUState *cs)
 #endif
 }
 =

+unsigned tb_flush_count(void)
+{
+    return atomic_read(&tb_ctx.tb_flush_count);
+}
+
 #if defined(CONFIG_NO_RWX)
 void tb_exec_memory_lock(void)
 {
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 5ccc9485812..1bc61fa6d76 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -584,6 +584,7 @@ void tlb_set_dirty(CPUState *cpu, target_ulong vaddr);
 void tb_flush_jmp_cache(CPUState *cpu, target_ulong addr);
 =

 /* translate-all.c */
+unsigned tb_flush_count(void);
 #if defined(CONFIG_NO_RWX)
 void tb_exec_memory_lock(void);
 bool tb_is_exec(const TranslationBlock *tb);

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1863025

Title:
  Use-after-free after flush in TCG accelerator

Status in QEMU:
  Confirmed

Bug description:
  I believe I found a UAF in TCG that can lead to a guest VM escape. The
  security list informed me "This can not be treated as a security
  issue." and to post it here. I am looking at the 4.2.0 source code.
  The issue requires a race and I will try to describe it in terms of
  three concurrent threads.

  Thread A:

  A1. qemu_tcg_cpu_thread_fn runs work loop
  A2. qemu_wait_io_event =3D> qemu_wait_io_event_common =3D> process_queued=
_cpu_work
  A3. start_exclusive critical section entered
  A4. do_tb_flush is called, TB memory freed/re-allocated
  A5. end_exclusive exits critical section

  Thread B:

  B1. qemu_tcg_cpu_thread_fn runs work loop
  B2. tcg_cpu_exec =3D> cpu_exec =3D> tb_find =3D> tb_gen_code
  B3. tcg_tb_alloc obtains a new TB

  Thread C:

  C1. qemu_tcg_cpu_thread_fn runs work loop
  C2. cpu_exec_step_atomic executes
  C3. TB obtained with tb_lookup__cpu_state or tb_gen_code
  C4. start_exclusive critical section entered
  C5. cpu_tb_exec executes the TB code
  C6. end_exclusive exits critical section

  Consider the following sequence of events:
  =C2=A0=C2=A0B2 =3D> B3 =3D> C3 (same TB as B2) =3D> A3 =3D> A4 (TB freed)=
 =3D> A5 =3D> B2 =3D>
  =C2=A0=C2=A0B3 (re-allocates TB from B2) =3D> C4 =3D> C5 (freed/reused TB=
 now executing) =3D> C6

  In short, because thread C uses the TB in the critical section, there
  is no guarantee that the pointer has not been "freed" (rather the
  memory is marked as re-usable) and therefore a use-after-free occurs.

  Since the TCG generated code can be in the same memory as the TB data
  structure, it is possible for an attacker to overwrite the UAF pointer
  with code generated from TCG. This can overwrite key pointer values
  and could lead to code execution on the host outside of the TCG
  sandbox.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1863025/+subscriptions

