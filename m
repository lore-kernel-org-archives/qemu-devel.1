Received: from eggs.gnu.org ([2001:4830:134:3::10]:50980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr9pj-0003Hu-L3
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr9pe-0006Jx-Ri
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:59:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cr9pe-0006Jt-Ia
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:59:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A25A80F90
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:59:42 +0000 (UTC)
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
	<1490266548-22500-5-git-send-email-armbru@redhat.com>
	<fe5583dc-bbe7-3387-dea9-3f4b89d682a8@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a438ce0a-3035-1b2e-0d16-296ee930ed35@redhat.com>
Date: Thu, 23 Mar 2017 15:59:39 -0500
MIME-Version: 1.0
In-Reply-To: <fe5583dc-bbe7-3387-dea9-3f4b89d682a8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vCXvdJrPwRc7uodsevhhP9EKrTdB9WCMx"
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
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jdurgin@redhat.com, jcody@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vCXvdJrPwRc7uodsevhhP9EKrTdB9WCMx
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jdurgin@redhat.com, jcody@redhat.com, mreitz@redhat.com
Message-ID: <a438ce0a-3035-1b2e-0d16-296ee930ed35@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/5] rbd: Peel off redundant
 RbdAuthMethod wrapper struct
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
 <1490266548-22500-5-git-send-email-armbru@redhat.com>
 <fe5583dc-bbe7-3387-dea9-3f4b89d682a8@redhat.com>
In-Reply-To: <fe5583dc-bbe7-3387-dea9-3f4b89d682a8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/23/2017 01:10 PM, Eric Blake wrote:

>>  # @RbdAuthMethod:
>>  #
>>  # An enumeration of rados auth_supported types
>>  #
>>  # Since: 2.9
>>  ##
>> -{ 'struct': 'RbdAuthMethod',
>> -  'data': { 'auth': 'RbdAuthSupport' } }
>> +{ 'enum': 'RbdAuthMethod',
>> +  'data': [ 'cephx', 'none' ] }
>=20
> Changes BlockdevOptionsRbd from:
>=20
> ..., "auth-supported": [ { "auth": "none" } ],

Another question - why does auth-supported take an array?  Can you
really pass both 'none' and 'cephx' at the same time? Or can you only
pass an array of at most one element, at which point why is it an array?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vCXvdJrPwRc7uodsevhhP9EKrTdB9WCMx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1Dc7AAoJEKeha0olJ0NqphIIAIiWO7pSloAuKrgk/hDz4GMY
8W6KajAnLsqdcP1aRauTv4e58etpoSxP5lRi0bCgickiEG923qiHQDXccRppMm0z
Hvuf7IaijV9NlNzjgt9WDeOVIq+56S5G3EAh4gW7inN6gHzUVBLT3wy9Jaju1ppL
xNMm8N1rcQizz+Hay3jdWr4fzrgUxW6KYq+xYXiOjorO9YdGvK+OtwcbtXSn8dFx
rwnDmlM7iwKUwhXIZwSWyOfmYMxnaxYV2bj2QbNG84WaEtb2z9mWDTjyZAlhLv2B
ZyA/Z/WPGQu49uaBgz6Y9/Ve8gC/dnx6Yz04smZSgT0xqnCF4bjX6ktvC8S8/t0=
=b58j
-----END PGP SIGNATURE-----

--vCXvdJrPwRc7uodsevhhP9EKrTdB9WCMx--
