Received: from eggs.gnu.org ([2001:4830:134:3::10]:42311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpg4a-0001cP-MC
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 15:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpg4W-0003iF-EG
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 15:33:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpg4W-0003hO-5R
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 15:33:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 379C55F7AE
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 19:33:10 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-2-eblake@redhat.com>
	<f00ee153-b5e8-a95d-8d45-3ec9867dfb5d@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0d39cd85-a721-4883-573a-50d64a2d4b99@redhat.com>
Date: Wed, 6 Sep 2017 14:33:08 -0500
MIME-Version: 1.0
In-Reply-To: <f00ee153-b5e8-a95d-8d45-3ec9867dfb5d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2I3KkuOftaVSkfg7bWWeBreMlPuihwLDm"
Subject: Re: [Qemu-devel] [PATCH v6 01/29] tests: Improve .gitignore for
 tests/multiboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2I3KkuOftaVSkfg7bWWeBreMlPuihwLDm
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, Kevin Wolf <kwolf@redhat.com>
Message-ID: <0d39cd85-a721-4883-573a-50d64a2d4b99@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 01/29] tests: Improve .gitignore for
 tests/multiboot
References: <20170901180340.30009-1-eblake@redhat.com>
 <20170901180340.30009-2-eblake@redhat.com>
 <f00ee153-b5e8-a95d-8d45-3ec9867dfb5d@redhat.com>
In-Reply-To: <f00ee153-b5e8-a95d-8d45-3ec9867dfb5d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/04/2017 09:03 AM, Thomas Huth wrote:
> On 01.09.2017 20:03, Eric Blake wrote:
>> Right now, tests/multiboot is not run by default during 'make check';
>> but when it is run in-tree, it was leaving some junk behind that could=

>> accidentally get checked in with a careless 'git add tests'.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  tests/.gitignore | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tests/.gitignore b/tests/.gitignore
>> index fed0189a5a..64ecd6683b 100644
>> --- a/tests/.gitignore
>> +++ b/tests/.gitignore
>> @@ -10,6 +10,8 @@ check-qnull
>>  check-qstring
>>  check-qom-interface
>>  check-qom-proplist
>> +multiboot/test.out
>=20
> Your patch is of course a good idea ... but that test.out smells quite
> bad ... I guess it should (a) use mktemp for a better file name instead=

> so that we can run this in parallel and (b) clean up the temporary file=

> once the test has been done?

Indeed, making multiboot better, and run by default under 'make check',
is a better task than just tweaking .gitignore, but one orthogonal
enough to my libqtest changes that I will save this patch (and 2/29) for
another series (or if someone else wants to tackle it first).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2I3KkuOftaVSkfg7bWWeBreMlPuihwLDm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmwTXQACgkQp6FrSiUn
Q2rqeQf/U5ZAJMHCqz5BO66JCK7q6SCop9e4CzYMzWFxKcHEiBvTFOtBWBFCJooO
VKS6lyhdPjCKayTgyivyFCNQ7LQxgWYDpNpwV8/7qKDzUQFuEkgEh9VQtg4aUNIc
RbpzSKYc6YIaSiS5t6ryhxYxDHllZV7/FJ597E3T7KgyH0M+PEPwJ35HNWh4nj3h
9UHsb1vOrkRaRWBKUECR3khD1t+E7TWqtZRPAYR7U77S5+/YhcgNzM4BUxEgv4Av
2BVABSiNXaEmqtwLGzEmfHi3rex6mQaSiVIUOjqVjZN+L3HYa7/YCy7GvDqohY8t
p8hfw5jztD6m0f064B2bgy/gKha37g==
=rp+S
-----END PGP SIGNATURE-----

--2I3KkuOftaVSkfg7bWWeBreMlPuihwLDm--
