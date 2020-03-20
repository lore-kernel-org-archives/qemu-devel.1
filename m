Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F455C43332
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D01F20724
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdBkvxin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D01F20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFKO9-0006um-5m
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 12:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFKN6-0005SW-G4
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFKN5-0003Y9-CG
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:19:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:49045)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFKN5-0003Xv-8M
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584721182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kD34915ohKfPx4X1fBfkodPESkIf3cEZUh6ZtZG5rvU=;
 b=bdBkvxinCNWc+cv+1Ysn+mLvojJIa46F+D0PujnlYqalk5pKjAN4B34Bc58bIX/zD3Zx+r
 vtXguhf1/1WfORXfngha0hrPlYbwJ6QyP2nSrKCukTHVmiysaFTGFBJEdtlFY4oSKSHQM2
 tsvHlKJYVEK0Zcm6z6ojP6XLU+3lGlc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-w8FFvgnzMou1GO26tn8I2w-1; Fri, 20 Mar 2020 12:19:40 -0400
X-MC-Unique: w8FFvgnzMou1GO26tn8I2w-1
Received: by mail-ed1-f72.google.com with SMTP id b9so4386884edj.10
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 09:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kVWOkBaUZ+ucppvlQiTMZlu2xEl17c5C+O6SXpMbzeI=;
 b=nhGTUqPN6MfCvBUK9F68S0ulcS0jhLvcV6lM88qphgURi44Wg+8AzMNKxPc+uNJmKf
 Vp6Kd9QICLXcVkpHmkW5xss2OI0xsz3qMScHKZ0co+LjR31xUIjt8I5ZkIdRJqulSOrL
 Wnbuk56R8q3U5K4qu+ejghAHQFZCmsxvla6z/0OIkYzD3g6cZ4lnBmF9HlTyKYrSABo1
 A+lF9ZGsliB2DI26hQcsJWi+ouoAMvnIibdItm3Y4SqYO4Pgp/IyqvZHhUdW8fZDQtaR
 DTIp8Y/tmld6wMA0df3IoXVTrfxNlg7Rh/pEuN7EXvZ85g41eM/qdfaaYQPpeB5THtZ4
 vtuA==
X-Gm-Message-State: ANhLgQ15twPNq5VgdEOBVeegOtQnMBye2HIBETFPVf5MnE04yTJEXvfM
 JYugGWIVjySSrAMxqbYaLrbzy8l7eA7lGA6hxf1NwOlup8jTp09N6ejeF2USE6htwDckc8hvasf
 NxMBlLj8J6hT9CIE=
X-Received: by 2002:aa7:d488:: with SMTP id b8mr8433100edr.48.1584721179582;
 Fri, 20 Mar 2020 09:19:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuguiyOyPgXm/ntuMbcgilPDnY+GFQLJYOw5Tfo1aBLwSNoxjPDYZn6xhSrx73IluhdBoKvCg==
X-Received: by 2002:aa7:d488:: with SMTP id b8mr8433077edr.48.1584721179335;
 Fri, 20 Mar 2020 09:19:39 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id qk2sm132968ejb.80.2020.03.20.09.19.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 09:19:38 -0700 (PDT)
Subject: Re: [PULL 0/4] Python queue for 5.0 soft freeze
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200318011217.2102748-1-ehabkost@redhat.com>
 <CAFEAcA_6i1ponfRK6vUA_KCz_F=2c886CPQNKE8Kn4SifaRRxw@mail.gmail.com>
 <ae222b3b-04ef-7dc7-4560-2e24d32b69b5@redhat.com>
 <CAFEAcA8M4P3a-QGA9qjOTmpsAKGBcKDG2KRhOC1V=iLHK3mqkw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <72ee2882-94b5-4eb5-7178-f8af29ca317f@redhat.com>
Date: Fri, 20 Mar 2020 17:19:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8M4P3a-QGA9qjOTmpsAKGBcKDG2KRhOC1V=iLHK3mqkw@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Cleber Rosa <crosa@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/20/20 5:14 PM, Peter Maydell wrote:
> On Fri, 20 Mar 2020 at 16:11, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> On 3/20/20 4:59 PM, Peter Maydell wrote:
>>> On Wed, 18 Mar 2020 at 01:12, Eduardo Habkost <ehabkost@redhat.com> wro=
te:
>>>>
>>>> The following changes since commit d649689a8ecb2e276cc20d3af6d416e3c29=
9cb17:
>>>>
>>>>     Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' i=
nto staging (2020-03-17 18:33:05 +0000)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>     git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>>>>
>>>> for you to fetch changes up to f4abfc6cb037da951e7977a67171f361fc6d21d=
7:
>>>>
>>>>     MAINTAINERS: add simplebench (2020-03-17 21:09:26 -0400)
>>>>
>>>> ----------------------------------------------------------------
>>>> Python queue for 5.0 soft freeze
>>>>
>>>> * Add scripts/simplebench (Vladimir Sementsov-Ogievskiy)
>>>>
>>>
>>>
>>> Applied, thanks.
>>
>> I guess there was a mis understanding with Eduardo, he was going to
>> resend this pullrequest due to:
>>
>> ERROR: please use python3 interpreter
>=20
> Ah, sorry. I'd read the replies to this thread as meaning that
> those things were OK to fix as followup patches rather than
> requiring a respin of the pull.

As you noticed, scripts/simplebench/bench_block_job.py is not run in our=20
tests, so no need to hold the other pull requests, we'll fix later.

Thanks,

Phil.


