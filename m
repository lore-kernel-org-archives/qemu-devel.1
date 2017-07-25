Received: from eggs.gnu.org ([2001:4830:134:3::10]:52129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7Wr-0000Cs-W9
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7Wq-0000rn-V2
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:38:09 -0400
References: <20170721183243.22706-1-eblake@redhat.com>
	<20170721183243.22706-2-eblake@redhat.com>
	<76a5ebbd-5261-a3f0-2dc1-a236c6c3f97a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7c61246c-3098-3b8f-bb1a-fec58d80961d@redhat.com>
Date: Tue, 25 Jul 2017 16:37:54 -0500
MIME-Version: 1.0
In-Reply-To: <76a5ebbd-5261-a3f0-2dc1-a236c6c3f97a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uRrwtr6rxHL2GmquudceSnctnkKcijAmr"
Subject: Re: [Qemu-devel] [PATCH 1/2] dirty-bitmap: Report
 BlockDirtyInfo.count in bytes, as documented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uRrwtr6rxHL2GmquudceSnctnkKcijAmr
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Fam Zheng <famz@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <7c61246c-3098-3b8f-bb1a-fec58d80961d@redhat.com>
Subject: Re: [PATCH 1/2] dirty-bitmap: Report BlockDirtyInfo.count in bytes,
 as documented
References: <20170721183243.22706-1-eblake@redhat.com>
 <20170721183243.22706-2-eblake@redhat.com>
 <76a5ebbd-5261-a3f0-2dc1-a236c6c3f97a@redhat.com>
In-Reply-To: <76a5ebbd-5261-a3f0-2dc1-a236c6c3f97a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2017 04:28 PM, John Snow wrote:
>=20
>=20
> On 07/21/2017 02:32 PM, Eric Blake wrote:
>> We've been documenting the value in bytes since its introduction
>> in commit b9a9b3a4 (v1.3), where it was actually reported in bytes.
>>
>> Commit e4654d2 (v2.0) then removed things from block/qapi.c, in
>> preparation for a rewrite to a list of dirty sectors in the next
>> commit 21b5683 in block.c, but the new code mistakenly started
>> reporting in sectors.
>>
>> Fixes: https://bugzilla.redhat.com/1441460
>>
>> CC: qemu-stable@nongnu.org
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>>
>=20
> I must have forgotten about this -- Didn't this get reviewed as part of=

> your byte series? Is this a resend for a stable branch?

Yes, it was reviewed during my part 2-of-4 series on byte-base block
status (the dirty bitmap series).  Series 1 made it into 2.10, but
series 2-4 did not; ergo, I filtered out the true bug-fixes that were
still worthy post-freeze.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--uRrwtr6rxHL2GmquudceSnctnkKcijAmr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll3ujIACgkQp6FrSiUn
Q2qnHAf/QXovaOl2ybh+WpQbQTKjU34IuXgIIZDbXgAj4wkg7NvF6RXvHLz3qlzk
rnAWcAkMU37G8K/BmbWe5iHielBDFtqwx2mBfg7XFr71A8j1aBE7RfH9czhLkasf
HBivvCyen7pLWfRsMpDJ+tkX5Cc3paOs+KbsW4WXFftc+88zOFiTGOHlqwIlalY8
Vnn7xIBQ4nkzMnFYYSfCBDf7iAPCaka9Vi/23HSi5Eq0Whp1fOQUvB72KVH2wmZW
fEqXWUkY0K3QI56ri7XJzmsP6wTy73dEWhs+Sd37FXDHBgZ8vV2SlNM9/PW3kszq
ESZ21nKMB/hsEDTyaFEJnCFEF9tMHA==
=lsSL
-----END PGP SIGNATURE-----

--uRrwtr6rxHL2GmquudceSnctnkKcijAmr--
