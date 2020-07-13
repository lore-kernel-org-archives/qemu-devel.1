Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99F3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C462067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAIBGyhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C462067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jutsI-0003ao-ON
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jutrU-0002eA-3n; Mon, 13 Jul 2020 04:30:56 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42088)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jutrS-0007Rm-J0; Mon, 13 Jul 2020 04:30:55 -0400
Received: by mail-wr1-x444.google.com with SMTP id o11so14957011wrv.9;
 Mon, 13 Jul 2020 01:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AdRCZyV4A0XbB87bUYhILTzVzYYo/O7Upm1y5jzAz/U=;
 b=eAIBGyhSxu7j71iedtmaByYStpM2ehAwaa8VhVA47zpdbPXbU8DN7GbOQ2e4sOMGHo
 yJfyl6n08rwKTjGIST3kN3iILffTyeDrNaOHYs2L0Dy+aLc2EZeooMV5EUjJiSp+VdKY
 uDHigv2P6YL3MiepPVOZ0wWr0/QP7+YpKhGowwDx9UQ2xEGkkYcW5ctBPr2rZVVj1Hh2
 mLLjwJ+W30gFZdbX1lj6g3SljpLxmqnp37Jfabs5nmNGtEwR4cgSYtDowg483XXDBKUd
 w/XfgQJc+ybisMR1S3/DXuXoEm0i9xn0XzD1NMLP6HWV0jEcNjj7oOXcS14N0Al29q/+
 Rm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AdRCZyV4A0XbB87bUYhILTzVzYYo/O7Upm1y5jzAz/U=;
 b=Zf11pnO4TARKX0lfVs3N+wx3avkrHImM4ox2Wk2L53mnWSixuhVutmtr9Mdf0hvxPU
 8shwsxZ8BTrOpWGaf+yiyj5NTke9IbjGgnO7UaK6ymCatqoMd9gJdUxM1xH3PWMe2q4x
 fdo1h3lxDMoFJKH8wrg0v/HZULhWTyP2ZtchEob0fNH7XdmU5MJsuvXuY8IgkKbIHcRz
 jzgDKp+cjS9j8PZvbXrq3nuwiw+iX849qXJhH2xB3xsE5U/30dD/7loKbbH9ejdlndGm
 9FoAF6sRlfFK423UCh7OS4M3Q9rCh1nJJiO8M03jKL2IxsrZSrd2ObXYPwIo4fcoT2Yv
 NhIw==
X-Gm-Message-State: AOAM531rxt9KpuJUbVxMNkCV45J6dpAKqALhCNnKvIwBEXDptQKjeM+j
 a1qsGMWPfIJ88A3Dt+pp+U6mtFRk0zI=
X-Google-Smtp-Source: ABdhPJwEvAKgtFbz+2KI/Col8WB8HnZMQb52o1zrau1LN8elcf2Az8j4MCK8nqUhRrdi+5FH0xgtOA==
X-Received: by 2002:a5d:68c7:: with SMTP id p7mr82779063wrw.16.1594629052485; 
 Mon, 13 Jul 2020 01:30:52 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id e23sm20719280wme.35.2020.07.13.01.30.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 01:30:51 -0700 (PDT)
Subject: Re: hw/misc/aspeed_scu: 5d971f9e breaks Supermicro AST2400
To: Erik Smit <erik.lucas.smit@gmail.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>
References: <CA+MHfoubt1g2FzcjTw3a0vNr7X2T8Jb+nYoc4_x=Z2TP51afKg@mail.gmail.com>
 <a7acba46-5a9a-5dd2-71c6-7e4586485823@amsat.org>
 <CA+MHfot6FdS2yT0mEsCW36bCfwy-WY-1KPQ-KDfYBKzTy=Gd7w@mail.gmail.com>
 <CACPK8Xdqr+EufMgooCY=D+Vt98qu11YTHE5Fzi5+xqX=wKReeQ@mail.gmail.com>
 <CA+MHfouin6Zmz+GrjWRCc_WzPF=ff-z_5V7BLv0HkL+SW9bRoQ@mail.gmail.com>
 <8879bfee-752b-c4e2-7646-c42dec84a440@kaod.org>
 <CA+MHfou6ijtwjzWye6CKaqTa4sKxF1WmgH9juaSdO344uP2UZA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ff328764-870b-7074-ac24-43421f3c95cc@amsat.org>
Date: Mon, 13 Jul 2020 10:30:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CA+MHfou6ijtwjzWye6CKaqTa4sKxF1WmgH9juaSdO344uP2UZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 10:06 AM, Erik Smit wrote:
> Hi Cédric,
> 
> On Mon, 13 Jul 2020 at 09:52, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> With this patch, the supermicro firmware boots further but there is still
>> an issue. It might be the flash definition I used. The machine is detected
>> as an AST2300 SoC which is weird.
> 
>> BMC flash ID:0x19ba20
>> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> 
> The firmware is expecting the flash ID to repeat.

At what address?

> The following makes it boot.
> Not sure if this is the right way to go.
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 8227088441..5000930800 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -1041,7 +1041,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>              s->data[i] = s->pi->id[i];
>          }
>          for (; i < SPI_NOR_MAX_ID_LEN; i++) {
> -            s->data[i] = 0;
> +            s->data[i] = s->pi->id[i % s->pi->id_len];

Interesting. It makes sense to read the ID repeated (not sure
your patch is the safest way to do it).

I can't find the time to add a generic NOR flash device :/

>          }
> 
>          s->len = SPI_NOR_MAX_ID_LEN;
> 


