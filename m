Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50728CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5DA2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5DA2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNe6i-0005BC-Jc
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNd3h-0003Z1-1b
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNd3f-0005Aw-VX
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:21:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40818)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNd3f-0005Ad-NS
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:21:43 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A74658553A
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 13:21:42 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id k184so1013315wmk.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 06:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8ZmlhCsJoIE+YSUtfFBESR4PXWooISs73z1sPHAdYDc=;
 b=OJKxlx8F9N3xSYK4jKTw5JCB4ipkkZjVWgC7rpNsJQFOeJBdgAVKUbUXKJA4ANnVOy
 +5sW+IojbW3qMIJ0vwmNWGLvZmVsooi66QoB++NpqWpxXOwBrS2MdZt9s1fP7HoYknie
 9km00bXK1qCKAaodenXaoIQzYuhMJl6lA2FKXISzisGqhFRMX0SxgCUCMZhfRuMjbOkA
 qSFnHeeRrpHG2rnblLQYJ1wy0O13aQjX19lhVF4ZaV1U6RmtHO+GuKxNctMrtYf91hRB
 HHid7+SbJFBpYGj895d8umYNoD/LZNjbOYd11TyJrQF8zJJS8uSlaZ47Psp2IXSRpILq
 M82g==
X-Gm-Message-State: APjAAAXQi/pX4xWQdfeiFQIyXQMKtd2g40C3LbucfDHQW9GNhRpoYXG3
 maD5+SX+ppgvKFctpunOxULUkw+2epiU3vXh9C71hSNyG44IVkeCodkM0FEvDoJMuU9prVRag8q
 0pzSyrA9ZPeNJ8Zk=
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr4649890wmj.119.1571923301352; 
 Thu, 24 Oct 2019 06:21:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqymvv8boqLPyxAPcUuTqgjvrVyV1JC3xj+OMdE30JANiPp+8Xam/isesUk8gp7ZHrgMiAds7A==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr4649874wmj.119.1571923301146; 
 Thu, 24 Oct 2019 06:21:41 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id d8sm11908890wrr.71.2019.10.24.06.21.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 06:21:40 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] mc146818rtc: Tidy up indentation
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-devel@nongnu.org
References: <20191024122425.2483-1-philmd@redhat.com>
 <20191024122425.2483-3-philmd@redhat.com>
 <c4fef2c4-32f1-cb4a-295f-13a03434becd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fb0239d5-5705-9d31-8db2-198c0e6913db@redhat.com>
Date: Thu, 24 Oct 2019 15:21:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <c4fef2c4-32f1-cb4a-295f-13a03434becd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Xiao Guangrong <guangrong.xiao@gmail.com>,
 Vadim Rozenfeld <vrozenfe@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/19 3:01 PM, Paolo Bonzini wrote:
> On 24/10/19 14:24, Philippe Mathieu-Daud=C3=A9 wrote:
>> -        * if the periodic timer's update is due to period re-configur=
ation,
>> -        * we should count the clock since last interrupt.
>> -        */
>> -        if (old_period) {
>> -            int64_t last_periodic_clock, next_periodic_clock;
>> +    /*
>> +     * if the periodic timer's update is due to period re-configurati=
on,
>> +     * we should count the clock since last interrupt.
>> +     */
>> +    if (old_period) {
>> +        int64_t last_periodic_clock, next_periodic_clock;
>>  =20
>> -            next_periodic_clock =3D muldiv64(s->next_periodic_time,
>> -                                    RTC_CLOCK_RATE, NANOSECONDS_PER_S=
ECOND);
>> -            last_periodic_clock =3D next_periodic_clock - old_period;
>> -            lost_clock =3D cur_clock - last_periodic_clock;
>> -            assert(lost_clock >=3D 0);
>> +        next_periodic_clock =3D muldiv64(s->next_periodic_time,
>> +                                RTC_CLOCK_RATE, NANOSECONDS_PER_SECON=
D);
>> +        last_periodic_clock =3D next_periodic_clock - old_period;
>> +        lost_clock =3D cur_clock - last_periodic_clock;
>> +        assert(lost_clock >=3D 0);
>>           }
>>  =20
>>           /*
>=20
> Still not entirely tidy, is it?  I understand making Marcelo's fix just
> move a brace, but in general you can review with "git show -b" to see
> more clearly what's going on.  Therefore, it would make the most sense
> to have just two patches, one reversing the if and one fixing the bug
> (and both of them having indentation changes).
>=20
> However, I'm preparing the pull request now so I think I'll just keep
> Marcelo's version.

OK.

