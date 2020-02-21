Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1DCC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6B1324650
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELPUVSZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B1324650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j56KX-0001a4-R3
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 06:18:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j56Ja-0000QZ-VC
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j56JZ-0005a3-TE
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:17:50 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53477)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1j56JZ-0005Zr-Mk; Fri, 21 Feb 2020 06:17:49 -0500
Received: by mail-wm1-x342.google.com with SMTP id s10so1344791wmh.3;
 Fri, 21 Feb 2020 03:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cZ86CzqotdBAUUMsc4+wlaAZMZfiRJYpp6lD+/SIs4Q=;
 b=ELPUVSZD3OuRhHKv9wUZdHc2+CDgGRdGJ23Fn8N2D4bvrdmFpfy3YawThHuyBXBlxy
 rTWvgiwpQCMLpUmt8HGY7iDtKpgKIJ2WklZ3FcqGrs19qSwiWfFIgrFX9QsTNz17sqxT
 56T5HUlM3Bt0jkqPjGrJn3bi/p2MdMDp47XhaR3A0w/mjJaNcabhizh/PIAGrellyJKB
 xGwu/OJqr3lnfLLqu29FeoCyujD6mBkta2zNoJFa4El6tqTg3GxyhvK6cLzafeKwbjAI
 q0+xOUI8Wj6XENyhPtVkBlvEl4x3x/zH8/DVsemZePN1HrYa4u1CGQOv5ibC5s355sck
 AWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cZ86CzqotdBAUUMsc4+wlaAZMZfiRJYpp6lD+/SIs4Q=;
 b=iYKIqA5qQpmdZGMGDpxM9uKv3Ta4FUAnKAPviQdKQisBMt3Y+Nj2+a2zHhLYFlqQnn
 Zy81kdpksk1bnwKqUZ2bAS/EHTIPrRRiI1nbwFhRBf+cL3Gt3l73Gqh/zMZS+C9A1GwY
 il5vIy+2tUTW1aQCO0AsYkwcZ55kQHV5ILbL2YfAQFzULZFKdnqYQeftOm9PiCaP+pej
 8WEP9IGUcSocxfcLosSkySgHf9IA0x87skMWzv56lVthaL+HTfzdxG4y+H3DeiNdwUS0
 2qUyWhKplEETtUWr1mWggGhr9Aqr5gpBKcOpSYF+IHdkfewUohLKmtXhT7U3/2Uxom92
 n/wQ==
X-Gm-Message-State: APjAAAUVOM/JTaehS/5FV0z/RvkApU6BXbMGfw20C4xfQk5Ld91xb1V0
 0t093j71KasdUTNeGKCPvHs=
X-Google-Smtp-Source: APXvYqzCu+LZwf102szDqr/sgfqnfZ8W5Ua+dCGyytWMTEYO/z6twIOI2H9xWKUTcXfkRKL1gmxlTg==
X-Received: by 2002:a05:600c:21c6:: with SMTP id
 x6mr3171437wmj.177.1582283868596; 
 Fri, 21 Feb 2020 03:17:48 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id o9sm3608936wrw.20.2020.02.21.03.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 03:17:47 -0800 (PST)
Date: Fri, 21 Feb 2020 11:17:46 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 1/4] luks: extract
 qcrypto_block_calculate_payload_offset()
Message-ID: <20200221111746.GE1484511@stefanha-x1.localdomain>
References: <20200211160318.453650-1-stefanha@redhat.com>
 <20200211160318.453650-2-stefanha@redhat.com>
 <80432d24-cd1e-5321-0e7a-be998b3886fc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UnaWdueM1EBWVRzC"
Content-Disposition: inline
In-Reply-To: <80432d24-cd1e-5321-0e7a-be998b3886fc@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--UnaWdueM1EBWVRzC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2020 at 02:03:50PM +0100, Max Reitz wrote:
> On 11.02.20 17:03, Stefan Hajnoczi wrote:
> > The qcow2 .bdrv_measure() code calculates the crypto payload offset.
> > This logic really belongs in crypto/block.c where it can be reused by
> > other image formats.
> >=20
> > The "luks" block driver will need this same logic in order to implement
> > .bdrv_measure(), so extract the qcrypto_block_calculate_payload_offset()
> > function now.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  block/qcow2.c          | 74 +++++++++++-------------------------------
> >  crypto/block.c         | 40 +++++++++++++++++++++++
> >  include/crypto/block.h | 22 +++++++++++++
> >  3 files changed, 81 insertions(+), 55 deletions(-)
>=20
> [...]
>=20
> > diff --git a/crypto/block.c b/crypto/block.c
> > index 325752871c..a9e1b8cc36 100644
> > --- a/crypto/block.c
> > +++ b/crypto/block.c
> > @@ -115,6 +115,46 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCre=
ateOptions *options,
>=20
> [...]
>=20
> > +bool
> > +qcrypto_block_calculate_payload_offset(QCryptoBlockCreateOptions *crea=
te_opts,
> > +                                       const char *optprefix,
> > +                                       size_t *len,
> > +                                       Error **errp)
> > +{
> > +    QCryptoBlock *crypto;
> > +    bool ok;
> > +
> > +    /* Fake LUKS creation in order to determine the payload size */
> > +    crypto =3D qcrypto_block_create(create_opts, optprefix,
> > +                                  qcrypto_block_headerlen_hdr_init_fun=
c,
> > +                                  qcrypto_block_headerlen_hdr_write_fu=
nc,
> > +                                  len, errp);
> > +    ok =3D crypto !=3D NULL;
> > +    qcrypto_block_free(crypto);
> > +    return ok;
>=20
> Speaking of g_autoptr...  Would g_autoptr(QCryptoBlock) crypto; suffice
> to contract these three lines into =E2=80=9Creturn crypto !=3D NULL;=E2=
=80=9D?
>=20
> Either way:
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Yes, it can be simplified.  Will fix in v3.

Stefan

--UnaWdueM1EBWVRzC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5PvFoACgkQnKSrs4Gr
c8ih1wgAv59hflabR7Oh3+MWr7/rYEnYlvA1GKVg2EO8c93AEcGBOjoO7h3o/jBE
6bpLfP9SOjMM9eyExsuBwtBx94TKx1kHqXkfjz4zdZQXPRjeT4CXIqQpLvAfjlwH
w6dtzdelD10FO1lXx2QSUBIkw81/ZVba0Ezn+vpkP4N5KHJe6SPbcY+sB2sdbVWQ
J6A4yxAnd2Tka9Kfp1WM2y8QmKW4LBjQDoOT+EBa2QiQTSnMC2UsfkhMCwU8igoe
vYzMsnC5ewBBsr6Y+/Vb0hZ1sMaxYGXDaRcHRRfdrBnlg34J2CbIrG5Kq/pJjzJg
1M7F4wvq7O7k5m3X0jW8SzPg0RA0uQ==
=qILr
-----END PGP SIGNATURE-----

--UnaWdueM1EBWVRzC--

