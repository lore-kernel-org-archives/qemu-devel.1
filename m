Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14C2C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFA72072D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INdbyI7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFA72072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6C2K-0006nj-T3
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 06:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j6C1O-0006Hh-LP
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j6C1N-0003Zm-LY
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:35:34 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:40578)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1j6C1N-0003ZN-EW; Mon, 24 Feb 2020 06:35:33 -0500
Received: by mail-wm1-x333.google.com with SMTP id t14so8987971wmi.5;
 Mon, 24 Feb 2020 03:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=bgAg8pV4RG5pfkpcpvSy/+3iiLhkffHFCqHdPlzFcNs=;
 b=INdbyI7JRf0VN2wtI4c0Lx3BzAypK08vZ8npZGLC4iDaagYRcdhlYwK1P5yn7Vetzt
 G4gjLQYiMX3ZHDpn39DjSTmndJRwvDj+agaf2hL2f+NPvLXEpXlotdkylC6bSUG8WPrJ
 6BJY83q7SdkRjICamvgT9v4pP13LDHUM+8lgHy9nknm5/gewVV0BHXbjtgJTV4NUgA9t
 UzNo4/ayOceOAIqRMx1co1chGrrH1dpyACUS7To9LqJrnDHIhdKTadGH2ZXzf1mTeHqv
 U8WCooF9058E+dUMK0Iv45ibEy29l3C7s5K54N9YIOIo2VeBqf7GEJj8VYOT8jaUKQHS
 X6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bgAg8pV4RG5pfkpcpvSy/+3iiLhkffHFCqHdPlzFcNs=;
 b=kgbuNbvELk59tktIQF5tCn023n1V6Xiwedy+2rZIe7Ys8cgFFz+jknFXPmFqp9+/p+
 OSNwDa4/AVL/KCvztJSBUxTS+xsACWsVbOhcT0e/FAvvaVpFbN29WrwZslMWynp1G5hI
 Z0evp11LrbLofZXSeb377lHR9wwxLcas7qRQV4kf/OxUBEJhSto0ylPSEo4btVk7w/aN
 v4NqVmnbjTPBWLofbw6cLJf1NsEnVDCnVXXFtq4PFw6/UpnN49CW/og3oiy0vG3BHIfN
 2akZn6xztvShNRPR8Qfm42JutC9uz5nro1/S5RuwOzAGEAKN38iCUsln7rxaKarJ7+x0
 pPuQ==
X-Gm-Message-State: APjAAAWbyx3npg0zohnCyCOVrprVPVSmzR/1xQ7iipv0EbVrETpIF8qg
 vhOYc/lkIX0J6HGkk2zjsjg=
X-Google-Smtp-Source: APXvYqz/P7uhXNaozo7t0ZllvNYvoMqG/oI+VS6gvh/NmhZ0X65EBKnFk5acaEMw6bje+DYXE/uczg==
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr22251107wmi.71.1582544132183; 
 Mon, 24 Feb 2020 03:35:32 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id d4sm18367511wra.14.2020.02.24.03.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 03:35:30 -0800 (PST)
Date: Mon, 24 Feb 2020 11:35:29 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PULL 24/31] fuzz: support for fork-based fuzzing.
Message-ID: <20200224113529.GB1896567@stefanha-x1.localdomain>
References: <20200222085030.1760640-1-stefanha@redhat.com>
 <20200222085030.1760640-25-stefanha@redhat.com>
 <6ffd74e1-d603-f479-e6e4-eb5ef4ce7050@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <6ffd74e1-d603-f479-e6e4-eb5ef4ce7050@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <rth@twiddle.net>, Darren Kenny <darren.kenny@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2020 at 05:34:29AM -0600, Eric Blake wrote:
> On 2/22/20 2:50 AM, Stefan Hajnoczi wrote:
> > From: Alexander Bulekov <alxndr@bu.edu>
> >=20
> > fork() is a simple way to ensure that state does not leak in between
> > fuzzing runs. Unfortunately, the fuzzer mutation engine relies on
> > bitmaps which contain coverage information for each fuzzing run, and
> > these bitmaps should be copied from the child to the parent(where the
> > mutation occurs). These bitmaps are created through compile-time
> > instrumentation and they are not shared with fork()-ed processes, by
> > default. To address this, we create a shared memory region, adjust its
> > size and map it _over_ the counter region. Furthermore, libfuzzer
> > doesn't generally expose the globals that specify the location of the
> > counters/coverage bitmap. As a workaround, we rely on a custom linker
> > script which forces all of the bitmaps we care about to be placed in a
> > contiguous region, which is easy to locate and mmap over.
> >=20
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> > Message-id: 20200220041118.23264-16-alxndr@bu.edu
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
>=20
> Random drive-by observation:
>=20
> > +++ b/tests/qtest/fuzz/fork_fuzz.ld
> > @@ -0,0 +1,37 @@
> > +/* We adjust linker script modification to place all of the stuff that=
 needs to
> > + * persist across fuzzing runs into a contiguous seciton of memory. Th=
en, it is
>=20
> section

Thanks, Eric!

Alex, please send follow-up patches to fix this typo and the 80
character line limit issues identified by patchew (see patch email reply
to this email thread).

Stefan

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5TtQEACgkQnKSrs4Gr
c8h7dQf/S51Z2ep9EpPAKH5dH130iFPeJ7bbvfNwCSmdv62OiYNFDa1/yTlitpag
8CGX+djLld8fJGcbMQOYK/RXk/v6jTdfuiMVB25f0HwRDY4GgJQRYP8G3KH2dQvM
o9Q5bskysfbc0qk2SsqsgYw189/qIIHKYhkIynI35In3HNmcM2s2Hmsg7J0grnJV
tIubJrWpA0O6EM7jLcfgdQmNXiuL8L7JED7Aq6l/iN+OKoKNOfm48RHQ6iIqCUCC
KvL5r1fYC2jX0UHZT/NUaDWKZwCo05AhHaot6eQBtzH/AfPdlUlxyu/tibBTikCc
Xujnz3Bioy9ms7nuwikwistXQM8ufw==
=IsDp
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--

