Received: from eggs.gnu.org ([2001:4830:134:3::10]:47496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csZsN-0003k3-Fn
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csZsJ-0005Ba-II
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:00:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1csZsJ-0005Ay-AH
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:00:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4538B6199F
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 19:00:18 +0000 (UTC)
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-9-git-send-email-armbru@redhat.com>
	<d6cd1529-2f9a-45fe-3bbf-76e7baf5e9d4@redhat.com>
	<87h92eefmf.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a07cf17a-146e-1b5b-e5e5-0456cecb88d1@redhat.com>
Date: Mon, 27 Mar 2017 14:00:15 -0500
MIME-Version: 1.0
In-Reply-To: <87h92eefmf.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vOQm7frtCS0BHUev3KfAdP7w8Te0fdraa"
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 08/11] rbd: Revert -blockdev
 and -drive parameter auth-supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jdurgin@redhat.com, jcody@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vOQm7frtCS0BHUev3KfAdP7w8Te0fdraa
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jdurgin@redhat.com,
 jcody@redhat.com, mreitz@redhat.com
Message-ID: <a07cf17a-146e-1b5b-e5e5-0456cecb88d1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 08/11] rbd: Revert -blockdev
 and -drive parameter auth-supported
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
 <1490621195-2228-9-git-send-email-armbru@redhat.com>
 <d6cd1529-2f9a-45fe-3bbf-76e7baf5e9d4@redhat.com>
 <87h92eefmf.fsf@dusky.pond.sub.org>
In-Reply-To: <87h92eefmf.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/27/2017 01:31 PM, Markus Armbruster wrote:

>>> -
>>> -##
>>> -# @RbdAuthMethod:
>>> -#
>>> -# An enumeration of rados auth_supported types
>>> -#
>>> -# Since: 2.9
>>> -##
>>> -{ 'struct': 'RbdAuthMethod',
>>> -  'data': { 'auth': 'RbdAuthSupport' } }
>>> -
>>
>> Removing the .json QMP support is fine. But I'm reluctant to give R-b
>> without knowing for sure that -drive usage won't regress.
>=20
> auth-supported landed in master only on March 2nd.

auth-supported via -blockdev-add only landed on March 2nd.  But
auth-supported via -drive landed in commit 60390a2, Jan 2016; and is in
use by libvirt:

src/qemu/qemu_command.c:
":key=3D%s:auth_supported=3Dcephx\\;none",

>=20
> What libvirt usage exactly do you think this could break?
>=20

Libvirt has been managing rbd drives using -drive since at least libvirt
commit 5745cd1, in Nov 2011, where even back then it was passing:
            virBufferEscape(opt, ":", ":key=3D%s:auth_supported=3Dcephx n=
one",

(back when it used space instead of ; to separate the list of supported
auth types).

As I've never personally used RBD (whether through qemu directly, or
through libvirt), I'm extremely wary of breaking -drive usage that
"works" (for some definition of "works"), even though I have no qualms
making the QMP interface extremely limited.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vOQm7frtCS0BHUev3KfAdP7w8Te0fdraa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY2WE/AAoJEKeha0olJ0NqY0wH/37uHf02Dge2+q4bPZjfxKrY
iGo5mNeqVyEnR1/Idrt5Yi2h2iYJe8UinjUeaBpVs8I1lmSMkTJNvSHtnFmuiYZW
lJSQuP/uVBL6dmAKxk0AUNRHPywl7cG+tYxyazJJWsvoFTLix/APHTrDk16W4EQB
twKbo/JDBofV2kzqrnqIc2irJGSeHyl+ua/RzbG9LsEJPe2zBM/jGHZRekvdGBte
KAfa2nyh0LHskAlG0mQxRULTPSL75/8OxaTtaPpLB8YShEzwLzdp5gzOXXAYb6Qn
sXFnVYcKn0yYfvdWf68NTcE6O/ATdM8KbKDjYYW6H64j3RbfEIhq/mJEkOU30mY=
=w4Ee
-----END PGP SIGNATURE-----

--vOQm7frtCS0BHUev3KfAdP7w8Te0fdraa--
