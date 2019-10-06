Return-Path: <SRS0=2u83=X7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9DDC4360C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 16:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3795D20835
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 16:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcYapCxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3795D20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iH93c-0000cT-DT
	for qemu-devel@archiver.kernel.org; Sun, 06 Oct 2019 12:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iH92o-0000Aw-Uf
 for qemu-devel@nongnu.org; Sun, 06 Oct 2019 12:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iH92m-0003vt-7U
 for qemu-devel@nongnu.org; Sun, 06 Oct 2019 12:06:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46442
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iH92l-0003u4-Ul
 for qemu-devel@nongnu.org; Sun, 06 Oct 2019 12:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570377958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=z7yoEbkDQ1kB+hHKsv2TCkBm65bfT4uy3xqLS2veNQo=;
 b=KcYapCxTvp4oa3vJ2LSHiC+L+z8mDUPMpzlYbvTU7XZ3/H6AanIgNAm4qk4oCvAe0OhpBg
 P0XHm0HoeLr/5+HtCKLvJXJ/K9+KfHlErwGUY5V7SDeAcgL3ATKSBAZ3b5Gyqnvb4L0qsc
 WL1QQ3HPxF1rUfrAxYdYfE6nVmS4fnE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-j_ItwBgbN8CVoJuyqy8P1g-1; Sun, 06 Oct 2019 12:05:56 -0400
Received: by mail-wm1-f69.google.com with SMTP id n3so4597493wmf.3
 for <qemu-devel@nongnu.org>; Sun, 06 Oct 2019 09:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TzxWDJRON3vkxrouOX90qTTCQaVZhH9arDlwvYsLjxQ=;
 b=euYYoSAjZXMfhR2lMYLlGAqWfVkz5IWRi9/qQ0TN4bFHqJDZTeoc73REXbX6Ikc7ZF
 3OamsuZ65NnDsBoY45H39W09/7L11w1ORf7jd1SOvBmMPxY0JXOjTRv2cQimXXVrTbDz
 NiJB+AJ6ZM+VVNDk6pqzJafvMGATjv9zuqLJNy+ruzTNlbqNktiQiLTgoVZp2hnQ2jIR
 Exk3FunmOVtJNyQ59Mcagkp8XUgBRyaCIAEvoqJpwdecq0cfPE/x2ItMpm/UW4vMqeiW
 tbtms0UGYFHegQdS7dA+1Qx5sz7JfF6jZTOjPAJa7h+Jyk5uJeXV1b3dvmWH7ZMydo3z
 p9cA==
X-Gm-Message-State: APjAAAU2Hd5JmVbPESFgRhPCTbaW2FBNYjNejntMn4CVtKuuHHKVGIn2
 w/kXj8/6Rmsrd80+IeSJUQ3D/od7+9so1VPvzXPb22wUvNrTocYkXWwqHnLrmLjgzJubi3eco9I
 QOkCMTuJJbcZSWts=
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr18499684wmi.39.1570377955079; 
 Sun, 06 Oct 2019 09:05:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw/pP849OKRf7+fSKR1NGT3g6rj/zcnRspP0aI+5uwSIQwjWuzEvimYxtuZ8L4J/MwQpaD7nA==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr18499674wmi.39.1570377954761; 
 Sun, 06 Oct 2019 09:05:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e876:e214:dc8e:2846?
 ([2001:b07:6468:f312:e876:e214:dc8e:2846])
 by smtp.gmail.com with ESMTPSA id t123sm20211990wma.40.2019.10.06.09.05.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Oct 2019 09:05:53 -0700 (PDT)
Subject: Re: [PATCH] cpus: kick all vCPUs when running thread=single
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191001160426.26644-1-alex.bennee@linaro.org>
 <5582c91e-ac0e-9f74-a3de-82f7fe25fadd@redhat.com> <874l0sl5z6.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d25121c7-e499-95e4-840e-4de53a4469f2@redhat.com>
Date: Sun, 6 Oct 2019 18:05:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <874l0sl5z6.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: j_ItwBgbN8CVoJuyqy8P1g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Doug Gale <doug16k@gmail.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/10/19 19:40, Alex Benn=C3=A9e wrote:
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> On 01/10/19 18:04, Alex Benn=C3=A9e wrote:
>>> qemu_cpu_kick is used for a number of reasons including to indicate
>>> there is work to be done. However when thread=3Dsingle the old
>>> qemu_cpu_kick_rr_cpu only advanced the vCPU to the next executing one
>>> which can lead to a hang in the case that:
>>>
>>>   a) the kick is from outside the vCPUs (e.g. iothread)
>>>   b) the timers are paused (i.e. iothread calling run_on_cpu)
>>>
>>> To avoid this lets split qemu_cpu_kick_rr into two functions. One for
>>> the timer which continues to advance to the next timeslice and another
>>> for all other kicks.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Cc: Doug Gale <doug16k@gmail.com>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>  cpus.c | 24 ++++++++++++++++++------
>>>  1 file changed, 18 insertions(+), 6 deletions(-)
>>
>> Looks good to me.  Single-threaded TCG is not going to have high vCPU
>> counts anyway.
>=20
> Are you going to take this via your queue?

I wasn't, since we have had a proper TCG maintainer for a while. :)

Paolo

>=20
>>
>> Paolo
>>
>>> diff --git a/cpus.c b/cpus.c
>>> index d2c61ff155..bee7209134 100644
>>> --- a/cpus.c
>>> +++ b/cpus.c
>>> @@ -949,8 +949,8 @@ static inline int64_t qemu_tcg_next_kick(void)
>>>      return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + TCG_KICK_PERIOD;
>>>  }
>>>
>>> -/* Kick the currently round-robin scheduled vCPU */
>>> -static void qemu_cpu_kick_rr_cpu(void)
>>> +/* Kick the currently round-robin scheduled vCPU to next */
>>> +static void qemu_cpu_kick_rr_next_cpu(void)
>>>  {
>>>      CPUState *cpu;
>>>      do {
>>> @@ -961,6 +961,16 @@ static void qemu_cpu_kick_rr_cpu(void)
>>>      } while (cpu !=3D atomic_mb_read(&tcg_current_rr_cpu));
>>>  }
>>>
>>> +/* Kick all RR vCPUs */
>>> +static void qemu_cpu_kick_rr_cpus(void)
>>> +{
>>> +    CPUState *cpu;
>>> +
>>> +    CPU_FOREACH(cpu) {
>>> +        cpu_exit(cpu);
>>> +    };
>>> +}
>>> +
>>>  static void do_nothing(CPUState *cpu, run_on_cpu_data unused)
>>>  {
>>>  }
>>> @@ -993,7 +1003,7 @@ void qemu_timer_notify_cb(void *opaque, QEMUClockT=
ype type)
>>>  static void kick_tcg_thread(void *opaque)
>>>  {
>>>      timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
>>> -    qemu_cpu_kick_rr_cpu();
>>> +    qemu_cpu_kick_rr_next_cpu();
>>>  }
>>>
>>>  static void start_tcg_kick_timer(void)
>>> @@ -1828,9 +1838,11 @@ void qemu_cpu_kick(CPUState *cpu)
>>>  {
>>>      qemu_cond_broadcast(cpu->halt_cond);
>>>      if (tcg_enabled()) {
>>> -        cpu_exit(cpu);
>>> -        /* NOP unless doing single-thread RR */
>>> -        qemu_cpu_kick_rr_cpu();
>>> +        if (qemu_tcg_mttcg_enabled()) {
>>> +            cpu_exit(cpu);
>>> +        } else {
>>> +            qemu_cpu_kick_rr_cpus();
>>> +        }
>>>      } else {
>>>          if (hax_enabled()) {
>>>              /*
>>>
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20


