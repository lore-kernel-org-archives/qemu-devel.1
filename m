Received: from eggs.gnu.org ([2001:4830:134:3::10]:48010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqK9K-0008RH-1X
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqK9J-0001Ot-8K
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:48:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqK9I-0001Og-W2
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:48:33 -0400
References: <20170316070427.17120-1-stefanha@redhat.com>
	<20170316070427.17120-2-stefanha@redhat.com>
	<87fuidzj02.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <40cbe76c-dd10-06de-c87b-8111400c525e@redhat.com>
Date: Tue, 21 Mar 2017 08:48:24 -0500
MIME-Version: 1.0
In-Reply-To: <87fuidzj02.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nF3XO0fCOwqvXdDNIO59iQ9igxCn0oDph"
Subject: Re: [Qemu-devel] [PULL 1/3] makefile: merge GENERATED_HEADERS &
 GENERATED_SOURCES variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nF3XO0fCOwqvXdDNIO59iQ9igxCn0oDph
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Message-ID: <40cbe76c-dd10-06de-c87b-8111400c525e@redhat.com>
Subject: Re: [Qemu-devel] [PULL 1/3] makefile: merge GENERATED_HEADERS &
 GENERATED_SOURCES variables
References: <20170316070427.17120-1-stefanha@redhat.com>
 <20170316070427.17120-2-stefanha@redhat.com>
 <87fuidzj02.fsf@dusky.pond.sub.org>
In-Reply-To: <87fuidzj02.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2017 04:08 AM, Markus Armbruster wrote:
> Sorry for chiming in late, I had missed this change.
>=20
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
>> From: "Daniel P. Berrange" <berrange@redhat.com>
>>
>> The only functional difference between the GENERATED_HEADERS
>> and GENERATED_SOURCES variables is that 'Makefile' has a
>> dependancy on GENERATED_HEADERS, causing generated header files
>> to be created immediatey at the start of the build process.
>> There is no reason why this early creation should be restricted
>> to the .h files, and not include .c files too.
>=20
> Actually, there is.
>=20
> Any prerequisites of Makefile are made even by make -n.  Restricting
> them to the ones make -n absolutely needs is good practice.

In fact, this is part of what tripped me up in trying to get to a root
cause in why modifying scripts/tracetool/format/h.py didn't cause
trace.h to be regenerated.  When trace.h is treated as a prerequisite of
Makefile, it's rules get run automatically and don't show up in 'make
--debug' output (you have to resort to the noisier 'make -d' to see that
the rule was run).

>=20
> Generated headers must be prerequisites of Makefile, because automatic
> dependency generation may fail without them.
>=20
> There is no such reason for generated non-headers.
>=20
>>                                                Merge both of
>> the variables into a single GENERATED_FILES variable to make
>> it clear it is for any type of generated file.
>=20
> I don't hate this quite enough for an outright NAK at this late stage.
> I do hate it enough to ask you to think about it once more.
>=20
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--nF3XO0fCOwqvXdDNIO59iQ9igxCn0oDph
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0S8oAAoJEKeha0olJ0NqtuwIAJNk+HC3+c7MZSeTQVCupzsy
4Is2VGuYY/CCFuw9EbOfaAwdL2wpq1apATm49UmLh8Qt8wME2zTMtz3WpPXe9dBc
zFqOoW2RTaC+74QuBLdAVBdKoY4MHaUDzNwqwcathhTESmt57nLpfj1KRUJ+IF55
bOTPHI+AQ/YHdVLYLQ+oRjKS1AYZLLPWNSiskV/Hqu+vlXiPBz1foFPqB6TVKVcd
IC8GZ7g9pRfipcNHDK572zGpRaPzFz3QT2TBF5yTcKHIoMVUt/NyaLNbciGofjr6
VbkiVkSGaC443stWFyzGqsJS8ZwYG/8CmdmIR5Dgd/eeG4wr8/kAi9ySPobIyAE=
=znD4
-----END PGP SIGNATURE-----

--nF3XO0fCOwqvXdDNIO59iQ9igxCn0oDph--
