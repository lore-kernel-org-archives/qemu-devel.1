Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC67FC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 20:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6251206E9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 20:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvrtcTho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6251206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCqc2-0006jP-Vm
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 16:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCqb1-0006Jo-9W
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 16:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCqb0-0003Dc-5p
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 16:07:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37736
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCqb0-0003Aw-1M
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 16:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584130069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0x82LgMbNQm246MDfZYsJBCoDnwEYdgG/yjEKNhCfU=;
 b=JvrtcTho6Z7S+54vrjb8xrk8Fv7iJE3bT2oRHHKFgKjRFMRl27X3rqr25I8jHb28+v2xnE
 I82Gg25q3Mazz3OzsJBr0ib8oHTiErkpHIUI02IIuOtoXG2y/8LEADX3uHbnCzu0lIVMyB
 lKRtJ3PUemROn22W0NBGcBYFGT+oM9M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-7kcezP__PLuPgWFhmGe40g-1; Fri, 13 Mar 2020 16:07:48 -0400
X-MC-Unique: 7kcezP__PLuPgWFhmGe40g-1
Received: by mail-wr1-f72.google.com with SMTP id u18so4781863wrn.11
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 13:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U0x82LgMbNQm246MDfZYsJBCoDnwEYdgG/yjEKNhCfU=;
 b=lIwdUzrJztixaopesSqTi3ZuaMrDRRmiTGL57LCq1PNlI5EvkRkNJjMTEMaqolA7Ux
 +VUfZ5r3V4CvGJW7UiJfZIfOJcHyL62NqsGBaXr1nwEZxl9GUKVGyybbQPWIb43IzGNC
 OD6mjb10F95p8WJfvWsZIJw0cgoX/vKLOvPw8tPrhB9YfU2sibRLW2OEDGE0vAghpYJd
 QY6QSh0tV54Isl8e61A4IrI0A8K382T4zWEtcKxfgVrvbsDpTECFYCXgCOYJjSYSh+8k
 Dj+esoNvO3d60AbvnnQYFwrcNu5Ixc/Ju2z+CmEKXUkg7LcLyi72JiSF2PvGOyjpA+le
 obJA==
X-Gm-Message-State: ANhLgQ1+Neadm+VrJON54cpEDvzV4id0b0YC1aP7QiLwTI9rxT8l3PKe
 b79NrA+excT4a1OxnllVuigvSuOUgRgbToil94qxJS2MmD4/VNfOhDkVAJ+mTS08jSiVsGV9/Le
 zzfkU45CvALaBvMU=
X-Received: by 2002:a05:600c:29cf:: with SMTP id
 s15mr12010455wmd.117.1584130066831; 
 Fri, 13 Mar 2020 13:07:46 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsuw9XaYQ3SNRFePPOzaBafDNg924v2g3Zf//2ZIhG36HNrdKR3D7cmkf52bAEznn5HFtAJJg==
X-Received: by 2002:a05:600c:29cf:: with SMTP id
 s15mr12010432wmd.117.1584130066550; 
 Fri, 13 Mar 2020 13:07:46 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id t126sm16359669wmb.27.2020.03.13.13.07.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 13:07:46 -0700 (PDT)
Subject: Re: [PATCH v3 15/16] hw/i386/vmport: Add support for CMD_GETHZ
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-16-liran.alon@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <97784452-8270-e0ab-1164-d3a9fe567006@redhat.com>
Date: Fri, 13 Mar 2020 21:07:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312165431.82118-16-liran.alon@oracle.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: pbonzini@redhat.com, Nikita Leshenko <nikita.leshchenko@oracle.com>,
 rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 5:54 PM, Liran Alon wrote:
> This command returns to guest information on LAPIC bus frequency and TSC
> frequency.
> 
> One can see how this interface is used by Linux vmware_platform_setup()
> introduced in Linux commit 88b094fb8d4f ("x86: Hypervisor detection and
> get tsc_freq from hypervisor").
> 
> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>   hw/i386/vmport.c         | 19 +++++++++++++++++++
>   include/hw/i386/vmport.h |  1 +
>   2 files changed, 20 insertions(+)
> 
> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> index 1664a6b97332..9d3921cf418d 100644
> --- a/hw/i386/vmport.c
> +++ b/hw/i386/vmport.c
> @@ -176,6 +176,24 @@ static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
>       return ram_size;
>   }
>   
> +static uint32_t vmport_cmd_get_hz(void *opaque, uint32_t addr)
> +{
> +    X86CPU *cpu = X86_CPU(current_cpu);
> +
> +    if (cpu->env.tsc_khz && cpu->env.apic_bus_freq) {
> +        uint64_t tsc_freq = (uint64_t)cpu->env.tsc_khz * 1000;
> +
> +        cpu->env.regs[R_ECX] = cpu->env.apic_bus_freq;
> +        cpu->env.regs[R_EBX] = (uint32_t)(tsc_freq >> 32);
> +        cpu->env.regs[R_EAX] = (uint32_t)tsc_freq;
> +    } else {
> +        /* Signal cmd as not supported */
> +        cpu->env.regs[R_EBX] = UINT32_MAX;
> +    }
> +
> +    return cpu->env.regs[R_EAX];
> +}
> +
>   static uint32_t vmport_cmd_time(void *opaque, uint32_t addr)
>   {
>       X86CPU *cpu = X86_CPU(current_cpu);
> @@ -265,6 +283,7 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
>       if (s->compat_flags & VMPORT_COMPAT_CMDS_V2) {
>           vmport_register(VMPORT_CMD_GETBIOSUUID, vmport_cmd_get_bios_uuid, NULL);
>           vmport_register(VMPORT_CMD_GETTIME, vmport_cmd_time, NULL);
> +        vmport_register(VMPORT_CMD_GETHZ, vmport_cmd_get_hz, NULL);
>           vmport_register(VMPORT_CMD_GETTIMEFULL, vmport_cmd_time_full, NULL);
>           vmport_register(VMPORT_CMD_GET_VCPU_INFO, vmport_cmd_get_vcpu_info,
>                           NULL);
> diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
> index 34cc050b1ffa..aee809521aa0 100644
> --- a/include/hw/i386/vmport.h
> +++ b/include/hw/i386/vmport.h
> @@ -12,6 +12,7 @@ typedef enum {
>       VMPORT_CMD_VMMOUSE_DATA     = 39,
>       VMPORT_CMD_VMMOUSE_STATUS   = 40,
>       VMPORT_CMD_VMMOUSE_COMMAND  = 41,
> +    VMPORT_CMD_GETHZ            = 45,

Can you rename to something easier to read, such _GET_FREQS_HZ or nicer?

>       VMPORT_CMD_GETTIMEFULL      = 46,
>       VMPORT_CMD_GET_VCPU_INFO    = 68,
>       VMPORT_ENTRIES
> 


