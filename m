Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D1DC10F14
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 07:32:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3892067B
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 07:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J21Ras8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3892067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJBsp-0003lV-A9
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 03:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iJBs1-0003LT-A1
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 03:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iJBrz-0001Ht-5c
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 03:31:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26445
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iJBrv-00018z-Oz
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 03:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570865472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3NxRTrcugbvzye9hlLevC//ToErhN85183Sw5g7j0d4=;
 b=J21Ras8JyNTDXtAVLbfW1stvE69rMyZjU5Ru0+jNaRgAA5h/jYi7Iwn9lWlmMAmjxu4z5O
 +X8YaUb6DE/bLagk80sI0ULlCyvaVH+X59S0vRUvK2UbOndT/J3AToq6Ll1ab/l6woxJYK
 RtRt4tvcUq2ZYG9Zs3PWqyIgeygoZ54=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-TEi6piT-M9yqJMgBv6Kw6g-1; Sat, 12 Oct 2019 03:31:11 -0400
Received: by mail-wr1-f70.google.com with SMTP id k4so5510991wru.1
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 00:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ww/y6OfNiMVsW4KRyI0/3V8+hb0zUcoXwsERwzzfKSg=;
 b=AAQh8j5O9LWkpl8LmHFYFhtx2el8V4hkmZUVQKMLMLahHk/kux/Lv/UtqKAr7ERVls
 it/nCxbZ789RHSPI/BKwzIUudiw9WtfCZEqAFfAiNknyrCLklx1zbRKZOOYlHp+wV2+e
 j5nEYbh/uXXxbCKpv9mbSPobL2YuExUQHT1dVGS8jLNTjMNfkb+3z+92MIPovB29qm9R
 +Fn/Y3Uy5hHdeTYOegRdH23YODe473DKBB9qMDM8RyUiZ22/lQR+fQh+igkSeau2Md9c
 etecbBN6U+TRDNPmYoxhlBPrYpwmRf9M7T/NoGJ24awiDra21s2B6L9atJRN5ve9joaR
 MdNA==
X-Gm-Message-State: APjAAAU1HJxCuPDz8U5qlg3rXe/CL8TTH4bk+g3KVEpBz+Cn1L39uZPe
 Es9kRJ7DlWcEK1lT0ntOupjj+7hHYUFYRKODTlzNJsCEmQL0Iz5hx84klK4+xxOrc+I4MwA+z7G
 6WZDRQG3xcUUZFf8=
X-Received: by 2002:a05:6000:1252:: with SMTP id
 j18mr16507806wrx.160.1570865470028; 
 Sat, 12 Oct 2019 00:31:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzK8VMZe4Lrxft3Wgq+sx5qQabxnvCWogJvPX3bvzlvOI7ctPBKXdQP0E4BPzM116dv0och4w==
X-Received: by 2002:a05:6000:1252:: with SMTP id
 j18mr16507750wrx.160.1570865469081; 
 Sat, 12 Oct 2019 00:31:09 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id y3sm8023502wro.36.2019.10.12.00.31.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2019 00:31:08 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v1 8/8] target/avr: Register AVR support with
 the rest of QEMU, the build system, and the MAINTAINERS file
To: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20190504083638.13380-1-S.E.Harris@kent.ac.uk>
 <20190504083638.13380-9-S.E.Harris@kent.ac.uk>
 <c05b4876-c55e-fd82-46d0-83be1b128cee@linaro.org>
 <CAK4993h0yCqpjBFzPy7GHt3kbSK43nLD6EXh4WFd_STHu15DTA@mail.gmail.com>
 <20190510121732.de0aa4075bcf6962a7414054@kent.ac.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6dfd36cf-9d2f-d74a-2c8e-4b283973e8f7@redhat.com>
Date: Sat, 12 Oct 2019 09:31:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190510121732.de0aa4075bcf6962a7414054@kent.ac.uk>
Content-Language: en-US
X-MC-Unique: TEi6piT-M9yqJMgBv6Kw6g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: A.M.King@kent.ac.uk, Michael Rolnik <mrolnik@gmail.com>,
 E.J.C.Robbins@kent.ac.uk, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sarah,

On 5/10/19 1:17 PM, Sarah Harris wrote:
> Hi Richard,
>=20
> Having discussed with my colleagues, we don't have the resources to maint=
ain this.
> If you wanted to take up Michael's offer then I'm happy to respond to que=
ries and provide minor fixes.
> Otherwise, we will make our repository publicly available in the near fut=
ure for anyone who wants to use it.

Would you agree to be listed as reviewer for AVR (Michael being the=20
maintainer)?

   M: Mail patches to: FullName <address@domain>
      Maintainers are looking after a certain area and must be CCed on
      patches. They are considered the main contact point.
   R: Designated reviewer: FullName <address@domain>
      These reviewers should be CCed on patches.
      Reviewers are familiar with the subject matter and provide feedback
      even though they are not maintainers.

> Kind regards,
> Sarah Harris
>=20
> On Sun, 5 May 2019 09:10:00 -0700
> Michael Rolnik <mrolnik@gmail.com> wrote:
>=20
>> Hi Richard.
>>
>> I can maintain it
>>
>> Sent from my cell phone, please ignore typos
>>
>> On Sun, May 5, 2019, 8:57 AM Richard Henderson <richard.henderson@linaro=
.org>
>> wrote:
>>
>>> On 5/4/19 1:36 AM, Sarah Harris wrote:
>>>> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
>>> ...
>>>>
>>>> +AVR
>>>> +M: Michael Rolnik <mrolnik@gmail.com>
>>>> +S: Odd Fixes
>>>> +F: target-avr/
>>>> +F: hw/avr/
>>>> +
>>>
>>> This is not how things work.  Michael wasn't up to maintaining the code=
 2
>>> years
>>> ago; that's why it was never committed.
>>>
>>> You would need to maintain this yourself, and for more than "Odd Fixes"=
.
>>>
>>>
>>> r~
>>>
>=20


