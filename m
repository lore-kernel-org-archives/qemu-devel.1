Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2F2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 14:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3732F20705
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 14:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lg7J42A+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3732F20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixXa9-0001km-CT
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 09:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixXYR-0000iF-RN
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:45:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixXYP-00009J-Ky
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:45:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52835
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixXYP-00007B-H9
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580481951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mZN9Hl3+aF+v15kZfh6M8ORr2C6rS/jG7ddyKfgCOKo=;
 b=Lg7J42A+wXt5KTS0Y3zMR3VpnbZopzwLQyiO/MvEARGrLa0lEa1p96yQoJhaEnFDGmaxh2
 uM0AIxaE31k0cQ5E3wv74tlhToRO8tGaAHDd1U3P8XwnONW8GH2NnG1VGlv8HRaBnjftIA
 6QjoCMeUZ2FYrDFjUwd6jmbpuscAyDk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-YcjPOhpiN5i8TgdIXDUliQ-1; Fri, 31 Jan 2020 09:45:49 -0500
Received: by mail-wm1-f72.google.com with SMTP id z7so2134624wmi.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 06:45:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ejwg/O+VzGmKZ2KmKlNoJEMXJ+cdT8l5wb72BiCNNRc=;
 b=cwjOwRM+deyTtUa6gjoyEQxV8+QzLH0h12vXfudEt9C1uyDqVSughQwXB4kWvmotUB
 H7nBqBhkde7Hq+NGc2Jf7zQA4tLdmeEgeBO9+9PTXwZARNXi3n2qHE+XxTQqONAms11J
 ilY+tJ+tBeg5m388AqQvHF4vsq/dM6Bbw2wv46ccIzgBf5Mx1BUYGyihLKemWCNic5Sq
 UU5LiBFrNRxWLplqIfBbttkem7BabIUvKPCsU46vvZFnBAyspyr6Jm7L2nAoXsLiQ5Oa
 IiDAFryr0cpDDQgyal5vKWRo38WtjVT8jeFCgBxOP1w0BKOSRLaABtZiTlRE/Z+RqHV8
 HGbA==
X-Gm-Message-State: APjAAAWwnsGKMKiUZbTBOlTIBoohwASndIWwKcCeRhFRmtnXcrxDIm3E
 biW4g4sz+ArI+QhUDBxbuBgyElae+BuNpfNP3LywxazEiuD5zak0cIQmNxE0zaQRhwVG5vWz+g+
 TKdAGCm7W/AhJRbg=
X-Received: by 2002:a1c:1c4:: with SMTP id 187mr4733352wmb.77.1580481948372;
 Fri, 31 Jan 2020 06:45:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5kI0DydiocaUUHHT7yzSSxdYMKi1wOOBnKCTk/Rj7qBGx75+RMb+2bH0rKMXUwnM41wzdug==
X-Received: by 2002:a1c:1c4:: with SMTP id 187mr4733330wmb.77.1580481948134;
 Fri, 31 Jan 2020 06:45:48 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id h10sm10375568wre.3.2020.01.31.06.45.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2020 06:45:47 -0800 (PST)
Subject: Re: [PULL 0/5] Tracing patches
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20200130213814.334195-1-stefanha@redhat.com>
 <CAFEAcA_=_8ZFC=DF3UkqvWqvjQsCHjc=_fYcMmbXs=iLp7JrcQ@mail.gmail.com>
 <f5e22fef-d746-b6f4-2766-0c6258e7b47e@redhat.com>
Message-ID: <6de21482-f9d9-69f9-7a85-dfd6fd4b406f@redhat.com>
Date: Fri, 31 Jan 2020 15:45:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <f5e22fef-d746-b6f4-2766-0c6258e7b47e@redhat.com>
Content-Language: en-US
X-MC-Unique: YcjPOhpiN5i8TgdIXDUliQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/31/20 3:38 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/31/20 2:57 PM, Peter Maydell wrote:
>> On Thu, 30 Jan 2020 at 21:38, Stefan Hajnoczi <stefanha@redhat.com>=20
>> wrote:
>>>
>>> The following changes since commit=20
>>> 928173659d6e5dc368284f73f90ea1d129e1f57d:
>>>
>>> =C2=A0=C2=A0 Merge remote-tracking branch=20
>>> 'remotes/pmaydell/tags/pull-target-arm-20200130' into staging=20
>>> (2020-01-30 16:19:04 +0000)
>>>
>>> are available in the Git repository at:
>>>
>>> =C2=A0=C2=A0 https://github.com/stefanha/qemu.git tags/tracing-pull-req=
uest
>>>
>>> for you to fetch changes up to e144a605a614d22165000c69e8e1dc6986d45cd8=
:
>>>
>>> =C2=A0=C2=A0 qemu_set_log_filename: filename argument may be NULL (2020=
-01-30=20
>>> 21:33:50 +0000)
>>>
>>> ----------------------------------------------------------------
>>> Pull request
>>>
>>> ----------------------------------------------------------------
>>>
>>> Peter Maydell (3):
>>> =C2=A0=C2=A0 docs/devel/tracing.txt: Recommend only
>>> =C2=A0=C2=A0=C2=A0=C2=A0 trace_event_get_state_backends()
>>> =C2=A0=C2=A0 memory.c: Use trace_event_get_state_backends()
>>> =C2=A0=C2=A0 hw/display/qxl.c: Use trace_event_get_state_backends()
>>>
>>> Philippe Mathieu-Daud=C3=A9 (1):
>>> =C2=A0=C2=A0 Makefile: Keep trace-events-subdirs ordered
>>>
>>> Salvador Fandino (1):
>>> =C2=A0=C2=A0 qemu_set_log_filename: filename argument may be NULL
>>
>> Here's a weird one -- with this pullreq applied I
>> see a new warning running check-tcg on the linux-user
>> static config build:
>>
>> =C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 linux-test on aarch64
>> =C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 testthread on aarch64
>> =C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 float_madds on aarch64
>> =C2=A0=C2=A0 DIFF=C2=A0=C2=A0=C2=A0 float_madds.out with
>> /home/petmay01/linaro/qemu-for-merges/tests/tcg/aarch64/float_ma
>> dds.ref
>> =C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 fcvt on aarch64
>> warning: TCG temporary leaks before 0000000000400a0c
>> =C2=A0=C2=A0 DIFF=C2=A0=C2=A0=C2=A0 fcvt.out with
>> /home/petmay01/linaro/qemu-for-merges/tests/tcg/aarch64/fcvt.ref
>> =C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 pauth-1 on aarch64
>> =C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 pauth-2 on aarch64
>>
>> but I'm not sure why any of the patches here would have
>> provoked that, unless they're now causing a log message
>> that would previously have been suppressed or directed
>> somewhere else to be emitted.
>=20
> Looking at the last patch "qemu_set_log_filename: filename argument may=
=20
> be NULL", maybe these were previously logged into a ./'(null)' logfile?

Forget that comment, I need some caffeine.


