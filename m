Received: from eggs.gnu.org ([2001:4830:134:3::10]:56269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crQFo-0006KB-Mo
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crQFl-0008Rt-F3
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:31:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1crQFl-0008Ri-7I
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:31:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19F9680F94
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 14:31:45 +0000 (UTC)
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
	<1490266548-22500-5-git-send-email-armbru@redhat.com>
	<fe5583dc-bbe7-3387-dea9-3f4b89d682a8@redhat.com>
	<a438ce0a-3035-1b2e-0d16-296ee930ed35@redhat.com>
	<e6621b99-a980-dc61-b267-590eb08923c0@redhat.com>
	<59a3aed6-e1cf-a601-4369-1a7cd74500cc@redhat.com>
	<20170324035537.GA22342@localhost.localdomain>
	<87fui3yx0y.fsf@dusky.pond.sub.org>
	<20170324124213.GC22342@localhost.localdomain>
	<89101331-9bba-fb6c-42a1-dfce7775fe4c@redhat.com>
	<20170324141025.GE15423@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2c25aa1c-3832-e8a6-4bfa-004a79a10c77@redhat.com>
Date: Fri, 24 Mar 2017 09:31:37 -0500
MIME-Version: 1.0
In-Reply-To: <20170324141025.GE15423@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jXqV5tmiCaNHI2VGfGgNkST7QlxUBcJFU"
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/5] rbd: Peel off redundant
 RbdAuthMethod wrapper struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, kwolf@redhat.com, jdurgin@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, dillaman@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jXqV5tmiCaNHI2VGfGgNkST7QlxUBcJFU
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, kwolf@redhat.com,
 jdurgin@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 dillaman@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <2c25aa1c-3832-e8a6-4bfa-004a79a10c77@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/5] rbd: Peel off redundant
 RbdAuthMethod wrapper struct
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
 <1490266548-22500-5-git-send-email-armbru@redhat.com>
 <fe5583dc-bbe7-3387-dea9-3f4b89d682a8@redhat.com>
 <a438ce0a-3035-1b2e-0d16-296ee930ed35@redhat.com>
 <e6621b99-a980-dc61-b267-590eb08923c0@redhat.com>
 <59a3aed6-e1cf-a601-4369-1a7cd74500cc@redhat.com>
 <20170324035537.GA22342@localhost.localdomain>
 <87fui3yx0y.fsf@dusky.pond.sub.org>
 <20170324124213.GC22342@localhost.localdomain>
 <89101331-9bba-fb6c-42a1-dfce7775fe4c@redhat.com>
 <20170324141025.GE15423@localhost.localdomain>
In-Reply-To: <20170324141025.GE15423@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/24/2017 09:10 AM, Jeff Cody wrote:
> On Fri, Mar 24, 2017 at 08:49:20AM -0500, Eric Blake wrote:
>> On 03/24/2017 07:42 AM, Jeff Cody wrote:
>>
>>> Agree.  My preference is to leave it as an array of methods, so long =
as that
>>> is tenable to libvirt.
>>
>> The -drive syntax should remain unchanged (that's an absolute must for=

>> libvirt).  But the QMP syntax being an array of methods sounds best to=

>> me, and I think password-secret should be part of the array.  So my vo=
te
>> would be for:
>>
>> { "driver": "rbd", "image": "foo",
>>   "auth": [ { "type": "cephx", "password-secret": "sec0" },
>>             { "type": "none" } ],
>>   "pool": "bar" }
>>
>> It makes mapping -drive arguments into QMP form a bit trickier, but th=
e
>> QMP form is then easily extensible if we add another auth method down
>> the road.
>>
>=20
> In that case, what about adding user as well, and not just password-sec=
ret?

Makes sense - anything that is associated solely with cephx should
belong to the same flat-union branch for cephx, rather than at the top
level.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--jXqV5tmiCaNHI2VGfGgNkST7QlxUBcJFU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1S3KAAoJEKeha0olJ0NqrA4IAIdna/38M8eFVyOknIlfuNlV
4SxE9nhsBOlItNEtudKCFxRi9l5P5fSAgrW/fLt/TR3JX7Nrm1CHmafgaJFDzF1q
15jiDsdhdkIyM/aY7Lk1INHFy4GqOv0qvt1Zz55MBW5Yu4Yd1WJskh2y8DKDSVMG
Uplls9zghXGG8sz0Q8gG0kmOQ1Dfhepx6IpjTe4iL2UGc4afaTykdU935MJnvKp6
bUKZI6cIhe5uNPw6trMR9PfM1j1dvo4fbxYWGeX9YeUxsCEKQxlVuD9mWbMfDUFT
1iT5HRcAd5pcziTJg7QgBrjv8XXGFvpNrwZQk/dpCXf5G6/nlsS87xlvmNW4OaE=
=kxJd
-----END PGP SIGNATURE-----

--jXqV5tmiCaNHI2VGfGgNkST7QlxUBcJFU--
