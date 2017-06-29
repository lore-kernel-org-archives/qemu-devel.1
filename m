Received: from eggs.gnu.org ([2001:4830:134:3::10]:45884)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dQZMi-0007kJ-9t
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dQZMf-0005vh-Jr
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:20:12 -0400
Received: from mout.gmx.net ([212.227.15.19]:54280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dQZMf-0005s3-82
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:20:09 -0400
References: <20170628204452.41230-1-raj.khem@gmail.com>
	<CAFEAcA-N3Ve8GmX6Yq+Kbng8vExe3CzDT_2_07JML8QC2xVwDA@mail.gmail.com>
	<87vanfuecu.fsf@dusky.pond.sub.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <10d75944-0c25-0ae0-aac3-a1b8bb941f58@gmx.com>
Date: Thu, 29 Jun 2017 15:10:53 +0200
MIME-Version: 1.0
In-Reply-To: <87vanfuecu.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6wm9LRMkP6GENJ2OS6JRXhUGwdirDcKSj"
Subject: Re: [Qemu-devel] [PATCH] replace struct ucontext with ucontext_t
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Khem Raj <raj.khem@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>, Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6wm9LRMkP6GENJ2OS6JRXhUGwdirDcKSj
From: Kamil Rytarowski <n54@gmx.com>
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Khem Raj <raj.khem@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Message-ID: <10d75944-0c25-0ae0-aac3-a1b8bb941f58@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] replace struct ucontext with ucontext_t type
References: <20170628204452.41230-1-raj.khem@gmail.com>
 <CAFEAcA-N3Ve8GmX6Yq+Kbng8vExe3CzDT_2_07JML8QC2xVwDA@mail.gmail.com>
 <87vanfuecu.fsf@dusky.pond.sub.org>
In-Reply-To: <87vanfuecu.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.06.2017 15:12, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
>> On 28 June 2017 at 21:44, Khem Raj <raj.khem@gmail.com> wrote:
>>> The ucontext_t type had a tag struct ucontext until now
>>> but newer glibc will drop it so we need to adjust and use
>>> the exposed type instead
>>
>> If true this seems like a bug in glibc to break
>> existing working programs, and it should be fixed there...
>=20
> I'd support that notion.  However, SUSv2 documents ucontext_t, not
> struct ucontext.  Using the former instead of the latter makes sense as=

> a portability improvement, doesn't it?
>=20


NetBSD ships with ucontext_t, no 'struct ucontext' available.
Technically there is 'struct __ucontext', but nobody is allowed to use
it sanely.


--6wm9LRMkP6GENJ2OS6JRXhUGwdirDcKSj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZVPxoAAoJEEuzCOmwLnZsDLwP/jA8G6jl6yF3M704q04VVKtU
WW4dmjbvrTEFKoT6NGwPmTW0uW5zH5+nY7SBc9ZJBaQ/fd1rPxl82HPiwYaCPPlO
b1dupYSTmlpUPDlGKN0ZSy9B6EYYxpKj9LCzjPX+LRS+XbPyXOjDeaq5jSa2hB32
vEK6JQOpA8zAmDDWDtMfAExehU8e5tigmDhd300J/V68bGU6DJ/mOrYnMNnZCpk9
LzdtZ4gUyeYPe3q23hUt5Y8sHXxcdpk+N8gdhfXiKvQOr5/AeJmjld9EJ1UIFonu
QqFj9JTPqx7ixkw5zE+cDuvdNaQYPFY4neFtEMQoj1mFOkp9vsDuDOQztLRq9F6S
j4yI6897WkDl2RQSdjqUun/2vsDDA5gJPsGh+zNkGs0zdpQ6NzqCzBMVrdA1Q55I
SNoxTEq/KJ4xwp9jqQLRVTeDP+Grb1frcshAm5ymFMCessFzdNZYPrQbH2UzPe/a
J9Zt0Gza2lfBrFVIZ5LZRoBX2Un0MhibprO4IGcoHdKHf013K3sqpP/ZK4C11QvO
xTkgBuPf4pT/MMKtBII1AtSXLI2I5r8q+kvcyrWvWGLNzvbBLAYAB1fNUoIz5lsx
gTPBj8H28YpvtZuFCQeOEK9reYhBQ/N4GbRn0IPN0dDwebbnsFN29DwS4CN1152h
TlK5Jfl7za89FR6mc0Dh
=91wI
-----END PGP SIGNATURE-----

--6wm9LRMkP6GENJ2OS6JRXhUGwdirDcKSj--
