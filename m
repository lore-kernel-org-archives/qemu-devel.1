Received: from eggs.gnu.org ([2001:4830:134:3::10]:40606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dipHT-00021W-Ad
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dipHQ-0005Bd-5S
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:58:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dipHP-0005BM-Sf
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:58:12 -0400
References: <20170818211542.5380-1-eblake@redhat.com>
	<20170818211542.5380-3-eblake@redhat.com>
	<cb8a8b43-e511-a892-24a7-09cac4836648@amsat.org>
	<d39d17a5-7f78-08e5-ade5-8a173c5f0393@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fadc06a9-f00c-c473-7b74-7d0e9369f2cb@redhat.com>
Date: Fri, 18 Aug 2017 16:58:09 -0500
MIME-Version: 1.0
In-Reply-To: <d39d17a5-7f78-08e5-ade5-8a173c5f0393@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ETiHjt8kEXBvONK1exgrBjfVXviLqGnIR"
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
--ETiHjt8kEXBvONK1exgrBjfVXviLqGnIR
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com
Message-ID: <fadc06a9-f00c-c473-7b74-7d0e9369f2cb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 02/13] qtest: Don't perform side effects
 inside assertion
References: <20170818211542.5380-1-eblake@redhat.com>
 <20170818211542.5380-3-eblake@redhat.com>
 <cb8a8b43-e511-a892-24a7-09cac4836648@amsat.org>
 <d39d17a5-7f78-08e5-ade5-8a173c5f0393@redhat.com>
In-Reply-To: <d39d17a5-7f78-08e5-ade5-8a173c5f0393@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/18/2017 04:39 PM, Eric Blake wrote:
> On 08/18/2017 04:33 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Eric,
>>
>> On 08/18/2017 06:15 PM, Eric Blake wrote:
>>> Assertions should be separate from the side effects, since in
>>> theory, g_assert() can be disabled (in practice, we can't really
>>> ever do that).
>>
>> What about the suggestion on your "Hacks for building on gcc 7 / Fedor=
a
>> 26" series about avoid building without assertions?
>=20
> NDEBUG doesn't affect g_assert() (only assert(), but that wasn't in use=

> here) - I have to double-check glib documentation to see whether
> g_assert() can be crippled in a manner similar to how I know assert()
> can be crippled.  Ideally, we have a form that always performs side
> effects exactly once, whether or not abort-on-error is enabled (assert(=
)
> does not have that, but I don't know whether glib does).

Per https://developer.gnome.org/glib/stable/glib-Testing.html#g-assert,
G_DISABLE_ASSERT has the same compile-time effect on g_assert() as
NDEBUG on assert().  Even worse, g_assert_not_reached() has the same
problem.

Then there is the runtime switch g_test_set_nonfatal_assertions() which
affects the REST of the g_assert_*() family (such as g_assert_cmpint(),
g_assert_true(), g_assert_null()) - but NOT g_assert() proper.  And I
recall Markus has posted in the past about complaining that
g_assert_cmpint() should not be used outside of tests/.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ETiHjt8kEXBvONK1exgrBjfVXviLqGnIR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmXYvEACgkQp6FrSiUn
Q2p09Af/UTVdOvIPgOAfeMVMMjvSRBPUBGuZ2ys3q9RkdcnJOCIBDcjf4xjrXdtw
qHWo0opnquIv9nFu0GL4lhKrmOeopugK+K2XZtgN39aMsoR7oke5awUj/0TmFUfA
bGtDl+HoKIU+B58CLKYUAjTDsGerSPAPCj6sQ/0jN8D9m6ya/zcRWpKVSwErvMnX
h+J3sQAt0qQfmfBuv73TNWYAqQ/fk8vqyQhJ8NnLcTFj6bVDuc+/Q06HIAnIyof2
X6osgZn8GQ+QHZ8YZbfYDdOo9yqsl0kG9sv87SuBLI9MzFoOtBZaqUjgW3SwwgMm
4o1DxJHLt6Q+FQR5I/b0h8P7M8apVQ==
=Edeu
-----END PGP SIGNATURE-----

--ETiHjt8kEXBvONK1exgrBjfVXviLqGnIR--
