Received: from eggs.gnu.org ([2001:4830:134:3::10]:57832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYaAs-0008PL-Kq
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYaAp-0001JJ-Gv
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:16:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYaAp-0001I0-7j
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:16:47 -0500
References: <1485873796-15095-1-git-send-email-mst@redhat.com>
	<b1e5af37-6547-e688-0365-2bb1bfe45954@redhat.com>
	<CAFEAcA-UPQrgq8h1LbqsUWP-MKwkOBLsAk0R0u0YuSfyA=nQAg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c6c5267a-58df-061b-8dd3-73d691d37578@redhat.com>
Date: Tue, 31 Jan 2017 09:16:40 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-UPQrgq8h1LbqsUWP-MKwkOBLsAk0R0u0YuSfyA=nQAg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d9uPuxootSUcG9UnptAunHOetiSwdTjAv"
Subject: Re: [Qemu-devel] [PATCH] QEMU_BUILD_BUG_ON: use __COUNTER__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d9uPuxootSUcG9UnptAunHOetiSwdTjAv
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <c6c5267a-58df-061b-8dd3-73d691d37578@redhat.com>
Subject: Re: [PATCH] QEMU_BUILD_BUG_ON: use __COUNTER__
References: <1485873796-15095-1-git-send-email-mst@redhat.com>
 <b1e5af37-6547-e688-0365-2bb1bfe45954@redhat.com>
 <CAFEAcA-UPQrgq8h1LbqsUWP-MKwkOBLsAk0R0u0YuSfyA=nQAg@mail.gmail.com>
In-Reply-To: <CAFEAcA-UPQrgq8h1LbqsUWP-MKwkOBLsAk0R0u0YuSfyA=nQAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2017 09:12 AM, Peter Maydell wrote:
> On 31 January 2017 at 15:03, Eric Blake <eblake@redhat.com> wrote:
>> On 01/31/2017 08:43 AM, Michael S. Tsirkin wrote:
>>> Some headers use QEMU_BUILD_BUG_ON. This causes a problem
>>> if the C file including that header happens to have
>>> QEMU_BUILD_BUG_ON at the same line number.
>>>
>>> Fix using a widely available extension: __COUNTER__.
>>
>> gcc 4.3 and later; clang documents it but doesn't say when it was adde=
d.
>>
>>> If unavailable, provide a stub.
>>
>> What fails in our build farm if we don't provide the stub? Can we just=

>> require that our compiler is new enough to have __COUNTER__, or will
>> that break some of our existing targets?
>=20
> I think the problem is not so much our build farm (which is
> I think all recent enough to postdate introduction of
> __COUNTER__) but the probability of there being users
> out there who are still using older compilers to build
> QEMU releases. We don't need to enforce compile time
> asserts on those old compilers but given that it's
> trivial to avoid actually breaking the build for them,
> why not provide the do-nothing fallback?

The do-nothing fallback works for me; I'm just debating whether it is
dead code or whether we really would have a user building with a
compiler that old.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--d9uPuxootSUcG9UnptAunHOetiSwdTjAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYkKpYAAoJEKeha0olJ0NqTeMH/RScBBCyGPEYXbTGHdYdxbpu
wi0V/Q7/GIXEkJYeg53OTDKtWQCiQi0AnelXgvZAXkhK+vI+45uXRpr9jT9pipp6
HPgTFY4GCPHQSKedrNeFKuSTnBhwtcSSoKaqyzKJfuMDrhXTK0YDxjhq7zqtHgbY
CIsDke42pjAzO/MTDBORG6G7bxaMHzcz6cTek+iuITmnFQzkwQVFa49WQN6YlG4E
S1UiNJpKydFiuom2oPkMpWxFfsGQR5kKGp2SEy0XoWuMlp5NHqVTITMf6f+K4N7D
aVLsNNI4J+FQhS9A7aEevDVCDiutQLXGNbPhqIJDy8mypjHt+zUEfJBkPz5Q3kI=
=MNyW
-----END PGP SIGNATURE-----

--d9uPuxootSUcG9UnptAunHOetiSwdTjAv--
