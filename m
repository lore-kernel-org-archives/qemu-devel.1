Return-Path: <SRS0=i/12=ZI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0891C432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 01:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB27520730
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 01:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NNnOH1r+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB27520730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVmtt-0006aB-QV
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 20:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iVmt0-0005yc-Kt
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 20:28:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iVmsz-0006RG-6V
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 20:28:26 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:49797)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iVmsy-0006Pq-49; Fri, 15 Nov 2019 20:28:25 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47FHfV3cZ7z9sPV; Sat, 16 Nov 2019 12:28:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1573867698;
 bh=DhjX/mtCHEd52qIAayLcJinNQDZb8pLC6aShNMcTNjs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NNnOH1r+NTvhw/eWTTa1bEx02VTp5R/UDpLr6KSbKZ6h0KGLZ4HjH3Sh/XM5up18B
 u4G2bxHmcTU3Azg7couWPyeLuELaYFBv1u2uOzTTjb+MiGwpcEmtVAPWqDvWuJ8fiU
 RJQdpW9w/JAJQdb3q55uMinW5FgWv9bjMjBsnYPw=
Date: Sat, 16 Nov 2019 12:28:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 for-5.0 0/8] ppc: Consolidate QOM links and pointers
 to the same object
Message-ID: <20191116012807.GS2134@umbus.fritz.box>
References: <157383332103.165747.15204186097237659466.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VmyrZ50r30oK77nV"
Content-Disposition: inline
In-Reply-To: <157383332103.165747.15204186097237659466.stgit@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--VmyrZ50r30oK77nV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 04:55:21PM +0100, Greg Kurz wrote:
> There's a recurring pattern in the code where a const link is added to a
> newly instanciated object and the link is then used in the object's reali=
ze
> function to keep a pointer to the QOM entity which the link points to.
>=20
> void create_obj_b(Object *obj_a)
> {
>     Object *obj_b;
>=20
>     obj_b =3D object_new(TYPE_B);
>     object_property_add_const_link(obj_b, "link-to-a", obj_a, &error_abor=
t);
>     object_property_set_bool(obj_b, true, "realized", &error_abort);
> }
>=20
> void object_b_realize(DeviceState *dev, Error **errp)
> {
>     Object *obj_a;
>=20
>     obj_a =3D object_property_get_link(OBJECT(dev), "link-to-a", errp);
>     if (!obj_a) {
>         return;
>     }
>=20
>     obj_b->obj_a =3D A(obj_a); // If obj_b->obj_a is changed, the link pr=
operty
>                              // still points to the original obj_a that w=
as
>                              // passed to object_property_add_const_link()
> }
>=20
> Confusing bugs could arise if the pointer and the link go out of sync for
> some reason. This can be avoided if the property is defined to directly u=
se
> the pointer with the DEFINE_PROP_LINK() macro.
>=20
> This series just does that for all occurences of the fragile pattern in
> the XIVE and PNV code.
>=20
> Changes in v2:
> - use DEFINE_PROP_LINK() instead of object_property_add_link()
> - dropped public -> private changes in type definitions

Applied to ppc-for-5.0.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VmyrZ50r30oK77nV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3PUKUACgkQbDjKyiDZ
s5IawRAAl9/5yMQerjhPf0MSDDI4y4TUDvY2LK/Dv24rGpYfiBmEAksSWyluUfVR
JybDXx1/oq2UHr+uFfn5eYTXZYUb+qWSOY0YpK4XOt6pE3p+6xgFbuTWoO80qcWn
JWMwvB1NmdbALGB0nHH3Px5hzcyBNUvxLXjkbRBYS6RTaspVFikupvYVVPco5J4c
C8G1Skz5M3c/sTUfCrtdWfyOV2AwUxiacTTZxspNpri8trYWped8gTG5upIMhQO6
5XNT4l7zSj5jxKmUwB1F1hQchLHGV28pvuceFwWyBuZEacXD1MYQQR8toK8f+9jg
jBwgxhApCumIXYiUzEVLbwO2B1ZfYN0BzekYQ8AoNCkut6JBCnv5zZKJPXOgh5uF
/QhYPf9H/vbykf2y3514dY2myB6JJCB5YmCQOwVD+fAKHf0bByeyZM+2tdJ77ttU
d8qRwBSMEhbq7EQuX5Qai0O1kCoS478wDDTFGBGK0jq3bo4f9XyJQ9PGGB75SpVs
lIU6FjJrGv9abpqcFH9l+w6uqGK0m7QV/zGkXxpjYr2Rgb9V12gPgve8/LD6j0Cj
CJAqOtco7ME8SDFHqti1vBBgwarI6dkW4IC4vPKAQyu5hzbMTvzlukqlogxrw6W5
LFSQ2qK4wiPgncF9YfOuVgEMcyfMBXUtndZt2LUavn1BoM4a3EI=
=rUQS
-----END PGP SIGNATURE-----

--VmyrZ50r30oK77nV--

