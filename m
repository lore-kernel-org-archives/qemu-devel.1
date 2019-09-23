Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF434C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 15:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9559F20673
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 15:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9559F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCQ1D-00081f-Pv
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 11:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCQ0B-0007T4-QW
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 11:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCQ09-0002HT-Lm
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 11:11:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47570)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCQ09-0002Gx-DA
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 11:11:45 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D16592A09A7
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 15:11:43 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id n6so4942810wrm.20
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 08:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2iMzuuPa251sfDFdyUH3lp6mnbLiaArbh7c7v38p0zs=;
 b=K/2fpO+5OmdD7+7IM9ouXV74kzcjfdSPtIv8KLGWxnrujbZ1KauLIWkWsRYL40Ai1q
 Jp7u9jHj6CiD1TYM0p5ZTou6FkHiLxg+N+vD2f+/7Z7t+r67FyqUNN/R6vxtjn9a7VDr
 UOv2T/cOdyJFiHXWGA/B37mWMc6Xp+MilTqT4685wwJPWENCyeZ+ouHIgrssze5720pz
 eDRzNhReiXsRfhaDBY2eOLFNDI/IorABm35EBD+nMYKbaUsxVM+RRbBzj8RpwRp3TnNj
 epNbVGrY46mRPQ5c+rRJFkWIItH2/px4ym88YKFSzS9SR8eVDSEV+OCBWQXi0d/aFq1E
 lg1Q==
X-Gm-Message-State: APjAAAWwqozZyB5tfyVvjptQ6Xlc542F0x44Y+vZ0yvJ4QrEL+fLGNFx
 PZgeG/B9vWGmMaMemJ38fSTm+nKjnLetIkCaUjtNX3IeE00Jt1g+RW977jvU2mJVY9iw0R6uynT
 UMu6NCXzYva/0L/I=
X-Received: by 2002:a05:600c:2208:: with SMTP id
 z8mr109579wml.113.1569251502616; 
 Mon, 23 Sep 2019 08:11:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzDCXRTlUINGwFQhQitsS+3WNBTzT+Wi4q+hwFFK+CEk27SCz5qtYBgKj11Oy+AQoDNKbsw4w==
X-Received: by 2002:a05:600c:2208:: with SMTP id
 z8mr109560wml.113.1569251502458; 
 Mon, 23 Sep 2019 08:11:42 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id m16sm10474546wml.11.2019.09.23.08.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 08:11:41 -0700 (PDT)
Subject: Re: [PATCH] hw/ptimer: Assert next_event is newer than last_event
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190921101703.17935-1-philmd@redhat.com>
 <CAFEAcA8RfAPuV9LfL3c01KU+sCtAcWkHsLR7e-4QNJVcniq7Cg@mail.gmail.com>
 <ec6ddb30-6ae4-a3fb-e97c-58758df65650@redhat.com>
 <CAFEAcA8+3KjJ61n_U-eM4ydPTNQpok2VRMpwQecYMGhGxcf9tw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e166ee35-8a4c-5379-c933-9f561841ed9b@redhat.com>
Date: Mon, 23 Sep 2019 17:11:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8+3KjJ61n_U-eM4ydPTNQpok2VRMpwQecYMGhGxcf9tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Osipenko <digetx@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/19 5:08 PM, Peter Maydell wrote:
> On Mon, 23 Sep 2019 at 15:54, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
>>
>> On 9/23/19 4:40 PM, Peter Maydell wrote:
>>> On Sat, 21 Sep 2019 at 11:17, Philippe Mathieu-Daud=C3=A9 <philmd@red=
hat.com> wrote:
>>>>
>>>> If the period is too big, the 'delta * period' product result
>>>> might overflow, resulting in a negative number, then the
>>>> next_event ends before the last_event. This is buggy, as there
>>>> is no forward progress. Assert this can not happen.
>=20
>>> Can this only happen if a QEMU timer model using the ptimer
>>> code has a bug, or is it guest-triggerable for some of our
>>> timer models?
>>
>> I hit this running a raspi4 guest, I had incorrectly initialized a clo=
ck
>> using the core cpu frequency, while I had to use the APB one (in my
>> case, core_cpu_freq / 2). The guest use a high value to configure a sl=
ow
>> timer, which in my buggy case made QEMU hang in hard way to debug.
>>
>> So yes, it seems guest-triggerable if the implementation is broken.
>> Using assert() is OK for broken implementation, right?
>=20
> Yeah, if this can only happen if QEMU code is broken then
> an assert is OK. I was just trying to find out what the
> cause was, since "this is buggy" isn't specific about where
> the bug is.
>=20
>> Or should we audit all ptimer calls?
>=20
> I don't think we specifically need an audit. We could perhaps
> expand the comment by the assert to specifically say that if
> the calculation of the next event overflowed then this indicates
> a bug in the QEMU device model using the ptimer API, so if
> somebody else runs into the assert they have a hint about
> what to look at. (An overflowed next_event indicates a time
> incredibly far in the future, given that it's a nanosecond
> time in an int64_t.)

OK I'll improve the comment.

> The other approach I thought of would be to make the ptimer
> code handle this sort of after-the-end-of-QEMU-universe time
> by saturating next_event to INT64_MAX rather than letting it
> overflow and wrap. Unfortunately while this would be fine for
> the 'timer event' part of the code, it would break
> ptimer_get_count() which calculates the current counter
> value by looking at the difference between the current
> time and the time of the next event (fixable but only with
> a bunch of messing about to treat a next_event of INT64_MAX
> as equivalent to the counter being disabled and tracking
> the counter value in s->delta). So an assert is the
> best thing I think.

Yes :/

Thanks!

Phil.

