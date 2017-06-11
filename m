Received: from eggs.gnu.org ([2001:4830:134:3::10]:57642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dK2AD-0002BS-KD
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 08:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dK2AC-0008Ee-QA
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 08:40:17 -0400
References: <20170609152017.7286-1-eblake@redhat.com>
	<20170609152017.7286-3-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e70e065e-cd44-8ba4-d3d4-e3424bf55d5c@redhat.com>
Date: Sun, 11 Jun 2017 14:40:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170609152017.7286-3-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="R5ohwfxQExukK9Sshh6t8MWwqdlfpvpE8"
Subject: Re: [Qemu-devel] [PATCH 2/2] qobject: Catch another straggler for
 use of qdict_put_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, marcandre.lureau@redhat.com, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R5ohwfxQExukK9Sshh6t8MWwqdlfpvpE8
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, marcandre.lureau@redhat.com, qemu-trivial@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Message-ID: <e70e065e-cd44-8ba4-d3d4-e3424bf55d5c@redhat.com>
Subject: Re: [PATCH 2/2] qobject: Catch another straggler for use of
 qdict_put_str()
References: <20170609152017.7286-1-eblake@redhat.com>
 <20170609152017.7286-3-eblake@redhat.com>
In-Reply-To: <20170609152017.7286-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-09 17:20, Eric Blake wrote:
> Dan's addition of key-secret improvements in commit 29cf9336 was
> developed prior to the addition of QDict scalar insertion macros,
> but merged after the general cleanup in commit 46f5ac20.
> Patch created mechanically by rerunning:
>   spatch --sp-file scripts/coccinelle/qobject.cocci \
>          --macro-file scripts/cocci-macro-file.h --dir . --in-place
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qemu-img.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--R5ohwfxQExukK9Sshh6t8MWwqdlfpvpE8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZPTolEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQGbj
B/97WnEnmhZDvhj4S/8+nYnjUrTdqHlu6RazuXknrwwUkMmkP+o3DoxRvEbFd+OZ
CHC2kszL7xGK7sdIKnJrACvJCsg/uc7E1NSeJLEyz0clv3nzljG7Gj8uMoE8j2f9
7bsYVaHSC2SpFVB+G5JefRiwYE7YLuf20gNa+Yn1icetaTUlm9oUiPW00QR7UM6w
zIU6fNTp217UVBXgRuPkLaWJw7Y3aXl5usi4ndZMdwuDXcvvpfqU67ukcv84Jkgl
+XAVcNDRlo5OzIq26vvCblXiOKAN3Jq0zq58Rf6j7/AljyZUba7Z9n8ROiwAttB6
4HoSOxDzjKzHrRBhDkiuLgdz
=3mjw
-----END PGP SIGNATURE-----

--R5ohwfxQExukK9Sshh6t8MWwqdlfpvpE8--
