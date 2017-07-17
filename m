Received: from eggs.gnu.org ([2001:4830:134:3::10]:60834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX4Ov-0006tg-D5
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX4Ou-0002Be-9L
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:41:21 -0400
References: <20170707203049.534-1-eblake@redhat.com>
	<20170707203049.534-8-eblake@redhat.com>
	<20170717083110.GA5301@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <922ec9d2-383d-c673-a667-dcc2ca2f61fd@redhat.com>
Date: Mon, 17 Jul 2017 06:41:09 -0500
MIME-Version: 1.0
In-Reply-To: <20170717083110.GA5301@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iAvPIJaCpui3MedgOwdRpmC3aoS0hrRUs"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 7/9] nbd: Implement
 NBD_OPT_GO on client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-block@nongnu.org, marcandre.lureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iAvPIJaCpui3MedgOwdRpmC3aoS0hrRUs
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, vsementsov@virtuozzo.com,
 den@virtuozzo.com, qemu-block@nongnu.org, marcandre.lureau@redhat.com
Message-ID: <922ec9d2-383d-c673-a667-dcc2ca2f61fd@redhat.com>
Subject: Re: [Qemu-block] [PATCH v5 7/9] nbd: Implement NBD_OPT_GO on client
References: <20170707203049.534-1-eblake@redhat.com>
 <20170707203049.534-8-eblake@redhat.com>
 <20170717083110.GA5301@noname.redhat.com>
In-Reply-To: <20170717083110.GA5301@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 03:31 AM, Kevin Wolf wrote:
> Am 07.07.2017 um 22:30 hat Eric Blake geschrieben:
>> NBD_OPT_EXPORT_NAME is lousy: per the NBD protocol, any failure
>> requires the server to close the connection rather than report an
>> error to us.  Therefore, upstream NBD recently added NBD_OPT_GO as
>> the improved version of the option that does what we want [1]: it
>> reports sane errors on failures, and on success provides at least
>> as much info as NBD_OPT_EXPORT_NAME.
>>

>=20
> This breaks qemu-iotests 140 and 143:

Urrgh, and I even ran into it locally last week after posting my v1, and
had it on my list to fix before posting v2, when Paolo committed my v1
to make softfreeze before going on PTO this week. I will post the fix
later today (I already have a couple other NBD patches pending, so my
plan is to submit a PULL request by the end of my day with all of the
fixes).

>=20
> -can't open device nbd+unix:///drv?socket=3DTEST_DIR/nbd: No export wit=
h name 'drv' available
> +can't open device nbd+unix:///drv?socket=3DTEST_DIR/nbd: Requested exp=
ort not available for option 7 (go)
> +export 'drv' not present
>=20
> We could just update the reference output, but I actually believe the
> old error message was better.

One line is indeed better than two; I'm still playing with the easiest
way to get the desired output.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--iAvPIJaCpui3MedgOwdRpmC3aoS0hrRUs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZbKJVAAoJEKeha0olJ0NqJDcH/Ake6gIRZzHBxRu7MK8/P1Ma
4IbP7DZjyIOsm1YsJuNzLxmKZZgnGS+zVOE8C1Ku66Hzx+kCEywUXHrDkL2A4l8F
JFcyWLqA8fy6RPRkSunGDwG7dEnT/NSWTtvvPs3kRU8YJ9vwd24v1wOcbcWAiQM3
puvg6ZnHgXhEphbl5WaV9RYs3dAiaC9RjpbaagOMfLBHvNp9LGKKIfFL1CNQUjbr
1S9c0blRj3rPxsTg1q6LZk2TLQiD2Fnxut6TLPzPJeXljVnSjrhNopa0G9aHIXls
duz6zOpcW4mbXvTWZuL1N+2xN8abNykVUcbel6vDfSod1ywHrh3onLFKdxrJF2o=
=OS0f
-----END PGP SIGNATURE-----

--iAvPIJaCpui3MedgOwdRpmC3aoS0hrRUs--
