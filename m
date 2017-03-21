Received: from eggs.gnu.org ([2001:4830:134:3::10]:39949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqL0B-0003KX-4r
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqL06-00079e-NU
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:43:11 -0400
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
	<20170311132256.22951-4-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8a7b0c94-b274-d8c2-a551-dec86814e96c@redhat.com>
Date: Tue, 21 Mar 2017 09:43:01 -0500
MIME-Version: 1.0
In-Reply-To: <20170311132256.22951-4-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dtECbAkD433BILTFNiKU1MF72Nv9BPkN7"
Subject: Re: [Qemu-devel] [PATCH 03/21] object: fix potential leak in getters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, mdroth@linux.vnet.ibm.com, armbru@redhat.com, anderson@redhat.com, pbonzini@redhat.com, lersek@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dtECbAkD433BILTFNiKU1MF72Nv9BPkN7
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, mdroth@linux.vnet.ibm.com, armbru@redhat.com,
 anderson@redhat.com, pbonzini@redhat.com, lersek@redhat.com
Message-ID: <8a7b0c94-b274-d8c2-a551-dec86814e96c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/21] object: fix potential leak in getters
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
 <20170311132256.22951-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170311132256.22951-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/11/2017 07:22 AM, Marc-Andr=C3=A9 Lureau wrote:
> If the property is not of the requested type, the getters will leak a
> QObject.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: qemu-trivial@nongnu.org
> ---
>  qom/object.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

This one should be safe for 2.9.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--dtECbAkD433BILTFNiKU1MF72Nv9BPkN7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0Tv1AAoJEKeha0olJ0NqZIsIAJf7Rm/f5wOVa3LLMK87kC2l
/J9T5hrfDAwHy5dOKFqyi20+ZzCLvVcsZzMMeJfQfWnjD6McXFyjeamZQ3t0tniZ
C/7Tb8T3vlRYaL6vOhTY1OyTGDxgGH1YDkTB3JM20g6aGBxbJ1xa9p9HfokjGK5/
51sTZLMH1TgWk9cNetqV5IoYHyfi/3oF6ckUa1kZClOVTeiTv0yunRV790lMl/gl
VUwj+Ezq/FXZA6JpMcHtILpusUyWw8RDZzG3u2ng1J36Lp+u2/LiDa6Vg6q7L93r
Yd26Ae5pxk50YM9A7ZelhMoVPFc6StNRhfFZql4ahNjwZyFrPU+GDcJ15igrHOY=
=fIBw
-----END PGP SIGNATURE-----

--dtECbAkD433BILTFNiKU1MF72Nv9BPkN7--
