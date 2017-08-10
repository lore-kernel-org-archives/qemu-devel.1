Received: from eggs.gnu.org ([2001:4830:134:3::10]:53149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfpAa-0000JI-SC
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfpAW-0007g8-PS
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:14:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfpAW-0007fs-FZ
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 11:14:40 -0400
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1499182263-19139-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<87bmoxcuvn.fsf@dusky.pond.sub.org>
	<61626c42-9c47-14e5-24b7-e6086d042a6b@huawei.com>
	<87shh3fn7d.fsf@dusky.pond.sub.org>
	<w511soml2kh.fsf@maestria.local.igalia.com>
	<34e45421-0b22-15b4-deb7-980f26e5ca23@huawei.com>
	<w51shh2jfi9.fsf@maestria.local.igalia.com>
	<87wp6e6qb7.fsf@dusky.pond.sub.org>
	<dc14df7c-2f7c-300b-5f60-44411f3d6604@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <66aac45f-6319-2eca-3703-aaab43557e00@redhat.com>
Date: Thu, 10 Aug 2017 10:14:36 -0500
MIME-Version: 1.0
In-Reply-To: <dc14df7c-2f7c-300b-5f60-44411f3d6604@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Pg7ts9Ir6PScH2FPkc8vGM8HAvTDUEbUr"
Subject: Re: [Qemu-devel] [PATCH v7 2/6] qmp: Create IOThrottle structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>
Cc: Kevin Wolf <kwolf@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, greg kurz <groug@kaod.org>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pg7ts9Ir6PScH2FPkc8vGM8HAvTDUEbUr
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>
Cc: Kevin Wolf <kwolf@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>,
 greg kurz <groug@kaod.org>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>,
 qemu-devel@nongnu.org
Message-ID: <66aac45f-6319-2eca-3703-aaab43557e00@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 2/6] qmp: Create IOThrottle structure
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1499182263-19139-3-git-send-email-pradeep.jagadeesh@huawei.com>
 <87bmoxcuvn.fsf@dusky.pond.sub.org>
 <61626c42-9c47-14e5-24b7-e6086d042a6b@huawei.com>
 <87shh3fn7d.fsf@dusky.pond.sub.org>
 <w511soml2kh.fsf@maestria.local.igalia.com>
 <34e45421-0b22-15b4-deb7-980f26e5ca23@huawei.com>
 <w51shh2jfi9.fsf@maestria.local.igalia.com>
 <87wp6e6qb7.fsf@dusky.pond.sub.org>
 <dc14df7c-2f7c-300b-5f60-44411f3d6604@huawei.com>
In-Reply-To: <dc14df7c-2f7c-300b-5f60-44411f3d6604@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/10/2017 09:06 AM, Pradeep Jagadeesh wrote:

>>> It's not "moving it back", it's keeping it where it is. But I see no =
big
>>> problem with moving it to a common file either.
>>
>> I'd rather not put every struct shared across subsystem boundaries in
>> its own file.
>>
>> We can keep it right where it is for now.  Bonus: more readable diff.
>> If we start sharing more throttle-related material than just a struct,=

>> we can reconsider.
>>
>> We could also move it to the existing file for common stuff:
>> qapi/common.json.  Not a great fit, though.
> So, the final conclusion is to move to common.json?

No.

If more than one .json file would benefit by including the definition,
then put it in a separate file that both .json include from.

But if only one .json file would be including a new file, then just
inline the struct directly into that one original file (in this case,
block-core.json) instead of creating a separate file (so no to needing
iothrottle.json), or putting the code in yet a different file than the
one that is using the struct (so no to putting it in common.json).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Pg7ts9Ir6PScH2FPkc8vGM8HAvTDUEbUr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmMeFwACgkQp6FrSiUn
Q2oRmggAg+AizUPIiQ17xyisWrZG0TU17fTxt/+B6J8K6/KLvn3OhTxDJ4k9s+0j
nsgqq+VqVfaeRFwMds47jjT9ICUVeHVvRwB/WSzjlqwt3gqaKddNKbnpZDkPxz0q
jF7bjDLb+YijK52B6sY99VAxKE4F4kEXR0FVfyU9+VD7D7XnjAcw72GGRVo3OI1S
zgzO2EDVN6DKei0zGQ8oWtblQKmIZMZNh3HUaqgF37IK9+XZutw3OUHHlPPlRc5d
4oDW5tYqHmPLk4+Ixm1dRVHxE9dIFx/4MepUJaZITBV61u1+KAbYWtmaEPxVzu3J
aFXC+bR1q3UZ7YhGQVrlxRHGZFjFKA==
=0K0d
-----END PGP SIGNATURE-----

--Pg7ts9Ir6PScH2FPkc8vGM8HAvTDUEbUr--
