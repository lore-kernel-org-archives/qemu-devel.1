Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771F9C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:20:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F20021939
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8U6YAQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F20021939
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXMA1-0007gg-D1
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 04:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXM9N-0007GI-7j
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXM9K-0001rw-E7
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:19:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44247
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXM9K-0001ra-Ag
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574241585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u3w0vL4wjl/yiCBJRB7qac5oJ29PEm/+EwIDBi+uXW0=;
 b=F8U6YAQzZNURKbNWtgnSzKcetqJDN+Vmtw5IjfqbHf7TIWM7OE/tzXycKNoabqHKgLz3aU
 zq67Q5PL78FQTKF6lBYTG3T0ocmQjMmJZMHzMKzc+G1VISbtQekvW9E6Nz9vstk+HVHIDt
 15xNy1f2b7Hs+gcimPdF7GgTcEwgTDM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-rn3qCW09OHSoSYydNN9sbA-1; Wed, 20 Nov 2019 04:19:43 -0500
Received: by mail-wr1-f71.google.com with SMTP id 92so20897838wro.14
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 01:19:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9PmtRyRNdOHWQSMRcSK06U7dwHBrX/b/38rRhyNHWy8=;
 b=gQEJap1HCu04Txiw9uGpBC1hs/Os6N5lZ9WAqLW4JZ2eGCKjOXG1W/5ljWos6MlU5A
 3CkqJ2AzhZOO8X+a+yCqOsZ9rHYvIdAxDzwrhtiIALfn3XH04IhgSM+GfIKtd8qBDTQ/
 msgFxOJe7ZnzetlA+ENsFhwLfBeNFw/pZ0LqILFbm4I9Rg2FvEz2gOJeBWnWumdiyTID
 ICPTxqTgXN1ZPsV6PakYHV/OOLAm7/BSRihYCfdDsRZ/16V+rZl4UJv31QITuays7tBk
 /bHUzFFWs7NtMslpxqxNBuyl/Kg/gVFJfUqs9glz7BaW0ni+6govK6AG1bMD58VACNhz
 Kmww==
X-Gm-Message-State: APjAAAUNFk6WnYPiO+b7WFDxWD+Tcig64er6usAOSZCilx1MgoXQT1J0
 YW+m7geKVu7oOVjus5HyVTF7XvxXJLXHN7L9rkXTJze0wkAIrUW4WZ1WWylduMKOKI8/pgGAsYP
 OhT8UOAbNWgBTshw=
X-Received: by 2002:a05:6000:12c4:: with SMTP id
 l4mr1876518wrx.110.1574241582271; 
 Wed, 20 Nov 2019 01:19:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqzsA+2IaFyM2Pfd6CtdlEZR5BLhmcHzMm8G9aAm4InBvvQGpWqBOQ4sOPWEwxvfbV7fuEWLFA==
X-Received: by 2002:a05:6000:12c4:: with SMTP id
 l4mr1876488wrx.110.1574241581944; 
 Wed, 20 Nov 2019 01:19:41 -0800 (PST)
Received: from [10.114.188.4] ([46.31.59.59])
 by smtp.gmail.com with ESMTPSA id h140sm6290653wme.22.2019.11.20.01.19.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 01:19:41 -0800 (PST)
Subject: Re: [PULL for-4.2-rc2 0/2] Tracing patches
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20191119204551.240792-1-stefanha@redhat.com>
 <CAL1e-=ibQBWUzUZvsvSWCZ5SwFk5T+b2P94D068W8G_taWVASg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <72728928-995a-296b-388f-5591b8a55de9@redhat.com>
Date: Wed, 20 Nov 2019 10:19:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=ibQBWUzUZvsvSWCZ5SwFk5T+b2P94D068W8G_taWVASg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: rn3qCW09OHSoSYydNN9sbA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:bochs" <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/19/19 10:14 PM, Aleksandar Markovic wrote:
> On Tue, Nov 19, 2019 at 9:46 PM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
>>
>> The following changes since commit f086f22d6c068ba151b0f6e81e75a64f130df=
712:
>>
>>    Merge remote-tracking branch 'remotes/awilliam/tags/vfio-fixes-201911=
18.0' into staging (2019-11-18 21:35:48 +0000)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/stefanha/qemu.git tags/tracing-pull-request
>>
>> for you to fetch changes up to 6b904f1a528a6d8c21f7fbdeab13b9603d1b6df7:
>>
>>    hw/mips/gt64xxx: Remove dynamic field width from trace events (2019-1=
1-19 16:17:05 +0000)
>>
>> ----------------------------------------------------------------
>> Pull request
>>
>> Tracing fixes for MIPS.
>>
>> ----------------------------------------------------------------
>>
>=20
> Hello, Stefan, Philippe, Peter.
>=20
> This appears to be a duplicate of the pull request sent today by Philippe
> (and already applied by Peter just hours ago):
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg02894.html
>=20
> The patches from the two pull requests appear to be identical, except
> some minor details in commit messages: Stefan's versions contain
> "Message-Id:" identifiers, while Philippe's don't (my suggestion to
> Philippe is to include "Message-Id:" for all patches that are part of any
> pull request in future; this can be achieved effortlessly/automatically
> by applying patches using patchwork).

Yes you are right. I usually use 'pwclient git-am' to apply patches from=20
the mailing list, which automatically amend the proper Message-Id tag.
I totally forgot to use it with here. I'll see how to not miss them in=20
the future.

> In summary, for this very situation, it looks to me we are all set, no ne=
ed
> for Peter to process this pull request.
>=20
> Regards,
> Aleksandar
>=20
>> Philippe Mathieu-Daud=C3=A9 (2):
>>    hw/block/pflash: Remove dynamic field width from trace events
>>    hw/mips/gt64xxx: Remove dynamic field width from trace events
>>
>>   hw/block/pflash_cfi01.c |  8 ++++----
>>   hw/block/pflash_cfi02.c |  8 ++++----
>>   hw/block/trace-events   |  8 ++++----
>>   hw/mips/gt64xxx_pci.c   | 16 ++++++++--------
>>   hw/mips/trace-events    |  4 ++--
>>   5 files changed, 22 insertions(+), 22 deletions(-)
>>
>> --
>> 2.23.0
>>
>>
>=20


