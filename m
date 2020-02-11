Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31741C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 21:59:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA50E20714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 21:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUcEvC2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA50E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1dYf-0004wZ-5o
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 16:59:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j1dXz-0004Pk-UV
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 16:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j1dXy-00016y-4M
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 16:58:23 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50351)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j1dXx-00015S-Sc
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 16:58:22 -0500
Received: by mail-wm1-x342.google.com with SMTP id a5so5683127wmb.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 13:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Ai/IkIqNUKkIVB+V8v61iPuavXB1TfCvR7wQIy6IFjY=;
 b=eUcEvC2MSVqbAlVbEeRLei3lh7SBr/5qu1OLW3PX6PdcLOaCwlJCI7w4QvruQ71at3
 1PVoGBQbDf7qOln1GkENzaCo/mEsEixZ7D27c5PksOAY8DXYJB8kle03t4VDdoEW+FWG
 u5VTGJRReKOTTV416IdVVdfPYgZgDBYEiQ1pbrmZpP3Ww9mGJQFq9+XPL6qLmFpL9hgh
 BBm8DPNtJPV/vqN6TJcLNTOq7+alVa3UebvvnTi6OZzRCvAEblu0VlYww8tJalUImC+Q
 dSVRBTnxbirt1g9ZGeAyZKqsmDdPXb3V1Jlb6inWj8ckq8Z104SLxNXc9crcp1bCsADf
 0MUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Ai/IkIqNUKkIVB+V8v61iPuavXB1TfCvR7wQIy6IFjY=;
 b=q38xXDiDDZ9VYHiDsbnvvNyPZz1l+Q3ZPYAGFK8E0/3KcmNkrCcq+xmjd+bVqLCCcs
 qIpcNYCnD8w+Z5b/P4l1/w1ghkFoSggptMbNAzCTTJDFhc7nRn3ouGmJ9FRNpd5U4zv6
 aoKp79H0j/JcXg7kCZwcUA9t/zzF+DsrSJQZrb+3n270qiBuf9hEZtVZDYUOg2We+Nob
 LYHx3fD+kWQfwYo/1PSSD+SQCUFcADer0WqLAwRPHcExHQhySPUeKdHjX7yQkGoviP++
 38HWWryiskAUcdy0C9jTazzPR2EmKUmeOHyBwikLYOP8bsUtLDheOWWmkqsBuKPSmYMr
 ebXw==
X-Gm-Message-State: APjAAAUK5I38iJojZQqk+pnX/s78+PeJDbiM2lnCuMSfkIibZd7aG8is
 aPwMcQLX62DV86EZyYg6ai1QSg==
X-Google-Smtp-Source: APXvYqzi8HvYUFQviLw7cWH6lPnzsFhFJePSQpmp+0s3NsEotIe6p8YaJuNm2aHH5A2me1Aa7s65Xw==
X-Received: by 2002:a1c:9cce:: with SMTP id f197mr8387061wme.133.1581458300214; 
 Tue, 11 Feb 2020 13:58:20 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d13sm7022191wrc.64.2020.02.11.13.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 13:58:18 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 390631FF87;
 Tue, 11 Feb 2020 21:58:18 +0000 (GMT)
References: <20200211173510.16347-1-alex.bennee@linaro.org>
 <CAFEAcA8GQ=bkQjRvC_XDh_4zZMSCWsoJOB8=7QPg0BgBFYNj8w@mail.gmail.com>
User-agent: mu4e 1.3.8; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] linux-user: un-register threads from RCU before exit
In-reply-to: <CAFEAcA8GQ=bkQjRvC_XDh_4zZMSCWsoJOB8=7QPg0BgBFYNj8w@mail.gmail.com>
Date: Tue, 11 Feb 2020 21:58:18 +0000
Message-ID: <87pnekyef9.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 11 Feb 2020 at 17:36, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Through a mechanism I don't quite yet understand we can find ourselves
>> with a left over RCU thread when we exit group. This is a racy failure
>> that occurs for example with:
>>
>>   alpha-linux-user running testthread
>>     with libhowvec.so plugin
>>     but only when run from make
>>
>> This may not be the correct fix but it seems to alleviate the
>> symptoms.
>
> This is weird. The only time we call preexit_cleanup()
> is when the next thing we do is to terminate the entire
> process all at once. (For some reason in one place
> we do that by calling _exit() and in another place
> by calling exit_group() -- I don't see why we need that
> inconsistency).
>
> I'm pretty sure the system emulation threads don't
> call rcu_unregister_thread() for the "whole process
> is going away" case, so something odd is happening here...

So what I see is (although possibly confused further by rr's capture):

  End of pthread test.
  [New Thread 7966.7967]

  Thread 3 received signal SIGKILL, Killed.
  [Switching to Thread 7966.7967]
  0x0000000070000002 in ?? ()
  (rr) bt
  #0  0x0000000070000002 in ?? ()
  #1  0x00007f36981a490e in _raw_syscall () at /build/rr-79viaC/rr-5.2.0/sr=
c/preload/raw_syscall.S:120
  #2  0x00007f36981a13fe in traced_raw_syscall (call=3Dcall@entry=3D0x7f369=
656ffa0) at ./src/preload/syscallbuf.c:222
  #3  0x00007f36981a271a in sys_xstat64 (call=3D<optimized out>) at ./src/p=
reload/syscallbuf.c:2439
  #4  syscall_hook_internal (call=3D0x7f369656ffa0) at ./src/preload/syscal=
lbuf.c:2651
  #5  syscall_hook (call=3D0x7f369656ffa0) at ./src/preload/syscallbuf.c:26=
87
  #6  0x00007f36981a12da in _syscall_hook_trampoline () at /build/rr-79viaC=
/rr-5.2.0/src/preload/syscall_hook.S:282
  #7  0x00007f36981a130a in __morestack () at /build/rr-79viaC/rr-5.2.0/src=
/preload/syscall_hook.S:417
  #8  0x00007f36981a1310 in _syscall_hook_trampoline_48_3d_01_f0_ff_ff () a=
t /build/rr-79viaC/rr-5.2.0/src/preload/syscall_hook.S:423
  #9  0x00007f369758bf5f in syscall () at ../sysdeps/unix/sysv/linux/x86_64=
/syscall.S:38
  #10 0x0000556b768b764b in qemu_futex_wait (val=3D<optimized out>, f=3D<op=
timized out>) at /home/alex/lsrc/qemu.git/util/qemu-thread-posix.c:455
  #11 qemu_event_wait (ev=3Dev@entry=3D0x556b7897a608 <rcu_call_ready_event=
>) at /home/alex/lsrc/qemu.git/util/qemu-thread-posix.c:459
  #12 0x0000556b768be29a in call_rcu_thread (opaque=3Dopaque@entry=3D0x0) a=
t /home/alex/lsrc/qemu.git/util/rcu.c:260
  #13 0x0000556b768b689a in qemu_thread_start (args=3D<optimized out>) at /=
home/alex/lsrc/qemu.git/util/qemu-thread-posix.c:519
  #14 0x00007f3697660fa3 in start_thread (arg=3D<optimized out>) at pthread=
_create.c:486
  #15 0x00007f36975914cf in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:95
  (rr) info threads
    Id   Target Id                                     Frame
  * 3    Thread 7966.7967 (mmap_hardlink_3_qemu-alpha) 0x0000000070000002 i=
n ?? ()
  (rr)

Although possibly it hasn't moved on from where it was during exit:

  (rr) b preexit_cleanup
  Breakpoint 1 at 0x556b768646d0: file /home/alex/lsrc/qemu.git/linux-user/=
exit.c, line 31.
  (rr) rc
  Continuing.
  [New Thread 7966.7966]
  [Switching to Thread 7966.7966]

  Thread 4 hit Breakpoint 1, preexit_cleanup (env=3D0x556b797aac40, code=3D=
code@entry=3D0) at /home/alex/lsrc/qemu.git/linux-user/exit.c:31
  31          rcu_unregister_thread();
  (rr) bt
  #0  preexit_cleanup (env=3D0x556b797aac40, code=3Dcode@entry=3D0) at /hom=
e/alex/lsrc/qemu.git/linux-user/exit.c:31
  #1  0x0000556b76850a63 in do_syscall1 (cpu_env=3Dcpu_env@entry=3D0x556b79=
7aac40, num=3Dnum@entry=3D405, arg1=3Darg1@entry=3D0, arg2=3Darg2@entry=3D0=
, arg3=3Darg3@entry=3D4832687680, arg4=3Darg4@entry=3D0, arg5=3D4095, arg6=
=3D4832686256, arg8=3D0, arg7=3D0) at /home/alex/lsrc/qemu.git/linux-user/s=
yscall.c:9373
  #2  0x0000556b76859b88 in do_syscall (cpu_env=3Dcpu_env@entry=3D0x556b797=
aac40, num=3D405, arg1=3D0, arg2=3D0, arg3=3D<optimized out>, arg4=3D<optim=
ized out>, arg5=3D4095, arg6=3D4832686256,
  arg7=3D0, arg8=3D0) at /home/alex/lsrc/qemu.git/linux-user/syscall.c:12110
  #3  0x0000556b768645c6 in cpu_loop (env=3D0x556b797aac40) at /home/alex/l=
src/qemu.git/linux-user/alpha/cpu_loop.c:109
  #4  0x0000556b767e13de in main (argc=3D<optimized out>, argv=3D0x7ffe9d8f=
5ca8, envp=3D<optimized out>) at /home/alex/lsrc/qemu.git/linux-user/main.c=
:865
  (rr) info threads
    Id   Target Id                          Frame
    3    Thread 7966.7967 (mmap_hardlink_3) 0x0000000070000002 in ?? ()
  * 4    Thread 7966.7966 (mmap_hardlink_3) preexit_cleanup (env=3D0x556b79=
7aac40, code=3Dcode@entry=3D0) at /home/alex/lsrc/qemu.git/linux-user/exit.=
c:31
  (rr) thread 3
  [Switching to thread 3 (Thread 7966.7967)]
  #0  0x0000000070000002 in ?? ()
  (rr) bt
  #0  0x0000000070000002 in ?? ()
  #1  0x00007f36981a490e in _raw_syscall () at /build/rr-79viaC/rr-5.2.0/sr=
c/preload/raw_syscall.S:120
  #2  0x00007f36981a13fe in traced_raw_syscall (call=3Dcall@entry=3D0x7f369=
656ffa0) at ./src/preload/syscallbuf.c:222
  #3  0x00007f36981a271a in sys_xstat64 (call=3D<optimized out>) at ./src/p=
reload/syscallbuf.c:2439
  #4  syscall_hook_internal (call=3D0x7f369656ffa0) at ./src/preload/syscal=
lbuf.c:2651
  #5  syscall_hook (call=3D0x7f369656ffa0) at ./src/preload/syscallbuf.c:26=
87
  #6  0x00007f36981a12da in _syscall_hook_trampoline () at /build/rr-79viaC=
/rr-5.2.0/src/preload/syscall_hook.S:282
  #7  0x00007f36981a130a in __morestack () at /build/rr-79viaC/rr-5.2.0/src=
/preload/syscall_hook.S:417
  #8  0x00007f36981a1310 in _syscall_hook_trampoline_48_3d_01_f0_ff_ff () a=
t /build/rr-79viaC/rr-5.2.0/src/preload/syscall_hook.S:423
  #9  0x00007f369758bf5f in syscall () at ../sysdeps/unix/sysv/linux/x86_64=
/syscall.S:38
  #10 0x0000556b768b764b in qemu_futex_wait (val=3D<optimized out>, f=3D<op=
timized out>) at /home/alex/lsrc/qemu.git/util/qemu-thread-posix.c:455
  #11 qemu_event_wait (ev=3Dev@entry=3D0x556b7897a608 <rcu_call_ready_event=
>) at /home/alex/lsrc/qemu.git/util/qemu-thread-posix.c:459
  #12 0x0000556b768be29a in call_rcu_thread (opaque=3Dopaque@entry=3D0x0) a=
t /home/alex/lsrc/qemu.git/util/rcu.c:260
  #13 0x0000556b768b689a in qemu_thread_start (args=3D<optimized out>) at /=
home/alex/lsrc/qemu.git/util/qemu-thread-posix.c:519
  #14 0x00007f3697660fa3 in start_thread (arg=3D<optimized out>) at pthread=
_create.c:486
  #15 0x00007f36975914cf in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:95
  (rr)

Of course it is occurring on my patched tree so I guess the unregister
approach doesn't actually help.

>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

