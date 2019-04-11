Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5761C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85AF6206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 09:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AF6206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45134 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEWFg-0006NH-SX
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 05:44:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWEs-0005wv-TB
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWEr-00072j-B0
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:43:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWEr-00072A-0W
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:43:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so6379285wra.12
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=eCR7EzyryttRtTnn9QJiQRPM/evugQlZLrApTsdrhUY=;
	b=ChAqlzBL+Ir+lrPw6LTpn0o9GuWLfLPpv5fW15x/jk/ijSFRnlYLpw+seF2La4nlqJ
	aWMVBt1AKvvXXW9WovRnxOS1rC/G2UP6YjxnUQVz6psKAIRqdO0YEjp/Sc6VG5/2o5uS
	/j+oodpfdHIqhQVnDMB+TJULoQj870p4iPf04WPXKG5Uekzjgnon7eGvKI40dU9D/hMD
	kBxyHXZbh6ECwjaBR2iAwRiV6numn2Vw/m6BmzV85YaBxRDEcvTm1xuiiXa/W8W5CQjF
	VIgeIWWiTYxRr0TP6pqS8PmdZKuVwPuGiH4fzXAEG8JxU3wvnYXoYBCQPizqt3VaU9Jt
	DVlA==
X-Gm-Message-State: APjAAAVc/ssvUPTNZGa70TF/EDt4NRmFKEjmTXMxQ9h/AJVqAYHxaOi8
	A2lpaYg5or1eYnFf0+miJ7ZqcuQ3xWU=
X-Google-Smtp-Source: APXvYqyI+3JlP/kjcr1aLyrVwBL6UaxJilxsqSQ54gtuaV0Q3zVfWGOfsR0yJHkGnrsuTZ2ZNTCvDw==
X-Received: by 2002:adf:dc4a:: with SMTP id m10mr29866364wrj.0.1554975799810; 
	Thu, 11 Apr 2019 02:43:19 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	b10sm63276159wrt.86.2019.04.11.02.43.19
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 02:43:19 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d20cf0a8-73a8-b913-2668-2924e5253834@redhat.com>
Date: Thu, 11 Apr 2019 11:43:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v3 10/23] cpus: Initialize pseudo-random
 seeds for all guest cpus
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411094318.JX7Z26GK187uAvALKsVjhtzf8R7IcL2cObEComEkoQk@z>

On 3/15/19 4:26 AM, Richard Henderson wrote:
> When the -seed option is given, call qemu_guest_random_seed_main,
> putting the subsystem into deterministic mode.  Pass derived seeds
> to each cpu created; which is a no-op unless the subsystem is in
> deterministic mode.
> 
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/qom/cpu.h |  1 +
>  cpus.c            |  9 +++++++++
>  vl.c              |  4 ++++
>  qemu-options.hx   | 10 ++++++++++
>  4 files changed, 24 insertions(+)
> 
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 1d6099e5d4..343cc6d51e 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -372,6 +372,7 @@ struct CPUState {
>      int singlestep_enabled;
>      int64_t icount_budget;
>      int64_t icount_extra;
> +    uint64_t random_seed;
>      sigjmp_buf jmp_env;
>  
>      QemuMutex work_mutex;
> diff --git a/cpus.c b/cpus.c
> index e83f72b48b..6d88f6bfcd 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -49,6 +49,7 @@
>  #include "qemu/option.h"
>  #include "qemu/bitmap.h"
>  #include "qemu/seqlock.h"
> +#include "qemu/guest-random.h"
>  #include "tcg.h"
>  #include "hw/nmi.h"
>  #include "sysemu/replay.h"
> @@ -1275,6 +1276,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
>      /* signal CPU creation */
>      cpu->created = true;
>      qemu_cond_signal(&qemu_cpu_cond);
> +    qemu_guest_random_seed_thread_part2(cpu->random_seed);
>  
>      do {
>          if (cpu_can_run(cpu)) {
> @@ -1318,6 +1320,7 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
>      /* signal CPU creation */
>      cpu->created = true;
>      qemu_cond_signal(&qemu_cpu_cond);
> +    qemu_guest_random_seed_thread_part2(cpu->random_seed);
>  
>      do {
>          qemu_mutex_unlock_iothread();
> @@ -1477,6 +1480,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
>      cpu->created = true;
>      cpu->can_do_io = 1;
>      qemu_cond_signal(&qemu_cpu_cond);
> +    qemu_guest_random_seed_thread_part2(cpu->random_seed);
>  
>      /* wait for initial kick-off after machine start */
>      while (first_cpu->stopped) {
> @@ -1591,6 +1595,7 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
>  
>      hax_init_vcpu(cpu);
>      qemu_cond_signal(&qemu_cpu_cond);
> +    qemu_guest_random_seed_thread_part2(cpu->random_seed);
>  
>      do {
>          if (cpu_can_run(cpu)) {
> @@ -1630,6 +1635,7 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
>      /* signal CPU creation */
>      cpu->created = true;
>      qemu_cond_signal(&qemu_cpu_cond);
> +    qemu_guest_random_seed_thread_part2(cpu->random_seed);
>  
>      do {
>          if (cpu_can_run(cpu)) {
> @@ -1670,6 +1676,7 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
>      /* signal CPU creation */
>      cpu->created = true;
>      qemu_cond_signal(&qemu_cpu_cond);
> +    qemu_guest_random_seed_thread_part2(cpu->random_seed);
>  
>      do {
>          if (cpu_can_run(cpu)) {
> @@ -1723,6 +1730,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
>      cpu->can_do_io = 1;
>      current_cpu = cpu;
>      qemu_cond_signal(&qemu_cpu_cond);
> +    qemu_guest_random_seed_thread_part2(cpu->random_seed);
>  
>      /* process any pending work */
>      cpu->exit_request = 1;
> @@ -2070,6 +2078,7 @@ void qemu_init_vcpu(CPUState *cpu)
>      cpu->nr_cores = smp_cores;
>      cpu->nr_threads = smp_threads;
>      cpu->stopped = true;
> +    cpu->random_seed = qemu_guest_random_seed_thread_part1();
>  
>      if (!cpu->as) {
>          /* If the target cpu hasn't set up any address spaces itself,
> diff --git a/vl.c b/vl.c
> index c1d5484e12..d84f883c2c 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -128,6 +128,7 @@ int main(int argc, char **argv)
>  #include "qapi/qapi-commands-ui.h"
>  #include "qapi/qmp/qerror.h"
>  #include "sysemu/iothread.h"
> +#include "qemu/guest-random.h"
>  
>  #define MAX_VIRTIO_CONSOLES 1
>  
> @@ -3330,6 +3331,9 @@ int main(int argc, char **argv, char **envp)
>              case QEMU_OPTION_DFILTER:
>                  qemu_set_dfilter_ranges(optarg, &error_fatal);
>                  break;
> +            case QEMU_OPTION_seed:
> +                qemu_guest_random_seed_main(optarg, &error_fatal);
> +                break;
>              case QEMU_OPTION_s:
>                  add_device_config(DEV_GDB, "tcp::" DEFAULT_GDBSTUB_PORT);
>                  break;
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 08749a3391..b8da998668 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3601,6 +3601,16 @@ the 0x200 sized block starting at 0xffffffc000080000 and another 0x1000 sized
>  block starting at 0xffffffc00005f000.
>  ETEXI
>  
> +DEF("seed", HAS_ARG, QEMU_OPTION_seed, \
> +    "-seed number       seed the pseudo-random number generator\n",
> +    QEMU_ARCH_ALL)
> +STEXI
> +@item -seed @var{number}
> +@findex -seed
> +Force the guest to use a deterministic pseudo-random number generator, seeded
> +with @var{number}.  This does not affect crypto routines within the host.
> +ETEXI

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +
>  DEF("L", HAS_ARG, QEMU_OPTION_L, \
>      "-L path         set the directory for the BIOS, VGA BIOS and keymaps\n",
>      QEMU_ARCH_ALL)
> 

