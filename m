Received: from eggs.gnu.org ([2001:4830:134:3::10]:48129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e47WJ-0007K5-Gz
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e47WI-0003Np-EG
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:41:35 -0400
References: <20171015010131.12172-1-eblake@redhat.com>
	<20171015010131.12172-5-eblake@redhat.com>
	<b96907fe-1b3d-8ab9-c4ab-761fe48f26aa@virtuozzo.com>
	<5ec13265-60d3-aeb6-641b-9aaebfbe498e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bac1f011-2aa6-5b02-707b-bbb12b9a07fd@redhat.com>
Date: Mon, 16 Oct 2017 10:41:25 -0500
MIME-Version: 1.0
In-Reply-To: <5ec13265-60d3-aeb6-641b-9aaebfbe498e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="56DxiVbp0XDgMBuo3Rj0Xk1Q5FecGi723"
Subject: Re: [Qemu-devel] [PATCH v4 4/8] nbd: Minimal structured read for
 server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--56DxiVbp0XDgMBuo3Rj0Xk1Q5FecGi723
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Message-ID: <bac1f011-2aa6-5b02-707b-bbb12b9a07fd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 4/8] nbd: Minimal structured read for
 server
References: <20171015010131.12172-1-eblake@redhat.com>
 <20171015010131.12172-5-eblake@redhat.com>
 <b96907fe-1b3d-8ab9-c4ab-761fe48f26aa@virtuozzo.com>
 <5ec13265-60d3-aeb6-641b-9aaebfbe498e@redhat.com>
In-Reply-To: <5ec13265-60d3-aeb6-641b-9aaebfbe498e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/16/2017 07:18 AM, Eric Blake wrote:
> On 10/16/2017 04:49 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 15.10.2017 04:01, Eric Blake wrote:
>>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>
>>> Minimal implementation of structured read: one structured reply chunk=
,
>>> no segmentation.
>>> Minimal structured error implementation: no text message.
>>> Support DF flag, but just ignore it, as there is no segmentation any
>>> way.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>
>=20
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ase NBD_OPT_STRUCTURED_REPLY:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (client->structured_reply) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_negotiate_send_=
rep_err(
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cli=
ent->ioc, NBD_REP_ERR_INVALID, option, errp,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "st=
ructured reply already negotiated");
>>
>> You were going to send a patch to spec for this..
>=20
> Still am; it's on my queue for tasks to do today. :)

https://lists.debian.org/nbd/2017/nbd-201710/msg00013.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--56DxiVbp0XDgMBuo3Rj0Xk1Q5FecGi723
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnk0yUACgkQp6FrSiUn
Q2rvXwgAht1wP+IqeIle+eIs6n+PMFP3r+QgU6W/K34VQqrunOJArTbEjXthScv/
+Se+BmTxkH1jtQCfIRErNndhEcqE3XXy6CZzPnyVMOhXiLwDSACG8lvaZvPWdDqC
03IgkfUgzIBf6Cl7vP+8KtxFRusLR2GtCcU4tT3/0nniaDppuUU+s45fX4ok3a5Y
EPMCMx5w46EkXupHdCD/dL4StXDBiLqIdxdCCz1C4s/K2Bpd49CotUjyo1UZGA7K
aWd75IK59f/EeEHxwHn7OPMHlWj1KzFM2UP38WKdvfvoeu567k9geiFAmXKx3Cnf
EehS4NRXky8kb8Zd1w+WJ5TYHNXnig==
=2y6E
-----END PGP SIGNATURE-----

--56DxiVbp0XDgMBuo3Rj0Xk1Q5FecGi723--
