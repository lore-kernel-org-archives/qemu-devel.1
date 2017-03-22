Received: from eggs.gnu.org ([2001:4830:134:3::10]:53994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqkQj-0002v8-VX
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqkQj-0002hf-0J
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:52:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqkQi-0002gw-OP
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:52:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ADCBD19D22F
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 17:52:16 +0000 (UTC)
References: <1490199642-5521-1-git-send-email-armbru@redhat.com>
	<01e78c6d-b182-f8f9-828c-737cb94c4f1b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3c0998d7-ce9f-4ed8-e65b-5a6911f6b724@redhat.com>
Date: Wed, 22 Mar 2017 12:52:13 -0500
MIME-Version: 1.0
In-Reply-To: <01e78c6d-b182-f8f9-828c-737cb94c4f1b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9qOPNLS6GxdKjhJuKE51cxhbuWeDNrDxi"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.9] block: Declare blockdev-add and
 blockdev-del supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9qOPNLS6GxdKjhJuKE51cxhbuWeDNrDxi
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com
Message-ID: <3c0998d7-ce9f-4ed8-e65b-5a6911f6b724@redhat.com>
Subject: Re: [PATCH v2 for-2.9] block: Declare blockdev-add and blockdev-del
 supported
References: <1490199642-5521-1-git-send-email-armbru@redhat.com>
 <01e78c6d-b182-f8f9-828c-737cb94c4f1b@redhat.com>
In-Reply-To: <01e78c6d-b182-f8f9-828c-737cb94c4f1b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/22/2017 12:13 PM, Max Reitz wrote:
> On 22.03.2017 17:20, Markus Armbruster wrote:
>> It's been a long journey, but here we are.
>>
>> The supported blockdev-add is not compatible to its experimental
>> predecessors; bump all Since: tags to 2.9.
>>
>> x-blockdev-remove-medium, x-blockdev-insert-medium and
>> x-blockdev-change need a bit more work, so leave them alone for now.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>> v2:
>> * Another "command is considered experimental" comment dropped [Max]
>> * More Since: tags updated to 2.9, commit message improved, R-bys drop=
ped
>=20
> Do you want to do this recursively? There are things such as
> BlkdebugSetStateOptions or ReplicationMode which are only used by the
> corresponding BlockdevOptions*, so they too are basically only supporte=
d
> as of 2.9.
>=20
> I don't have a strong opinion, but I think I personally wouldn't bother=

> with any of these structures and just update the tag for blockdev-add
> itself...

I also don't have a strong opinion, and think it may actually be a bit
more time consuming to audit which types are recursively used only by
blockdev-add (and no where else) than to just leave them be.  But I'm
also okay if you like bumping the numbers to the point where the struct
was marked stable, and where we have to start thinking about back-compat
ramifications when modifying the struct.

>=20
> You being fine with me would be enough to convince me, so:
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Likewise.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--9qOPNLS6GxdKjhJuKE51cxhbuWeDNrDxi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0rnNAAoJEKeha0olJ0Nq9k8H/iwl/LuwfdAwTMeEpK4Nohmj
SSRBYtpzeAxNx98n3NI4vfpVPyfw3zzaVHnkRUsChSUvLcN+D9qG2CBvwrzyEXVp
YolCNkMiNtuSuDOxXMrLiqZwq8JhFk83lKaelUjtAp0BVZaRRRLV1AbGHb0ZmV0k
KP9Y1EnELxX5N9D24ZhyHDnZ1ZDHssZyaEisDTtVTXLpauECOZjT5f+eh6Tp9oXZ
+TjxUSrARMC4pzCxRHaxCZFZyYy71sN3xmQYM8urfaJWoZaOib50sF9LavKOngn7
2jJFnvvB+lCBSPlTl4QX6X8IlBGYNTgkmUW9nluBTVSPoI7xxTQOOv2iZr8wUcE=
=zYFW
-----END PGP SIGNATURE-----

--9qOPNLS6GxdKjhJuKE51cxhbuWeDNrDxi--
