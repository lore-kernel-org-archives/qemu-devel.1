Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E88CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488FF2065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CiCDC7uL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488FF2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0SDB-0004DJ-Iw
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 12:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k0SCG-0003aY-A8
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:11:20 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k0SCE-000136-H1
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:11:19 -0400
Received: by mail-wm1-x344.google.com with SMTP id k8so95553wma.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 09:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=9fcA43p5Zyv/yaGKg2BoUOe5ZdmHBDfute646ZCEFA4=;
 b=CiCDC7uL9ta2V4++jzN9jEaym9bP9p8H2NxIsA5ow3W8rPlXM3G/VcfLhvg+daRAlq
 YpIbKmuV9xrCnJi6FvaTr4ce6eMh369ecwu/GO/AN7/sHALpT0qwsF+IIYH9IsPrNglo
 LoFnzI8Hh4nj1wI1RHEsmTvJvi7sU1GKzobGWCHHHjEYPhUti9eU1HypAQsj504v+P9U
 sfniZsCeX/GMhbP/3r08NEJV88fF30pIhdzDJM1q0rInTPthOfcA62S8Cgz2tXPr7PJN
 8scxZA+CwxXS0Eou1JL8m3slgfMuozSXzBZ6Wn44oE04CyRd8oEcoexjCdz4S3VBN8Cm
 fwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=9fcA43p5Zyv/yaGKg2BoUOe5ZdmHBDfute646ZCEFA4=;
 b=XY+nvqCob8DUCemalDyjlPIEHvT1V58uAJrBTPmGZgqUvPexbVnioetZepIR1vWj3L
 9UgMnwDqtG5z07dgGjFcfMv/XB2ZZPN6kYeJJ4phXLZvSXvhvtlkteET8blku0dtrGrD
 Uwt0838zC2+ESq4T3dmAP4sV5BxaNZq7XBfjfLCpYGAafS8xi0x+ydwxm/SCmZ2VnLym
 lyams/exXruyuiLMV+1t9Ajyc1YoCerSfgp6Zfina0sYMDg7gG6hZLUREqnnbwK49n5h
 9KvcBkh46dHuwOSOxQv32TG9ebW7+Oy5npAEtNkFc+LT3qi9gskWFGffVRg+5DigTGph
 VrCw==
X-Gm-Message-State: AOAM533rHiEvGFnubEaOM24sVtDhm/yp+nE/lQ8EvN61uznBA6U/iVV4
 V4YqxMf46qhyaJ+0ip/LuQiyyg==
X-Google-Smtp-Source: ABdhPJz88M7/DOBM+t/bU6x0Pgl8kjudMBkfZqQPOkjBNODdCBcZwXfqspje4g1RfKJ9k1uSLL8azQ==
X-Received: by 2002:a7b:c0c8:: with SMTP id s8mr4849741wmh.4.1595952676828;
 Tue, 28 Jul 2020 09:11:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z127sm5230763wme.44.2020.07.28.09.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 09:11:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0111F1FF7E;
 Tue, 28 Jul 2020 17:11:14 +0100 (BST)
References: <20200728141005.28664-1-alex.bennee@linaro.org>
 <20200728141005.28664-3-alex.bennee@linaro.org>
 <CAFEAcA_MT8U6uUYhNVDc1-AkxPPL22pBevNDSbB2ZwQQ94OPmw@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 2/2] target/arm: only set the nexttick timer if !ISTATUS
In-reply-to: <CAFEAcA_MT8U6uUYhNVDc1-AkxPPL22pBevNDSbB2ZwQQ94OPmw@mail.gmail.com>
Date: Tue, 28 Jul 2020 17:11:14 +0100
Message-ID: <87lfj339i5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Igor R <boost.lists@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Victor CLEMENT <victor.clement@openwide.fr>, "open
 list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Pavel Dovgaluk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 28 Jul 2020 at 15:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Otherwise we have an unfortunate interaction with -count sleep=3Doff
>> which means we fast forward time when we don't need to. The easiest
>> way to trigger it was to attach to the gdbstub and place a break point
>> at the timers IRQ routine. Once the timer fired setting the next event
>> at INT_MAX then qemu_start_warp_timer would skip to the end.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  target/arm/helper.c | 35 ++++++++++++++++++++++-------------
>>  1 file changed, 22 insertions(+), 13 deletions(-)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index c69a2baf1d3..ec1b84cf0fd 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -2683,7 +2683,7 @@ static void gt_recalc_timer(ARMCPU *cpu, int timer=
idx)
>>          uint64_t count =3D gt_get_countervalue(&cpu->env);
>>          /* Note that this must be unsigned 64 bit arithmetic: */
>>          int istatus =3D count - offset >=3D gt->cval;
>> -        uint64_t nexttick;
>> +        uint64_t nexttick =3D 0;
>>          int irqstate;
>>
>>          gt->ctl =3D deposit32(gt->ctl, 2, 1, istatus);
>> @@ -2692,21 +2692,30 @@ static void gt_recalc_timer(ARMCPU *cpu, int tim=
eridx)
>>          qemu_set_irq(cpu->gt_timer_outputs[timeridx], irqstate);
>>
>>          if (istatus) {
>> -            /* Next transition is when count rolls back over to zero */
>> -            nexttick =3D UINT64_MAX;
>> +            /*
>> +             * The IRQ status of the timer will persist until:
>> +             *   - CVAL is changed or
>> +             *   - ENABLE is changed
>> +             *
>> +             * There is no point re-arming the timer for some far
>> +             * flung future - currently it just is.
>> +             */
>> +            timer_del(cpu->gt_timer[timeridx]);
>
> Why do we delete the timer for this case of "next time we need to
> know is massively in the future"...

It's not really - it's happening now and it will continue to happen
until the IRQ is serviced or we change the CVAL at which point we can
calculate the next time we need it.

>
>>          } else {
>>              /* Next transition is when we hit cval */
>>              nexttick =3D gt->cval + offset;
>> -        }
>> -        /* Note that the desired next expiry time might be beyond the
>> -         * signed-64-bit range of a QEMUTimer -- in this case we just
>> -         * set the timer for as far in the future as possible. When the
>> -         * timer expires we will reset the timer for any remaining peri=
od.
>> -         */
>> -        if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
>> -            timer_mod_ns(cpu->gt_timer[timeridx], INT64_MAX);
>> -        } else {
>> -            timer_mod(cpu->gt_timer[timeridx], nexttick);
>> +
>> +            /*
>> +             * It is possible the next tick is beyond the
>> +             * signed-64-bit range of a QEMUTimer but currently the
>> +             * timer system doesn't support a run time of more the 292
>> +             * odd years so we set it to INT_MAX in this case.
>> +             */
>> +            if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
>> +                timer_mod_ns(cpu->gt_timer[timeridx], INT64_MAX);
>
> ...but here we handle the similar case by "set a timeout for
> INT64_MAX" ?

Yeah we could just swallow it up and report something to say it's not
going to happen because it's beyond the horizon of what QEMUTimer can
deal with.

>
>> +            } else {
>> +                timer_mod(cpu->gt_timer[timeridx], nexttick);
>> +            }
>>          }
>>          trace_arm_gt_recalc(timeridx, irqstate, nexttick);
>>      } else {
>> --
>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

