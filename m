Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A593C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 16:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35EE02168B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 16:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fetE1U2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EE02168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEyha-0007C9-Ad
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 12:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iEygn-0006mv-Md
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 12:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iEygl-0006f3-Kp
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 12:38:21 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iEygl-0006eX-CE
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 12:38:19 -0400
Received: by mail-wm1-x344.google.com with SMTP id r17so442011wme.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 09:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=MqcDsqob8zdpSQ9O51HTy+pHc2xxQyUuSFnvAW8fGV0=;
 b=fetE1U2KlH19vBbBpv5sF9P1BNWRIFG/tj0f2SN866o5MBap/it29apegYEZJG/y0u
 G9DLDM4rHVmUlhjP+Gz7ZaOUbxaaw9OmII/7YjV3Qj46KezaQ6JNVN4c7R2Qp8WJfrvd
 fC7qqHj1vFk3r+kdm+zIwGmVJ2b83NexNlsxNbc4DzHd6rX8smvrw5Ewbxi5FTtWI8uz
 fNP+cjQgdIRHJJuUycS3Htc/8nhnl8Fj4GjjFbCzvcieNM0XT4KVbDUcK2bfkoKQuQpx
 pRl7xdhIQp5J+2sAl0H9tNmiNq08+PtyouEaJWI09AkAPyVvtRIiquS6iwM9z5PERFd+
 AAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=MqcDsqob8zdpSQ9O51HTy+pHc2xxQyUuSFnvAW8fGV0=;
 b=Pe4rKWC4T54VInkokAUgdGzNOyFd/RjmOI8UJmAJGjltJlJIxgmgKrdEWcWDkxrNPF
 c6iMRFTqK0BEjkbTe6uK9Xx7FrPKmOkFa9yFNPhkGd5hp1Tk0551kFFamr+r1zXtWFRy
 sbZXp8vgGJ5N/cA6uvjSeTg5B/ERuujutIP8f9QsJ/HfkqExnuWShEr3rDhJAKMYLP82
 2204hTh1CEE+lq7QQ6AENjh7OzLxjk3+kjAK9hd1lGtYJfOD68TiuR1ZalIZ3qlCJYyH
 KA7jXfpeKNAAXexRC0y6Uo3d22jv34LtThSLBcqkuTowSeQ21fcvv7jW0t9Z2Gxbw1eF
 YD2Q==
X-Gm-Message-State: APjAAAU/ls3zKKrW9B5nT4MaeKfxlDFXCw1jOe72blWLMybTmS20s6X3
 mAsCLBTwCgKld+N5kIYWmuJkPw==
X-Google-Smtp-Source: APXvYqzLUl/oZNxIMGof6pbHOs0K9ieW4bc2YopLxKzwC0NvcHkKHAvJLLMlo0qZmenI/CqsJ3E6cg==
X-Received: by 2002:a1c:1bcf:: with SMTP id b198mr128630wmb.0.1569861497693;
 Mon, 30 Sep 2019 09:38:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q19sm33426874wra.89.2019.09.30.09.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 09:38:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1946F1FF87;
 Mon, 30 Sep 2019 17:38:16 +0100 (BST)
References: <CAEfK_44VEF17nRgzNvVe+MPmAfS34kiJ_ozubWFkVYV0rm71sw@mail.gmail.com>
 <CAFEAcA9nz9S4R+O9fwa0k38dB3r1smguG4bQRzwm1s0zJCvfDA@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Lockup with --accel tcg,thread=single
In-reply-to: <CAFEAcA9nz9S4R+O9fwa0k38dB3r1smguG4bQRzwm1s0zJCvfDA@mail.gmail.com>
Date: Mon, 30 Sep 2019 17:38:15 +0100
Message-ID: <87h84tloy0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Doug Gale <doug16k@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 30 Sep 2019 at 14:17, Doug Gale <doug16k@gmail.com> wrote:
>>
>> I found a lockup in single threaded TCG, with OVMF bios, 16 CPUs.
>>
>> qemu-system-x86_64 --accel tcg,thread=3Dsingle -smp cpus=3D16 -bios
>> /usr/share/ovmf/OVMF.fd
>>
>> Using Ubuntu 18.04 LTS, default gnome desktop. There is no guest OS,
>> there is no hard drive, just the OVMF firmware locks it up. (I
>> narrowed it down to this from a much larger repro)
>
>> Peter Maydell helped me bisect it in IRC.
>>  Works fine at commit 1e8a98b53867f61
>>  Fails at commit 9458a9a1df1a4c7
>>
>> MTTCG works fine all the way up to master.
>
> Thanks for this bug report. I've reproduced it and think
> I have figured out what is going on here.
>
> Commit 9458a9a1df1a4c719e245 is Paolo's commit that fixes the
> TCG-vs-dirty-bitmap race by having the thread which is
> doing a memory access wait for the vCPU thread to finish
> its current TB using a no-op run_on_cpu() operation.
>
> In the case of the hang the thread doing the memory access
> is the iothread, like this:
>
> #14 0x000055c150c0a98c in run_on_cpu (cpu=3D0x55c153801c60,
> func=3D0x55c150bbb542 <do_nothing>, data=3D...)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1205
> #15 0x000055c150bbb58c in tcg_log_global_after_sync
> (listener=3D0x55c1538410c8) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/exec.c:2963
> #16 0x000055c150c1fe18 in memory_global_after_dirty_log_sync () at
> /home/petmay01/linaro/qemu-from-laptop/qemu/memory.c:2598
> #17 0x000055c150c1e6b8 in memory_region_snapshot_and_clear_dirty
> (mr=3D0x55c1541e82b0, addr=3D0, size=3D1920000, client=3D0)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/memory.c:2106
> #18 0x000055c150c76c05 in vga_draw_graphic (s=3D0x55c1541e82a0, full_upda=
te=3D0)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/display/vga.c:1661
> #19 0x000055c150c771c4 in vga_update_display (opaque=3D0x55c1541e82a0)
> at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/display/vga.c:1785
> #20 0x000055c151052a83 in graphic_hw_update (con=3D0x55c1536dfaa0) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/ui/console.c:268
> #21 0x000055c151091490 in gd_refresh (dcl=3D0x55c1549af090) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/ui/gtk.c:484
> #22 0x000055c151056571 in dpy_refresh (s=3D0x55c1542f9d90) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/ui/console.c:1629
> #23 0x000055c1510527f0 in gui_update (opaque=3D0x55c1542f9d90) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/ui/console.c:206
> #24 0x000055c1511ee67c in timerlist_run_timers
> (timer_list=3D0x55c15370c280) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/util/qemu-timer.c:592
> #25 0x000055c1511ee726 in qemu_clock_run_timers
> (type=3DQEMU_CLOCK_REALTIME) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/util/qemu-timer.c:606
> #26 0x000055c1511ee9e5 in qemu_clock_run_all_timers () at
> /home/petmay01/linaro/qemu-from-laptop/qemu/util/qemu-timer.c:692
> #27 0x000055c1511ef181 in main_loop_wait (nonblocking=3D0) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/util/main-loop.c:524
> #28 0x000055c150db03fe in main_loop () at
> /home/petmay01/linaro/qemu-from-laptop/qemu/vl.c:1806
>
> run_on_cpu() adds the do_nothing function to a cpu queued-work list.
>
> However, the single-threaded TCG runloop qemu_tcg_rr_cpu_thread_fn()
> has the basic structure:
>
>    while (1) {
>        for (each vCPU) {
>            run this vCPU for a timeslice;
>        }
>        qemu_tcg_rr_wait_io_event();
>    }
>
> and it processes cpu work queues only in qemu_tcg_rr_wait_io_event().
> This is a problem, because the thing which causes us to stop running
> one vCPU when its timeslice ends and move on to the next is the
> tcg_kick_vcpu_timer -- and the iothread will never process that timer
> and kick the vcpu because it is currently blocked in run_on_cpu() !
>
> Not sure currently what the best fix is here.

We seem to be repeating ourselves because:

  a8efa60633575a2ee4dbf807a71cb44d44b0e0f8
  Author:     Paolo Bonzini <pbonzini@redhat.com>
  AuthorDate: Wed Nov 14 12:36:57 2018 +0100
  cpus: run work items for all vCPUs if single-threaded

However looking at the commit I can still see we have the problem of not
advancing to the next vCPU if the kick timer (or some other event)
doesn't bring the execution to an exit. I suspect you could get this in
Linux but it's probably sufficiently busy to ensure vCPUs are always
exiting for some reason or another.

So options I can think of so far are:

1. Kick 'em all when not inter-vCPU

Something like this untested patch...

--8<---------------cut here---------------start------------->8---
1 file changed, 17 insertions(+), 5 deletions(-)
cpus.c | 22 +++++++++++++++++-----

modified   cpus.c
@@ -949,8 +949,8 @@ static inline int64_t qemu_tcg_next_kick(void)
     return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + TCG_KICK_PERIOD;
 }

-/* Kick the currently round-robin scheduled vCPU */
-static void qemu_cpu_kick_rr_cpu(void)
+/* Kick the currently round-robin scheduled vCPU to next */
+static void qemu_cpu_kick_rr_next_cpu(void)
 {
     CPUState *cpu;
     do {
@@ -961,6 +961,16 @@ static void qemu_cpu_kick_rr_cpu(void)
     } while (cpu !=3D atomic_mb_read(&tcg_current_rr_cpu));
 }

+/* Kick all RR vCPUs */
+static void qemu_cpu_kick_rr_cpus(void)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        cpu_exit(cpu);
+    };
+}
+
 static void do_nothing(CPUState *cpu, run_on_cpu_data unused)
 {
 }
@@ -993,7 +1003,7 @@ void qemu_timer_notify_cb(void *opaque, QEMUClockType =
type)
 static void kick_tcg_thread(void *opaque)
 {
     timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
-    qemu_cpu_kick_rr_cpu();
+    qemu_cpu_kick_rr_next_cpu();
 }

 static void start_tcg_kick_timer(void)
@@ -1828,9 +1838,11 @@ void qemu_cpu_kick(CPUState *cpu)
 {
     qemu_cond_broadcast(cpu->halt_cond);
     if (tcg_enabled()) {
+        if (qemu_tcg_mttcg_enabled()) {
         cpu_exit(cpu);
-        /* NOP unless doing single-thread RR */
-        qemu_cpu_kick_rr_cpu();
+        } else {
+            qemu_cpu_kick_rr_cpus();
+        }
     } else {
         if (hax_enabled()) {
             /*
--8<---------------cut here---------------end--------------->8---

2. Add handling of kicking all VCPUs to do_run_on_cpu when current_cpu
=3D=3D NULL

Which would basically kick all vCPUs when events come from outside the
emulation.

3. Figure out multi-threaded icount and record/replay and drop the
special RR case.

This might take a while.

> Side note -- this use of run_on_cpu() means that we now drop
> the iothread lock within memory_region_snapshot_and_clear_dirty(),
> which we didn't before. This means that a vCPU thread can now
> get in and execute an access to the device registers of
> hw/display/vga.c, updating its state in a way I suspect that the
> device model code is not expecting... So maybe the right answer
> here should be to come up with a fix for the race that 9458a9a1
> addresses that doesn't require us to drop the iothread lock in
> memory_region_snapshot_and_clear_dirty() ? Alternatively we need
> to audit the callers and flag in the documentation that this
> function has the unexpected side effect of briefly dropping the
> iothread lock.

There was a series Emilio posted to get rid of more of the BQL in place
of per-CPU locks which IIRC also stopped some of the bouncing we do in
the *_on_cpu functions. Each time we have to do a lock shuffle to get
things moving is a bit of a red flag.

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

