Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9C1CA9EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 09:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A62921D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 09:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dnEorKPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A62921D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNwL1-0002b1-Au
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 05:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNwGH-0005U2-8n
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNwGE-0001g0-Sq
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:52:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33923)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNwGE-0001fe-G8
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:51:58 -0400
Received: by mail-wr1-x441.google.com with SMTP id t16so1583791wrr.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 02:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=h72ssrMfOueJUO1F6L+QsXWBTEA4iYzhcbRVfDJJeo0=;
 b=dnEorKPnSTekdu4uKZsxsw6+5D82Qcag1kZLSJee0uEEtM1vvGEtWdAEjPg9397p8x
 YCCrW131TTM+x5z+SZoFkjqldd3I0155wAIr+qDeL4X65WG//DMGvytvdGLHnbUopVFt
 O10bC/YYtfIixlK3TH75R4mJRKpFPJbzknVlyb4qfL3/L2D1/iR02ZOYxtLB9G+kaN+O
 0X3xOfidWH7RQpE9CD4bVP/kPcbDyHhT32rrHVKq+NtnfDrVUk3T1QhALihaNPHWDnUp
 8a4kzh9Z9kf8VzApFfN1AKk5obtq9y1+1spMpwwgVyM/LebFO5XruPK3gVO56W7oJPq0
 jgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=h72ssrMfOueJUO1F6L+QsXWBTEA4iYzhcbRVfDJJeo0=;
 b=H0Jih7mVEjAgoD5/vJHzcmzu41sn7o5OT1Th2d5LU1KpJZ4RAw6XW71K/zSaFjurpm
 71SttpTvou0tYsNfZV0MMXPOtvyQyU3bvA1I/kg7K71R6suFiuvEZdixFB2JntHp88oI
 hCe4rIC3djIV1XSbE9iOwOj0sW9jgHnLJF7wFSXuW5KhApIjSeuWWgXDSRbS8n40mQIi
 gq2lHlb+X9Y7avK9fliQcUs0I6k7+zZ8xAIkVyKI27NUN/A9fPohSclMX9IDYbU8dgvj
 Kmp3Pzwxr0xkfoXsiMduYOe726rGL0iJkS+84cNX2YZFOa3j5aeIKI9iIk1Lkp1QWVKV
 VMTA==
X-Gm-Message-State: APjAAAWVMpTeuE/DcSObIVzeRmSUla0JqHJVcNIupnTaSyibQPZi3FYL
 OxWP7tvCJ8hwXb+a6UwxKckRyZ3Oo/w=
X-Google-Smtp-Source: APXvYqyppvYxiC0wDD9Fi0mlAgztdpSEoztVfvN9pPrOVvFhqaGkBI9kjzyS5iPowPhq0ti8QD1H9g==
X-Received: by 2002:adf:9b9d:: with SMTP id d29mr2132964wrc.293.1571997116707; 
 Fri, 25 Oct 2019 02:51:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u21sm2313999wmu.27.2019.10.25.02.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 02:51:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4FE121FF87;
 Fri, 25 Oct 2019 10:51:55 +0100 (BST)
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
In-reply-to: <20191024224622.12371-1-keithp@keithp.com>
Date: Fri, 25 Oct 2019 10:51:55 +0100
Message-ID: <8736fhm9tw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Keith Packard <keithp@keithp.com>
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

I can see the use for this but I'd like to know what you are testing
with. We only have very basic smoketests in check-tcg but I've tested
with the latest arm-semihosting tests and they are all fine so no
regressions there.

>
> This creates a chardev hooked to stdio and then connects all of the
> subsystems to it. A shorter mechanism would be good to hear about.

Please keep version history bellow --- so they get dropped when the
patch is applied.

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

This doesn't appear to be in the diff which is why I'm seeing a compile
failure for non-CONFIG_SEMIHOST machines. However...

>
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>  hw/semihosting/console.c          | 73 +++++++++++++++++++++++++++++++
>  include/hw/semihosting/console.h  | 12 +++++
>  include/hw/semihosting/semihost.h |  4 ++
>  linux-user/arm/semihost.c         | 24 ++++++++++
>  target/arm/arm-semi.c             |  3 +-
>  vl.c                              |  3 ++
>  6 files changed, 117 insertions(+), 2 deletions(-)
>
> diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
> index b4b17c8afb..197bff079b 100644
> --- a/hw/semihosting/console.c
> +++ b/hw/semihosting/console.c
> @@ -98,3 +98,76 @@ void qemu_semihosting_console_outc(CPUArchState *env, =
target_ulong addr)
>                        __func__, addr);
>      }
>  }
> +
> +#include <pthread.h>
> +#include "chardev/char-fe.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/main-loop.h"
> +#include "qapi/error.h"
> +#include "qemu/fifo8.h"
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
>
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
>
>  #endif /* SEMIHOST_H */
> diff --git a/linux-user/arm/semihost.c b/linux-user/arm/semihost.c
> index a16b525eec..13a097515b 100644
> --- a/linux-user/arm/semihost.c
> +++ b/linux-user/arm/semihost.c
> @@ -47,3 +47,27 @@ void qemu_semihosting_console_outc(CPUArchState *env, =
target_ulong addr)
>          }
>      }
>  }
> +
> +#include <poll.h>

Headers should go at the top...I was about to discuss the usage of
poll() but I realise we are in linux-user here so non-POSIX portability
isn't an issue.

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
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index 6f7b6d801b..47d61f6fe1 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -802,8 +802,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>
>          return guestfd_fns[gf->type].readfn(cpu, gf, arg1, len);
>      case TARGET_SYS_READC:
> -        qemu_log_mask(LOG_UNIMP, "%s: SYS_READC not implemented", __func=
__);
> -        return 0;
> +        return qemu_semihosting_console_inc(env);

I'm not sure this would be correct if there was no character available.
The docs imply it blocks although don't say so explicitly AFAICT.

>      case TARGET_SYS_ISTTY:
>          GET_ARG(0);
>
> diff --git a/vl.c b/vl.c
> index 4489cfb2bb..ac584d97ea 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4381,6 +4381,9 @@ int main(int argc, char **argv, char **envp)
>      ds =3D init_displaystate();
>      qemu_display_init(ds, &dpy);
>
> +    /* connect semihosting console input if requested */
> +    qemu_semihosting_console_init();
> +

I'd rather rename qemu_semihosting_connect_chardevs to
qemu_semihosting_init and keep all our bits of semihosting setup in
there rather than having multiple calls out of vl.c

>      /* must be after terminal init, SDL library changes signal handlers =
*/
>      os_setup_signal_handling();


--
Alex Benn=C3=A9e

