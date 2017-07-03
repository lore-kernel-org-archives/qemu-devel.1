Received: from eggs.gnu.org ([2001:4830:134:3::10]:57951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9jn-0005Qt-QV
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:22:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9jm-0003KW-S4
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:22:35 -0400
References: <20170629184320.7151-1-el13635@mail.ntua.gr>
	<20170629184320.7151-4-el13635@mail.ntua.gr>
	<69eaa5de-6e3c-d520-cdc6-35a6298aee94@redhat.com>
	<a3c3ad15-ae75-4eae-f74e-72da4e96d980@redhat.com>
	<20170703182427.ltj6bbezc3udfiq3@postretch>
	<9a57d938-0fc6-da74-1b02-0b9ab1667415@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7770218c-d136-5ef1-f0e8-952938ffa94b@redhat.com>
Date: Mon, 3 Jul 2017 17:22:25 -0500
MIME-Version: 1.0
In-Reply-To: <9a57d938-0fc6-da74-1b02-0b9ab1667415@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eQJEP5pbL4K23OfGxKVjoGDa2GlAtIGwf"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] block: add default implementations
 for bdrv_co_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eQJEP5pbL4K23OfGxKVjoGDa2GlAtIGwf
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <7770218c-d136-5ef1-f0e8-952938ffa94b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] block: add default implementations
 for bdrv_co_get_block_status()
References: <20170629184320.7151-1-el13635@mail.ntua.gr>
 <20170629184320.7151-4-el13635@mail.ntua.gr>
 <69eaa5de-6e3c-d520-cdc6-35a6298aee94@redhat.com>
 <a3c3ad15-ae75-4eae-f74e-72da4e96d980@redhat.com>
 <20170703182427.ltj6bbezc3udfiq3@postretch>
 <9a57d938-0fc6-da74-1b02-0b9ab1667415@redhat.com>
In-Reply-To: <9a57d938-0fc6-da74-1b02-0b9ab1667415@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/03/2017 01:31 PM, Eric Blake wrote:
>> The throttle driver I'm working on passes bdrv_co_get_block_status() t=
o
>> bs->file. If there is a problem with an unused default function (it's
>> not static so will compile, but it might not be up to standard), you c=
an
>> just remove it and I will reintroduce it when it's needed. CC me on
>> those patches when you send them if you can.
>=20
> Sure.

Now posted:
https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00427.html

> The other thing I can do is have:
>=20
> blkdebug_version() {
>    assert(...);
>    return common version;
> }

That's the approach I went with in 14/15 of that series.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eQJEP5pbL4K23OfGxKVjoGDa2GlAtIGwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZWsOhAAoJEKeha0olJ0NquQMIAK+x63GmXM4ugBSPZZj5fyis
I4nyLzzUPacEQDdetihXkU5pLaCboLA6Ykcyla+0l8zjeHO8Z37sUiB7WeGRnsDH
3DmJTTjZOqhaqthIa18KtBYVlNwAZY1P41nKWX2aGrOfLwSNTVjPZGhhpEkTBQ8k
/RcA/0gDgSrwcamFbHybG6ObJl8a9z0tGeS9OmtPouRQ/CwlDqf7U4God0euxuxa
mEoLCDrmUOAzXpkNEWS8PCHDJZ7loUNMDvwahDYoYTsgTe11MOuHW12NUJ5l8ity
jTOsjB2pPc4/Sk4GJ63hJCmm29uV0GQO8xjkIk7svyNyRe5bWdm9TZ4tEVGkRGo=
=l5fn
-----END PGP SIGNATURE-----

--eQJEP5pbL4K23OfGxKVjoGDa2GlAtIGwf--
