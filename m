Received: from eggs.gnu.org ([209.51.188.92]:42692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1guhSH-0003jY-8Y
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1guhSG-0001mF-HT
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:39:17 -0500
References: <20190213225311.17876-1-mreitz@redhat.com>
	<20190213225311.17876-2-mreitz@redhat.com>
	<41419065-2609-cec2-d518-4fb9d08dc811@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1c9650be-956c-4994-9b88-2c25a0752e96@redhat.com>
Date: Fri, 15 Feb 2019 18:38:58 +0100
MIME-Version: 1.0
In-Reply-To: <41419065-2609-cec2-d518-4fb9d08dc811@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eUjSkZc4klqEj6cqpb0O0dlikTwzZHFCM"
Subject: Re: [Qemu-devel] [PATCH v3 01/12] block: Mark commit and mirror as
 filter drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eUjSkZc4klqEj6cqpb0O0dlikTwzZHFCM
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <1c9650be-956c-4994-9b88-2c25a0752e96@redhat.com>
Subject: Re: [PATCH v3 01/12] block: Mark commit and mirror as filter drivers
References: <20190213225311.17876-1-mreitz@redhat.com>
 <20190213225311.17876-2-mreitz@redhat.com>
 <41419065-2609-cec2-d518-4fb9d08dc811@redhat.com>
In-Reply-To: <41419065-2609-cec2-d518-4fb9d08dc811@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.02.19 00:24, Eric Blake wrote:
> On 2/13/19 4:53 PM, Max Reitz wrote:
>> The commit and mirror block nodes are filters, so they should be marke=
d
>> as such.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>> ---
>>  block/commit.c | 2 ++
>>  block/mirror.c | 2 ++
>>  2 files changed, 4 insertions(+)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> I know there are patches pending review for a backup driver (for image
> fleecing and otherwise), have you checked if that series would need
> similar treatment?

Good point; it is indeed marked as a filter driver from the start, so
we're good there.

Max


--eUjSkZc4klqEj6cqpb0O0dlikTwzZHFCM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxm+TIACgkQ9AfbAGHV
z0DSoAf9HDrP8L8zuYIO494YN7kICvlr2IvqX56J9Z6FvpkcykfQwOqzWTBTOKb4
FxY8mTCXhtB+vVcBieKF9TktcDfkW6GY6qi/krOCxMKPKWJ00JA+CY2vF7KXsXVe
6jDX7nrf/s2YIjm61icVwlAEsv/3W47e74WerGxmQV9/lRGw0fI0HOJ0aAFGP7Cw
Pcmn7dOV5TL/RMWkZTBNNHTZbeKFZiupGOdFSnnBA9+ipNxrQ+qqc1xzjVNWijqE
co9lcKc4uxWqc7p4Di++HhfA0yRt6kw4UN7IZMgihzYzLsI2qeobwv6+bIZaufIm
g8eY4Revaiv2xvrD3Fci5fVLuYElyw==
=3GbT
-----END PGP SIGNATURE-----

--eUjSkZc4klqEj6cqpb0O0dlikTwzZHFCM--
