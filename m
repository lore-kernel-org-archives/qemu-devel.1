Received: from eggs.gnu.org ([2001:4830:134:3::10]:40252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBiC1-0000JW-BM
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBiBx-0001JU-Cx
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:48:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39264 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBiBx-0001J3-66
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:48:13 -0400
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-7-lersek@redhat.com>
	<8736zjagg3.fsf@dusky.pond.sub.org>
	<4509705a-43b2-db40-aa24-18eff649e750@redhat.com>
	<87sh7i4h5y.fsf@dusky.pond.sub.org>
	<ea646e6d-9512-559d-be8d-fd3c754cc301@redhat.com>
	<136c5d3a-9d5b-eb15-a1f4-18150662144b@redhat.com>
	<87vacexcir.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <230b57bf-1bf0-fd4e-05bf-cb7c4902975d@redhat.com>
Date: Thu, 26 Apr 2018 09:48:03 -0500
MIME-Version: 1.0
In-Reply-To: <87vacexcir.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PCaj6SDOWHYOavaWCQmWbJvB0xtLFMHAN"
Subject: Re: [Qemu-devel] [PATCH 6/6] qapi: discriminate CpuInfo[Fast] on
 SysEmuTarget, not CpuInfoArch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PCaj6SDOWHYOavaWCQmWbJvB0xtLFMHAN
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Message-ID: <230b57bf-1bf0-fd4e-05bf-cb7c4902975d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/6] qapi: discriminate CpuInfo[Fast] on
 SysEmuTarget, not CpuInfoArch
References: <20180424214550.32549-1-lersek@redhat.com>
 <20180424214550.32549-7-lersek@redhat.com>
 <8736zjagg3.fsf@dusky.pond.sub.org>
 <4509705a-43b2-db40-aa24-18eff649e750@redhat.com>
 <87sh7i4h5y.fsf@dusky.pond.sub.org>
 <ea646e6d-9512-559d-be8d-fd3c754cc301@redhat.com>
 <136c5d3a-9d5b-eb15-a1f4-18150662144b@redhat.com>
 <87vacexcir.fsf@dusky.pond.sub.org>
In-Reply-To: <87vacexcir.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2018 09:34 AM, Markus Armbruster wrote:
>>
>> Acerbic discovery of the day: @CpuInfoArch has "x86", while configure
>> produces:
>>
>>   TARGET_NAME  TARGET_BASE_ARCH
>>          i386              i386
>>        x86_64              i386
>>
>> Note how "i386" does not match "x86".
>=20
> Review fail.
>=20
> Just three weeks ago, we could still have fixed query-cpus-fast...

Actually, I think we still can.  We already documented in the 2.12
release notes that the "arch" field of query-cpus-fast is known to be
broken for all but "s390x" (which is really the only arch field that
MUST be correct, as that is the only time we send additional
information).  And introspection can easily see both the enum contents
(if we add something) as well as any other additions to the
query-cpus-fast output union (although that is less likely), to use
those as a witness for whether qemu is new enough to have fixed the
bogus "arch" values.  I'd argue that if we change things right now, with
intent to include the change in 2.12.1, before people start relying on
the bogus "arch" of 2.12, then we should feel free to make
query-cpus-fast output whatever we want for all architectures other than
"s390x", even if it changes the current output of "x86".

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PCaj6SDOWHYOavaWCQmWbJvB0xtLFMHAN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrh5qMACgkQp6FrSiUn
Q2o1wQf/SQ/iGe6y+ULVcHG3jbMTvbR5rbdS/JhSrlJ6hnuFm0Q7eSUdBPrbLBwP
NL2f/YJ91639WqR+OKiARKXbP9I/HOusW71jIZr50c1d2g8Cxm4aRpBRAirdy4kT
GxLe84oi5wdj/SFM78gHZeb9CqTaCjKQcYGC3rWI+mW8UDkx9AXlslJPIwZ7CLLC
2rv3F4QJEy+FPFXqyGU6NUkFbzjv5EJhO/YdH3pUL6+8puZdqCxmhyNJJIYphHxM
fSTK5FgkOLb+CDXS3GOaVXvKGnvbYpkxU656xqJWWc/+CTFF/hVdrzfosDp2yG3y
d2bcKdRWAVvL1Ozsnl2cNpyXwt78Qg==
=Ola7
-----END PGP SIGNATURE-----

--PCaj6SDOWHYOavaWCQmWbJvB0xtLFMHAN--
