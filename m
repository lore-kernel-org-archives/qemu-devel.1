Received: from eggs.gnu.org ([2001:4830:134:3::10]:56659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQhGT-0000r2-C0
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:14:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQhGQ-0002mn-5i
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:14:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cQhGP-0002me-TE
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:13:58 -0500
References: <1469611466-31574-1-git-send-email-silbe@linux.vnet.ibm.com>
	<57991CC1.40003@redhat.com> <87twfaysit.fsf@dusky.pond.sub.org>
	<5799E26B.7090408@linux.vnet.ibm.com> <579A1D33.6010500@redhat.com>
	<579A24BE.2060707@linux.vnet.ibm.com> <579A733C.5050306@redhat.com>
	<579B5C49.1040707@linux.vnet.ibm.com>
	<8b7d3287-90c4-6a07-894c-e9c32fd4567f@redhat.com>
	<e1305993-ac60-d965-16cd-281919825ff6@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0c4a930b-f7a7-0571-c955-01840d75c3e3@redhat.com>
Date: Mon, 9 Jan 2017 15:13:54 -0600
MIME-Version: 1.0
In-Reply-To: <e1305993-ac60-d965-16cd-281919825ff6@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="L6gTAQt08b8PuDTrUhKMh195u6cXK76OE"
Subject: Re: [Qemu-devel] [PATCH] error: error_setg_errno(): errno gets
 preserved
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Max Reitz <mreitz@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sascha Silbe <silbe@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L6gTAQt08b8PuDTrUhKMh195u6cXK76OE
From: Eric Blake <eblake@redhat.com>
To: Halil Pasic <pasic@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Max Reitz <mreitz@redhat.com>,
 Cornelia Huck <cornelia.huck@de.ibm.com>,
 Sascha Silbe <silbe@linux.vnet.ibm.com>
Message-ID: <0c4a930b-f7a7-0571-c955-01840d75c3e3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] error: error_setg_errno(): errno gets
 preserved
References: <1469611466-31574-1-git-send-email-silbe@linux.vnet.ibm.com>
 <57991CC1.40003@redhat.com> <87twfaysit.fsf@dusky.pond.sub.org>
 <5799E26B.7090408@linux.vnet.ibm.com> <579A1D33.6010500@redhat.com>
 <579A24BE.2060707@linux.vnet.ibm.com> <579A733C.5050306@redhat.com>
 <579B5C49.1040707@linux.vnet.ibm.com>
 <8b7d3287-90c4-6a07-894c-e9c32fd4567f@redhat.com>
 <e1305993-ac60-d965-16cd-281919825ff6@linux.vnet.ibm.com>
In-Reply-To: <e1305993-ac60-d965-16cd-281919825ff6@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/09/2017 12:27 PM, Halil Pasic wrote:

>>> I still do
>>> not understand why were you wrong there. In fact, I could argue that =
you
>>> were right, but I'm afraid the argument would be somewhat lengthy and=

>>> confusing, and I'm already feeling bad about taking so much of your t=
ime
>>> with this. Since I'm  admittedly quite inexperienced in this field I
>>> decided to just accept your the conclusion you and the POSIX guys
>>> reached -- without fully understanding it.
>>
>> The C99 standard is annoying in that it does not use the usual RFC
>> wording, so where C99 uses "may", many other standards (including POSI=
X)
>> use "shall" or even "shall only".  So the fact that C99 states that "T=
he
>> value of errno may be set to nonzero by a library function call" is a
>> requirement that C can permit arbitrary modification of errno ONLY aft=
er
>> a function call, and not for any other reason (including after a macro=

>=20
> Thanks for the clarification. As a non-native speaker I find that usage=

> of "may" highly non-intuitive. Especially since in chapter 4.
> "Conformance" (from n1124) does define how "shall" and "shall not" but
> there is nothing on "may".
>=20
> This way of saying macros expand to stuff that does not touch errno is
> IMHO quite unfriendly (if this was really the intention - I think it is=

> quite likely that it was), and IMHO a more straight forward formulation=

> would benefit the standard.

Sadly, I'm not responsible for the wording in the C standard; I also
find it confusing sometimes, even as a native speaker.

>=20
> Thank you very much for making your point clear. I take away: "The valu=
e
> of errno may be set to nonzero by a library function call" also
> means/implies 'use of any library entity, which was not specified as a
> library function, shall not set errno to nonzero'.  This really helps m=
e
> a lot because it answers the question which part of the standard
> prohibits the va_* macros from clobbering errno.

Or better: "Use of any library entity which was not specified as a
library function shall not modify errno".  While most interfaces in the
library are functions (because they have required linkage) and may also
be a macro, there are some (like assert() and the va_* macros) which are
explicitly documented to be macros only.

>=20
> I see this primarily as a C ISO standard problem, so I'm reluctant to
> necro-bump that bug in order to start a discussion about how the C
> standard is to be interpreted.  I'm going to ask some friends if it is
> only me who finds it difficult to read that sentence as you propose.

Yes, you are probably right that raising an issue with the C authors may
be the best path forward on this topic, as it is certainly getting
beyond the bounds of what qemu cares about.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--L6gTAQt08b8PuDTrUhKMh195u6cXK76OE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYc/0SAAoJEKeha0olJ0NqJeAH/REDmlKyY758b9Mj+C+nfewq
eRpIB2xRNAn/gh4NKjfAsRHfpYCf8NgWFGQZKzT0m2brq9AToMYR8chXSjoirtHI
jxBqdpB9Zy54VsD0awlmh8KD4ojHKF6UK1c5/GSNKgNVfJ7OaDSX9pq3eCKBdlXx
fL/6Ysa2Sjk0bYOOiZ8JbTiInEmjrLhAZWioOlxraXzkL3WyJbh6OjIYK+dm9xrU
OreoOQ2mcoKTO/p0N/W+DhTB4Ad85rSW8i/yfvLQy2Z/49jUC3X7NPFmYajcAIQP
3oYgVQsPy6t+VWyIejSVkOrrRpFndkWVeQgl+YavDEklr0LXq+L4rXd8q4Fp6SI=
=Qp3u
-----END PGP SIGNATURE-----

--L6gTAQt08b8PuDTrUhKMh195u6cXK76OE--
