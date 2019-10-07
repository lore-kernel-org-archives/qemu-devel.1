Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B45AC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 10:28:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E7A2084D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 10:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E7A2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHQFn-0000xE-Hf
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 06:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHQEr-0000Mm-Qa
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHQEp-0007Y5-3Q
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:27:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34736)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHQEo-0007Xi-Rh
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:27:35 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0941F2D1EF1
 for <qemu-devel@nongnu.org>; Mon,  7 Oct 2019 10:27:33 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id o188so5992530wmo.5
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 03:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i6JpkMARqyYXynCJK6HZNtcf3dcaBVwqJylq3o+GYoI=;
 b=nlYJEGR9JwbeK4iTUgsTrWJdKZaVL29PQVOGcunHMa2p/oRdwjBUAmGzEiW91WzSZP
 a9mNJV5Q6zDkp2jMtyAbhXIRoD+TT3fUPpJj6dVJtAqqvQor6ddkGmpB4Q5IwwOnwVlE
 hKNhIfs9ZoLFP7zx9ZABDDzmRtXP0PKt0W98sdW9XgEgwPXZdXqAW7tEVmkRKdSA1cmA
 Zxi4IMqXs9fqcKXPSsqBJPtxLINaGAqEBhYxlOffRjrPAMgWBKjTaVevoey0oGpLpTzs
 KC2jeWobJJB61x8LO+7Q7b5YJ4SBk3doKDsPBsa9I5BP0Xsus1fuMzkdJas565Zcupsd
 yj8A==
X-Gm-Message-State: APjAAAW5QsNfBaF05RVBCVOZ/sMHJBPs05um+UJTxxEH1z4LBsw+9dhj
 kJv+yeOZdQZ0wYFleBrWBCTkLSGXE+YNC79hfFABxLBjtMSw0LJYBdOQGdUlyJgN55zz94RIi18
 fSVQVnDrs3sv0mNs=
X-Received: by 2002:adf:ec09:: with SMTP id x9mr23003603wrn.308.1570444050875; 
 Mon, 07 Oct 2019 03:27:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxZmq6vNUKIDVfCqnIhatgpzUQhHugMhlVcVsSo+3xPWjIzw82+51PqOwF3/BYjEGDOkILAYg==
X-Received: by 2002:adf:ec09:: with SMTP id x9mr23003567wrn.308.1570444050459; 
 Mon, 07 Oct 2019 03:27:30 -0700 (PDT)
Received: from [192.168.1.115] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id r2sm13351987wrm.3.2019.10.07.03.27.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2019 03:27:29 -0700 (PDT)
Subject: Re: [PATCH] target/i386: log guest name and memory error type AO, AR
 for MCEs
To: Mario Smarduch <msmarduch@digitalocean.com>, mtosatti@redhat.com,
 armbru@redhat.com, pbonzini@redhat.com
References: <ceb4d639-842a-30bd-5d54-bfacb07b5cc4@digitalocean.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8ca93883-1af3-7959-1b8c-4eeff2f2cae5@redhat.com>
Date: Mon, 7 Oct 2019 12:27:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <ceb4d639-842a-30bd-5d54-bfacb07b5cc4@digitalocean.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, ehabkost@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Mario,

On 10/5/19 1:53 AM, Mario Smarduch wrote:
> In a large VPC environment we want to log memory error occurrences
> and log them with guest name and type - there are few use cases
> 
> 
> - if VM crashes on AR mce inform the user about the reason and
>    resolve the case
> - if VM hangs notify the user to reboot and resume processing
> - if VM continues to run let the user know, he/she maybe able to
>    correlate to vm internal outage
> - Rawhammer attacks - isolate/determine the attacker possible
>    migrating it off the hypervisor
> - In general track memory errors on a hyperviosr over time to determine
>    trends
> 
> Monitoring our fleet we come across quite a few of these and been
> able to take action where before there were no clues to the causes.
> 
> When memory error occurs we get a log entry in qemu log:
> 
> Guest [Droplet-12345678] 2019-08-02T05:00:11.940270Z qemu-system-x86_64:
> Guest MCE Memory Error at qemu addr 0x7f3c7622f000 and guest 78e42f000
> addr of type BUS_MCEERR_AR injected
> 
> with enterprise logging environment we can to take further actions.
> 
> Signed-off-by: Mario Smarduch <msmarduch@digitalocean.com>
> ---
>   target/i386/kvm.c | 27 ++++++++++++++++++++++-----
>   util/qemu-error.c | 24 ++++++++++++++++++++++++
>   2 files changed, 46 insertions(+), 5 deletions(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 92069099ab..79ebccc684 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -555,9 +555,9 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr
> paddr, int code)
>                          (MCM_ADDR_PHYS << 6) | 0xc, flags);
>   }
> 
> -static void hardware_memory_error(void)
> +static void hardware_memory_error(void *addr)

Maybe rename addr -> host_addr.

>   {
> -    fprintf(stderr, "Hardware memory error!\n");
> +    error_report("QEMU got Hardware memory error at addr %p", addr);
>       exit(1);
>   }
> 
> @@ -581,15 +581,32 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int
> code, void *addr)
>               kvm_physical_memory_addr_from_host(c->kvm_state, addr,
> &paddr)) {
>               kvm_hwpoison_page_add(ram_addr);
>               kvm_mce_inject(cpu, paddr, code);
> +            /*
> +             * Use different logging severity based on error type.
> +             * If mcelog is running qemu va addr will help debug via
> mcelog.
> +             */
> +            if (code == BUS_MCEERR_AR) {
> +                error_report("Guest MCE Memory Error at qemu addr %p and "
> +                    "guest %lx addr of type %s injected", addr, paddr,

"qemu addr" is not clear IMO, 'addr' is in the host (and is virtual... 
how does this help you?).

For the guest paddr you should use "0x%"HWADDR_PRIx format.

> +                     "BUS_MCEERR_AR");
> +            } else {
> +                 warn_report("Guest MCE Memory Error at qemu addr %p and "
> +                     "guest %lx addr of type %s injected", addr,
> +                     paddr, "BUS_MCEERR_AO");
> +            }
> +
>               return;
>           }
> 
> -        fprintf(stderr, "Hardware memory error for memory used by "
> -                "QEMU itself instead of guest system!\n");
> +        if (code == BUS_MCEERR_AO) {
> +            warn_report("Hardware memory error at addr %p of type %s "
> +                "for memory used by QEMU itself instead of guest system!",
> +                addr, "BUS_MCEERR_AO");
> +        }
>       }
> 
>       if (code == BUS_MCEERR_AR) {
> -        hardware_memory_error();
> +        hardware_memory_error(addr);
>       }
> 
>       /* Hope we are lucky for AO MCE */
> diff --git a/util/qemu-error.c b/util/qemu-error.c
> index f373f3b3b0..2ebafd4405 100644
> --- a/util/qemu-error.c
> +++ b/util/qemu-error.c
> @@ -11,6 +11,8 @@
>    */
> 
>   #include "qemu/osdep.h"
> +#include "qemu/option.h"
> +#include "qemu/config-file.h"
>   #include "monitor/monitor.h"
>   #include "qemu/error-report.h"
> 
> @@ -35,11 +37,31 @@ int error_printf(const char *fmt, ...)
>       return ret;
>   }
> 
> +static const char *error_get_guestname(void)
> +{
> +    QemuOpts *opts = qemu_opts_find(qemu_find_opts("name"), NULL);
> +    return qemu_opt_get(opts, "guest");
> +}
> +
> +/*
> + * Print guest name associated with error, to aid debugging errors from
> + * multiple guests in centralized logging environment.
> + */
> +static void error_print_guestname(void)
> +{
> +    const char *name;
> +    name = error_get_guestname();
> +    if (name != NULL && !cur_mon) {
> +        error_printf("Guest [%s] ", name);
> +    }
> +}
> +
>   int error_printf_unless_qmp(const char *fmt, ...)
>   {
>       va_list ap;
>       int ret;
> 
> +    error_print_guestname();
>       va_start(ap, fmt);
>       ret = error_vprintf_unless_qmp(fmt, ap);
>       va_end(ap);
> @@ -274,6 +296,7 @@ void error_report(const char *fmt, ...)
>   {
>       va_list ap;
> 
> +    error_print_guestname();
>       va_start(ap, fmt);
>       vreport(REPORT_TYPE_ERROR, fmt, ap);
>       va_end(ap);
> @@ -289,6 +312,7 @@ void warn_report(const char *fmt, ...)
>   {
>       va_list ap;
> 
> +    error_print_guestname();
>       va_start(ap, fmt);
>       vreport(REPORT_TYPE_WARNING, fmt, ap);
>       va_end(ap);
> --
> 2.17.1
> 

