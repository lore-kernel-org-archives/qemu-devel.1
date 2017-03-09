Received: from eggs.gnu.org ([2001:4830:134:3::10]:50771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cloZC-0005Bq-BF
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 22:16:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cloZ9-0000i7-62
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 22:16:38 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1cloZ8-0000ht-Qm
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 22:16:35 -0500
Received: by mail-pg0-x243.google.com with SMTP id b5so5283544pgg.1
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 19:16:34 -0800 (PST)
References: <20170308124955.35623-1-aik@ozlabs.ru>
	<CAFEAcA_pq6cUVVqzg0in-QTKngsf2cSpzpaGnP=gH5X2GnzOQQ@mail.gmail.com>
	<4c8ab05b-9e6d-10db-6480-e6b58d3ca390@ozlabs.ru>
	<20170309013150.GK19967@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <bbeb8cfe-5468-62f0-ee5a-e390975d5284@ozlabs.ru>
Date: Thu, 9 Mar 2017 14:16:28 +1100
MIME-Version: 1.0
In-Reply-To: <20170309013150.GK19967@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PdGT099J92qRNBDGqEhm9gDOA8w6nEguD"
Subject: Re: [Qemu-devel] [RFC PATCH qemu] dtc: Allow compiling with old gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PdGT099J92qRNBDGqEhm9gDOA8w6nEguD
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Message-ID: <bbeb8cfe-5468-62f0-ee5a-e390975d5284@ozlabs.ru>
Subject: Re: [RFC PATCH qemu] dtc: Allow compiling with old gcc
References: <20170308124955.35623-1-aik@ozlabs.ru>
 <CAFEAcA_pq6cUVVqzg0in-QTKngsf2cSpzpaGnP=gH5X2GnzOQQ@mail.gmail.com>
 <4c8ab05b-9e6d-10db-6480-e6b58d3ca390@ozlabs.ru>
 <20170309013150.GK19967@umbus.fritz.box>
In-Reply-To: <20170309013150.GK19967@umbus.fritz.box>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 09/03/17 12:31, David Gibson wrote:
> On Thu, Mar 09, 2017 at 11:52:17AM +1100, Alexey Kardashevskiy wrote:
>> On 09/03/17 01:21, Peter Maydell wrote:
>>> On 8 March 2017 at 13:49, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:=

>>>> After 6e85fce0225f "dtc: Update requirement to v1.4.2" QEMU stopped
>>>> compiling in CentOS7:
>>>>
>>>> In file included from /home/aik/p/qemu/dtc/libfdt/libfdt.h:54:0,
>>>>                  from /home/aik/p/qemu/device_tree.c:30:
>>>> /home/aik/p/qemu/dtc/libfdt/libfdt_env.h:64:0: error: "__bitwise" re=
defined [-Werror]
>>>>  #define __bitwise
>>>>  ^
>>>> In file included from /usr/include/asm/ptrace.h:27:0,
>>>>                  from /usr/include/asm/sigcontext.h:11,
>>>>                  from /usr/include/bits/sigcontext.h:27,
>>>>                  from /usr/include/signal.h:340,
>>>>                  from /home/aik/p/qemu/include/qemu/osdep.h:86,
>>>>                  from /home/aik/p/qemu/device_tree.c:14:
>>>> /usr/include/linux/types.h:21:0: note: this is the location of the p=
revious definition
>>>>  #define __bitwise __bitwise__
>>>>  ^
>>>> cc1: all warnings being treated as errors
>>>> make: *** [device_tree.o] Error 1
>>>> make: *** Waiting for unfinished jobs....
>>>>
>>>> The reason is that CentOS7 comes with libfdt 1.4.0 so QEMU tries usi=
ng
>>>> the internal one which does not compile as CentOS7 comes with gcc v4=
=2E8.5
>>>> which reports warnings which it would not if the OS's libfdt was use=
d
>>>> (libfdt_env.h has not changed between 1.4.0 and 1.4.2).
>>>>
>>>> gcc 6.2.0 from Ubuntu v16.10 handles this fine.
>>>>
>>>> This replaces -I with -isystem to suppress the warning (which turns
>>>> to an error because of -Werror).
>>>
>>> Thanks for the bug report. I think it would be cleaner to fix this
>>
>> Agree.
>>
>>> by fixing the problem upstream in libfdt and then moving our
>>> submodule forward to the fixed version. (libfdt should not be
>>> defining __ prefixed symbols as these are reserved for the
>>> system.)
>=20
> Yes.  I've now fixed this in upstream libfdt, at Paolo's suggestion.
> Unfortunately, it came just after the 1.4.3 release.  I was just leery
> about making a new release and qemu pull so soon after the last one.
> Should I do that anyway?
>
>> Also agree, regardless my proposal, libfdt should be fixed. However v2=
=2E9
>> won't compile on CentOS7 (and I suppose on RHEL7) which is a bit annoy=
ing.
>> And having "-isystem" makes some sense as these headers are normally s=
ystem
>> ones and I'd think they should be treated the same way (i.e. path shou=
ld be
>> included via -isystem vs. -I).
>=20
> I'm not really clear on why -isystem fixes this problem anyway.

I believe it is a workaround as if all warnings were enabled, than many
(many) system headers would have triggered warnings because many have not=

changed for quite a while and do not keep up with the actual gcc version.=

"-isystem" tells gcc where it can relax warnings.

Pretty much like moving from older Microsoft Visual Studio to a newer one=

would produce thousands warnings in my files (but not in system ones),
mostly about "deprecated" stuff but they could afford this as they ship
both the compiler and the standard library in one package :)


--=20
Alexey


--PdGT099J92qRNBDGqEhm9gDOA8w6nEguD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYwMkMDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5mWYQAL6h
F0N+QlUcaYf5/NiWtIzD4AlnruoC2SgepKYpohDYbKa28n8v/Vg5Q9FSaUysL89W
AnbuJBcGfAgDUlT5mZZbDLu7oiv2cxmlWnuhoPIDIpKwyfJvwrLa3al3fxiu4rvn
yDnay7a+q1G7l4EIMGidAlpC7QpS84xp56DM5lKhYGNWUbDdyz5tdmg4cmyCeyx+
4E523wvszKOaAAXX9ORa4uyfdA6fAbJRpHHUMkIm9Z3MF6m4lcDPwHGmcbilB+86
livIo4k/IlHh8FvH6Aukb/V4P+A5KzJ1b6BTuImzDnK+hLY9AJUSx6KBPLVId5l5
RZJBXo7h9riVqtUPzhImZrDR3PwmW7h5+L5LLXp91Eimfp6b2bed6VxPyIyvhHEF
YvWBTRQFbr2Y2APBWDWzN4rpoctz5HCp/lfDy87cn2jyhtZRf6s8IakPJUe7I0a2
FiXSJavMHR2CvWmxiFB1D5VtFZWiUeMygVaAAsxG0SfdD8CUJqt3cRfmu4jFPuyV
4LmzlAUbuLmeklH59rojLlh7favwHZtH/rUQHO8bJ1qUBW8GMBWXiDSDITV5W1kc
zF2/dHAi2VQFMfJrZiar/kzbzM5dsLZ7YPypYcViAT9hJfNqdfkeAz8RSWHZpaQ1
cSGkbEiN4HCjYE0sgC12nkN8tbfkaP8chF4+A9Q0
=T9dB
-----END PGP SIGNATURE-----

--PdGT099J92qRNBDGqEhm9gDOA8w6nEguD--
