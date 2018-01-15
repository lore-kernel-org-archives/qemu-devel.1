Received: from eggs.gnu.org ([2001:4830:134:3::10]:55987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eb6OB-0007Xm-4L
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:09:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eb6OA-00060r-41
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:09:31 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-4-vsementsov@virtuozzo.com>
	<74fa9031-25d8-df0f-0690-c03ff377c0d9@redhat.com>
	<7f7c46fe-c6e1-a597-c6d1-5212abc12212@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d338d282-f264-3d39-2240-0cd5dbf0294e@redhat.com>
Date: Mon, 15 Jan 2018 09:09:12 -0600
MIME-Version: 1.0
In-Reply-To: <7f7c46fe-c6e1-a597-c6d1-5212abc12212@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BsEWmd6qYDd8vZFyj1M3BrjXvL42NJuOy"
Subject: Re: [Qemu-devel] [PATCH v2 3/6] qapi: add nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BsEWmd6qYDd8vZFyj1M3BrjXvL42NJuOy
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
Message-ID: <d338d282-f264-3d39-2240-0cd5dbf0294e@redhat.com>
Subject: Re: [PATCH v2 3/6] qapi: add nbd-server-remove
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
 <20171207155102.66622-4-vsementsov@virtuozzo.com>
 <74fa9031-25d8-df0f-0690-c03ff377c0d9@redhat.com>
 <7f7c46fe-c6e1-a597-c6d1-5212abc12212@virtuozzo.com>
In-Reply-To: <7f7c46fe-c6e1-a597-c6d1-5212abc12212@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/12/2018 03:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> 09.01.2018 22:52, Eric Blake wrote:
>> On 12/07/2017 09:50 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Add command for export removing. It is needed for cases when we
>>> don't want to keep export after the operation on it was completed.
>>> The other example is temporary node, created with blockdev-add.
>>> If we want to delete it we should firstly remove corresponding
>>> NBD export.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---

>> Do we want a third mode in the middle, where the server starts replyin=
g
>> to all existing clients with ESHUTDOWN errors for all new requests
>> rather than abruptly disconnecting (no new I/O, but no forced disconne=
ct
>> and pending in-flight transactions can still complete gracefully)?
>=20
> looks interesting. what about the following naming?
>=20
> @mode: possible values:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 hide - just hide server from new clients, maintain
> existing connections,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 remove after all clients disconnected
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 soft - like hide, but answer with ESHUTDOWN for all
> further requests from
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 exis=
ting connections
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 hard - hard disconnect all clients and remove server
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (default: soft)

Or even a fourth mode that causes an immediate error return without
state change if there are any connected clients, but otherwise removes
the server.

>=20
> new corresponding states of nbd export:
> hidden, shutting_down
>=20
> and we allow transitions:
>=20
> normal_execution -> hidden
> normal_execution -> shutting_down
> normal_execution -> exit
> hidden -> shutting_down
> hidden -> exit
> shutting_down -> exit

Seems reasonable.  Are you planning on tackling a respin of this series
incorporating that idea?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BsEWmd6qYDd8vZFyj1M3BrjXvL42NJuOy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpcxBgACgkQp6FrSiUn
Q2ommggAhlsMqpWbzG12DabVo52V6dOIg0365myezhV04/wKN504+G7aTUnCZPrm
I2xmsthjUoRV4R6zketXRRMbu9pIcnct3TF/Ag3gEPYOfBBMhXTrhy0exJbaDb1o
WaWRbQJWonzoltCymlRWCmeY1a3piFg0OkOTHCqtCgZTDf8pjInqGeadjUrcQAcj
x9mp+o2L3cC4gV5gaxMjNWlrudvlJ8aw6/CcenJeiwJWxD/z4dF8XMSbMKnH2NVr
tnJNDOFeoHs9jtx8FckgKamvr9kXArMgyMm4y7GUrVPLXl9HeCAq1nnho9uzvVIN
S23X9fCVuc/AMjUEnjBCXbUI4CUwlQ==
=f9YH
-----END PGP SIGNATURE-----

--BsEWmd6qYDd8vZFyj1M3BrjXvL42NJuOy--
