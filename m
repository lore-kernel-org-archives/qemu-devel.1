Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C6DC352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BCF2082F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJZApzHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BCF2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j17Dv-0006Pt-TO
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 06:27:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j17Cc-000531-H8
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:26:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j17Cb-0007Ky-8H
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:26:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43609
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j17Cb-0007KV-3l
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581333967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LNvWm0QcQMiy+BvznThhnDmbvUVaLjCAvT4eggFNm54=;
 b=HJZApzHJzuIxT906M4EKHbMxZt9k7UZvkixTo/3BTiEHv/YL0uhEpNfirsDdPHqYwGVIWN
 i/FwiQAcJJbNydF702eJ7CqkIidlBOy233nqjf1g55fcHuIjyQtcb96QXiZJB3xuvRjISr
 31voWm8qfwaatDbDM9KW1WOWr/08bYM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-SKJ5m9mPPtqXa6DQUBYImA-1; Mon, 10 Feb 2020 06:26:04 -0500
Received: by mail-wr1-f71.google.com with SMTP id u18so4817700wrn.11
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 03:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UkAq2XRsQHW5GYl8Vg9B+M+OBzhvFA5w8GdyNT3jHrY=;
 b=cwfkV+OzST8FCKTsdJTSn+R9nHogXTBVTEwbvVFZ9y+1bz8CHMLAnwW2OjCupOiaGN
 qq4wtJL3gQPVlzb8Od05qPGaMBW4XtEbvqx94g7EuS2szTochdywvKsOHfaY9oXxsmD7
 3cO7Ah5pwc0WH9/3kAFqZgc1O/J7Wh4xxao8GPtNPv7hxcHCntUtOhV96K/JU6i88cYV
 aduNbtbqzSjaTWUADe+kHaSIwVOmTLeKWZzoXY56i+W+90BNfOW3vEuYHb7vbLxcY431
 fRWX7RRZra1ULA/iqMfCEQB92AJLVt35aqW7kx1WZmP1MWwQ/MzplBQr0XTxqnfHR8q5
 Gghg==
X-Gm-Message-State: APjAAAU1cG06y8L+Dr1SKptS6BzEm3SHcM6GJIuhTosxWLrnnLiuYSF3
 Q7qVcK9hT1rgb3Gu/3y/5sLTVdlSzhrtE7DMk7MTn4gWzlwZAVQFHqdfOCA4ob6/+CqE0BSvQtv
 3CaX5f/9kCxtbxHk=
X-Received: by 2002:a05:6000:1289:: with SMTP id
 f9mr1377965wrx.381.1581333963416; 
 Mon, 10 Feb 2020 03:26:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEn08wCjMtoXKedBUt49RfBeECfKQLYprMRu8lzs7297Fy/wEnKqCpTpkCOi/y1wngAqQUsw==
X-Received: by 2002:a05:6000:1289:: with SMTP id
 f9mr1377932wrx.381.1581333963137; 
 Mon, 10 Feb 2020 03:26:03 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56?
 ([2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56])
 by smtp.gmail.com with ESMTPSA id s1sm101524wro.66.2020.02.10.03.25.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 03:26:02 -0800 (PST)
Subject: Re: Getting whole-tree patches reviewed and merged
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200120100849.GB345995@stefanha-x1.localdomain>
 <871rrtmkko.fsf@dusky.pond.sub.org>
 <20200121113224.GD630615@stefanha-x1.localdomain>
 <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
 <87wo9lc4oe.fsf_-_@dusky.pond.sub.org> <20200121143658.GB597037@redhat.com>
 <871rrs97ld.fsf@dusky.pond.sub.org>
 <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
 <CAFEAcA-C5Kvp-tUZfXSeAiFAHW-YXb+ddwFqyo5Y=0ziPhFbDA@mail.gmail.com>
 <871rrs136l.fsf_-_@dusky.pond.sub.org>
 <f450e310-3614-5e03-b932-ecba95970c95@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dc1c60f7-3f88-2d86-9f03-88cca1b6d49e@redhat.com>
Date: Mon, 10 Feb 2020 12:26:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f450e310-3614-5e03-b932-ecba95970c95@redhat.com>
Content-Language: en-US
X-MC-Unique: SKJ5m9mPPtqXa6DQUBYImA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Christophe de Dinechin <dinechin@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/02/20 22:53, Eric Blake wrote:
> On 1/21/20 11:16 PM, Markus Armbruster wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On Tue, 21 Jan 2020 at 15:11, Marc-Andr=C3=A9 Lureau
>>> <marcandre.lureau@gmail.com> wrote:
>>>> There are plenty of refactoring to do. The problem when touching the
>>>> whole code-base, imho, is review time. It may take a couple of
>>>> hours/days to come up with a cocci/spatch, and make various patches
>>>> here and there. But it takes often weeks and a lot of constant push to
>>>> various folks to get all the reviews (as seens by the qdev prop-ptr
>>>> series earlier for example). How can we better address whole code-base
>>>> changes?
>>>
>>> It depends. If it's literally just a cocci/spatch mechanical
>>> transformation, I think we should be OK with reviewing that
>>> transform and then applying it; we don't need to get acks
>>> from every submaintainer for that kind of thing.
>>
>> I go one step further: I prefer mechanical changes committed together,
>> not torn apart and routed through N+1 trees, where N is the number of
>> active maintainers picking patches from the series, and 1 is the
>> maintainer taking pity of the inevitable leftovers.
>>
>> Tearing a patch series apart may be in order when it's invasive enough
>> to risk many conflicts.=C2=A0 The subsystem maintainer may need tighter
>> control over merging order then, and routing picked patches through his
>> own tree may be the practical way to get it.
>=20
> And the pending work on ERRP_AUTO_PROPAGATE is an example of that -
> Vladimir has been trying to get the improvements in for some time, but
> it touches so many files, and is awkward to review whether it is split
> into over 100 patches per maintainer area or when it is consolidates
> into few but large patches.

If I can help with ERRP_AUTO_PROPAGATE, I can merge it through my tree.

Paolo


