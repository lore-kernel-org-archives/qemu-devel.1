Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F771C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:52:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40536208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I0KXIXY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40536208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDtA-0003lM-EE
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlDsO-0002n4-1i
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:51:52 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlDsL-0001i1-8f
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:51:51 -0400
Received: by mail-wm1-x341.google.com with SMTP id c71so3355098wmd.5
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=dyNU5SpYuQVkCdnMp0J0uAzAinQGGxJen8m11073y5s=;
 b=I0KXIXY9FgClgQf5IPi/ed6PrYH4u0lI/qRZ9geXyYZVWDHqb4amDOGDgoJ9of5eRF
 lYiX+CgO1VomWqfuZjs0RwALRz+Vn4GhmKkBYJobXmGu2D8D85I4gbd3xbcOs4xO10Bw
 P40thdR6o9cDgDpq3DMZp4bpdx0ebBBA/Szjmw8/TTzBofgVkNQtcQ6DS1Px7B82vnfD
 nnpq0goxjAdeHTl9vRQ7nBqBIwBUOXPy0nkzTheJjV1gRnzuYklrL6B6sW4KqNKWt4Ij
 w3XI1LcZt42rogXfwp4w+mTmvxfNiWv7xCXKkotIHNMgcq6IbryMFD4TlosmrsQHPx9i
 j2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=dyNU5SpYuQVkCdnMp0J0uAzAinQGGxJen8m11073y5s=;
 b=C42PztBPZ/pMdNAAHwbRmf+2Yi2kZlEL+blj1OWkqzP2N7j+/g6Guxx52QZ8PhBUF2
 RjLKXQEzaBxDbmchEUBfIL76CTrp/qWOHyk9NrerE5eqwXQdpp5eFdPTV+GF9vc2ilmB
 osISU+/dYI0gsmJLixKZC7errfosCtrUCI48hKKQiVDJEVkHR+ZEuvYLD96iBAA8ae4i
 0mUdfaiKpUM1N962L2ZbWhikt5aHiK2XbgQDWim3aqCj5/nHiqpc4hEfK/QBCG5Rff2M
 lpLGqoNKSEt+cfBQq4zr+VVzjraPXtdo2w5mCkpsMSYlYUDDrTHc8IQ5gON9Z+E/mQo4
 eU4A==
X-Gm-Message-State: AOAM531gNmJku7dMv/qCYeth7BTyrwX4TmUlTW+NI1jmt52TRJziieiY
 ZoyYS/zuGHYMIDeHUr4+cpCnXJ9JUH4=
X-Google-Smtp-Source: ABdhPJzdgDYuaivkhZbkcu0A1DwdgTDajlvjUyruFKE9BpmXnr9Q8Pkd4rfZufPLLsjHW1EUVBTrbQ==
X-Received: by 2002:a05:600c:224f:: with SMTP id
 a15mr3789885wmm.166.1592322707347; 
 Tue, 16 Jun 2020 08:51:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n204sm4834046wma.5.2020.06.16.08.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 08:51:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4B83A1FF7E;
 Tue, 16 Jun 2020 16:51:45 +0100 (BST)
References: <20200612014606.147691-1-jkz@google.com>
 <20200612014606.147691-2-jkz@google.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Josh Kunz <jkz@google.com>
Subject: Re: [PATCH 1/5] linux-user: Refactor do_fork to use new `qemu_clone`
In-reply-to: <20200612014606.147691-2-jkz@google.com>
Date: Tue, 16 Jun 2020 16:51:45 +0100
Message-ID: <87mu53ypny.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: riku.voipio@iki.fi, qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Josh Kunz <jkz@google.com> writes:

> This is pre-work for adding full support for the `CLONE_VM` `clone`
> flag. In a follow-up patch, we'll add support to `clone.c` for
> `clone_vm`-type clones beyond threads. CLONE_VM support is more
> complicated, so first we're splitting existing clone mechanisms
> (pthread_create, and fork) into a separate file.
>
> Signed-off-by: Josh Kunz <jkz@google.com>
> ---
>  linux-user/Makefile.objs |   2 +-
>  linux-user/clone.c       | 152 ++++++++++++++++
>  linux-user/clone.h       |  27 +++
>  linux-user/syscall.c     | 376 +++++++++++++++++++--------------------
>  4 files changed, 365 insertions(+), 192 deletions(-)
>  create mode 100644 linux-user/clone.c
>  create mode 100644 linux-user/clone.h
>
> diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
> index 1940910a73..d6788f012c 100644
> --- a/linux-user/Makefile.objs
> +++ b/linux-user/Makefile.objs
> @@ -1,7 +1,7 @@
>  obj-y =3D main.o syscall.o strace.o mmap.o signal.o \
>  	elfload.o linuxload.o uaccess.o uname.o \
>  	safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
> -        $(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o
> +        $(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o clone.o
>=20=20
>  obj-$(TARGET_HAS_BFLT) +=3D flatload.o
>  obj-$(TARGET_I386) +=3D vm86.o
> diff --git a/linux-user/clone.c b/linux-user/clone.c
> new file mode 100644
> index 0000000000..f02ae8c464
> --- /dev/null
> +++ b/linux-user/clone.c
> @@ -0,0 +1,152 @@
> +#include "qemu/osdep.h"
> +#include "qemu.h"
> +#include "clone.h"
> +#include <pthread.h>
> +#include <sched.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <stdbool.h>
> +#include <assert.h>
> +
> +static const unsigned long NEW_STACK_SIZE =3D 0x40000UL;
> +
> +/*
> + * A completion tracks an event that can be completed. It's based on the
> + * kernel concept with the same name, but implemented with userspace loc=
ks.
> + */
> +struct completion {
> +    /* done is set once this completion has been completed. */
> +    bool done;
> +    /* mu syncronizes access to this completion. */
> +    pthread_mutex_t mu;
> +    /* cond is used to broadcast completion status to awaiting threads. =
*/
> +    pthread_cond_t cond;
> +};
> +
> +static void completion_init(struct completion *c)
> +{
> +    c->done =3D false;
> +    pthread_mutex_init(&c->mu, NULL);
> +    pthread_cond_init(&c->cond, NULL);
> +}
> +
> +/*
> + * Block until the given completion finishes. Returns immediately if the
> + * completion has already finished.
> + */
> +static void completion_await(struct completion *c)
> +{
> +    pthread_mutex_lock(&c->mu);
> +    if (c->done) {
> +        pthread_mutex_unlock(&c->mu);
> +        return;
> +    }
> +    pthread_cond_wait(&c->cond, &c->mu);
> +    assert(c->done && "returned from cond wait without being marked as d=
one");
> +    pthread_mutex_unlock(&c->mu);
> +}

This introduces another sync mechanism specifically for clone behaviour
- is there a reason one of the exiting mechanisms can't be used? If this
brings new useful functionality it might be worth introducing it as a
system wide function.

> +
> +/*
> + * Finish the completion. Unblocks all awaiters.
> + */
> +static void completion_finish(struct completion *c)
> +{
> +    pthread_mutex_lock(&c->mu);
> +    assert(!c->done && "trying to finish an already finished completion"=
);
> +    c->done =3D true;
> +    pthread_cond_broadcast(&c->cond);
> +    pthread_mutex_unlock(&c->mu);
> +}
> +
> +struct clone_thread_info {
> +    struct completion running;
> +    int tid;
> +    int (*callback)(void *);
> +    void *payload;
> +};
> +
> +static void *clone_thread_run(void *raw_info)
> +{
> +    struct clone_thread_info *info =3D (struct clone_thread_info *) raw_=
info;
> +    info->tid =3D syscall(SYS_gettid);
> +
> +    /*
> +     * Save out callback/payload since lifetime of info is only guarante=
ed
> +     * until we finish the completion.
> +     */
> +    int (*callback)(void *) =3D info->callback;
> +    void *payload =3D info->payload;
> +    completion_finish(&info->running);
> +
> +    _exit(callback(payload));
> +}
> +
> +static int clone_thread(int flags, int (*callback)(void *), void
> *payload)

It's nicer to typedef a function call type rather than manually casting
to it each time.

> +{
> +    struct clone_thread_info info;
> +    pthread_attr_t attr;
> +    int ret;
> +    pthread_t thread_unused;
> +
> +    memset(&info, 0, sizeof(info));
> +
> +    completion_init(&info.running);
> +    info.callback =3D callback;
> +    info.payload =3D payload;
> +
> +    (void)pthread_attr_init(&attr);
> +    (void)pthread_attr_setstacksize(&attr, NEW_STACK_SIZE);
> +    (void)pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
> +
> +    ret =3D pthread_create(&thread_unused, &attr, clone_thread_run, (voi=
d *) &info);
> +    /* pthread_create returns errors directly, instead of via errno. */
> +    if (ret !=3D 0) {
> +        errno =3D ret;
> +        ret =3D -1;
> +    } else {
> +        completion_await(&info.running);
> +        ret =3D info.tid;
> +    }
> +
> +    pthread_attr_destroy(&attr);
> +    return ret;
> +}
> +
> +int qemu_clone(int flags, int (*callback)(void *), void *payload)
> +{
> +    int ret;
> +
> +    if (clone_flags_are_thread(flags)) {
> +        /*
> +         * The new process uses the same flags as pthread_create, so we =
can
> +         * use pthread_create directly. This is an optimization.
> +         */
> +        return clone_thread(flags, callback, payload);
> +    }
> +
> +    if (clone_flags_are_fork(flags)) {
> +        /*
> +         * Special case a true `fork` clone call. This is so we can take
> +         * advantage of special pthread_atfork handlers in libraries we
> +         * depend on (e.g., glibc). Without this, existing users of `for=
k`
> +         * in multi-threaded environments will likely get new flaky
> +         * deadlocks.
> +         */
> +        fork_start();
> +        ret =3D fork();
> +        if (ret =3D=3D 0) {
> +            fork_end(1);
> +            _exit(callback(payload));
> +        }
> +        fork_end(0);
> +        return ret;
> +    }
> +
> +    /* !fork && !thread */
> +    errno =3D EINVAL;
> +    return -1;
> +}
> diff --git a/linux-user/clone.h b/linux-user/clone.h
> new file mode 100644
> index 0000000000..34ae9b3780
> --- /dev/null
> +++ b/linux-user/clone.h
> @@ -0,0 +1,27 @@
> +#ifndef CLONE_H
> +#define CLONE_H
> +
> +/*
> + * qemu_clone executes the given `callback`, with the given payload as t=
he
> + * first argument, in a new process created with the given flags. Some c=
lone
> + * flags, such as *SETTLS, *CLEARTID are not supported. The child thread=
 ID is
> + * returned on success, otherwise negative errno is returned on clone fa=
ilure.
> + */
> +int qemu_clone(int flags, int (*callback)(void *), void *payload);
> +
> +/* Returns true if the given clone flags can be emulated with libc fork.=
 */
> +static bool clone_flags_are_fork(unsigned int flags)
> +{
> +    return flags =3D=3D SIGCHLD;
> +}
> +
> +/* Returns true if the given clone flags can be emulated with pthread_cr=
eate. */
> +static bool clone_flags_are_thread(unsigned int flags)
> +{
> +    return flags =3D=3D (
> +        CLONE_VM | CLONE_FS | CLONE_FILES |
> +        CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM
> +    );
> +}

This is fine in of itself but we seemed to have lost some context from
moving the flags from syscall.c.

> +
> +#endif /* CLONE_H */
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 97de9fb5c9..7ce021cea2 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -122,6 +122,7 @@
>  #include "qapi/error.h"
>  #include "fd-trans.h"
>  #include "tcg/tcg.h"
> +#include "clone.h"
>=20=20
>  #ifndef CLONE_IO
>  #define CLONE_IO                0x80000000      /* Clone io context */
> @@ -135,12 +136,6 @@
>   *  * flags we can implement within QEMU itself
>   *  * flags we can't support and will return an error for
>   */
> -/* For thread creation, all these flags must be present; for
> - * fork, none must be present.
> - */
> -#define CLONE_THREAD_FLAGS                              \
> -    (CLONE_VM | CLONE_FS | CLONE_FILES |                \
> -     CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM)
>=20=20
>  /* These flags are ignored:
>   * CLONE_DETACHED is now ignored by the kernel;
> @@ -150,30 +145,10 @@
>      (CLONE_DETACHED | CLONE_IO)
>=20=20
>  /* Flags for fork which we can implement within QEMU itself */
> -#define CLONE_OPTIONAL_FORK_FLAGS               \
> +#define CLONE_EMULATED_FLAGS               \
>      (CLONE_SETTLS | CLONE_PARENT_SETTID |       \
>       CLONE_CHILD_CLEARTID | CLONE_CHILD_SETTID)
>=20=20
> -/* Flags for thread creation which we can implement within QEMU itself */
> -#define CLONE_OPTIONAL_THREAD_FLAGS                             \
> -    (CLONE_SETTLS | CLONE_PARENT_SETTID |                       \
> -     CLONE_CHILD_CLEARTID | CLONE_CHILD_SETTID | CLONE_PARENT)
> -
> -#define CLONE_INVALID_FORK_FLAGS                                        \
> -    (~(CSIGNAL | CLONE_OPTIONAL_FORK_FLAGS | CLONE_IGNORED_FLAGS))
> -
> -#define CLONE_INVALID_THREAD_FLAGS                                      \
> -    (~(CSIGNAL | CLONE_THREAD_FLAGS | CLONE_OPTIONAL_THREAD_FLAGS |     \
> -       CLONE_IGNORED_FLAGS))
> -
> -/* CLONE_VFORK is special cased early in do_fork(). The other flag bits
> - * have almost all been allocated. We cannot support any of
> - * CLONE_NEWNS, CLONE_NEWCGROUP, CLONE_NEWUTS, CLONE_NEWIPC,
> - * CLONE_NEWUSER, CLONE_NEWPID, CLONE_NEWNET, CLONE_PTRACE, CLONE_UNTRAC=
ED.
> - * The checks against the invalid thread masks above will catch these.
> - * (The one remaining unallocated bit is 0x1000 which used to be CLONE_P=
ID.)
> - */
> -

I think some of the above can be usefully moved to clone.h to discuss
the various clone/fork options QEMU can and can't support.

>  /* Define DEBUG_ERESTARTSYS to force every syscall to be restarted
>   * once. This exercises the codepaths for restart.
>   */
> @@ -1104,7 +1079,7 @@ static inline rlim_t target_to_host_rlim(abi_ulong =
target_rlim)
>  {
>      abi_ulong target_rlim_swap;
>      rlim_t result;
> -=20=20=20=20
> +
>      target_rlim_swap =3D tswapal(target_rlim);
>      if (target_rlim_swap =3D=3D TARGET_RLIM_INFINITY)
>          return RLIM_INFINITY;
> @@ -1112,7 +1087,7 @@ static inline rlim_t target_to_host_rlim(abi_ulong =
target_rlim)
>      result =3D target_rlim_swap;
>      if (target_rlim_swap !=3D (rlim_t)result)
>          return RLIM_INFINITY;
> -=20=20=20=20
> +
>      return result;
>  }
>  #endif
> @@ -1122,13 +1097,13 @@ static inline abi_ulong host_to_target_rlim(rlim_=
t rlim)
>  {
>      abi_ulong target_rlim_swap;
>      abi_ulong result;
> -=20=20=20=20
> +
>      if (rlim =3D=3D RLIM_INFINITY || rlim !=3D (abi_long)rlim)
>          target_rlim_swap =3D TARGET_RLIM_INFINITY;
>      else
>          target_rlim_swap =3D rlim;
>      result =3D tswapal(target_rlim_swap);
> -=20=20=20=20
> +
>      return result;
>  }
>  #endif
> @@ -1615,10 +1590,11 @@ static inline abi_long target_to_host_cmsg(struct=
 msghdr *msgh,
>      abi_ulong target_cmsg_addr;
>      struct target_cmsghdr *target_cmsg, *target_cmsg_start;
>      socklen_t space =3D 0;
> -=20=20=20=20
> +
>      msg_controllen =3D tswapal(target_msgh->msg_controllen);
> -    if (msg_controllen < sizeof (struct target_cmsghdr))=20
> +    if (msg_controllen < sizeof(struct target_cmsghdr)) {
>          goto the_end;
> +    }
>      target_cmsg_addr =3D tswapal(target_msgh->msg_control);
>      target_cmsg =3D lock_user(VERIFY_READ, target_cmsg_addr, msg_control=
len, 1);
>      target_cmsg_start =3D target_cmsg;
> @@ -1703,8 +1679,9 @@ static inline abi_long host_to_target_cmsg(struct t=
arget_msghdr *target_msgh,
>      socklen_t space =3D 0;
>=20=20
>      msg_controllen =3D tswapal(target_msgh->msg_controllen);
> -    if (msg_controllen < sizeof (struct target_cmsghdr))=20
> +    if (msg_controllen < sizeof(struct target_cmsghdr)) {
>          goto the_end;
> +    }

Try and avoid un-related whitespace fixes in code that is otherwise unchang=
ed.

>      target_cmsg_addr =3D tswapal(target_msgh->msg_control);
>      target_cmsg =3D lock_user(VERIFY_WRITE, target_cmsg_addr, msg_contro=
llen, 0);
>      target_cmsg_start =3D target_cmsg;
> @@ -5750,9 +5727,10 @@ abi_long do_set_thread_area(CPUX86State *env, abi_=
ulong ptr)
>      }
>      unlock_user_struct(target_ldt_info, ptr, 1);
>=20=20
> -    if (ldt_info.entry_number < TARGET_GDT_ENTRY_TLS_MIN ||=20
> -        ldt_info.entry_number > TARGET_GDT_ENTRY_TLS_MAX)
> -           return -TARGET_EINVAL;
> +    if (ldt_info.entry_number < TARGET_GDT_ENTRY_TLS_MIN ||
> +        ldt_info.entry_number > TARGET_GDT_ENTRY_TLS_MAX) {
> +        return -TARGET_EINVAL;
> +    }
>      seg_32bit =3D ldt_info.flags & 1;
>      contents =3D (ldt_info.flags >> 1) & 3;
>      read_exec_only =3D (ldt_info.flags >> 3) & 1;
> @@ -5828,7 +5806,7 @@ static abi_long do_get_thread_area(CPUX86State *env=
, abi_ulong ptr)
>      lp =3D (uint32_t *)(gdt_table + idx);
>      entry_1 =3D tswap32(lp[0]);
>      entry_2 =3D tswap32(lp[1]);
> -=20=20=20=20
> +
>      read_exec_only =3D ((entry_2 >> 9) & 1) ^ 1;
>      contents =3D (entry_2 >> 10) & 3;
>      seg_not_present =3D ((entry_2 >> 15) & 1) ^ 1;
> @@ -5844,8 +5822,8 @@ static abi_long do_get_thread_area(CPUX86State *env=
, abi_ulong ptr)
>          (read_exec_only << 3) | (limit_in_pages << 4) |
>          (seg_not_present << 5) | (useable << 6) | (lm << 7);
>      limit =3D (entry_1 & 0xffff) | (entry_2  & 0xf0000);
> -    base_addr =3D (entry_1 >> 16) |=20
> -        (entry_2 & 0xff000000) |=20
> +    base_addr =3D (entry_1 >> 16) |
> +        (entry_2 & 0xff000000) |
>          ((entry_2 & 0xff) << 16);
>      target_ldt_info->base_addr =3D tswapal(base_addr);
>      target_ldt_info->limit =3D tswap32(limit);
> @@ -5895,53 +5873,71 @@ abi_long do_arch_prctl(CPUX86State *env, int code=
, abi_ulong addr)
>=20=20
>  #endif /* defined(TARGET_I386) */
>=20=20
> -#define NEW_STACK_SIZE 0x40000
> -
> -
>  static pthread_mutex_t clone_lock =3D PTHREAD_MUTEX_INITIALIZER;
>  typedef struct {
> -    CPUArchState *env;
> +    /* Used to synchronize thread/process creation between parent and ch=
ild. */
>      pthread_mutex_t mutex;
>      pthread_cond_t cond;
> -    pthread_t thread;
> -    uint32_t tid;
> +    /*
> +     * Guest pointers for implementing CLONE_PARENT_SETTID
> +     * and CLONE_CHILD_SETTID.
> +     */
>      abi_ulong child_tidptr;
>      abi_ulong parent_tidptr;
> -    sigset_t sigmask;
> -} new_thread_info;
> +    struct {
> +        sigset_t sigmask;
> +        CPUArchState *env;
> +        bool register_thread;
> +        bool signal_setup;
> +    } child;
> +} clone_info;
>=20=20
> -static void *clone_func(void *arg)
> +static int clone_run(void *arg)
>  {
> -    new_thread_info *info =3D arg;
> +    clone_info *info =3D (clone_info *) arg;
>      CPUArchState *env;
>      CPUState *cpu;
>      TaskState *ts;
> +    uint32_t tid;
>=20=20
> -    rcu_register_thread();
> -    tcg_register_thread();
> -    env =3D info->env;
> +    if (info->child.register_thread) {
> +        rcu_register_thread();
> +        tcg_register_thread();
> +    }
> +
> +    env =3D info->child.env;
>      cpu =3D env_cpu(env);
>      thread_cpu =3D cpu;
>      ts =3D (TaskState *)cpu->opaque;
> -    info->tid =3D sys_gettid();
> +    tid =3D sys_gettid();
>      task_settid(ts);
> -    if (info->child_tidptr)
> -        put_user_u32(info->tid, info->child_tidptr);
> -    if (info->parent_tidptr)
> -        put_user_u32(info->tid, info->parent_tidptr);
> +
>      qemu_guest_random_seed_thread_part2(cpu->random_seed);
> -    /* Enable signals.  */
> -    sigprocmask(SIG_SETMASK, &info->sigmask, NULL);
> -    /* Signal to the parent that we're ready.  */
> -    pthread_mutex_lock(&info->mutex);
> -    pthread_cond_broadcast(&info->cond);
> -    pthread_mutex_unlock(&info->mutex);
> -    /* Wait until the parent has finished initializing the tls state.  */
> -    pthread_mutex_lock(&clone_lock);
> -    pthread_mutex_unlock(&clone_lock);
> +
> +    if (info->parent_tidptr) {
> +        /*
> +         * Even when memory is not shared, parent_tidptr is set before t=
he
> +         * process copy, so we need to set it in the child.
> +         */
> +        put_user_u32(tid, info->parent_tidptr);
> +    }
> +
> +    if (info->child_tidptr) {
> +        put_user_u32(tid, info->child_tidptr);
> +    }
> +
> +    /* Enable signals. */
> +    sigprocmask(SIG_SETMASK, &info->child.sigmask, NULL);
> +
> +    if (info->child.signal_setup) {
> +        pthread_mutex_lock(&info->mutex);
> +        pthread_cond_broadcast(&info->cond);
> +        pthread_mutex_unlock(&info->mutex);
> +    }
> +
>      cpu_loop(env);
>      /* never exits */
> -    return NULL;
> +    _exit(1);  /* avoid compiler warning. */
>  }
>=20=20
>  /* do_fork() Must return host values and target errnos (unlike most
> @@ -5951,139 +5947,131 @@ static int do_fork(CPUArchState *env, unsigned =
int flags, abi_ulong newsp,
>                     abi_ulong child_tidptr)
>  {
>      CPUState *cpu =3D env_cpu(env);
> -    int ret;
> +    int proc_flags, host_sig, ret;
>      TaskState *ts;
>      CPUState *new_cpu;
> -    CPUArchState *new_env;
> -    sigset_t sigmask;
> +    sigset_t block_sigmask;
> +    sigset_t orig_sigmask;
> +    clone_info info;
> +    TaskState *parent_ts =3D (TaskState *)cpu->opaque;
>=20=20
> -    flags &=3D ~CLONE_IGNORED_FLAGS;
> +    memset(&info, 0, sizeof(info));
> +
> +    /*
> +     * When cloning the actual subprocess, we don't need to worry about =
any
> +     * flags that can be ignored, or emulated in QEMU. proc_flags holds =
only
> +     * the flags that need to be passed to `clone` itself.
> +     */
> +    proc_flags =3D flags & ~(CLONE_EMULATED_FLAGS | CLONE_IGNORED_FLAGS);
> +
> +    /*
> +     * The exit signal is included in the flags. That signal needs to be=
 mapped
> +     * to the appropriate host signal, and we need to check if that sign=
al is
> +     * supported.
> +     */
> +    host_sig =3D target_to_host_signal(proc_flags & CSIGNAL);
> +    if (host_sig > SIGRTMAX) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "guest signal %d not supported for exit_signal",
> +                      proc_flags & CSIGNAL);
> +        return -TARGET_EINVAL;
> +    }
> +    proc_flags =3D (proc_flags & ~CSIGNAL) | host_sig;
>=20=20
>      /* Emulate vfork() with fork() */
> -    if (flags & CLONE_VFORK)
> -        flags &=3D ~(CLONE_VFORK | CLONE_VM);
> +    if (proc_flags & CLONE_VFORK) {
> +        proc_flags &=3D ~(CLONE_VFORK | CLONE_VM);
> +    }
>=20=20
> -    if (flags & CLONE_VM) {
> -        TaskState *parent_ts =3D (TaskState *)cpu->opaque;
> -        new_thread_info info;
> -        pthread_attr_t attr;
> +    if (!clone_flags_are_fork(proc_flags) &&
> +        !clone_flags_are_thread(proc_flags)) {
> +        qemu_log_mask(LOG_UNIMP, "unsupported clone flags");
> +        return -TARGET_EINVAL;
> +    }
>=20=20
> -        if (((flags & CLONE_THREAD_FLAGS) !=3D CLONE_THREAD_FLAGS) ||
> -            (flags & CLONE_INVALID_THREAD_FLAGS)) {
> -            return -TARGET_EINVAL;
> -        }
> +    pthread_mutex_init(&info.mutex, NULL);
> +    pthread_mutex_lock(&info.mutex);
> +    pthread_cond_init(&info.cond, NULL);
>=20=20
> -        ts =3D g_new0(TaskState, 1);
> -        init_task_state(ts);
> +    ts =3D g_new0(TaskState, 1);
> +    init_task_state(ts);
>=20=20
> -        /* Grab a mutex so that thread setup appears atomic.  */
> -        pthread_mutex_lock(&clone_lock);
> +    /* Guard CPU copy. It is not thread-safe. */

Why not - isn't that the point of the lock?

<snip>
>      case TARGET_NR_setdomainname:
>          if (!(p =3D lock_user_string(arg1)))
> @@ -10873,8 +10865,10 @@ static abi_long do_syscall1(void *cpu_env, int n=
um, abi_long arg1,
>          return get_errno(fchown(arg1, low2highuid(arg2), low2highgid(arg=
3)));
>  #if defined(TARGET_NR_fchownat)
>      case TARGET_NR_fchownat:
> -        if (!(p =3D lock_user_string(arg2)))=20
> +        p =3D lock_user_string(arg2)
> +        if (!p) {
>              return -TARGET_EFAULT;
> +        }

This has dropped a ; killing the build

--=20
Alex Benn=C3=A9e

