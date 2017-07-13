Received: from eggs.gnu.org ([2001:4830:134:3::10]:42270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVc0k-0004vk-MN
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:10:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVc0j-0005pP-Fg
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:10:22 -0400
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<2442d4fc-7dd9-7e25-2389-7dd602e2aa27@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a058285d-2794-8d42-5397-26103d007dd8@redhat.com>
Date: Thu, 13 Jul 2017 06:10:00 -0500
MIME-Version: 1.0
In-Reply-To: <2442d4fc-7dd9-7e25-2389-7dd602e2aa27@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oAQOqA0fOCCPuAaIPn6CEqaCwbkoDup82"
Subject: Re: [Qemu-devel] [PATCH 00/18] nbd: BLOCK_STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oAQOqA0fOCCPuAaIPn6CEqaCwbkoDup82
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com
Message-ID: <a058285d-2794-8d42-5397-26103d007dd8@redhat.com>
Subject: Re: [PATCH 00/18] nbd: BLOCK_STATUS
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <2442d4fc-7dd9-7e25-2389-7dd602e2aa27@redhat.com>
In-Reply-To: <2442d4fc-7dd9-7e25-2389-7dd602e2aa27@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/15/2017 11:05 AM, Paolo Bonzini wrote:

[now several months later...]

>=20
>=20
> On 03/02/2017 16:47, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> We really need exporting dirty bitmaps feature as well as remote
>> get_block_status for nbd devices. So, here is minimalistic and restric=
ted
>> realization of 'structured reply' and 'block status' nbd protocol exte=
nsion
>> (as second is developed over the first the combined spec may be found =
here:
>> https://github.com/NetworkBlockDevice/nbd/blob/extension-blockstatus/d=
oc/proto.md)
>>

>>
>> It should be minimal but fully compatible realization of the spec.
>=20
> This will require v2, but it seems pretty close already.

This series now needs a major rebase on top of the cleanups already
present for qemu 2.10.  Realistically, I'm aiming to get my series [1]
for NBD_OPT_GO into 2.10 (we have less than a week before soft freeze,
so any reviews offered on that series will be appreciated), then the
work on adding structured read and BLOCK_STATUS will probably be big
enough that it will have to be 2.11 material, but getting it posted
sooner rather than later will make it easier to fine-tune all the details=
=2E

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg01971.html

And remember that in open source projects, review can often be the
bottleneck - it does not scale to have reviews done solely by the people
listed in MAINTAINERS.  My personal rule of thumb is that I try to
review 2 patches for every 1 that I submit, to make sure I'm not
contributing to a black hole of unreviewed patch backlog (although no
one will ever turn down a patch from a contributor unable to follow that
advice).  Other benefits of offering reviews: you quickly become more
familiar with the code base, and you earn some name-recognition in the
community (where it is more likely that your own patches get reviewed
quickly because someone recognizes that you are a regular contributor).
It's okay to state on a review that you are not familiar/comfortable
with the code, and want a second reviewer to double-check your work.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--oAQOqA0fOCCPuAaIPn6CEqaCwbkoDup82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZ1UIAAoJEKeha0olJ0NqLbUH/AwBBzaOACL1Q/BN1R4Qtvpb
EeJ+3j2SA5ZIgHWCaSftG+PQxNcac8fHhYj2I+95QA76laA3dch0lTKbsLWf0rlQ
cnWYwcZn8PHmnCo9slg7EFebQ+M1KzXURVzHaZulitWbLEmGsf7h8fgII7YLrble
fiU62zhOX46VDle1P9GUFmb3SohuibxWm/G1uPc/GLn9szsvAE3q0k0sUQfVfJns
xbXyA9XQJPHLoX2QG40Su0kw8AVQiQpxUlmKxQuEQuh1t0QIvRtuw0hqh4oIAcw0
AeEXP2Z340bxmu8p5QJXRqdVZxrVjXjHf1iAa/yf5ScQT7cQNL0Ux043DhWVPqE=
=y1tm
-----END PGP SIGNATURE-----

--oAQOqA0fOCCPuAaIPn6CEqaCwbkoDup82--
