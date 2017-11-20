Received: from eggs.gnu.org ([2001:4830:134:3::10]:55057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eGuVr-0000k2-CM
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eGuVq-0006ny-MW
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:25:59 -0500
References: <cover.1511145863.git.jcody@redhat.com>
	<2cd4d33dc68bb3c738e1c9aa39a0ddd4108c401e.1511145863.git.jcody@redhat.com>
	<20171120111653.GB4516@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b910238b-d42c-abfe-9d57-1db2c97728cc@redhat.com>
Date: Mon, 20 Nov 2017 23:25:37 +0100
MIME-Version: 1.0
In-Reply-To: <20171120111653.GB4516@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u0ClNopGCsQwiiwar50RPV9GmVgKcI7bJ"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/5] blockjob: do not allow
 coroutine double entry or entry-after-completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u0ClNopGCsQwiiwar50RPV9GmVgKcI7bJ
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com
Message-ID: <b910238b-d42c-abfe-9d57-1db2c97728cc@redhat.com>
Subject: Re: [Qemu-block] [PATCH 1/5] blockjob: do not allow coroutine double
 entry or entry-after-completion
References: <cover.1511145863.git.jcody@redhat.com>
 <2cd4d33dc68bb3c738e1c9aa39a0ddd4108c401e.1511145863.git.jcody@redhat.com>
 <20171120111653.GB4516@stefanha-x1.localdomain>
In-Reply-To: <20171120111653.GB4516@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20/11/2017 12:16, Stefan Hajnoczi wrote:
> This raises questions about the ability to cancel sleep:
>=20
> 1. Does something depend on cancelling sleep?

block_job_cancel does, but in practice the sleep time is so small
(smaller than SLICE_TIME, which is 100 ms) that we probably don't care.

I agree with Jeff that canceling the sleep by force-entering the
coroutine seemed clever but is probably a very bad idea.

Paolo


--u0ClNopGCsQwiiwar50RPV9GmVgKcI7bJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAloTVmQACgkQv/vSX3jH
roMgEAf9GhnWRWpNGGsAiJz5ufdrsDjjGC9aBmjAfR5IiXjkDf5Sla1BKa96QZVW
tHG3QLc77Qy0o7g6cD3Fz7twYyRtq68CJPHVk8K6B6BZjIQP3GL0mfYt39f6jgpZ
3r2dLiPux3GPGxHqPy2Oz2BMHIP+Ega2fy0ovM6qvxgY93Hl74oSxanHTDeRRT1S
qRWLV5AXEK+CBXEhnIllOLTQ3ywe71HrLh3LKkBBoJDcBK+kaCruT1+ZXigmI2+L
XalgP7ccq/0yQSiJMdi2UinDrfE+l2rM5hKlr7JzMlk+fbtFuumPyQ6uLDan79Qr
gOe08qcgFgrMciQo+9cKWHlJM8r7+Q==
=ClmR
-----END PGP SIGNATURE-----

--u0ClNopGCsQwiiwar50RPV9GmVgKcI7bJ--
