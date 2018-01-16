Received: from eggs.gnu.org ([2001:4830:134:3::10]:43601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebY79-0004eR-Ah
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebY78-0003i1-GQ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:45:47 -0500
References: <1516107870-8110-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516107870-8110-10-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <55baeb92-f476-20de-0bec-cb8bf42e2155@redhat.com>
Date: Tue, 16 Jan 2018 14:45:32 -0600
MIME-Version: 1.0
In-Reply-To: <1516107870-8110-10-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ZgVxw9CWT61xgebtQN50obdGGs2AfDRAR"
Subject: Re: [Qemu-devel] [PATCH v6 9/9] iotest 134: test cluster-misaligned
 encrypted write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, den@virtuozzo.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZgVxw9CWT61xgebtQN50obdGGs2AfDRAR
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 den@virtuozzo.com, berto@igalia.com
Message-ID: <55baeb92-f476-20de-0bec-cb8bf42e2155@redhat.com>
Subject: Re: [PATCH v6 9/9] iotest 134: test cluster-misaligned encrypted
 write
References: <1516107870-8110-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516107870-8110-10-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1516107870-8110-10-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2018 07:04 AM, Anton Nefedov wrote:
> COW (even empty/zero) areas require encryption too
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  tests/qemu-iotests/134     |  9 +++++++++
>  tests/qemu-iotests/134.out | 10 ++++++++++
>  2 files changed, 19 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ZgVxw9CWT61xgebtQN50obdGGs2AfDRAR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeZGwACgkQp6FrSiUn
Q2rz+gf/dDeF+FmWb3G/xssIzwEBdB8YpMCo5mm4ssGDJ6kYEXJcqVNuI0FgHUoQ
UV1EVhzU4H6gCBGjkbXzKTz1bE5ZfSdWqBBEBVf769phIeXdRBw/eBxmq0tc/Yyz
datHar+GLWUH2pZIxm07EMjg9VBl1M6z7UHbV5h/74ssDWQ/ESLZy+hjrTh6CisK
bKXWMHAPY86tmR5tqqCSXn2QxmpU+cMqzVTjlMgPhl+/ZLtBWo8Hsb5Y5vz439jn
Xc1kWa/h+6uY4ByfN30RlmJeCwYzcV3Niljz3MAYIpo+CZ6Ea/Fzs7DOlISIjG8T
P1eYV07a6eRo7Fj+BuX1eDSS/8zxlg==
=tQfX
-----END PGP SIGNATURE-----

--ZgVxw9CWT61xgebtQN50obdGGs2AfDRAR--
