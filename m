Received: from eggs.gnu.org ([2001:4830:134:3::10]:51416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS683-0006OY-J5
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 14:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS682-0004dr-Lk
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 14:31:23 -0400
References: <20170629184320.7151-1-el13635@mail.ntua.gr>
	<20170629184320.7151-4-el13635@mail.ntua.gr>
	<69eaa5de-6e3c-d520-cdc6-35a6298aee94@redhat.com>
	<a3c3ad15-ae75-4eae-f74e-72da4e96d980@redhat.com>
	<20170703182427.ltj6bbezc3udfiq3@postretch>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9a57d938-0fc6-da74-1b02-0b9ab1667415@redhat.com>
Date: Mon, 3 Jul 2017 13:31:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170703182427.ltj6bbezc3udfiq3@postretch>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VCRasqnGN3LSk2Ji864bmc9xSO5003RSU"
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
--VCRasqnGN3LSk2Ji864bmc9xSO5003RSU
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <9a57d938-0fc6-da74-1b02-0b9ab1667415@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] block: add default implementations
 for bdrv_co_get_block_status()
References: <20170629184320.7151-1-el13635@mail.ntua.gr>
 <20170629184320.7151-4-el13635@mail.ntua.gr>
 <69eaa5de-6e3c-d520-cdc6-35a6298aee94@redhat.com>
 <a3c3ad15-ae75-4eae-f74e-72da4e96d980@redhat.com>
 <20170703182427.ltj6bbezc3udfiq3@postretch>
In-Reply-To: <20170703182427.ltj6bbezc3udfiq3@postretch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/03/2017 01:24 PM, Manos Pitsidianakis wrote:

>> In fact, my rebase fallout is to completely delete
>> bdrv_co_get_block_status_from_file().  Why? Because blkdebug is the on=
ly
>> client, but I want to enhance blkdebug to add in-place assert()ions th=
at
>> the values passed by the block layer are properly aligned to
>> bs->bl.request_alignment (matching what blkdebug does for read and wri=
te
>> - after all, if a device cannot access smaller than a given alignment
>> for a read, it should not be able to report different statuses half-wa=
y
>> through that granularity).  However, in-place assertions are no longer=

>> generic, so we no longer have a client of a generic helper function
>> referring to bs->file.
>>
>> Which means you are REALLY left only with commit and mirror as the two=

>> functions that have a common implementation of pointing back to backin=
g.
>=20
>=20
> Hello Eric, thanks for taking the time to review my patches.
>=20
> The throttle driver I'm working on passes bdrv_co_get_block_status() to=

> bs->file. If there is a problem with an unused default function (it's
> not static so will compile, but it might not be up to standard), you ca=
n
> just remove it and I will reintroduce it when it's needed. CC me on
> those patches when you send them if you can.

Sure. The other thing I can do is have:

blkdebug_version() {
   assert(...);
   return common version;
}

so that the common version is still there for use by the throttling
code.  I'm adjusting my rebase accordingly, now that I know you have
another intended use in mind.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VCRasqnGN3LSk2Ji864bmc9xSO5003RSU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZWo1qAAoJEKeha0olJ0NqhB0H/R4hcbZ98jDdxcGcSoj0H5Cw
10QElxmc4AOQ9+s/myk+S3qMtYDOloId7q58DVT4dYrSUWPSdtQdfO7DecQdGWxX
viB5kDiXYKuZI0q1gKkvl7OKS0dH93ePXdEzx9iilAyleYoqgTJBDolTDxR7OEMQ
iWiSljtVzyPzUUCiJkILx9tm1aUbDPnVDjyJi8OqCtwnzt0PMI8fiKqbzyvlIl+m
fOU43v/cH6bZN9yxs1HTJ7asf8iEky/t0YIPFwUDyw45lt36/NmjWdFZDgPh0xY7
I4eILUHlSrNspV5w7SLmMAGN2yPukgyPwS4vUUr51/BG2VzahlAZH982nxlsBiQ=
=t7ps
-----END PGP SIGNATURE-----

--VCRasqnGN3LSk2Ji864bmc9xSO5003RSU--
