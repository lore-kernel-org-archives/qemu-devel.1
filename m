Received: from eggs.gnu.org ([2001:4830:134:3::10]:39587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYfGy-0007hE-HG
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYfGv-0001HQ-Bc
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:15:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYfGu-0001H9-VA
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:15:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A881D85541
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 21:15:39 +0000 (UTC)
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-5-git-send-email-armbru@redhat.com>
	<295a3dcc-5165-cc23-26a2-ffb4d8ccb144@redhat.com>
	<87tw25ag8p.fsf@dusky.pond.sub.org>
	<500db1a0-e7f5-0413-950a-4c9bfbceba06@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <90c0c74e-db30-9f3d-e396-7bdc7872339b@redhat.com>
Date: Fri, 21 Jul 2017 16:15:38 -0500
MIME-Version: 1.0
In-Reply-To: <500db1a0-e7f5-0413-950a-4c9bfbceba06@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rtSq1mTImGEbmHa5BvjrLvr3ohi9fPXt0"
Subject: Re: [Qemu-devel] [PATCH 4/9] tests: Clean up string interpolation
 into QMP input (simple cases)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rtSq1mTImGEbmHa5BvjrLvr3ohi9fPXt0
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <90c0c74e-db30-9f3d-e396-7bdc7872339b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/9] tests: Clean up string interpolation
 into QMP input (simple cases)
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
 <1500645206-13559-5-git-send-email-armbru@redhat.com>
 <295a3dcc-5165-cc23-26a2-ffb4d8ccb144@redhat.com>
 <87tw25ag8p.fsf@dusky.pond.sub.org>
 <500db1a0-e7f5-0413-950a-4c9bfbceba06@redhat.com>
In-Reply-To: <500db1a0-e7f5-0413-950a-4c9bfbceba06@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 03:08 PM, Eric Blake wrote:
>> 2. Support PRId64 and PRIu64, whatever their actual value may be.
>>
>>    a. Support all possible values.  This is what we've tried before.

>>
>>    b. Support exactly the host's PRId64 and PRIu64 values.

>> Preferences?
>>
>> I like 2b, but I'm not sure I'll like the code implementing it.  One w=
ay
>> to find out...

I ended up implementing 2a in the C code, but 2b in the configure check
to make sure our C code gets updated if we ever encounter any more
oddballs.  Of course, I don't have easy access to Mac OS, so I'm relying
on others to test the patch for me; but once we get that patch going to
our liking, I can rebase the rest of this series on top of it.

https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07039.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rtSq1mTImGEbmHa5BvjrLvr3ohi9fPXt0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllybvoACgkQp6FrSiUn
Q2qPgwf9HhocwLODTFISc4FiFq3/Z13slRFPX4VFsrMVjHvA+iq3dFHFANknXeM0
fjarMEwrMqonT39R8w1jAblTe2RuCSj1qIZzHivumx7iwv3zbUCs35mtEjjrJv5N
Jyk2ml9OufTS7t9fHT3UZ+5Jgk1mplZKEI+bHUzYT9pwKM1Tma4FScoW9+UfVtJX
WKE+VVyPUz7HwGaYyq0tVuqNzfn+W12AVjGsQhvSuwP9d+Y0zECv6SweE1BRfMnY
EZYNllSThTYFXQ54GxSwNaEPuwgodfnt5Z0ise/CUMWhxkRLbvnijTbvyhyfsrFc
X/TIKbcZZjhCKynww8rP7B0df4DnPg==
=DGVS
-----END PGP SIGNATURE-----

--rtSq1mTImGEbmHa5BvjrLvr3ohi9fPXt0--
