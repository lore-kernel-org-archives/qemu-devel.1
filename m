Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8511C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 04:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EC77206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 04:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ld76hPgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC77206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipPQQ-0004Sx-6g
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 23:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ipPOq-0003AE-31
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:26:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ipPOo-0000jW-4X
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:26:23 -0500
Received: from ozlabs.org ([203.11.71.1]:48533)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ipPOn-0000cJ-7r; Wed, 08 Jan 2020 23:26:22 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47tY2x4qK7z9sNx; Thu,  9 Jan 2020 15:26:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578543977;
 bh=D++JUG9ef3yZtaaIasHKACUySpJxmpKiNY3sV8YyJvY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ld76hPgPutCYM/QlryA8YHpYQIQPCMzs+2t8J/g2H2Q05iC09ASQWBSra4UjKiFZC
 1+43/XxM1iOhFxN31PqPz/wMYG3jU/VazUAVxGL/aqlJnjucRcQKna7BYNaY8C38jn
 09VbWE9255tt9rYBn8mUFAlrjG0XUwQX4rf/LAP4=
Date: Thu, 9 Jan 2020 15:18:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu v2] spapr: Kill SLOF
Message-ID: <20200109041815.GN8586@umbus.fritz.box>
References: <20200105234242.78897-1-aik@ozlabs.ru>
 <20200106041940.GV2098@umbus>
 <835b2928-aff9-c2d1-dfdf-60d915706404@ozlabs.ru>
 <20200107055436.GI2098@umbus>
 <cf5bb030-167e-b073-f423-ea2f6c620b1f@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cf0hFtnykp6aONGL"
Content-Disposition: inline
In-Reply-To: <cf5bb030-167e-b073-f423-ea2f6c620b1f@ozlabs.ru>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cf0hFtnykp6aONGL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2020 at 03:20:22PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 07/01/2020 16:54, David Gibson wrote:
> > On Tue, Jan 07, 2020 at 03:44:35PM +1100, Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 06/01/2020 15:19, David Gibson wrote:
> >>>> +
> >>>> +static uint32_t client_package_to_path(const void *fdt, uint32_t ph=
andle,
> >>>> +                                       uint32_t buf, uint32_t len)
> >>>> +{
> >>>> +    char tmp[256];
> >>>
> >>> Fixed sized buffers are icky.  You could either dynamically allocate
> >>> this based on the size the client gives, or you could use
> >>> memory_region_get_ram_ptr() to read the data from the tree directly
> >>> into guest memory.
> >>
> >> @len comes from the guest, I am really not comfortable with allocating
> >> whatever (broken) guest requested. And if I limit @len by 1024 or
> >> similar, then a fixed size buffer will do too, no?
> >=20
> > I see your point.  Does this call have a way to report failure?  In
> > that case you could outright fail the call if it requests too long a
> > length.
>=20
> It returns length which can be 0 to signal an error.
>=20
> but with this particular method the bigger problem is that I cannot know
> in advance the actual path length from fdt_get_path(). I could double
> the size until fdt_get_path() succeeded, just seems overkill here.

fdt_get_path() will return -FDT_ERR_NOSPACE if the path doesn't fit in
the provided buffer.  I think that's enough to fail in the relevant
cases.  You could then use a buffer of size min(client provided size,
fixed max size).

I believe I've thought of trying to implement something that returns
what the path length would be without constructing it, but it turns
out to be essentially impossible given the fdt format and the fact
that we don't allocate inside libfdt (basically we have to use the
partially constructed path buf as state information to know how to
proceed with our scan).

> Property names seem to be limited by 32:
>=20
> OF1275:
> =3D=3D=3D
> nextprop
> IN:phandle, [string] previous, [address] buf
> OUT:  flag
>=20
> Copies the name of the property following previous in the property list
> of the device node identified by phandle into buf, as a null-terminated
> string. Buf is the address of a 32-byte region of memory. If previous is
> zero or a pointer to a null string, copies the name of the device node=E2=
=80=99s
> first property.
> =3D=3D=3D

Yeah... IEEE1275 says that, but I don't think most OF implementations
enforce it.  I'm also pretty sure that limit is broken by device trees
in the wild (I remember investigating this when implementing dtc &
libfdt).

> >> btw how exactly can I use memory_region_get_ram_ptr()?
> >> get_system_memory() returns a root MR which is not RAM, RAM is a
> >> "spapr.ram" sub-MR.
> >=20
> > Right, but you know that RAM is always at offset 0 within that root
> > MR.=20
>=20
> Well, it could potentially be more than just one level down in the MR
> tree, for example we could add NUMA MRs and place actual RAM MR
> under these.

Oh.. yeah, sorry, I think you'd need address_space_translate() or
something like it to locate the right MR first.  Which come to think
of it, validates / truncates the length to, so..

> > That said, it doesn't look like it's that easy to bounds check
> > that pointer, so maybe that's not a good idea after all.
>=20
> ok.

=2E. I think that would work after all.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cf0hFtnykp6aONGL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4WqYUACgkQbDjKyiDZ
s5LQshAAjE7nU6RscADUN+iReHpEQqozd5pU9qqdEPY475wBkS9Xs25oM1nOEql9
NtEVYJpkaVf+xoaoGdNuzgN9mpiCX90XWieLAWYlSZXyVYyvW/w/bu2G/6TfGbJS
X3SM9nzGRzhPuxi/Uqz9J/3Py8q8rldNr3RgyzHIPO6/x5ODwYi3CRtVkzhgjHcM
GkxOwEHPbWkG1BrBoMfKO+AFUW+HUvQql4WCwnfVzgcJu5pGlGvmWl9Nqh5EbAMW
ILdbAJMBDKFgSS3ySQJELvxZ1kagGwnVYku3BK1Gf87I84Zx83j/CvUapjNFgkyG
Kh9dFHrGtvCLy8ZRV2NuLQXoKGAJ5HVddMJV/oekhROsX20AquXAqLncnnNbQi1/
myd7L8yJhKaDFnYN7TiLwE43OPiMHDDWdnCQlrPmxx9ptKL2Uio356ncebu1hooR
jlYCCNWM0eMy1tdKoR+A+R4QEdma2yREfJT0KrME27PRVEYIK4PyrgI+DRsf55DD
7GOziMLKKa5ReybJD1YMMhwl9TBLm8YNceTWTM5jPFAqxxTC/n01F6eMEK3EcMV7
ymzf3PC5GjO1nGYCzosW5hCG9xAyWZW8IcG9LQ/0unFctHPh0rXbZDGXeY29Sgyl
n30M60c32/5oFlNoelkDosqiRWriacaICzssQIgT0bN0U4QJpxY=
=P3Dp
-----END PGP SIGNATURE-----

--cf0hFtnykp6aONGL--

