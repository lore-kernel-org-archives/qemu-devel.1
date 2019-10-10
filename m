Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309FDC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DEB20650
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DEB20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXC4-0004aD-RQ
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIWnz-0003KS-BR
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIWnx-0007V1-J6
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:40:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37734)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIWnx-0007Ro-2c
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:40:25 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B2ADE4E8AC
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 11:40:23 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id n3so2504772wmf.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 04:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q8o01x8YRtYzGvBYXN8HMfCxymxHgIbljVL2OnXwNNE=;
 b=pvZy4moJOZfZKMImYuAjQv+UD7PC4bok9MhnXEQwqpOWKn8khvnjrtpHGT1BMk10ja
 uC+d3gRWbDQGnH91WlmlPox8AfL7AXDil2j+BkHcxFz2PSbjApWBeJt4b6U1RHBzITZ6
 BPBON4jCLErdGnbq7pEy64PfJUakmOei1w0CNYLIB/BN5TgLvfizH54sa4dTwq42aF7N
 rIM4UW0bFqOIUZUTl2ODoKruqt9xvqg3VP1yjZ4ZP6EsrtsT3C58ut7dUYNqN3MDyDih
 Pd8ajY1Lp0Y+aCmHrJ4Che2YVanO/jmvkQpJpH7uUsFqtyTkKFuEGMp68CUsbBi5DeCC
 m3Rw==
X-Gm-Message-State: APjAAAUpFWSwV0EHGmK1IfNcA/IKJAByagDAQAZ/798pgubA+hY08RcU
 HKCh05xB+oO6ntYXZd8T9lYs5YH7Mnvow6j7b3yUC3qEC/pvc078u+HuebhBhjTvf7v7uaaFIoy
 D+XtvbmMfKlPZsEE=
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr7563417wmj.94.1570707622243; 
 Thu, 10 Oct 2019 04:40:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyhdu+WrxDcLJYUmRVyEvNV+N/9FNHKS5CeCAEfjLv7YdUILSjcTwfyGbxlFbVvwOHDJA54vw==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr7563383wmj.94.1570707621899; 
 Thu, 10 Oct 2019 04:40:21 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id j26sm7858389wrd.2.2019.10.10.04.40.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2019 04:40:21 -0700 (PDT)
Subject: Re: [PATCH v7 03/12] hw/i386/pc: fix code style issues on functions
 that will be moved out
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191008135537.197867-1-slp@redhat.com>
 <20191008135537.197867-4-slp@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <665da4ba-c548-bad8-c6e5-899aea4d2798@redhat.com>
Date: Thu, 10 Oct 2019 13:40:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191008135537.197867-4-slp@redhat.com>
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
Cc: ehabkost@redhat.com, mst@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sergio,

On 10/8/19 3:55 PM, Sergio Lopez wrote:
> Fix code style issues detected by checkpatch.pl on functions that will
> be moved out to x86.c on the next patch.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>   hw/i386/pc.c | 86 ++++++++++++++++++++++++++++------------------------
>   1 file changed, 46 insertions(+), 40 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index fd08c6704b..f19d4ac0bd 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -68,6 +68,7 @@
>   #include "qemu/config-file.h"
>   #include "qemu/error-report.h"
>   #include "qemu/option.h"
> +#include "qemu/cutils.h"

Hmm this line seems to belong to the next patch, it is not a style issue 
cleanup.

>   #include "hw/acpi/acpi.h"
>   #include "hw/acpi/cpu_hotplug.h"
>   #include "hw/boards.h"
> @@ -866,7 +867,8 @@ static void handle_a20_line_change(void *opaque, int irq, int level)
>       x86_cpu_set_a20(cpu, level);
>   }
>   
> -/* Calculates initial APIC ID for a specific CPU index
> +/*
> + * Calculates initial APIC ID for a specific CPU index

OK

>    *
>    * Currently we need to be able to calculate the APIC ID from the CPU index
>    * alone (without requiring a CPU object), as the QEMU<->Seabios interfaces have
> @@ -1039,11 +1041,18 @@ static void x86_load_linux(PCMachineState *pcms,
>       const char *kernel_cmdline = machine->kernel_cmdline;
>   
>       /* Align to 16 bytes as a paranoia measure */
> -    cmdline_size = (strlen(kernel_cmdline)+16) & ~15;
> +    cmdline_size = (strlen(kernel_cmdline) + 16) & ~15;
>   
>       /* load the kernel header */
>       f = fopen(kernel_filename, "rb");
> -    if (!f || !(kernel_size = get_file_size(f)) ||
> +    if (!f) {
> +        fprintf(stderr, "qemu: could not open kernel file '%s': %s\n",
> +                kernel_filename, strerror(errno));

This is not a style change neither :(

> +        exit(1);
> +    }
> +
> +    kernel_size = get_file_size(f);
> +    if (!kernel_size ||
>           fread(header, 1, MIN(ARRAY_SIZE(header), kernel_size), f) !=
>           MIN(ARRAY_SIZE(header), kernel_size)) {
>           fprintf(stderr, "qemu: could not load kernel '%s': %s\n",
> @@ -1052,11 +1061,8 @@ static void x86_load_linux(PCMachineState *pcms,
>       }
>   
>       /* kernel protocol version */
> -#if 0
> -    fprintf(stderr, "header magic: %#x\n", ldl_p(header+0x202));

Since unfortunately you need to respin, can you move this change (and 
the other fprintf(stderr) few lines below) into a separate patch 
"~Remove commented out code~"?

> -#endif
> -    if (ldl_p(header+0x202) == 0x53726448) {
> -        protocol = lduw_p(header+0x206);
> +    if (ldl_p(header + 0x202) == 0x53726448) {
> +        protocol = lduw_p(header + 0x206);

OK

>       } else {
>           /*
>            * This could be a multiboot kernel. If it is, let's stop treating it
> @@ -1146,19 +1152,9 @@ static void x86_load_linux(PCMachineState *pcms,
>           prot_addr    = 0x100000;
>       }
>   
> -#if 0
> -    fprintf(stderr,
> -            "qemu: real_addr     = 0x" TARGET_FMT_plx "\n"
> -            "qemu: cmdline_addr  = 0x" TARGET_FMT_plx "\n"
> -            "qemu: prot_addr     = 0x" TARGET_FMT_plx "\n",
> -            real_addr,
> -            cmdline_addr,
> -            prot_addr);
> -#endif
> -
>       /* highest address for loading the initrd */
>       if (protocol >= 0x20c &&
> -        lduw_p(header+0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
> +        lduw_p(header + 0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {

OK

>           /*
>            * Linux has supported initrd up to 4 GB for a very long time (2007,
>            * long before XLF_CAN_BE_LOADED_ABOVE_4G which was added in 2013),
> @@ -1177,7 +1173,7 @@ static void x86_load_linux(PCMachineState *pcms,
>            */
>           initrd_max = UINT32_MAX;
>       } else if (protocol >= 0x203) {
> -        initrd_max = ldl_p(header+0x22c);
> +        initrd_max = ldl_p(header + 0x22c);

OK

>       } else {
>           initrd_max = 0x37ffffff;
>       }
> @@ -1187,20 +1183,21 @@ static void x86_load_linux(PCMachineState *pcms,
>       }
>   
>       fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
> -    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(kernel_cmdline)+1);
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(kernel_cmdline) + 1);

OK

>       fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
>   
>       if (protocol >= 0x202) {
> -        stl_p(header+0x228, cmdline_addr);
> +        stl_p(header + 0x228, cmdline_addr);
OK

>       } else {
> -        stw_p(header+0x20, 0xA33F);
> -        stw_p(header+0x22, cmdline_addr-real_addr);
> +        stw_p(header + 0x20, 0xA33F);
> +        stw_p(header + 0x22, cmdline_addr - real_addr);

OK

>       }
>   
>       /* handle vga= parameter */
>       vmode = strstr(kernel_cmdline, "vga=");
>       if (vmode) {
> -        unsigned int video_mode;
> +        long video_mode;
> +        int ret;
>           /* skip "vga=" */
>           vmode += 4;
>           if (!strncmp(vmode, "normal", 6)) {
> @@ -1210,22 +1207,29 @@ static void x86_load_linux(PCMachineState *pcms,
>           } else if (!strncmp(vmode, "ask", 3)) {
>               video_mode = 0xfffd;
>           } else {
> -            video_mode = strtol(vmode, NULL, 0);
> +            ret = qemu_strtol(vmode, NULL, 0, &video_mode);
> +            if (ret != 0) {
> +                fprintf(stderr, "qemu: can't parse 'vga' parameter: %s\n",
> +                        strerror(-ret));

Not a style cleanup.

> +                exit(1);
> +            }
>           }
> -        stw_p(header+0x1fa, video_mode);
> +        stw_p(header + 0x1fa, video_mode);

OK

>       }
>   
>       /* loader type */
> -    /* High nybble = B reserved for QEMU; low nybble is revision number.
> -       If this code is substantially changed, you may want to consider
> -       incrementing the revision. */
> +    /*
> +     * High nybble = B reserved for QEMU; low nybble is revision number.
> +     * If this code is substantially changed, you may want to consider
> +     * incrementing the revision.

OK

> +     */
>       if (protocol >= 0x200) {
>           header[0x210] = 0xB0;
>       }
>       /* heap */
>       if (protocol >= 0x201) {
> -        header[0x211] |= 0x80;	/* CAN_USE_HEAP */
> -        stw_p(header+0x224, cmdline_addr-real_addr-0x200);
> +        header[0x211] |= 0x80; /* CAN_USE_HEAP */
> +        stw_p(header + 0x224, cmdline_addr - real_addr - 0x200);

OK

>       }
>   
>       /* load initrd */
> @@ -1257,14 +1261,14 @@ static void x86_load_linux(PCMachineState *pcms,
>               exit(1);
>           }
>   
> -        initrd_addr = (initrd_max-initrd_size) & ~4095;
> +        initrd_addr = (initrd_max - initrd_size) & ~4095;

OK

>   
>           fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
>           fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
>           fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data, initrd_size);
>   
> -        stl_p(header+0x218, initrd_addr);
> -        stl_p(header+0x21c, initrd_size);
> +        stl_p(header + 0x218, initrd_addr);
> +        stl_p(header + 0x21c, initrd_size);

OK

>       }
>   
>       /* load kernel and setup */
> @@ -1272,7 +1276,7 @@ static void x86_load_linux(PCMachineState *pcms,
>       if (setup_size == 0) {
>           setup_size = 4;
>       }
> -    setup_size = (setup_size+1)*512;
> +    setup_size = (setup_size + 1) * 512;

OK

>       if (setup_size > kernel_size) {
>           fprintf(stderr, "qemu: invalid kernel header\n");
>           exit(1);
> @@ -1310,7 +1314,7 @@ static void x86_load_linux(PCMachineState *pcms,
>           kernel_size = setup_data_offset + sizeof(struct setup_data) + dtb_size;
>           kernel = g_realloc(kernel, kernel_size);
>   
> -        stq_p(header+0x250, prot_addr + setup_data_offset);
> +        stq_p(header + 0x250, prot_addr + setup_data_offset);

OK

>   
>           setup_data = (struct setup_data *)(kernel + setup_data_offset);
>           setup_data->next = 0;
> @@ -1507,7 +1511,8 @@ void x86_cpus_init(PCMachineState *pcms)
>   
>       x86_cpu_set_default_version(pcmc->default_cpu_version);
>   
> -    /* Calculates the limit to CPU APIC ID values
> +    /*
> +     * Calculates the limit to CPU APIC ID values

OK

>        *
>        * Limit for the APIC ID value, so that all
>        * CPU APIC IDs are < pcms->apic_id_limit.
> @@ -2709,7 +2714,7 @@ static const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>           /*
>            * make sure that max_cpus hasn't changed since the first use, i.e.
>            * -smp hasn't been parsed after it
> -        */
> +         */

Arf OK

>           assert(ms->possible_cpus->len == max_cpus);
>           return ms->possible_cpus;
>       }
> @@ -2722,7 +2727,8 @@ static const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>   
>           ms->possible_cpus->cpus[i].type = ms->cpu_type;
>           ms->possible_cpus->cpus[i].vcpus_count = 1;
> -        ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(pcms, i);
> +        ms->possible_cpus->cpus[i].arch_id =
> +            x86_cpu_apic_id_from_index(pcms, i);

OK

>           x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
>                                    pcms->smp_dies, ms->smp.cores,
>                                    ms->smp.threads, &topo);
> 

