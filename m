Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEB4C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30DF32072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZ00OMtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DF32072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoda-0007RV-4t
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDoc9-0005xL-N5; Thu, 03 Sep 2020 08:45:17 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDoc7-0001aI-V8; Thu, 03 Sep 2020 08:45:17 -0400
Received: by mail-wm1-x343.google.com with SMTP id a9so2754017wmm.2;
 Thu, 03 Sep 2020 05:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sPLoQJtAT4WBik7hhQYuT1/Cfi/FzdvLnONFwteKS3s=;
 b=aZ00OMtrqESRinocvNrK067GvDqSoDJO71dDpkZLcu/JUIjw13X6ca0FX/fzvETGm4
 koLX688vfdHcPoqHIgZX9rfRKwMfrXp+w8UvRaiV1FHaaFR+Nb04Tq+lwSohK5cZkHZh
 95X+dbs/06JP5w5HFywMzduuKqkSwfjChuNecSdJhGL5K/nIqYJLW1lU9QojNoER2Hgw
 FLdTKTcQcDKHAAesZlMV2tqpgOrfyR6e2PKKdq960Sd7M+98qMYpf5+gVMJkumwGWz38
 VKuITd28nvT5Uvk96WRYTBETbovNNbGyWAaNXBpKC0iOKSNZ8ugVVBaME41C4AE8da89
 ojgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sPLoQJtAT4WBik7hhQYuT1/Cfi/FzdvLnONFwteKS3s=;
 b=tZT2ZLWDaKfOkLbQAymLIGxLuYR/Nu0e0GEbS8YQExszKo7wfiARG9iWNPeo1P1ycQ
 CZqTyAWOKDVYT7MA//TiWJ6IRc92i1SEKFyUgPMuT90UTZ5NyQWURVWje/W6I0xJ4f+G
 aFY9D+bZ63yiU2Of8vegthvA4RhQxnh3Jy6SEzSsMQpl5EdXNKWvsI+JZJ92jFHx29cP
 H63oYDrlBtuY95S43JfOaa19Zt3c08cuhJCz3pufeMv5ag9ZZvdnRHMbvryTe1P1OeyM
 Zox7Og7LSItEbUggEsjVPGxSvveL0d1ANKzmNKZqVy8vOhTWkJvz/b6NwuHZ9jAuM1sI
 3N2Q==
X-Gm-Message-State: AOAM530Xgrtqa5g9aaz8vatIsFBPjz+2MYeNRoxGsxL8iQ628NW7evsk
 mECbPWWT+pIGAgavVsyCwxQ=
X-Google-Smtp-Source: ABdhPJzf1xX/iKQCTf2and0//HxwaoYDzs5CRhEGdeMro8MeVT0EM5BdQYv9+L6sVAY5oy/oOZ7gPg==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr2290315wmg.164.1599137114150; 
 Thu, 03 Sep 2020 05:45:14 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id w21sm4294799wmk.34.2020.09.03.05.45.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 05:45:13 -0700 (PDT)
Subject: Re: [PATCH 20/63] pc87312: Rename TYPE_PC87312_SUPERIO to TYPE_PC87312
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-21-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2863f7ea-6fde-5a2e-b55f-e805f5db35be@amsat.org>
Date: Thu, 3 Sep 2020 14:45:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902224311.1321159-21-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.403,
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
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 12:42 AM, Eduardo Habkost wrote:
> This will make the type name constant consistent with the name of
> the type checking macro.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: "Hervé Poussineau" <hpoussin@reactos.org>
> Cc: qemu-ppc@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  include/hw/isa/pc87312.h | 4 ++--
>  hw/isa/pc87312.c         | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/isa/pc87312.h b/include/hw/isa/pc87312.h
> index a65168a157..da8dc5ddf5 100644
> --- a/include/hw/isa/pc87312.h
> +++ b/include/hw/isa/pc87312.h
> @@ -29,10 +29,10 @@
>  #include "qom/object.h"
>  
>  
> -#define TYPE_PC87312_SUPERIO "pc87312"
> +#define TYPE_PC87312 "pc87312"

We loose self-documentation. What is a TYPE_PC87312
when reviewing a board setup code? Should we add a
comment /* Create the Super I/O */? The current name
is self-describing...

Is it easier to rename the type as 'pc87312-superio'?

   #define TYPE_PC87312_SUPERIO "pc87312-superio"

>  typedef struct PC87312State PC87312State;
>  DECLARE_INSTANCE_CHECKER(PC87312State, PC87312,
> -                         TYPE_PC87312_SUPERIO)
> +                         TYPE_PC87312)
>  
>  struct PC87312State {
>      /*< private >*/
> diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
> index 0cacbbc91b..8d7b8d3db2 100644
> --- a/hw/isa/pc87312.c
> +++ b/hw/isa/pc87312.c
> @@ -371,7 +371,7 @@ static void pc87312_class_init(ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo pc87312_type_info = {
> -    .name          = TYPE_PC87312_SUPERIO,
> +    .name          = TYPE_PC87312,
>      .parent        = TYPE_ISA_SUPERIO,
>      .instance_size = sizeof(PC87312State),
>      .instance_init = pc87312_initfn,
> 


