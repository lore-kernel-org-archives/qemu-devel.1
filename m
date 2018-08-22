Received: from eggs.gnu.org ([2001:4830:134:3::10]:35442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsRh8-0000ZD-NZ
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 07:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsRh8-0000vN-0z
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 07:53:02 -0400
From: Max Reitz <mreitz@redhat.com>
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-4-jsnow@redhat.com>
	<7c836fb4-c6f4-b590-11ef-6aadb8bc169a@redhat.com>
Message-ID: <bd4dc120-2fb2-fc4d-c11f-d79631eb7c16@redhat.com>
Date: Wed, 22 Aug 2018 13:52:50 +0200
MIME-Version: 1.0
In-Reply-To: <7c836fb4-c6f4-b590-11ef-6aadb8bc169a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UeJUKhTDdpTRCnC3PYV5adayFEPHUxcll"
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
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UeJUKhTDdpTRCnC3PYV5adayFEPHUxcll
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com
Message-ID: <bd4dc120-2fb2-fc4d-c11f-d79631eb7c16@redhat.com>
Subject: Re: [PATCH 3/7] jobs: add exit shim
References: <20180817190457.8292-1-jsnow@redhat.com>
 <20180817190457.8292-4-jsnow@redhat.com>
 <7c836fb4-c6f4-b590-11ef-6aadb8bc169a@redhat.com>
In-Reply-To: <7c836fb4-c6f4-b590-11ef-6aadb8bc169a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-22 13:43, Max Reitz wrote:

[...]

> I'd like .main_loop_settle().  Or .main_loop_post_run().  I think it's
> OK to have names that aren't as cool and tense as possible, when in
> return they actually tell you what they're doing.  (Sure,
> .main_loop_post_run() sounds really stupid, but it tells you exactly
> when the function is called and what it's for.)

Looking at the next patch, I realized that .main_loop_complete() or
=2Ecomplete_in_main_loop() would work just as well.  (No, I don't see any=

confusion with whether you need to call job_completed(), especially
since after this series you can probably make that function static to
job.c.)

Max


--UeJUKhTDdpTRCnC3PYV5adayFEPHUxcll
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt9TpIACgkQ9AfbAGHV
z0DXnwf/ZwjqRL5UUbMwAi3q09vQuOAwF9WKErgOKHNI2SabkEoU850lPTOW/ZZz
HZpLUeL6nNwYHwtPp0J1v7MnkwA+wdb0YGuponWRXeoPbkPOXuhl1763Tm0YcXPE
Qpx/sPsEIJ9cBAkulgNgCmsaFGtT72EMzoTo5oXnckQJcCxovIcA4F3dGQHpyNWN
ysB5mOp7dhdhgiUy2xLIKTbnX+h6Eyk+2fGDTysTU9dRSh9MWOHnlThcXwx06djH
UEChbxZy6pVwGiVBIafFhSx7sVC8e51HLh1LL9Bwrm9rl6pMQ2SfZE7tMgGL42XE
KGsURLkwqjenuzR/MRan4ESdDlckoA==
=vjRi
-----END PGP SIGNATURE-----

--UeJUKhTDdpTRCnC3PYV5adayFEPHUxcll--
