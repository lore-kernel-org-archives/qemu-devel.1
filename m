Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1A0C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:56:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 354642077D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUrU97Vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354642077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKQYK-0006eS-Du
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 13:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKQXD-00068J-Vq
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKQXB-0004Fj-Qw
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:55:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22085
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKQXB-0004Bb-8A
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585936512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmehEILHrX9WwIp4elmxGTw8590p87FIqHWAh7W8lIo=;
 b=bUrU97VlmG3Dd4WtL2i5sE7489QkXaIzB6EUCu9Mwu0eXbMVJYaaEGrGjBx3Zg4YTyd56u
 96YWBv6I+V0Fp7Vs5hSx1ceJjvwsHrIr5mM+vM21Hc2nRY5eyEJcsaOFK65de5HmqLjOjb
 Vl+x8Gyl6SsyEDSWzwrWnUCtkyv4Z/g=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-3SWoKtsBNEaQcn1m5RhNOA-1; Fri, 03 Apr 2020 13:55:10 -0400
X-MC-Unique: 3SWoKtsBNEaQcn1m5RhNOA-1
Received: by mail-ed1-f70.google.com with SMTP id q29so6159203edc.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 10:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9tia9T/GV57y9Qfa5U89Aqjno0f66akZls6Djw6Sa6s=;
 b=HT23oVyBnTU48IGC0lR8BVlT6er+3nDDSkgHLKoazVTZcz2U7ESfhcud/L8aGjTfU+
 q/iUsy9wT3Oqeqe5/RRDC5seLf+8KWveknBkjMrCb7l6Zvvl/Nr7nKFQwmcS+nIjLnaV
 BhmzLYgO86QzrJgZxSICQ9wBL8zRx+xiAZyBifsGF21lS6MaqnBgt4G/qZJPZE4sOBdQ
 gwYKa7w7xjy5mFknp01SnolscS0t5+vkfOdr1Qn3skM5QAdtpUeA/fz2e/wUUhlRe+KF
 NKQNiERcQX1JJqpA50cVUpM0hO9DGU/7UCozbsWv1zbXIk9eUkW33zG8NsRvzExY29lw
 zXgA==
X-Gm-Message-State: AGi0Pub0rIX3wzzBrM2sSa89pyDxlNoJOOscSdQk/fI85Apdu47Vm7E5
 Ek6TqqeVqmxX0CSYTGEGQez8jOtn5thi7UQjY4S4iIgtbpPptwYMiIl8Gw/ioi7uE+6ZEKEarE+
 f615N3+RInNMb/+g=
X-Received: by 2002:a17:906:158c:: with SMTP id
 k12mr9748674ejd.7.1585936509091; 
 Fri, 03 Apr 2020 10:55:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypIWMkDiACQMrP2SEiGRilr0/t41cwgWv2XflFf9g8T+GsSTDM454a1TAO9vKhd8DKDx5Ox/cw==
X-Received: by 2002:a17:906:158c:: with SMTP id
 k12mr9748656ejd.7.1585936508852; 
 Fri, 03 Apr 2020 10:55:08 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id l24sm1687488ejx.81.2020.04.03.10.55.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2020 10:55:08 -0700 (PDT)
Subject: Re: [PATCH-for-5.0?] configure: Do not leave sphinx in-tree artifacts
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20200403165422.21714-1-philmd@redhat.com>
 <CAFEAcA-BAvi3HEuvpMyyir9CqAbkg3nF3920zBVF-sPyFz++Rg@mail.gmail.com>
 <7c976a7a-beeb-e3ce-5760-e4239ff7dd1f@redhat.com>
 <41cac243-105c-51c9-3747-7ee23441b226@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <71170787-ee52-ef0e-0732-94da6875ad11@redhat.com>
Date: Fri, 3 Apr 2020 19:55:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <41cac243-105c-51c9-3747-7ee23441b226@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/20 7:49 PM, Eric Blake wrote:
> On 4/3/20 12:37 PM, Eric Blake wrote:
>> On 4/3/20 11:57 AM, Peter Maydell wrote:
>>> On Fri, 3 Apr 2020 at 17:54, Philippe Mathieu-Daud=C3=A9=20
>>> <philmd@redhat.com> wrote:
>>>>
>>>> When ./configure checks the sphinx version is new enough, it leaves
>>>> the docs/sphinx/__pycache__/ directory. Avoid this by using the '-B'
>>>> option (don't write .py[co] files on import) via the
>>>> PYTHONDONTWRITEBYTECODE environment variable.
>>>>
>>>> Reported-by: Eric Blake <eblake@redhat.com>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>
>>> This only happens for an in-tree build, right? I think in
>>> that case you're kind of OK with having random stuff
>>> left in the source tree... It seems easy enough to suppress
>>> them though, so I guess we might as well.
>>
>> It happens in VPATH too - and what's more, in VPATH, it is still=20
>> creating it under srcdir rather than builddir, which feels like=20
>> unnecessary pollution.=C2=A0 I was trying to prove whether 'make distcle=
an'=20
>> got us back to a pristine state; this was one of the files that=20
>> escaped 'make distclean', so our choice is to either add it to the=20
>> clean rules, or to avoid creating it in the first place.=C2=A0 I like th=
e=20
>> approach of not creating it in the first place :)
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Hmm, I spoke early.=C2=A0 Your patch only addresses the pollution during=
=20
> './configure'.=C2=A0 But running 'make' (even in a VPATH build) equally=
=20
> creates the same pollution.=C2=A0 Which means we really ought to be clean=
ing=20
> it up during 'make distclean' rather than just trying to make=20
> './configure' clever.

Oh I only checked ./configure indeed, sorry. Thanks for testing!


