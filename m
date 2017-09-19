Received: from eggs.gnu.org ([2001:4830:134:3::10]:55736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duIq2-0007F7-Tu
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duIpw-0003Ip-W2
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:45:22 -0400
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
	<20170918135935.255591-8-vsementsov@virtuozzo.com>
	<0f9ffc3d-02e1-fde8-67ac-0f62101f1204@redhat.com>
	<17fdbc1d-05db-ee91-6b13-cac9d3719c21@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5b4fc170-c315-0e86-443f-bd511a0dba84@redhat.com>
Date: Tue, 19 Sep 2017 08:45:06 -0500
MIME-Version: 1.0
In-Reply-To: <17fdbc1d-05db-ee91-6b13-cac9d3719c21@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RpLm07la3r0P4GKvqCckEg6Gt04P5LOrt"
Subject: Re: [Qemu-devel] [PATCH v2 7/7] block/nbd-client: do not yield from
 nbd_read_reply_entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RpLm07la3r0P4GKvqCckEg6Gt04P5LOrt
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <5b4fc170-c315-0e86-443f-bd511a0dba84@redhat.com>
Subject: Re: [PATCH v2 7/7] block/nbd-client: do not yield from
 nbd_read_reply_entry
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
 <20170918135935.255591-8-vsementsov@virtuozzo.com>
 <0f9ffc3d-02e1-fde8-67ac-0f62101f1204@redhat.com>
 <17fdbc1d-05db-ee91-6b13-cac9d3719c21@virtuozzo.com>
In-Reply-To: <17fdbc1d-05db-ee91-6b13-cac9d3719c21@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2017 05:00 AM, Vladimir Sementsov-Ogievskiy wrote:
> 19.09.2017 01:36, Eric Blake wrote:
>> On 09/18/2017 08:59 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Refactor nbd client to not yield from nbd_read_reply_entry. It's
>>> possible now as all reading is done in nbd_read_reply_entry and
>>> all request-related data is stored in per-request s->requests[i].
>>>
>>> We need here some additional work with s->requests[i].ret and
>>> s->quit to not fail requests on normal disconnet and to not report
>>> reading errors on normal disconnect.
>>>

>>> @@ -364,6 +353,8 @@ void nbd_client_close(BlockDriverState *bs)
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbd_send_request(client->ioc, &=
request);
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 client->quit =3D true;
>> Previously, client->quit was only set when detecting a broken server,
>> now it is also set for a clean exit.=C2=A0 Do we need to change any
>> documentation of the field?
>=20
> It has documentation?

Touche.  But it probably should, especially if we are changing its
semantics, to make it easier to understand from looking at the struct
what semantics to expect.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--RpLm07la3r0P4GKvqCckEg6Gt04P5LOrt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnBH2IACgkQp6FrSiUn
Q2oYtgf/S+AqnlCZDihO3ox9i+tHmvDQbZGPtEvj7tYrgHXOBz+w19ruAsShT3QB
GuVQ9OcY8cQ1SpZL8p0Xp+MTRFQRq9Vnjfk1FKhkU0A1RJiS5DO78pGuf8HBJW7R
Et7cfnJWHjFoTUuG2Oq2J9mB8hlFtc2IWdHF9+VS9E6fxlGRGbVa/mm8NKQWNvKH
qJds1//hT90Bfu5sivDDyxj4Jge4uYa/bM3xtdLZUowN4N0SR8blEmevRCFBQB+G
42ii03SqbNcKi2WeQO7nah0nV7w/V5wgeJbfsu4rX+VlW/ZKJKFWXjGwYI4tEQqN
DdYvfwd5SuJ/7cRQs6+dVhf8AuapEw==
=NEqu
-----END PGP SIGNATURE-----

--RpLm07la3r0P4GKvqCckEg6Gt04P5LOrt--
