Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BE8C33CAE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 07:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A342075B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 07:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="W71Totl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A342075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqtzD-0005wF-Lc
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 02:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iqtyZ-0005IC-U1
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 02:17:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iqtyY-0002Lb-Oh
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 02:17:27 -0500
Received: from ozlabs.org ([203.11.71.1]:54233)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iqtyW-0002HD-2a; Mon, 13 Jan 2020 02:17:24 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47x4fS2FYbz9sPn; Mon, 13 Jan 2020 18:17:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578899840;
 bh=aaWWOD+aHSxJEi2O2Vs9dFgm1buPigAQBFB1/1ut62Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W71Totl//cINFjtMhIVRW6WMNQdvRrfxqhdWTzrYsJxfbAzzNzvD4PvtMsoMFIKl/
 MI9mVhwOiw3rboglPy3O6t/L/rI2O37XWGyvdWRH+bsw70W9/tM1Vlp/ancQQqskw+
 CgBVkElofU9uX4u2vscodtQKhBozqp39VCk/tApg=
Date: Mon, 13 Jan 2020 17:16:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 04/15] hw/ppc/spapr_rtas: Restrict variables scope to
 single switch case
Message-ID: <20200113071648.GF19995@umbus>
References: <20200109152133.23649-1-philmd@redhat.com>
 <20200109152133.23649-5-philmd@redhat.com>
 <20200109184349.1aefa074@bahia.lan>
 <9870f8ed-3fa0-1deb-860d-7481cb3db556@redhat.com>
 <20200110105055.3e72ddf4@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XIiC+We3v3zHqZ6Z"
Content-Disposition: inline
In-Reply-To: <20200110105055.3e72ddf4@bahia.lan>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Juan Quintela <quintela@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2020 at 10:50:55AM +0100, Greg Kurz wrote:
> On Fri, 10 Jan 2020 10:34:07 +0100
> Philippe Mathieu-Daud=E9 <philmd@redhat.com> wrote:
>=20
> > On 1/9/20 6:43 PM, Greg Kurz wrote:
> > > On Thu,  9 Jan 2020 16:21:22 +0100
> > > Philippe Mathieu-Daud=E9 <philmd@redhat.com> wrote:
> > >=20
> > >> We only access these variables in RTAS_SYSPARM_SPLPAR_CHARACTERISTICS
> > >> case, restrict their scope to avoid unnecessary initialization.
> > >>
> > >=20
> > > I guess a decent compiler can be smart enough detect that the initial=
ization
> > > isn't needed outside of the RTAS_SYSPARM_SPLPAR_CHARACTERISTICS branc=
h...
> > > Anyway, reducing scope isn't bad. The only hitch I could see is that =
some
> > > people do prefer to have all variables declared upfront, but there's =
a nested
> > > param_val variable already so I guess it's okay.
> >=20
> > I don't want to outsmart compilers :)
> >=20
> > The MACHINE() macro is not a simple cast, it does object introspection=
=20
> > with OBJECT_CHECK(), thus is not free. Since=20
>=20
> Sure, I understand the motivation in avoiding an unneeded call
> to calling object_dynamic_cast_assert().
>=20
> > object_dynamic_cast_assert() argument is not const, I'm not sure the=20
> > compiler can remove the call.
> >=20
>=20
> Not remove the call, but delay it to the branch that uses it,
> ie. parameter =3D=3D RTAS_SYSPARM_SPLPAR_CHARACTERISTICS.

I think any performance consideration here is a red herring.  This
particular RTAS call is a handful-of-times-per-boot thing, and only
AFAIK used by AIX guests.

I'm in favour of the change on the grounds of code locality and
readability.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4cGWAACgkQbDjKyiDZ
s5IRhxAAgjwTfn6oDce64WmxrtSzdp5v8NnkSL1fO3d3+2xEQyjHrPoCNGPjgsqG
s05hIyZ+0BwiAKsdwmFtqnxsMdtwpNWDgzESv9t7aY3qRy3hZWj7b12sVkhio7nv
5LZ5VI0Brp0fGRv6Kw6/4KczI/rvWUKYYchMv027IyOdnK01hBLL0Le06RY4gUo4
ouZOKyF3NolvtBSxotq72UDJzlUeCACieg/xQuYo3DB2KT3HeerdYv4ijsF/vXpe
yHgxJleALbk8XXfVGM2iXODKOuhbPE0Q1xovdzLZtw8Gc6LyRHlqS0PB4QVqu2pN
2W2ykFzPV52O5apL+Ythb03YgsbA15V02thgPWJgs8h3MEWaUOkkwuwmguJuZQnH
4jYeXOIY58Lwksts5+N8TiyuSAuepQiFTXFvysM9GUjt7aSDqW05Gg0b+heDyzyJ
C00cQD+AzUJzFeRR75A8/bBzoeA2xTG8N2+CH2uinY2H3CBMHfy9V2DnzJChDwEL
zkPr/tk2KT00dioTwNJFTyVivvZOzTWR8GbHxsM6+uOBiF/UwvyOQiJEHYcj2g/4
KFl9FaakjOqsjd3+tEOwyTmmIxlNNBBpphHYt+8ZKoYu344+Qp/E7brigCvhpC6+
x/YqfPajq/dqVh2mWqGNfEZyepvxWhQO2OglVhpd5WdTGP1x99U=
=x52C
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--

