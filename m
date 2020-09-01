Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA1CC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 519B5206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vl+F7pjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519B5206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3IR-0006BQ-Gg
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD39A-0005ZW-NK; Tue, 01 Sep 2020 06:04:12 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD397-000542-CA; Tue, 01 Sep 2020 06:04:12 -0400
Received: by mail-wr1-x441.google.com with SMTP id c18so811364wrm.9;
 Tue, 01 Sep 2020 03:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1M9Jaqvo6r7BX6FEljqlQp1pDlkpsFMcYy47H0RrXEM=;
 b=Vl+F7pjrsg3TaRXO5j3nx5Y5+/CoZomCkr7K6bzmphswSnGd5W6xIXpyYbHuY+4T1O
 YLrx9WRUs/a0QGuK2svjaRjtw2kcvGNL0/X44ewzeI5y1cC4hUmCCpCztjMq4e6uWFd2
 hCZded5izm/NNVxMqEuf3i1xTnKNhmUdR8Q6cxyVV10sKtKdvLhWcpCDW+q8u8WW4LBX
 AIkGQlzXni5fGfiPibGtDLxhs7t/yPbGYbZAQlWg+K8YZZWmxkLZNiGXc/l8v3QI5z81
 goOc1DXzBKBAJPl/Uk1JMxMtAYkSx4OKs+t8VTteQwB/TQZGGUN2EnSezsu0tuSxAgTp
 wgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1M9Jaqvo6r7BX6FEljqlQp1pDlkpsFMcYy47H0RrXEM=;
 b=JdZl8ZpZ0sH1FYHUupmroDQSVX1NtF3xhTDPtIal9l1YUKZdfKgEAEcSep59zF8qWv
 XKsu7peFzcLiAFWtHi0qEQRPoYZSQTlUukiW/aZ09V2wA4n2ZeaxWWOq5RL11FHrUKJX
 eYIcUiWPCLUtjXkJL47Kofp3PaVISLLC656mewPMeph1KrWeZjWGro+5LT047k48H+3C
 2rvARnTH9FKQQYUQUidpIsTAh6SNrjhcAwfw/hicOjgX4b/0EePNq7KQ0k3KZrqqi1F7
 G4RG+8Mjqzo9NtvkFA8YK04YNryXJJsyOxrCJQYtik6Cz9PRcqrqGcoEOLXrMrKTdbak
 GC7g==
X-Gm-Message-State: AOAM533vIUnWdK3YUvuzb9XZT/g1UUk1OiJudXdV2mvDlq0uEiW40c5d
 AIOoF8DN3iGSPLGHwbspWegmeXdYgCI=
X-Google-Smtp-Source: ABdhPJwmF9/zukIvZ6IwRhTzT+yvqvcd2qd4ScSvxryDt2uLiDIvYmrCi/Hm/Ct/3O+iduylQGe5yQ==
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr1022685wro.362.1598954646947; 
 Tue, 01 Sep 2020 03:04:06 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id k13sm1179219wmj.14.2020.09.01.03.04.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 03:04:06 -0700 (PDT)
Subject: Re: [Bug 1892540] [RFC PATCH v2] hw/display/tcx: Allow 64-bit
 accesses to framebuffer stippler and blitter
To: mst@redhat.com, Bug 1892540 <1892540@bugs.launchpad.net>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
References: <159803735569.2614.10182276398047269277.malonedeb@chaenomeles.canonical.com>
 <20200822142127.1316231-1-f4bug@amsat.org>
 <20200830021257-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2656bffb-9717-2d41-29d2-98334c0a8180@amsat.org>
Date: Tue, 1 Sep 2020 12:04:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200830021257-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200901100405.mDTUPfTLt2T8ynJ4_MgSxPNz0WoWZMnG9I-X_xc6TCM@z>

On 8/30/20 8:18 AM, mst@redhat.com wrote:
> On Sat, Aug 22, 2020 at 02:21:27PM -0000, Philippe Mathieu-DaudÃƒÆ’Ã‚Â© wrote:
>> The S24/TCX datasheet is listed as "Unable to locate" on [1].
>>
>> However the NetBSD revision 1.32 of the driver introduced
>> 64-bit accesses to the stippler and blitter [2]. It is safe
>> to assume these memory regions are 64-bit accessible.
>> QEMU implementation is 32-bit, so fill the 'impl' fields.
>>
>> [1] http://web.archive.org/web/20111209011516/http://wikis.sun.com/display/FOSSdocs/Home
>> [2] http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/sbus/tcx.c.diff?r1=1.31&r2=1.32
>>
>> Reported-by: Andreas Gustafsson <gson@gson.org>
>> Buglink: https://bugs.launchpad.net/bugs/1892540
>> Fixes: 55d7bfe2293 ("tcx: Implement hardware acceleration")
>> Signed-off-by: Philippe Mathieu-DaudÃƒÆ’Ã‚Â© <f4bug@amsat.org>
> 
> Philippe, did you submit the patch on the mailing list
> normally too? I don't seem to see it there.

Yes, Message-id: <20200822142127.1316231-1-f4bug@amsat.org>
https://www.mail-archive.com/qemu-devel@nongnu.org/msg732515.html

> 
> the patch seems to work for me:
> 
> Tested-by: Michael S. Tsirkin <mst@redhat.com>

Thanks!

> 
> 
> CC Nathan who reported a similar failure.
> 
> Nathan, does the patch below fix the issue for you?
> 
>> ---
>> Since v1:
>> - added missing uncommitted staged changes... (tcx_blit_ops)
>> ---
>  hw/display/tcx.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
> index 1fb45b1aab8..96c6898b149 100644
> --- a/hw/display/tcx.c
> +++ b/hw/display/tcx.c
> @@ -548,20 +548,28 @@ static const MemoryRegionOps tcx_stip_ops = {
>      .read = tcx_stip_readl,
>      .write = tcx_stip_writel,
>      .endianness = DEVICE_NATIVE_ENDIAN,
> -    .valid = {
> +    .impl = {
>          .min_access_size = 4,
>          .max_access_size = 4,
>      },
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +    },
>  };
>  
>  static const MemoryRegionOps tcx_rstip_ops = {
>      .read = tcx_stip_readl,
>      .write = tcx_rstip_writel,
>      .endianness = DEVICE_NATIVE_ENDIAN,
> -    .valid = {
> +    .impl = {
>          .min_access_size = 4,
>          .max_access_size = 4,
>      },
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +    },
>  };
>  
>  static uint64_t tcx_blit_readl(void *opaque, hwaddr addr,
> @@ -650,10 +658,14 @@ static const MemoryRegionOps tcx_rblit_ops = {
>      .read = tcx_blit_readl,
>      .write = tcx_rblit_writel,
>      .endianness = DEVICE_NATIVE_ENDIAN,
> -    .valid = {
> +    .impl = {
>          .min_access_size = 4,
>          .max_access_size = 4,
>      },
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +    },
>  };
>  
>  static void tcx_invalidate_cursor_position(TCXState *s)
> 
> 
> -----------------------------------------------------------
> 
> I think you shouldn't specify .min_access_size in impl, since
> that also allows 1 and 2 byte accesses from guest.
> 
> 
> 
>> -- 
>> 2.26.2
>>
>> -- 
>> You received this bug notification because you are subscribed to the bug
>> report.
>> https://bugs.launchpad.net/bugs/1892540
>>
>> Title:
>>   qemu can no longer boot NetBSD/sparc
>>
>> Status in QEMU:
>>   New
>>
>> Bug description:
>>   Booting NetBSD/sparc in qemu no longer works.  It broke between qemu
>>   version 5.0.0 and 5.1.0, and a bisection identified the following as
>>   the offending commit:
>>
>>     [5d971f9e672507210e77d020d89e0e89165c8fc9] memory: Revert "memory:
>>   accept mismatching sizes in memory_region_access_valid"
>>
>>   It's still broken as of 7fd51e68c34fcefdb4d6fd646ed3346f780f89f4.
>>
>>   To reproduce, run
>>
>>     wget http://ftp.netbsd.org/pub/NetBSD/NetBSD-9.0/images/NetBSD-9.0-sparc.iso
>>     qemu-system-sparc -nographic -cdrom NetBSD-9.0-sparc.iso -boot d
>>
>>   The expected behavior is that the guest boots to the prompt
>>
>>     Installation medium to load the additional utilities from:
>>
>>   The observed behavior is a panic:
>>
>>     [   1.0000050] system[0]: trap 0x29: pc=0xf0046b14 sfsr=0xb6 sfva=0x54000000
>>     [   1.0000050] cpu0: data fault: pc=0xf0046b14 addr=0x54000000 sfsr=0xb6<PERR=0x0,LVL=0x0,AT=0x5,FT=0x5,FAV,OW>
>>     [   1.0000050] panic: kernel fault
>>     [   1.0000050] halted
>>
>> To manage notifications about this bug go to:
>> https://bugs.launchpad.net/qemu/+bug/1892540/+subscriptions
> 
> 


