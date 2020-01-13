Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D4AC33CAE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 07:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1ACA2075B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 07:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ks3HBY5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1ACA2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqttg-0003sQ-0D
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 02:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iqtss-0003Ld-7Z
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 02:11:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iqtsq-00069c-HS
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 02:11:33 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:55123)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iqtsp-00066O-Ot; Mon, 13 Jan 2020 02:11:32 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47x4Wf64KYz9sP6; Mon, 13 Jan 2020 18:11:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578899486;
 bh=vGBO/AL1Y52EBxODY0t3OJNUEj3opc7xAFl1ISxXDiI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ks3HBY5/1tKp2OHRkLf0xGCK7tvQBJwIp8oCZiuy2WifJKSEX2lYYSLR4z5GmAT0J
 GPGVLaNQyptL0HqP3hZ2cMZ0oVSNjWMtUzu5jp5n6iGifUK0Nwi4t6Mi5h8m5kl9vb
 h+wSPoe8Ku7KarZsDGk92Swla0NwLWdn/crKdE6A=
Date: Mon, 13 Jan 2020 17:05:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu v4] spapr: Kill SLOF
Message-ID: <20200113070500.GD19995@umbus>
References: <20200108061856.4554-1-aik@ozlabs.ru>
 <b4011a6b-d502-b514-84ad-4e6a1580449d@ozlabs.ru>
 <75b2a298-b549-dcc9-519b-7bf7c388110b@ozlabs.ru>
 <684e7d31-04d0-3176-5de2-c817ce1aedf3@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Content-Disposition: inline
In-Reply-To: <684e7d31-04d0-3176-5de2-c817ce1aedf3@ozlabs.ru>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2020 at 11:51:32AM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 10/01/2020 10:32, Alexey Kardashevskiy wrote:
> >=20
> >=20
> > On 10/01/2020 10:05, Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 08/01/2020 17:18, Alexey Kardashevskiy wrote:
> >>> The Petitboot bootloader is way more advanced than SLOF is ever going=
 to
> >>> be as Petitboot comes with the full-featured Linux kernel with all
> >>> the drivers, and initramdisk with quite user friendly interface.
> >>> The problem with ditching SLOF is that an unmodified pseries kernel c=
an
> >>> either start via:
> >>> 1. kexec, this requires presence of RTAS and skips
> >>> ibm,client-architecture-support entirely;
> >>> 2. normal boot, this heavily relies on the OF1275 client interface to
> >>> fetch the device tree and do early setup (claim memory).
> >>>
> >>> This adds a new bios-less mode to the pseries machine: "bios=3Don|off=
".
> >>> When enabled, QEMU does not load SLOF and jumps to the kernel from
> >>> "-kernel".
> >>>
> >>> The client interface is implemented exactly as RTAS - a 20 bytes blob,
> >>> right next after the RTAS blob. The entry point is passed to the kern=
el
> >>> via GPR5.
> >>>
> >>> This implements a handful of client interface methods just to get goi=
ng.
> >>> In particular, this implements the device tree fetching,
> >>> ibm,client-architecture-support and instantiate-rtas.
> >>>
> >>> This implements changing FDT properties for RTAS (for vmlinux and zIm=
age)
> >>> and initramdisk location (for zImage). To make this work, this skips
> >>> fdt_pack() when bios=3Doff as not packing the blob leaves some room f=
or
> >>> appending.
> >>>
> >>> This assigns "phandles" to device tree nodes as there is no more SLOF
> >>> and OF nodes addresses of which served as phandle values.
> >>> This keeps predefined nodes (such as XICS/NVLINK/...) unchanged.
> >>> phandles are regenerated at every FDT rebuild.
> >>>
> >>> This defines phandles for VIO devices to have phandle assigned to
> >>> the default stdout device at the point when we write "/chosen/stdout"
> >>> which an ihandle which the OS uses to write to the console.
> >>
> >>
> >> And I do not really need to preallocate phandles for stdout as it is a
> >> leftover from when I populated /chosen/stdout before populating VIO
> >> nodes, now /chosen/stdout is added at the very end. Thanks,
> >=20
> >=20
> > Ah noo, I do, to implement "write" to the selected stdout as I need to
> > trace ihandle back to Object* and  object_resolve_path() does not know
> > about FDT path, it is /machine/peripheral/svty0 in QOM. The commit log
> > needs an update, or this needs a fix but I cannot think of a nicer one.
> > Thanks,
>=20
>=20
> I just might extend instances to do real instances, i.e. associate
> ihandle with phandle _and_ Object*, I just need a helper to find Object
> which matches what qdev_get_fw_dev_path() returns. Fun :)

If you only allow one instance per device, could you just make
ihandles =3D=3D phandle | CONSTANT?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4cFpoACgkQbDjKyiDZ
s5LYZA//Vl6zFQdCGS/RFyKwgqzd2p6GnU7swDFlzEWbKcTdvzOPExi0Gsq072A9
ZPNQZFTiUn8MteAF5NpJ/m7GPWaSPkOYHMHaTm3SvI7Ov3Q7SzKD2T5Lck0Sv+B0
ptcxV2R8XwvsiQ1cVBG45MmLvZa5YUFR3Vg/gHQvGQIDTLc2BLgE9GHecnYBWOek
q3bN/5oXzT37/uchD3wn6BMJRRZ+Tg+Ejwm0C65W0GDRbdWKkEsKQIkykrK3MJ5n
4UhndjJlm9FISgs5PAvsxuWpt+XGKgVeV/pwBb0tBOQfkJ5UVU8N2ARvW9pDl7dD
G47aM+QFCB1Ul3RLbAu02n2iPuEBnWC4+NA9tVVUJP7iapXf8bWgvbE8SMTnTWdu
fliMyJTKVRVQQMxd4OqEcNwZ2S+whcHW/kZ2WZJswmmxLe7mb+dsHJlcPhfo/AEe
n85IufQnP4dKh4ldasEP1QOX5OCfw/D2B/8SCdcRmbzljm/2y6okzvOUnIsPKY79
d13++CpAt+8Kc8lqHC3C7mnEybMFXKs+26b2jAzpDJ5jxQdcRPjaW9zpFQ9L55ab
ZotWYP8VRlsOotN7sUUTRHKAxiuN//JH+GU/W3sgqIXDd0ZZewPQa0rCexXnfaiM
MqAR7qnzrnu4BtWvvP0rltYWYz+/2F7KpLZMGYH17vfCeusGcok=
=hkgK
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--

