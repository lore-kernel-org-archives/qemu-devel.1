Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359DFC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 008FB2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQzeDbBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008FB2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6WeQ-0005kb-7B
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 04:37:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6Wdm-00054L-31
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6Wdk-0005xy-Tz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:36:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43979
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6Wdk-0005xd-PZ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582623391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7KjT0CTZTWIUeOqi2YG+7sHvIjQlRTpL/HxX7X+vDAY=;
 b=IQzeDbBhjYcwB2VNFIH6Vic52feookLTIq9JI0X4O3v4QR5MLO9MjFarIlXOpxf9rr79G4
 l+xWUZN/uudkCoal5kWAUs2wPFLaiDhPOOB0a/ummmf6hpCd/Bhnp4vcXcfBKUdEhvCNIG
 l7b+HIlKxjYNP4paD/Ed26cWwftAM64=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-FzhYwJAcNmWCb24YH0zT5Q-1; Tue, 25 Feb 2020 04:36:30 -0500
X-MC-Unique: FzhYwJAcNmWCb24YH0zT5Q-1
Received: by mail-ed1-f70.google.com with SMTP id g20so8648792edt.18
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 01:36:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7KjT0CTZTWIUeOqi2YG+7sHvIjQlRTpL/HxX7X+vDAY=;
 b=pYEdPbW9ETyYE8Sl9Iiti4G1fIzszmg5Bp5sEZO5MLmscI3fvawknxzhzx5H6O/7XD
 /7Lmyfx5V6KB4wmmYtxYS2v8Pmjgq3J+idI5d4ZlZ3sfTIryCrmku59spW8S7kOylHr6
 GN5fZGSYHpPfA5/MrIu8FnWlBR0l85qWha27Zy4yPOedJmIxvrmaznyiibjhFNQO5pXJ
 SADH9ouChrHMafvNM4jhrnw3eUVQP217lTdpqb+KG7qCvBub164c7cUeOBh0LprQlhTS
 +sSxKe/hX4TSRGlx2A5amW+jUsRU6aBZ2Pd0LvO6ju1jCxKhZ6/BjuO0/mBNAIgu1g+6
 vdfw==
X-Gm-Message-State: APjAAAX2N26+xJN7+9WRRBXN0YFzlD/3dTy9pk4NFwofPVQSJ7c/9Yuc
 ZX32wI0mw29S//PkU4g+my4mMMVE2HLWWNIUfI2XXgMwzzKIgOO0lxjI04k0m9N1NLKKw8yd2ns
 Wyb1xgbo4UBlehEY=
X-Received: by 2002:aa7:cf83:: with SMTP id z3mr49905219edx.166.1582623389075; 
 Tue, 25 Feb 2020 01:36:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqzw8G34c00OGWinf9NomAlCgmCvPvI8D0k+BcfH4hKWZtKlk0loLyuXeKQysTNwCTQxdSf+Bg==
X-Received: by 2002:aa7:cf83:: with SMTP id z3mr49905203edx.166.1582623388888; 
 Tue, 25 Feb 2020 01:36:28 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id j24sm1120838edr.57.2020.02.25.01.36.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 01:36:27 -0800 (PST)
Subject: Re: [PATCH 09/13] dma/xlnx-zdma: Remove redundant statement in
 zdma_write_dst()
To: kuhn.chenqun@huawei.com, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20200225020937.25028-1-kuhn.chenqun@huawei.com>
 <20200225020937.25028-10-kuhn.chenqun@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6d31ac16-adc6-235e-8784-51bf86e33b72@redhat.com>
Date: Tue, 25 Feb 2020 10:36:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225020937.25028-10-kuhn.chenqun@huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: peter.maydell@linaro.org, Alistair Francis <alistair@alistair23.me>,
 zhang.zhanghailiang@huawei.com, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 3:09 AM, kuhn.chenqun@huawei.com wrote:
> From: Chen Qun <kuhn.chenqun@huawei.com>
> 
> Clang static code analyzer show warning:
> hw/dma/xlnx-zdma.c:399:13: warning: Value stored to 'dst_type' is never read
>              dst_type = FIELD_EX32(s->dsc_dst.words[3], ZDMA_CH_DST_DSCR_WORD3,
>              ^          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> ---
>   hw/dma/xlnx-zdma.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
> index 8fb83f5b07..45355c5d59 100644
> --- a/hw/dma/xlnx-zdma.c
> +++ b/hw/dma/xlnx-zdma.c
> @@ -396,8 +396,6 @@ static void zdma_write_dst(XlnxZDMA *s, uint8_t *buf, uint32_t len)
>               zdma_load_descriptor(s, next, &s->dsc_dst);
>               dst_size = FIELD_EX32(s->dsc_dst.words[2], ZDMA_CH_DST_DSCR_WORD2,
>                                     SIZE);
> -            dst_type = FIELD_EX32(s->dsc_dst.words[3], ZDMA_CH_DST_DSCR_WORD3,
> -                                  TYPE);

Maybe move dst_type to this if() statement now?

>           }
>   
>           /* Match what hardware does by ignoring the dst_size and only using
> 


