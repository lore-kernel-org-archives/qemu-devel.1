Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B743C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F002465A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3VKHqBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F002465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifnwP-0004l2-Bs
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 11:37:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ifntz-0002hS-H1
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ifnty-0001Lp-5e
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:34:51 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:37676)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ifntx-0001JD-RY
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:34:50 -0500
Received: by mail-wr1-x433.google.com with SMTP id w15so94103wru.4
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 08:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GllguRgKdMrXGb8b8bzp7zBGcHn43KAGsdtik35mN08=;
 b=P3VKHqBKL/XJ11aDDoPa9QZKyxOHai1d2tcx8eXgCbLvkKSh42tQ94LmRIcLwL8rvT
 CFYeUu7xOcVKT7o0kBZvtC5ZW6JfvNPgSKf46j4CdhO298oXg202J8phgmBE8qcxKum2
 pbz8+Fnkmw1Xd4aJgcN0y69Wi6iEBNawFc63OSFVWYXKb2YtTBvJ2yj9m3WQfD4ojxRq
 lruR6fuGGcMoQ9AZkrtQpDcyQNOoALFlaWHlLQZPVcZCh74e1VmlDgq+gbC/bIyQ9GMy
 h7BQiohvpXDUQ2ChnImiqVB7SvBtoOPv/MeazIBLz3JtN20UxLJ0VXzxt+DhfDniyIWE
 mGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GllguRgKdMrXGb8b8bzp7zBGcHn43KAGsdtik35mN08=;
 b=hVvEV1n7kBqkT6UpFQ7dKx9A32gqYBMSaqLfqJmNbHOVqI+PJCZ1CXPCxH2ZmRiZld
 IQmhnqM1UddFXol3ssY+9cXhbFA5VtRzn/eHQZc4Ad1++HpWffE6h49ycliKCbCPgCAg
 F7dKpEY9tXxGbyX8WMi6Cjw8CPnK+iHeEbPn68tty+QIN8HlxChjtB58LNEKNBsWhMqa
 QOyAm6uk/E2SeEr5QNKfFNzTG86urFd6GCuXIjZmHugH0jeW/QCm2lcZ+EKC1u+nsdLf
 J679ya1l66Ge4/1pdSF78TkbLY1sAp2qsJMZWAvOCfIB0hCFPH6mmMK1srhHPqXTI3Q5
 kwSw==
X-Gm-Message-State: APjAAAWX+iFILQtKJTgn0MZCK3n8stnK9TajJKUXZPebShMOXT2Y+04/
 VdPDSwIaC60rcwpvrwhH4DlSj9XLeqv6TX7VTPg=
X-Google-Smtp-Source: APXvYqzTXFe3fMkTxKMLvzfF2spjKxZURELeODW3VvnL5I179Y0zba8RA4GB4swUUCy6XLgXahZffLQDxnwaCEPmx2M=
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr12973864wrw.370.1576254888427; 
 Fri, 13 Dec 2019 08:34:48 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <CAJ+F1CLV_JRhXX=tB7ZXYxa1En4LzYgJr+7egKzVRNBOLY2nSA@mail.gmail.com>
 <CAFEAcA82wRy0U-DzPr64s5QiKo6XmZM96O88c4-AY4zP926GPw@mail.gmail.com>
 <CAJ+F1CKwZJnJMFzc4Z1zsY3dZAsXL1SLaXYu8y0G7=u319DWDg@mail.gmail.com>
 <CAFEAcA8nSVe2kGU9kuBxb+5BGs7GRVUHf4aHR2kUwvRNF-9-EA@mail.gmail.com>
 <CAJ+F1CL6i05tt7LmY1opSTdKq6tdJomF20MU0btBwqW-FvRGYg@mail.gmail.com>
 <20191212201759.GF4282@work-vm>
In-Reply-To: <20191212201759.GF4282@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 13 Dec 2019 20:34:35 +0400
Message-ID: <CAJ+F1CJZ5BmCFdVUfOYqRbDb3wRY1seskOZOFaVie04aXRy4qQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/37] Clean-ups: qom-ify serial and remove
 QDEV_PROP_PTR
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Dec 13, 2019 at 12:18 AM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> Apologies for the delay.
>
> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
> > Hi
> >
> > On Sun, Dec 1, 2019 at 10:10 PM Peter Maydell <peter.maydell@linaro.org=
> wrote:
> > >
> > > On Sun, 1 Dec 2019 at 17:27, Marc-Andr=C3=A9 Lureau
> > > <marcandre.lureau@gmail.com> wrote:
> > > >
> > > > Hi
> > > >
> > > > On Sun, Dec 1, 2019 at 9:18 PM Peter Maydell <peter.maydell@linaro.=
org> wrote:
> > > > >
> > > > > On Sun, 1 Dec 2019 at 10:19, Marc-Andr=C3=A9 Lureau
> > > > > <marcandre.lureau@gmail.com> wrote:
> > > > > >
> > > > > > - "serial: register vmsd with DeviceClass"
> > > > > >
> > > > > > This is standard qdev-ification, however it breaks backward mig=
ration,
> > > > > > but that's just how qdev_set_legacy_instance_id() works.
> > > > >
> > > > > I don't understand this part. Surely the whole point
> > > > > of setting a legacy instance ID is exactly to preserve
> > > > > migration compatibility? If it doesn't do that then what
> > > > > does setting legacy ID value do?
> > > > >
> > > >
> > > > It works in old->new direction only, because new code can match the
> > > > legacy instance id.
> > > >
> > > > But when going from new->old, the legacy instance id is lost, as it
> > > > uses new 0-based instance_id.
> > >
> > > I still don't understand. My mental model of the situation is:
> > >
> > >  * in the old (current) version of the code, the instance ID
> > >    is some random thing resulting from what the old code does
> >
> > right
> >
> > >  * in the new version of the code, we use qdev_set_legacy_instance_id=
,
> > >    and so instead of using the ID you'd naturally get as a
> > >    written-from-scratch qdev device, it uses the legacy value
> > >    you pass in
> >
> > no, it only sets the SaveStateEntry.alias_id, which is only used
> > during incoming migration in find_se().
> >
> > Iow, it only works old->new.
> >
> > >  * thus the device/board in both old and new versions of QEMU
> > >    uses the same value and migration in both directions works
> >
> > sadly no
> >
> > >
> > > I don't understand why we would ever be using a "new 0-based
> > > instance_id" -- it seems to me that the whole point of setting
> > > a legacy ID value is that we will use it always, and I don't
> > > understand how the board code can know that it's going to be
> > > the target of an old->new migration as opposed to being the
> > > source of a new->old migration such that it can end up with
> > > a different ID value in the latter case.
> >
> > The target will find the "legacy" alias with find_se() on incoming
> > migration, but any new outgoing migration will use the new 0-based
> > instance_id
> >
> > >
> > > If qdev_set_legacy_instance_id() doesn't work the way I
> > > think it does above, what *does* it do ?
> >
> > just set the old alias_id for incoming migration.
> >
> > David, is that correct?
>
> Yes, I think it is.
> However, I'm curious which devices you're finding are explicitly setting
> their id's;  there aren't many - although there are some that probably
> should!
> For example, running an x86 image with:
>    -device isa-parallel,chardev=3D... -device isa-serial -device isa-seri=
al -trace enable=3Dqemu_loadvm_state_section_startfull
>
> shows:
> qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idst=
r, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>
> 165217@1576179638.856300:qemu_loadvm_state_section_startfull 41(serial) 0=
 3
> 165217@1576179638.856307:qemu_loadvm_state_section_startfull 42(serial) 1=
 3
> 165217@1576179638.856311:qemu_loadvm_state_section_startfull 43(parallel_=
isa) 0 1
>
> so those two serial devices are instances '0' and '1' I think by luck of
> their command line order, rather than having specified their base
> address (which would have been safer).

None of the qdev devices using vmsd use a hard-coded instance id
afaik. In device_set_realized(), vmstate_register_with_alias_id() is
called with instance_id =3D -1, so it relies on
calculate_new_instance_id(se->idstr)

>
> Dave
>
>
>
> > thanks
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>


--=20
Marc-Andr=C3=A9 Lureau

