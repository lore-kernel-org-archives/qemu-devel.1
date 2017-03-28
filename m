Received: from eggs.gnu.org ([2001:4830:134:3::10]:52569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csqx8-00030d-7U
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csqx7-0002aQ-5N
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:14:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1csqx6-0002a8-Tk
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:14:25 -0400
References: <1490694017-7532-1-git-send-email-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fd10f419-f13c-28c8-f85b-5cb54b59566a@redhat.com>
Date: Tue, 28 Mar 2017 08:14:19 -0500
MIME-Version: 1.0
In-Reply-To: <1490694017-7532-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PgjobQJEIGS6DbbojeOT2wqR2B0GpAvK0"
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] tests/bios-tables-test: Don't
 pass addresses of packed struct fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PgjobQJEIGS6DbbojeOT2wqR2B0GpAvK0
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, patches@linaro.org
Message-ID: <fd10f419-f13c-28c8-f85b-5cb54b59566a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] tests/bios-tables-test: Don't
 pass addresses of packed struct fields
References: <1490694017-7532-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1490694017-7532-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/28/2017 04:40 AM, Peter Maydell wrote:
> Passing the address of a field in a packed struct to a function
> that expects a pointer to normally aligned data will result in
> a SEGBUS on architectures like SPARC that have strict alignment

s/SEGBUG/SIGBUS/

> requirements.
>=20
> Pass addresses of local variables rather than addresses of packed
> structure fields to glib functions like g_file_get_contents() to
> avoid this bug.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--PgjobQJEIGS6DbbojeOT2wqR2B0GpAvK0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY2mGrAAoJEKeha0olJ0NqsoAIAI9GQYYyILAPTP35LuDH7N5i
tDzI7q8anMJOMD6QZDql3FCRSX4e+roUPMsyjwLVwaIGhs7ZOUmlXQhIPgfGXuDY
7N4fop7gT9hRVmKV7r2fRgdofXfHldP0xhsfxlMObyuGOc9sEylY3MuXMJT/mMFf
Nj9S8I6wxOONiu6w2vbFJypEzqrg6Lw4M3cbcJ0IvlmhjOvdZLWnS8OzOllc4ZKs
dt03QZ0O9wcqJ4RekJ61X1VxJwRlelVnZijvR15FNF1eTcWIOMrEEnLNMQoCibfY
rk689rQhlntDeR9yvRpiWXBpCrB3ZOqU7ISLyiQoMzQEtpRzs/7HkhaVthI6CAk=
=oiSO
-----END PGP SIGNATURE-----

--PgjobQJEIGS6DbbojeOT2wqR2B0GpAvK0--
