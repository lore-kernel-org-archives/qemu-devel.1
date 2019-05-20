Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB29C04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 06:05:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C1FD20851
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 06:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHzBCN6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1FD20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58439 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSbQ6-0001mU-EE
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 02:05:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hSbPC-0001V1-Ch
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hSbP9-0005fC-TZ
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:04:14 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hSbP9-0005dQ-J0
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:04:11 -0400
Received: by mail-oi1-x242.google.com with SMTP id y10so9089047oia.8
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 23:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=UqPswRAyKQ5AkV4oqsOuTlUr1ujfkF/aKROS2Oef6ac=;
	b=PHzBCN6aBaocxOk/FfxYRhfZgLt5E5Gg30+XlQltAgZU7/E0XpnZqK0HpyMOmoLK2c
	0gSvlgqt9dogrQ00jP3JUS8IQwcIrWn/IP6cToa3ZlKB5v61d89x3+9ypwkNmMqlewt5
	wE1WW/e9UyB9yx8GkUoDdO0c3VSnDTcTQQyw5m7uiFcJZVj9ecAWtYzWgx0fFnU7PJ2f
	QZxmP82qEOCDPvOEqW1x0nT6w5t/zUazibLPXY8aCO/WdrWdbQZe3KA4JV1/jsSyhLlC
	kmZPROWsDV6z0saNUIL4IlLRFZhdYf5LgNMq8Xjsm66Oscd0KDJdQPAKocKgIwvuixQq
	sqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=UqPswRAyKQ5AkV4oqsOuTlUr1ujfkF/aKROS2Oef6ac=;
	b=J6uju/vscxueW4LMZ61IfEx5FV29cRSfGVrq+GngZTLXX0jmoAR+ff21C/ydHjZPXf
	ngxJpKl8LtHAKcToxL/jGIVZtSUPys9FRQFKJLTZydJRrwnZA4J8jzUh1dnVWy1N7dcb
	/YkEKt6Q0RW3+UtiBPtaBkfCno5vr+TMTbq7lEnof8vkXXu4nEWXS6ihWI10B2gjQHep
	hUVpHnhZJYlVcHPKckqcYyxHpaxjitNHhn/sBslFrLW34ELzE9nNyPDxzKp8VlVOO3Uc
	sCtQzLCs/o3x+c6mi/wRciuxUGvax2wDGiL10qVx0e0JgNnNL4vy6giuXK7b858L8y/V
	NCLg==
X-Gm-Message-State: APjAAAX4OuKbVArzU1EPGMiUNwQ1XaqvhcOx5r7KX8WBsafhVBmOxjd3
	P4r00bLWXzgTav35UwyTTOz6DAcKsWxjBSUo4II=
X-Google-Smtp-Source: APXvYqyat1jy18jp9b7QyOtir4Plf8Hs1cZzSGrE3ECWYYzb8ZQ1ycveQUGgsBzLOKRlg6/cBja9WpjE3i1Nm/Zav/g=
X-Received: by 2002:aca:5d06:: with SMTP id r6mr21775038oib.62.1558332249445; 
	Sun, 19 May 2019 23:04:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Sun, 19 May 2019 23:04:08
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Sun, 19 May 2019 23:04:08
	-0700 (PDT)
In-Reply-To: <20190519203726.20729-63-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
	<20190519203726.20729-63-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 20 May 2019 08:04:08 +0200
Message-ID: <CAL1e-=jHwYPGqqS3GLthO+1xYCc9mX_zgxXu+2gRsCOb0rnN_A@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v7 62/74] linux-user: Split out
 rt_sigqueueinfo, rt_tgsigqueueinfo
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
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 19, 2019 11:25 PM, "Richard Henderson" <richard.henderson@linaro.org=
>
wrote:
>
> This does drop the (questionable) siginfo_t printing.
> But since we already do not handle more important things
> in this area like sigset_t, this does not feel a loss.
>

What is the most questionable here is the reasoning =E2=80=9Cwe don't handl=
e one
thing, therefore let's drop another=E2=80=9D.

If you find siginfo_t printing questionable, then provide a better one, not
remove it altogether.

I find that the current printing is useful in many circumstances, there is
a lot of energy of former contributors invested into it, and should not be
deleted just like that. It does feel like a loss.

Aleksandar

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall-defs.h    |   2 +
>  linux-user/strace.c          | 138 -----------------------------------
>  linux-user/syscall-sig.inc.c |  30 ++++++++
>  linux-user/syscall.c         |  26 -------
>  linux-user/strace.list       |   6 --
>  5 files changed, 32 insertions(+), 170 deletions(-)
>
> diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
> index 24289ed413..11851535e1 100644
> --- a/linux-user/syscall-defs.h
> +++ b/linux-user/syscall-defs.h
> @@ -196,8 +196,10 @@ SYSCALL_DEF(rt_sigaction, ARG_SIGNAL, ARG_PTR,
ARG_PTR, ARG_DEC);
>  #endif
>  SYSCALL_DEF(rt_sigpending, ARG_PTR, ARG_DEC);
>  SYSCALL_DEF(rt_sigprocmask, ARG_SIGPROCMASKHOW, ARG_PTR, ARG_PTR,
ARG_DEC);
> +SYSCALL_DEF(rt_sigqueueinfo, ARG_DEC, ARG_SIGNAL, ARG_PTR);
>  SYSCALL_DEF(rt_sigsuspend, ARG_PTR, ARG_DEC);
>  SYSCALL_DEF(rt_sigtimedwait, ARG_PTR, ARG_PTR, ARG_PTR, ARG_DEC);
> +SYSCALL_DEF(rt_tgsigqueueinfo, ARG_DEC, ARG_DEC, ARG_SIGNAL, ARG_PTR);
>  #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_semctl)
>  SYSCALL_DEF(semctl, ARG_DEC, ARG_DEC, ARG_DEC, ARG_HEX);
>  #endif
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 886663af2e..2e70a3910c 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -167,93 +167,6 @@ static void print_si_code(int arg)
>      gemu_log("%s", codename);
>  }
>
> -static void get_target_siginfo(target_siginfo_t *tinfo,
> -                                const target_siginfo_t *info)
> -{
> -    abi_ulong sival_ptr;
> -
> -    int sig;
> -    int si_errno;
> -    int si_code;
> -    int si_type;
> -
> -    __get_user(sig, &info->si_signo);
> -    __get_user(si_errno, &tinfo->si_errno);
> -    __get_user(si_code, &info->si_code);
> -
> -    tinfo->si_signo =3D sig;
> -    tinfo->si_errno =3D si_errno;
> -    tinfo->si_code =3D si_code;
> -
> -    /* Ensure we don't leak random junk to the guest later */
> -    memset(tinfo->_sifields._pad, 0, sizeof(tinfo->_sifields._pad));
> -
> -    /* This is awkward, because we have to use a combination of
> -     * the si_code and si_signo to figure out which of the union's
> -     * members are valid. (Within the host kernel it is always possible
> -     * to tell, but the kernel carefully avoids giving userspace the
> -     * high 16 bits of si_code, so we don't have the information to
> -     * do this the easy way...) We therefore make our best guess,
> -     * bearing in mind that a guest can spoof most of the si_codes
> -     * via rt_sigqueueinfo() if it likes.
> -     *
> -     * Once we have made our guess, we record it in the top 16 bits of
> -     * the si_code, so that print_siginfo() later can use it.
> -     * print_siginfo() will strip these top bits out before printing
> -     * the si_code.
> -     */
> -
> -    switch (si_code) {
> -    case SI_USER:
> -    case SI_TKILL:
> -    case SI_KERNEL:
> -        /* Sent via kill(), tkill() or tgkill(), or direct from the
kernel.
> -         * These are the only unspoofable si_code values.
> -         */
> -        __get_user(tinfo->_sifields._kill._pid,
&info->_sifields._kill._pid);
> -        __get_user(tinfo->_sifields._kill._uid,
&info->_sifields._kill._uid);
> -        si_type =3D QEMU_SI_KILL;
> -        break;
> -    default:
> -        /* Everything else is spoofable. Make best guess based on signal
*/
> -        switch (sig) {
> -        case TARGET_SIGCHLD:
> -            __get_user(tinfo->_sifields._sigchld._pid,
> -                       &info->_sifields._sigchld._pid);
> -            __get_user(tinfo->_sifields._sigchld._uid,
> -                       &info->_sifields._sigchld._uid);
> -            __get_user(tinfo->_sifields._sigchld._status,
> -                       &info->_sifields._sigchld._status);
> -            __get_user(tinfo->_sifields._sigchld._utime,
> -                       &info->_sifields._sigchld._utime);
> -            __get_user(tinfo->_sifields._sigchld._stime,
> -                       &info->_sifields._sigchld._stime);
> -            si_type =3D QEMU_SI_CHLD;
> -            break;
> -        case TARGET_SIGIO:
> -            __get_user(tinfo->_sifields._sigpoll._band,
> -                       &info->_sifields._sigpoll._band);
> -            __get_user(tinfo->_sifields._sigpoll._fd,
> -                       &info->_sifields._sigpoll._fd);
> -            si_type =3D QEMU_SI_POLL;
> -            break;
> -        default:
> -            /* Assume a sigqueue()/mq_notify()/rt_sigqueueinfo() source.
*/
> -            __get_user(tinfo->_sifields._rt._pid,
&info->_sifields._rt._pid);
> -            __get_user(tinfo->_sifields._rt._uid,
&info->_sifields._rt._uid);
> -            /* XXX: potential problem if 64 bit */
> -            __get_user(sival_ptr,
&info->_sifields._rt._sigval.sival_ptr);
> -            tinfo->_sifields._rt._sigval.sival_ptr =3D sival_ptr;
> -
> -            si_type =3D QEMU_SI_RT;
> -            break;
> -        }
> -        break;
> -    }
> -
> -    tinfo->si_code =3D deposit32(si_code, 16, 16, si_type);
> -}
> -
>  static void print_siginfo(const target_siginfo_t *tinfo)
>  {
>      /* Print a target_siginfo_t in the format desired for printing
> @@ -1585,57 +1498,6 @@ print_fstat(const struct syscallname *name,
>  #define print_fstat64     print_fstat
>  #endif
>
> -#ifdef TARGET_NR_rt_sigqueueinfo
> -static void
> -print_rt_sigqueueinfo(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> -{
> -    void *p;
> -    target_siginfo_t uinfo;
> -
> -    print_syscall_prologue(name);
> -    print_raw_param("%d", arg0, 0);
> -    print_signal(arg1, 0);
> -    p =3D lock_user(VERIFY_READ, arg2, sizeof(target_siginfo_t), 1);
> -    if (p) {
> -        get_target_siginfo(&uinfo, p);
> -        print_siginfo(&uinfo);
> -
> -        unlock_user(p, arg2, 0);
> -    } else {
> -        print_pointer(arg2, 1);
> -    }
> -    print_syscall_epilogue(name);
> -}
> -#endif
> -
> -#ifdef TARGET_NR_rt_tgsigqueueinfo
> -static void
> -print_rt_tgsigqueueinfo(const struct syscallname *name,
> -    abi_long arg0, abi_long arg1, abi_long arg2,
> -    abi_long arg3, abi_long arg4, abi_long arg5)
> -{
> -    void *p;
> -    target_siginfo_t uinfo;
> -
> -    print_syscall_prologue(name);
> -    print_raw_param("%d", arg0, 0);
> -    print_raw_param("%d", arg1, 0);
> -    print_signal(arg2, 0);
> -    p =3D lock_user(VERIFY_READ, arg3, sizeof(target_siginfo_t), 1);
> -    if (p) {
> -        get_target_siginfo(&uinfo, p);
> -        print_siginfo(&uinfo);
> -
> -        unlock_user(p, arg3, 0);
> -    } else {
> -        print_pointer(arg3, 1);
> -    }
> -    print_syscall_epilogue(name);
> -}
> -#endif
> -
>  #ifdef TARGET_NR_syslog
>  static void
>  print_syslog_action(abi_ulong arg, int last)
> diff --git a/linux-user/syscall-sig.inc.c b/linux-user/syscall-sig.inc.c
> index 5f2c0ba499..774346838b 100644
> --- a/linux-user/syscall-sig.inc.c
> +++ b/linux-user/syscall-sig.inc.c
> @@ -191,6 +191,21 @@ SYSCALL_IMPL(rt_sigprocmask)
>      return ret;
>  }
>
> +SYSCALL_IMPL(rt_sigqueueinfo)
> +{
> +    siginfo_t uinfo;
> +    void *p;
> +
> +    p =3D lock_user(VERIFY_READ, arg3, sizeof(target_siginfo_t), 1);
> +    if (!p) {
> +        return -TARGET_EFAULT;
> +    }
> +    target_to_host_siginfo(&uinfo, p);
> +    unlock_user(p, arg3, 0);
> +
> +    return get_errno(sys_rt_sigqueueinfo(arg1, arg2, &uinfo));
> +}
> +
>  SYSCALL_IMPL(rt_sigsuspend)
>  {
>      CPUState *cpu =3D ENV_GET_CPU(cpu_env);
> @@ -252,6 +267,21 @@ SYSCALL_IMPL(rt_sigtimedwait)
>      return ret;
>  }
>
> +SYSCALL_IMPL(rt_tgsigqueueinfo)
> +{
> +    siginfo_t uinfo;
> +    void *p;
> +
> +    p =3D lock_user(VERIFY_READ, arg4, sizeof(target_siginfo_t), 1);
> +    if (!p) {
> +        return -TARGET_EFAULT;
> +    }
> +    target_to_host_siginfo(&uinfo, p);
> +    unlock_user(p, arg4, 0);
> +
> +    return get_errno(sys_rt_tgsigqueueinfo(arg1, arg2, arg3, &uinfo));
> +}
> +
>  #ifdef TARGET_NR_sigaction
>  SYSCALL_IMPL(sigaction)
>  {
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8a05d3e32a..e489d12103 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -4240,32 +4240,6 @@ static abi_long do_syscall1(void *cpu_env, int
num, abi_long arg1,
>      void *p;
>
>      switch(num) {
> -    case TARGET_NR_rt_sigqueueinfo:
> -        {
> -            siginfo_t uinfo;
> -
> -            p =3D lock_user(VERIFY_READ, arg3, sizeof(target_siginfo_t),
1);
> -            if (!p) {
> -                return -TARGET_EFAULT;
> -            }
> -            target_to_host_siginfo(&uinfo, p);
> -            unlock_user(p, arg3, 0);
> -            ret =3D get_errno(sys_rt_sigqueueinfo(arg1, arg2, &uinfo));
> -        }
> -        return ret;
> -    case TARGET_NR_rt_tgsigqueueinfo:
> -        {
> -            siginfo_t uinfo;
> -
> -            p =3D lock_user(VERIFY_READ, arg4, sizeof(target_siginfo_t),
1);
> -            if (!p) {
> -                return -TARGET_EFAULT;
> -            }
> -            target_to_host_siginfo(&uinfo, p);
> -            unlock_user(p, arg4, 0);
> -            ret =3D get_errno(sys_rt_tgsigqueueinfo(arg1, arg2, arg3,
&uinfo));
> -        }
> -        return ret;
>  #ifdef TARGET_NR_sigreturn
>      case TARGET_NR_sigreturn:
>          if (block_signals()) {
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index 0b2c057673..57445a8d81 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -926,15 +926,9 @@
>  #ifdef TARGET_NR_rmdir
>  { TARGET_NR_rmdir, "rmdir" , NULL, NULL, NULL },
>  #endif
> -#ifdef TARGET_NR_rt_sigqueueinfo
> -{ TARGET_NR_rt_sigqueueinfo, "rt_sigqueueinfo" , NULL,
print_rt_sigqueueinfo, NULL },
> -#endif
>  #ifdef TARGET_NR_rt_sigreturn
>  { TARGET_NR_rt_sigreturn, "rt_sigreturn" , NULL, NULL, NULL },
>  #endif
> -#ifdef TARGET_NR_rt_tgsigqueueinfo
> -{ TARGET_NR_rt_tgsigqueueinfo, "rt_tgsigqueueinfo" , NULL,
print_rt_tgsigqueueinfo, NULL },
> -#endif
>  #ifdef TARGET_NR_sched_getaffinity
>  { TARGET_NR_sched_getaffinity, "sched_getaffinity" , NULL, NULL, NULL },
>  #endif
> --
> 2.17.1
>
>
