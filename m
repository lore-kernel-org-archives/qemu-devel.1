Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B443CC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 10:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A2F204EC
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 10:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJUKRK30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A2F204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Qix-000708-Ms
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 06:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Qhw-0006Pi-OD
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 06:25:08 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Qhu-0003ZW-N6
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 06:25:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id x9so97764wmi.2
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 03:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Xe2PzOPGvkUvTzXVHYH+k/HFeSwieGyGTyF9CuKPCfA=;
 b=QJUKRK30gEtJxbVBKTPTH71JMoOBjQlHofc+OrDEXpka2tzaAOFCoXpXKOMvQUHPvB
 P9GNtoXovBpe9c3xdTkgZuh4I31BuhkNFnJEXcQiNIut/ThjNIGW/b7yCniQP2uOk8Ou
 XtWA/EvFY8gOOfAZsEPFV4XQDE79rRXyuZzCeA4o+FEVnjUNjUImrrSE+bm2GiGMmvW2
 tT7rJWUqWNEw6lMPGiqbq+/AFfunQtcTrw8IyCOCceJQ4Khkg0PZsv0CNHP9BlJai4As
 KVGDh3e/GVW+8psFPUCu5kg4Zo43BKM7HgGIjr7enyKTezSJgjv2TKftDvmIcYTB02aN
 YMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xe2PzOPGvkUvTzXVHYH+k/HFeSwieGyGTyF9CuKPCfA=;
 b=OA+ifQld0FSrR5BIByzi5q5eUyjzhSsCyBla+Jy/nHkUTfhkksJyTidTWzBunHoTla
 AIJQ8xMHI7lcPDvmQXlgl+r5qtg9n2LGE2ETGQ6CMqH2MVVsEPRg3dCxLePhVrDWJRUL
 K+HcuA6Hs5cpOKci8VujFFufgS6HtXcYgp/5odg01GffGnlqTKdS7y7xlKF5XDZuLDT0
 TOZc4E31OSl+zugsy4Wg5KG3e8ckRPh1ECF6QreToeseFSVW5gmKcx4hQax7Hzo5nyOd
 etKfiHvjmVBpHWMhqbXSNkt3kKzF92WycYNwQbi2GC72a1ym071DvG2Wpr+4A0lfTTgg
 Psgw==
X-Gm-Message-State: AOAM531CEPqxOK9SzopXUPeCd6b/xmJFvzdsddo4JBc2PL/5WXgdSaxR
 +p8dqtcslAldv3uFLJQk+ZhtYNVCxGE=
X-Google-Smtp-Source: ABdhPJzYYot32/CAFtN2pJtVqoQ8imHA+N7BH2dj0ZGMWGSWu6hrGzhsi5OMvxuE7qWdgF9igLkyLQ==
X-Received: by 2002:a7b:c1d0:: with SMTP id a16mr8036889wmj.111.1598091903613; 
 Sat, 22 Aug 2020 03:25:03 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id y142sm11634132wmd.3.2020.08.22.03.25.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Aug 2020 03:25:03 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] core/register: Specify instance_size in the
 TypeInfo
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 ehabkost@redhat.comg
References: <87a2da602785bce972a6a6b4502769f4fee58a2d.1598074333.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <63024ede-9d19-7292-29d6-a33da6a7177e@amsat.org>
Date: Sat, 22 Aug 2020 12:25:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87a2da602785bce972a6a6b4502769f4fee58a2d.1598074333.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On 8/22/20 7:33 AM, Alistair Francis wrote:
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/core/register.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/core/register.c b/hw/core/register.c
> index ddf91eb445..5e8e8199d0 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -180,11 +180,7 @@ void register_init(RegisterInfo *reg)
>  {
>      assert(reg);
>  
> -    if (!reg->data || !reg->access) {
> -        return;
> -    }
>  
> -    object_initialize((void *)reg, sizeof(*reg), TYPE_REGISTER);

Can we remove register_init()? Are concerned is it is declared
publicly in "hw/register.h"?

>  }
>  
>  void register_write_memory(void *opaque, hwaddr addr,
> @@ -269,13 +265,20 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
>          int index = rae[i].addr / data_size;
>          RegisterInfo *r = &ri[index];
>  
> +        if (data + data_size * index == 0 || !&rae[i]) {
> +            continue;
> +        }
> +
> +        /* Init the register, this will zero it. */
> +        object_initialize((void *)r, sizeof(*r), TYPE_REGISTER);
> +
> +        /* Set the properties of the register */
>          *r = (RegisterInfo) {
>              .data = data + data_size * index,
>              .data_size = data_size,
>              .access = &rae[i],
>              .opaque = owner,
>          };
> -        register_init(r);
>  
>          r_array->r[i] = r;
>      }
> @@ -329,6 +332,7 @@ static const TypeInfo register_info = {
>      .name  = TYPE_REGISTER,
>      .parent = TYPE_DEVICE,
>      .class_init = register_class_init,
> +    .instance_size = sizeof(RegisterInfo),
>  };
>  
>  static void register_register_types(void)
> 


