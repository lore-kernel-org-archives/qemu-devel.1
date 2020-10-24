Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97EDC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:54:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 694A621D41
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrEHXzjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694A621D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWQYa-0004lJ-Jc
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 16:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWQXj-0004Bq-Ok
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 16:53:41 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWQXi-0006a7-7Z
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 16:53:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id i1so7098902wro.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/cOxkHqJ6DrAtDTOxCJg3SCIT93xQ5ucTpx1FyzjXh0=;
 b=BrEHXzjfjJNWbtUPWBCnfJ+kHOUQ/ZvCs2HUAaQK7+ewqmZ+XMrOWYHItYOWytBJiq
 1ZirXwOPbf3gt6WuzlYNDznw++hJN1/jGG8mX6eErWi+SgjSEdojSntZ43fcxLbj4Tqs
 9WOAqsJ5DEu6YBNZ/xghUuQ/Alyn2mSmk2xAixwV84fmIlsUFGE60z+rN4ecVdbYXDoV
 RuhnAmGMEv1esdKlx3BnoRB9FpTGM6Dx8EOwXhLtBLP3MOVDxgNxsAOZ/UGd/iPjbgqX
 UC89lSHU5NPdvdgp5sbkHmenjc++IS7SzfMzg/rVVlSEXSMe+vxZTQ4rsxMqYEWoAK8e
 mwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/cOxkHqJ6DrAtDTOxCJg3SCIT93xQ5ucTpx1FyzjXh0=;
 b=sOT2ke7d53Kb7LSusv2Fp+MvT1kvWb30Ek1twDs7+KwUk0YqG/TrzSgZudWsHFiESh
 bWg2KUuK/OVgnJugPhSsw9F231YV+/eY/oeJu0Reif8y4GbfDq0biBzmZxPOVFFZvMiy
 GyFMvQpJTUl1vPLDFvYvjYU+jfYpZnzkaCqohddiqvTbV1IelAnvh6hYOgMsvQvkt/l7
 ZOe7DxS+JxDsFHzxUxem6K4LuWy4Yi8p4aHuPVlBt9LN31Eef7Zf0s6+0WC4IZ+aY9Zi
 RS0XQBSPqpfLrNi2ljRWIaaKeiqTObdpww57peNAT4jOcAcVsreL9a0T6FuYIpCFM8ym
 KvyA==
X-Gm-Message-State: AOAM530T7A7IC1lVI3NivbBxxWczTnhN547/cf7LopukWnt3UfJlrzXx
 L9EUv3MTuPXNEQesniDKxps=
X-Google-Smtp-Source: ABdhPJxzx3DVI8AKBVpsoZWMRkvuRhMURviFChGKQ9/+ajuvQFYzi1QVlimx4L8W7R2aNiURgfICtg==
X-Received: by 2002:adf:81f4:: with SMTP id 107mr9403155wra.272.1603572816788; 
 Sat, 24 Oct 2020 13:53:36 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id n4sm12590671wrr.91.2020.10.24.13.53.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 13:53:36 -0700 (PDT)
Subject: Re: [RFC PATCH v2] hw/display/tcx: Allow 64-bit accesses to
 framebuffer stippler and blitter
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael <macallan1888@gmail.com>
References: <20200822142127.1316231-1-f4bug@amsat.org>
 <7300edf2-ab44-3676-6948-adf2c5af6c02@linaro.org>
 <20200829121341.59d8277b@glenfarclas>
 <CAAdtpL4Pi3w+5awNrohmSpySsZhmmPFQeby+a1-=TT8mJ7ZQVw@mail.gmail.com>
 <578210d0-059e-9fca-5ea9-b2cf12733f7e@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7b05c369-37c4-68c0-efae-f027e4845f90@amsat.org>
Date: Sat, 24 Oct 2020 22:53:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <578210d0-059e-9fca-5ea9-b2cf12733f7e@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Michael Lorenz <macallan@netbsd.org>, Andreas Gustafsson <gson@gson.org>,
 1892540@bugs.launchpad.net, Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/30/20 9:32 AM, Mark Cave-Ayland wrote:
> On 29/08/2020 17:45, Philippe Mathieu-Daudé wrote:
> 
>> Le sam. 29 août 2020 18:14, Michael <macallan1888@gmail.com
>> <mailto:macallan1888@gmail.com>> a écrit :
>>
>>      Hello,
>>
>>      since I wrote the NetBSD code in question, here are my 2 cent:
>>
>>      On Sat, 29 Aug 2020 08:41:43 -0700
>>      Richard Henderson <richard.henderson@linaro.org
>>      <mailto:richard.henderson@linaro.org>> wrote:
>>
>>      > On 8/22/20 7:21 AM, Philippe Mathieu-Daudé wrote:
>>      > > The S24/TCX datasheet is listed as "Unable to locate" on [1].
>>
>>      I don't have it either, but someone did a lot of reverse engineering
>>      and gave me his notes. The hardware isn't that complicated, but quite
>>      weird.
>>
>>      > > However the NetBSD revision 1.32 of the driver introduced
>>      > > 64-bit accesses to the stippler and blitter [2]. It is safe
>>      > > to assume these memory regions are 64-bit accessible.
>>      > > QEMU implementation is 32-bit, so fill the 'impl' fields.
>>
>>      IIRC the real hardware *requires* 64bit accesses for stipple and
>>      blitter operations to work. For stipples you write a 64bit word into
>>      STIP space, the address defines where in the framebuffer you want to
>>      draw, the data contain a 32bit bitmask, foreground colour and a ROP.
>>      BLIT space works similarly, the 64bit word contains an offset were to
>>      read pixels from, and how many you want to copy.
>>
>>
>> Thanks Michael for this information!
>> If you don't mind I'll amend it to the commit description so there is a reference for
>> posterity.
>>
>> I'm waiting for /Andreas Gustafsson to test it then will repost.
> 
> Hi Philippe,
> 
> Thanks for coming up with this patch! Looks fine to me, just wondering if it should
> have a "Fixes: 5d971f9e67 ("memory: Revert "memory: accept mismatching sizes in
> memory_region_access_valid"") tag rather than the original commit since that's how
> other bugs exposed by that commit have been tagged?

I don't think so, the bug was present (hidden) *before* 5d971f9e67 and
we were incorrectly modelling it. I just posted a v3 including Michael
valuable memories :)

> 
> 
> ATB,
> 
> Mark.
> 

