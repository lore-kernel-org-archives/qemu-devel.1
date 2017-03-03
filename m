Received: from eggs.gnu.org ([2001:4830:134:3::10]:58515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjq3n-00028T-VE
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:28:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjq3m-0001Xb-Mi
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:28:03 -0500
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<dba72030-5a51-c439-ff27-9bb52430b772@redhat.com>
	<87shmu7wcm.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ff607b9e-ad62-6d44-1593-93a437125a76@redhat.com>
Date: Fri, 3 Mar 2017 10:27:44 -0600
MIME-Version: 1.0
In-Reply-To: <87shmu7wcm.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wu2H4D78kBp2Uwnk7MPSBeUOPXInQC7Q6"
Subject: Re: [Qemu-devel] [PATCH 00/15] block: A bunch of fixes for Sheepdog
 and Gluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-block@nongnu.org, namei.unix@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wu2H4D78kBp2Uwnk7MPSBeUOPXInQC7Q6
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp,
 jcody@redhat.com, qemu-block@nongnu.org, namei.unix@gmail.com
Message-ID: <ff607b9e-ad62-6d44-1593-93a437125a76@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/15] block: A bunch of fixes for Sheepdog
 and Gluster
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
 <dba72030-5a51-c439-ff27-9bb52430b772@redhat.com>
 <87shmu7wcm.fsf@dusky.pond.sub.org>
In-Reply-To: <87shmu7wcm.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2017 11:39 PM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 03/02/2017 03:43 PM, Markus Armbruster wrote:
>>> Bad error handling, memory leaks, and lack of blockdev-add support.
>>
>> How hard are we trying to get blockdev-add working in 2.9?  Or is this=

>> series 2.10 material now?
>=20
> Definitely not 2.10: seven patches fix or document bugs, one improves
> error messages, five are straightforward cleanups.  The series touches
> only these two block drivers, including QAPI schema parts not used
> anywhere else:
>=20
>>>  block/gluster.c      | 127 +++++++--------
>>>  block/sheepdog.c     | 436 +++++++++++++++++++++++++++++++++++++----=
----------
>>>  qapi-schema.json     |  38 +++++
>>>  qapi/block-core.json |  73 +++------
>>>  4 files changed, 443 insertions(+), 231 deletions(-)
>=20
> With the pending pull requests merged, blockdev-add *is* working, excep=
t
> for sheepdog.  I'm considering that a bug, and I need *two* patches to
> fix it.  One touches only sheepdog.c, and the other only adds to the
> QAPI schema.

I can agree to that. It may help if the v2 is explicit that the series
is for-2.9 in the subject.

>=20
> If we decide not to fix the bug, I'd recommend to declare blockdev-add
> supported in 2.9 anyway, with a release note that sheepdog support is
> broken.
>=20

Yes, I think we can still treat the rename of 'x-blockdev-del' to
'blockdev-del' as a bug fix appropriate for 2.9, finally declaring the
feature stable.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--wu2H4D78kBp2Uwnk7MPSBeUOPXInQC7Q6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuZmAAAoJEKeha0olJ0NqO2EH/35NpjaGG/7Zc2MwGxftdb6r
3G/URMpj+kpkG21LgioRMc8IC+O1xTsJ0VoDRHoBGXykELzWBCm4jx+shk1pMB9m
rpB7y2+I4Ey0hKDIFJ1LQjhfcWVkeAIvBJiiM5jTX7HHoqK8xGXMBaXC8EG22TCF
O7RDLuYYChAWsEP13aXHAW2CGw921/hole+avc5Lb1wuQWLK9pEBVVqXqMdFjhar
SEjCkEeWC9GofV4U3SILKCqJV3dlR8Spma9PMMJAn7hV3FwqGvbhg64tEz3ulWMC
aEU3+cLpIyv5k1AHa556M111vjl9q1t7+s1+g+XVCd0npV4QukWkQv2dJS1px3s=
=Po+z
-----END PGP SIGNATURE-----

--wu2H4D78kBp2Uwnk7MPSBeUOPXInQC7Q6--
