Received: from eggs.gnu.org ([2001:4830:134:3::10]:39337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dALQZ-0003wQ-48
	for qemu-devel@nongnu.org; Mon, 15 May 2017 15:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dALQY-0001GM-25
	for qemu-devel@nongnu.org; Mon, 15 May 2017 15:13:07 -0400
References: <20170510143205.32013-1-pbonzini@redhat.com>
	<20170510155700.GY16511@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0c3040de-aabb-ae8c-7689-a6012f8c72e5@redhat.com>
Date: Mon, 15 May 2017 21:12:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170510155700.GY16511@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XvtsXEuuMebFpsKHguD80pPs396xnLRR3"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/7] curl: locking
 cleanups/fixes, coroutine conversion, remove aio_poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XvtsXEuuMebFpsKHguD80pPs396xnLRR3
From: Max Reitz <mreitz@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org
Message-ID: <0c3040de-aabb-ae8c-7689-a6012f8c72e5@redhat.com>
Subject: Re: [Qemu-block] [PATCH v2 0/7] curl: locking cleanups/fixes,
 coroutine conversion, remove aio_poll
References: <20170510143205.32013-1-pbonzini@redhat.com>
 <20170510155700.GY16511@redhat.com>
In-Reply-To: <20170510155700.GY16511@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-10 17:57, Richard W.M. Jones wrote:
> On Wed, May 10, 2017 at 04:31:58PM +0200, Paolo Bonzini wrote:
>> Since the last patch in v1 didn't work, I bit the bullet and converted=

>> the whole thing to coroutines (patches 4-6).  This in turns allows a m=
ore
>> elegant solution to wait for CURLStates to get free (patch 7).
>>
>> I tested this by lowering CURL_NUM_STATES to 2.  With this change, the=

>> buggy case triggers a couple times while booting a Fedora netinst imag=
e.
>=20
> This series fixes the original bug, so:
>=20
>   Tested-by: Richard W.M. Jones <rjones@redhat.com>
>=20
> I think the Reported-by in patch 3 should credit Kun Wei for finding
> the bug, and we should probably mention the BZ too:
>=20
>   Reported-by: Kun Wei <kuwei@redhat.com>
>   Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1447590

This one is older, though:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1437393

:-)

Max

> A nit pick perhaps but in patch 5 you say "This was broken before for
> disks > 2TB, but now it would break at 4GB.".
> I understand after reading it a few times that you mean it would be
> broken at 4GB, if you hadn't changed size_t -> uint64_t (on 32 bit
> platforms).  Perhaps better to clarify that sentence.
>=20
> ---
>=20
> I also ran some performance and stability testing.  I used virt-ls for
> this.  The following command will iterate over every file in a remote
> guest image and print an md5sum:
>=20
>   LIBGUESTFS_BACKEND=3Ddirect \
>   LIBGUESTFS_HV=3D~/d/qemu/x86_64-softmmu/qemu-system-x86_64 \
>   virt-ls -a http://somehost/rhel-guest-image-7.1-20150224.0.x86_64.qco=
w2 \
>           -lR --checksum /
>=20
> I timed this with and without your patches, but there was no
> significant difference (but note that virt-ls is a fundamentally
> sequential program).
>=20
> It didn't crash or hang at any time during my testing.
>=20
> Rich.
>=20



--XvtsXEuuMebFpsKHguD80pPs396xnLRR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZGf22EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQH6s
B/wLuB1pLLIipgyKxW4gk1xcZ2jcvGBoHK7Al6O4GXZ4ZToTxq/zBQoMM+kefkMs
OSo8ETXS7y2Kv6GnBdbU9j/1IiTjD2bBwRIpAOmt7siYm1VOfobT5oT6V1h87snI
BoQ5mj/8xHzyImv7tujQvN+9jgapnqqJHhqwSU3XaHMo2aAtD/ze86hXbe69ZHVQ
DupY8QVnf8K/rAvUHByKvzlAvN6VW8U3LgjvWMmFrXlZnDOCrwTPS1LAb0xXi9u/
JEVRyd/ivAYU9GluzlFRkNr3wMArArRSr2uSkRCa3v7YAY9CWiGaE2HL2KIChUx0
fzSQCnopvNg5AxTgwjcUnsOt
=7ZAM
-----END PGP SIGNATURE-----

--XvtsXEuuMebFpsKHguD80pPs396xnLRR3--
