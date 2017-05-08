Received: from eggs.gnu.org ([2001:4830:134:3::10]:46574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7kML-0003pv-0c
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7kMJ-0000ao-Ph
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:14:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d7kMJ-0000ak-Fo
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:13:59 -0400
References: <87pofj8kek.fsf@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6d99873f-a68f-180d-a72f-db6d569fb215@redhat.com>
Date: Mon, 8 May 2017 10:13:56 -0500
MIME-Version: 1.0
In-Reply-To: <87pofj8kek.fsf@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="w5S2rHS9kIB6lSBJlri5NqLiojRt7rtHG"
Subject: Re: [Qemu-devel] Future of SoftFloat use in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <aleksandar.markovic@imgtec.com>, Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w5S2rHS9kIB6lSBJlri5NqLiojRt7rtHG
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Richard Henderson
 <rth@twiddle.net>, Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
 Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <6d99873f-a68f-180d-a72f-db6d569fb215@redhat.com>
Subject: Re: [Qemu-devel] Future of SoftFloat use in QEMU
References: <87pofj8kek.fsf@linaro.org>
In-Reply-To: <87pofj8kek.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2017 09:58 AM, Alex Benn=C3=A9e wrote:
> Hi,
>=20
> We've got a task coming up to implement half-precision floating point
> (FP16) for ARMv8.2. As you know pretty much all our floating point in
> QEMU is handled by our internal fork of John R. Hauser's BSD SoftFloat
> library. Our current implementation is based on version 2a which doesn'=
t
> support FP16.

Our fork is stuck at 2a because the license of 2b had compatibility
problems (it had legal restrictions that prevent interaction with GPL).

>=20
> As it happens there has been a new release of SoftFloat recently.
> Version 3 is a complete re-write which made a number of changes, some
> notable ones being:
>=20
>   - Complete rewrite, different use license than earlier releases.

And this different license is what?

> See: http://www.jhauser.us/arithmetic/SoftFloat-3c/doc/SoftFloat-histor=
y.html

which says merely "Replaced the license text supplied by the University
of California, Berkeley." but not WHAT the actual license text is.  Are
we lucky enough that it might have a 2-clause BSD license?

/me goes digging...

http://www.jhauser.us/arithmetic/SoftFloat-3c/doc/SoftFloat.html

>  The following applies to the whole of SoftFloat Release 3c as well as =
to each source file individually.
>=20
> Copyright 2011, 2012, 2013, 2014, 2015, 2016, 2017 The Regents of the U=
niversity of California. All rights reserved.
>=20
> Redistribution and use in source and binary forms, with or without modi=
fication, are permitted provided that the following conditions are met:
>=20
>     Redistributions of source code must retain the above copyright noti=
ce, this list of conditions, and the following disclaimer.
>=20
>     Redistributions in binary form must reproduce the above copyright n=
otice, this list of conditions, and the following disclaimer in the docum=
entation and/or other materials provided with the distribution.
>=20
>     Neither the name of the University nor the names of its contributor=
s may be used to endorse or promote products derived from this software w=
ithout specific prior written permission.
>=20
> THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS =E2=80=9CAS I=
S=E2=80=9D, AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIM=
ITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PART=
ICULAR PURPOSE, ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBU=
TORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, =
OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF S=
UBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS I=
NTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CO=
NTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARI=
SING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE P=
OSSIBILITY OF SUCH DAMAGE.=20

Not a 2-clause BSD, but sure looks exactly like the stock 3-clause BSD
license.  Yay - https://www.gnu.org/licenses/license-list.en.html says
it is compatible with GPL, and thus we can use it in qemu!

> So any thoughts about what would make the best approach?

No quick thoughts on the best way to proceed, but at least (from my
non-lawyer perspective) it looks like we CAN quit maintaining our fork.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--w5S2rHS9kIB6lSBJlri5NqLiojRt7rtHG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEIs0AAoJEKeha0olJ0NqvEUH/1+wHBsTjQhYu2GsQdbua/LX
1vuYEFjYT7CJKLgDJ1uC3JKs9FKaCgOnwlqrS0Dx0MmMQTpDqsUOo/eMvyC5MP4t
ozB/AQ7lGTxcziRrOMNap4IbGi4RFhJ6nXz2hC+j4BuSZMj5gnmiw7vjdyXYspOv
iS2vrfIrjnAPJNR+cwj6YjkxBf2cW/FLYdn1wVWyNo6dSmZKTVqEnMHZS+QmTOlp
DU2o1d6jAvJjLh1Ju1TvgevebdGT6NdxZZgPrZYELtiVZbhmC9OLq8XL+H6/CV5K
BVJ3sUrmakh+V9XW43UOuxIbql+j5RGR3jHSRCGGld12J27Rj2ojBaPePnkkATo=
=Yucp
-----END PGP SIGNATURE-----

--w5S2rHS9kIB6lSBJlri5NqLiojRt7rtHG--
