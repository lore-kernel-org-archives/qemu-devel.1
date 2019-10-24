Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A52CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B84721872
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B84721872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeBM-00055V-R4
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iNckT-0005WE-EM
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:01:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iNckR-0002bp-Kb
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:01:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iNckR-0002bR-C8
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:01:51 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 37343C049E17
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 13:01:50 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id z23so1056068wml.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 06:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vSc3owgLawv5MFYpzoX1TjEMMoTIOV7tcHhCX7Da5OU=;
 b=kBDk/HdBULoTgqZukT8KyH44zIyQqbAtvF+I9K5+Heqzd06edvUJLmX+twKtPutx0y
 nQXX2ibASh4KnJdx4gA5+8ysw53I8Rp//MvnBu08m2X+dt4bO5XNLsE4UgeOx+aezgo1
 jAfXFGzR3BAHb8Rnyg1oDBCeG/Q4LIhJi3wEJEfcoL7ScHLVjAtHwGRNQxiDpNOHByPz
 Aj/4uh7OkwbEB/AZbiTHaxwFfE9XeMhySQmS+U8PkwFf9oB/antsgTvD28eFdYx/HDf7
 iGhObFWIXg6VL3iHbXmqei0bF4G7Zin0MT28ejCo63i4FTlyM6ulptjXDnTdUr08DZJ9
 +0AQ==
X-Gm-Message-State: APjAAAUTg9Ig9/yDp07x3ujx7LDdoWTjSNPUWFuzhcQgtWLObLoxf2Oc
 cBIDkYD0ZmRmR0fNzNv283uuV9ISzuQvcV5832wLtJxIG/JyKQRUG/AE2NkndQWx3dHR4/qpwJA
 +KQytYj8ZWwWGmTE=
X-Received: by 2002:a5d:678e:: with SMTP id v14mr3619906wru.393.1571922108833; 
 Thu, 24 Oct 2019 06:01:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwl0fRVb3Fl2P3Dg7gTf20NvmYh1CwZwia+rb6tod4kvBQCQOXsmPwICPFjkPdwIMKF83Wg5w==
X-Received: by 2002:a5d:678e:: with SMTP id v14mr3619855wru.393.1571922108419; 
 Thu, 24 Oct 2019 06:01:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6887:47f9:72a7:24e6?
 ([2001:b07:6468:f312:6887:47f9:72a7:24e6])
 by smtp.gmail.com with ESMTPSA id h10sm22506591wrq.95.2019.10.24.06.01.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 06:01:47 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] mc146818rtc: Tidy up indentation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
References: <20191024122425.2483-1-philmd@redhat.com>
 <20191024122425.2483-3-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c4fef2c4-32f1-cb4a-295f-13a03434becd@redhat.com>
Date: Thu, 24 Oct 2019 15:01:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191024122425.2483-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
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

On 24/10/19 14:24, Philippe Mathieu-Daud=C3=A9 wrote:
> -        * if the periodic timer's update is due to period re-configura=
tion,
> -        * we should count the clock since last interrupt.
> -        */
> -        if (old_period) {
> -            int64_t last_periodic_clock, next_periodic_clock;
> +    /*
> +     * if the periodic timer's update is due to period re-configuratio=
n,
> +     * we should count the clock since last interrupt.
> +     */
> +    if (old_period) {
> +        int64_t last_periodic_clock, next_periodic_clock;
> =20
> -            next_periodic_clock =3D muldiv64(s->next_periodic_time,
> -                                    RTC_CLOCK_RATE, NANOSECONDS_PER_SE=
COND);
> -            last_periodic_clock =3D next_periodic_clock - old_period;
> -            lost_clock =3D cur_clock - last_periodic_clock;
> -            assert(lost_clock >=3D 0);
> +        next_periodic_clock =3D muldiv64(s->next_periodic_time,
> +                                RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND=
);
> +        last_periodic_clock =3D next_periodic_clock - old_period;
> +        lost_clock =3D cur_clock - last_periodic_clock;
> +        assert(lost_clock >=3D 0);
>          }
> =20
>          /*

Still not entirely tidy, is it?  I understand making Marcelo's fix just
move a brace, but in general you can review with "git show -b" to see
more clearly what's going on.  Therefore, it would make the most sense
to have just two patches, one reversing the if and one fixing the bug
(and both of them having indentation changes).

However, I'm preparing the pull request now so I think I'll just keep
Marcelo's version.

Paolo

