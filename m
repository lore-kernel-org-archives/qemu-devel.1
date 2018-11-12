Received: from eggs.gnu.org ([2001:4830:134:3::10]:51752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gME1E-0007aL-Cx
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:20:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gME1D-0003j6-H3
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:20:52 -0500
References: <cover.1541595424.git.berto@igalia.com>
	<d213fb4eb326353eccde0ea1c5a05bba2da706e0.1541595424.git.berto@igalia.com>
	<62cb7e48-9120-ace4-cd84-f462b3100251@redhat.com>
	<w51muqebni4.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8eb55cde-fdd9-70be-0edd-e414da5f0a22@redhat.com>
Date: Mon, 12 Nov 2018 16:20:16 +0100
MIME-Version: 1.0
In-Reply-To: <w51muqebni4.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MXUBrXffaWxUSNAlgqO4h5qo3HbAM1xFk"
Subject: Re: [Qemu-devel] [PATCH v4 14/15] block: Remove assertions from
 update_flags_from_options()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MXUBrXffaWxUSNAlgqO4h5qo3HbAM1xFk
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <8eb55cde-fdd9-70be-0edd-e414da5f0a22@redhat.com>
Subject: Re: [PATCH v4 14/15] block: Remove assertions from
 update_flags_from_options()
References: <cover.1541595424.git.berto@igalia.com>
 <d213fb4eb326353eccde0ea1c5a05bba2da706e0.1541595424.git.berto@igalia.com>
 <62cb7e48-9120-ace4-cd84-f462b3100251@redhat.com>
 <w51muqebni4.fsf@maestria.local.igalia.com>
In-Reply-To: <w51muqebni4.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.11.18 11:26, Alberto Garcia wrote:
> On Sun 11 Nov 2018 10:01:05 PM CET, Max Reitz wrote:
>> On 07.11.18 13:59, Alberto Garcia wrote:
>>> This function takes three options (cache.direct, cache.no-flush and
>>> read-only) from a QemuOpts object and updates the flags accordingly.
>>
>> and auto-read-only now
>=20
> Oops, will update.
>=20
>> Hm, seems like one way to solve it and I can't really find issue with
>> it.  So, let's first give a
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>> However, I wonder why you dropped your patch from v1 for this.  It
>> seemed more reasonable to me.  You're basically trading half-updating
>> the flags for just not touching them at all (and the latter seems
>> better, even though it's all an error in the end anyway).
>=20
> The main reason why I'm doing this is because if we keep the assertions=

> then we're forced to have these four options always set, and I don't se=
e
> any reason why they would need to be.
>=20
> It's not a problem now but it will be later on. Have a look at this
> early implementation of qmp_x_blockdev_reopen():
>=20
>    https://lists.gnu.org/archive/html/qemu-block/2018-06/msg00795.html
>=20
> Here we need to explicitly set those options to false if they're
> unset. 'false' is already the default value of all of them, so this
> shouldn't be necessary, but if we don't do it we'd hit the assertions
> that I'm removing in this patch.

OK, that makes sense.

Max


--MXUBrXffaWxUSNAlgqO4h5qo3HbAM1xFk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvpmjAACgkQ9AfbAGHV
z0CdPwf/feiGmO8KpgcWGKQcB8USsGP9LcSc+DaBCGEqpBrb4SizQkVDunhLwioJ
3D8OfV/fnQH69O3gp1y51MOHAwdCmXutYzZa8mE1Do0B6YomTPBK/paLjxUSgYpo
7IO+3ZWc/vbTUbTxDkByViI6zGVzBnXvmJOqv7uZ4w2uCCYONlI32r8L7uvTmBla
Cn4ifUlFc0jGJ0myRQBGHr4hJpsgeUroOCFUKISs5XercaioiqDR/HBktq9g5j/h
cBgELDK7z0R+7mv3QjTKMdLNiUBsIli8a8fnglX3R8m2kHZLCstliXqIGK3NEk2M
jTGv96CrKtm4eHwMk3CSvOLrIy2iWw==
=0zkc
-----END PGP SIGNATURE-----

--MXUBrXffaWxUSNAlgqO4h5qo3HbAM1xFk--
