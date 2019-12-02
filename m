Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCABC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 11:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0595920833
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 11:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYtHm5Qq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0595920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibjjL-0005F2-6u
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 06:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ibjhp-00040k-IS
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 06:17:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ibjho-0001AQ-D0
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 06:17:29 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41641)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ibjho-00018P-6K
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 06:17:28 -0500
Received: by mail-wr1-x443.google.com with SMTP id b18so43729972wrj.8
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 03:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eQi9yiL1SgJE1ivljlkViky/PBxqJ9TBB8DmrLRuJUA=;
 b=uYtHm5Qq1gRQ2xxXA1g9P/ogcE/FGiwZEnRJyBWhPLdPXBTv/QqIPOL1NoTSU/bq4/
 nf/YLxHVVQSmZnkFQBQ/5zVkhS/ML2C2dyMJS7sByvu1OAAdLh4NlgAoxzTudODZgh+b
 2CZ46WO/357sV3luu/cxHuOkCpN/w5ukD4jwNCbriOIagJXESqlu6HW1Sti83+5zAMek
 m2YCCfeK6XVnR57PZCh94km4uxR5sngv0cn/3Z5R+MKkFdMc+hmBWEtcP+N3+pBCAuPt
 lj9sA/+w+TAY6tV3zyH4h3dtQ1Zyc8ByDyXHKxV58Wo2uvWeOb8a9lgl6rfknCz/7GXp
 g3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eQi9yiL1SgJE1ivljlkViky/PBxqJ9TBB8DmrLRuJUA=;
 b=U5P8cy0tbWN1ob4X3fD/KpTQHeFEo4lBRgW0TDcpcuJpHFcWOuDm2D3j+QOHjMGGaL
 NbT9P96QEdtlrQ5SEmTCNyqM7oDPtjjRNx5U2bws9jZs+6x8vxCWQIkUgnq6WCaAe4SN
 9aBMtAQOC6NshgaelgTp6KNRdWVuN0QhXONm8TjPAZPrMhXzWh5b0maYOvAbH9rPh1qA
 /uBlwpv+94q9t+4KwnBD3Tu1q1ewx1k56mORqyj+z6m5AtLjReW3jldhkLnQXA2+EXkU
 FmyC7wQicK/4fqpu+Rg0Ba5szD33lSPseM/tXCewgcrU051v6h7PQvRRTwYXhSK062qg
 idZw==
X-Gm-Message-State: APjAAAXZx0vZBWUgyCGFwrg7SKyLy7bOlMSaYzZaDlHCHTGwaPSJ58dm
 R7zoBpqaGCegaZ90vMILdIe+Ls55AXNNO+WsgL4=
X-Google-Smtp-Source: APXvYqwjW51aSW7MzVJn3sujSwdLhxXiNNg6Y1ff8GIduOmojmIyDi7NXc9SEl3OIccdcKJ/HLMURiLp9MxMZJPHPHw=
X-Received: by 2002:a5d:6350:: with SMTP id b16mr4847000wrw.132.1575285445089; 
 Mon, 02 Dec 2019 03:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <CAJ+F1CLV_JRhXX=tB7ZXYxa1En4LzYgJr+7egKzVRNBOLY2nSA@mail.gmail.com>
 <CAFEAcA82wRy0U-DzPr64s5QiKo6XmZM96O88c4-AY4zP926GPw@mail.gmail.com>
 <CAJ+F1CKwZJnJMFzc4Z1zsY3dZAsXL1SLaXYu8y0G7=u319DWDg@mail.gmail.com>
 <CAFEAcA8nSVe2kGU9kuBxb+5BGs7GRVUHf4aHR2kUwvRNF-9-EA@mail.gmail.com>
In-Reply-To: <CAFEAcA8nSVe2kGU9kuBxb+5BGs7GRVUHf4aHR2kUwvRNF-9-EA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 2 Dec 2019 15:17:12 +0400
Message-ID: <CAJ+F1CL6i05tt7LmY1opSTdKq6tdJomF20MU0btBwqW-FvRGYg@mail.gmail.com>
Subject: Re: [PATCH v4 00/37] Clean-ups: qom-ify serial and remove
 QDEV_PROP_PTR
To: Peter Maydell <peter.maydell@linaro.org>
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
Cc: QEMU <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Sun, Dec 1, 2019 at 10:10 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Sun, 1 Dec 2019 at 17:27, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
> >
> > Hi
> >
> > On Sun, Dec 1, 2019 at 9:18 PM Peter Maydell <peter.maydell@linaro.org>=
 wrote:
> > >
> > > On Sun, 1 Dec 2019 at 10:19, Marc-Andr=C3=A9 Lureau
> > > <marcandre.lureau@gmail.com> wrote:
> > > >
> > > > - "serial: register vmsd with DeviceClass"
> > > >
> > > > This is standard qdev-ification, however it breaks backward migrati=
on,
> > > > but that's just how qdev_set_legacy_instance_id() works.
> > >
> > > I don't understand this part. Surely the whole point
> > > of setting a legacy instance ID is exactly to preserve
> > > migration compatibility? If it doesn't do that then what
> > > does setting legacy ID value do?
> > >
> >
> > It works in old->new direction only, because new code can match the
> > legacy instance id.
> >
> > But when going from new->old, the legacy instance id is lost, as it
> > uses new 0-based instance_id.
>
> I still don't understand. My mental model of the situation is:
>
>  * in the old (current) version of the code, the instance ID
>    is some random thing resulting from what the old code does

right

>  * in the new version of the code, we use qdev_set_legacy_instance_id,
>    and so instead of using the ID you'd naturally get as a
>    written-from-scratch qdev device, it uses the legacy value
>    you pass in

no, it only sets the SaveStateEntry.alias_id, which is only used
during incoming migration in find_se().

Iow, it only works old->new.

>  * thus the device/board in both old and new versions of QEMU
>    uses the same value and migration in both directions works

sadly no

>
> I don't understand why we would ever be using a "new 0-based
> instance_id" -- it seems to me that the whole point of setting
> a legacy ID value is that we will use it always, and I don't
> understand how the board code can know that it's going to be
> the target of an old->new migration as opposed to being the
> source of a new->old migration such that it can end up with
> a different ID value in the latter case.

The target will find the "legacy" alias with find_se() on incoming
migration, but any new outgoing migration will use the new 0-based
instance_id

>
> If qdev_set_legacy_instance_id() doesn't work the way I
> think it does above, what *does* it do ?

just set the old alias_id for incoming migration.

David, is that correct?

thanks


--=20
Marc-Andr=C3=A9 Lureau

