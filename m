Received: from eggs.gnu.org ([2001:4830:134:3::10]:55090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d6LqN-0006eA-Sg
	for qemu-devel@nongnu.org; Thu, 04 May 2017 14:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d6LqK-0001fg-QS
	for qemu-devel@nongnu.org; Thu, 04 May 2017 14:51:15 -0400
Received: from 19.mo5.mail-out.ovh.net ([46.105.35.78]:47580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d6LqK-0001dz-Jw
	for qemu-devel@nongnu.org; Thu, 04 May 2017 14:51:12 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id F3F1BE88FF
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 20:51:03 +0200 (CEST)
Date: Thu, 4 May 2017 20:50:47 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170504205047.161b45ca@bahia>
In-Reply-To: <1493917751.4214.12.camel@redhat.com>
References: <20170427072843.8089-1-david@gibson.dropbear.id.au>
	<20170427072843.8089-3-david@gibson.dropbear.id.au>
	<1493917751.4214.12.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/M/BzR+Kn1v++74aAVsmdrsA";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCHv3 2/4] pseries: Move CPU compatibility
 property to machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, agraf@suse.de, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

--Sig_/M/BzR+Kn1v++74aAVsmdrsA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 04 May 2017 19:09:11 +0200
Andrea Bolognani <abologna@redhat.com> wrote:

> On Thu, 2017-04-27 at 17:28 +1000, David Gibson wrote:
> > @@ -2480,6 +2480,10 @@ static void spapr_machine_initfn(Object *obj)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0" place of standard EPOW events when possible"
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0" (required for memory hot-unplug support)",
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0NULL);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0object_property_add(obj, "max-cpu-compat", "st=
r",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
ppc_compat_prop_get, ppc_compat_prop_set,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
NULL, &spapr->max_compat_pvr, &error_fatal); =20
>=20
> I'm not familiar with QEMU's object system, but shouldn't
> you be using object_property_add_str() instead? It looks
> like you're doing more than the straightforward wrapper
> would do, so maybe that's just not possible.
>=20
>=20
> In any case, all other string properties look like
>=20
> =C2=A0 pseries-2.10.kvm-type=3Dstring
>=20
> whereas this one ends up looking like
>=20
> =C2=A0 pseries-2.10.max-cpu-compat=3Dstr
>=20
> which I think should be fixed - object_property_add_str()
> passes "string" instead of "str" to object_property_add().
>=20
> You should also add a sensible description for the property,
> preferably spelling out all the accepted values.
>=20
>=20
> Speaking of properties...
>=20
> =C2=A0 $ qemu-system-ppc64 -cpu host,compat=3Dwhatever
> =C2=A0 Segmentation fault
>=20
> You might want to look into that ;)
>=20

This happens because patch 2 is missing a change for the recently added POW=
ER9:

         .max_threads =3D 8,
     },
     { /* POWER9, ISA3.00 */
+        .name =3D "power9",
         .pvr =3D CPU_POWERPC_LOGICAL_3_00,
         .pcr =3D PCR_COMPAT_3_00,
         .pcr_level =3D PCR_COMPAT_3_00,


> --=C2=A0
> Andrea Bolognani / Red Hat / Virtualization


--Sig_/M/BzR+Kn1v++74aAVsmdrsA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkLeAcACgkQAvw66wEB28JOagCfbU7Nzz6+7UkdzX0VeokYI6aR
GakAn26i/PVE//6Qc4+8F3kTvKt/2gxH
=HLSW
-----END PGP SIGNATURE-----

--Sig_/M/BzR+Kn1v++74aAVsmdrsA--
