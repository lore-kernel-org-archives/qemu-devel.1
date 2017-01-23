Received: from eggs.gnu.org ([2001:4830:134:3::10]:60434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cVgoM-0005J4-PJ
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cVgoJ-00026W-L7
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:45:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cVgoJ-00026R-9P
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:45:35 -0500
References: <1485180414-11601-1-git-send-email-pradeep.jagadeesh@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <62cb8baf-bed7-84d2-c3f2-89b448829a09@redhat.com>
Date: Mon, 23 Jan 2017 09:45:30 -0600
MIME-Version: 1.0
In-Reply-To: <1485180414-11601-1-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="poTlWsukg8OQDVXMvDvM6NPoeXOI3Hq2a"
Subject: Re: [Qemu-devel] [PATCH V13] throttle: removed duplicate throtlle
 code from block and fsdev files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Greg Kurz <groug@kaod.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--poTlWsukg8OQDVXMvDvM6NPoeXOI3Hq2a
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Greg Kurz <groug@kaod.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Alberto Garcia <berto@igalia.com>,
 Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org
Message-ID: <62cb8baf-bed7-84d2-c3f2-89b448829a09@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V13] throttle: removed duplicate throtlle
 code from block and fsdev files
References: <1485180414-11601-1-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1485180414-11601-1-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/23/2017 08:06 AM, Pradeep Jagadeesh wrote:

Subject line is long and misspelled; I suggest:

throttle: factor out duplicate code

> This removes the redundant throttle code that was present in
> block and fsdev device files. Now the common code is moved
> to a single file.
>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> ---

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--poTlWsukg8OQDVXMvDvM6NPoeXOI3Hq2a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYhiUaAAoJEKeha0olJ0NqsfgH/3fiO9O4b/ysllhPe3P83RC9
4ZZJy4Sm3cmoETwKaweW6w0DDbz5Mt60vvOkR7n19YE2tjP3Z/g1e+4+6R2L2mXb
Wh6XqBoZZLCZA1t28O+BjSadKuT32i7G82fDFoHdcahsKIfElLlFz5L9OVgls6zE
I8ALSn6HqRyUO1ygHGzmhR1Y5BeaIKzJgRI1/O7V6/zgOfkVASVm6ounm7nRZ75l
MOiHms6qb7+bHR/C8Qs7z4n+88PMG43CL8ZMLoLxqHjbbMb521wveBausYBGno8h
3JcWDaSIOAxbwcxEE0e0uMxnXour15V3NPzFiBy5JVACMMWbPzK448TeiprQobs=
=rglc
-----END PGP SIGNATURE-----

--poTlWsukg8OQDVXMvDvM6NPoeXOI3Hq2a--
