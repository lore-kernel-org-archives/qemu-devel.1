Received: from eggs.gnu.org ([2001:4830:134:3::10]:48764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX6SW-0004VR-2A
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX6SS-0003Gc-6Q
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:53:12 -0400
References: <20170707203049.534-1-eblake@redhat.com>
	<20170707203049.534-8-eblake@redhat.com>
	<20170717083110.GA5301@noname.redhat.com>
	<922ec9d2-383d-c673-a667-dcc2ca2f61fd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9a30b584-1a53-8aa5-fd71-80fbecb1e67a@redhat.com>
Date: Mon, 17 Jul 2017 08:52:58 -0500
MIME-Version: 1.0
In-Reply-To: <922ec9d2-383d-c673-a667-dcc2ca2f61fd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u1DE74LXJQvht0rubgdsQMWgtF3LrrQQv"
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
Cc: vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u1DE74LXJQvht0rubgdsQMWgtF3LrrQQv
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com
Message-ID: <9a30b584-1a53-8aa5-fd71-80fbecb1e67a@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 7/9] nbd: Implement
 NBD_OPT_GO on client
References: <20170707203049.534-1-eblake@redhat.com>
 <20170707203049.534-8-eblake@redhat.com>
 <20170717083110.GA5301@noname.redhat.com>
 <922ec9d2-383d-c673-a667-dcc2ca2f61fd@redhat.com>
In-Reply-To: <922ec9d2-383d-c673-a667-dcc2ca2f61fd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 06:41 AM, Eric Blake wrote:

>> This breaks qemu-iotests 140 and 143:
>=20

>> -can't open device nbd+unix:///drv?socket=3DTEST_DIR/nbd: No export wi=
th name 'drv' available
>> +can't open device nbd+unix:///drv?socket=3DTEST_DIR/nbd: Requested ex=
port not available for option 7 (go)
>> +export 'drv' not present
>>
>> We could just update the reference output, but I actually believe the
>> old error message was better.
>=20
> One line is indeed better than two; I'm still playing with the easiest
> way to get the desired output.

The fact that output is two lines is because the client is now replaying
the server's error message (something that was not previously possible,
prior to NBD_OPT_GO).  Dropping that information may not hurt in this
case, but it's nice to show the server's message when one is present.
Maybe I can change this to:

can't open device nbd+unix:///drv?socket=3DTEST_DIR/nbd: Requested export=

not available
server reported: export 'drv' not present

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--u1DE74LXJQvht0rubgdsQMWgtF3LrrQQv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllswTsACgkQp6FrSiUn
Q2pF4QgAhLHWPR8JKAcULIw/8uW8gBVUk3HXlhBmBBZ7S0HlJF29SW8hOFeDiu9y
Hqz52YiHbs47mXGbZQDMT1X4+QtfpuFyxKBBJoMoLudXqay85BO+KLk4+5mlRy+u
YCeQIzRbnJm0jJnZgG6M90Ymcj/FU8IjMscMb2bqqPzNi5gYKt7S2t5qK78jesk7
XbsgjZ8obt2I0n9t3KdmeJv2k9DI7kropy6TwQf+IyKjEEKUeZ2/PpwUHLaYyCIV
bGw5uoO4pDRRnHkiGkUfzgdyApS4ACw3OcAygdyvX3PPCRFVM4LVEdPRE9qdhBve
dyVCKTlVelT1rVSxZ5mDHXMF7ORZgQ==
=AMGP
-----END PGP SIGNATURE-----

--u1DE74LXJQvht0rubgdsQMWgtF3LrrQQv--
