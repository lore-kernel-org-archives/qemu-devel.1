Received: from eggs.gnu.org ([2001:4830:134:3::10]:42546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJIg4-0006wM-WF
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJIg3-00007N-Qj
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:06:08 -0400
References: <1497009003-25794-1-git-send-email-kwolf@redhat.com>
	<1497009003-25794-3-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <024dd4f2-ecf8-088e-4207-822878a13433@redhat.com>
Date: Fri, 9 Jun 2017 07:05:54 -0500
MIME-Version: 1.0
In-Reply-To: <1497009003-25794-3-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="99EgMopWsxKVKNfLqSs6hXNJIpOqP21q6"
Subject: Re: [Qemu-devel] [PATCH 2/3] qemu-iotests: Allow starting new qemu
 after cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--99EgMopWsxKVKNfLqSs6hXNJIpOqP21q6
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <024dd4f2-ecf8-088e-4207-822878a13433@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] qemu-iotests: Allow starting new qemu
 after cleanup
References: <1497009003-25794-1-git-send-email-kwolf@redhat.com>
 <1497009003-25794-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1497009003-25794-3-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/09/2017 06:50 AM, Kevin Wolf wrote:
> After _cleanup_qemu(), test cases should be able to start the next qemu=

> process and call _cleanup_qemu() for that one as well. For this to work=

> cleanly, we need to improve the cleanup so that the second invocation
> doesn't try to kill the qemu instances from the first invocation a
> second time (which would result in error messages).

Yeah, idempotency is a nice thing.

>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/common.qemu | 3 +++
>  1 file changed, 3 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common=
=2Eqemu
> index 7a78a00..76ef298 100644
> --- a/tests/qemu-iotests/common.qemu
> +++ b/tests/qemu-iotests/common.qemu
> @@ -222,5 +222,8 @@ function _cleanup_qemu()
>          rm -f "${QEMU_FIFO_IN}_${i}" "${QEMU_FIFO_OUT}_${i}"
>          eval "exec ${QEMU_IN[$i]}<&-"   # close file descriptors
>          eval "exec ${QEMU_OUT[$i]}<&-"
> +
> +        unset QEMU_IN[$i]
> +        unset QEMU_OUT[$i]
>      done
>  }
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--99EgMopWsxKVKNfLqSs6hXNJIpOqP21q6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOo8jAAoJEKeha0olJ0NqqC4H/10BD0UaJzB0LwsYI3BbRFrP
92jojodEQTPDkX4H811kf8nQkjsDs5s5D4ZWEbVITlw+R6FR8Rjc7sgfi8CuMrrT
ibwR1G4bOJzUt/m4AoiENX7RXLyf0iszXLO7Oqvcs+lC0ItCO0Bp9CSUqffEn4Ku
WiHmDpTcXqRCO/8xZoyt/IvF/vwTtUi81YvZKpQDfgiuXYyjQrJmywbM8x3g5B1b
hSDOZEINRIHhDuji7U5fbd4HkpTGbFVkK4zlFXEAeJxOsROZnrFsJt9JdLBIHmHQ
ESErObuKjItKhCf++OAQCeAFeJpWncqP0y4Iyht0532sccnXg5nCqNZ96XvrC2U=
=Fy+9
-----END PGP SIGNATURE-----

--99EgMopWsxKVKNfLqSs6hXNJIpOqP21q6--
