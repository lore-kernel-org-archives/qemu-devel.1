Received: from eggs.gnu.org ([2001:4830:134:3::10]:39303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcC4R-0004dL-50
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcC4Q-0004dp-7M
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:53:23 -0400
References: <cover.1501508049.git.jcody@redhat.com>
	<c2c3ec73f07ce7181cf71ad8d0d91811c48ea283.1501508049.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <825806a4-9ea7-aa92-c1f6-4c625dc01de0@redhat.com>
Date: Mon, 31 Jul 2017 09:53:02 -0500
MIME-Version: 1.0
In-Reply-To: <c2c3ec73f07ce7181cf71ad8d0d91811c48ea283.1501508049.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FBf3FJpTkda7FDfB44Lekr63d6dJCqDFn"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11 2/3] qemu-iotests: remove file
 cleanup from bash tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FBf3FJpTkda7FDfB44Lekr63d6dJCqDFn
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com
Message-ID: <825806a4-9ea7-aa92-c1f6-4c625dc01de0@redhat.com>
Subject: Re: [PATCH v2 for-2.11 2/3] qemu-iotests: remove file cleanup from
 bash tests
References: <cover.1501508049.git.jcody@redhat.com>
 <c2c3ec73f07ce7181cf71ad8d0d91811c48ea283.1501508049.git.jcody@redhat.com>
In-Reply-To: <c2c3ec73f07ce7181cf71ad8d0d91811c48ea283.1501508049.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/31/2017 08:47 AM, Jeff Cody wrote:
> All files for a given test are now self-contained in a subdirectory,
> and therefore the "./check" script can do all file-related cleanup
> without any help.
>=20
> This removes file cleanups from the bash tests.  The only cleanup left
> is whatever is needed to kill any spawned processes; e.g. _cleanup_qemu=
=2E
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---

Based on cover letter description of diff from v1, you addressed my
concerns.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FBf3FJpTkda7FDfB44Lekr63d6dJCqDFn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/RE4ACgkQp6FrSiUn
Q2qKRwf+L9DhJLbGUsnkksi++38rL9tSpRSxrk5iQL+nKN3HRsvb6sxYrmHDrm3h
KjwqnrboEgN5mYPfw5halFsTM57As/QahckYxmp7v12dPjrVTr2Eq/Mx/XCqpEHW
ir4xSmOvF3LfHkpV9zYidZd+8F6wJXKZ46FIU+hvYh208A3MO0esD1W9ldq6tyXC
mcZu+bwokWibGpuIyf/OSyDFRfucoK4gUfW/Biyg+pRHYJ50WEBcZX1AyR2pgKU6
80TErxgQqe6Et1BXYL2/YkikVdqiVqSdILYjWuenKsK3t3aeGMhoyyG4i8r/qdQw
MZyH1A7iPp2NTVWUxG9CdoeVHe9rWg==
=BW2/
-----END PGP SIGNATURE-----

--FBf3FJpTkda7FDfB44Lekr63d6dJCqDFn--
