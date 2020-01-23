Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D09C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 04:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B051621835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 04:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8FIR+i7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B051621835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuURc-0000xf-JV
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 23:50:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iuUR1-0000SG-7s
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 23:49:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iuUQz-0005mq-CY
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 23:49:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53872
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iuUQz-0005lo-8u
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 23:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579754976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=aVuSkwUZt5YRTFVVqww6XN8QuLgVCH6cWYnU1xYAuSw=;
 b=h8FIR+i7MuQpqC7zVY25DZZi7CzYWhs53rEN1St2o7ejftKZkasx8ZrlntjvmNcD6RnARs
 rx0fuvsM2wdIy1hMd8qxwWnq59pu98mG1aS2ERxKnUScxf7kwCWXW8MCn/a6VEbarlSEhS
 5x3sHCl3+HZ8U6cUPwJyp1uHgUMTyVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-B4cXabT1NEO5pnihuz-Fiw-1; Wed, 22 Jan 2020 23:49:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4C4C3F0E;
 Thu, 23 Jan 2020 04:49:32 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 407718574A;
 Thu, 23 Jan 2020 04:49:30 +0000 (UTC)
Subject: Re: [PATCH rc1 12/24] hw/timer: Add limited support for Atmel 16 bit
 timer peripheral
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200123000307.11541-1-richard.henderson@linaro.org>
 <20200123000307.11541-13-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <13770068-790a-5317-a0fa-5a672bae7253@redhat.com>
Date: Thu, 23 Jan 2020 05:49:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200123000307.11541-13-richard.henderson@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: B4cXabT1NEO5pnihuz-Fiw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: S.E.Harris@kent.ac.uk, me@xcancerberox.com.ar,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, dovgaluk@ispras.ru,
 imammedo@redhat.com, mrolnik@gmail.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/01/2020 01.02, Richard Henderson wrote:
> From: Michael Rolnik <mrolnik@gmail.com>
>=20
> These were designed to facilitate testing but should provide enough
> function to be useful in other contexts.  Only a subset of the functions
> of each peripheral is implemented, mainly due to the lack of a standard
> way to handle electrical connections (like GPIO pins).
>=20
> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> Message-Id: <20200118191416.19934-13-mrolnik@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> [rth: Squash info mtree fixes and a file rename from f4bug, which was:]
> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
[...]
> +static void avr_timer16_clksrc_update(AVRTimer16State *t16)
> +{
> +    uint16_t divider =3D 0;
> +    switch (CLKSRC(t16)) {
> +    case T16_CLKSRC_EXT_FALLING:
> +    case T16_CLKSRC_EXT_RISING:
> +        ERROR("external clock source unsupported");

Maybe this should rather be qemu_log_mask(LOG_UNIMP, ...) instead?

> +        goto end;
> +    case T16_CLKSRC_STOPPED:
> +        goto end;
> +    case T16_CLKSRC_DIV1:
> +        divider =3D 1;
> +        break;
> +    case T16_CLKSRC_DIV8:
> +        divider =3D 8;
> +        break;
> +    case T16_CLKSRC_DIV64:
> +        divider =3D 64;
> +        break;
> +    case T16_CLKSRC_DIV256:
> +        divider =3D 256;
> +        break;
> +    case T16_CLKSRC_DIV1024:
> +        divider =3D 1024;
> +        break;
> +    default:
> +        goto end;
> +    }
> +    t16->freq_hz =3D t16->cpu_freq_hz / divider;
> +    t16->period_ns =3D NANOSECONDS_PER_SECOND / t16->freq_hz;
> +    DB_PRINT("Timer frequency %" PRIu64 " hz, period %" PRIu64 " ns (%f =
s)",
> +             t16->freq_hz, t16->period_ns, 1 / (double)t16->freq_hz);
> +end:
> +    return;
> +}

Nit: You could use an early "return" instead of "goto end" and the
superfluous return statement at the end of the function.

> +static void avr_timer16_set_alarm(AVRTimer16State *t16)
> +{
> +    if (CLKSRC(t16) =3D=3D T16_CLKSRC_EXT_FALLING ||
> +        CLKSRC(t16) =3D=3D T16_CLKSRC_EXT_RISING ||
> +        CLKSRC(t16) =3D=3D T16_CLKSRC_STOPPED) {
> +        /* Timer is disabled or set to external clock source (unsupporte=
d) */
> +        goto end;
> +    }
> +
> +    uint64_t alarm_offset =3D 0xffff;
> +    enum NextInterrupt next_interrupt =3D OVERFLOW;
> +
> +    switch (MODE(t16)) {
> +    case T16_MODE_NORMAL:
> +        /* Normal mode */
> +        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16) &&
> +            (t16->imsk & T16_INT_OCA)) {
> +            alarm_offset =3D OCRA(t16);
> +            next_interrupt =3D COMPA;
> +        }
> +        break;
> +    case T16_MODE_CTC_OCRA:
> +        /* CTC mode, top =3D ocra */
> +        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16)) {
> +            alarm_offset =3D OCRA(t16);
> +            next_interrupt =3D COMPA;
> +        }
> +       break;
> +    case T16_MODE_CTC_ICR:
> +        /* CTC mode, top =3D icr */
> +        if (ICR(t16) < alarm_offset && ICR(t16) > CNT(t16)) {
> +            alarm_offset =3D ICR(t16);
> +            next_interrupt =3D CAPT;
> +        }
> +        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16) &&
> +            (t16->imsk & T16_INT_OCA)) {
> +            alarm_offset =3D OCRA(t16);
> +            next_interrupt =3D COMPA;
> +        }
> +        break;
> +    default:
> +        ERROR("pwm modes are unsupported");

qemu_log_mask(LOG_UNIMP, ...) ?

> +        goto end;
> +    }
> +    if (OCRB(t16) < alarm_offset && OCRB(t16) > CNT(t16) &&
> +        (t16->imsk & T16_INT_OCB)) {
> +        alarm_offset =3D OCRB(t16);
> +        next_interrupt =3D COMPB;
> +    }
> +    if (OCRC(t16) < alarm_offset && OCRB(t16) > CNT(t16) &&
> +        (t16->imsk & T16_INT_OCC)) {
> +        alarm_offset =3D OCRB(t16);
> +        next_interrupt =3D COMPC;
> +    }
> +    alarm_offset -=3D CNT(t16);
> +
> +    t16->next_interrupt =3D next_interrupt;
> +    uint64_t alarm_ns =3D
> +        t16->reset_time_ns + ((CNT(t16) + alarm_offset) * t16->period_ns=
);
> +    timer_mod(t16->timer, alarm_ns);
> +
> +    DB_PRINT("next alarm %" PRIu64 " ns from now",
> +        alarm_offset * t16->period_ns);
> +
> +end:
> +    return;
> +}

This function could also use early returns instead of "goto end".

(no need to respin just because of these nits ... but maybe something to
consider if you respin anyway)

 Thomas


