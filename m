Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5C7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 12:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B33C24684
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 12:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5pTtyhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B33C24684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuFLl-0001iO-AL
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 07:43:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iuFL4-0001BX-1z
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 07:42:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iuFL2-00028D-LO
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 07:42:29 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:50731)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iuFL2-00027m-Eq
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 07:42:28 -0500
Received: by mail-wm1-x329.google.com with SMTP id a5so6682434wmb.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 04:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hvdNhYJJhe+r8BPIxhc7oclt+wINj2ihQ5/ARLp+CkU=;
 b=b5pTtyhgAIG5bK2n+KNoUB17p7u4G6Mu/PlPuB5zt9RuLLLCrqIwoNyExIDxG0PJIq
 MIPr7cTZurUAu5AgZ2384ZyF2Ya8wqa5PoeQsc7PxoHNuCJS3hJub/ihIiUihwOhIom2
 0cQDXmOpRr0E5ZrvvYnfMrBxwRGSiPzW73RjixznpLcxTeEmfQuyNJhonGrARPFE3G//
 w05O0OJYIeDEZ3lQrjpVYB+xmYA3eqxE8/hIDEwiOXjqGpj0q/JBbB/j0rP6onM+u5UY
 Z8AYUEIlgHYk8PVy1+pMYC4wCiohBsGnGyp+Fhh9VD8tfQkOLFWiRfYH1bESEgHiMcAb
 KRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hvdNhYJJhe+r8BPIxhc7oclt+wINj2ihQ5/ARLp+CkU=;
 b=BX6r630bKNMe5ZlAMYUKPfzDrtWXt+Lw2GJXa61XyUbvrorTiKosFouUudSeNOEFFp
 nySPtfxRnR3UYrAdnsCvQF+dK4/fbTSiVcjWzGK0OifxKt6MTI3NpvJu03I9TYZ3leIw
 DgR8dSM43DOD333aLAXOb7xe9tkvR8k6esbP3j+EfZ2ytTHb4W4R8l7WzE+RginzMYZR
 3HRJg/9Sg2Nh5X7S4wmQGG62RYuqkvpqX/MFfJlt5O99IuOV3qp5pz7+ocnAFdC9yUgc
 NUtu7MOQ62/QcnKzcXwVbXIzJqqLzbqC18EA7zJbPIgP6/pTrBhJY5yhaDs3WTBvuRXD
 i4eg==
X-Gm-Message-State: APjAAAVwjDpu/QUNY36pVaISp/QFUdBF3D6+ke+qgqe2yJ4hmQk1hXiG
 rwRb86e8v+41vyeDDLNIJs6IRmalCLB54mXOf88=
X-Google-Smtp-Source: APXvYqz4QoMuBOFgbREzsA6Pz2hDL0bgkXS1rfEXLLip64pz4wouGQx6JX/1y4ewr1vq1aMoHBdU3UsN/uDKtgyKMlk=
X-Received: by 2002:a05:600c:24ca:: with SMTP id
 10mr2958455wmu.4.1579696946719; 
 Wed, 22 Jan 2020 04:42:26 -0800 (PST)
MIME-Version: 1.0
References: <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200120100849.GB345995@stefanha-x1.localdomain>
 <871rrtmkko.fsf@dusky.pond.sub.org>
 <20200121113224.GD630615@stefanha-x1.localdomain>
 <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
 <87wo9lc4oe.fsf_-_@dusky.pond.sub.org> <20200121143658.GB597037@redhat.com>
 <871rrs97ld.fsf@dusky.pond.sub.org>
 <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
 <87y2tzzrwo.fsf@linaro.org> <87wo9ju19n.fsf@dusky.pond.sub.org>
In-Reply-To: <87wo9ju19n.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 Jan 2020 16:42:13 +0400
Message-ID: <CAJ+F1CLu6xNJ834qWpJ6Bx1PHhv5QutdK2-Nzp+J2q80YV5tzA@mail.gmail.com>
Subject: Re: Integrating QOM into QAPI
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Jan 22, 2020 at 4:25 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
> >> Actually, we are not that far off from being able to use GObject
> >> altogether (I hacked something like that to play with), but I
> >> disgress...
> >
> > As a mostly hands off observer who mainly c&p's QOM code when he has to
> > I have to ask is this a long term plan?
> >
> > I've always found having our own hand rolled object system a little
> > incongruous given we lean heavily on the rest of glib.
>
> I vaguely remember claims that GObject falls short of our needs.  Sadly,
> I don't remember the details.  This is why major features should come
> with a design document.
>
> https://wiki.qemu.org/Features/QOM ain't: it does not mention GObject.
> I'm afraid that page has fallen too far behind the code to be useful to
> anyone not familiar with the code.

From the top of my mind, this is the pain point when trying to use GObject:
- static/inlined object, not supported by GObject, unlikely to ever be
- few users in qemu, transition possible.
- 64k limit of GObject, for some reason, unlikely to change but I will
take a look. Some users in qemu, code adaptation possible.
- dynamic properties, possible in GObject with hacks, but not
recommended and going to be deprecated from what I remember
- "array" properties - would need extra layer/tweaks for compatibility
- link properties - would need special handling
- different limitations for type names and properties names

A possible initial approach is to have all the type system and object
allocation done by GObject under the hood (what I hacked), while
keeping all the properties handled by QOM. Then, figure out a
migration to GObject properties (which are also being refactored a bit
upstream). If there is enough interest, I will keep investigating. But
for now, helping with meson seems more urgent.

>
> >> So introducing GObject-like macros? sure!
> >>
> >> There are plenty of refactoring to do. The problem when touching the
> >> whole code-base, imho, is review time. It may take a couple of
> >> hours/days to come up with a cocci/spatch, and make various patches
> >> here and there. But it takes often weeks and a lot of constant push to
> >> various folks to get all the reviews (as seens by the qdev prop-ptr
> >> series earlier for example). How can we better address whole code-base
> >> changes?
> >
> > The problem with review time - especially for QOM - is having domain
> > knowledge to understand what is happening.
> >
> > Are we happy that the existing qdev/qmp tests sufficiently exercise
> > QEMU's object model? Perhaps with a little extra tweaking of the tests
> > we could dump the object hierarchy and then compare it to the hierarchy
> > presented after modification. That might make it easier to have
> > confidence that these large scale but mostly mechanical changes don't
> > change anything externally visible?
>
> Comparing the composition tree complete with properties and property
> values before and after feels like a useful regression test.  Any
> takers?
>


--=20
Marc-Andr=C3=A9 Lureau

