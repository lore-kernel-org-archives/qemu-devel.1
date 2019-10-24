Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F74CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D8F20679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D8F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcCL-0001TS-G5
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNbun-0002DT-Da
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNbum-0000wz-1E
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:08:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59306)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNbul-0000wg-PJ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:08:27 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D5A7F85539
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 12:08:25 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id v26so1171550wmh.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 05:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=69Yz9t5vXe3E2E5y37KYoVPQVihQITIuZnzPMtNlO8M=;
 b=r2VaILFC4/EAQU9gvHEIYjbTEg0akWBJVxBqqdj2q1phxKmuCdniwHgazNfrr1ZpRU
 +S9srahbFpL6IZ1ryh1pKPWKBQYtKhIQTf2Bg4+Ayw5zmMh8DDh2o36DbWqXbXNET4Xl
 zQJ2oz4vcBC6INULd+gCuzkpuq1cWDW3JYKc9NAyxJDYl6/hug3x/uxbp2sMMU88q9eH
 gH3Qd53L6zYPm8BR5//koMoIeTNd6t2Jzyck8dk/RvGPVJuGjya4eXlvPSPfeEXctFng
 +FKMIUsXFEU7YKo5ZrFqB/VwZUR2nTNvvTbfPLAZzrUo5iHgzFQ5chz9QCXxbbbQdjOI
 r28w==
X-Gm-Message-State: APjAAAUvLegtbOMg2+RyQ6cPbt1dDvYJk0jJburmUb75YWYThfGoWfr3
 jCspGmCJqsKaAn06toWaJMjzsSxnnnm4/acTCefE/EBwIuCBepzIt3+8sSsnWVcaZgIAUqfyyV0
 L60KAz+I5JujcSnM=
X-Received: by 2002:adf:e50a:: with SMTP id j10mr3404046wrm.352.1571918904482; 
 Thu, 24 Oct 2019 05:08:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxz0Y6gjnwSHejhYMfs35EF2pd2h84aWv1Ei8/c/b/yZnjF8qUnQ0vwkcXALUuJ84B+6D51IA==
X-Received: by 2002:adf:e50a:: with SMTP id j10mr3404027wrm.352.1571918904239; 
 Thu, 24 Oct 2019 05:08:24 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id l8sm9182104wru.22.2019.10.24.05.08.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 05:08:23 -0700 (PDT)
Subject: Re: [PATCH v2] mc146818rtc: fix timer interrupt reinjection
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
References: <20191010123008.GA19158@amt.cnet>
 <cc492782-8e5a-5c39-226d-a4e97cabf914@redhat.com>
Message-ID: <12f2aebb-6919-2ee0-f356-4000652ee3c3@redhat.com>
Date: Thu, 24 Oct 2019 14:08:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <cc492782-8e5a-5c39-226d-a4e97cabf914@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Xiao Guangrong <guangrong.xiao@gmail.com>,
 Vadim Rozenfeld <vrozenfe@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/19 1:22 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 10/10/19 2:30 PM, Marcelo Tosatti wrote:
>>
>> commit 369b41359af46bded5799c9ef8be2b641d92e043 broke timer interrupt
>> reinjection when there is no period change by the guest.
>>
>> In that case, old_period is 0, which ends up zeroing irq_coalesced
>> (counter of reinjected interrupts).
>>
>> The consequence is Windows 7 is unable to synchronize time via NTP.
>> Easily reproducible by playing a fullscreen video with cirrus and VNC.
>>
>> Fix by not updating s->irq_coalesced when old_period is 0.
>>
>> V2: reorganize code (Paolo Bonzini)
>=20
> ^ This line shouldn't be part of git history,
> Paolo if possible can you drop it?
>=20
>>
>> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
>>
>> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
>> index 6cb378751b..0e7cf97042 100644
>> --- a/hw/timer/mc146818rtc.c
>> +++ b/hw/timer/mc146818rtc.c
>> @@ -203,24 +203,28 @@ periodic_timer_update(RTCState *s, int64_t=20
>> current_time, uint32_t old_period)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 period =3D rtc_periodic_clock_ticks(s);
>> -=C2=A0=C2=A0=C2=A0 if (period) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* compute 32 khz clock */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur_clock =3D
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mu=
ldiv64(current_time, RTC_CLOCK_RATE,=20
>> NANOSECONDS_PER_SECOND);
>> +=C2=A0=C2=A0=C2=A0 if (!period) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->irq_coalesced =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timer_del(s->periodic_time=
r);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>=20
> This is the first change, simplify the if statement with a return.
>=20
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if the periodic timer's =
update is due to period=20
>> re-configuration,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we should count the cloc=
k since last interrupt.
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (old_period) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
t64_t last_periodic_clock, next_periodic_clock;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ne=
xt_periodic_clock =3D muldiv64(s->next_periodic_time,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RTC_CL=
OCK_RATE,=20
>> NANOSECONDS_PER_SECOND);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 la=
st_periodic_clock =3D next_periodic_clock - old_period;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lo=
st_clock =3D cur_clock - last_periodic_clock;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as=
sert(lost_clock >=3D 0);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 /* compute 32 khz clock */
>> +=C2=A0=C2=A0=C2=A0 cur_clock =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 muldiv64(current_time, RTC=
_CLOCK_RATE, NANOSECONDS_PER_SECOND);
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * if the periodic timer's update is due to p=
eriod re-configuration,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * we should count the clock since last inter=
rupt.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (old_period) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t last_periodic_cloc=
k, next_periodic_clock;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next_periodic_clock =3D mu=
ldiv64(s->next_periodic_time,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RTC_CLOCK_RATE, NANOSECONDS_PE=
R_SECOND);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_periodic_clock =3D ne=
xt_periodic_clock - old_period;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lost_clock =3D cur_clock -=
 last_periodic_clock;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(lost_clock >=3D 0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * s->irq_=
coalesced can change for two reasons:
>> @@ -251,22 +255,19 @@ periodic_timer_update(RTCState *s, int64_t=20
>> current_time, uint32_t old_period)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc_coalesced_timer_update(s);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * no way to compensate the interrupt if=20
>> LOST_TICK_POLICY_SLEW
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * is not used, we should make the time progress anyway.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 lost_clock =3D MIN(lost_clock, period);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>=20
> This is the second change, changing the logic and fixing the bug.
>=20
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(lost_clock >=3D 0 &=
& lost_clock <=3D period);
>> +=C2=A0=C2=A0=C2=A0 assert(lost_clock >=3D 0 && lost_clock <=3D period=
);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next_irq_clock =3D cur_clo=
ck + period - lost_clock;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->next_periodic_time =3D =
periodic_clock_to_ns(next_irq_clock)=20
>> + 1;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timer_mod(s->periodic_time=
r, s->next_periodic_time);
>> -=C2=A0=C2=A0=C2=A0 } else {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->irq_coalesced =3D 0;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timer_del(s->periodic_time=
r);
>> -=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 next_irq_clock =3D cur_clock + period - lost_clock=
;
>> +=C2=A0=C2=A0=C2=A0 s->next_periodic_time =3D periodic_clock_to_ns(nex=
t_irq_clock) + 1;
>> +=C2=A0=C2=A0=C2=A0 timer_mod(s->periodic_timer, s->next_periodic_time=
);
>=20
> This is part of the 1st change.
>=20
> I'd rather see this patch split in 2 logical changes...

Since this split makes sense to me (easier to understand the patch diff=20
when reviewing), I can quickly do it if you don't mind.

>> =C2=A0 }
>> =C2=A0 static void rtc_periodic_timer(void *opaque)
>>
>>

