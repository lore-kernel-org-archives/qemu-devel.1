Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CE5C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A2C2467D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkBW1Hh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A2C2467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBbZr-00056F-1H
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jBbZ8-0004MU-NR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jBbZ6-000816-WF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:52:46 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37582)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jBbZ6-0007zI-MT
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:52:44 -0400
Received: by mail-wr1-x441.google.com with SMTP id 6so14962930wre.4
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 02:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=kw8+Kz+s8iLvewhlq83kKrCeHWu0DKozpkCaVb7Gy3w=;
 b=IkBW1Hh6OnJcScfElAfLX//UdBnOOTiyNbkXRyvJ0nNCJsRg9Vwd9eVPLFM2nZuzZ3
 foKRWCtwx9jJlzySi6UPs0LA7SmfgRxrC9DtiWoH7fWvzKkXCVSIFUCHTMqkyRgEFGpj
 zGASKAE6FR7fPvSbRkA99SK/qBte5qJ8UGSq+U+mIPUWQlUXOmTht2KF4RGfppllimNd
 rwAZ9YpteXbUUXc00gzN7dW87QNONnsM8A6UXjT7aw3b/goJs2AZpCFsXrHnWO2WYW7A
 rxn+dvxrP7kHCdyTZX1yMq+kQM2tZVcMhzcJ9kjTkEU9Vlh8dmlO6USSGXQ34lWicYbv
 qhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kw8+Kz+s8iLvewhlq83kKrCeHWu0DKozpkCaVb7Gy3w=;
 b=qtnvkW64dqsLEn020P2bCIQ0Nto4jy5426nhGeTqRdlOY+AC6UTSl+DQuNM1MlBXp8
 wGnA1LL2IrN+bXt9AiRk6aTdO06HCnooyqrvkE+bVYb7NCrduSBokd5c45qrw/Xew22R
 MsDUYOYiKqV8pC6sZWH771r9dK0zyY3dgZ+K0TwJsaNSGK+3fh+zzoMt3PJUel+5Wsey
 QS48psbjhcXAVBvjv9Ivr7MOaOvUJ97KG2VMbMAXfJl267z+o6g0U189G9YxFgnXA6a8
 WpEnO5p/1bkoaS9Jvn1D4QrVGRy36Xc0CzNp+3HYCHU0KuHoYZH0OBFLX72tcThi/SeO
 /qng==
X-Gm-Message-State: ANhLgQ2dedljBZv6xyVVbIiShn88TugxhSjKiiJZYB5EXGaGEpyPPp8q
 l97j8kN6SL9JfiHcjsU9Yks=
X-Google-Smtp-Source: ADFU+vukbeGD88p6FFDwUJgIr9Dqgv+ri707nnOuFv2ioDWkNYBEnlAnEN5mViyfiUQZGNq988lczA==
X-Received: by 2002:adf:f581:: with SMTP id f1mr13094472wro.38.1583833962640; 
 Tue, 10 Mar 2020 02:52:42 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 19sm3524391wma.3.2020.03.10.02.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 02:52:41 -0700 (PDT)
Date: Tue, 10 Mar 2020 09:52:40 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Paul Zimmerman <pauldzim@gmail.com>
Subject: Re: Any interest in dwc-otg (aka dwc2) device emulation? For Raspi 3
 and below.
Message-ID: <20200310095240.GD140737@stefanha-x1.localdomain>
References: <CADBGO79s5ZTWrvheAu=XHrVQO0O_RxLu9LD9=B=k982c8_mC6g@mail.gmail.com>
 <a3d88162-abb1-d770-0222-dec576bbdb6a@redhat.com>
 <CADBGO7-O7=nZVH1Zm8Fi08KBJK8rhCLQJsNeXzv4va+o+3ViKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Content-Disposition: inline
In-Reply-To: <CADBGO7-O7=nZVH1Zm8Fi08KBJK8rhCLQJsNeXzv4va+o+3ViKA@mail.gmail.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, kraxel@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2020 at 08:15:33PM -0700, Paul Zimmerman wrote:
> Hi John,
>=20
> Thanks for the tips! I found an issue when testing with the usb-storage
> device, so I will work on fixing that, and then think about how best to
> split up the patches.

Please CC Gerd Hoffmann (QEMU USB maintainer) when sending your patches.
Thanks!

Stefan

>=20
> Thanks,
> Paul
>=20
> On Mon, Mar 9, 2020 at 7:23 PM John Snow <jsnow@redhat.com> wrote:
>=20
> >
> >
> > On 3/6/20 7:34 PM, Paul Zimmerman wrote:
> > > Hi Folks,
> > >
> > > I have been working on an emulation of the dwc-otg USB controller
> > > (host mode only for now), as implemented on the Raspberry Pi 3 and
> > > below, and on numerous other embedded platforms. I have it to a point
> > > where it works pretty well with the dwc2 driver in the mainline Linux
> > > kernel, and with the dwc-otg driver in the Raspbian kernel. Mouse and
> > > keyboard work fine, and I *think* the usb-net device is working too,
> > > although I have been unsuccessful in connecting to the outside world
> > > with it.
> > >
> > > I haven't done anything with gadget-mode yet, but that could certainly
> > > be added in the future.
> > >
> > > Would there be any interest in me submitting this for inclusion in
> > > Qemu? I ask because I see there was a previous effort at this at
> > > github.com/0xabu/qemu/hw/usb/bcm2835_usb.c, but it seems it never went
> > > anywhere.
> > >
> > > Thanks,
> > > Paul
> > >
> >
> > At a minimum, I think you should send your patches to the list for
> > posterity even if they don't wind up getting enough review pressure to
> > be merged.
> >
> > If you want advice on how to split up your patches to entice more
> > reviewers, please let us know and any one of us can write a thousand
> > more :words: that might help make a better case.
> >
> > (There's a much-too-long wiki entry on the matter, if you are brave.)
> >
> > The issue, as always, is usually just reviewer time -- and how squeaky
> > the wheel is. Making the patches look pretty and well organized is one
> > way to trick well meaning people into reviewing your patches.
> >
> > --js
> >
> >

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5nY2gACgkQnKSrs4Gr
c8gKFgf9G8OTIzXHge0eEKDQ52/B2R9FSXylNnzZNF/F0OQVVde09Pq+7+w13vE8
WA1njHKmPsyS+yNhIOMrHVRdZt03cq6ehvRka5yYHe1NLQXzibVKD6OgOEvGQDeL
1Odqq956j8AGcSSEGuKPrrugJPYYx8Xzf01oaEyAeeH/YBGknUOmN5dJv7SPuwkF
IkRmV9T8ctYwOCxQHNM3kHMc71jGTvnbRjkivbYssc7T6t9ogoMPGIJq0pww9yzN
HY10W+laAwUwlmyTUmRkgvB5dLBbbXLlvp1F0MejmBrxBitxR5fI7YvTh/dQn0NF
I7Vmc2kpUOF23US6nCmgROqtXZM4tg==
=mqSy
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--

