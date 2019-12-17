Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB67C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 08:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E45207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 08:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQVbh9RW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E45207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih8Nt-0001mk-Me
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 03:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ih8N5-0001F7-0P
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 03:38:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ih8N2-0006P1-J2
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 03:38:22 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34259)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ih8N2-0006Ky-8R
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 03:38:20 -0500
Received: by mail-wr1-x444.google.com with SMTP id t2so10330377wrr.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 00:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=UanTn2sevHxPdwCP77RUSC5TLxUqtwG+0yaCDTyANqo=;
 b=OQVbh9RWafeCgrAo55GNlgPsrl0kD1sXGq8kSAh6uzYb7kGnpLkxn7qpf4AtBP/UmA
 7pYhSZg/aIM8Ex60iumuOq5miT8/T5rg610m2jLiihdmV/4IB2JYVwqESxworEO6jQU6
 jIUkbKdacmXuOfECJtVqdXcZH4pBNd2NA6ZC79E4uWD7FYYrdAzggPn9wWsyolXUjMRq
 80KtknN5aex7XxNOCZKVdWpFEFUbl75GNFUwGHlfO/KjHh9Ns/zFrCEvf+5K2G8AEmQA
 d2P15UMSahjnXWBIGqkLOk5yPE0uEl5gZfYJEkY99YC6A97FYrNcwSDnnrTj4aNtEz+K
 6T1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=UanTn2sevHxPdwCP77RUSC5TLxUqtwG+0yaCDTyANqo=;
 b=kV4fZrbyon5Ck1kYX1u3ySJF+7oZ5Xa/Pbl2yQeHtloULyE93qX57IEHzbPP2Qb888
 CEL4Izr+6/nwx/OMh8nh9uVNramaDoGugsxp56OFznchSfnk1VXvU0IDqFvxGdcjjh2D
 lySS/V45hZc88Pr7wp2ov7U1XtD01NiNo4XgivQ0AuxgCTSn/tN9TKvfYYUHZUwieYQo
 mWxY57k/KRJVcOKMXF/Lp2jv7MQd3SWod78c2iXGlcZLv+TLFLYWEg3+QyGEsq2RUyT/
 VSj/b3L6ubHyH/ygAW7P9Dhy0qxkl6NF5tD4CgVgB2+MeTVf4KjTiS7Uj+DHKEdruIkC
 FtZw==
X-Gm-Message-State: APjAAAVEQdRqAJAtAihXQjtajGQ51wJevh44SfUcnhQbS9W4Hzc/PE2R
 AxMKA0R5lbKfMWEQ/4cJhId5fQ==
X-Google-Smtp-Source: APXvYqzWMPMrHhwZ1iYw5eeY8oVBLeGGDcS1cv5YYfSdqD6QyF58yCQS/vLwoYYmm9PKnrqWW35IhQ==
X-Received: by 2002:a05:6000:11c3:: with SMTP id
 i3mr35047398wrx.244.1576571897937; 
 Tue, 17 Dec 2019 00:38:17 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x11sm2110650wmg.46.2019.12.17.00.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 00:38:16 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A15FC1FF87;
 Tue, 17 Dec 2019 08:38:15 +0000 (GMT)
References: <87h83w4dod.fsf@keithp.com>
 <20191104204230.12249-1-keithp@keithp.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Keith Packard <keithp@keithp.com>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v6)
In-reply-to: <20191104204230.12249-1-keithp@keithp.com>
Date: Tue, 17 Dec 2019 08:38:15 +0000
Message-ID: <87h81zwdmw.fsf@linaro.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Keith Packard <keithp@keithp.com> writes:

> Provides a blocking call to read a character from the console using
> semihosting.chardev, if specified. This takes some careful command
> line options to use stdio successfully as the serial ports, monitor
> and semihost all want to use stdio. Here's a sample set of command
> line options which share stdio betwen semihost, monitor and serial
> ports:
>
> 	qemu \
> 	-chardev stdio,mux=3Don,id=3Dstdio0 \
> 	-serial chardev:stdio0 \
> 	-semihosting-config enable=3Don,chardev=3Dstdio0 \
> 	-mon chardev=3Dstdio0,mode=3Dreadline
>
> This creates a chardev hooked to stdio and then connects all of the
> subsystems to it. A shorter mechanism would be good to hear about.
>
> Signed-off-by: Keith Packard <keithp@keithp.com>
>
> ---
>
> v2:
> 	Add implementation in linux-user/arm/semihost.c
>
> v3:  (thanks to Paolo Bonzini <pbonzini@redhat.com>)
> 	Replace hand-rolled fifo with fifo8
> 	Avoid mixing code and declarations
> 	Remove spurious (void) cast of function parameters
> 	Define qemu_semihosting_console_init when CONFIG_USER_ONLY
>
> v4:
> 	Add qemu_semihosting_console_init to stubs/semihost.c for
> 	hosts that don't support semihosting
>
> v5:
> 	Move #include statements to the top of the file.
> 	Actually include the stubs/semihost.c patch that was
> 	supposed to be in v4
> v6:
> 	Move call to qemu_semihosting_console_init earlier in
> 	main so that the mux starts connected to the serial device
> ---
>  hw/semihosting/console.c          | 72 +++++++++++++++++++++++++++++++
>  include/hw/semihosting/console.h  | 12 ++++++
>  include/hw/semihosting/semihost.h |  4 ++
>  linux-user/arm/semihost.c         | 23 ++++++++++
>  stubs/semihost.c                  |  4 ++
>  target/arm/arm-semi.c             |  3 +-
>  vl.c                              |  3 ++
>  7 files changed, 119 insertions(+), 2 deletions(-)
>
> diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
> index b4b17c8afb..4db68d6227 100644
> --- a/hw/semihosting/console.c
> +++ b/hw/semihosting/console.c
> @@ -22,6 +22,12 @@
>  #include "exec/gdbstub.h"
>  #include "qemu/log.h"
>  #include "chardev/char.h"
> +#include <pthread.h>
> +#include "chardev/char-fe.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/main-loop.h"
> +#include "qapi/error.h"
> +#include "qemu/fifo8.h"
>=20=20
>  int qemu_semihosting_log_out(const char *s, int len)
>  {
> @@ -98,3 +104,69 @@ void qemu_semihosting_console_outc(CPUArchState *env,=
 target_ulong addr)
>                        __func__, addr);
>      }
>  }
> +
> +#define FIFO_SIZE   1024
> +
> +typedef struct SemihostingConsole {
> +    CharBackend         backend;
> +    pthread_mutex_t     mutex;
> +    pthread_cond_t      cond;
> +    bool                got;
> +    Fifo8               fifo;
> +} SemihostingConsole;
> +
> +static SemihostingConsole console =3D {
> +    .mutex =3D PTHREAD_MUTEX_INITIALIZER,
> +    .cond =3D PTHREAD_COND_INITIALIZER
> +};
> +
> +static int console_can_read(void *opaque)
> +{
> +    SemihostingConsole *c =3D opaque;
> +    int ret;
> +    pthread_mutex_lock(&c->mutex);
> +    ret =3D (int) fifo8_num_free(&c->fifo);
> +    pthread_mutex_unlock(&c->mutex);
> +    return ret;
> +}
> +
> +static void console_read(void *opaque, const uint8_t *buf, int size)
> +{
> +    SemihostingConsole *c =3D opaque;
> +    pthread_mutex_lock(&c->mutex);
> +    while (size-- && !fifo8_is_full(&c->fifo)) {
> +        fifo8_push(&c->fifo, *buf++);
> +    }
> +    pthread_cond_broadcast(&c->cond);
> +    pthread_mutex_unlock(&c->mutex);
> +}
> +
> +target_ulong qemu_semihosting_console_inc(CPUArchState *env)
> +{
> +    uint8_t ch;
> +    SemihostingConsole *c =3D &console;
> +    qemu_mutex_unlock_iothread();
> +    pthread_mutex_lock(&c->mutex);
> +    while (fifo8_is_empty(&c->fifo)) {
> +        pthread_cond_wait(&c->cond, &c->mutex);
> +    }
> +    ch =3D fifo8_pop(&c->fifo);
> +    pthread_mutex_unlock(&c->mutex);
> +    qemu_mutex_lock_iothread();
> +    return (target_ulong) ch;
> +}

I've been trying to exercise this code with a new test case:

  https://github.com/stsquad/semihosting-tests/tree/readc-test

But I end up deadlocked. Even worse when I issue quit via the mmio we
end up hanging on something that will never complete:

  (gdb) thread apply all bt

  Thread 3 (Thread 0x7f8b1959e700 (LWP 14017)):
  #0  0x00007f8b2ada900c in futex_wait_cancelable (private=3D0, expected=3D=
0, futex_word=3D0x56213f5482e8 <console+136>) at ../sysdeps/unix/sysv/linux=
/futex-internal.h:88
  #1  0x00007f8b2ada900c in __pthread_cond_wait_common (abstime=3D0x0, mute=
x=3D0x56213f548298 <console+56>, cond=3D0x56213f5482c0 <console+96>) at pth=
read_cond_wait.c:502
  #2  0x00007f8b2ada900c in __pthread_cond_wait (cond=3Dcond@entry=3D0x5621=
3f5482c0 <console+96>, mutex=3Dmutex@entry=3D0x56213f548298 <console+56>) a=
t pthread_cond_wait.c:655
  #3  0x000056213ea31a40 in qemu_semihosting_console_inc (env=3Denv@entry=
=3D0x56214138a680) at /home/alex/lsrc/qemu.git/hw/semihosting/console.c:151
  #4  0x000056213eab96e8 in do_arm_semihosting (env=3Denv@entry=3D0x5621413=
8a680) at /home/alex/lsrc/qemu.git/target/arm/arm-semi.c:805
  #5  0x000056213eacd521 in handle_semihosting (cs=3D<optimized out>) at /h=
ome/alex/lsrc/qemu.git/target/arm/helper.c:8476
  #6  0x000056213eacd521 in arm_cpu_do_interrupt (cs=3D<optimized out>) at =
/home/alex/lsrc/qemu.git/target/arm/helper.c:8522
  #7  0x000056213e9e53d0 in cpu_handle_exception (ret=3D<synthetic pointer>=
, cpu=3D0x5621411fe2f0) at /home/alex/lsrc/qemu.git/accel/tcg/cpu-exec.c:503
  #8  0x000056213e9e53d0 in cpu_exec (cpu=3Dcpu@entry=3D0x562141381550) at =
/home/alex/lsrc/qemu.git/accel/tcg/cpu-exec.c:711
  #9  0x000056213e9b4f1f in tcg_cpu_exec (cpu=3D0x562141381550) at /home/al=
ex/lsrc/qemu.git/cpus.c:1473
  #10 0x000056213e9b715b in qemu_tcg_cpu_thread_fn (arg=3Darg@entry=3D0x562=
141381550) at /home/alex/lsrc/qemu.git/cpus.c:1781
  #11 0x000056213ef026fa in qemu_thread_start (args=3D<optimized out>) at /=
home/alex/lsrc/qemu.git/util/qemu-thread-posix.c:519
  #12 0x00007f8b2ada2fa3 in start_thread (arg=3D<optimized out>) at pthread=
_create.c:486
  #13 0x00007f8b2acd14cf in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:95

  Thread 2 (Thread 0x7f8b1c012700 (LWP 14016)):
  #0  0x00007f8b2accbf59 in syscall () at ../sysdeps/unix/sysv/linux/x86_64=
/syscall.S:38
  #1  0x000056213ef034ab in qemu_futex_wait (val=3D<optimized out>, f=3D<op=
timized out>) at /home/alex/lsrc/qemu.git/util/qemu-thread-posix.c:455
  #2  0x000056213ef034ab in qemu_event_wait (ev=3Dev@entry=3D0x56213f55ffe0=
 <rcu_gp_event>) at /home/alex/lsrc/qemu.git/util/qemu-thread-posix.c:459
  #3  0x000056213ef14dc7 in wait_for_readers () at /home/alex/lsrc/qemu.git=
/util/rcu.c:134
  #4  0x000056213ef14dc7 in synchronize_rcu () at /home/alex/lsrc/qemu.git/=
util/rcu.c:170
  #5  0x000056213ef1508d in call_rcu_thread (opaque=3Dopaque@entry=3D0x0) a=
t /home/alex/lsrc/qemu.git/util/rcu.c:267
  #6  0x000056213ef026fa in qemu_thread_start (args=3D<optimized out>) at /=
home/alex/lsrc/qemu.git/util/qemu-thread-posix.c:519
  #7  0x00007f8b2ada2fa3 in start_thread (arg=3D<optimized out>) at pthread=
_create.c:486
  #8  0x00007f8b2acd14cf in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:95

  Thread 1 (Thread 0x7f8b1c151680 (LWP 14010)):
  #0  0x00007f8b2ada900c in futex_wait_cancelable (private=3D0, expected=3D=
0, futex_word=3D0x56213f52c7c8 <qemu_pause_cond+40>) at ../sysdeps/unix/sys=
v/linux/futex-internal.h:88
  #1  0x00007f8b2ada900c in __pthread_cond_wait_common (abstime=3D0x0, mute=
x=3D0x56213f52c8c0 <qemu_global_mutex>, cond=3D0x56213f52c7a0 <qemu_pause_c=
ond>) at pthread_cond_wait.c:502
  #2  0x00007f8b2ada900c in __pthread_cond_wait (cond=3Dcond@entry=3D0x5621=
3f52c7a0 <qemu_pause_cond>, mutex=3Dmutex@entry=3D0x56213f52c8c0 <qemu_glob=
al_mutex>) at pthread_cond_wait.c:655
  #3  0x000056213ef02e2b in qemu_cond_wait_impl (cond=3D0x56213f52c7a0 <qem=
u_pause_cond>, mutex=3D0x56213f52c8c0 <qemu_global_mutex>, file=3D0x56213ef=
43700 "/home/alex/lsrc/qemu.git/cpus.c", line=3D1943) at /home/alex/lsrc/qe=
mu.git/util/qemu-thread-posix.c:173
  #4  0x000056213e9b74a4 in pause_all_vcpus () at /home/alex/lsrc/qemu.git/=
cpus.c:1943
  #5  0x000056213e9b74a4 in pause_all_vcpus () at /home/alex/lsrc/qemu.git/=
cpus.c:1923
  #6  0x000056213e9b7532 in do_vm_stop (state=3DRUN_STATE_SHUTDOWN, send_st=
op=3D<optimized out>) at /home/alex/lsrc/qemu.git/cpus.c:1102
  #7  0x000056213e96b8fc in main (argc=3D<optimized out>, argv=3D<optimized=
 out>, envp=3D<optimized out>) at /home/alex/lsrc/qemu.git/vl.c:4473

I guess my first question is why do we need a separate mutex/cond
variable for this operation? This seems like the sort of thing that the
BQL could protect.

Secondly if the vCPU is paused (via console or gdbstub) we need to
unwind from our blocking position and be in a position to restart
cleanly.

> +
> +void qemu_semihosting_console_init(void)
> +{
> +    Chardev *chr =3D semihosting_get_chardev();
> +
> +    if  (chr) {
> +        fifo8_create(&console.fifo, FIFO_SIZE);
> +        qemu_chr_fe_init(&console.backend, chr, &error_abort);
> +        qemu_chr_fe_set_handlers(&console.backend,
> +                                 console_can_read,
> +                                 console_read,
> +                                 NULL, NULL, &console,
> +                                 NULL, true);
> +    }
> +}
> diff --git a/include/hw/semihosting/console.h b/include/hw/semihosting/co=
nsole.h
> index 9be9754bcd..f7d5905b41 100644
> --- a/include/hw/semihosting/console.h
> +++ b/include/hw/semihosting/console.h
> @@ -37,6 +37,18 @@ int qemu_semihosting_console_outs(CPUArchState *env, t=
arget_ulong s);
>   */
>  void qemu_semihosting_console_outc(CPUArchState *env, target_ulong c);
>=20=20
> +/**
> + * qemu_semihosting_console_inc:
> + * @env: CPUArchState
> + *
> + * Receive single character from debug console. This
> + * may be the remote gdb session if a softmmu guest is currently being
> + * debugged.
> + *
> + * Returns: character read or -1 on error
> + */
> +target_ulong qemu_semihosting_console_inc(CPUArchState *env);
> +
>  /**
>   * qemu_semihosting_log_out:
>   * @s: pointer to string
> diff --git a/include/hw/semihosting/semihost.h b/include/hw/semihosting/s=
emihost.h
> index 60fc42d851..b8ce5117ae 100644
> --- a/include/hw/semihosting/semihost.h
> +++ b/include/hw/semihosting/semihost.h
> @@ -56,6 +56,9 @@ static inline Chardev *semihosting_get_chardev(void)
>  {
>      return NULL;
>  }
> +static inline void qemu_semihosting_console_init(void)
> +{
> +}
>  #else /* !CONFIG_USER_ONLY */
>  bool semihosting_enabled(void);
>  SemihostingTarget semihosting_get_target(void);
> @@ -68,6 +71,7 @@ Chardev *semihosting_get_chardev(void);
>  void qemu_semihosting_enable(void);
>  int qemu_semihosting_config_options(const char *opt);
>  void qemu_semihosting_connect_chardevs(void);
> +void qemu_semihosting_console_init(void);
>  #endif /* CONFIG_USER_ONLY */
>=20=20
>  #endif /* SEMIHOST_H */
> diff --git a/linux-user/arm/semihost.c b/linux-user/arm/semihost.c
> index a16b525eec..4f998d6220 100644
> --- a/linux-user/arm/semihost.c
> +++ b/linux-user/arm/semihost.c
> @@ -14,6 +14,7 @@
>  #include "cpu.h"
>  #include "hw/semihosting/console.h"
>  #include "qemu.h"
> +#include <poll.h>
>=20=20
>  int qemu_semihosting_console_outs(CPUArchState *env, target_ulong addr)
>  {
> @@ -47,3 +48,25 @@ void qemu_semihosting_console_outc(CPUArchState *env, =
target_ulong addr)
>          }
>      }
>  }
> +
> +target_ulong qemu_semihosting_console_inc(CPUArchState *env)
> +{
> +    uint8_t c;
> +    struct pollfd pollfd =3D {
> +        .fd =3D STDIN_FILENO,
> +        .events =3D POLLIN
> +    };
> +
> +    if (poll(&pollfd, 1, -1) !=3D 1) {
> +        qemu_log_mask(LOG_UNIMP, "%s: unexpected read from stdin failure=
",
> +                      __func__);
> +        return (target_ulong) -1;
> +    }
> +
> +    if (read(STDIN_FILENO, &c, 1) !=3D 1) {
> +        qemu_log_mask(LOG_UNIMP, "%s: unexpected read from stdin failure=
",
> +                      __func__);
> +        return (target_ulong) -1;
> +    }
> +    return (target_ulong) c;
> +}
> diff --git a/stubs/semihost.c b/stubs/semihost.c
> index f90589259c..1d8b37f7b2 100644
> --- a/stubs/semihost.c
> +++ b/stubs/semihost.c
> @@ -69,3 +69,7 @@ void semihosting_arg_fallback(const char *file, const c=
har *cmd)
>  void qemu_semihosting_connect_chardevs(void)
>  {
>  }
> +
> +void qemu_semihosting_console_init(void)
> +{
> +}
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index 6f7b6d801b..47d61f6fe1 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -802,8 +802,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>=20=20
>          return guestfd_fns[gf->type].readfn(cpu, gf, arg1, len);
>      case TARGET_SYS_READC:
> -        qemu_log_mask(LOG_UNIMP, "%s: SYS_READC not implemented", __func=
__);
> -        return 0;
> +        return qemu_semihosting_console_inc(env);
>      case TARGET_SYS_ISTTY:
>          GET_ARG(0);
>=20=20
> diff --git a/vl.c b/vl.c
> index 4489cfb2bb..7ea8a907fd 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4284,6 +4284,9 @@ int main(int argc, char **argv, char **envp)
>      qemu_opts_foreach(qemu_find_opts("mon"),
>                        mon_init_func, NULL, &error_fatal);
>=20=20
> +    /* connect semihosting console input if requested */
> +    qemu_semihosting_console_init();
> +
>      if (foreach_device_config(DEV_SERIAL, serial_parse) < 0)
>          exit(1);
>      if (foreach_device_config(DEV_PARALLEL, parallel_parse) < 0)


--=20
Alex Benn=C3=A9e

