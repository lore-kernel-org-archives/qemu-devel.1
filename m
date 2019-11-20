Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677CAC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 22:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 382E3206D8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 22:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382E3206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXYwz-0005jH-CN
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 17:59:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iXYvr-0005EC-Vp
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 17:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iXYvq-0003v0-Pp
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 17:58:43 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:53475)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iXYvq-0003u4-Gs
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 17:58:42 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MmDZI-1i73nB3Swy-00iGXH; Wed, 20 Nov 2019 23:58:06 +0100
Subject: Re: [PATCH v4 25/37] dp8393x: replace PROP_PTR with PROP_LINK
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-26-marcandre.lureau@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7bd76794-9064-5a80-258c-519d6c784181@vivier.eu>
Date: Wed, 20 Nov 2019 23:58:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120152442.26657-26-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XStuWuHWu8e8HOGD4V15CcbGWtWQ5B70ODBEH94rtU2OhWNB1D9
 WXhs7lY8SaGRB2zxwkxaP/EFrwZr/rNuzrmyhSeiIPc20MIFOva0Wq78JlzI4lErxk1sdam
 kty5+etuPQ4fgjD6F/uEW5RgSrbr02yydOHGWp5628wi2mWkWwlJSDrUKljBPCernqXhibm
 4d8un44bMpP1EKD2RL5Pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nTWBq2O4ovc=:xFn5vWv5/8fz7YagNjyNLH
 UzBnEBAoUg7pUgA10bcKB6TdVFGDiKrps1nOsfPJI1nHo41JRIpcyHaUneVlBBejYXm3Kpm+9
 9iCMD9ZvNeF2VXIKItQVUaUFeeuhin6HQ1ssCVUEWGvWyZuFQJfULP+FLo0JBz7gWQzohVjhE
 gU16qr0doucHBEsHEPkU31Gc1qdFe+PYtgx4xWtoIJWF9HLW3R0Ppe78nzZG0v8uYcHIawi3s
 VtYQ/rLe3Z4f5Dsmfn1c7GCGPW9zGdZId4EwjwGGRP6a24aE7MYrmn2RQ0ckNoCvH4hFhBzUU
 UuppSWy1+90tOiPXYPClXYJlTJk5WJUniF626+TWF17Es4ThqhTyeLWd4YMJO8fQor7h2iC59
 78iDF4GRXKGCrIGkbn5wA4BmNurqf87eKvHteuRCbPsIFzaz1ahS+JkI+z9dwH7ZvMg1lbi8U
 nPGwPLpO4J4DL9lUI3lqnPMS3VL/LoD/J9BmbsXFb94dFecIDtun7f+Ax+GbinO/TzrtlHeIp
 CvJgEDBbGT34WfOzH+Caxu8jbpzbUKc1A1ILZm4SRT6bAq5ioMtwVi9eAKolAva843XRUUOtU
 Wzn27H16VplomVndIJnWVILLFkUM0TFk/aaO64++rvsq3sWpO2aAB9/iSPltzR12JCFxrrffe
 ERGxLCHxKnXhRUo1UwZcY+A7csoPRnVHkq8s37EczqcZmuxt9usj5szZdhVS6+0ir2nGFGPdC
 txM9+4UOIWMPKnnjGmOmKLl4mAP9jkVSMIzu+Lknbw1Wn9GJKtyKOXQup+k15xSuJol4T3b5U
 lJzBYN/xshBYrteC6s8wRqfPD1paP4fkfOuDzjD3wQEEJns2PPBC41I50f9NSZgoREISwiTsM
 qnoLavdrtXpJ5vbRzVI4RkT4deMzMQOxUfCUn+f44=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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
Cc: peter.maydell@linaro.org, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 20/11/2019 à 16:24, Marc-André Lureau a écrit :
> Link property is the correct way to pass a MemoryRegion to a device
> for DMA purposes.
> 
> Sidenote: as a sysbus device, this remains non-usercreatable
> even though we can drop the specific flag here.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/m68k/q800.c      | 3 ++-
>  hw/mips/mips_jazz.c | 3 ++-
>  hw/net/dp8393x.c    | 7 +++----
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 4ca8678007..8f3eb6bfe7 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -239,7 +239,8 @@ static void q800_init(MachineState *machine)
>      qdev_set_nic_properties(dev, &nd_table[0]);
>      qdev_prop_set_uint8(dev, "it_shift", 2);
>      qdev_prop_set_bit(dev, "big_endian", true);
> -    qdev_prop_set_ptr(dev, "dma_mr", get_system_memory());
> +    object_property_set_link(OBJECT(dev), OBJECT(get_system_memory()),
> +                             "dma_mr", &error_abort);
>      qdev_init_nofail(dev);
>      sysbus = SYS_BUS_DEVICE(dev);
>      sysbus_mmio_map(sysbus, 0, SONIC_BASE);
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index d978bb64a0..1518eb5e55 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -284,7 +284,8 @@ static void mips_jazz_init(MachineState *machine,
>              dev = qdev_create(NULL, "dp8393x");
>              qdev_set_nic_properties(dev, nd);
>              qdev_prop_set_uint8(dev, "it_shift", 2);
> -            qdev_prop_set_ptr(dev, "dma_mr", rc4030_dma_mr);
> +            object_property_set_link(OBJECT(dev), OBJECT(rc4030_dma_mr),
> +                                     "dma_mr", &error_abort);
>              qdev_init_nofail(dev);
>              sysbus = SYS_BUS_DEVICE(dev);
>              sysbus_mmio_map(sysbus, 0, 0x80001000);
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index 3d991af163..cdc2631c0c 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -175,7 +175,7 @@ typedef struct dp8393xState {
>      int loopback_packet;
>  
>      /* Memory access */
> -    void *dma_mr;
> +    MemoryRegion *dma_mr;
>      AddressSpace as;
>  } dp8393xState;
>  
> @@ -948,7 +948,8 @@ static const VMStateDescription vmstate_dp8393x = {
>  
>  static Property dp8393x_properties[] = {
>      DEFINE_NIC_PROPERTIES(dp8393xState, conf),
> -    DEFINE_PROP_PTR("dma_mr", dp8393xState, dma_mr),
> +    DEFINE_PROP_LINK("dma_mr", dp8393xState, dma_mr,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
>      DEFINE_PROP_UINT8("it_shift", dp8393xState, it_shift, 0),
>      DEFINE_PROP_BOOL("big_endian", dp8393xState, big_endian, false),
>      DEFINE_PROP_END_OF_LIST(),
> @@ -963,8 +964,6 @@ static void dp8393x_class_init(ObjectClass *klass, void *data)
>      dc->reset = dp8393x_reset;
>      dc->vmsd = &vmstate_dp8393x;
>      dc->props = dp8393x_properties;
> -    /* Reason: dma_mr property can't be set */
> -    dc->user_creatable = false;
>  }
>  
>  static const TypeInfo dp8393x_info = {
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>

