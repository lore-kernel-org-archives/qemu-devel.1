Received: from eggs.gnu.org ([2001:4830:134:3::10]:36020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e44Lb-0003X2-Fy
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e44La-0002bN-ED
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:18:19 -0400
References: <20171015010131.12172-1-eblake@redhat.com>
	<20171015010131.12172-5-eblake@redhat.com>
	<b96907fe-1b3d-8ab9-c4ab-761fe48f26aa@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5ec13265-60d3-aeb6-641b-9aaebfbe498e@redhat.com>
Date: Mon, 16 Oct 2017 07:18:01 -0500
MIME-Version: 1.0
In-Reply-To: <b96907fe-1b3d-8ab9-c4ab-761fe48f26aa@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CpVvDNdK1MbK0jKNQIrGfOjhj3LQhBBi4"
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
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CpVvDNdK1MbK0jKNQIrGfOjhj3LQhBBi4
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5ec13265-60d3-aeb6-641b-9aaebfbe498e@redhat.com>
Subject: Re: [PATCH v4 4/8] nbd: Minimal structured read for server
References: <20171015010131.12172-1-eblake@redhat.com>
 <20171015010131.12172-5-eblake@redhat.com>
 <b96907fe-1b3d-8ab9-c4ab-761fe48f26aa@virtuozzo.com>
In-Reply-To: <b96907fe-1b3d-8ab9-c4ab-761fe48f26aa@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/16/2017 04:49 AM, Vladimir Sementsov-Ogievskiy wrote:
> 15.10.2017 04:01, Eric Blake wrote:
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Minimal implementation of structured read: one structured reply chunk,=

>> no segmentation.
>> Minimal structured error implementation: no text message.
>> Support DF flag, but just ignore it, as there is no segmentation any
>> way.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ca=
se NBD_OPT_STRUCTURED_REPLY:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (client->structured_reply) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_negotiate_send_=
rep_err(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cli=
ent->ioc, NBD_REP_ERR_INVALID, option, errp,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "st=
ructured reply already negotiated");
>=20
> You were going to send a patch to spec for this..

Still am; it's on my queue for tasks to do today. :)

>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_negotiate_send_=
rep(client->ioc,
>> NBD_REP_ACK,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opt=
ion, errp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 client->structured_reply =3D true;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 myflags |=3D NBD_CMD_FLAG_DF;
>=20
> it should be NBD_FLAG_SEND_DF

Ouch, you're right.  NBD_CMD_FLAG_DF has the same value as
NBD_FLAG_SEND_FLUSH (which we always advertise).  If nothing else, you
proved that my weekend hacking was shoved out the door quickly, rather
than fully tested.  :)

>=20
> [...]
>=20
> the following looks ok.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CpVvDNdK1MbK0jKNQIrGfOjhj3LQhBBi4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnko3oACgkQp6FrSiUn
Q2r1kgf+Pc01IMgMsQ/ewhfdRZc6gCNBjcDItc7ULmxmcbaTRjPGm9axcY6Lbvfc
xqRvHzJqD+lsOhqNqUIfOe4gDlKdBNTcOGKmJNltcJ5jZf/ErXivQk2wu8ufBlIa
+n059RheRigsTW9ILcE89wY5B6MD05YBrHHS1HJF8ofI4EvtlGGRXzBDEkx8EJF1
1mO8k8vlkws3EMBVRLtI7XYi9+5+MwRB9B/WniSZa1C9+9QYsZugDBut+UKIJZEv
NdWd4ZCl9G3cdxlWia4YSoRtQhW8BlvLx/YWh1QUVkYNnHeSOGg3nJkMv0c9gplB
00yJCK4U4m2KUDcKCkgz+b3zd/PJfw==
=yQsW
-----END PGP SIGNATURE-----

--CpVvDNdK1MbK0jKNQIrGfOjhj3LQhBBi4--
