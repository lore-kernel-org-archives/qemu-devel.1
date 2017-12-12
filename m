Received: from eggs.gnu.org ([2001:4830:134:3::10]:46143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eOrNM-0008Rl-M1
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 15:42:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eOrNI-0003FS-29
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 15:42:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eOrNH-0003FF-PE
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 15:41:59 -0500
References: <20171208105553.12249-1-pbonzini@redhat.com>
	<32f8bbf4-1fb6-b974-f7ca-f5a91adf875e@redhat.com>
	<CAFEAcA8j_tGZr-i5LE+ZXAnk4v=pfrKadmgsf=ncMHRUsYK1zQ@mail.gmail.com>
	<b5a01fb0-4f25-7cae-99d3-c9722912b6c1@redhat.com>
	<cfe0f5b0-39e7-6bd1-3caf-4abb855275ec@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0895424e-ad82-be08-4232-0f46369a946b@redhat.com>
Date: Tue, 12 Dec 2017 14:41:52 -0600
MIME-Version: 1.0
In-Reply-To: <cfe0f5b0-39e7-6bd1-3caf-4abb855275ec@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mg7iun0APHiwxAtEGVhkxmCT5e3uejbDT"
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] Scoped locks using
 attribute((cleanup))
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mg7iun0APHiwxAtEGVhkxmCT5e3uejbDT
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G . Cota"
 <cota@braap.org>, Fam Zheng <famz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <0895424e-ad82-be08-4232-0f46369a946b@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] Scoped locks using
 attribute((cleanup))
References: <20171208105553.12249-1-pbonzini@redhat.com>
 <32f8bbf4-1fb6-b974-f7ca-f5a91adf875e@redhat.com>
 <CAFEAcA8j_tGZr-i5LE+ZXAnk4v=pfrKadmgsf=ncMHRUsYK1zQ@mail.gmail.com>
 <b5a01fb0-4f25-7cae-99d3-c9722912b6c1@redhat.com>
 <cfe0f5b0-39e7-6bd1-3caf-4abb855275ec@redhat.com>
In-Reply-To: <cfe0f5b0-39e7-6bd1-3caf-4abb855275ec@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/11/2017 03:32 PM, Paolo Bonzini wrote:
> On 11/12/2017 15:11, Eric Blake wrote:
>> I don't know if there is a way to make gcc insert stack-unwind
>> directives that are honored across longjmp (I know C++ does it for
>> exceptions; so there may be a way, and I just don't know it).
>=20
> Probably -fexceptions.
>=20

Well, that's what 'info gcc' mentions:

'cleanup (CLEANUP_FUNCTION)'
     The 'cleanup' attribute runs a function when the variable goes out
     of scope.  This attribute can only be applied to auto function
     scope variables; it may not be applied to parameters or variables
     with static storage duration.  The function must take one
     parameter, a pointer to a type compatible with the variable.  The
     return value of the function (if any) is ignored.

     If '-fexceptions' is enabled, then CLEANUP_FUNCTION is run during
     the stack unwinding that happens during the processing of the
     exception.  Note that the 'cleanup' attribute does not allow the
     exception to be caught, only to perform an action.  It is undefined
     what happens if CLEANUP_FUNCTION does not return normally.

but adding -fexceptions to my sample program does NOT make a difference
(apparently, unwind cleanup triggered by C++ exceptions is NOT the same
as unwinding done by longjmp()).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mg7iun0APHiwxAtEGVhkxmCT5e3uejbDT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlowPxAACgkQp6FrSiUn
Q2rQBwf/XLL26khWJN8kNXx+DyJ1x5KyxZD41wxoxZPc3TlY7IRpESqQ8EW6gOZq
NcYYES5h3AAmHUKw9auhKuDAROupvpig6KdBFIU9xYKNrU1NuYDURhvmtPjZM6QD
If6eKetLDbUI+eM4AbwJsZkCTxDYFbsHrZslHYf84QUgvpP898bmE9ReJGuZAO0z
5puhyz+g9Z64JGLJPT8XaxqN0vt5cBwfcj/awANkpIuX1dITLqUInka2UqbRaMUh
dL4ZFi9AOk+p144OAfcyWTHpzfEdsJaeyyrnT1IUymwF1j4uMxBCS0pXgf/fH95Z
Hlrje47uuqgRd0EfICOo5cHHq9uqbA==
=t/Dz
-----END PGP SIGNATURE-----

--mg7iun0APHiwxAtEGVhkxmCT5e3uejbDT--
