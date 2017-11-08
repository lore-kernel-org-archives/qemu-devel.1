Received: from eggs.gnu.org ([2001:4830:134:3::10]:40987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCSjl-0001To-0s
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:57:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCSjg-0006Ex-Gt
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:57:57 -0500
References: <20171107223708.17935-1-eblake@redhat.com>
	<20171108154226.GC6118@stefanha-x1.localdomain>
	<462c8b69-9665-1342-fd01-5ba57049a39c@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <061e94f4-602e-3ff3-0f20-d3915e7a5550@redhat.com>
Date: Wed, 8 Nov 2017 09:57:47 -0600
MIME-Version: 1.0
In-Reply-To: <462c8b69-9665-1342-fd01-5ba57049a39c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XWhurDJJjVkBGJtQIwdd5SAEiDpL1DFGm"
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
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XWhurDJJjVkBGJtQIwdd5SAEiDpL1DFGm
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <061e94f4-602e-3ff3-0f20-d3915e7a5550@redhat.com>
Subject: Re: [PATCH] coroutine: Fix documentation of co_aio_sleep_ns()
References: <20171107223708.17935-1-eblake@redhat.com>
 <20171108154226.GC6118@stefanha-x1.localdomain>
 <462c8b69-9665-1342-fd01-5ba57049a39c@redhat.com>
In-Reply-To: <462c8b69-9665-1342-fd01-5ba57049a39c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/08/2017 09:47 AM, Paolo Bonzini wrote:
> On 08/11/2017 16:42, Stefan Hajnoczi wrote:
>>> In any case, co_aio_sleep_ns()
>>> + * does not affect the #AioContext where the current coroutine is ru=
nning,
>>> + * as the coroutine will restart on the same #AioContext that it is
>>> + * running on.
>> I cannot parse the second sentence.  What does "affecting" an AioConte=
xt
>> mean?  Does "where the current coroutine is running" simply mean "the
>> caller"?
>>
>> What is it trying to say?  My guess is: the caller will be resumed in
>> the current AioContext, not the timer's AioContext.
>=20
> Yes, that is the intended meaning.  Perhaps just s/current//.

How about:

This function uses timers and hence needs to know the event loop
(#AioContext) to place the timer on.  After the time elapses, the
current coroutine will restart with the same #AioContext it is currently
running in, even if that is different than the timer context passed to
co_aio_sleep_ns().

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XWhurDJJjVkBGJtQIwdd5SAEiDpL1DFGm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloDKXsACgkQp6FrSiUn
Q2pnagf/e+5853+j30Q9nocVlNGa9KU+ODUdaSeNrj2YZRDRUURM8oEn+TrYroF9
zesAUzPB5FS7C3bryJLdehpLtaQcjTWQrG40dDMeSILhpvIVkXqazrjHdA7tBabw
HyS+7JzQ0U5t+8qGsaRtLirKFn1jGwUGvQb/ZA7F2LBMmavK/5sn0Vx0SIvERwTe
t2vmfHW/nyYyzCxh0B0fDJlUyRwJx48OWULAHNuQxlnL9Ydjrj6cfdGb0ylZJFPY
nYsH883TB+/UrgKOgomLWi8jwW+BPmFYD0W4xC3iLpi6sZUyXjPEsMskNRgYKsjw
Da4yDU2+gftW5aUPLQ7Z7WklGdylsA==
=QJvt
-----END PGP SIGNATURE-----

--XWhurDJJjVkBGJtQIwdd5SAEiDpL1DFGm--
