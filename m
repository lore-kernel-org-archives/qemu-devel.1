Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9E0C43215
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C35222304
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L8UWS8s4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C35222304
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX0rV-0007rp-Ep
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 05:35:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iX0pH-0006DR-4s
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:33:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iX0pF-0007pO-Fl
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:33:38 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34093)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iX0pF-0007ow-9u
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:33:37 -0500
Received: by mail-oi1-x242.google.com with SMTP id l202so18454767oig.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 02:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0lDqPK8b1g/YgSQ4UOhqRSuVLV798FAflD0gLwIGofE=;
 b=L8UWS8s4YkqJRLwNTQSM1MdzeTKKwcB7wmy8MzcfLT9HQ9uYwkyjj0t+jRTpZ3AnYG
 He7cUBRAJUosJGpExEEbLcgbMfU1xZmpbVVUMX5bBj9cCuqVPvVpTwSJY0vi3ZuXAbnU
 6WTJ1/+Lr1lvuFp/vJ/oq9Maq6cj8aQXMgc+C/XG840Kb2pZbxLPdJge9CCWp3+40r6D
 Uh/tKuzUWLQ3MDFVOYx4v9l1agarTYcIHumE0aABfRoH5N16oS5oRwrSWz1OfVT9fCd9
 bk5JYZcTfjBdFjJu1B6hTYJ2Ag/Crsj8eD6UaK1HUkGQ+ytdpd7sN9QDto8hkUEj6LI4
 r/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0lDqPK8b1g/YgSQ4UOhqRSuVLV798FAflD0gLwIGofE=;
 b=FxGITz9X0ciC3BP6kF7xclnxcgo2BUK07gFT2/PME60ER+fJYZqfc3PDB+UN5dUYKW
 c55GhlCxHNgzsVJa/nwbFwMX7issV3Iij5Ze1lD0gXIMZCb/h51i1u60r4h0Ckcj4FbO
 OFpkSbvDQL27l5+o7Ds8CsKH1CDYHQZ49iFNJYKwKCOZh2QkqkP3ZydMEUypGqZb+2Iu
 yKHWDGJvdcBpFTfBkP2fk29Nr8XnOWTehPDtSYl7o7zV80Tn2cdwVqgSnP62bYMU0UjL
 OdPveUshiJZFXtG1plJTtj1qrUMbxqrvcNySQH81XP6vLSiAU7f0bjI9lYbtqiMOIr+A
 hYDA==
X-Gm-Message-State: APjAAAW40S9CBoGQBZS1liiWjyUM5N+v2MgCkCviABL7YhmPvcAz23Lw
 5YeXNTeaNak0MlUJ5o5ajT4HeS8i+KLS70DTGZsaeg==
X-Google-Smtp-Source: APXvYqxZLMPyOabxpjVKuK83nQbzRqT4IXlfwIJTwadUbV2hgyW+GrY0drDleZVaYQ+VanlYUFUe3OJnEepQDsQ+LXs=
X-Received: by 2002:aca:4945:: with SMTP id w66mr3552543oia.98.1574159615840; 
 Tue, 19 Nov 2019 02:33:35 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-8-marcandre.lureau@redhat.com>
 <CAFEAcA8GHqiaHSKdTjzTY_mWxYpDLZhXLYc98kjPGLUnzsG3oQ@mail.gmail.com>
 <CAMxuvawcYnH4pp8PitMO6KcTz_GdwF7i=zJxepofsN1o9Yh65w@mail.gmail.com>
In-Reply-To: <CAMxuvawcYnH4pp8PitMO6KcTz_GdwF7i=zJxepofsN1o9Yh65w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2019 10:33:24 +0000
Message-ID: <CAFEAcA9Ee950esqNT4PJgGU0txnv_oFJWvQ+8oOn0FS9PBt=-w@mail.gmail.com>
Subject: Re: [PATCH v3 07/33] serial: register vmsd with DeviceClass
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 Nov 2019 at 10:23, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> On Mon, Nov 18, 2019 at 6:22 PM Peter Maydell <peter.maydell@linaro.org> =
wrote:
> > Did you test whether migration still works from a QEMU
> > version without this patch to one with it? (The migration
>
> Yes, I thought I did test correctly, but I realized testing with x86
> isn't correct.
>
> So with arm/musicpal for ex, I can migrate from before->after, however
> after->before won't work. Is that ok?

Broadly speaking, the only case where we care about not
breaking cross-version migration is where we have a versioned
machine type. So musicpal doesn't matter too much. Beyond
that, yes, generally before->after is more important than
after->before. I have a feeling Red Hat downstream cares about
after->before migration at least for x86 but you or your colleagues
would know that better than me :-)

> > vmstate code is too complicated for me to be able to figure
> > out whether passing the 'dev' pointer makes a difference
> > to whot it names the state sections and whether the
> > 'qdev_set_legacy_instance_id' suffices to avoid problems.)
>
> I don't see a way to fix after->before, because the instance id is
> initially 0 with the new code, and the old code expect a different
> value.

Can you explain how the instance ID stuff works? I was
expecting that the result of setting the legacy instance ID
would just be that the new version would always have
the older setting, so if it works for old->new it would also
work for new->old. But as I say I don't understand this bit
of the migration code.

thanks
-- PMM

