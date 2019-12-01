Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1963C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 18:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 937742082E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 18:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n/UDRgvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937742082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibTgg-00019u-6A
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 13:11:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ibTfw-0000Og-La
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 13:10:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ibTfv-0005uL-D3
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 13:10:28 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46875)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ibTfv-0005td-7G
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 13:10:27 -0500
Received: by mail-ot1-x344.google.com with SMTP id g18so1903360otj.13
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 10:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NxQmc6i9SKqyT46GvFo+rJByHzQnfvacuhJg7nhcVS0=;
 b=n/UDRgvPmyoNrnn2LSaYTgIsYrMGHSMx4XteoNTJRCFv0yeX9bwLxdrYFusQt180bN
 N+q4gZiGs8b01RAYQZrxnzYY2PRJfaBGYUDVljzbnQC31J9PvZT9tRghK5WyxfOuitYd
 SJkCDcSVP5mVs2hQmUN9lX+AxFLhHDLh5qDU3R1tAkYyyZ6ZsWVPiDTzC9VkArmlG5S2
 PyjXqSuD+tnELNC4cBgaphq1x93kwZvMotBvwd4I1B4X8RzSZxa/zD9HwR1Tx3kbss+i
 vYQWCMtF9PVk7PEP1XC/D2taSg03sVkLEZdAHTAZv0ot7qWJksTqG3qopve2eIEJSHMl
 D40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NxQmc6i9SKqyT46GvFo+rJByHzQnfvacuhJg7nhcVS0=;
 b=U7hEFWtSVFNNERRrwzfF0tM47BW32Wa7pIAcxnOdCQ3How6x4zvJU9Ispthz2LC2ce
 E6JftPIkUz6EpJVf8MFvsFqAKaFi/VDsStnu24l0Reizd7JPmdCHU7VyXA3arGvDh3iu
 2oN8JXlRlkiPN45Jt4djcjEiWL2cnjE9IF3AfMKFRrH7wNcsRkOD3z8L1nLO35NxoCB5
 s1H9bcfYJnVSq1/RvoSHhG+vtf/neK12MCI7gg+f3PFwAs0nQv4KqrgNNRlD/CwSm+wb
 jowJr4yYcPJhKHpDufNasPFW+QetVZJSBg4Nkdw4p8NWObHuXQ/t6XZgcTSiScg01GgO
 yDXw==
X-Gm-Message-State: APjAAAUGKux7jPqOLKPfKRqWN1w257npkbSG3hmDsSNWsbDJRPrE+RiH
 tazOT0hK5HuevjnBdmTERnkiuDlwtPJFhUllt9n1MA==
X-Google-Smtp-Source: APXvYqzAgeEvhuhDq83Yt5N4ciT/qHbHWfVVG7GL0d3mVXKr5pPisce1tWOVdzAY4azmeE1YHFogjIdzUYD9qxX5qiw=
X-Received: by 2002:a9d:6745:: with SMTP id w5mr1212678otm.221.1575223826480; 
 Sun, 01 Dec 2019 10:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <CAJ+F1CLV_JRhXX=tB7ZXYxa1En4LzYgJr+7egKzVRNBOLY2nSA@mail.gmail.com>
 <CAFEAcA82wRy0U-DzPr64s5QiKo6XmZM96O88c4-AY4zP926GPw@mail.gmail.com>
 <CAJ+F1CKwZJnJMFzc4Z1zsY3dZAsXL1SLaXYu8y0G7=u319DWDg@mail.gmail.com>
In-Reply-To: <CAJ+F1CKwZJnJMFzc4Z1zsY3dZAsXL1SLaXYu8y0G7=u319DWDg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 1 Dec 2019 18:10:15 +0000
Message-ID: <CAFEAcA8nSVe2kGU9kuBxb+5BGs7GRVUHf4aHR2kUwvRNF-9-EA@mail.gmail.com>
Subject: Re: [PATCH v4 00/37] Clean-ups: qom-ify serial and remove
 QDEV_PROP_PTR
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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

On Sun, 1 Dec 2019 at 17:27, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Sun, Dec 1, 2019 at 9:18 PM Peter Maydell <peter.maydell@linaro.org> w=
rote:
> >
> > On Sun, 1 Dec 2019 at 10:19, Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@gmail.com> wrote:
> > >
> > > - "serial: register vmsd with DeviceClass"
> > >
> > > This is standard qdev-ification, however it breaks backward migration=
,
> > > but that's just how qdev_set_legacy_instance_id() works.
> >
> > I don't understand this part. Surely the whole point
> > of setting a legacy instance ID is exactly to preserve
> > migration compatibility? If it doesn't do that then what
> > does setting legacy ID value do?
> >
>
> It works in old->new direction only, because new code can match the
> legacy instance id.
>
> But when going from new->old, the legacy instance id is lost, as it
> uses new 0-based instance_id.

I still don't understand. My mental model of the situation is:

 * in the old (current) version of the code, the instance ID
   is some random thing resulting from what the old code does
 * in the new version of the code, we use qdev_set_legacy_instance_id,
   and so instead of using the ID you'd naturally get as a
   written-from-scratch qdev device, it uses the legacy value
   you pass in
 * thus the device/board in both old and new versions of QEMU
   uses the same value and migration in both directions works

I don't understand why we would ever be using a "new 0-based
instance_id" -- it seems to me that the whole point of setting
a legacy ID value is that we will use it always, and I don't
understand how the board code can know that it's going to be
the target of an old->new migration as opposed to being the
source of a new->old migration such that it can end up with
a different ID value in the latter case.

If qdev_set_legacy_instance_id() doesn't work the way I
think it does above, what *does* it do ?

thanks
-- PMM

