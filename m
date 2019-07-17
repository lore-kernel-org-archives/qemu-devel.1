Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AB2C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB1F217D9
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="a0QM/M6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB1F217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnZGZ-0001rn-Im
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 22:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44955)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnZG7-00011M-Ks
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnZG6-0008C9-B0
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:01:31 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37101 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnZG5-000870-MQ; Tue, 16 Jul 2019 22:01:30 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45pL900jgRz9sN4; Wed, 17 Jul 2019 12:01:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563328884;
 bh=SWy7mB1m41APMBolYwQLY/j1EDSpQVFv99JPkyPdRDo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a0QM/M6B/g8kTC7x+GkT4IqUR3cgswFq2X9+yBFBwtNXkd7j3bn89bUBojtzOKgG5
 EpI8Vvkd2/H85g8p5nmAlGjHHihR8cf5AZa++DDi769DSPeg/22GmNvfxKlFzkYWRU
 GrtikDNr2G2mKZsVCjg0UsF5pyefSLyM7J/QbVcY=
Date: Wed, 17 Jul 2019 11:39:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190717013909.GC2217@umbus.fritz.box>
References: <156326547324.51324.17260886524634041718.stgit@lep8c.aus.stglabs.ibm.com>
 <58500cfb-cacb-17e9-f993-4107289a5f44@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline
In-Reply-To: <58500cfb-cacb-17e9-f993-4107289a5f44@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] ppc: Fix some memory leaks
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2019 at 07:44:24AM -0700, Richard Henderson wrote:
> On 7/16/19 8:24 AM, Shivaprasad G Bhat wrote:
> > @@ -827,6 +827,7 @@ int spapr_dt_drc(void *fdt, int offset, Object *own=
er, uint32_t drc_type_mask)
> >          Object *obj;
> >          SpaprDrc *drc;
> >          SpaprDrcClass *drck;
> > +        const char *drc_name =3D NULL;
> >          uint32_t drc_index, drc_power_domain;
> > =20
> >          if (!strstart(prop->type, "link<", NULL)) {
> > @@ -856,8 +857,10 @@ int spapr_dt_drc(void *fdt, int offset, Object *ow=
ner, uint32_t drc_type_mask)
> >          g_array_append_val(drc_power_domains, drc_power_domain);
> > =20
> >          /* ibm,drc-names */
> > -        drc_names =3D g_string_append(drc_names, spapr_drc_name(drc));
> > +        drc_name =3D spapr_drc_name(drc);
> > +        drc_names =3D g_string_append(drc_names, drc_name);
> >          drc_names =3D g_string_insert_len(drc_names, -1, "\0", 1);
> > +        g_free((char *)drc_name);
>=20
> This sort of casting means that you got the original type wrong.

Ah, good point.  And spapr_drc_name() has the wrong type also.  I've
pulled this patch out of my ppc-for-4.2 tree until this is fixed up.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0ufD0ACgkQbDjKyiDZ
s5L2pA//boVquQGSDKSM6xVqwHnYHIcsdtP5N8zSZfTKo9/nwuT3iiD6m+NBVJf7
ixgTx4OCsE7fCj6VXhbKbPFqoytYc+RoMDxMAPeA5098pV9GZ/VyI8hNxYnj7JKX
ZCUAJ+5EciNeHS3/jjHh4VwrjX10GI4bojqHLbBVi8gGbKxs5AlTU6LMJ+MDzGCj
nK9OYv9htb3/rqGyHblXnkXnwF3OSEJf8tPBZIYsREmeZllS1SIGXKaYUcpp0t7p
a/YDFXBGcKn4lVWquecJqFcX1sfgixzSkoZTPO9AkJr2S3W3U2Rc2IS5UintMO8z
dNf2FxqQLqA8SPw2NKGznl2MkBMsQ7kdupCcCtCxR7lFM45F+1VF26oyKBaux4Uq
V5TWMEuOnLFte3vfnVTyk0NCXP8bcW4oSQme42qsXfh0WG/06DqZB3ZCkUsa9ThS
uMh6voHleObR0rs3AUFl840nq9JDOKZRgIpSuJjZ0RFj6HXPcmulAR/aVv3KkbuP
KHOx9aizn6dvg1/0G03YpbdlMOTFOhFEonFyA4nKgMHNHwL6PnRr5GD/9IelpErq
SJnryIhpRpmcXXvCR3J7EzH0cx2QhOJJvEAuPRJ/It5OwmR4/kT+kQzyN8rOmBWG
zI2BHMupXd4NbsH+Bw7i1IGxtIA2hmU5aMtLTKONjeEQ8OsRTc8=
=X/wT
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--

