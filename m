Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA643C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 902B2206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902B2206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIajz-0006EE-72
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 11:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIaUy-00027y-TL
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIaUw-0008A6-Vj
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:37:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39224)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIaUw-00089n-NK
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:37:02 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4A344A76C
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 15:37:01 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id m16so1926045wmg.8
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 08:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Pvzh+QqX4b/9j/hTSm4IVizT1O52q3p1yC1FsqhDsZ4=;
 b=pvH8bhWUCksBCrv+hmHrxkQmcg4wDDdEVAbKK6A21EBnMlpTF/MdgyqRSgXUZ6HYpv
 nNjzmInXxCM5lvq5/yjV7XeMXo2eapwvhbFLy3OOUEznTTy7yxvO0XKcBG3jjNZYuW4R
 eBLYQtRsHpqbFBjXDSqQRWWQ+WBPJj35uJTM/ujFrsO+5RamOSO9XaHMlDO6f/6nM9WH
 F8xI4uPCWx/RjAU1HYtU4RxoP5Tlun4EbaRmUUMXS29SiWOgqkP7H5K++xkjrWeQGHjC
 uIH6y7UovBb2NXqEUc7T5QDurocbhtFCq1G6dh9eXwry0kMsEn13ocMxNyQw2lFHgH5E
 HzvA==
X-Gm-Message-State: APjAAAVzDnMjIAjo/LKEhWr5DUOVC8vaMPIFTeELmlEvKgnOOQTi+VSK
 I/Bnbn+lKfiTmB0ybHt+jo9SqH50zPShp6wPV5tgKxpC8KDaFQX/YNxTLjurMqlFb8jHr34Edp4
 dhgHAc3myxt3miaw=
X-Received: by 2002:a1c:2d4d:: with SMTP id t74mr7838203wmt.108.1570721819882; 
 Thu, 10 Oct 2019 08:36:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqycADKflItcRXfzu8xT1dHgf3IBp1eHn8mca10lETxD8VVgMbL03l8dZNWfJj7IbzRuSOKYIA==
X-Received: by 2002:a1c:2d4d:: with SMTP id t74mr7838173wmt.108.1570721819576; 
 Thu, 10 Oct 2019 08:36:59 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id o4sm13280435wre.91.2019.10.10.08.36.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2019 08:36:58 -0700 (PDT)
Subject: Re: [PATCH v8 03/15] hw/i386/pc: fix code style issues on functions
 that will be moved out
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191010143125.67246-1-slp@redhat.com>
 <20191010143125.67246-4-slp@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0b646268-8610-f14a-c513-8a4580078b29@redhat.com>
Date: Thu, 10 Oct 2019 17:36:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191010143125.67246-4-slp@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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

On 10/10/19 4:31 PM, Sergio Lopez wrote:
> Fix code style issues detected by checkpatch.pl on functions that will
> be moved out to x86.c.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>   hw/i386/pc.c | 53 ++++++++++++++++++++++++++++-----------------------=
-
>   1 file changed, 29 insertions(+), 24 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index fd08c6704b..77e86bfc3d 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -866,7 +866,8 @@ static void handle_a20_line_change(void *opaque, in=
t irq, int level)
>       x86_cpu_set_a20(cpu, level);
>   }
>  =20
> -/* Calculates initial APIC ID for a specific CPU index
> +/*
> + * Calculates initial APIC ID for a specific CPU index
>    *
>    * Currently we need to be able to calculate the APIC ID from the CPU=
 index
>    * alone (without requiring a CPU object), as the QEMU<->Seabios inte=
rfaces have
> @@ -1039,7 +1040,7 @@ static void x86_load_linux(PCMachineState *pcms,
>       const char *kernel_cmdline =3D machine->kernel_cmdline;
>  =20
>       /* Align to 16 bytes as a paranoia measure */
> -    cmdline_size =3D (strlen(kernel_cmdline)+16) & ~15;
> +    cmdline_size =3D (strlen(kernel_cmdline) + 16) & ~15;
>  =20
>       /* load the kernel header */
>       f =3D fopen(kernel_filename, "rb");
> @@ -1055,8 +1056,8 @@ static void x86_load_linux(PCMachineState *pcms,
>   #if 0
>       fprintf(stderr, "header magic: %#x\n", ldl_p(header+0x202));
>   #endif
> -    if (ldl_p(header+0x202) =3D=3D 0x53726448) {
> -        protocol =3D lduw_p(header+0x206);
> +    if (ldl_p(header + 0x202) =3D=3D 0x53726448) {
> +        protocol =3D lduw_p(header + 0x206);
>       } else {
>           /*
>            * This could be a multiboot kernel. If it is, let's stop tre=
ating it
> @@ -1158,7 +1159,7 @@ static void x86_load_linux(PCMachineState *pcms,
>  =20
>       /* highest address for loading the initrd */
>       if (protocol >=3D 0x20c &&
> -        lduw_p(header+0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
> +        lduw_p(header + 0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
>           /*
>            * Linux has supported initrd up to 4 GB for a very long time=
 (2007,
>            * long before XLF_CAN_BE_LOADED_ABOVE_4G which was added in =
2013),
> @@ -1177,7 +1178,7 @@ static void x86_load_linux(PCMachineState *pcms,
>            */
>           initrd_max =3D UINT32_MAX;
>       } else if (protocol >=3D 0x203) {
> -        initrd_max =3D ldl_p(header+0x22c);
> +        initrd_max =3D ldl_p(header + 0x22c);
>       } else {
>           initrd_max =3D 0x37ffffff;
>       }
> @@ -1187,14 +1188,14 @@ static void x86_load_linux(PCMachineState *pcms=
,
>       }
>  =20
>       fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
> -    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(kernel_cmdline)=
+1);
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(kernel_cmdline)=
 + 1);
>       fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
>  =20
>       if (protocol >=3D 0x202) {
> -        stl_p(header+0x228, cmdline_addr);
> +        stl_p(header + 0x228, cmdline_addr);
>       } else {
> -        stw_p(header+0x20, 0xA33F);
> -        stw_p(header+0x22, cmdline_addr-real_addr);
> +        stw_p(header + 0x20, 0xA33F);
> +        stw_p(header + 0x22, cmdline_addr - real_addr);
>       }
>  =20
>       /* handle vga=3D parameter */
> @@ -1212,20 +1213,22 @@ static void x86_load_linux(PCMachineState *pcms=
,
>           } else {
>               video_mode =3D strtol(vmode, NULL, 0);
>           }
> -        stw_p(header+0x1fa, video_mode);
> +        stw_p(header + 0x1fa, video_mode);
>       }
>  =20
>       /* loader type */
> -    /* High nybble =3D B reserved for QEMU; low nybble is revision num=
ber.
> -       If this code is substantially changed, you may want to consider
> -       incrementing the revision. */
> +    /*
> +     * High nybble =3D B reserved for QEMU; low nybble is revision num=
ber.
> +     * If this code is substantially changed, you may want to consider
> +     * incrementing the revision.
> +     */
>       if (protocol >=3D 0x200) {
>           header[0x210] =3D 0xB0;
>       }
>       /* heap */
>       if (protocol >=3D 0x201) {
> -        header[0x211] |=3D 0x80;	/* CAN_USE_HEAP */
> -        stw_p(header+0x224, cmdline_addr-real_addr-0x200);
> +        header[0x211] |=3D 0x80; /* CAN_USE_HEAP */
> +        stw_p(header + 0x224, cmdline_addr - real_addr - 0x200);
>       }
>  =20
>       /* load initrd */
> @@ -1257,14 +1260,14 @@ static void x86_load_linux(PCMachineState *pcms=
,
>               exit(1);
>           }
>  =20
> -        initrd_addr =3D (initrd_max-initrd_size) & ~4095;
> +        initrd_addr =3D (initrd_max - initrd_size) & ~4095;
>  =20
>           fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
>           fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
>           fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data, ini=
trd_size);
>  =20
> -        stl_p(header+0x218, initrd_addr);
> -        stl_p(header+0x21c, initrd_size);
> +        stl_p(header + 0x218, initrd_addr);
> +        stl_p(header + 0x21c, initrd_size);
>       }
>  =20
>       /* load kernel and setup */
> @@ -1272,7 +1275,7 @@ static void x86_load_linux(PCMachineState *pcms,
>       if (setup_size =3D=3D 0) {
>           setup_size =3D 4;
>       }
> -    setup_size =3D (setup_size+1)*512;
> +    setup_size =3D (setup_size + 1) * 512;
>       if (setup_size > kernel_size) {
>           fprintf(stderr, "qemu: invalid kernel header\n");
>           exit(1);
> @@ -1310,7 +1313,7 @@ static void x86_load_linux(PCMachineState *pcms,
>           kernel_size =3D setup_data_offset + sizeof(struct setup_data)=
 + dtb_size;
>           kernel =3D g_realloc(kernel, kernel_size);
>  =20
> -        stq_p(header+0x250, prot_addr + setup_data_offset);
> +        stq_p(header + 0x250, prot_addr + setup_data_offset);
>  =20
>           setup_data =3D (struct setup_data *)(kernel + setup_data_offs=
et);
>           setup_data->next =3D 0;
> @@ -1507,7 +1510,8 @@ void x86_cpus_init(PCMachineState *pcms)
>  =20
>       x86_cpu_set_default_version(pcmc->default_cpu_version);
>  =20
> -    /* Calculates the limit to CPU APIC ID values
> +    /*
> +     * Calculates the limit to CPU APIC ID values
>        *
>        * Limit for the APIC ID value, so that all
>        * CPU APIC IDs are < pcms->apic_id_limit.
> @@ -2709,7 +2713,7 @@ static const CPUArchIdList *x86_possible_cpu_arch=
_ids(MachineState *ms)
>           /*
>            * make sure that max_cpus hasn't changed since the first use=
, i.e.
>            * -smp hasn't been parsed after it
> -        */
> +         */
>           assert(ms->possible_cpus->len =3D=3D max_cpus);
>           return ms->possible_cpus;
>       }
> @@ -2722,7 +2726,8 @@ static const CPUArchIdList *x86_possible_cpu_arch=
_ids(MachineState *ms)
>  =20
>           ms->possible_cpus->cpus[i].type =3D ms->cpu_type;
>           ms->possible_cpus->cpus[i].vcpus_count =3D 1;
> -        ms->possible_cpus->cpus[i].arch_id =3D x86_cpu_apic_id_from_in=
dex(pcms, i);
> +        ms->possible_cpus->cpus[i].arch_id =3D
> +            x86_cpu_apic_id_from_index(pcms, i);
>           x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
>                                    pcms->smp_dies, ms->smp.cores,
>                                    ms->smp.threads, &topo);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

