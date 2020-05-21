Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BFAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C06DF207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qa2gv22t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06DF207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmVe-00060N-VF
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jbmUm-0003Vq-6W; Thu, 21 May 2020 10:48:28 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37680)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jbmUl-0002zd-Dy; Thu, 21 May 2020 10:48:27 -0400
Received: by mail-wr1-x441.google.com with SMTP id l17so6936929wrr.4;
 Thu, 21 May 2020 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qtqsvHSuQJOeViteiq/MtRUnB7haRBW+2sGnGMz0WjU=;
 b=qa2gv22tktvN6xWz+JvHriUfsxu6V7HwuEvTE/zCLJ9OrgULjqjhhQI96eFqm4zrt+
 4mFC8BXFYOSVJooyi2IGP3eMhfdyoI+u/bUp1Z8jdSbwSpnbg7WU6N0FvDJ6be9mVzKj
 qk4Mh2RBj3YF+c9dG+x3b16geEoYte13NZBQPPmQFOyj5Udwfg6frGCWYnysBVtk/R0w
 yGmLVYOAWlx3GMYWoiSsSvNib+LvFaX3yfsJoY76sC2zva+Y9znGWuSScjqMhehkiPxd
 nOlyv4pExHhrwKCCGTEc2VFUqYnvUS4sAPC7+CZMgAK4iIEj9YtZ01foZ3kfEl+wqIMo
 ryhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qtqsvHSuQJOeViteiq/MtRUnB7haRBW+2sGnGMz0WjU=;
 b=E7tTshopj9l17VXwV0KyTYc6PADmCC6o5d/jU1mK6cX+dA/GRX2t7dHXWxPNUKIfGI
 ptiMKnewkOZMlC+POlO5Nrz/Mjvvn3Wb98sdXGZ5GyYlT9B9lH4HtracXiRvJ2XJknxJ
 zmYLe5MLOfaGx9DY5BWyKTBjbz2jwpbxNpv3vVWA6NpYgStSLUFmV1qou4Ophp9y4oam
 iqsfdzo7aYVAJGWkaX2m8c6PJbHMPgEiqz32fpVA9y9GMFZJJUCynE7Da5icOOzGczfK
 6ibJnkyrcnHCT1YqeYemmDxzn9v+z8tuSC4zH8CVY+MdxwRidaGUbXXUS9/XEMBl6w/L
 ykAQ==
X-Gm-Message-State: AOAM531WRs6mXIKWFPLSQl0ui5Ck7m4HzSma+1pcMOyGL+7J61sD0Vyk
 ZFH0iu0AEWbCrHfrnNaZYR4=
X-Google-Smtp-Source: ABdhPJznZ+5w9gdiy840MRgex5+n6SH9W7MRaABcBBZXiAzrDiVgz+bzyy6ZniKG/HNvyGHauqsQkg==
X-Received: by 2002:adf:ce05:: with SMTP id p5mr9322045wrn.423.1590072505176; 
 Thu, 21 May 2020 07:48:25 -0700 (PDT)
Received: from [192.168.1.40] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id b12sm7123853wmj.0.2020.05.21.07.48.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 07:48:24 -0700 (PDT)
Subject: Re: [PATCH 1/2] hw/riscv: sifive_u: Remove the riscv_ prefix of the
 soc* functions
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <1590072147-13035-1-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c6fba5b7-1191-29bf-a4b7-4707efecb973@amsat.org>
Date: Thu, 21 May 2020 16:48:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1590072147-13035-1-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/20 4:42 PM, Bin Meng wrote:
> From: Bin Meng <bin.meng@windriver.com>
> 
> To keep consistency with the machine* functions, remove the riscv_
> prefix of the soc* functions.
> 
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
> 
>   hw/riscv/sifive_u.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 4299bdf..f9fef2b 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -481,7 +481,7 @@ static void sifive_u_machine_init_register_types(void)
>   
>   type_init(sifive_u_machine_init_register_types)
>   
> -static void riscv_sifive_u_soc_init(Object *obj)
> +static void sifive_u_soc_instance_init(Object *obj)
>   {
>       MachineState *ms = MACHINE(qdev_get_machine());
>       SiFiveUSoCState *s = RISCV_U_SOC(obj);
> @@ -520,7 +520,7 @@ static void riscv_sifive_u_soc_init(Object *obj)
>                             TYPE_CADENCE_GEM);
>   }
>   
> -static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
> +static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>   {
>       MachineState *ms = MACHINE(qdev_get_machine());
>       SiFiveUSoCState *s = RISCV_U_SOC(dev);
> @@ -635,32 +635,32 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>           memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
>   }
>   
> -static Property riscv_sifive_u_soc_props[] = {
> +static Property sifive_u_soc_props[] = {
>       DEFINE_PROP_UINT32("serial", SiFiveUSoCState, serial, OTP_SERIAL),
>       DEFINE_PROP_END_OF_LIST()
>   };
>   
> -static void riscv_sifive_u_soc_class_init(ObjectClass *oc, void *data)
> +static void sifive_u_soc_class_init(ObjectClass *oc, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(oc);
>   
> -    device_class_set_props(dc, riscv_sifive_u_soc_props);
> -    dc->realize = riscv_sifive_u_soc_realize;
> +    device_class_set_props(dc, sifive_u_soc_props);
> +    dc->realize = sifive_u_soc_realize;
>       /* Reason: Uses serial_hds in realize function, thus can't be used twice */
>       dc->user_creatable = false;
>   }
>   
> -static const TypeInfo riscv_sifive_u_soc_type_info = {
> +static const TypeInfo sifive_u_soc_type_info = {
>       .name = TYPE_RISCV_U_SOC,
>       .parent = TYPE_DEVICE,
>       .instance_size = sizeof(SiFiveUSoCState),
> -    .instance_init = riscv_sifive_u_soc_init,
> -    .class_init = riscv_sifive_u_soc_class_init,
> +    .instance_init = sifive_u_soc_instance_init,
> +    .class_init = sifive_u_soc_class_init,
>   };
>   
> -static void riscv_sifive_u_soc_register_types(void)
> +static void sifive_u_soc_register_types(void)
>   {
> -    type_register_static(&riscv_sifive_u_soc_type_info);
> +    type_register_static(&sifive_u_soc_type_info);
>   }
>   
> -type_init(riscv_sifive_u_soc_register_types)
> +type_init(sifive_u_soc_register_types)
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


