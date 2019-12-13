Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F23C2D0BF
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 05:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B45214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 05:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NC/fhWd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B45214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifdvw-0000Sp-RM
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 00:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ifduG-0007RO-4j
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 00:54:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ifduE-0006Ln-SQ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 00:54:28 -0500
Received: from ozlabs.org ([203.11.71.1]:38345)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ifduE-0006Df-Eq; Fri, 13 Dec 2019 00:54:26 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47Z0Gw0S9Hz9sRC; Fri, 13 Dec 2019 16:54:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576216456;
 bh=QRjCKhPklx7jYiNvtvPK7bu2T+O3GgW51aD2ZeVjAOs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NC/fhWd4W9Y2q1F5LsnwZpFjNcc+GJRO1+eXEDBTqNHsaBmDDXuFxWmZmVPMFdPRl
 rGi3Jq1kaH7iGATJSVmDYQ1kX0g3RRi0EfjoWMwB5GfhH5fRS7aqee9Gt3Ddeo1wkY
 O0W15Doj5Vg+IrOnwrpDGcWO288GTvThFXsEKRoM=
Date: Fri, 13 Dec 2019 16:52:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, y@umbus.fritz.box
Subject: Re: [PATCH v2 ppc-for-5.0 2/2] ppc/spapr: Support reboot of secure
 pseries guest
Message-ID: <20191213055259.GF207300@umbus.fritz.box>
References: <20191212055059.9399-1-bharata@linux.ibm.com>
 <20191212055059.9399-3-bharata@linux.ibm.com>
 <aeadba2d-1699-a750-2dc2-cf9921e57680@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BqNvIJgrK1/MQy2W"
Content-Disposition: inline
In-Reply-To: <aeadba2d-1699-a750-2dc2-cf9921e57680@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: linuxram@us.ibm.com, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
 paulus@ozlabs.org, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--BqNvIJgrK1/MQy2W
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2019 at 08:34:57AM +0100, C=E9dric Le Goater wrote:
> Hello Bharata,
>=20
>=20
> On 12/12/2019 06:50, Bharata B Rao wrote:
> > A pseries guest can be run as a secure guest on Ultravisor-enabled
> > POWER platforms. When such a secure guest is reset, we need to
> > release/reset a few resources both on ultravisor and hypervisor side.
> > This is achieved by invoking this new ioctl KVM_PPC_SVM_OFF from the
> > machine reset path.
> >=20
> > As part of this ioctl, the secure guest is essentially transitioned
> > back to normal mode so that it can reboot like a regular guest and
> > become secure again.
> >=20
> > This ioctl has no effect when invoked for a normal guest. If this ioctl
> > fails for a secure guest, the guest is terminated.
>=20
> This looks OK.=20
>=20
> > Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> > ---
> >  hw/ppc/spapr.c       | 15 +++++++++++++++
> >  target/ppc/kvm.c     |  7 +++++++
> >  target/ppc/kvm_ppc.h |  6 ++++++
> >  3 files changed, 28 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index f11422fc41..25e1a3446e 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1597,6 +1597,21 @@ static void spapr_machine_reset(MachineState *ma=
chine)
> >      void *fdt;
> >      int rc;
> > =20
> > +    /*
> > +     * KVM_PPC_SVM_OFF ioctl can fail for secure guests, check and
> > +     * exit in that case. However check for -ENOTTY explicitly
> > +     * to ensure that we don't terminate normal guests that are
> > +     * running on kernels which don't support this ioctl.
> > +     *
> > +     * Also, this ioctl returns 0 for normal guests on kernels where
> > +     * this ioctl is supported.
> > +     */
> > +    rc =3D kvmppc_svm_off();
> > +    if (rc && rc !=3D -ENOTTY) {
>=20
> I would put these low level tests under kvmppc_svm_off().
>=20
> > +        error_report("Reset of secure guest failed, exiting...");
> > +        exit(EXIT_FAILURE);
>=20
> The exit() could probably go under kvmppc_svm_off() also.

TBH, I don't think these details matter all that much.

But if I had to pick a preferred option here it would be:

int kvmppc_svm_off(Error **errp)

Which would set the errp with error_setg_errno() except in the case of
ENOTTY.  spapr_machine_reset() would call it with &error_fatal.  That
puts the analysis of whether the error is expected into
kvmppc_svm_off() - which is best equipped to know that, but the choice
of what to do about it (fail fatally) in the reset caller.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BqNvIJgrK1/MQy2W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3zJzsACgkQbDjKyiDZ
s5IgVBAArCP6msuIuJU5Nz6KMqSvnmh1CSzVpzlP7R0kiRaKHa+c/Im6+bwZmjSy
0f9PQSmr3bSd3vBUJXoJRBw/2VxPZBOspgDr1f5h/FnfXGXUj1rgKwjtHf3xM00Q
/b7eC4FGvnbMLfGnjPshAJEP/P/JaXqODvLYXiaim9eKPIVboUFxnRepBT0vdRMd
GPiXG2todTwsdSeMvWd61RBeAjnD57SJZMuiUSgbJ8cTePZpBYU8ppidCRxh4Bc6
TzVfun9YssYu5YAciBoRNDWLR5amDfpOUBe6ctV0K+Qy0wsvhgmA9IJvIGJLq53d
dEkpR76agWosXc22aS06RjxZfpFi5nsQin8xuXW5fTKhZ+s/xbkHFgl1IqBbiozu
kGsQevCUVzzDOW6f+wQgqhOqN0968JmiS07iUkLZkTSmWoWUTXdMlcfetvmnYtDc
0jsKxz4Q/m/HjBiLvvJwDy9i1e25QQ/DsxSblgVH8HIodfRyrfk9gauH64dHqlPz
2M2vRiDFkKgdt97dq4faPEdnT0PGignI08HD6hbpSrcNNDfYdYUpoNlKDjwFTQ9O
JpetAIiN7VDLA4n5v4m7kZC8b49lT+OBFuy3/jEm+9MqAsy59t6/wplkcUkKeH+b
CIkMtYKurAbMIyW+V6mpgPA5rig//v+n2cznZM6/WAdvDcHjHMM=
=pWKu
-----END PGP SIGNATURE-----

--BqNvIJgrK1/MQy2W--

