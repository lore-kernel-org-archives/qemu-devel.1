Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8BEC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:00:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED93124677
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X34Cmikj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED93124677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8uys-0001h9-1g
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:00:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j8uyD-0001FM-Jq
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:59:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j8uyC-00050m-5a
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:59:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49426
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j8uyC-00050d-0y
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583193571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UDioW14Cd9IrNZtCdsKhj5z5zw2Hexoy+6PRPzHw25Y=;
 b=X34CmikjhwLZ3SyLZTtek8TJi0jVCopT2HmHuQh2BLeMm1G353TZJEFE8Xx3Rx9X3q0SDV
 7UI/pZfIMhUiBhJrLzOZzWQcu6rc4urQeUFwHpXck3Mj+5+3GSMGmMSUcMSoKZFArVYXZ+
 WbcIlxrU7AiBilxYzRQAHYAHIZBzUwg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-e-kMSNE-PiuX_G4QnKoQJQ-1; Mon, 02 Mar 2020 18:59:29 -0500
X-MC-Unique: e-kMSNE-PiuX_G4QnKoQJQ-1
Received: by mail-wm1-f69.google.com with SMTP id r19so352159wmh.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 15:59:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UDioW14Cd9IrNZtCdsKhj5z5zw2Hexoy+6PRPzHw25Y=;
 b=LfJ3gGNeAXw66caisf9iqAtxa0/StkX1bNX0uDFQyM/tM++O5s/mG20czvyhd6l+3K
 7AsAfnlft7j6m1do+gxUGb2hEvXiX6wikqNeF7jCkqDa70FNYh04YoWNh76JpfBc7p70
 yUdKRfSz9aePDcAJDX1hdSNbjVKdRoW/OZPYrQkc0F1msh7W50R7oD/TXvSUg2PE/MAJ
 Chzj97fGHqBr/gbbfCJT1j2/ydd4/PwRuLw76SN4XeKcphWSTuKfipbCjvzfHl+c0Oj3
 G3yh2lZ549YsxlWmPfAKllA8+/w1jqYS+2k1DoZDlaq0tG4X8yA4JV7I5F06HMbaLUax
 E0pA==
X-Gm-Message-State: ANhLgQ3qLTWC+u4w5Fp5K4Sr0wf9s0Br8w6Qxk52UiN6QIHKxAM6vA2F
 cR3hXQbx/Ocx+GwlcG3FrlQGFuW2k1fCfBMToPAfDQWgxdcQz+6J5OH9GG9/pOBvy3zS3p9/xA8
 EyLZspFy7JMl3xT8=
X-Received: by 2002:adf:f2ca:: with SMTP id d10mr1971361wrp.247.1583193568159; 
 Mon, 02 Mar 2020 15:59:28 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuVIPNT+2KEjn1uSM8r6aW27xF9roCSR3jgqDoYnUSiUufA0m4A0sb6um7a38tzLViuviH7ZA==
X-Received: by 2002:adf:f2ca:: with SMTP id d10mr1971343wrp.247.1583193567879; 
 Mon, 02 Mar 2020 15:59:27 -0800 (PST)
Received: from ?IPv6:2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0?
 ([2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0])
 by smtp.gmail.com with ESMTPSA id t1sm33274495wrs.41.2020.03.02.15.59.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 15:59:27 -0800 (PST)
Subject: Re: [EXTERNAL][PATCH] mips/mips_malta: Allow more than 2G RAM
To: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>
References: <20200228032613.1049955-1-jiaxun.yang@flygoat.com>
 <BN6PR2201MB12518300604D482EAE3CA145C6E70@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8ad428b2-834e-7f33-eb96-dd0aa1aad8ed@redhat.com>
Date: Tue, 3 Mar 2020 00:59:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB12518300604D482EAE3CA145C6E70@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Yunqiang Su <ysu@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 10:22 PM, Aleksandar Markovic wrote:
> Forwarding this to Igor. Can you please give us your opinion, Igor, on this proposal?

I'm not sure it is Igor area.

What need to be reviewed here is the GT64120 north bridge, which works 
very well with the default config, but is fragile when modifying it.

I'd be more confident with an acceptance test running memtester.

> ________________________________________
> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Sent: Friday, February 28, 2020 4:26 AM
> To: qemu-devel@nongnu.org
> Cc: philmd@redhat.com; Aleksandar Markovic; Jiaxun Yang; Yunqiang Su
> Subject: [EXTERNAL][PATCH] mips/mips_malta: Allow more than 2G RAM
> 
> When malta is coupled with MIPS64 cpu which have 64bit
> address space, it is possible to have more than 2G RAM.
> 
> So we removed ram_size check and overwrite memory
> layout for these targets.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Suggested-by: Yunqiang Su <ysu@wavecomp.com>
> ---
>   hw/mips/mips_malta.c | 24 ++++++++++++++++++------
>   1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 6e7ba9235d..de89cdcfc1 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -98,7 +98,8 @@ typedef struct {
>   } MaltaState;
> 
>   static struct _loaderparams {
> -    int ram_size, ram_low_size;
> +    unsigned int ram_low_size;
> +    ram_addr_t ram_size;
>       const char *kernel_filename;
>       const char *kernel_cmdline;
>       const char *initrd_filename;
> @@ -1023,6 +1024,7 @@ static int64_t load_kernel(void)
>   {
>       int64_t kernel_entry, kernel_high, initrd_size;
>       long kernel_size;
> +    char mem_cmdline[128];
>       ram_addr_t initrd_offset;
>       int big_endian;
>       uint32_t *prom_buf;
> @@ -1099,20 +1101,28 @@ static int64_t load_kernel(void)
>       prom_buf = g_malloc(prom_size);
> 
>       prom_set(prom_buf, prom_index++, "%s", loaderparams.kernel_filename);
> +
> +    /*
> +     * Always use cmdline to overwrite mem layout
> +     * as kernel may reject large emesize.
> +     */
> +    sprintf(&mem_cmdline[0],
> +        "mem=0x10000000@0x00000000 mem=0x%" PRIx64 "@0x90000000",
> +        loaderparams.ram_size - 0x10000000);
>       if (initrd_size > 0) {
>           prom_set(prom_buf, prom_index++,
> -                 "rd_start=0x%" PRIx64 " rd_size=%" PRId64 " %s",
> -                 xlate_to_kseg0(NULL, initrd_offset),
> +                 "%s rd_start=0x%" PRIx64 " rd_size=%" PRId64 " %s",
> +                 &mem_cmdline[0], xlate_to_kseg0(NULL, initrd_offset),
>                    initrd_size, loaderparams.kernel_cmdline);
>       } else {
> -        prom_set(prom_buf, prom_index++, "%s", loaderparams.kernel_cmdline);
> +        prom_set(prom_buf, prom_index++, "%s %s",&mem_cmdline[0] ,loaderparams.kernel_cmdline);
>       }
> 
>       prom_set(prom_buf, prom_index++, "memsize");
>       prom_set(prom_buf, prom_index++, "%u", loaderparams.ram_low_size);
> 
>       prom_set(prom_buf, prom_index++, "ememsize");
> -    prom_set(prom_buf, prom_index++, "%u", loaderparams.ram_size);
> +    prom_set(prom_buf, prom_index++, "%lu", loaderparams.ram_size);
> 
>       prom_set(prom_buf, prom_index++, "modetty0");
>       prom_set(prom_buf, prom_index++, "38400n8r");
> @@ -1253,12 +1263,14 @@ void mips_malta_init(MachineState *machine)
>       /* create CPU */
>       mips_create_cpu(machine, s, &cbus_irq, &i8259_irq);
> 
> -    /* allocate RAM */
> +#ifdef TARGET_MIPS32
> +    /* MIPS32 won't accept more than 2GiB RAM due to limited address space */
>       if (ram_size > 2 * GiB) {
>           error_report("Too much memory for this machine: %" PRId64 "MB,"
>                        " maximum 2048MB", ram_size / MiB);
>           exit(1);
>       }
> +#endif
> 
>       /* register RAM at high address where it is undisturbed by IO */
>       memory_region_add_subregion(system_memory, 0x80000000, machine->ram);
> --
> 2.25.1
> 
> 
> 
> 


