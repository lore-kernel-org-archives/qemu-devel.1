Received: from eggs.gnu.org ([2001:4830:134:3::10]:52398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drldY-0001Ln-ME
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drldV-0006EK-Gf
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:54:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1drldV-0006DV-7X
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:53:57 -0400
References: <59B7C252.1070004@huawei.com>
	<20170912113722.GH29136@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <96af9703-a35e-0baf-55b8-01f052a019b1@redhat.com>
Date: Tue, 12 Sep 2017 08:53:47 -0500
MIME-Version: 1.0
In-Reply-To: <20170912113722.GH29136@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EWFO6huWgFixlNnkLHQD7BQ26s6jpxeq3"
Subject: Re: [Qemu-devel]
 =?utf-8?q?question=EF=BC=9A_I_found_a_bug_which_wil?=
 =?utf-8?q?l_lead_to_qemu_crash?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, "WangJie (Captain)" <wangjie88@huawei.com>
Cc: famz@redhat.com, berto@igalia.com, qemu-devel@nongnu.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EWFO6huWgFixlNnkLHQD7BQ26s6jpxeq3
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, "WangJie (Captain)" <wangjie88@huawei.com>
Cc: famz@redhat.com, berto@igalia.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <96af9703-a35e-0baf-55b8-01f052a019b1@redhat.com>
Subject: =?UTF-8?Q?Re:_[Qemu-devel]_question=ef=bc=9a_I_found_a_bug_which_wi?=
 =?UTF-8?Q?ll_lead_to_qemu_crash?=
References: <59B7C252.1070004@huawei.com>
 <20170912113722.GH29136@localhost.localdomain>
In-Reply-To: <20170912113722.GH29136@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2017 06:37 AM, Kevin Wolf wrote:
> Am 12.09.2017 um 13:17 hat WangJie (Captain) geschrieben:
>> Hi, Kevin.
>>
>> I found a bug about qemu-kvm(version 2.7.0-rc0 adn 2.8.1). but qemu 2.=
6.0 and current master is OK.
>> So I git-bisect the master branch=EF=BC=8Cand I found the patch you co=
mmited (block: Decouple throttling from BlockDriverState) lead the bug in=
to qemu.
>>
>> The patch which lead the bug into qemu: (https://github.com/qemu/qemu/=
commit/7ca7f0f6db1fedd28d490795d778cf23979a2aa7#diff-ea36ba0f79150cc29973=
2696a069caba)
>>
>> Because the current master is OK. So I think you had fixed it , can yo=
u tell me which patch fixed the bug?        Thank you :>
>=20
> I can't tell offhand which fix this was, but you can use 'git bisect'
> not only to find which commit introduced the bug, but also to find the
> fix. You just bisect between a broken commit and master, and then use
> the reversed meaning of 'good' and 'bad' (i.e. 'good' means that the bu=
g
> is still there, 'bad' means it is already fixed).

That can be mentally confusing; with new-enough git, you can also use:

git bisect start --term-old=3Dbuggy --term-new=3Dfixed

at which point, you can then say 'git bisect buggy' or 'git bisect
fixed' according to whether the bug is still present on a given
compilation, without having to remember which direction good/bad means.
There's also 'git bisect terms' to remind you what you chose.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EWFO6huWgFixlNnkLHQD7BQ26s6jpxeq3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm35usACgkQp6FrSiUn
Q2oy3AgAoJH7BXSxVkeXbKojHp7S2BCzt/+J1kNjt4r8v8mhM0xC7YdsZ797T6uW
M64fQA4jzAuL73aKK9a5LhXDi3AuXLzSfZMcSLBtPIiHTMWlij6v9Y+ZIlSDP+/E
fPKuwH10yyGgpoFHrW9Jdl5Ki4GVTgZXYlqUgNvdI9rmR2fYdw0CbpWyIHJaCUiR
BcPojVfTzsmOhFDDCHvG1kq6S/ItVsYWamjGYlQgiCmBQi/TFzHpJ3WGdtXmPWKN
+FE+JGqHkfBOwmK8hETvs5rzln1xmBGeVDY/o8ZmAhtCe6+Oof3VrXv1x9Gu2sFs
lFN1nVhhH9mi8ABNB1d3i/wiw7S4SQ==
=+c2Z
-----END PGP SIGNATURE-----

--EWFO6huWgFixlNnkLHQD7BQ26s6jpxeq3--
