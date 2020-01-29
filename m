Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFD9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 14:00:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20464206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 14:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaRNQT52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20464206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwnsy-0006fq-9U
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 09:00:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iwnri-0005Tj-5X
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iwnrh-00052h-69
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:58:46 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iwnrh-000524-02
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:58:45 -0500
Received: by mail-wr1-x442.google.com with SMTP id t2so20288146wrr.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 05:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=r00rZDN/fIobpeEz8zkLqVKeHiSvaRa/2b0GN/j+N4U=;
 b=LaRNQT52dY580bwgNUuRoZOK3DK/VnKbQsKkLKxOD2B9MVSrw/QrjHHAqYrzwxY7uH
 0NZ8xWFP/nURZConUBh4vdc2aK/1zOMATY/0n7PjCkcqA+bwv0AcfAxEwZClUQXhQywL
 RYVZX8X4a7oUVbxIZmFoaZgDEdTsF0e+tRF3HXssydfaSPM2mQM4TeS3jw7oRyRCzSdJ
 vr5c5hnAbUgfHHqwswZCJPV8Kxkc9ptuD4GzfLY1A4a6DhmwOELpeyw8j8GiSBIQckmF
 oQb/wN89DJMqhaLytKw2WNmXrV5aGpHVIbnVPqC3rAVgh/UoMEo7qTG4Na0TOaH7gOOP
 O9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=r00rZDN/fIobpeEz8zkLqVKeHiSvaRa/2b0GN/j+N4U=;
 b=EsoeTBycwmqD2QRN6GPDWhP1A5/bXFrZaRNZredOo5r7Cs2DX/NyKdCbgsMKKCqRNr
 9nlC1D2J3kFS/TFrUxGkwqZB5xHi3SYD8G/I3tfHbXPLtLgJP+NcvNJ9yBCrpTdOz5Ov
 OjU/pQJJLYodU4fT7qjHI1etLOHOCfD+altoLA0xEtO2igQTNbw19YBz6Q4ru64R9r5s
 WAhQOGuVcf6HmVyEHrq93H85M5HppAn/pHXlWzcaBJJomNDtFNTKKq2t/SfqRoyYqmFW
 mg9cmaFPSa5Gvxnri948Q6ClothZXb9juNgfWd0LKhtvEQ81o8RwyAZ4W4TFwgYKcd9w
 WmEw==
X-Gm-Message-State: APjAAAVhTDR/l4EpsjQuRhR5TmCbjI0CR+/6FQOQ4S+g8bgkE4k4RDAO
 YUYUWqo+gkXeeyYn0Aw1sLt+K7ExBCUcp6XJaSU=
X-Google-Smtp-Source: APXvYqyE/pVHdxCNUqaGcC+W/BE9XGQOo1FGnQ3Ne5fsN6LJO8wVW0Oxi5ZXEW1qDBrnKOyDW+Fy9AizGT4u68Iq4z4=
X-Received: by 2002:adf:d850:: with SMTP id k16mr36066375wrl.96.1580306323889; 
 Wed, 29 Jan 2020 05:58:43 -0800 (PST)
MIME-Version: 1.0
References: <20200128175342.9066-1-pbonzini@redhat.com>
 <20200128175342.9066-120-pbonzini@redhat.com>
 <c6464834-4dba-2ed2-fe67-2a28d128ba21@redhat.com>
 <CAL1e-=gD0zkKVvs3ve0Q-45vTGNCNSp-cxRBoYT0KyCsaiiw+g@mail.gmail.com>
In-Reply-To: <CAL1e-=gD0zkKVvs3ve0Q-45vTGNCNSp-cxRBoYT0KyCsaiiw+g@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 29 Jan 2020 14:58:31 +0100
Message-ID: <CAJ+F1CLz4dzKiB30x+DyrvCgC_GTk-y47OUW5xAEtnb+dUgC4g@mail.gmail.com>
Subject: Re: [PATCH 119/142] Aaaaallelujah!
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Jan 29, 2020 at 2:38 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> On Wed, Jan 29, 2020 at 1:26 PM Thomas Huth <thuth@redhat.com> wrote:
> >
> > On 28/01/2020 18.53, Paolo Bonzini wrote:
> > > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> >
> > Well, even for an RFC series, you could choose a better patch subject.
> > And please add a short description what this patch is all about.
> >
>
> Speaking seriously, I agree with Thomas absolutely 100%, but in case
> this patch is merged as is, I suggest that we establish "QEMU award
> for the most original patch subject 2020", and nominate this patch for
> it. ;) It would have had tremendous chances to be a winner. :)
>

fwiw, I originally wrote that patch subject, and pushed to my meson-poc bra=
nch.

It was quite an achievement to get meson to build all qemu binaries,
and seeing the light!

Later, Paolo took the branch over, and I didn't think he would just
publish it as is. But at least, it is consistent with the PoC status,
and you noticed it :)

The subject should be changed to something like: "meson: build qemu
executables", and the comment should at least mention that qemu
binaries are now located under $top_builddir instead of
$top_builddir/$arch-{softmmu,linux-user,..} (+1 from me, the subdir
was mostly there because of the complex recursive build system)

--=20
Marc-Andr=C3=A9 Lureau

