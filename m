Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5450BC33CA3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 04:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C47206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 04:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="p9xvEC+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C47206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipPQT-0004X2-Qv
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 23:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ipPOq-0003AI-BG
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:26:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ipPOo-0000ka-Hl
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:26:24 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:58463 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ipPOo-0000c7-2m; Wed, 08 Jan 2020 23:26:22 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47tY2x4HQJz9sRY; Thu,  9 Jan 2020 15:26:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578543977;
 bh=k35VB7jck5EdbAcJ/pE469Ier18LRiHhJg9+zSffLQM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p9xvEC+hQV8S7mojEmKjmOrtLdNQZRfIsnlceV3W/nUXyInUTTfzmzKbpy/s/cizU
 +SK43OYnuqAzoDQQIoR+z5fKlC4vTu9HvVhmKZXI7Hrx4A1wyxky78FchVVGjoMKVp
 rv+K8qsA7oLLTeUSz4NQGkeaET3hzQQkg4ocxZC4=
Date: Thu, 9 Jan 2020 15:07:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu v2] spapr: Kill SLOF
Message-ID: <20200109040715.GM8586@umbus.fritz.box>
References: <20200105234242.78897-1-aik@ozlabs.ru>
 <20200106041940.GV2098@umbus>
 <80157816-7859-3450-6a2c-ab151be5ee94@ozlabs.ru>
 <20200106085042.GW2098@umbus>
 <741e9b5e-6a7d-66a4-451d-e37c30697b2b@ozlabs.ru>
 <20200107052604.GH2098@umbus>
 <a76e906f-4cf0-aa49-759d-e64b7f219a1b@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xHbokkKX1kTiQeDC"
Content-Disposition: inline
In-Reply-To: <a76e906f-4cf0-aa49-759d-e64b7f219a1b@ozlabs.ru>
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


--xHbokkKX1kTiQeDC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2020 at 03:07:41PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 07/01/2020 16:26, David Gibson wrote:
>=20
> >>>>>> +static uint32_t client_setprop(SpaprMachineState *sm,
> >>>>>> +                               uint32_t nodeph, uint32_t pname,
> >>>>>> +                               uint32_t valaddr, uint32_t vallen)
> >>>>>> +{
> >>>>>> +    char propname[64];
> >>>>>> +    uint32_t ret =3D -1;
> >>>>>> +    int proplen =3D 0;
> >>>>>> +    const void *prop;
> >>>>>> +
> >>>>>> +    readstr(pname, propname);
> >>>>>> +    if (vallen =3D=3D sizeof(uint32_t) &&
> >>>>>> +        ((strncmp(propname, "linux,rtas-base", 15) =3D=3D 0) ||
> >>>>>> +         (strncmp(propname, "linux,rtas-entry", 16) =3D=3D 0))) {
> >>>>>> +
> >>>>>> +        sm->rtas_base =3D readuint32(valaddr);
> >>>>>> +        prop =3D fdt_getprop_namelen(sm->fdt_blob,
> >>>>>> +                                   fdt_node_offset_by_phandle(sm-=
>fdt_blob,
> >>>>>> +                                                              nod=
eph),
> >>>>>> +                                   propname, strlen(propname), &p=
roplen);
> >>>>>> +        if (proplen =3D=3D vallen) {
> >>>>>> +            *(uint32_t *) prop =3D cpu_to_be32(sm->rtas_base);
> >>>>>> +            ret =3D proplen;
> >>>>>> +        }
> >>>>>
> >>>>> Is there a particular reason to restrict this to the rtas propertie=
s,
> >>>>> rather than just allowing the guest to fdt_setprop() something
> >>>>> arbitrary?
> >>>>
> >>>> The FDT is flatten and I am not quite sure if libfdt can handle upda=
ting
> >>>> properties if the length has changed.
> >>>
> >>> fdt_setprop() will handle updating properties with changed length (in
> >>> fact there's a special fdt_setprop_inplace() optimized for the case
> >>> where you don't need that).  It's not particularly efficient, but it
> >>> should work fine for the cases we have here.  In fact, I think you're
> >>> already relying on this for the code that adds the phandles to
> >>> everything.
> >>
> >> Well, I used to add phandles before calling fdt_pack() so it is not ex=
actly the same.
> >=20
> > Ah, right, that's why adding the phandles worked.
> >=20
> >>> One complication is that it can return FDT_ERR_NOSPACE if there isn't
> >>> enough buffer for the increased thing.  We could either trap that,
> >>> resize and retry, or we could leave a bunch of extra space.  The
> >>> latter would be basically equivalent to not doing fdt_pack() on the
> >>> blob in the nobios case.
> >>
> >>
> >> This is what I ended up doing.
> >>
> >>
> >>>> Also, more importantly, potentially property changes like this may h=
ave
> >>>> to be reflected in the QEMU device tree so I allowed only the proper=
ties
> >>>> which I know how to deal with.
> >>>
> >>> That's a reasonable concern, but the nice thing about not having SLOF
> >>> is that there's only one copy of the device tree - the blob in qemu.
> >>> So a setprop() on that is automatically a setprop() everywhere (this
> >>> is another reason not to write the fdt into guest memory in the nobios
> >>> case - it will become stale as soon as the client changes anything).
> >>
> >>
> >> True to a degree. It is "setprop" to the current fdt blob which we do =
not
> >> analyze after we build the fdt. We either need to do parse the tree be=
fore
> >> we rebuild it as CAS so we do not lose the updates or do selective cha=
nges
> >> to the QEMUs objects from the "setprop" handler (this is what I do
> >> now).
> >=20
> > Hrm.. do those setprops happen before CAS?
>=20
> Yes, vmlinux/zimage call "setprop" for "linux,initrd-start",
> "linux,initrd-end", "bootargs", "linux,stdout-path"; vmlinux sets
> properties if linux,initrd-* came from r3/r4 and zImage sets properties
> no matter how it discovered them - from r3/r4 or the device tree.

Ok, and those setprops happen before CAS?

In a sense this is kind of a fundamental problem with rebuilding the
whole DT at CAS time.  Except that strictly speaking it's a problem
even without that: we just get away with it by accident because CAS
isn't likely to change the same things that guest setprops do.

It's still basically unsynchronized mutations by two parties to a
shared data structure.

> btw we write them as "cells" (=3D=3D4bytes long) in qemu but vminux chang=
es
> them to 8 bytes and zImage keeps it 4 bytes. Not a problem but an
> interesting fact, this is why I had to allow extending the properties in
> "setprop" :)
>=20
>=20
> >  I would have thought we'd
> > call CAS before instantiating RTAS.
>=20
> This is correct but I do not think the order is mandatory.

Hm, right.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xHbokkKX1kTiQeDC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4WpvMACgkQbDjKyiDZ
s5IUCxAArxHkB46xPz2fbIgd1ZgxUoJRdmhBaLdXt+8WQAHPIiVea1Q29q6RYpkG
fCrSpu5f4T/dgBbl/fSWVG1WD3jR8zmi9TOgbn9eViL0tUqVfVJEgy/avNsTUIaJ
N/FYqkp9oOQEbod0Q1dJmxWhya+Cf58L4NZa5/jdFovun7gWZVIFMVUKKIUmJQ+W
TjtHdPsmCZkzAQiERSORv2jVWknuvghGdIpTGS1Uw0XhQhlLSHZRk5Fl4Xcp8SpA
vGvpg9iG3OdJ1CpvEsvKHp6DIOzT/WwoIv4kyZibraNoLGhlNxSnL18lHIugK6/D
tbHTV9iX8EgLGpjeY8wMW8wvD+8B+NtFnKMc6yRq8OQvyOiIRy89KEHgGradDxTX
8tNZmpHdpNapnlXVRQDW6PdDJKCY5KidnCTrvODEUQ5wYnWmIDLuUC/Cf1v3uDmz
K/g4Sr3jU2kgKuxiGGVUuXDJIfJ7UslqOsNmVAR49ZFgOfz0h20zOXufg7zDsIIQ
rmUTWlFZEof/0HpPXoa26Ktf3WEkyb8Ay0+b+6JytSj8dVN3kpXvldNDhCMMK1ME
Mc93vuD4HvsH/PDJw6y6Eqb8eh4TJzWJyIWU5iL2OaM20O3uObceqzc0gRkMTrvd
yl/g1UoNeyYitQaQ9oArqrPkGikwuWlhGl679TAIdJBQuFDfki0=
=iFOZ
-----END PGP SIGNATURE-----

--xHbokkKX1kTiQeDC--

