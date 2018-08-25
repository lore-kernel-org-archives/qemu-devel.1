Received: from eggs.gnu.org ([2001:4830:134:3::10]:37360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ftYDn-0001P7-88
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ftY5L-0004vU-TT
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 08:54:36 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-4-jsnow@redhat.com>
	<7c836fb4-c6f4-b590-11ef-6aadb8bc169a@redhat.com>
	<bd4dc120-2fb2-fc4d-c11f-d79631eb7c16@redhat.com>
	<d6c3b676-2fa2-f4e3-439a-93785827579f@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b6ece610-27f2-433d-3eea-4702b9381af6@redhat.com>
Date: Sat, 25 Aug 2018 14:54:18 +0200
MIME-Version: 1.0
In-Reply-To: <d6c3b676-2fa2-f4e3-439a-93785827579f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HweOPp0QFPPlbFHSORwlnIk1NCBHinUiO"
Subject: Re: [Qemu-devel] [PATCH 3/7] jobs: add exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HweOPp0QFPPlbFHSORwlnIk1NCBHinUiO
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com
Message-ID: <b6ece610-27f2-433d-3eea-4702b9381af6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/7] jobs: add exit shim
References: <20180817190457.8292-1-jsnow@redhat.com>
 <20180817190457.8292-4-jsnow@redhat.com>
 <7c836fb4-c6f4-b590-11ef-6aadb8bc169a@redhat.com>
 <bd4dc120-2fb2-fc4d-c11f-d79631eb7c16@redhat.com>
 <d6c3b676-2fa2-f4e3-439a-93785827579f@redhat.com>
In-Reply-To: <d6c3b676-2fa2-f4e3-439a-93785827579f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-22 23:45, John Snow wrote:
>=20
>=20
> On 08/22/2018 07:52 AM, Max Reitz wrote:
>> On 2018-08-22 13:43, Max Reitz wrote:
>>
>> [...]
>>
>>> I'd like .main_loop_settle().  Or .main_loop_post_run().  I think it'=
s
>>> OK to have names that aren't as cool and tense as possible, when in
>>> return they actually tell you what they're doing.  (Sure,
>>> .main_loop_post_run() sounds really stupid, but it tells you exactly
>>> when the function is called and what it's for.)
>>
>> Looking at the next patch, I realized that .main_loop_complete() or
>> .complete_in_main_loop() would work just as well.  (No, I don't see an=
y
>> confusion with whether you need to call job_completed(), especially
>> since after this series you can probably make that function static to
>> job.c.)
>>
>> Max
>>
>=20
> I'm sorry to announce that after the part two of this series, the
> callback will be erased completely, so the name is maybe less... import=
ant.

That's what I get for not reading the cover letter.

Max


--HweOPp0QFPPlbFHSORwlnIk1NCBHinUiO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluBUXoACgkQ9AfbAGHV
z0BO2AgAvsonHor0TNw+kGfN7mQyrr0Rt8sLjdtit+3C0q9LNArd+/YYmOWzOlU1
1Pjk+NaYZUGzemQzqiV/QoQ5NUPc2QF5+zYTGUYZ20l4UrgAkR8vVmrl75VY7RH7
8/qvQVijuO4EdwhYq+4KRz65Y8xw1kYrqGOXixHMroWOS3EeTkp3lUw7NzhyGQiD
4HT4k1O+6vPcDHBKtiJnaGYHbjxPfvP1Z6BtdfBsnpuQDp+ZIXKNSLcz605bsKoL
n6awQB1MrTrs+6K8h+58sp7LxcWtMUTxLVLE2aaBbDjxHk8f7K9HRlMX3SEtXCp1
57N3TXmOYGqser020nqMMR49PiESPg==
=Lfvw
-----END PGP SIGNATURE-----

--HweOPp0QFPPlbFHSORwlnIk1NCBHinUiO--
