Received: from eggs.gnu.org ([2001:4830:134:3::10]:41448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dipMj-0004Rg-Fh
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 18:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dipMg-00081t-9J
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 18:03:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dipMf-00081S-Rv
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 18:03:38 -0400
References: <20170818211542.5380-1-eblake@redhat.com>
	<20170818211542.5380-3-eblake@redhat.com>
	<cb8a8b43-e511-a892-24a7-09cac4836648@amsat.org>
	<d39d17a5-7f78-08e5-ade5-8a173c5f0393@redhat.com>
	<fadc06a9-f00c-c473-7b74-7d0e9369f2cb@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <98eafcc9-10d2-1cb2-54c9-3770262f3890@redhat.com>
Date: Fri, 18 Aug 2017 17:03:35 -0500
MIME-Version: 1.0
In-Reply-To: <fadc06a9-f00c-c473-7b74-7d0e9369f2cb@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XsN0x1w6HClkPeCbwbmNsOVAECvgSXK04"
Subject: Re: [Qemu-devel] [PATCH v5 02/13] qtest: Don't perform side effects
 inside assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XsN0x1w6HClkPeCbwbmNsOVAECvgSXK04
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com
Message-ID: <98eafcc9-10d2-1cb2-54c9-3770262f3890@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 02/13] qtest: Don't perform side effects
 inside assertion
References: <20170818211542.5380-1-eblake@redhat.com>
 <20170818211542.5380-3-eblake@redhat.com>
 <cb8a8b43-e511-a892-24a7-09cac4836648@amsat.org>
 <d39d17a5-7f78-08e5-ade5-8a173c5f0393@redhat.com>
 <fadc06a9-f00c-c473-7b74-7d0e9369f2cb@redhat.com>
In-Reply-To: <fadc06a9-f00c-c473-7b74-7d0e9369f2cb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/18/2017 04:58 PM, Eric Blake wrote:
>> NDEBUG doesn't affect g_assert() (only assert(), but that wasn't in us=
e
>> here) - I have to double-check glib documentation to see whether
>> g_assert() can be crippled in a manner similar to how I know assert()
>> can be crippled.  Ideally, we have a form that always performs side
>> effects exactly once, whether or not abort-on-error is enabled (assert=
()
>> does not have that, but I don't know whether glib does).
>=20
> Per https://developer.gnome.org/glib/stable/glib-Testing.html#g-assert,=

> G_DISABLE_ASSERT has the same compile-time effect on g_assert() as
> NDEBUG on assert().  Even worse, g_assert_not_reached() has the same
> problem.

Oh, and I failed to mention:

g_assert() has the same problem as assert() - when disabled at
compile-time, 'expr' is not evaluated.  If you want legible code (by
including side-effects within your macro that has optional
abort-on-error behavior), then you need some OTHER macro that always
performs the evaluation.  But if you create such a macro, don't use
'assert' in its name.  And I still fail to see why anyone would actually
want to disable abort-on-error behavior - once an assertion has gone
wrong, continuing execution is liable to hit follow-on problems that are
much harder to diagnose than it would have been just quitting at the
assertion failure.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XsN0x1w6HClkPeCbwbmNsOVAECvgSXK04
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmXZDcACgkQp6FrSiUn
Q2pfNAgAjixWxAskToDC/HPAHYQM2RAycwC9vZbSg5pbCgKmX4uFCWY8RHvOJQKn
BuJ57ClqgdvubWRPW2A1XshcVFWtrwAIZVHFPV3E5FCsE+brsxN088lG4UXcIuCL
CSwYiQiXo2/RDrOZLBLHgeqfpuOSFrMhOosu1wlRMJ7oXmKFYFIc8s0+0ppq1n5R
tzJomAOdXHiIZc1vrtE/3YcwhOM/kfd22UNiUjsIXkcAM1ovuIPn6h6j7J5bRgZm
uX555lleF9l3t940kDdgxWQVadCW05gMne3eLBnKXyJKbIXQS8pgCHlRWOOjg/jg
xb1gtM2CpoOXsGC4tv8GrmyF5IplXw==
=w9rb
-----END PGP SIGNATURE-----

--XsN0x1w6HClkPeCbwbmNsOVAECvgSXK04--
