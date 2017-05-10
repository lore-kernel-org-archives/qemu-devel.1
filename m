Received: from eggs.gnu.org ([2001:4830:134:3::10]:57875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8XiT-0005bj-Nb
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8XiP-0003Qu-Nh
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:56:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d8XiP-0003Qg-F5
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:56:05 -0400
References: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1494405683-20877-4-git-send-email-pradeep.jagadeesh@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3797fb7d-bd3d-c1b0-0707-57f95852cb5f@redhat.com>
Date: Wed, 10 May 2017 14:56:01 -0500
MIME-Version: 1.0
In-Reply-To: <1494405683-20877-4-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PNenv5EnADMCiNcX4tLPfv64c7UkR2DA7"
Subject: Re: [Qemu-devel] [PATCH v4 3/4] qmp: refactor duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PNenv5EnADMCiNcX4tLPfv64c7UkR2DA7
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>,
 qemu-devel@nongnu.org
Message-ID: <3797fb7d-bd3d-c1b0-0707-57f95852cb5f@redhat.com>
Subject: Re: [PATCH v4 3/4] qmp: refactor duplicate code
References: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1494405683-20877-4-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1494405683-20877-4-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/10/2017 03:41 AM, Pradeep Jagadeesh wrote:
> This patch factor out the duplicate qmp throttle interface code
> that was present in both block and fsdev device files.
>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> ---
>  blockdev.c                      | 53 +++------------------------------=
-------
>  hmp.c                           | 21 +++++++++++-----
>  include/qemu/throttle-options.h |  2 ++
>  util/throttle-options.c         | 54 +++++++++++++++++++++++++++++++++=
++++++++
>  4 files changed, 74 insertions(+), 56 deletions(-)
>=20

> +++ b/include/qemu/throttle-options.h
> @@ -94,4 +94,6 @@
> =20
>  void parse_io_throttle_options(ThrottleConfig *, QemuOpts *);
> =20
> +void qmp_set_io_throttle(ThrottleConfig *, IOThrottle *);

I don't think this is the right name for this function.  You are not
adding a new QMP command (you didn't modify a .json file to add
'set-io-throttle').  As mentioned in patch 1/4, you can probably reuse
the existing util/throttle.c instead of throttle-options.c, and name
this something starting with throttle_ rather than with qmp_.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PNenv5EnADMCiNcX4tLPfv64c7UkR2DA7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZE3BRAAoJEKeha0olJ0NqJnsH/R8XYLm5Un6giunwKZjvmXUn
KaSzr0nHyT+kxth1xVoDicnD63/476e+ixDuPAnDSY5LJwNMX5oqV69/HnxGlmKZ
FjZ6mRPITCYZuQGhiQgwcYakj8he0kHGdvDWYDCjbUjolZ6jB0d3UW+UQYYl3PdD
c/3FeE+4ZJhrJLQk140hwUC6xUcsYbIgOsxL+nG3Y3J4ZB2+YjiOZ75+w+UXbtWM
9sh+eAfxScJB5CwJFsvQIjwH8ST+SCyTzGJ1CqGes/cNlt8xl3isFjZME9mWd7rb
4PgTj6lcwoSWP1OZQXYzt1ongSsIxV0hGeJgINjXlRvHkPyLc3vrANEN0FlVSMo=
=npdw
-----END PGP SIGNATURE-----

--PNenv5EnADMCiNcX4tLPfv64c7UkR2DA7--
