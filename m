Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890DCC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 06:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5370120855
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 06:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fz70o79a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5370120855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXgJB-0006Bp-IJ
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 01:51:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iXgI2-0005Y7-CM
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 01:50:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iXgI1-0002TM-2Q
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 01:50:06 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iXgI0-0002Sn-QV; Thu, 21 Nov 2019 01:50:05 -0500
Received: by mail-wr1-x444.google.com with SMTP id b18so2922914wrj.8;
 Wed, 20 Nov 2019 22:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=m2RBZGJmMVxX1oxQjlyy6SgLwWGf5Bdq1+uhRJfEWDs=;
 b=fz70o79anE20Pk6Z7uPRDeaFiUTVUb8b1h/yP0HatbJEljxaRgcf5/ysck8tUtxV3L
 TdY1LhCuv25cdapBCeQ3TnTYpwucJyj8wYy3+8/8vqdnD7dMWU0K+sAKyEVbTofh/DY/
 RwEsLPigXMbQbaT3n5m0NYCVszdD37aGV6x+aY7D0SqRXbmUYeYgrH1/uGDNKsWY4tJa
 hHyQZPHjFTns26yxllM/WOREvJdRjEM1fAn4JOHBC3WrSXvWPo/yCW7BqG4KwLlE8WtA
 /8x2I/swYrteBgwkMK+HwtY9fhUsvOu7jSIfF4hrnKMpqqzrXm0+Xs0T7Nat3cJAZKX6
 l/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=m2RBZGJmMVxX1oxQjlyy6SgLwWGf5Bdq1+uhRJfEWDs=;
 b=o1UT4TyBPrfAh0eL9nkDCljR4ZQvGNYX1bfJRv6laG45kImeCYn1VylQ6cW2Gf+By1
 owrUuxqZqX8Ytqfy0rPFAl6sjGHIjyfH/gtrzwPuUAnFG9naHdFWzOmgyuu2bTOi1ESQ
 VmAWleDzMjBrXhfZ6lr6xT8p6o/uGYNKbsDj5YuvtRiUEMvaX/8iZwt1ztapuz/TW3Dx
 qZgy6LDtHLEi0U//8LeT/2Z9LzzDKxrfz5vMAhM3XtvC9vAUIm8hNyh/8Q/5iaht689k
 xT4DJkMEXWJskWBFBwolMsVcf6lGZJVSELUmGdNHkY+HhGCPQWi2rkOA/xEibCk8lNEy
 NIMw==
X-Gm-Message-State: APjAAAVJ2G4nseqQv1USilIPpvjTDizjyhWH0KXbqxXxPDAStMQP8UoH
 fbZS53S550UKum3R1w0Q+LnIBBoW19/rEu2r5l8=
X-Google-Smtp-Source: APXvYqxCUOHyuVukVk9HRS6g0KpvYkbt+QxWYFAiUBDpnW4Au0HYKfsK80hP2/dDMbV4FC1p9One35fhm0HghJx11io=
X-Received: by 2002:adf:e310:: with SMTP id b16mr866054wrj.202.1574319002693; 
 Wed, 20 Nov 2019 22:50:02 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-8-marcandre.lureau@redhat.com>
 <CAFEAcA8GHqiaHSKdTjzTY_mWxYpDLZhXLYc98kjPGLUnzsG3oQ@mail.gmail.com>
 <CAMxuvawcYnH4pp8PitMO6KcTz_GdwF7i=zJxepofsN1o9Yh65w@mail.gmail.com>
 <CAFEAcA9Ee950esqNT4PJgGU0txnv_oFJWvQ+8oOn0FS9PBt=-w@mail.gmail.com>
 <CAJ+F1CKYriLP=FK5s2u=azk-rfUCAG-gR6_keXDSOPS4D0Mq3A@mail.gmail.com>
 <20191120185420.GF2858@work-vm>
In-Reply-To: <20191120185420.GF2858@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 21 Nov 2019 10:49:50 +0400
Message-ID: <CAJ+F1CLW1+w3WsUS8ySdU2qLqGy7+0sRhwsTqki1qY+-ij7U2g@mail.gmail.com>
Subject: Re: [PATCH v3 07/33] serial: register vmsd with DeviceClass
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Corey Minyard <cminyard@mvista.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Paul Burton <pburton@wavecomp.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Nov 20, 2019 at 10:54 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
> > On Tue, Nov 19, 2019 at 2:35 PM Peter Maydell <peter.maydell@linaro.org=
> wrote:
> > >
> > > On Tue, 19 Nov 2019 at 10:23, Marc-Andr=C3=A9 Lureau
> > > <marcandre.lureau@redhat.com> wrote:
> > > > On Mon, Nov 18, 2019 at 6:22 PM Peter Maydell <peter.maydell@linaro=
.org> wrote:
> > > > > Did you test whether migration still works from a QEMU
> > > > > version without this patch to one with it? (The migration
> > > >
> > > > Yes, I thought I did test correctly, but I realized testing with x8=
6
> > > > isn't correct.
> > > >
> > > > So with arm/musicpal for ex, I can migrate from before->after, howe=
ver
> > > > after->before won't work. Is that ok?
> > >
> > > Broadly speaking, the only case where we care about not
> > > breaking cross-version migration is where we have a versioned
> > > machine type. So musicpal doesn't matter too much. Beyond
> > > that, yes, generally before->after is more important than
> > > after->before. I have a feeling Red Hat downstream cares about
> > > after->before migration at least for x86 but you or your colleagues
> > > would know that better than me :-)
> > >
> > > > > vmstate code is too complicated for me to be able to figure
> > > > > out whether passing the 'dev' pointer makes a difference
> > > > > to whot it names the state sections and whether the
> > > > > 'qdev_set_legacy_instance_id' suffices to avoid problems.)
> > > >
> > > > I don't see a way to fix after->before, because the instance id is
> > > > initially 0 with the new code, and the old code expect a different
> > > > value.
> > >
> > > Can you explain how the instance ID stuff works? I was
> > > expecting that the result of setting the legacy instance ID
> > > would just be that the new version would always have
> > > the older setting, so if it works for old->new it would also
> > > work for new->old. But as I say I don't understand this bit
> > > of the migration code.
> >
> > From what I understand, the alias_id is only used in
> > savevm.c:find_se(), and thus can only be used to match against
> > "legacy" instance id values. On new code, instance_id is generated
> > incrementally from 0 with calculate_new_instance_id(), based on
> > "qdev-path/vmsd-name".
>
> I think there are cases here there's no qdev path that's viable;
> e.g. for ISA devices, the ID is set to the ISA IO base:
>
> hw/char/serial-isa.c
> 79:    qdev_set_legacy_instance_id(dev, isa->iobase, 3);
>
> (In serial_isa_realizefn )
>
> but to be honest I'd have to trace this out and see what values the
> devices are actually using to be sure.

There is no qdev path, because ISA bus doesn't have get_dev_path()
implemented for some reason.

However, vmstate_register_with_alias_id() will use
calculate_new_instance_id(se->idstr) in this case.

>
> (And yes, please don't break backwards migration; otherwise I'll
> end up having to figure out a fix).

My understanding is that qdev_set_legacy_instance_id() always broke
backward migration.

To keep backward migration to work, we would need a mechanism to
"force" to use legacy instance id.

Would it be acceptable to have a patch that does that when the
original VM state uses legacy instance id?
If you start the VM with the new code path, and try to migrate to the
old / legacy it would fail. But migrating existing old VM back and
forth between old/new would work.





--=20
Marc-Andr=C3=A9 Lureau

