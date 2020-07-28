Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52301C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19916206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cpcwFmQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19916206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0QQa-0002ee-D3
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 10:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0QPb-0001sM-FD
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:16:59 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0QPZ-0007hd-8r
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:16:59 -0400
Received: by mail-oi1-x243.google.com with SMTP id j7so1201291oij.9
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rdnN0X/ThvV/+IE7SkFHAJZ+z5tKV4xGikHJFATXOCs=;
 b=cpcwFmQz7KxMstz7oLTWoG1iu8b0+rKoSHzeMYUbxl0TWa4xrq5zgPWmFdASDIA67M
 ctZktKcW4BVKrEk8OSqmjVVK6zrK2QONP4yLD3l0PYXYDkT7i7ER20XPirk4jgrMenrg
 umOXyn+zk9JqrwYaOJV/crB6dPbMNv2N1jm3yGQi7BBtp9HMPXxThEXvCoOIoL1j3x34
 o8SRcqR+Wp7qqWtkMCqNA1NkkN+TdLfTmB1a+36oFvjQTOltGQUIpZeOp3BsMo40BshL
 oYjduV/WlUcvB4kt8UemPZvHzjrPKFMvdTMLPSIOXxUtzM5qSiA/+bpsr3DEjcosjxV6
 GqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rdnN0X/ThvV/+IE7SkFHAJZ+z5tKV4xGikHJFATXOCs=;
 b=eO1phi5T/5WUC4T/XYLRqO4SJh4U+0xn+6DzusAatgLsYfZFc+DHLsDAtNpZWVpSdI
 2pkQPdLINEipnjsbsRP8z9X29FUXl9C3Xhc89++6gyuvPsR5ij6ItrxtucKqH9ej2tBI
 3LlGbKmi0gwkt8gEDl7Q3q+JDV2NuCSamVXjCPsziUGLo7G7E4C8X1jk8DwKK6b9fTw1
 3nnGvvl6f8nkuCEPcn6TrRgsGM4UO0bklhP7S76CYlt2gLBAooDr/O5zzqSyM+0UioES
 F+aJQa0jdKMQFjmgApAt6Cy3Fg6Ti33iWl7Pnkpcvc+xO3ALVXjZgo78TvN7w72WThEu
 6+xg==
X-Gm-Message-State: AOAM531pSCsygVk403M1xkp8IvBcsAl8eeqUKARy8h74GjneV5sxxFbT
 Yc8WVaPtcHQ44pivQ86ic3UldT/dToL9N31jVAas9g==
X-Google-Smtp-Source: ABdhPJx5vCUJ8gMSKJL23ElN8AZ9XZIpjANZSA5ybwdbo3vr3t1Z4kP3ilISomYYGTJCqn7A4YYdhNCHE8W08s8b+Lc=
X-Received: by 2002:aca:4a96:: with SMTP id x144mr3615537oia.163.1595945815872; 
 Tue, 28 Jul 2020 07:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200728141005.28664-1-alex.bennee@linaro.org>
 <20200728141005.28664-3-alex.bennee@linaro.org>
In-Reply-To: <20200728141005.28664-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 15:16:44 +0100
Message-ID: <CAFEAcA_MT8U6uUYhNVDc1-AkxPPL22pBevNDSbB2ZwQQ94OPmw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] target/arm: only set the nexttick timer if !ISTATUS
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
 Victor CLEMENT <victor.clement@openwide.fr>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Pavel Dovgaluk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 at 15:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Otherwise we have an unfortunate interaction with -count sleep=3Doff
> which means we fast forward time when we don't need to. The easiest
> way to trigger it was to attach to the gdbstub and place a break point
> at the timers IRQ routine. Once the timer fired setting the next event
> at INT_MAX then qemu_start_warp_timer would skip to the end.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/arm/helper.c | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index c69a2baf1d3..ec1b84cf0fd 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2683,7 +2683,7 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeri=
dx)
>          uint64_t count =3D gt_get_countervalue(&cpu->env);
>          /* Note that this must be unsigned 64 bit arithmetic: */
>          int istatus =3D count - offset >=3D gt->cval;
> -        uint64_t nexttick;
> +        uint64_t nexttick =3D 0;
>          int irqstate;
>
>          gt->ctl =3D deposit32(gt->ctl, 2, 1, istatus);
> @@ -2692,21 +2692,30 @@ static void gt_recalc_timer(ARMCPU *cpu, int time=
ridx)
>          qemu_set_irq(cpu->gt_timer_outputs[timeridx], irqstate);
>
>          if (istatus) {
> -            /* Next transition is when count rolls back over to zero */
> -            nexttick =3D UINT64_MAX;
> +            /*
> +             * The IRQ status of the timer will persist until:
> +             *   - CVAL is changed or
> +             *   - ENABLE is changed
> +             *
> +             * There is no point re-arming the timer for some far
> +             * flung future - currently it just is.
> +             */
> +            timer_del(cpu->gt_timer[timeridx]);

Why do we delete the timer for this case of "next time we need to
know is massively in the future"...

>          } else {
>              /* Next transition is when we hit cval */
>              nexttick =3D gt->cval + offset;
> -        }
> -        /* Note that the desired next expiry time might be beyond the
> -         * signed-64-bit range of a QEMUTimer -- in this case we just
> -         * set the timer for as far in the future as possible. When the
> -         * timer expires we will reset the timer for any remaining perio=
d.
> -         */
> -        if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
> -            timer_mod_ns(cpu->gt_timer[timeridx], INT64_MAX);
> -        } else {
> -            timer_mod(cpu->gt_timer[timeridx], nexttick);
> +
> +            /*
> +             * It is possible the next tick is beyond the
> +             * signed-64-bit range of a QEMUTimer but currently the
> +             * timer system doesn't support a run time of more the 292
> +             * odd years so we set it to INT_MAX in this case.
> +             */
> +            if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
> +                timer_mod_ns(cpu->gt_timer[timeridx], INT64_MAX);

...but here we handle the similar case by "set a timeout for
INT64_MAX" ?

> +            } else {
> +                timer_mod(cpu->gt_timer[timeridx], nexttick);
> +            }
>          }
>          trace_arm_gt_recalc(timeridx, irqstate, nexttick);
>      } else {
> --

thanks
-- PMM

