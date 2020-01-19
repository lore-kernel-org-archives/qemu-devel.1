Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E98C32771
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 01:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC5F24697
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 01:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc7TAVVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC5F24697
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iszll-0000AE-HR
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 20:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1iszl8-00085a-5D
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 20:52:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1iszl7-0000HA-2B
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 20:52:14 -0500
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:39780)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1iszl6-0000GQ-Sq; Sat, 18 Jan 2020 20:52:13 -0500
Received: by mail-yb1-xb42.google.com with SMTP id x18so7816441ybk.6;
 Sat, 18 Jan 2020 17:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hdjmv4rK6p3IKw08SRXziTj9Wl6dIxMG00S94z9PuRc=;
 b=Mc7TAVVi8h6e52Y47YgNod83Rgj6yhJPN0czcz+1K4DMajBEI4fub7okpPfFx8FVjS
 t7sDGiyP5X6ByV3hPqGpfDCPiU3CZV6RcJ6AO62WfIe+TlntkkYZu7evUvNfpjIujWYn
 WJLohVvr578PeqGwGIRG/a0fJRHjVpXRaEEQq1gqhbeNxtSI6/VkiF6KXuBcDSR4hp55
 GJTM5sw1C4sDLWZDk0vY/+wn/GcX7a7zBgZq4cDLifgCyWripvpv/LtyzWyNopuQf1JH
 rjRq3ygL00ipJt4ZJ0PrIguxnqp62iKF1aa2nMmJog0SGWX4cx/vzNZ1jD83zrST6r1f
 MaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hdjmv4rK6p3IKw08SRXziTj9Wl6dIxMG00S94z9PuRc=;
 b=qds+SoI678BxxA0d4LPVZJT/iX+8FhLZ5USip0sEj+OhQjhV/HAVhCDpJgpOw7rFY+
 JPH/QPiqqBNt3Cq9/ETFDcqT1Mv6Jvfp54ZYgBm5py1Y3WEoGkrdmj23MBwaS0fbBPH0
 9+Icvk8j4Hr9FsiW9ih3T7FGamYd6etcbfhnj1TeA2Ml2Y6yVvj0u9SfGwzhX3t88o/L
 wipFp8gVkwmTv8wCNWH4DwKb8mlaaZFnJ3ixpyTOsxNgM5h7HBTTK+VIVB/Z2ETp71ug
 MceVDABXg/hQXTvjbNxA9qV8Jn7kU6ieobqF25vsRaIT5z2QzWr9oEkPum3LJF6i8d5R
 YuiQ==
X-Gm-Message-State: APjAAAXmKwvyW+Hblmp4PniOrKUjPF5OtqDoAtQYVtpMVAsF1lzlfelE
 XNaCT1KAGlV6I0JULMRG793iRa+o
X-Google-Smtp-Source: APXvYqxf+nunExtKkM92SZSs9hxOFgZ2dsiEqqcppSFGDdsMKMVsVnvywedZ6lLG0q1oq0gkd+eirA==
X-Received: by 2002:a25:ab8a:: with SMTP id v10mr36909848ybi.305.1579398731278; 
 Sat, 18 Jan 2020 17:52:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 o4sm13884520ywd.5.2020.01.18.17.52.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2020 17:52:10 -0800 (PST)
Subject: Re: [PATCH 6/6] hw/arm/exynos4210: Connect serial port DMA busy
 signals with pl330
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200110203942.5745-1-linux@roeck-us.net>
 <20200110203942.5745-7-linux@roeck-us.net>
 <CAFEAcA_v98GcR06PWfm+=VnteQN_Q7iKK4wobAg6NrVSP1AyDg@mail.gmail.com>
 <20200117182939.GC13396@roeck-us.net>
 <CAFEAcA9zWeW1k-K7qVzCSOA70BmOCa9onT2z_QUQK-=0AJ+NjQ@mail.gmail.com>
 <7a9967c6-a370-9137-10fd-095113dd9852@roeck-us.net>
 <CAFEAcA99CgreMMeTH+nmnY+6OU2xY3A-db6MfBuU8i_MCA+y3w@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <97dafdcd-3f4d-5cc3-efab-b07f373765d5@roeck-us.net>
Date: Sat, 18 Jan 2020 17:52:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA99CgreMMeTH+nmnY+6OU2xY3A-db6MfBuU8i_MCA+y3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/18/20 12:02 PM, Peter Maydell wrote:
> On Sat, 18 Jan 2020 at 15:08, Guenter Roeck <linux@roeck-us.net> wrote:
>> Do only the pointers have to be in Exynos4210State, or the entire
>> data structures ? In the armsse code it looks like it is the complete
>> data structures.
> 
> Either works. Embedding the entire data structure is the more
> "modern" approach, but we don't generally go to the effort of
> converting from the older style to the newer.
> 
>> Also, it seems to me that this means that not only pl330 and uart states
>> are affected, but everything created with qdev_create(). If so, the entire
>> file needs a serious rework, not just its pl330 / uart initialization.
>> Am I missing something ?
> 
> Yeah, all that stuff is broken, but don't feel you need to fix it.
> You just brought the pl330 pointers to my attention specifically
> by declaring locals in this patch, at which point it's just
> as easy to put those pointers in the state struct where they
> should be.
> 

I'd rather try to fix it all if I am at it; otherwise it feels kind
of incomplete. Would you be ok with addressing this separately after
the current patch series is accepted ?

Thanks,
Guenter

