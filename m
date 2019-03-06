Received: from eggs.gnu.org ([209.51.188.92]:57807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1WEH-0001pd-U8
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:05:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1WEG-00021H-TV
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:05:01 -0500
References: <20190305182908.13557-1-eblake@redhat.com>
	<w51imww5f5f.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9128e864-46d9-66d9-dc86-def77d09bae3@redhat.com>
Date: Wed, 6 Mar 2019 07:04:44 -0600
MIME-Version: 1.0
In-Reply-To: <w51imww5f5f.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="y4jiUUQ7miQqebtBMy4YxxiLN5Mp7jbZX"
Subject: Re: [Qemu-devel] [PATCH] iotests: Wait for qemu to end in 223
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--y4jiUUQ7miQqebtBMy4YxxiLN5Mp7jbZX
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <9128e864-46d9-66d9-dc86-def77d09bae3@redhat.com>
Subject: Re: [PATCH] iotests: Wait for qemu to end in 223
References: <20190305182908.13557-1-eblake@redhat.com>
 <w51imww5f5f.fsf@maestria.local.igalia.com>
In-Reply-To: <w51imww5f5f.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/6/19 7:03 AM, Alberto Garcia wrote:
> On Tue 05 Mar 2019 07:29:08 PM CET, Eric Blake wrote:
>> When iotest 223 was first written, it didn't matter if we waited for
>> the qemu process to clean up. But with the introduction of a later
>> qemu-nbd process trying to reuse the same file, there is a race where
>> even though the asynchronous qemu process has responded to "quit", it
>> has not yet had time to unlock the file and exit, resulting in:
>>
>> -[{ "start": 0, "length": 65536, "depth": 0, "zero": false, "data": fa=
lse},
>> -{ "start": 65536, "length": 2031616, "depth": 0, "zero": false, "data=
": true},
>> -{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "da=
ta": false}]
>> +qemu-nbd: Failed to blk_new_open 'tests/qemu-iotests/scratch/t.qcow2'=
: Failed to get shared "write" lock
>> +Is another process using the image [tests/qemu-iotests/scratch/t.qcow=
2]?
>> +qemu-img: Could not open 'driver=3Dnbd,server.type=3Dunix,server.path=
=3Dtests/qemu-iotests/scratch/qemu-nbd.sock,x-dirty-bitmap=3Dqemu:dirty-b=
itmap:b': Failed to connect socket tests/qemu-iotests/scratch/qemu-nbd.so=
ck: Connection refused
>> +./common.nbd: line 33: kill: (11122) - No such process
>>
>> Fixes: ddd09448
>> Reported-by: Alberto Garcia <berto@igalia.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Tested-by: Alberto Garcia <berto@igalia.com>

Thanks; will queue through my NBD tree this week.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--y4jiUUQ7miQqebtBMy4YxxiLN5Mp7jbZX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlx/xWwACgkQp6FrSiUn
Q2qqJwf9FtZKiDYKr0j8HE1GgrspkoT4dlWqSiduiwJCuvkP9mTaD6qj93khapnR
Z9Oy5T+5ME3i7zr3bsPh3ELs6j2a2lqUwVHZgaFDIK+jxjqR8iVkBr3iT/++6nh4
uRvUgJR/Wnhq3QraTEvYZng56BXP/ugyshFB8lR9BJ3+M3tRRs4VM1q13uXuZTJY
KY1raRiUiB6L8WniTNEeJBLKn+iUpOCZwbsI3pkzs/hZOu/m+ln6UvQJiKzcQb9t
dl3mTo+pRzkaeiLhIzuVC4dAS7HhrQmEEJz/3M3dY2i1jPrWCei89TRKabwilb3K
HY0TaKA5yPOKPUP6aOvxuU38gz4Vcg==
=jtdo
-----END PGP SIGNATURE-----

--y4jiUUQ7miQqebtBMy4YxxiLN5Mp7jbZX--
