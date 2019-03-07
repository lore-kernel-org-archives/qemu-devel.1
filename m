Received: from eggs.gnu.org ([209.51.188.92]:52803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1z2N-0000vb-0e
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:50:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1z2L-0002A5-Vw
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:50:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h1z2L-00029W-Cc
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:50:37 -0500
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
	<62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
	<CAMxuvaxeAdZKk_CQOyqCJdd_1kVZEBPCm0LRoP2u9aijOtbDxg@mail.gmail.com>
	<CAFEAcA_hqpHfJkXa1SkyOaxdEYPYOOyOX0urRh6X2zYadPprXw@mail.gmail.com>
	<alpine.BSF.2.21.9999.1903072016360.61349@zero.eik.bme.hu>
From: Eric Blake <eblake@redhat.com>
Message-ID: <43b248e1-482a-3073-019c-4fa812dd2bb0@redhat.com>
Date: Thu, 7 Mar 2019 13:50:30 -0600
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1903072016360.61349@zero.eik.bme.hu>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FMNrJb5AT7zEuW0mvN91EBzbiCVbnWAvD"
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FMNrJb5AT7zEuW0mvN91EBzbiCVbnWAvD
From: Eric Blake <eblake@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Message-ID: <43b248e1-482a-3073-019c-4fa812dd2bb0@redhat.com>
Subject: Re: [Qemu-devel] converting build system to Meson?
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
 <87r2bigarf.fsf@zen.linaroharston>
 <a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
 <CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
 <62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
 <CAMxuvaxeAdZKk_CQOyqCJdd_1kVZEBPCm0LRoP2u9aijOtbDxg@mail.gmail.com>
 <CAFEAcA_hqpHfJkXa1SkyOaxdEYPYOOyOX0urRh6X2zYadPprXw@mail.gmail.com>
 <alpine.BSF.2.21.9999.1903072016360.61349@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.9999.1903072016360.61349@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/7/19 1:23 PM, BALATON Zoltan wrote:
> On Thu, 7 Mar 2019, Peter Maydell wrote:
>> On Thu, 7 Mar 2019 at 18:17, Marc-Andr=C3=A9 Lureau
>> <marcandre.lureau@redhat.com> wrote:
>>> As someone who has also been annoyed having to support in-tree and
>>> out-of-tree, I support that move. I used to be a pretty happy use of
>>> in-tree builds, but out-of-tree his generally equally convenient.
>>>
>>> Who is volunteering to do patches to deprecate the support? warning i=
n
>>> 4.0, and error in 4.1?
>>
>> Do we need to bother to deprecate it? It doesn't affect end-users,
>> only those who build QEMU, and the change is easy...
>=20
> If you do this without warning and time for getting used to it, it woul=
d
> be nice to add some convenience functionality if possible to not upset
> people used to in-tree builds too much. That is if someone runs make in=

> the top src dir it should create a build subdir and run make -C in ther=
e
> instead of just returning an error so people can still just run make as=

> now instead of get frustrated every time until get used to use build
> dir. (I sometimes use build dir, sometimes in-tree build and the latter=

> is often more convenient if I don't need multiple separate builds only
> one.)

You might be able to do something like (untested):

echo /GNUMakefile >> .git/info/exclude
cat > GNUMakefile <<\EOF
%: force
	@$(MAKE) -C subdir $@
force: ;

so that 'make blah' in-tree becomes a shim to a default out-of-tree
build location. (You'd need to make it smarter than that to handle a
user invoking 'make -C tests ...', left as an exercise for the reader)

But yes, ideally we'd actually have a proper wrapper Makefile that does
this as part of qemu.git, instead of having to be reinvented by each
developer.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--FMNrJb5AT7zEuW0mvN91EBzbiCVbnWAvD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyBdgcACgkQp6FrSiUn
Q2rHagf/bLngaRzFkVWSywdFoPqw2onaoyqno3CXwTpJqmD3vKnyw4XTBi3/rO+r
1XWCUAFKh/wuTXeWPI9Da5rrMPOhHonnc6W3ugIPsCkDMuzax0CUMGUDEkfXd1iR
XW9B6RDm5FdWfr0rcNt+ZUQOvBWe1Zi3TalkEq2Oe3ixrlnUvKO+LgNgFwqisbbU
r8BDHbHtH5qmBDLEPm4HCXlR5qIM7PhpxofeAxglBU0ebpwpma/aKqU8NJcAZobU
YFJf3l4PMKDGUmMi+oftAcunfJbVtQGOpDiYuWPXk19pTkvtZvL+KlsRdqovXK0o
BLKAjg5tj+JQ3fhyITTYs0EVBtFj/A==
=ExpV
-----END PGP SIGNATURE-----

--FMNrJb5AT7zEuW0mvN91EBzbiCVbnWAvD--
