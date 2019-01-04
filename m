Received: from eggsout.gnu.org ([209.51.188.92]:43863 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfZBv-00038G-VC
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 18:47:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfZBv-0005qG-6E
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 18:47:51 -0500
References: <20181215135324.152629-1-eblake@redhat.com>
	<20181215135324.152629-5-eblake@redhat.com>
	<20181215141305.GT27120@redhat.com>
	<09763ed2-ec13-c159-879a-0f081a229280@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f23060ca-7656-4b6c-3936-9bb0b2a0c3b0@redhat.com>
Date: Fri, 4 Jan 2019 17:47:41 -0600
MIME-Version: 1.0
In-Reply-To: <09763ed2-ec13-c159-879a-0f081a229280@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hAox2pnpJTSdz5Cwx3c5zlN61NiHKWbGz"
Subject: Re: [Qemu-devel] [PATCH v2 04/22] qemu-nbd: Enhance man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: nsoffer@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hAox2pnpJTSdz5Cwx3c5zlN61NiHKWbGz
From: Eric Blake <eblake@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: nsoffer@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <f23060ca-7656-4b6c-3936-9bb0b2a0c3b0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 04/22] qemu-nbd: Enhance man page
References: <20181215135324.152629-1-eblake@redhat.com>
 <20181215135324.152629-5-eblake@redhat.com>
 <20181215141305.GT27120@redhat.com>
 <09763ed2-ec13-c159-879a-0f081a229280@redhat.com>
In-Reply-To: <09763ed2-ec13-c159-879a-0f081a229280@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/17/18 9:19 AM, Eric Blake wrote:

>>
>>> +@c man begin EXAMPLES
>>> +Start a server listening on port 10809 that exposes only the
>>> +guest-visible contents of a qcow2 file, with no TLS encryption, and
>>> +with the default export name (an empty string). The command will blo=
ck
>>> +until the first successful client disconnects:
>>
>> TBH I'd always include the -t option in every example.=C2=A0 I don't
>> understand (except for backwards compatibility) why it isn't the
>> default since it's something I always trip over when using qemu-nbd.
>=20
> I'd still like one example without -t, to call out specifically that it=

> creates a one-shot server that goes away after the first client, but
> don't mind fixing the rest of the examples to use -t.
>=20
> Using -e for read-only connections makes sense, using -e for writable
> exports is a bit more questionable - we _don't_ advertise the
> NBD_FLAG_CAN_MULTI_CONN which states that caches are kept consistent
> between simultaneous write connections, although maybe we should see if=

> qemu-nbd can start promising multi-write consistency in future patches?=


And I see you've just posted patches for nbdkit to start advertising
CAN_MULTI_CONN - so I really need to spend some time figuring out when
it makes sense for qemu to advertise the flag.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--hAox2pnpJTSdz5Cwx3c5zlN61NiHKWbGz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwv8J0ACgkQ3g5py3or
ov07EAf/cYPgpRCmIcD6WYwVDgM/8bHu6nT9Ez6PurntqLePNRnQ4G4iFh6Aop35
RL2F/XAlXMFMdeu0zqj+4kI9Gnoi9ejpzZUuGv7SnsriXfltMKDFrVbTWfLlZbGT
H84VOJZNidh2B0+RKlw6LInomQHaZHWiITYv6gcEureta4o6HskfmBmLaFClAJ5w
coSS5ebj1ztQREg0u0gK+kes5lz9pI0gi0PmGl6aLolWyR+4bxzuqWG1beUujsi6
wMP8NAyLxGCp7jM5VEvkCSG9ByDrTpaganeEr3SGNhFvGY/KSwN7BvVxnYnJMU7B
EXj64zTD9FE4UOvXH6vSiN/+2/Zd8w==
=+0T1
-----END PGP SIGNATURE-----

--hAox2pnpJTSdz5Cwx3c5zlN61NiHKWbGz--
