Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5531AC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CEBA20872
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vzr6ungd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CEBA20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX29e-0007cX-7D
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 06:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iX28x-0006zq-UL
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:58:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iX28w-0004Va-Pt
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:58:03 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44199)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iX28w-0004Uq-J7; Tue, 19 Nov 2019 06:58:02 -0500
Received: by mail-wr1-x443.google.com with SMTP id f2so23489298wrs.11;
 Tue, 19 Nov 2019 03:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=THczhtpawuKZWPnoFB6R2JN2qdWgxuopaHPjGmb5pAw=;
 b=Vzr6ungdmy/6Q5tsA9MP+NJei/nYSgLtAVJ0tZqVdt5rapDthfMJyWR0S/0AKMrRE1
 g8u9zuyG1Lnq9OpyePXcoofynWnVRsWSU4voBPq6y/Nc+21c+CXKKo+sg1hgWqv6SoVj
 2a4b4SB2U0HcYm8cBi8zYYswEMXOTDeLF0X4VNT6ZoVhNe1J4T7p5tKk0aumflkWfdbN
 Vbx5QFedcNMEKg1BLj5nTStlUWv/EvtdMQdLCwMdpG2VT7p516PnhOi7CQ7s14QWGPY9
 qizVn8c51WgyGgKQaFMsnPXj2L/5Xx6iX7MjtEpO3bVJ8DXRTO6LkN5T7/ySz/weZ10e
 okHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=THczhtpawuKZWPnoFB6R2JN2qdWgxuopaHPjGmb5pAw=;
 b=VAYoUv5caGtNP0mypLvIlDWgKREbxoUVUXQCQiQ5yLaTCc3Xlyc1oaBFQivcsL0JcQ
 kJG/mAE5dUe2yZyQKJy6hPRTUw6i4m1+DJfHGbQmjxL4asimA9i3sUAxLYbUf3rRl3GN
 JzMP7kE1alw2fM9bTNz0A+/FjVh5E6VEk7CzDw8z32fqbNTCBiTtMtqR5z4HXB7Dsw4Z
 lCfSbGZvmjYrhH3Szqhm+YnVJoEEb7pZIccIW9MUNeYOixrl3yXjifLUGGnTGGIcgwKn
 XVsA1F/TQqSoOBTkOPUo3zpKtwPqwImNpENQIMsn9zDX+YQrNP4f7cbBx+JVyYd2FGkL
 72Zw==
X-Gm-Message-State: APjAAAUKZ5zULRWgjPE3RbvcrPba9RWZHosXlAfenifIERE8SCJ5sQDa
 D4J9iPGc7fWOoHIeeY7gkcYs//5QSRkWoPGB/tc=
X-Google-Smtp-Source: APXvYqxzZhO2LwVLBDCPvYX/j+z7T6KG7uj135jKlJoeZN2ft73owMjK4Jld9iDqHM5F4qYnoZqKJZD9wjQww/h/rDY=
X-Received: by 2002:a5d:6cc3:: with SMTP id c3mr36402590wrc.202.1574164681300; 
 Tue, 19 Nov 2019 03:58:01 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-8-marcandre.lureau@redhat.com>
 <CAFEAcA8GHqiaHSKdTjzTY_mWxYpDLZhXLYc98kjPGLUnzsG3oQ@mail.gmail.com>
 <CAMxuvawcYnH4pp8PitMO6KcTz_GdwF7i=zJxepofsN1o9Yh65w@mail.gmail.com>
 <CAFEAcA9Ee950esqNT4PJgGU0txnv_oFJWvQ+8oOn0FS9PBt=-w@mail.gmail.com>
In-Reply-To: <CAFEAcA9Ee950esqNT4PJgGU0txnv_oFJWvQ+8oOn0FS9PBt=-w@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 19 Nov 2019 15:57:49 +0400
Message-ID: <CAJ+F1CKYriLP=FK5s2u=azk-rfUCAG-gR6_keXDSOPS4D0Mq3A@mail.gmail.com>
Subject: Re: [PATCH v3 07/33] serial: register vmsd with DeviceClass
To: Peter Maydell <peter.maydell@linaro.org>, 
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 19, 2019 at 2:35 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Tue, 19 Nov 2019 at 10:23, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> > On Mon, Nov 18, 2019 at 6:22 PM Peter Maydell <peter.maydell@linaro.org=
> wrote:
> > > Did you test whether migration still works from a QEMU
> > > version without this patch to one with it? (The migration
> >
> > Yes, I thought I did test correctly, but I realized testing with x86
> > isn't correct.
> >
> > So with arm/musicpal for ex, I can migrate from before->after, however
> > after->before won't work. Is that ok?
>
> Broadly speaking, the only case where we care about not
> breaking cross-version migration is where we have a versioned
> machine type. So musicpal doesn't matter too much. Beyond
> that, yes, generally before->after is more important than
> after->before. I have a feeling Red Hat downstream cares about
> after->before migration at least for x86 but you or your colleagues
> would know that better than me :-)
>
> > > vmstate code is too complicated for me to be able to figure
> > > out whether passing the 'dev' pointer makes a difference
> > > to whot it names the state sections and whether the
> > > 'qdev_set_legacy_instance_id' suffices to avoid problems.)
> >
> > I don't see a way to fix after->before, because the instance id is
> > initially 0 with the new code, and the old code expect a different
> > value.
>
> Can you explain how the instance ID stuff works? I was
> expecting that the result of setting the legacy instance ID
> would just be that the new version would always have
> the older setting, so if it works for old->new it would also
> work for new->old. But as I say I don't understand this bit
> of the migration code.

From what I understand, the alias_id is only used in
savevm.c:find_se(), and thus can only be used to match against
"legacy" instance id values. On new code, instance_id is generated
incrementally from 0 with calculate_new_instance_id(), based on
"qdev-path/vmsd-name".



--=20
Marc-Andr=C3=A9 Lureau

