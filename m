Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6CEC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 09:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9CB720717
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 09:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7pqApxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CB720717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih8qp-0005rs-VU
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 04:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ih8qC-0005Jc-MP
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 04:08:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ih8qA-0002Yc-Ty
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 04:08:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51237
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ih8qA-0002XY-Qz
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 04:08:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576573706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9HJKWolAg41zL7hPO63dV0aW6bVfWeULBzkYg6u1AE8=;
 b=h7pqApxu/+tTHI+rTTw4nOnvIMoJt0U5J/wABmExQTWnYOXwS+rSkTCRHnNlTI2/4bq4Tt
 TIlbQ0oqhG9J/M8xo5R/tXaturqSv29hsEU5TOxoC/gTQ1UVXYMjHiSMlx9WfGHQuus7ro
 aTBpVSt+9kYjsnSD3Ef5Ql7ZNe6fsn8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-Y2YavxRBNKye9sCDV0oCtg-1; Tue, 17 Dec 2019 04:08:24 -0500
Received: by mail-wm1-f72.google.com with SMTP id 18so669770wmp.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 01:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+qsBbSaHrwEfAZlKjDrHR4p3vP6YgzY79tvkGNrzuPk=;
 b=DX4weVWQ0IrSkBJ2h07gMcVzqmz3pfTet6wqhk3QatLtd4qF5H+Q06XWaZrHrWPSUs
 TFyzslaPtQBTuWvV5QjYYA8IeZWmug37uXLSzolU4Y752JceFXaJFav1l00KYWC1K9bA
 InOp8obm9WPpB9L2vNofwV5/LaoriYVVdusCRIy4Eeqj+Gb1asfzC7WPTKOaDItf1h9e
 2YrYoK/lmVDjyeSRUbMOf/f96BV9gk9maFzz+Xhj51MtG2mFMKT7Aw+D3tQ+PvLBiyxb
 SGOEF+F51xIFyn1xGtAD0WWAS2S9k8nrDQ4zbHgvHMrykEJPFRdVCXNAyQPO09bpC7BK
 eIkA==
X-Gm-Message-State: APjAAAWPmroeKgBLDUH3m+UT27aQtXdI6x9uJUqav77Tme+whpNI/hBg
 9HyQPlFyDOFpIbkD/Y9fXd6bUpT5Y1VVw4vPxnxUlK4IgHRdi4+XWN0m9kJILKpNGo/gC3nwdUY
 68rDwEyLIx8VKf1g=
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr4184751wma.24.1576573703659; 
 Tue, 17 Dec 2019 01:08:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxUpZpHRkB6Lb9wmlJR1M48WMujjO4O4ayYRBFoGfnVUqoAx0DdGomaJN9YciA4hGk56OW7pg==
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr4184726wma.24.1576573703355; 
 Tue, 17 Dec 2019 01:08:23 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:503f:4ffc:fc4a:f29a?
 ([2001:b07:6468:f312:503f:4ffc:fc4a:f29a])
 by smtp.gmail.com with ESMTPSA id x6sm2222288wmi.44.2019.12.17.01.08.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 01:08:22 -0800 (PST)
Subject: Re: [PATCH] Semihost SYS_READC implementation (v6)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Keith Packard <keithp@keithp.com>
References: <87h83w4dod.fsf@keithp.com>
 <20191104204230.12249-1-keithp@keithp.com> <87h81zwdmw.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5a3b1155-4242-831c-8ae4-e9fb07f1cdb2@redhat.com>
Date: Tue, 17 Dec 2019 10:08:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87h81zwdmw.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: Y2YavxRBNKye9sCDV0oCtg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/12/19 09:38, Alex Benn=C3=A9e wrote:
>   Thread 3 (Thread 0x7f8b1959e700 (LWP 14017)):
>   #0  0x00007f8b2ada900c in futex_wait_cancelable (private=3D0, expected=
=3D0, futex_word=3D0x56213f5482e8 <console+136>) at ../sysdeps/unix/sysv/li=
nux/futex-internal.h:88
>   #1  0x00007f8b2ada900c in __pthread_cond_wait_common (abstime=3D0x0, mu=
tex=3D0x56213f548298 <console+56>, cond=3D0x56213f5482c0 <console+96>) at p=
thread_cond_wait.c:502
>   #2  0x00007f8b2ada900c in __pthread_cond_wait (cond=3Dcond@entry=3D0x56=
213f5482c0 <console+96>, mutex=3Dmutex@entry=3D0x56213f548298 <console+56>)=
 at pthread_cond_wait.c:655
>   #3  0x000056213ea31a40 in qemu_semihosting_console_inc (env=3Denv@entry=
=3D0x56214138a680) at /home/alex/lsrc/qemu.git/hw/semihosting/console.c:151
>   #4  0x000056213eab96e8 in do_arm_semihosting (env=3Denv@entry=3D0x56214=
138a680) at /home/alex/lsrc/qemu.git/target/arm/arm-semi.c:805
>   #5  0x000056213eacd521 in handle_semihosting (cs=3D<optimized out>) at =
/home/alex/lsrc/qemu.git/target/arm/helper.c:8476
>   #6  0x000056213eacd521 in arm_cpu_do_interrupt (cs=3D<optimized out>) a=
t /home/alex/lsrc/qemu.git/target/arm/helper.c:8522
>   #7  0x000056213e9e53d0 in cpu_handle_exception (ret=3D<synthetic pointe=
r>, cpu=3D0x5621411fe2f0) at /home/alex/lsrc/qemu.git/accel/tcg/cpu-exec.c:=
503
>   #8  0x000056213e9e53d0 in cpu_exec (cpu=3Dcpu@entry=3D0x562141381550) a=
t /home/alex/lsrc/qemu.git/accel/tcg/cpu-exec.c:711
>   #9  0x000056213e9b4f1f in tcg_cpu_exec (cpu=3D0x562141381550) at /home/=
alex/lsrc/qemu.git/cpus.c:1473
>   #10 0x000056213e9b715b in qemu_tcg_cpu_thread_fn (arg=3Darg@entry=3D0x5=
62141381550) at /home/alex/lsrc/qemu.git/cpus.c:1781
>   #11 0x000056213ef026fa in qemu_thread_start (args=3D<optimized out>) at=
 /home/alex/lsrc/qemu.git/util/qemu-thread-posix.c:519
>   #12 0x00007f8b2ada2fa3 in start_thread (arg=3D<optimized out>) at pthre=
ad_create.c:486
>   #13 0x00007f8b2acd14cf in clone () at ../sysdeps/unix/sysv/linux/x86_64=
/clone.S:95
>=20
>   Thread 1 (Thread 0x7f8b1c151680 (LWP 14010)):
>   #0  0x00007f8b2ada900c in futex_wait_cancelable (private=3D0, expected=
=3D0, futex_word=3D0x56213f52c7c8 <qemu_pause_cond+40>) at ../sysdeps/unix/=
sysv/linux/futex-internal.h:88
>   #1  0x00007f8b2ada900c in __pthread_cond_wait_common (abstime=3D0x0, mu=
tex=3D0x56213f52c8c0 <qemu_global_mutex>, cond=3D0x56213f52c7a0 <qemu_pause=
_cond>) at pthread_cond_wait.c:502
>   #2  0x00007f8b2ada900c in __pthread_cond_wait (cond=3Dcond@entry=3D0x56=
213f52c7a0 <qemu_pause_cond>, mutex=3Dmutex@entry=3D0x56213f52c8c0 <qemu_gl=
obal_mutex>) at pthread_cond_wait.c:655
>   #3  0x000056213ef02e2b in qemu_cond_wait_impl (cond=3D0x56213f52c7a0 <q=
emu_pause_cond>, mutex=3D0x56213f52c8c0 <qemu_global_mutex>, file=3D0x56213=
ef43700 "/home/alex/lsrc/qemu.git/cpus.c", line=3D1943) at /home/alex/lsrc/=
qemu.git/util/qemu-thread-posix.c:173
>   #4  0x000056213e9b74a4 in pause_all_vcpus () at /home/alex/lsrc/qemu.gi=
t/cpus.c:1943
>   #5  0x000056213e9b74a4 in pause_all_vcpus () at /home/alex/lsrc/qemu.gi=
t/cpus.c:1923
>   #6  0x000056213e9b7532 in do_vm_stop (state=3DRUN_STATE_SHUTDOWN, send_=
stop=3D<optimized out>) at /home/alex/lsrc/qemu.git/cpus.c:1102
>   #7  0x000056213e96b8fc in main (argc=3D<optimized out>, argv=3D<optimiz=
ed out>, envp=3D<optimized out>) at /home/alex/lsrc/qemu.git/vl.c:4473
>=20
> I guess my first question is why do we need a separate mutex/cond
> variable for this operation? This seems like the sort of thing that the
> BQL could protect.

No, please do not introduce more uses of the BQL from the CPU thread.
The problem seems to lie with the condition variable, not the mutex.

> Secondly if the vCPU is paused (via console or gdbstub) we need to
> unwind from our blocking position and be in a position to restart
> cleanly.

Perhaps if fifo8_is_empty(&c->fifo) the CPU could update the PC back to
the SVC instruction and enter a halted state?  Perhaps with a new
CPU_INTERRUPT_* flag that would be checked in arm_cpu_has_work.

Paolo


