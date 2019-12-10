Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E320CC2D0BF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 00:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1020206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 00:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Tjer6ukK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1020206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieqDb-00060N-KT
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 19:51:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ieqC9-0004TN-V8
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 19:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ieqC8-0002Il-C4
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 19:49:37 -0500
Received: from ozlabs.org ([203.11.71.1]:55581)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ieqC7-0002FH-56; Tue, 10 Dec 2019 19:49:36 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47XdcB5KQ9z9sR7; Wed, 11 Dec 2019 11:49:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576025370;
 bh=+kw3f5DhiGPeBwW730RSQttGk+6mKbOyaBp6wNWNJXs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Tjer6ukKzHV9SEu0TeMUPPQU1tyAVP4qPlJLFDObqg0R6g5t/eFCiJfIwfNXzSUnh
 RvrrDNrhP6AfYHk47XyxRT60eaOEWvqPU0uqMsmDzJV2X/88ZiY0p/QFiHmyvyq4Ez
 DnQf9/cTR0rO8pYLNpo12qEwbd8TqVMI1q/ANIV0=
Date: Wed, 11 Dec 2019 10:42:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 2/5] ppc/pnv: Introduce a POWER10 PnvChip and a powernv10
 machine
Message-ID: <20191210234238.GM207300@umbus.fritz.box>
References: <20191205184454.10722-1-clg@kaod.org>
 <20191205184454.10722-3-clg@kaod.org>
 <20191210033454.GE207300@umbus.fritz.box>
 <ba99c545-fa33-fd34-0308-ed83f7ad62f4@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="um2V5WpqCyd73IVb"
Content-Disposition: inline
In-Reply-To: <ba99c545-fa33-fd34-0308-ed83f7ad62f4@kaod.org>
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--um2V5WpqCyd73IVb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2019 at 09:52:05AM +0100, C=E9dric Le Goater wrote:
> On 10/12/2019 04:34, David Gibson wrote:
> >> +static inline bool pnv_chip_is_power10(const PnvChip *chip)
> >> +{
> >> +    return PNV_CHIP_GET_CLASS(chip)->chip_type =3D=3D PNV_CHIP_POWER1=
0;
> >> +}
> >> +
> >> +static inline bool pnv_is_power10(PnvMachineState *pnv)
> >> +{
> >> +    return pnv_chip_is_power10(pnv->chips[0]);
> >> +}
> >
>=20
> I agree this is starting to be ugly.
>=20
> > It's not in scope for this series, but now that we have P8/9/10
> > specific chip object types and powernv8/powernv9, we should be able to
> > remove the ugly chip_type field, and just do object class checks on
> > the chip and or machine objects themselves.
> =20
>=20
> So we would use object_class_dynamic_cast() instead of field
> chip_type ?

Just object_dynamic_cast() should suffice, since you have access to
the chip and machine instances.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--um2V5WpqCyd73IVb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3wLW4ACgkQbDjKyiDZ
s5Lh+Q//Y6RJZHaqGbgbgXfOfzyeALOXwYGCOTAQvnDUyvFVacJoUreP+BF72lBR
gfVp05cHVeZ2sRYVJX2tp7ZtBMMUbKEbrcr2hek+7CJ965BT4cwvxkuEtHPbF7k0
ucFqtSYGN5KPwEDbJ+HCxU0kfQTFUVWa/frrt63N2GfBLesr6YIN2NnDVDEe517e
MdQnQAmnkIc+U8Pyg4hshpceyu3XAqNZX8wHN+faBgecR8ud++zYowM6nfzJvkYQ
eKZt9ANhzO6oUMcx1JgMErQV1pcEgtVNlftdfD8nLVToNczYiv6aeSZf0UWjt4rM
mbmJo1U2TsOktHyqreuajYAMbk7dBHNXkviRDNIWK5pzKQPrXNvzRTE7AFl/NsPh
omAz9dtebxcSBUon3QBT2TQy5XMRw2w904mdOsvrd8jkspt9kqmCq/X1MUCDlIRh
EQ92mxRNX19ZJ23exSXbQAE6MrQiGSmpS4RsUA+icxh99x4UohdCrnbv0OJlvweI
JsSyqVtafBeZMuUSCrGGujQ5yZimN/i3iIGjIolvkQfJXWAJYZBunvBY4BupZEvH
qDsJeqDjfOmJlx9yHzeD/4Ep0j1pqUgqP5VLfTenMyz4RjB36c1syij57ZGkcOhT
J6Q6+aiSDXEUmxRq2ZnBtedq0aayx9V/eol6LF6zVjq0l0vxbCc=
=nh5L
-----END PGP SIGNATURE-----

--um2V5WpqCyd73IVb--

