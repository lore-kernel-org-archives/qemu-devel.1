Received: from eggs.gnu.org ([2001:4830:134:3::10]:35398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ePpni-00017C-7W
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:13:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ePpnd-0004tA-9F
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:13:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ePpnc-0004rq-Vj
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:13:13 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 37B37369C9
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 13:13:12 +0000 (UTC)
References: <1501249552-788-1-git-send-email-armbru@redhat.com>
	<1501249552-788-4-git-send-email-armbru@redhat.com>
	<17d849ae-e99c-0f8a-5f38-374e8938cbe5@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3fb23e35-cdb7-8eb7-cd21-e8c5da9e320b@redhat.com>
Date: Fri, 15 Dec 2017 14:13:09 +0100
MIME-Version: 1.0
In-Reply-To: <17d849ae-e99c-0f8a-5f38-374e8938cbe5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ORvH5GERowDUV9nvwEWvG91pMhgxRJxkN"
Subject: Re: [Qemu-devel] [PATCH 3/3] block: Remove unused
 BlockDeviceMapEntry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ORvH5GERowDUV9nvwEWvG91pMhgxRJxkN
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3fb23e35-cdb7-8eb7-cd21-e8c5da9e320b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] block: Remove unused BlockDeviceMapEntry
References: <1501249552-788-1-git-send-email-armbru@redhat.com>
 <1501249552-788-4-git-send-email-armbru@redhat.com>
 <17d849ae-e99c-0f8a-5f38-374e8938cbe5@redhat.com>
In-Reply-To: <17d849ae-e99c-0f8a-5f38-374e8938cbe5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-28 20:10, Eric Blake wrote:
> On 07/28/2017 08:45 AM, Markus Armbruster wrote:
>> BlockDeviceMapEntry has never been used.  It was added in commit
>> facd6e2 "so that it is published through the introspection mechanism."=

>> What exactly introspecting types that aren't used for anything could
>> accomplish isn't clear.  What "introspection mechanism" to use is also=

>> nebulous.  To the best of my knowledge, there has never been one that
>> covered this type.  Certainly not query-qmp-schema, which includes
>> only types that are actually used in QMP.
>>
>> Not being able to introspect BlockDeviceMapEntry hasn't bothered
>> anyone enough to complain in almost four years.  Get rid of it.
>=20
> This type is the schema for 'qemu-img map --output=3Djson'.  And I had =
a
> patch once (that I need to revive) that added a JSON Output visitor; at=

> which point I fixed qemu-img to convert from QAPI to JSON instead of
> open-coding its construction of its output string, at which point the
> QAPI generated code for this type is useful.
(Very late reply, I know, I just stumbled over *MapEntry when looking
over block-core.json what we might want to deprecate in 3.0)

We already use MapEntry there -- why don't we output just that instead?
The only difference seems to be an additional @filename parameter which
would probably be actually nice to include in the output.

Except that BlockDeviceMapEntry's documentation is better, so we should
merge that into MapEntry before removing the former.

Max


--ORvH5GERowDUV9nvwEWvG91pMhgxRJxkN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlozymUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ALAwIAMPFcwcQmwKN/NOgRjqM2WtEFkvRMeST
3udKGlcoGQ0FoBsVMLevfkYxJaf8ndGhZm/Jk5YpxzarRvSRXs4E4RhHdex4vbYA
OVlPnHp7oY3SVpfLfppv5IQDlV6GoCpnpwoVIh0D2D5JocpY9jrLqUPA8MjSeB0K
d11mo7V++0WIdjAW/WAWFSNQ16dkGN6h1DyyPdUAuOwktN9+LXI2ZSYNa/d5uIt0
UVwKzWECSY1WiDnyRjZhvRd60oH0HH5bx3lLikU+LoZw7J/5CNQ4grPnpjm8NvqO
gcRp1xuDutYdHU4Ha72eC/OJ5utRqMnZkdg3UyQbiLURYXft2+YaDOc=
=MLer
-----END PGP SIGNATURE-----

--ORvH5GERowDUV9nvwEWvG91pMhgxRJxkN--
