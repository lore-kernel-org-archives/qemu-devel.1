Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F197C43215
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E2CC22311
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6vH0tsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2CC22311
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXMO9-0004Nq-EK
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 04:35:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXMMv-0003Wj-TT
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:33:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXMMt-0001x0-Vy
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:33:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24141
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXMMt-0001vr-G6
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574242426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I1xvAFbPBzY0R3YnKPz9fFINj1oUe66z51DCpLZDuL4=;
 b=g6vH0tsEjoi7PqFrTQzh2f9+gkKreS5v6rtuFUe7FPgB2GoA843WnkqT1NPFzcf1eULi2n
 twbilyoWfG3/5W+kBgAq6QrAsAvFM+h73U56EX+iS3Wr1tivxEywCcSBnTK+aasiP+WBUc
 sSbzhNVQGUMTjzz4/L2LpnTjHsjGHBc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-2hx1GeRAPS2urv6V_EXAZw-1; Wed, 20 Nov 2019 04:33:45 -0500
Received: by mail-wm1-f72.google.com with SMTP id y14so4817552wmi.4
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 01:33:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DnFVQcfnSyHdq6XrkwdYnDWPKhBn2Blaur7V83nC5EY=;
 b=p49Ah/SRKBBdDlLdxSFIwn0O1j5zQ4SZVdnJIbUgJi6Hix1JJKIFPudm8u7fK11pIa
 7bEcLzr4qcvwqmoagwxHrdNhoRnsJWSqAuu3nzj2PyDK/YFPLxx2LiY6UHY6k7R+R8fW
 6+AsIjRlEETg3tpeBuiNy2in2synYH2SCua7iVg0CA1hcg7wRM0KWTWru1MpY4kGsKCb
 hpPA/4xe2jCgCRx/ig+9Gw/WbHh8jeuh0UKp5uf0jRTmN4pNU5m1thy5SInYrsjO1ctC
 VoWUI7ARN2ZNR0e17iRrNdEwKxK65nO8IQZhUGk0+4/Tm/vwuBUa9WIVhwOZ7tfgWShe
 LSWg==
X-Gm-Message-State: APjAAAXsI/utNSC4DUtF9i+of1pjVEKykOmSIlo49B7OVuoI8cIUBe24
 ot9QwIPOGXqyIJ5fKY67RdXjaHdQsjgu7Agxz017SaMA1AvsQW419k2FjJKA85csyLITTVzk3fh
 oW/HaFeRECymc3kg=
X-Received: by 2002:a5d:68c3:: with SMTP id p3mr2163622wrw.82.1574242424203;
 Wed, 20 Nov 2019 01:33:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqx6jRAEtpTTjjoOSV70vdRrLp9IYhvWYQq0eTZJocvV9+76yNHYD8jt/8gpETXrJS3KoKaqSQ==
X-Received: by 2002:a5d:68c3:: with SMTP id p3mr2163566wrw.82.1574242423839;
 Wed, 20 Nov 2019 01:33:43 -0800 (PST)
Received: from [10.113.186.199] ([46.31.59.59])
 by smtp.gmail.com with ESMTPSA id k4sm6291893wmk.26.2019.11.20.01.33.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 01:33:43 -0800 (PST)
Subject: Re: [PULL for-4.2-rc2 0/2] Tracing patches
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20191119204551.240792-1-stefanha@redhat.com>
 <CAL1e-=ibQBWUzUZvsvSWCZ5SwFk5T+b2P94D068W8G_taWVASg@mail.gmail.com>
 <CAL1e-=iEN9GEGDzEvoYM9q477Le4rs-mQZEgxOdzr51ZxLJd0w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <02d25aa5-d913-947d-3ccd-5057bc516fd2@redhat.com>
Date: Wed, 20 Nov 2019 10:33:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=iEN9GEGDzEvoYM9q477Le4rs-mQZEgxOdzr51ZxLJd0w@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: 2hx1GeRAPS2urv6V_EXAZw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:bochs" <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/19/19 10:35 PM, Aleksandar Markovic wrote:
> On Tue, Nov 19, 2019 at 10:14 PM Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
>>
>> On Tue, Nov 19, 2019 at 9:46 PM Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
>>>
>>> The following changes since commit f086f22d6c068ba151b0f6e81e75a64f130d=
f712:
>>>
>>>    Merge remote-tracking branch 'remotes/awilliam/tags/vfio-fixes-20191=
118.0' into staging (2019-11-18 21:35:48 +0000)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://github.com/stefanha/qemu.git tags/tracing-pull-request
>>>
>>> for you to fetch changes up to 6b904f1a528a6d8c21f7fbdeab13b9603d1b6df7=
:
>>>
>>>    hw/mips/gt64xxx: Remove dynamic field width from trace events (2019-=
11-19 16:17:05 +0000)
>>>
>>> ----------------------------------------------------------------
>>> Pull request
>>>
>>> Tracing fixes for MIPS.
>>>
>>> ----------------------------------------------------------------
>>>
>>
>> Hello, Stefan, Philippe, Peter.
>>
>> This appears to be a duplicate of the pull request sent today by Philipp=
e
>> (and already applied by Peter just hours ago):
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg02894.html
>>
>> The patches from the two pull requests appear to be identical, except
>> some minor details in commit messages: Stefan's versions contain
>> "Message-Id:" identifiers, while Philippe's don't (my suggestion to
>> Philippe is to include "Message-Id:" for all patches that are part of an=
y
>> pull request in future; this can be achieved effortlessly/automatically
>> by applying patches using patchwork).
>>
>> In summary, for this very situation, it looks to me we are all set, no n=
eed
>> for Peter to process this pull request.
>>
>=20
> And just another really friendly advice for Philippe: When you apply
> some patches or a series to your pull request, just inform others
> about that by replying to the patches or a series: "I applied XXX to
> my queue/pull request" - this helps avoiding duplicate efforts like
> it happened here. This is also reminder to me too, I didn't do it in
> all cases of my applying to my my pull requests, and I should have,
> but I will improve too.

You are totally correct, in a rush to get these patches merged before=20
the release candidate get tagged, I neglected to reply to my series and=20
let Stefan waste his time.

Stefan, I sincerely apologize and will make efforts so this won't happen=20
again.

>=20
> Thanks for these fixes!
>=20
> Aleksandar
>=20
>> Regards,
>> Aleksandar
>>
>>> Philippe Mathieu-Daud=C3=A9 (2):
>>>    hw/block/pflash: Remove dynamic field width from trace events
>>>    hw/mips/gt64xxx: Remove dynamic field width from trace events
>>>
>>>   hw/block/pflash_cfi01.c |  8 ++++----
>>>   hw/block/pflash_cfi02.c |  8 ++++----
>>>   hw/block/trace-events   |  8 ++++----
>>>   hw/mips/gt64xxx_pci.c   | 16 ++++++++--------
>>>   hw/mips/trace-events    |  4 ++--
>>>   5 files changed, 22 insertions(+), 22 deletions(-)
>>>
>>> --
>>> 2.23.0
>>>
>>>
>=20


