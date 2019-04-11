Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB52C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:45:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F192084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F192084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45169 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEWGj-00071p-65
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 05:45:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWFr-0006Ym-Ch
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWFq-0007X5-7y
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:44:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWFp-0007Wa-TZ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:44:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so6460194wrd.3
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=nT3S90bFMofkvpEyzagvw3j4NU//plEY9z6Z08aQS7g=;
	b=DdnjDZZFcK6MTEZkJQsSsyKUS+NdLKDXqHYlz4LUeOEfRgpIrvO6GnkjuLRNzcPFBL
	zeS1uAKIpQyo0VmJI1bZiXWNGKlp7P+BdbkZtNTUMtzGLkBxzGcBz98+sZJXDU7bC9Uw
	3JtOmKvEiDBz0LL1ohtsCMSnNvm2Vt55Q1QSkdM6uJMEgrYsDJB4C/8nwpGdZlWwyvMq
	jY8P2uzNM70C0rcD7bYsg0G3DCEbeZqEonjRTiLz/+p663uffvWuUbYjOSQZ4CNNhJuy
	dMTHnpuZ753gW38E1AdI1+E2ROMYlNJ09cpukoiO+U7hlmIoVmEzylc5GtiNG559fKOf
	3ZNA==
X-Gm-Message-State: APjAAAVfXvohCfZ+y3Z1o6w2H6vkQpsYlbAha4nnhlWy4h4EAmG+EIeH
	fYDHFKFvs9WEjIXcCpkeG3MSj8a5XaA=
X-Google-Smtp-Source: APXvYqwpNQn3RISR4qPyATuKGpzTbSf8j5cztd9/z39bYnA+jC42P3FWdgQ0y8llKJ9drE3lwDEEoQ==
X-Received: by 2002:adf:eb0b:: with SMTP id s11mr5240559wrn.140.1554975860817; 
	Thu, 11 Apr 2019 02:44:20 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	x192sm5086822wmf.48.2019.04.11.02.44.19
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 02:44:20 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8a2271e4-46fc-c0a2-5d12-49879450dc91@redhat.com>
Date: Thu, 11 Apr 2019 11:44:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v3 11/23] linux-user: Initialize
 pseudo-random seeds for all guest cpus
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411094419.4BAzDkwxIguRTKQat0hGENSFwDhekKd7xBJ8j4eTfyc@z>

On 3/15/19 4:26 AM, Richard Henderson wrote:
> When the -seed option is given, call qemu_guest_random_seed_main,
> putting the subsystem into deterministic mode.  Pass derived seeds
> to each cpu created during clone; which is a no-op unless the
> subsystem is in deterministic mode.
> 
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/main.c    | 21 ++++++++++-----------
>  linux-user/syscall.c |  3 +++
>  2 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index a0aba9cb1e..cf7095bdaf 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -33,6 +33,7 @@
>  #include "tcg.h"
>  #include "qemu/timer.h"
>  #include "qemu/envlist.h"
> +#include "qemu/guest-random.h"
>  #include "elf.h"
>  #include "trace/control.h"
>  #include "target_elf.h"
> @@ -47,6 +48,7 @@ static int gdbstub_port;
>  static envlist_t *envlist;
>  static const char *cpu_model;
>  static const char *cpu_type;
> +static const char *seed_optarg;
>  unsigned long mmap_min_addr;
>  unsigned long guest_base;
>  int have_guest_base;
> @@ -289,15 +291,9 @@ static void handle_arg_pagesize(const char *arg)
>      }
>  }
>  
> -static void handle_arg_randseed(const char *arg)
> +static void handle_arg_seed(const char *arg)
>  {
> -    unsigned long long seed;
> -
> -    if (parse_uint_full(arg, &seed, 0) != 0 || seed > UINT_MAX) {
> -        fprintf(stderr, "Invalid seed number: %s\n", arg);
> -        exit(EXIT_FAILURE);
> -    }
> -    srand(seed);
> +    seed_optarg = arg;
>  }
>  
>  static void handle_arg_gdb(const char *arg)
> @@ -432,7 +428,7 @@ static const struct qemu_argument arg_table[] = {
>       "",           "run in singlestep mode"},
>      {"strace",     "QEMU_STRACE",      false, handle_arg_strace,
>       "",           "log system calls"},
> -    {"seed",       "QEMU_RAND_SEED",   true,  handle_arg_randseed,
> +    {"seed",       "QEMU_RAND_SEED",   true,  handle_arg_seed,
>       "",           "Seed for pseudo-random number generator"},
>      {"trace",      "QEMU_TRACE",       true,  handle_arg_trace,
>       "",           "[[enable=]<pattern>][,events=<file>][,file=<file>]"},
> @@ -687,8 +683,11 @@ int main(int argc, char **argv, char **envp)
>          do_strace = 1;
>      }
>  
> -    if (getenv("QEMU_RAND_SEED")) {
> -        handle_arg_randseed(getenv("QEMU_RAND_SEED"));
> +    if (seed_optarg == NULL) {
> +        seed_optarg = getenv("QEMU_RAND_SEED");
> +    }
> +    if (seed_optarg != NULL) {
> +        qemu_guest_random_seed_main(seed_optarg, &error_fatal);
>      }
>  
>      target_environ = envlist_to_environ(envlist, NULL);
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 208fd1813d..8f7125cd67 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -110,6 +110,7 @@
>  #include "uname.h"
>  
>  #include "qemu.h"
> +#include "qemu/guest-random.h"
>  #include "fd-trans.h"
>  
>  #ifndef CLONE_IO
> @@ -5448,6 +5449,7 @@ static void *clone_func(void *arg)
>          put_user_u32(info->tid, info->child_tidptr);
>      if (info->parent_tidptr)
>          put_user_u32(info->tid, info->parent_tidptr);
> +    qemu_guest_random_seed_thread_part2(cpu->random_seed);
>      /* Enable signals.  */
>      sigprocmask(SIG_SETMASK, &info->sigmask, NULL);
>      /* Signal to the parent that we're ready.  */
> @@ -5534,6 +5536,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
>             initializing, so temporarily block all signals.  */
>          sigfillset(&sigmask);
>          sigprocmask(SIG_BLOCK, &sigmask, &info.sigmask);
> +        cpu->random_seed = qemu_guest_random_seed_thread_part1();
>  
>          /* If this is our first additional thread, we need to ensure we
>           * generate code for parallel execution and flush old translations.
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

