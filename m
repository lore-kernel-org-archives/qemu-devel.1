Return-Path: <SRS0=5wN1=WA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA140C433FF
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 04:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7746C2054F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 04:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Xu/DyUKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7746C2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hu7mp-0000v2-LV
	for qemu-devel@archiver.kernel.org; Sun, 04 Aug 2019 00:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48361)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hu7mK-0000Lf-85
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 00:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hu7mI-0000tc-6G
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 00:05:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34037 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hu7mE-0000pf-9P; Sun, 04 Aug 2019 00:05:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 461S421Wtcz9sN4; Sun,  4 Aug 2019 14:05:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564891538;
 bh=d3hFxJUQCkOWUrYdDhdeqmU7aD7dhn4ppJGVpdxEP0g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Xu/DyUKeze6+rvbD/aYttPUIvYP3CxuMURnoiELkKzZxjhvlblMbNj2FXJTTghNUN
 SldHnW+X+IMzJBpEmsw33PWyMIwwK1+5A0wyuq4kHRfs0R6m8fINXYCdJlVsqDNgz/
 QQmZLkIaWP/kux9wfpj+fEMXb0lLs/8Xwezvl20E=
Date: Sun, 4 Aug 2019 13:29:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Black <daniel@linux.ibm.com>
Message-ID: <20190804032915.GC9535@umbus.fritz.box>
References: <20190801033819.29664-1-daniel@linux.ibm.com>
 <20190801124159.75d9fa48@bahia.lan>
 <20190802110348.60f22d92@volution.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <20190802110348.60f22d92@volution.ozlabs.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] spapr: quantify error
 messages regarding capability settings
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
Cc: "open list:sPAPR" <qemu-ppc@nongnu.org>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2019 at 11:03:48AM +1000, Daniel Black wrote:
> On Thu, 1 Aug 2019 12:41:59 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Thu,  1 Aug 2019 13:38:19 +1000
> > Daniel Black <daniel@linux.ibm.com> wrote:
> >=20
> > > Its not immediately obvious how cap-X=3DY setting need to be applied
> > > to the command line so, for spapr capability error messages, this
> > > has been clarified to:
> > >=20
> ...
> > > index bbb001f84a..1c0222a081 100644
> > > --- a/hw/ppc/spapr_caps.c
> > > +++ b/hw/ppc/spapr_caps.c
> > > @@ -37,6 +37,8 @@
> > > =20
> > >  #include "hw/ppc/spapr.h"
> > > =20
> > > +#define CAPABILITY_ERROR(X) "appending -machine " X =20
> >=20
> > I would make that:
> >=20
> > #define CAPABILITY_HINT() "try appending -machine " X
> >=20
> > because it is really an hint for the user, not an
> > error,
>=20
> Works for me. At the lowest layer it is a hint.

Oh.. of course it is.  Which means we should be using the
error_append_hint() system that's for exactly this sort of
information.

Sorry I didn't think of that earlier.

>=20
> > and all original strings have "try",
>=20
> True.
>=20
> > except...
>=20
>=20
> > > @@ -249,11 +255,13 @@ static void
> > > cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val, if
> > > (tcg_enabled() && val) { /* TCG only supports broken, allow other
> > > values and print a warning */ error_setg(&local_err,
> > > -                   "TCG doesn't support requested feature,
> > > cap-cfpc=3D%s",
> > > +                   "TCG doesn't support requested feature, "
> > > +                   CAPABILITY_ERROR("cap-cfpc=3D%s"), =20
> >=20
> > ... this one, but it doesn't look like a hint to me. It just tells
> > which is the unsupported cap.
>=20
> This is one of 3 that local_error (commit
> 006e9d3618698eeef2f3e07628d22cb6f5c2a039) - intentionally just a
> warning and to TLDR the commit/Suraj conversation; defaults apply
> to all machine types; hardware security measures don't make sense in
> TCG; hence warning.
>=20
> For every function with CAPABILITY_[ERROR|HINT] its called by
> spapr_caps_apply, has its errp as &error_fatal (intentionally - spoke
> to Suraj - migrations to machines without capabilities need to fail and
> defaults (kvm) should be secure unless explicitly disabled).
>=20
> > >                     cap_cfpc_possible.vals[val]);
> > >      } else if (kvm_enabled() && (val > kvm_val)) {
> > >          error_setg(errp,
> > > -"Requested safe cache capability level not supported by kvm, try
> > > cap-cfpc=3D%s", +"Requested safe cache capability level not supported
> > > by kvm, try "
> > > +                   CAPABILITY_ERROR("cap-cfpc=3D%s"),
> > >                     cap_cfpc_possible.vals[kvm_val]); =20
> >=20
> > Also, we have a dedicated API for hints, which are only printed under
> > the monitor but ignored under QMP.
>=20
> Ok.
> =20
> > Not sure why it isn't used here but it should be something like:
>=20
> If error_append_hint should be used for fatal errors (all that use
> errp), then this patten should be applied further to
> CAPABILITY_[HINT|ERROR] functions.
>=20
> If error_append_hint needs to apply to warnings
> cap_[cfpc/sbbc/ibs]_apply functions need to use it.
>=20
> Would I be right in I'm assuming that the below pattern needs to apply
> to both of these cases?
>=20
> >         error_setg(errp,=20
> >                    "Requested safe cache capability level not
> > supported by kvm");
> >         error_append_hint(errp,
> > CAPABILITY_HINT("cap-cfpc=3D%s") "\n", cap_cfpc_possible.vals[kvm_val]);
>=20
> This is going a little beyond the scope of fixing a message, ok, but
> lets not extend the scope too much more.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1GUQgACgkQbDjKyiDZ
s5II1g/9HgsTdeWtQkWVRw3HLIbu0fgHfN66kwndcpk8yBHdARmRTaDtctqONzQv
PkVA+KkBCY/Dpb/EUsKtUHvEQ9coUF0kHalWYxRD0wNQOncuMtKXlo/7KCDwSeln
Ejc/b0hHMv0GLj++o8KgzPxho6N+EW4izecjLR0IVnt35QZxY4cC/XSNSoWmVOIS
fD97VbkV1KXyrStPHg1xMX5R5Wy8wTG8Zh8xP3mOReGqFLnCjGhbEJHQjlhwA1jd
FliStxBFX/vP6/UrU7HFah0GLiUJjxikzLxHn8sTgkITngpuW0YCU+qQ9L9Kp8p/
y9IPiJkA1fv56ogMKJcuEZ9E2JDT/htUPZNI6zhsMC55dg4Bs1gYanxtJsTUfgJS
eTv5lTvqfcjmguqiya+VXEBSkWkaDCtRsTUzBjaP31V+VxA1x7vVXI3z6udTMzHy
QxI5qBXYjvHOjlKh1rsxggtVS6Wk350yxn9RGB4OMoaT443WESWnjjSOOnRvB9q2
Lyjgd5QeopzXXuLMbywa6asot8Ws8eSy+3mUVVKDsJY8qFPV5HkQP5LmOPINj8F9
HpEIF+2PO33scec13eW+Xkua1soNXOVHAwDCReJ5rswbR/ZgXTRgxsNPf7GcgPJc
Wu3m5NHqFrxKS1XKnqPB0phJSRkN6xc2tleVMo0ojym9/9kXw8g=
=vC53
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--

