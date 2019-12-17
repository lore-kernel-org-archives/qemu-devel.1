Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B30C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 09:52:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63474207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 09:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cAIc/AxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63474207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih9WN-0007KL-FV
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 04:52:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ih9Ve-0006nN-IW
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 04:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ih9Vd-0005mC-1Q
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 04:51:18 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46757)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ih9Vc-0005lB-PS
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 04:51:16 -0500
Received: by mail-wr1-x444.google.com with SMTP id z7so10503256wrl.13
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 01:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=NaKJgMspXK96PXPoxqU5GH9h7fCR/dnwBXYabK2mpw0=;
 b=cAIc/AxKJtt2hHo7ofHUIhkREZgqGhaYIhJdMu08F3fPmStTWD3NPY5NI05Rd46Qxi
 zbXBmsW1dxBOsnZBqohXZuHxNqQ5r2ZNl9Po5hYD0cvJ9LCKvX6aSVwlA7i+KNfggC32
 VzugRsX2/UATIKcYp+/CMY/Hd0wAevcLlKFnqxNwC9pW52qOHTorLraFAG7wu7fbSdci
 jJh0JHLlKq/CQjwg1TiWR4YYVwQlNvy+ASg2vFw+XBX0/Kla3rVFHSpcuxFBAIWypvLm
 rBegYoHaRKmON6jbS7A6JxLLOZXZxLarPGe0LwwM5hduy5Nl/0C0O5/NKIjIGReF0O/A
 8gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=NaKJgMspXK96PXPoxqU5GH9h7fCR/dnwBXYabK2mpw0=;
 b=nFxYAcL8zeSocLHUXxELyBiKdFCXlMrpqDW5lBAi56XUZQo3650e5wTtkNVK7hnytN
 iQaOhXfE24n4QxClAZDQqcA1lUpPl1xPh9d7PFYAxrIwhJVF7FS0ulYce9BZ0DXThEGx
 p43SL7J++XLr+BcQl7hGYYI9NxO0UXpXWWnCFIwkbtPOTUhB7gKA9jdUhRsNOfbAkf9T
 ug+5RU3ic3MG9qQ47VBaazCUnaELzDy1lxJoc9iZ8rv/CGQmxhm3KNshf6QeGKAFQ6Os
 WRfwygELhtwy2x7PrY2KDBmjGSXGab7WhSOp+9sI0vwCtkQPCgKwmwUwpGRlMHNXi9rq
 8ibA==
X-Gm-Message-State: APjAAAVtrbMOZpHyTGazbQkxWYs36LFOa+Nd9jaG4bx2eU6ll4crzBbY
 MUTt9UwWV7cptGp3wpgCvuZXjQ==
X-Google-Smtp-Source: APXvYqxsdWLa7CWRH1VHH+fWhTsR8W03M/+76VkWVTBrHbb/FIArc9XIx2y/QA0c/A+hZFUoHZCwLQ==
X-Received: by 2002:a05:6000:1052:: with SMTP id
 c18mr35828773wrx.268.1576576275364; 
 Tue, 17 Dec 2019 01:51:15 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w22sm2250615wmk.34.2019.12.17.01.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 01:51:14 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4A9FD1FF87;
 Tue, 17 Dec 2019 09:51:13 +0000 (GMT)
References: <87h83w4dod.fsf@keithp.com>
 <20191104204230.12249-1-keithp@keithp.com> <87h81zwdmw.fsf@linaro.org>
 <5a3b1155-4242-831c-8ae4-e9fb07f1cdb2@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v6)
In-reply-to: <5a3b1155-4242-831c-8ae4-e9fb07f1cdb2@redhat.com>
Date: Tue, 17 Dec 2019 09:51:13 +0000
Message-ID: <87eex3wa9a.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Keith Packard <keithp@keithp.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 17/12/19 09:38, Alex Benn=C3=A9e wrote:
>>   Thread 3 (Thread 0x7f8b1959e700 (LWP 14017)):
>>   #0  0x00007f8b2ada900c in futex_wait_cancelable (private=3D0, expected=
=3D0, futex_word=3D0x56213f5482e8 <console+136>) at ../sysdeps/unix/sysv/li=
nux/futex-internal.h:88
>>   #1  0x00007f8b2ada900c in __pthread_cond_wait_common (abstime=3D0x0, m=
utex=3D0x56213f548298 <console+56>, cond=3D0x56213f5482c0 <console+96>) at =
pthread_cond_wait.c:502
>>   #2  0x00007f8b2ada900c in __pthread_cond_wait (cond=3Dcond@entry=3D0x5=
6213f5482c0 <console+96>, mutex=3Dmutex@entry=3D0x56213f548298 <console+56>=
) at pthread_cond_wait.c:655
>>   #3  0x000056213ea31a40 in qemu_semihosting_console_inc (env=3Denv@entr=
y=3D0x56214138a680) at /home/alex/lsrc/qemu.git/hw/semihosting/console.c:151
>>   #4  0x000056213eab96e8 in do_arm_semihosting (env=3Denv@entry=3D0x5621=
4138a680) at /home/alex/lsrc/qemu.git/target/arm/arm-semi.c:805
>>   #5  0x000056213eacd521 in handle_semihosting (cs=3D<optimized out>) at=
 /home/alex/lsrc/qemu.git/target/arm/helper.c:8476
>>   #6  0x000056213eacd521 in arm_cpu_do_interrupt (cs=3D<optimized out>) =
at /home/alex/lsrc/qemu.git/target/arm/helper.c:8522
>>   #7  0x000056213e9e53d0 in cpu_handle_exception (ret=3D<synthetic point=
er>, cpu=3D0x5621411fe2f0) at /home/alex/lsrc/qemu.git/accel/tcg/cpu-exec.c=
:503
>>   #8  0x000056213e9e53d0 in cpu_exec (cpu=3Dcpu@entry=3D0x562141381550) =
at /home/alex/lsrc/qemu.git/accel/tcg/cpu-exec.c:711
>>   #9  0x000056213e9b4f1f in tcg_cpu_exec (cpu=3D0x562141381550) at /home=
/alex/lsrc/qemu.git/cpus.c:1473
>>   #10 0x000056213e9b715b in qemu_tcg_cpu_thread_fn (arg=3Darg@entry=3D0x=
562141381550) at /home/alex/lsrc/qemu.git/cpus.c:1781
>>   #11 0x000056213ef026fa in qemu_thread_start (args=3D<optimized out>) a=
t /home/alex/lsrc/qemu.git/util/qemu-thread-posix.c:519
>>   #12 0x00007f8b2ada2fa3 in start_thread (arg=3D<optimized out>) at pthr=
ead_create.c:486
>>   #13 0x00007f8b2acd14cf in clone () at ../sysdeps/unix/sysv/linux/x86_6=
4/clone.S:95
>>
>>   Thread 1 (Thread 0x7f8b1c151680 (LWP 14010)):
>>   #0  0x00007f8b2ada900c in futex_wait_cancelable (private=3D0, expected=
=3D0, futex_word=3D0x56213f52c7c8 <qemu_pause_cond+40>) at ../sysdeps/unix/=
sysv/linux/futex-internal.h:88
>>   #1  0x00007f8b2ada900c in __pthread_cond_wait_common (abstime=3D0x0, m=
utex=3D0x56213f52c8c0 <qemu_global_mutex>, cond=3D0x56213f52c7a0 <qemu_paus=
e_cond>) at pthread_cond_wait.c:502
>>   #2  0x00007f8b2ada900c in __pthread_cond_wait (cond=3Dcond@entry=3D0x5=
6213f52c7a0 <qemu_pause_cond>, mutex=3Dmutex@entry=3D0x56213f52c8c0 <qemu_g=
lobal_mutex>) at pthread_cond_wait.c:655
>>   #3  0x000056213ef02e2b in qemu_cond_wait_impl (cond=3D0x56213f52c7a0 <=
qemu_pause_cond>, mutex=3D0x56213f52c8c0 <qemu_global_mutex>, file=3D0x5621=
3ef43700 "/home/alex/lsrc/qemu.git/cpus.c", line=3D1943) at /home/alex/lsrc=
/qemu.git/util/qemu-thread-posix.c:173
>>   #4  0x000056213e9b74a4 in pause_all_vcpus () at /home/alex/lsrc/qemu.g=
it/cpus.c:1943
>>   #5  0x000056213e9b74a4 in pause_all_vcpus () at /home/alex/lsrc/qemu.g=
it/cpus.c:1923
>>   #6  0x000056213e9b7532 in do_vm_stop (state=3DRUN_STATE_SHUTDOWN, send=
_stop=3D<optimized out>) at /home/alex/lsrc/qemu.git/cpus.c:1102
>>   #7  0x000056213e96b8fc in main (argc=3D<optimized out>, argv=3D<optimi=
zed out>, envp=3D<optimized out>) at /home/alex/lsrc/qemu.git/vl.c:4473
>>
>> I guess my first question is why do we need a separate mutex/cond
>> variable for this operation? This seems like the sort of thing that the
>> BQL could protect.
>
> No, please do not introduce more uses of the BQL from the CPU thread.
> The problem seems to lie with the condition variable, not the mutex.

Well in this case we are holding the BQL anyway as we are being called
from the interrupt context. The BQL protects all shared HW state outside
of MMIO which is explicitly marked as doing it's own locking. That said
I don't know if the semihosting console will always be called from a
BQL held context.

>
>> Secondly if the vCPU is paused (via console or gdbstub) we need to
>> unwind from our blocking position and be in a position to restart
>> cleanly.
>
> Perhaps if fifo8_is_empty(&c->fifo) the CPU could update the PC back to
> the SVC instruction and enter a halted state?  Perhaps with a new
> CPU_INTERRUPT_* flag that would be checked in arm_cpu_has_work.

I don't think the PC has been updated at this point - but we don't want
that logic in the common semihosting code. If we cpu_loop_exit the
exception is still in effect and will re-run when we start again.

What we really want to do is fall back to the same halting semantics
that leave us in qemu_wait_io_event until there is something to process.
Is there any particular reason a blocking semihosting event isn't like
any other IO event?

>
> Paolo


--
Alex Benn=C3=A9e

