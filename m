Received: from eggs.gnu.org ([2001:4830:134:3::10]:58860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5ttd-0004eU-IQ
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 10:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5tta-0005KW-1C
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 10:05:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38128 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f5ttZ-0005Jc-Bq
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 10:05:13 -0400
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-18-git-send-email-cota@braap.org>
	<37e6c5c3-dc83-c557-658a-901485e20e19@linaro.org>
	<20180410125904.GA22304@flamenco>
From: Eric Blake <eblake@redhat.com>
Message-ID: <af72f45e-f6e5-9c29-4325-bc1fdfc37987@redhat.com>
Date: Tue, 10 Apr 2018 09:05:06 -0500
MIME-Version: 1.0
In-Reply-To: <20180410125904.GA22304@flamenco>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7aZ8aw7MLTCLmxHluossinh2VvHBJHTpb"
Subject: Re: [Qemu-devel] [PATCH v2 17/17] target/riscv: convert to
 TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7aZ8aw7MLTCLmxHluossinh2VvHBJHTpb
From: Eric Blake <eblake@redhat.com>
To: "Emilio G. Cota" <cota@braap.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>,
 qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>
Message-ID: <af72f45e-f6e5-9c29-4325-bc1fdfc37987@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 17/17] target/riscv: convert to
 TranslatorOps
References: <1523038800-2494-1-git-send-email-cota@braap.org>
 <1523038800-2494-18-git-send-email-cota@braap.org>
 <37e6c5c3-dc83-c557-658a-901485e20e19@linaro.org>
 <20180410125904.GA22304@flamenco>
In-Reply-To: <20180410125904.GA22304@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2018 07:59 AM, Emilio G. Cota wrote:
> On Tue, Apr 10, 2018 at 11:24:37 +1000, Richard Henderson wrote:
>> On 04/07/2018 04:20 AM, Emilio G. Cota wrote:
>>> +        next_page =3D (ctx->base.pc_first & TARGET_PAGE_MASK) + TARG=
ET_PAGE_SIZE;
>>> +        if (ctx->base.pc_next >=3D next_page) {
>>
>> This fails for the last page of the address space.
>> Better is
>>
>>   page_start =3D ctx->base.pc_first & TARGET_PAGE_MASK;
>>   if (ctx->base.pc_next - page_start >=3D TARGET_PAGE_SIZE) {
>=20
> Apart from the variable name change, I fail to see how this (A - B >=3D=
 C)
> is not equivalent to the above (A =3D> B + C). What am I missing?

Integer overflow.  Adding TARGET_PAGE_SIZE might wrap next_page to 0,
which changes the semantics of the conditional; while performing the
subtraction avoids the case of overflow.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7aZ8aw7MLTCLmxHluossinh2VvHBJHTpb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrMxJMACgkQp6FrSiUn
Q2rE6Af+JC8xfoAacsoDHyjM7aSzcyWoYGSWfuFiAsMAf3qphn+qg5XviEQPfty0
Gr3a1DdhlJ3CbOadCl+QlviPb0yEipVyDvfKE6LsHa3XkCYwhHRo5So1BC4C/1Dx
YnOcqydokC85BHOTqKjFO3VRIfDB2BNPLdzU7GSnjutASCfxHfGvegm+wOWohArz
7C6BUcjX9VC02WBhDXkJ1lU7gDD4lhLOCkI50y0oO7zqPrWRLPUYsL+g7vr3J2fN
dPJaZqmLTkaeDuIfP/Ji0i+kFZ7oDqO6o3IelWkp1zH9xZxSGEraB1AUk/CgK6v8
Zu6jYSiNY/ktteOOhSiWpsOWtbXsfA==
=E9E7
-----END PGP SIGNATURE-----

--7aZ8aw7MLTCLmxHluossinh2VvHBJHTpb--
