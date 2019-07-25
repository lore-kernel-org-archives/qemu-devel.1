Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0129FC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 13:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B97F42190F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 13:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97F42190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqdtC-0006Sd-V5
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 09:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50583)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hqdt0-00064H-8i
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 09:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hqdsy-0000G6-L0
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 09:34:22 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:58077)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hqdsy-0000FA-Bz
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 09:34:20 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M3VAI-1hrBqY2Gig-000cYw; Thu, 25 Jul 2019 15:34:04 +0200
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190725131645.19501-1-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3c560428-5350-c366-a542-04752709620e@vivier.eu>
Date: Thu, 25 Jul 2019 15:34:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725131645.19501-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:o2O+gR/SebKIJxJlhLy+LGq74xJsuLjXBR95EHC+ksl25+14KKd
 elq7nSHyRq0AUToK8rV9EmRkT1CNRKo2oJ9JCl9FCyUlls2Z76+Cch1h91t6ssPGfi7rOPC
 u+FIxBFhWWFTv1Npe0ainuHgGSpwjom2lqwFdHNVDgB0vFaM/TqdaTyAQgGgPbHzw9obqrD
 HwqePUcDJGY+c+MM/jZ+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fQb+WuAbFdA=:hTKPGGopH8bMRCqtyxIgf3
 qCQJfCbDlKdjOBNY4/f0Km8voEkvpEr0beeLLwOB8A9h4x6Zk6wgADuHXs6yubQ2+OBr4Os+W
 XphQJ24Lm0Hz6OTT1I6iQEomfoxY2udnSv7u99SWrTxP+0n0FhpLnpoDHgCW5/eI39Y9M8nCJ
 PhS1rG3DObEDkmunHtg42LlbnDYuGolo8Pd7CYy7qOfR6VNfo4DomL9bdgBOtSBjLDpN6FRan
 Ty1e7GXeactQTHoaWAtHIwtBj/vdTFlWLuXj8YBvuHKbZMIG97w5bGbbrr6oEC46KvNLZcOOH
 LbOr1kWgsTXGUmqONcCjNugMI2gWWD736tno+HcQmhnfYc8IzsiiTL5WmjqubLbESSTmQ3alO
 0X1Bilxxefoqvd5dW0RFpf6xcbhEJsa/02Bpz39plGxbu6uPhVTbklUhZZLsg0y1ZzFQi5noy
 KBGIXulpjP1RgTYVWJeCHwbmIwbi1nzSXc1lrM5sRvc+M/BQj6ODwD20IVDbN2Y01ts8aF+D4
 m3S08ousdLXDzuog29rcCj1v8pN3ubLD41CBN9wC1DF87fPILoF2yHuuDD0nfQwuf8CUSjlas
 7fRk0ujFNpHlgn2nJ/bhZ/1Mm9gvxGIYBK56n/wmHsiTsJH4LZnZOkHeaq/xh4m4zd6LMZWgU
 YsDWSyxwBS3ZF/XP3LGeHSAuMCb+8hJ/su9InAkUSD+Zu8YIiwJYz/NnWyMOdagRByBG0tnzO
 0T+p/phVLiVPD2VMZ8qKDxNdIsUTjfCcMiZL6y1Anuqex2qNJ2jxo6QGC7I=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: Re: [Qemu-devel] [PATCH for-4.1] linux-user: Make sigaltstack
 stacks per-thread
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
Cc: Riku Voipio <riku.voipio@iki.fi>, patches@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/07/2019 à 15:16, Peter Maydell a écrit :
> The alternate signal stack set up by the sigaltstack syscall is
> supposed to be per-thread.  We were incorrectly implementing it as
> process-wide.  This causes problems for guest binaries that rely on
> this.  Notably the Go runtime does, and so we were seeing crashes
> caused by races where two guest threads might incorrectly both
> execute on the same stack simultaneously.
> 
> Replace the global target_sigaltstack_used with a field
> sigaltstack_used in the TaskState, and make all the references to the
> old global instead get a pointer to the TaskState and use the field.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1696773
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I've marked this as "for-4.1" but it is quite late in the release
> cycle and I think this could use more testing than I have given it...

It looks good. I'm going to test it with LTP on all the targets I have.
I will test the go program too.

Thanks,
Laurent

> 
> Thanks are due to:
>  * the original bug reporter, for providing a nice simple test case
>  * rr, for allowing me to capture and forensically examine a single
>    example of the failure
>  * the Go project for having a good clear HACKING.md that explained
>    their stack usage and mentioned specifically that signal stacks
>    are per-thread (per-M, in their terms)
>  * a colleague, for prodding me into actually spending the necessary
>    two days grovelling through gdb sessions and logs to figure out
>    what was actually going wrong
> ---
>  linux-user/qemu.h          |  2 ++
>  linux-user/signal-common.h |  1 -
>  linux-user/hppa/signal.c   |  3 ++-
>  linux-user/main.c          |  5 +++++
>  linux-user/signal.c        | 35 +++++++++++++++++++----------------
>  5 files changed, 28 insertions(+), 18 deletions(-)
> 
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 4258e4162d2..aac03346270 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -151,6 +151,8 @@ typedef struct TaskState {
>       */
>      int signal_pending;
>  
> +    /* This thread's sigaltstack, if it has one */
> +    struct target_sigaltstack sigaltstack_used;
>  } __attribute__((aligned(16))) TaskState;
>  
>  extern char *exec_path;
> diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h
> index 51030a93069..1df1068552f 100644
> --- a/linux-user/signal-common.h
> +++ b/linux-user/signal-common.h
> @@ -19,7 +19,6 @@
>  
>  #ifndef SIGNAL_COMMON_H
>  #define SIGNAL_COMMON_H
> -extern struct target_sigaltstack target_sigaltstack_used;
>  
>  int on_sig_stack(unsigned long sp);
>  int sas_ss_flags(unsigned long sp);
> diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
> index b6927ee6735..d1a58feeb36 100644
> --- a/linux-user/hppa/signal.c
> +++ b/linux-user/hppa/signal.c
> @@ -111,10 +111,11 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>      abi_ulong frame_addr, sp, haddr;
>      struct target_rt_sigframe *frame;
>      int i;
> +    TaskState *ts = (TaskState *)thread_cpu->opaque;
>  
>      sp = get_sp_from_cpustate(env);
>      if ((ka->sa_flags & TARGET_SA_ONSTACK) && !sas_ss_flags(sp)) {
> -        sp = (target_sigaltstack_used.ss_sp + 0x7f) & ~0x3f;
> +        sp = (ts->sigaltstack_used.ss_sp + 0x7f) & ~0x3f;
>      }
>      frame_addr = QEMU_ALIGN_UP(sp, 64);
>      sp = frame_addr + PARISC_RT_SIGFRAME_SIZE32;
> diff --git a/linux-user/main.c b/linux-user/main.c
> index a59ae9439de..8ffc5251955 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -180,6 +180,11 @@ void stop_all_tasks(void)
>  void init_task_state(TaskState *ts)
>  {
>      ts->used = 1;
> +    ts->sigaltstack_used = (struct target_sigaltstack) {
> +        .ss_sp = 0,
> +        .ss_size = 0,
> +        .ss_flags = TARGET_SS_DISABLE,
> +    };
>  }
>  
>  CPUArchState *cpu_copy(CPUArchState *env)
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 5cd237834d9..5ca6d62b15d 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -25,12 +25,6 @@
>  #include "trace.h"
>  #include "signal-common.h"
>  
> -struct target_sigaltstack target_sigaltstack_used = {
> -    .ss_sp = 0,
> -    .ss_size = 0,
> -    .ss_flags = TARGET_SS_DISABLE,
> -};
> -
>  static struct target_sigaction sigact_table[TARGET_NSIG];
>  
>  static void host_signal_handler(int host_signum, siginfo_t *info,
> @@ -251,13 +245,17 @@ void set_sigmask(const sigset_t *set)
>  
>  int on_sig_stack(unsigned long sp)
>  {
> -    return (sp - target_sigaltstack_used.ss_sp
> -            < target_sigaltstack_used.ss_size);
> +    TaskState *ts = (TaskState *)thread_cpu->opaque;
> +
> +    return (sp - ts->sigaltstack_used.ss_sp
> +            < ts->sigaltstack_used.ss_size);
>  }
>  
>  int sas_ss_flags(unsigned long sp)
>  {
> -    return (target_sigaltstack_used.ss_size == 0 ? SS_DISABLE
> +    TaskState *ts = (TaskState *)thread_cpu->opaque;
> +
> +    return (ts->sigaltstack_used.ss_size == 0 ? SS_DISABLE
>              : on_sig_stack(sp) ? SS_ONSTACK : 0);
>  }
>  
> @@ -266,17 +264,21 @@ abi_ulong target_sigsp(abi_ulong sp, struct target_sigaction *ka)
>      /*
>       * This is the X/Open sanctioned signal stack switching.
>       */
> +    TaskState *ts = (TaskState *)thread_cpu->opaque;
> +
>      if ((ka->sa_flags & TARGET_SA_ONSTACK) && !sas_ss_flags(sp)) {
> -        return target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
> +        return ts->sigaltstack_used.ss_sp + ts->sigaltstack_used.ss_size;
>      }
>      return sp;
>  }
>  
>  void target_save_altstack(target_stack_t *uss, CPUArchState *env)
>  {
> -    __put_user(target_sigaltstack_used.ss_sp, &uss->ss_sp);
> +    TaskState *ts = (TaskState *)thread_cpu->opaque;
> +
> +    __put_user(ts->sigaltstack_used.ss_sp, &uss->ss_sp);
>      __put_user(sas_ss_flags(get_sp_from_cpustate(env)), &uss->ss_flags);
> -    __put_user(target_sigaltstack_used.ss_size, &uss->ss_size);
> +    __put_user(ts->sigaltstack_used.ss_size, &uss->ss_size);
>  }
>  
>  /* siginfo conversion */
> @@ -708,12 +710,13 @@ abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr, abi_ulong sp)
>  {
>      int ret;
>      struct target_sigaltstack oss;
> +    TaskState *ts = (TaskState *)thread_cpu->opaque;
>  
>      /* XXX: test errors */
>      if(uoss_addr)
>      {
> -        __put_user(target_sigaltstack_used.ss_sp, &oss.ss_sp);
> -        __put_user(target_sigaltstack_used.ss_size, &oss.ss_size);
> +        __put_user(ts->sigaltstack_used.ss_sp, &oss.ss_sp);
> +        __put_user(ts->sigaltstack_used.ss_size, &oss.ss_size);
>          __put_user(sas_ss_flags(sp), &oss.ss_flags);
>      }
>  
> @@ -760,8 +763,8 @@ abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr, abi_ulong sp)
>              }
>          }
>  
> -        target_sigaltstack_used.ss_sp = ss.ss_sp;
> -        target_sigaltstack_used.ss_size = ss.ss_size;
> +        ts->sigaltstack_used.ss_sp = ss.ss_sp;
> +        ts->sigaltstack_used.ss_size = ss.ss_size;
>      }
>  
>      if (uoss_addr) {
> 


