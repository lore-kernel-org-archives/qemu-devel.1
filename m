Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845BCC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:19:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503632051A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SBbixkgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503632051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBGRA-0005iB-I5
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 07:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBGQV-00050C-AD
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBGQT-00008J-WC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:18:26 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41917)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBGQT-00007Y-Ox
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:18:25 -0400
Received: by mail-oi1-x242.google.com with SMTP id i1so9706309oie.8
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 04:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tPVIgXL/FdByrIYAPc7+POTrdEznd6YhHH7HyAf5JHk=;
 b=SBbixkgNQt6QCn4/I57V+qNf/5/Ie8XtqhnDC427jT3u9BlUjs0vEsEMk4+5Bxd82E
 QWpKEIqeuHivIrkGLuB4EY/kAU6ylhj2LYMl3vUPYloeVxHenPVFPfYtBQcG5JVHHxXH
 1VfnMux7qDWH83qVLG4KWSdhSkge4X46lU3HUaJTTHMGUhUqbrPIBAz7hRBseg2IS+6k
 o4t/9kWFSDnB5exz43EpJGuEojjrSzL4eHM7k9SgHZ87leYFYP3xb2XNoRuIPfklmCpd
 C5TDewwPcxwYfsOPPNHWS9+9lpGx64L2NpmXwradkWAFIyw4Y20qaSd5nFSagDtixLD4
 bjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tPVIgXL/FdByrIYAPc7+POTrdEznd6YhHH7HyAf5JHk=;
 b=PrdSBsHtWMbcXJWqzztYNmGOgXk/Ed9cEs2dLdvxy8DzUt4wWvVO4PG4Bvp9grrF49
 aFILp2nekxbYCr1SiFDWY4d8SZTmcesIx7pyIrh78J6WjphlF64qCSDabrzYkCgOaInT
 iY+vHpHvZ/a8n0EdHEOHdxWq9Cul3VJPm6QZCDyn7Yya9AUOG3XyuXhuEOaAD9moCc8N
 nKfwJe83PUZ+d6OBV7h93nrdZYDaoJwalzudnQnQ/8FF4p+IA1HOqtr1ROD9z1X7yP4X
 gUHUFTK1+VtblSuZFaoaO/wld+m/IUfNafMv1/xybGWS9ZW7BUn3Vi0YimTFLfnj3qkA
 6alQ==
X-Gm-Message-State: ANhLgQ2x1lpS3qABW+LsclloYIe6HbQZDcTcw9yUyTg54YhTNf18NXF8
 cMFutRx9FW4DWA9LWrZYu2hRhGl3q0q2WWRKdVpWhg==
X-Google-Smtp-Source: ADFU+vvYMl+XkB6EY3jdh0NZlSDjk+IY5/RbOSWCl2FkYxuz057GyycYa1IeeSVrOIu8J9upLeIwNPGlOyshHr81pQs=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr11283474oiy.170.1583752703873; 
 Mon, 09 Mar 2020 04:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
 <20200301215029.15196-7-nieklinnenbank@gmail.com> <87d09t7i8i.fsf@linaro.org>
 <CAPan3Wo6_15zFSHJwf0hVq9CVUSfOBU+frwSLQX21SWrXW03iA@mail.gmail.com>
In-Reply-To: <CAPan3Wo6_15zFSHJwf0hVq9CVUSfOBU+frwSLQX21SWrXW03iA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2020 11:18:12 +0000
Message-ID: <CAFEAcA_wTrqgAh+NK5jmtqPeU9y6bhouzaXWQyPR_iYU5waOGg@mail.gmail.com>
Subject: Re: [PATCH v6 06/18] hw/arm/allwinner: add CPU Configuration module
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Mar 2020 at 20:15, Niek Linnenbank <nieklinnenbank@gmail.com> wro=
te:
> On Tue, Mar 3, 2020 at 1:09 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>> Niek Linnenbank <nieklinnenbank@gmail.com> writes:
>> > +static void allwinner_cpucfg_cpu_reset(AwCpuCfgState *s, uint8_t cpu_=
id)
>> > +{
>> > +    int ret;
>> > +
>> > +    trace_allwinner_cpucfg_cpu_reset(cpu_id, s->entry_addr);
>> > +
>> > +    ret =3D arm_set_cpu_on(cpu_id, s->entry_addr, 0,
>> > +                         CPU_EXCEPTION_LEVEL_ON_RESET, false);
>>
>> According to the arm_set_cpu_on code:
>>
>>     if (!target_aa64 && arm_feature(&target_cpu->env, ARM_FEATURE_AARCH6=
4)) {
>>         /*
>>          * For now we don't support booting an AArch64 CPU in AArch32 mo=
de
>>          * TODO: We should add this support later
>>          */
>>         qemu_log_mask(LOG_UNIMP,
>>                       "[ARM]%s: Starting AArch64 CPU %" PRId64
>>                       " in AArch32 mode is not supported yet\n",
>>                       __func__, cpuid);
>>         return QEMU_ARM_POWERCTL_INVALID_PARAM;
>>     }
>>
>> Do you really want to reboot in aarch32 mode on a reset? If so we should
>> fix the TODO.
>
> The Allwinner H3 has four ARM Cortex-A7 cores and are 32-bit, so in the
> early version I filled the @target_aa64 parameter with false to
> keep it in 32-bit mode. And for usage in the current Allwinner H3 SoC
> that is sufficient, but as soon as a potential new SoC implementation
> with a 64-bit CPU starts to use this module, the hardcoded @target_aa64
> parameter will become a problem.

> Maybe I should just use some function to check if the current emulated
> CPU its 32-bit or 64-bit and use that for @target_aa64?

If the intended behaviour is "just power on the CPU into EL3
in the aarch32/aarch64 state it would naturally have out of reset"
then you can get the right value to pass to target_aa64 like this:

   ARMCPU *target_cpu =3D ARM_CPU(arm_get_cpu_by_id(cpu_id));

   if (!target_cpu) {
       /*
        * handle the case of "guest wrote bogus value to RST_CTRL
        * field, probably by returning doing nothing
        */
   }
   target_aa64 =3D arm_feature(&target_cpu->env, ARM_FEATURE_AARCH64);

Or if the required behaviour for a 64-bit CPU is more complicated
you can just assert or something with a comment that this would need
updating if we ever modelled a 64-bit Allwinner SoC.

thanks
-- PMM

