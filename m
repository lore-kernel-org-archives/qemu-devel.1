Received: from eggs.gnu.org ([2001:4830:134:3::10]:44648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEO1I-0006lH-B5
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:15:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEO1H-0003IZ-Av
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:15:28 -0500
References: <20161202192223.15153-1-eblake@redhat.com>
	<20161202192223.15153-4-eblake@redhat.com>
	<26985621-a5f8-7bcb-99b0-8365e5b574fb@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2aa8a4b4-01d2-161e-1df3-8ece61dea502@redhat.com>
Date: Tue, 6 Dec 2016 16:15:16 -0600
MIME-Version: 1.0
In-Reply-To: <26985621-a5f8-7bcb-99b0-8365e5b574fb@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ouE8P0oKngDAqElDgqwkb5v6jasbkLAVV"
Subject: Re: [Qemu-devel] [PATCH v3 3/5] blkdebug: Simplify override logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ouE8P0oKngDAqElDgqwkb5v6jasbkLAVV
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <2aa8a4b4-01d2-161e-1df3-8ece61dea502@redhat.com>
Subject: Re: [PATCH v3 3/5] blkdebug: Simplify override logic
References: <20161202192223.15153-1-eblake@redhat.com>
 <20161202192223.15153-4-eblake@redhat.com>
 <26985621-a5f8-7bcb-99b0-8365e5b574fb@redhat.com>
In-Reply-To: <26985621-a5f8-7bcb-99b0-8365e5b574fb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2016 04:10 PM, Max Reitz wrote:
> On 02.12.2016 20:22, Eric Blake wrote:
>> Rather than store into a local variable, the copy to the struct
>> if the value is valid, then reporting errors otherwise,
>=20
> It is rather difficult to part this sentence starting from "the copy".

That's because I meant to type "then copy".  (What a difference an 'n'
makes - I hope it does't imply that the batteries i my wireless keyboard
are o the declie agai, or a sig of ay other more serious problem)

>=20
>>                                                         it is
>> simpler to just store into the struct and report errors if the
>> value is invalid.  This however requires that the struct store
>> a 64-bit number, rather than a narrower type.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> v3: new patch
>> ---
>>  block/blkdebug.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> Anyway, thanks! If you can explain to me how to parse the commit messag=
e
> or make it easier to read:
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ouE8P0oKngDAqElDgqwkb5v6jasbkLAVV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRzh0AAoJEKeha0olJ0NqNLgIAJFx5lew8ZrN3dJLzf5sgSd1
4Zke+OJyRd19qCEfXacW0hzf/aNu7Z+KhDaIivG6GHl7D45GRTR1/4ZO40H7yLWD
ZSQdSMZHYzWG8vEGxgkAis7Oz9Xpt/m1nusfReTHqc16eQwpsjvehY6Zl+klPCkH
qqrWMU/+vsS5W0jLUjopjD1XCRfTlYg0E4C28n1OYGLu6AWg36mJBHrNZRLgjQNt
P+3toIbNZkmqUW+mTm9hwWOXoZHWurDZHFEV7LwczvLHV0/EAmp+aTH8nF1895qz
u67JP1PsJqWF7llIY+p3Ah2+qu/s0J30muAndEE6+o0W/8iaoL+XIrcrTjBS+9s=
=b/Su
-----END PGP SIGNATURE-----

--ouE8P0oKngDAqElDgqwkb5v6jasbkLAVV--
