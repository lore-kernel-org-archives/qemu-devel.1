Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7696C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 703CF207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMRj/3HS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703CF207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiaK1-00065c-Nx
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 05:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiaJK-0005Sk-Ki; Tue, 09 Jun 2020 05:12:46 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42282)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiaJJ-0007Qa-PM; Tue, 09 Jun 2020 05:12:46 -0400
Received: by mail-wr1-x441.google.com with SMTP id p5so20382420wrw.9;
 Tue, 09 Jun 2020 02:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=d23IEvDyNJeGG9inUY3xsvKbsfaVGHwFj/TO+66H8wk=;
 b=lMRj/3HSb6VNC8YRp2xPainJVMALaSCd8p2+jirbf2MTaaoPc5LDn6w5lGmvUzU5Xc
 J/9yZKp6va6y7WFL4C3JDVfaoFSp2xSzY+BxCmtGdBn59TL4vAKSKls/4HDy/x4eYbIk
 umL+w5jb6gex4ehpFUSJORfU1SGw/4Z5Lu/mW964WRe9Zq4CzbszTCg/qSWdkbOAz8Pp
 mMRo1kc/gJc63iNyK8JNJPwwWAz12T8/Nlz2/xhHtzmGoi9o4NDSkCMQ6Jt+zlVW40uM
 4hJdHbJPoHCmJE8bmwz1Hl6ayEv9780tID/lWr4fRA2ljV9yTt1vvIApI26OljMSIKi7
 SsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d23IEvDyNJeGG9inUY3xsvKbsfaVGHwFj/TO+66H8wk=;
 b=nKshkKijuwZ+z6ZEIBk5bFAgoeVJMK41U4vjBmKKIlIJfBz69mxC9hhpR9stHgEDbJ
 G9Xirl+cdbcq/QyCSvDQuO2n+zdm37ckVtP6ISwyf+DgNEET2Es8Z8ukqD/7Fr2OIxUv
 XG7ETUL42Ajzk93Dz4s0s52onySUICsGbBk5K1jTTP5UhY48vlFq0wJiCAU84yHaXL5z
 8rgzs+g5LcIlOQpqZQt1NM5lS7DWPRhc6mhUJaxA6DgMK+M/OKWHdvs5Mpp3wylQoPxQ
 wnZG2aNvKVBzQED237pwffy+wytaWiBU7Rk0W0NSS2VHIswhhmONzz4GrYGSVOP668dK
 S3hQ==
X-Gm-Message-State: AOAM530ROTTok1Ian3UYvQNlT/v5XnLPzQDXP3Ahr7v1PJGOJhOlVOqX
 xgdNJQVUbt0vOA0I1sgYE+M=
X-Google-Smtp-Source: ABdhPJw8wfL2QPmW5qtQn3STC69pn/KUc3O8x5xJLLuGXy7vSRjEZA3uZbzH2xokaWr/kF/GTdoNnw==
X-Received: by 2002:adf:df91:: with SMTP id z17mr3242135wrl.273.1591693963642; 
 Tue, 09 Jun 2020 02:12:43 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id z16sm2564996wrm.70.2020.06.09.02.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 02:12:43 -0700 (PDT)
Subject: Re: [PATCH v2 2/8] MAINTAINERS: Mark SH4 based R2D & Shix machines
 orphan
To: Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20200608090142.6793-1-f4bug@amsat.org>
 <20200608090142.6793-3-f4bug@amsat.org>
 <8f97580c-bf25-dd83-e23e-dcea1e6ce6b7@redhat.com>
 <875zc0skab.fsf@dusky.pond.sub.org>
 <CANqRtoRwWksb8zngFqJnJg-gNs5_M_NoFZ1Y=A8mHK0NfCFBCg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e55ba7d1-6617-ed1b-e9a2-a564bd490709@amsat.org>
Date: Tue, 9 Jun 2020 11:12:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CANqRtoRwWksb8zngFqJnJg-gNs5_M_NoFZ1Y=A8mHK0NfCFBCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Magnus,

On 6/9/20 10:59 AM, Magnus Damm wrote:
> Hi Markus and Thomas,
> 
> On Tue, Jun 9, 2020 at 5:41 PM Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> On 08/06/2020 11.01, Philippe Mathieu-Daudé wrote:
>>>> Last commit from Magnus Damm is fc8e320ef583, which date is
>>>> Fri Nov 13 2009.  As nobody else seems to care about the patches
>>>> posted [*] related to the R2D and Shix machines, mark them orphan.
>>>>
>>>> Many thanks to Magnus for his substantial contributions to QEMU,
>>>> and for introducing these SH4 based machine!
>>
>> s/machine/machines/
>>
>>>>
>>>> [*] https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08519.html
>>>>
>>>> Cc: Magnus Damm <magnus.damm@gmail.com>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>>  MAINTAINERS | 5 +++--
>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 49d90c70de..a012d9b74e 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -1250,14 +1250,15 @@ SH4 Machines
>>>>  ------------
>>>>  R2D
>>>>  M: Magnus Damm <magnus.damm@gmail.com>
>>>> -S: Maintained
>>>> +S: Orphan
>>>>  F: hw/sh4/r2d.c
>>>>  F: hw/intc/sh_intc.c
>>>>  F: hw/timer/sh_timer.c
>>>> +F: include/hw/sh4/sh_intc.h
>>>>
>>>>  Shix
>>>>  M: Magnus Damm <magnus.damm@gmail.com>
>>>> -S: Odd Fixes
>>>> +S: Orphan
>>>>  F: hw/sh4/shix.c
>>>
>>> Having both, an "M:" entry and "S: Orphan" in a section sounds weird.
>>> Magnus, are you still interested in these sections? If not, I think the
>>> "M:" line should be removed...?
>>
>> Concur.  Of course, let's give Magnus a chance to chime in.
> 
> Thanks guys! I'm interested but don't have so much time available to
> commit to this I'm afraid. In particular I'm keen on trying to keep
> R2D around since I happen to have a physical machine setup in my
> remote access rack. SH4 with FPU used to have alright gcc + binutils
> toolchain and glibc support once while other SuperH SoCs lacked some
> portions. So keeping SH4 (sh775x) around would be nice IMO.

Great news!

FYI Yoshinori Sato did a great job on updating the Renesas
hardware, see:
https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08584.html

He might be able to help with the UART/TIMER peripherals used by the
R2D, see a suggestion to add a 'Renesas hardware' entry:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg708478.html

If Yoshinori accept the suggestion to add a Renesas hardware entry, do
you agree to be listed as there too? Maybe with a 'R:' tag for
designated reviewer instead of maintainer.

So I'll respin this series with these changes:

R2D: S: 'Maintained' -> 'Odd Fixes'

So contributors don't wait for you to take the patches, and they can go
via qemu-trivial.

And Shix -> No maintainer, S: 'Obsolete'.

The TCG backend stay orphan.

Regards,

Phil.

> 
> Cheers,
> 
> / magnus
> 

