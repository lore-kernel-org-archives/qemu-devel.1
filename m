Received: from eggs.gnu.org ([2001:4830:134:3::10]:44103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0sHM-0007Sm-Nb
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 12:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0sHI-0001YN-Mx
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 12:16:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d0sHI-0001XP-Dj
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 12:16:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6221D80F97
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 16:16:23 +0000 (UTC)
References: <20170419144219.20371-1-pbonzini@redhat.com>
	<20170419144219.20371-2-pbonzini@redhat.com>
	<25c60922-5cb3-99c4-dd60-05bf1b6faca4@redhat.com>
	<83bc60d2-c20f-1023-5337-b39b50a7fd6e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3e9385cd-311c-82a9-a123-d5ed2130c559@redhat.com>
Date: Wed, 19 Apr 2017 11:16:22 -0500
MIME-Version: 1.0
In-Reply-To: <83bc60d2-c20f-1023-5337-b39b50a7fd6e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uCqqivwHdCSRfFQFR3lqGWNP8feFxdLAs"
Subject: Re: [Qemu-devel] [PATCH 01/11] blockjob: remove unnecessary check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uCqqivwHdCSRfFQFR3lqGWNP8feFxdLAs
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Message-ID: <3e9385cd-311c-82a9-a123-d5ed2130c559@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/11] blockjob: remove unnecessary check
References: <20170419144219.20371-1-pbonzini@redhat.com>
 <20170419144219.20371-2-pbonzini@redhat.com>
 <25c60922-5cb3-99c4-dd60-05bf1b6faca4@redhat.com>
 <83bc60d2-c20f-1023-5337-b39b50a7fd6e@redhat.com>
In-Reply-To: <83bc60d2-c20f-1023-5337-b39b50a7fd6e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/19/2017 11:12 AM, Paolo Bonzini wrote:
>=20
>=20
> On 19/04/2017 17:48, Eric Blake wrote:
>>>  bool block_job_user_paused(BlockJob *job)
>>>  {
>> Is it worth using some form of attribute((nonnull)) annotations on
>> various functions, to both state our intentions and let compilers help=

>> us catch obvious places where we are violating our intentions?  That's=

>> more of a generic question to all of qemu, and doesn't affect your
>> particular patch, other than your patch is an instance where the
>> annotation would be useful if we wanted to use them.
>=20
> What kind of bug would the compiler catch?  I suppose Coverity would
> catch all of them, and maybe -flto would as well.

Newer gcc is (finally) getting smarts about warning about passing a
known-NULL value to a function parameter marked nonnull; I think Clang
has been doing it for a while.  Coverity definitely flags mismatches
like that.  Other bugs that can be caught include checking a parameter
for NULL after it has already been declared to be non-null.  And if
nothing else, the documentation factor makes it easier for developers to
remember contracts of various functions.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--uCqqivwHdCSRfFQFR3lqGWNP8feFxdLAs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY941WAAoJEKeha0olJ0NqnmgIAKxye6GYaL6iv8EFwKcPMrJe
6bN619nFDfpPWBKRX2BqEDRAVmk2m0KcYZdjEBRDfi3X47joqbqazlw/ayuXbsos
TtI2aQLExeip82Ey4ZFKfgw8uFw8YuYyeBt1lwdc07ySFEppv5owlf/O4yEaAHmB
5G8cO69B1AIq+lBuNGtoqDK219nn9iZeV+S/4EyNz//YGMCBHY0iyhrZ3DWJqXAE
79REhLvvIsS+Al//XPAsFYAIWHtEJD2Jly9JHyq88+XXzTa8goAw1e12tNLUZ0mT
NMxQQpMixvFUNKoS01yBLTzkvIcJgcrSWv0Yn14C9tGWzaH6PzcUTdQhHjQ0Jjs=
=pHvq
-----END PGP SIGNATURE-----

--uCqqivwHdCSRfFQFR3lqGWNP8feFxdLAs--
