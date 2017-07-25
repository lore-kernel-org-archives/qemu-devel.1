Received: from eggs.gnu.org ([2001:4830:134:3::10]:53617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da0Tp-0000JA-DH
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:06:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da0Tm-0000xB-8R
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:06:33 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1da0Tl-0000wq-Vz
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:06:30 -0400
Received: by mail-wr0-x241.google.com with SMTP id 12so11934738wrb.4
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 07:06:29 -0700 (PDT)
Date: Tue, 25 Jul 2017 15:06:26 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170725140626.GL23343@stefanha-x1.localdomain>
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-7-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fDERRRNgB4on1jOB"
Content-Disposition: inline
In-Reply-To: <1500645206-13559-7-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/9] tests/libqos/pci: Clean up string
 interpolation into QMP input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org


--fDERRRNgB4on1jOB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 03:53:23PM +0200, Markus Armbruster wrote:
> Leaving interpolation into JSON to qmp() is more robust than building
> QMP input manually, as explained in the commit before previous.
>=20
> The case in qpci_plug_device_test() is a bit complicated: it
> interpolates several JSON object members, not just a value.  Clean it
> up by passing them in as QDict rather than string, so we can leave
> interpolation to qmp() here and to qobject_from_jsonf() in callers.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/ivshmem-test.c    | 10 +++++-----
>  tests/libqos/pci.c      | 33 ++++++++++++++++++---------------
>  tests/libqos/pci.h      |  2 +-
>  tests/virtio-blk-test.c |  5 ++++-
>  4 files changed, 28 insertions(+), 22 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--fDERRRNgB4on1jOB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZd1BiAAoJEJykq7OBq3PI9yQIAIneV6zhCst7mWfW5sCVPXBV
X3kFhEr280Vkn4KnlhtbBz1z/qUdffABjBV7OAIcnLV6DFkZw0slMR7hqZYJ+oWg
i8uNxquGg32CXQYNKSoRycJwipJwmYng9zwkd1t/1BnSeR9muCsWN481PgEW9fnF
GRQsqswN2AN9sl9ZPCGBzZgwDQYqXehDJnxMlFaeXmAHTX/MuhFSymntcwD3d9uf
jjs0ZHRnqtTsOoQcL5RxvQzZk66IyeoqmZPcMTumTPD+7SWTAC5fByFvLIHMIDA4
il8h4TLGpiSxuAh8BjuKoceMBDYO5yftgYfYGkvg81ZRggyX/JiJdej3WgFmr4o=
=SlQ7
-----END PGP SIGNATURE-----

--fDERRRNgB4on1jOB--
