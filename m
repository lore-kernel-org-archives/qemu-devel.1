Received: from eggs.gnu.org ([2001:4830:134:3::10]:38503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eCSZa-0007As-F0
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:47:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eCSZV-0001br-Is
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:47:26 -0500
References: <20171107223708.17935-1-eblake@redhat.com>
	<20171108154226.GC6118@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <462c8b69-9665-1342-fd01-5ba57049a39c@redhat.com>
Date: Wed, 8 Nov 2017 16:47:07 +0100
MIME-Version: 1.0
In-Reply-To: <20171108154226.GC6118@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sMGnqX3Ew9k2dWCGjeECVUhMNjdM3DLUs"
Subject: Re: [Qemu-devel] [PATCH] coroutine: Fix documentation of
 co_aio_sleep_ns()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sMGnqX3Ew9k2dWCGjeECVUhMNjdM3DLUs
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <462c8b69-9665-1342-fd01-5ba57049a39c@redhat.com>
Subject: Re: [PATCH] coroutine: Fix documentation of co_aio_sleep_ns()
References: <20171107223708.17935-1-eblake@redhat.com>
 <20171108154226.GC6118@stefanha-x1.localdomain>
In-Reply-To: <20171108154226.GC6118@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/11/2017 16:42, Stefan Hajnoczi wrote:
>> In any case, co_aio_sleep_ns()
>> + * does not affect the #AioContext where the current coroutine is run=
ning,
>> + * as the coroutine will restart on the same #AioContext that it is
>> + * running on.
> I cannot parse the second sentence.  What does "affecting" an AioContex=
t
> mean?  Does "where the current coroutine is running" simply mean "the
> caller"?
>=20
> What is it trying to say?  My guess is: the caller will be resumed in
> the current AioContext, not the timer's AioContext.

Yes, that is the intended meaning.  Perhaps just s/current//.

Paolo


--sMGnqX3Ew9k2dWCGjeECVUhMNjdM3DLUs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAloDJvsACgkQv/vSX3jH
roOD3Af/dmH9U/CPUsg3NCKAzBi15Dut8Uo0oJTj8SfQdTT5M621BvodVRsgPUye
zG0Mo1RER8OQdJ/1kkgsTE1NL2vVmnNzAPooP7HvwGMZPA5x4PhykTqccHeg5JeD
V51Sf/qCR7XMLRiY9FZpyV/FjYf1w85E7Eoa6LWRMG9BU4Y/l+qr3sm8ujBEaYF6
CuQe/i1Adc4KQnNPdiHEb+LuhFrSWt8EuNIbBSNrN4iJEjauPgklz1xmUuFtp8xh
JBakBDXx109a/d40kkjrCOpty4PS6+isheM0Z9ibQnpM/N/+fePmNCIAck5IXsjW
9nzX33/lJgfekO564IlGrusjaVKRJQ==
=NnXs
-----END PGP SIGNATURE-----

--sMGnqX3Ew9k2dWCGjeECVUhMNjdM3DLUs--
