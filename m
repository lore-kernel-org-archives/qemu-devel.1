Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A643C2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 21:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28BD321D6C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 21:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjVJss8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BD321D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPvSA-0001vr-An
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 17:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jPvQw-0008U2-Fc
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 17:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jPvQv-0005Pv-8j
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 17:55:30 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jPvQu-0005OJ-OH
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 17:55:28 -0400
Received: by mail-pl1-x643.google.com with SMTP id y22so2449134pll.4
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 14:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ggxTA5A8jE749qyThde9pIESkz9EOtKgwbaEV5HROoo=;
 b=qjVJss8XItWC+cWK7EwcmLTj/nv/71TIR7VShyKxf2gJILP+AFD+m8TqFDi4Z52flD
 ZnNxyDcsgNVT2iKA3IJAblWh6hEj/HtwcJPoPCY0veoRwdD/Tf1aPiFhrxZvMlNIsG2m
 C7miFhLFjye3Ur1yj0dCVXMkYsC0Kl81ZeTcvfvhj2g4z4g61EQDLYWLrnSy6k0rG3j0
 Y/m8xuhnYWoyPCjyzkz01voB3qcekuzAdG3QwR3ntohDlTvfA76luzmJyc12hhQ5nmI6
 KGXok+jj2PNSQ/k5svT8sW5oxPEGgVvE004mKQrwbmjCD3ubDh113KMlLfNCYEplOZKA
 qAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ggxTA5A8jE749qyThde9pIESkz9EOtKgwbaEV5HROoo=;
 b=oifAoDijvgpw8GbUlW+xxBorjLkJw/N+QjH9vIZFVgRNqu/T2j3r39lvF6xlMX3QZo
 s7/l8VHxvE+XVoSFGaHxQkDM9megai1j1DvOlTPTJzWWtPFuKX+w7msF119ns4rqEXGY
 2dDmzkIdKqOmTnqcYmYCz/8mT+3lzueRKNdDgkXqdCEJlH5LTPLINie9XRZH8QBp/gJm
 fIqr/t7Clu7KQdqgc6CuJKADICIIq5C0iq0I6Tz833KJfBv4TOEPpXr3UID2GWF+0aV4
 x31bHQEldB57cWNtFTByhJlo37sNPyF8VudJb51yjUU38gkf39AmIO3zmYqn7+856dQw
 kbdg==
X-Gm-Message-State: AGi0Pub39z+YS2CbBrOQ4QtaYFnlqwN2JS2/gp1osob4q4qNVba3+dIs
 vJmR25fRaEeVwJnzyYidb8ereBPVKbbvfw==
X-Google-Smtp-Source: APiQypLPFr99/lKnFVi0fuZ4Nud3VEHfMzVcyg3setd/v1hidNZsGyJmbA34I3UYCg0UDJb9oIouyQ==
X-Received: by 2002:a17:90a:3441:: with SMTP id
 o59mr11289977pjb.185.1587246923485; 
 Sat, 18 Apr 2020 14:55:23 -0700 (PDT)
Received: from [192.168.0.3] ([75.167.104.59])
 by smtp.gmail.com with ESMTPSA id u21sm4940020pga.21.2020.04.18.14.55.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 18 Apr 2020 14:55:22 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] dwc-hsotg USB host controller emulation
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200329001705.15966-1-pauldzim@gmail.com>
 <20200329001705.15966-5-pauldzim@gmail.com>
 <CAFEAcA9bL=uZ3-F4bYbHW+V9REnS1OnSusGKB2UoHS0bjSbvzA@mail.gmail.com>
From: Paul Zimmerman <pauldzim@gmail.com>
Message-ID: <ebb6e338-0fa2-e9bf-2503-0059b0a2be58@gmail.com>
Date: Sat, 18 Apr 2020 14:55:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9bL=uZ3-F4bYbHW+V9REnS1OnSusGKB2UoHS0bjSbvzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=pauldzim@gmail.com; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 4/16/20 8:45 AM, Peter Maydell wrote:
> On Sun, 29 Mar 2020 at 00:18, Paul Zimmerman <pauldzim@gmail.com> wrote:

< snip >

>> +/* nifty macros from Arnon's EHCI version  */
>> +#define get_field(data, field) \
>> +    (((data) & field##_MASK) >> field##_SHIFT)
>> +
>> +#define set_field(data, newval, field) do { \
>> +    uint32_t val = *data; \
>> +    val &= ~field##_MASK; \
>> +    val |= ((newval) << field##_SHIFT) & field##_MASK; \
>> +    *data = val; \
>> +} while (0)
>> +
>> +#define get_bit(data, bitmask) \
>> +    (!!((data) & bitmask))
> 
> Could you use the standard field definition, extract, and deposit
> macros from include/hw/registerfields.h, please?

I would prefer not to do that if possible. By using these macros
(which I borrowed from hcd-ehci and hcd-xhci BTW) I am able to use
the existing dwc2 register definition file from the Linux kernel
without modification. To use the macros from registerfields.h it
looks like I would need to write new definitions for all of the
dwc2 registers. I would really like to avoid that.

Thanks,
Paul

