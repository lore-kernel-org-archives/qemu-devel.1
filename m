Received: from eggs.gnu.org ([2001:4830:134:3::10]:58875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXdRQ-0003Ux-0u
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 21:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXdRM-0008QE-0S
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 21:06:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXdRL-0008Pu-Nz
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 21:06:11 -0400
References: <20170628204452.41230-1-raj.khem@gmail.com>
	<CAFEAcA-N3Ve8GmX6Yq+Kbng8vExe3CzDT_2_07JML8QC2xVwDA@mail.gmail.com>
	<20170629131807.GD32167@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aadcb5f0-410a-94a5-ddd9-0933e32bd871@redhat.com>
Date: Tue, 18 Jul 2017 20:06:07 -0500
MIME-Version: 1.0
In-Reply-To: <20170629131807.GD32167@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="l02knDem3DajFPvisck5OmFk9G8xbX3iB"
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
To: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Khem Raj <raj.khem@gmail.com>, Kamil Rytarowski <kamil@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l02knDem3DajFPvisck5OmFk9G8xbX3iB
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio
 <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Khem Raj <raj.khem@gmail.com>, Kamil Rytarowski <kamil@netbsd.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aadcb5f0-410a-94a5-ddd9-0933e32bd871@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] replace struct ucontext with ucontext_t type
References: <20170628204452.41230-1-raj.khem@gmail.com>
 <CAFEAcA-N3Ve8GmX6Yq+Kbng8vExe3CzDT_2_07JML8QC2xVwDA@mail.gmail.com>
 <20170629131807.GD32167@redhat.com>
In-Reply-To: <20170629131807.GD32167@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/29/2017 08:18 AM, Daniel P. Berrange wrote:
> On Thu, Jun 29, 2017 at 10:05:13AM +0100, Peter Maydell wrote:
>> On 28 June 2017 at 21:44, Khem Raj <raj.khem@gmail.com> wrote:
>>> The ucontext_t type had a tag struct ucontext until now
>>> but newer glibc will drop it so we need to adjust and use
>>> the exposed type instead
>>
>> If true this seems like a bug in glibc to break
>> existing working programs, and it should be fixed there...
>=20
> The glib commit message indicates it is intentional change, in order
> to get POSIX compliance:
>=20
>   https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;h=3D251287734e89=
a52da3db682a8241eb6bccc050c9
>=20
> NB, other parts of QEMU like the coroutine code are already
> using the 'ucontext_t' typedef, so attaining consistency across
> files is good regardless of the glibc change.

I agree. And since the issue has been reposted, I support the fix,
although Nathaniel's repost may have the better commit message.
https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06005.html

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--l02knDem3DajFPvisck5OmFk9G8xbX3iB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllusH8ACgkQp6FrSiUn
Q2qJfAf/SLERV9RkcJfAnbCg71scKcblSJIyqLFcXNdgwsRJ8hD7SVmjJq2+jYdf
8XWbn/levm4ZCFK7wPoTtxXnmw9f982c5shZ589XVWLbl8iszpjcZwae6Q7Z19Go
6mOBLtEB1b/u6Y+bpPLQE/975F8p9gHB137idhqOBtksK4l5+w4T+n7dkvyIqp4N
EQb27iE+bO7IqGUg6scCqROOCe1cr82tlkNcuQat2YiOSX+XH+x+qoU87cuaT07b
IpAlajZWeeLxCINohgaNJ1A9dakHXzDMY3fe4+C2q77XrjTaTol8/R4gwN5nxpqV
bAT2i1vsVVpF/k9TzOKcBZTDtx1lKQ==
=ONth
-----END PGP SIGNATURE-----

--l02knDem3DajFPvisck5OmFk9G8xbX3iB--
