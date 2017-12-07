Received: from eggs.gnu.org ([2001:4830:134:3::10]:42413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN4w3-0006NO-G9
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 17:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN4w2-0000Bj-NT
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 17:46:31 -0500
References: <20171207201320.19284-1-stefanha@redhat.com>
	<20171207201320.19284-7-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <01909c6c-f0fa-a608-5abc-16137f2fa2e4@redhat.com>
Date: Thu, 7 Dec 2017 16:46:19 -0600
MIME-Version: 1.0
In-Reply-To: <20171207201320.19284-7-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wfndLstKW2c0WWprKFBstKFv5gmSg7ECl"
Subject: Re: [Qemu-devel] [PATCH v2 6/6] qemu-iotests: add 203 savevm with
 IOThreads test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wfndLstKW2c0WWprKFBstKFv5gmSg7ECl
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <01909c6c-f0fa-a608-5abc-16137f2fa2e4@redhat.com>
Subject: Re: [PATCH v2 6/6] qemu-iotests: add 203 savevm with IOThreads test
References: <20171207201320.19284-1-stefanha@redhat.com>
 <20171207201320.19284-7-stefanha@redhat.com>
In-Reply-To: <20171207201320.19284-7-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2017 02:13 PM, Stefan Hajnoczi wrote:
> This test case will prevent future regressions with savevm and
> IOThreads.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/203     | 59 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/203.out |  6 +++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 66 insertions(+)
>  create mode 100755 tests/qemu-iotests/203
>  create mode 100644 tests/qemu-iotests/203.out
>=20

> +#
> +# Creator/Owner: Stefan Hajnoczi <stefanha@redhat.com>

Again, not sure we need this line.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wfndLstKW2c0WWprKFBstKFv5gmSg7ECl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlopxLsACgkQp6FrSiUn
Q2oXdQgAp2ZbVNTmu9eRX5aYQXGihR1F5K3WroacOyFA9agjK80Uhjm+NlgObUl1
rZ/EoQ5h0RY8rJVMrmqrVBIXy4p3S7+Oa0jbd11WgNfzT6KxJKOZkYXx3K97ImNu
XD4yhsH4Sg2WE8lZFsJx0liGumhKAXofIHlCkB9lueILzA+OkoFDTKYTUsOhJWkB
autsH46CwXidb0gybRzzY3hI4lfoPl9iV5Tg0zQhHsoo2fhBEJmvQk9x4TDyDXrG
vA8bFVal7tyqMe5cN9re+0cJAX4EOHpeVAiZAGULO2L/9u0Kgdj/qoScFVkbd2+b
z9U0ARIzQ7EidtOkVGcYVK21BPsjXg==
=pvPc
-----END PGP SIGNATURE-----

--wfndLstKW2c0WWprKFBstKFv5gmSg7ECl--
