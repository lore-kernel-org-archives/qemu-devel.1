Received: from eggs.gnu.org ([2001:4830:134:3::10]:44466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5fmV-0001JA-DG
	for qemu-devel@nongnu.org; Tue, 02 May 2017 17:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5fmS-0005Hm-Bb
	for qemu-devel@nongnu.org; Tue, 02 May 2017 17:56:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d5fmS-0005H8-1u
	for qemu-devel@nongnu.org; Tue, 02 May 2017 17:56:24 -0400
References: <1493735386-39622-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1493735386-39622-2-git-send-email-pradeep.jagadeesh@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c4737a0-f633-8688-3711-f9ffb218a073@redhat.com>
Date: Tue, 2 May 2017 16:56:20 -0500
MIME-Version: 1.0
In-Reply-To: <1493735386-39622-2-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IcH1doiKlKCWNOKV2E61MOGAjKJ9c7dRV"
Subject: Re: [Qemu-devel] [PATCH v3 1/4] Throttle: Create IOThrottle
 structure
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
--IcH1doiKlKCWNOKV2E61MOGAjKJ9c7dRV
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>,
 qemu-devel@nongnu.org
Message-ID: <5c4737a0-f633-8688-3711-f9ffb218a073@redhat.com>
Subject: Re: [PATCH v3 1/4] Throttle: Create IOThrottle structure
References: <1493735386-39622-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1493735386-39622-2-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1493735386-39622-2-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/02/2017 09:29 AM, Pradeep Jagadeesh wrote:
> This patchset introduces a new io throttle structure. This will be
> used in both block and fsdev devices.
>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> ---
>  qapi/block-core.json | 76 ++------------------------------------------=
--
>  qapi/iothrottle.json | 86 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 89 insertions(+), 73 deletions(-)
>  create mode 100644 qapi/iothrottle.json
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--IcH1doiKlKCWNOKV2E61MOGAjKJ9c7dRV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCQCEAAoJEKeha0olJ0NqvDcIALAzxaJhE9hOnk7wacHmQufG
A7crnkvvZsTI5DmPmdJA6tHmwDxk228079YOrHUsjSseeyP5t0KbyckW9ZMasmLH
06qQI/lQSZ145LnB8IF9IYNww44guCWuxgpGBwGzhqHjKSfl3H6lyCAmkU8/mZHK
Sk+VpEA648l9sjSH4pXB+7ayQJqfuvqswvvXcGJUe+SYDIT2XUGVl5y2WnxxJlmF
qnrgWOs7dUoTMrHmxFg7kyxeFIC5hF+S5TVmHpTl5ryOjfNW0ywmc/ou5LhXJqjv
FucVkQ+dE6ymF4jbLqKJTUmC+N8xXsRNGSb9PmM+mH5bElqcE3f2uzIA5eImofs=
=2Ls5
-----END PGP SIGNATURE-----

--IcH1doiKlKCWNOKV2E61MOGAjKJ9c7dRV--
