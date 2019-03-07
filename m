Received: from eggs.gnu.org ([209.51.188.92]:39931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1yKH-0000Td-Fl
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:05:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1yKG-0008RD-Lt
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:05:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h1yKG-0008Pp-A7
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:05:04 -0500
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
	<62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
	<CAMxuvaxeAdZKk_CQOyqCJdd_1kVZEBPCm0LRoP2u9aijOtbDxg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c0e04289-3373-3a56-b367-0d6033c52789@redhat.com>
Date: Thu, 7 Mar 2019 13:04:59 -0600
MIME-Version: 1.0
In-Reply-To: <CAMxuvaxeAdZKk_CQOyqCJdd_1kVZEBPCm0LRoP2u9aijOtbDxg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VKoNvbatrLGYSF9qj1erpbPcpHgabHO1q"
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VKoNvbatrLGYSF9qj1erpbPcpHgabHO1q
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Message-ID: <c0e04289-3373-3a56-b367-0d6033c52789@redhat.com>
Subject: Re: [Qemu-devel] converting build system to Meson?
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
 <87r2bigarf.fsf@zen.linaroharston>
 <a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
 <CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
 <62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
 <CAMxuvaxeAdZKk_CQOyqCJdd_1kVZEBPCm0LRoP2u9aijOtbDxg@mail.gmail.com>
In-Reply-To: <CAMxuvaxeAdZKk_CQOyqCJdd_1kVZEBPCm0LRoP2u9aijOtbDxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/7/19 12:17 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Thu, Mar 7, 2019 at 7:13 PM Paolo Bonzini <pbonzini@redhat.com> wrot=
e:
>>
>> On 07/03/19 14:09, Peter Maydell wrote:
>>> On Thu, 7 Mar 2019 at 12:56, Paolo Bonzini <pbonzini@redhat.com> wrot=
e:
>>>> In any case, this wouldn't change; as you suggest below, configure c=
ould
>>>> remain as a front-end (well, in-srcdir builds are not supported by
>>>> Meson, so "../configure && ninja" perhaps).
>>>
>>> As an aside, it might be a nice idea to drop the in-srcdir
>>> build altogether for QEMU anyway -- it's not really a very
>>> good idea and it means our build system has to cope with two
>>> different ways of working to no particularly useful end.
>>
>> I was actually going to propose that, but I was afraid of throwing two=

>> bombs in the same day. :)
>=20
> As someone who has also been annoyed having to support in-tree and
> out-of-tree, I support that move. I used to be a pretty happy use of
> in-tree builds, but out-of-tree his generally equally convenient.
>=20
> Who is volunteering to do patches to deprecate the support? warning in
> 4.0, and error in 4.1?

How you build only affects developers, so I don't see this as needing to
go through the usual qemu-deprecated.texi rules - we just get enough
developers to agree to it, then have a flag day (and hopefully a sane
enough patch to make an incremental in-tree build complain loudly, but
with clear instructions that can be copied-and-pasted to turn into a
clean VPATH build).

I don't mind a switch to mandatory out-of-tree builds (I like the
convenience of in-tree for quick hacks, but VPATH is infinitely more
flexible when testing multiple build configurations in parallel, and
I've worked on other projects with mandatory VPATH builds without seeing
too many complaints there).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--VKoNvbatrLGYSF9qj1erpbPcpHgabHO1q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyBa1sACgkQp6FrSiUn
Q2oytQf6A4PjLkjM1yfpLIUR1TxrJiAjhHO/tJeDa78zRAOC73ay/KsoydRwkcov
tjLJXQVDPUOkFe1DkXTf8HE+/0whKqbhuqEB0QJGPH99WyzS05ukIdfzhiESXBCK
PdMXBgKBOQOU1MaQMqqUBRg4Dw5/WB4jhI0EfKuDqlqr+qB7EmEvgvWZmxrf+mQf
ga677RC0QsnHpym3Glx9PWmC4YMTT+as/i0nt7HYJRt7HEeEVd1fWxC0nTiqpy6f
e04OvNOH760cyeZYd1DFefsc4HaJcFRbHMo0/+3G3GCy9xOgeXAtt0kXoNURQm56
YQoybTx5BTecYviKwCm5b8kmczPC1g==
=A4dj
-----END PGP SIGNATURE-----

--VKoNvbatrLGYSF9qj1erpbPcpHgabHO1q--
