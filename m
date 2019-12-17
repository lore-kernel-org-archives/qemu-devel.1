Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42382C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 14:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF13320663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 14:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BNTzfwe3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF13320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihDgy-0000JI-H4
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 09:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihDgC-00082f-N9
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:18:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihDgB-00071p-I2
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:18:28 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46305)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihDgB-0006rX-BB
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:18:27 -0500
Received: by mail-wr1-x441.google.com with SMTP id z7so11438616wrl.13
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 06:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=xqGJeKD0AYwa80N1yoDziZMviCd5tptot9UfkEONBYw=;
 b=BNTzfwe37ItcoqdM0LsE2rnGRVOeV4464yZuFGOUNCnC4lBWNlwnqwheHETfxYr92L
 DReUNMLSayUu+EAoyaYo+Hyf81MItWT4VPiAGk45C2/kjlIbXhyV1ESZkdrbyRLoyBvz
 zm3RINyPVBmH/bC/9+8pPy5HvG2CzIQTELwOUzPFgxazFokY7VGNQbsFjH9trqbNZw5G
 9pd3DgGl1clhl0fqToukTPGSeZIXwfFDxAE9t5Olwv/nhGKoLskCv22TALgRcXMZcWvf
 LSl/NBhLWKgbMEgmN5Gqm3UJtAjYVFLkl2oZXB6cEXhx0b0OujjQVfSkeILEUVsLu//K
 n6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=xqGJeKD0AYwa80N1yoDziZMviCd5tptot9UfkEONBYw=;
 b=JEon5r1KIYyEmKUQ76kICV9XT2lCGboAHKjC3YC8l70gv2Lhs04snLgvu0wXtxt95y
 LEfB4m4Zt6B6DiQbW/pBnsZqPaBjSfrBBZiBTQ8ss37r75aVoKwoWAsTzL2MXgA4oEvg
 tMd/eqzKvmxv6rFIu8y8vO3jT/XnVaApvezTimSwkuEioL0/V4wgaA5N4j8NBD+1krnC
 xu4pGln/8L8FritBOv4ICl3QSgVexL1I6o1OyRC/1ZE1BE+B0pZevZMMhzxo8VhCmA+X
 0r93TNK7u3QnwqaiP1r3kj+oRWUjuDCBtvN9qTbkA/nYZjvMK/zdeVXfcqpZVfNkF7Zo
 V0NA==
X-Gm-Message-State: APjAAAVrM0WQDo2uTnOt7QJEKqvaQ3UFretslmaeJhuL7HlR1msQoDgs
 62SouR+yeodJsreuBTy4AR0XQQ==
X-Google-Smtp-Source: APXvYqzsxD6sAduxcuwzZMgD7us797D5FgH0dj5aLUuEbQi8DtP62Nf1/50hHRavRslCdMKewIsQkQ==
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr35764179wru.99.1576592305463; 
 Tue, 17 Dec 2019 06:18:25 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c2sm25898249wrp.46.2019.12.17.06.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 06:18:24 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5655C1FF87;
 Tue, 17 Dec 2019 14:18:23 +0000 (GMT)
References: <77dd4863-6301-b17d-529c-451d491d4794@redhat.com>
 <20191217121443.14757-1-alex.bennee@linaro.org>
 <1ca001f0-43a5-d8fc-fee0-3a318cc698e5@redhat.com>
 <87bls7vzjc.fsf@linaro.org>
 <976227bb-916a-2c50-1f8d-e146a199de15@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] semihosting: suspend recieving CPU when blocked
 (HACK, WIP)
In-reply-to: <976227bb-916a-2c50-1f8d-e146a199de15@redhat.com>
Date: Tue, 17 Dec 2019 14:18:23 +0000
Message-ID: <875zifvxw0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: keithp@keithp.com, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 17/12/19 14:42, Alex Benn=C3=A9e wrote:
>>> Why do you need to set exception_index to something other than -1 (using
>>> cpu_loop_exit_noexc for example)?
>> If there is no exception to process we won't exit the main loop which we
>> need to do if we want to wait until there is data to read.
>
> Okay.
>
>>> Using ->stop here is a bit weird, since ->stop is usually related to
>>> pause_all_vcpus.
>>=20
>> Arguably we could come up with a better API to cpu.c but this allows us
>> to use cpu_resume(c->sleeping_cpu) when waking up rather than hand
>> rolling our own wake-up mechanism.
>
> But we already have the right wake-up mechanism, which is
> cpu->halted/cpu_has_work.

cpu_has_work is a guest function though and semihosting_console is a
common hw module. It can't peek into the guests internal state. This all
comes back to cpu_thread_is_idle anyway in making our decision about if
we do or do not sleep on the halt_cond.

> That also makes it possible to just use
> EXCP_HALTED instead of adding a new EXCP_BLOCKED.

We can certainly use EXCP_HALTED but maybe come up with a common way of
entering the state? There seems to be a combination of messing around
with special interrupts and direct poking of cs->halted =3D 1 while
setting the exception. Maybe this could finally clear up the #if
defined(TARGET_I386) hacking in cpus.c?

>
> Paolo


--=20
Alex Benn=C3=A9e

