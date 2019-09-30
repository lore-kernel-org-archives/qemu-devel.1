Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB1EC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49ADF206BB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HofOwv+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49ADF206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iExlr-0005dx-Sq
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 11:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iExkA-0004cj-Jr
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iExk8-0001xs-UR
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:37:46 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35739)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iExk5-0001vv-Rj
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:37:43 -0400
Received: by mail-ot1-x344.google.com with SMTP id z6so8721450otb.2
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M49gzAp64BIWlMk0OyRdsJYVwUw9fk4RCVY5HqH4iZM=;
 b=HofOwv+djGt6XlQOgDxuw2lp18vznZPsaVLiCJM4V5keqiXzI3roJIJqQ69FGZ5nQ1
 DuuDgNKWNaL6c+/7JD3jdQUBmfhFEkh4zgrntU+83m3ccfaBr0FyHm+ZXb4nEerI2UrR
 XgtyCq7XPP3ry3+66744yy3uVwbF5gkMqf6UVfMs37/7qrR1r/Y1GV3vmGdEJyQifycC
 wbN3aQ2s1NcmuRYaIyEmpQvKAB06SmGA+jTL40QR3JCF5QiLPf/JPHEHqFo15nWvYgpI
 dvViH+R0TYE49GjG/2lBBSFAdnEs2WiUUSZvE8BYTuaw2FDQftTXriEHxlsO3LTN1KwM
 8PVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M49gzAp64BIWlMk0OyRdsJYVwUw9fk4RCVY5HqH4iZM=;
 b=SsYmkZ4cFNjTSdnA41Jnf+lKJpCAAfJZs19FyGAElZF+YSa+i6kuIeolgl/qSDmDjt
 H0qUcVa3ptZWr9sMToqO9IOx36eFHx9pAtpBx5cqxl3GFBZ9zLi5iUu84p8m5fF9Z1Li
 kHZmVLHY8hx/p7L1X4UDp7cCJoIEBO3vivmaRmlVt/54vKGl3NaE6RKNzfD2Lpew2InI
 wS8iT6jOSrTnsUkH8iZoXDweAjiMR8F4RM6cPfVLEa/pKXl/rWXb0oMZOWGR2hI0DyM0
 jCUk6bMswwvoYUo3PJjOBvDb4iWQPngPZ4QaOfSy1eNjf7jt/pPLFvK5J/Od0B1PlxCp
 xIsw==
X-Gm-Message-State: APjAAAUb+DM65FWToVRy3wVD2Hx/gGjpnXCEJGF+jUx/EFDfcucQVYLp
 X8Qo0bJV+4xHUaCWgfJPhrh+s0E1V8iwISZ0FvAvYg==
X-Google-Smtp-Source: APXvYqyspbgqZuofR3Xk2hoL61LkmhCAbxmzNps27k3xUpWWB2aP00CHvx52zjjisTGJLepzK1WK6Mj1yTeDtGQCxSY=
X-Received: by 2002:a9d:73ce:: with SMTP id m14mr9591398otk.135.1569857860761; 
 Mon, 30 Sep 2019 08:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAEfK_44VEF17nRgzNvVe+MPmAfS34kiJ_ozubWFkVYV0rm71sw@mail.gmail.com>
In-Reply-To: <CAEfK_44VEF17nRgzNvVe+MPmAfS34kiJ_ozubWFkVYV0rm71sw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2019 16:37:29 +0100
Message-ID: <CAFEAcA9nz9S4R+O9fwa0k38dB3r1smguG4bQRzwm1s0zJCvfDA@mail.gmail.com>
Subject: Re: Lockup with --accel tcg,thread=single
To: Doug Gale <doug16k@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Sep 2019 at 14:17, Doug Gale <doug16k@gmail.com> wrote:
>
> I found a lockup in single threaded TCG, with OVMF bios, 16 CPUs.
>
> qemu-system-x86_64 --accel tcg,thread=single -smp cpus=16 -bios
> /usr/share/ovmf/OVMF.fd
>
> Using Ubuntu 18.04 LTS, default gnome desktop. There is no guest OS,
> there is no hard drive, just the OVMF firmware locks it up. (I
> narrowed it down to this from a much larger repro)

> Peter Maydell helped me bisect it in IRC.
>  Works fine at commit 1e8a98b53867f61
>  Fails at commit 9458a9a1df1a4c7
>
> MTTCG works fine all the way up to master.

Thanks for this bug report. I've reproduced it and think
I have figured out what is going on here.

Commit 9458a9a1df1a4c719e245 is Paolo's commit that fixes the
TCG-vs-dirty-bitmap race by having the thread which is
doing a memory access wait for the vCPU thread to finish
its current TB using a no-op run_on_cpu() operation.

In the case of the hang the thread doing the memory access
is the iothread, like this:

#14 0x000055c150c0a98c in run_on_cpu (cpu=0x55c153801c60,
func=0x55c150bbb542 <do_nothing>, data=...)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1205
#15 0x000055c150bbb58c in tcg_log_global_after_sync
(listener=0x55c1538410c8) at
/home/petmay01/linaro/qemu-from-laptop/qemu/exec.c:2963
#16 0x000055c150c1fe18 in memory_global_after_dirty_log_sync () at
/home/petmay01/linaro/qemu-from-laptop/qemu/memory.c:2598
#17 0x000055c150c1e6b8 in memory_region_snapshot_and_clear_dirty
(mr=0x55c1541e82b0, addr=0, size=1920000, client=0)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/memory.c:2106
#18 0x000055c150c76c05 in vga_draw_graphic (s=0x55c1541e82a0, full_update=0)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/display/vga.c:1661
#19 0x000055c150c771c4 in vga_update_display (opaque=0x55c1541e82a0)
at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/display/vga.c:1785
#20 0x000055c151052a83 in graphic_hw_update (con=0x55c1536dfaa0) at
/home/petmay01/linaro/qemu-from-laptop/qemu/ui/console.c:268
#21 0x000055c151091490 in gd_refresh (dcl=0x55c1549af090) at
/home/petmay01/linaro/qemu-from-laptop/qemu/ui/gtk.c:484
#22 0x000055c151056571 in dpy_refresh (s=0x55c1542f9d90) at
/home/petmay01/linaro/qemu-from-laptop/qemu/ui/console.c:1629
#23 0x000055c1510527f0 in gui_update (opaque=0x55c1542f9d90) at
/home/petmay01/linaro/qemu-from-laptop/qemu/ui/console.c:206
#24 0x000055c1511ee67c in timerlist_run_timers
(timer_list=0x55c15370c280) at
/home/petmay01/linaro/qemu-from-laptop/qemu/util/qemu-timer.c:592
#25 0x000055c1511ee726 in qemu_clock_run_timers
(type=QEMU_CLOCK_REALTIME) at
/home/petmay01/linaro/qemu-from-laptop/qemu/util/qemu-timer.c:606
#26 0x000055c1511ee9e5 in qemu_clock_run_all_timers () at
/home/petmay01/linaro/qemu-from-laptop/qemu/util/qemu-timer.c:692
#27 0x000055c1511ef181 in main_loop_wait (nonblocking=0) at
/home/petmay01/linaro/qemu-from-laptop/qemu/util/main-loop.c:524
#28 0x000055c150db03fe in main_loop () at
/home/petmay01/linaro/qemu-from-laptop/qemu/vl.c:1806

run_on_cpu() adds the do_nothing function to a cpu queued-work list.

However, the single-threaded TCG runloop qemu_tcg_rr_cpu_thread_fn()
has the basic structure:

   while (1) {
       for (each vCPU) {
           run this vCPU for a timeslice;
       }
       qemu_tcg_rr_wait_io_event();
   }

and it processes cpu work queues only in qemu_tcg_rr_wait_io_event().
This is a problem, because the thing which causes us to stop running
one vCPU when its timeslice ends and move on to the next is the
tcg_kick_vcpu_timer -- and the iothread will never process that timer
and kick the vcpu because it is currently blocked in run_on_cpu() !

Not sure currently what the best fix is here.

Side note -- this use of run_on_cpu() means that we now drop
the iothread lock within memory_region_snapshot_and_clear_dirty(),
which we didn't before. This means that a vCPU thread can now
get in and execute an access to the device registers of
hw/display/vga.c, updating its state in a way I suspect that the
device model code is not expecting... So maybe the right answer
here should be to come up with a fix for the race that 9458a9a1
addresses that doesn't require us to drop the iothread lock in
memory_region_snapshot_and_clear_dirty() ? Alternatively we need
to audit the callers and flag in the documentation that this
function has the unexpected side effect of briefly dropping the
iothread lock.

thanks
-- PMM

