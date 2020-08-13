Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09434C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:10:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB8B20716
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DETaMtnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB8B20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k67O5-0000nG-JR
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 03:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k67NC-0008E9-Pl; Thu, 13 Aug 2020 03:10:02 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:57521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k67NA-0006xw-0u; Thu, 13 Aug 2020 03:10:02 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BRyPZ0w0Gz9sTY; Thu, 13 Aug 2020 17:09:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597302594;
 bh=CsJpRcdWm/SL1Ph6hNAZXZh6XVb4TrvSx53OGWVifbI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DETaMtnSvCGrBx2+5W3iQ4LlwE7SfHN4znkdQmOSZQciqJwakQSvE7bcjJE2Uy+/1
 ZSk+e0k7qp1uQg+E5FfKSovekKyDwk3oTSNQ4fKxjg1344zTY5+ABUwLLmM7zm2v86
 PvYDm+PZAN1p1vZ3S28WC6bxshNdJcRuaXMdBmMQ=
Date: Thu, 13 Aug 2020 16:43:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 2/2] spapr/nvram: Error out if NVRAM cannot contain
 all -prom-env data
Message-ID: <20200813064336.GC17532@yekko.fritz.box>
References: <159725212173.104309.6136813383848717434.stgit@bahia.lan>
 <159725213748.104309.14834084670144632611.stgit@bahia.lan>
 <a3b37d03-b8e5-fc1c-7988-4f71cb19c090@vivier.eu>
 <20200812210654.6ee82d66@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline
In-Reply-To: <20200812210654.6ee82d66@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2020 at 09:06:54PM +0200, Greg Kurz wrote:
> On Wed, 12 Aug 2020 19:29:26 +0200
> Laurent Vivier <laurent@vivier.eu> wrote:
>=20
> > Le 12/08/2020 =E0 19:08, Greg Kurz a =E9crit=A0:
> > > Since commit 61f20b9dc5b7 ("spapr_nvram: Pre-initialize the NVRAM to
> > > support the -prom-env parameter"), pseries machines can pre-initialize
> > > the "system" partition in the NVRAM with the data passed to all -prom=
-env
> > > parameters on the QEMU command line.
> > >=20
> > > In this cases it is assumed that all the data fits in 64 KiB, but the=
 user
> > > can easily pass more and crash QEMU:
> > >=20
> > > $ qemu-system-ppc64 -M pseries $(for ((x=3D0;x<128;x++)); do \
> > >   echo -n " -prom-env "$(for ((y=3D0;y<1024;y++)); do echo -n x ; don=
e) ; \
> > >   done) # this requires ~128 Kib
> > > malloc(): corrupted top size
> > > Aborted (core dumped)
> > >=20
> > > Call chrp_nvram_create_system_partition() first, with its recently ad=
ded
> > > parameter dry_run set to true, in order to know the required size and=
 fail
> > > gracefully if it's too small.
> >=20
> > Why do you need the dry_run parameter?
> > Can't you fail on the normal case?
> >=20
>=20
> Not sure what the "normal case" stands for... but basically, only
> chrp_nvram_create_system_partition() knows the exact size of the
> partition (ie. size of the header + size of all prom-env strings
> including the terminal nul + padding to the upper 16-byte aligment).
>=20
> Another solution could be to pass the buffer size and errp to
> chrp_nvram_create_system_partition() and chrp_nvram_set_var(),
> and let chrp_nvram_set_var() check it won't memcpy() past the
> buffer. But this is more code and since this is also used by
> other machine types, I chose to go for the dry_run parameter.

Hm, it does feel like a more natural interface to me, though, rather
than always having to call it twice.  Basically just add a "max_size"
parameter.

> Should I improve the changelog to make this clearer or are
> you thinking to something else ?
>=20
> > Thanks,
> > Laurent
> >=20
> > >=20
> > > Reported-by: John Snow <jsnow@redhat.com>
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  hw/nvram/spapr_nvram.c |   15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >=20
> > > diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
> > > index 992b818d34e7..c29d797ae1f0 100644
> > > --- a/hw/nvram/spapr_nvram.c
> > > +++ b/hw/nvram/spapr_nvram.c
> > > @@ -145,6 +145,7 @@ static void rtas_nvram_store(PowerPCCPU *cpu, Spa=
prMachineState *spapr,
> > > =20
> > >  static void spapr_nvram_realize(SpaprVioDevice *dev, Error **errp)
> > >  {
> > > +    ERRP_GUARD();
> > >      SpaprNvram *nvram =3D VIO_SPAPR_NVRAM(dev);
> > >      int ret;
> > > =20
> > > @@ -187,6 +188,20 @@ static void spapr_nvram_realize(SpaprVioDevice *=
dev, Error **errp)
> > >              return;
> > >          }
> > >      } else if (nb_prom_envs > 0) {
> > > +        int len =3D chrp_nvram_create_system_partition(nvram->buf,
> > > +                                                     MIN_NVRAM_SIZE =
/ 4,
> > > +                                                     true);
> > > +
> > > +        /* Check the partition is large enough for all the -prom-env=
 data */
> > > +        if (nvram->size < len) {
> > > +            error_setg(errp, "-prom-env data requires %d bytes but s=
papr-nvram "
> > > +                       "is only %d bytes in size", len, nvram->size);
> > > +            error_append_hint(errp,
> > > +                              "Try to pass %d less bytes to -prom-en=
v.\n",
> > > +                              len - nvram->size);
> > > +            return;
> > > +        }
> > > +
> > >          /* Create a system partition to pass the -prom-env variables=
 */
> > >          chrp_nvram_create_system_partition(nvram->buf, MIN_NVRAM_SIZ=
E / 4,
> > >                                             false);
> > >=20
> > >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl804RgACgkQbDjKyiDZ
s5LCkw//Zgt++sjlGb/3tKVIFgK8gbpc7xVe2iEVGTBR5H3cS2ZsSwpq9wtgYONw
QgjGoNYs5JF/g9+elqhCAV9kzWc48sj2LQMNtMZdUpphQl31g+/7/S5oMUw+KHIK
+NAs7cr2RunW0YSzTtYSweCfK57KrSAhv22THMHtbe6M+wusmguzCtCHvXLcqzT8
191rI+ED1eE0t5wmrOwvic+9eUTzPHWhIJu6ETnkt6YxhiaAYN944ZCffdRKK5wf
4+jxXO6Wy3RWJ7KbTgtBqc/HxdmpbDkTl1z6QFzyCSzhQt1QlGvUQsISMYCAJmmK
oFkeBpJlDWfo7EZv5POTmM+v59kONue2jPX5boTiNxcfeZuhLMe4kU2QQug15UP9
PKjIQpY4qAhhHGxKBRGyy4HXaE4CfR88iqLo7w1NJpmw5WgDGn4HQxJVfOhqpUrA
3yUp4yLaudrqwymTgmiLw4SdipsshVwDWJBk8zyfEDjZTTXoDliUoKsK+dmTyvyG
f0Cck2j56EoTL7sH0cf0nso0MRDxE93mV0kO6mX2u84+HvIlI/Tx3x5ELPbdLY6k
Atm6cHgFQfVRFSNspu6DgYfglC1zsBKiusZzhKj7NQXTQtHtpR2+gH9UQ3sW6rOK
f1XR+0GXT3RUQ68w8SsISvKCApNE3H0r7E5woAiAJBUR/aTleps=
=mFHZ
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--

