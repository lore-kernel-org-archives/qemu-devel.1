Received: from eggs.gnu.org ([2001:4830:134:3::10]:43158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUaLB-0001OW-NO
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:38:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUaLA-0000Kx-PP
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:38:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cUaLA-0000Jf-Gm
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:38:56 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BADFC0567B2
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 14:38:56 +0000 (UTC)
References: <20170118161653.19296-1-eblake@redhat.com>
	<20170118161653.19296-7-eblake@redhat.com>
	<8737gffkhy.fsf@dusky.pond.sub.org>
	<f5618def-ca46-72e7-c872-85e6d79a17b5@redhat.com>
	<87h94u42xf.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8b87e0b6-c928-1dd0-037b-9215d741eb93@redhat.com>
Date: Fri, 20 Jan 2017 08:38:49 -0600
MIME-Version: 1.0
In-Reply-To: <87h94u42xf.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="a4OpE2oFwEhgPhMwRvFUipCDfvfPLXWL2"
Subject: Re: [Qemu-devel] [PATCH v2 6/6] qapi: Promote
 blockdev-change-medium arguments to QAPI type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a4OpE2oFwEhgPhMwRvFUipCDfvfPLXWL2
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <8b87e0b6-c928-1dd0-037b-9215d741eb93@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/6] qapi: Promote blockdev-change-medium
 arguments to QAPI type
References: <20170118161653.19296-1-eblake@redhat.com>
 <20170118161653.19296-7-eblake@redhat.com>
 <8737gffkhy.fsf@dusky.pond.sub.org>
 <f5618def-ca46-72e7-c872-85e6d79a17b5@redhat.com>
 <87h94u42xf.fsf@dusky.pond.sub.org>
In-Reply-To: <87h94u42xf.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/20/2017 01:15 AM, Markus Armbruster wrote:

>>> Isn't Since: 2.5 misleading?  The anonymous type goes back to 2.5, bu=
t
>>> the name doesn't.
>>
>> It matches what we've done elsewhere - when refactoring .json files to=

>> create a new type, but where the new type doesn't represent anything
>> different over the wire than what was previously sent, we've documente=
d
>> the new struct name as of the older release where the wire format was
>> introduced.  But as long as the command says 'since 2.5', I'm okay if =
we
>> want to mark the struct as 'since 2.9', if that's easier to think abou=
t.
>=20
> Sticking to established practice is better than inconsistent practice.
>=20
> That said, I wonder why we bother to track "since" for types.  "Since"
> is important information for external interfaces.  Why is it useful for=

> purely internal ones?
>=20
> External visible are commands, events, and members of types used by
> commands or events.

I guess what we can do is treat a type-wide 'Since: 2.5' as the default
for all its members that don't supply any other '(since 2.6)' note.
You're right that types themselves (even when used in a command) are NOT
the API, and that we can refactor type names without breaking wire
compatibility, but having a default for when each member of the type was
first made available makes sense since we DO care when members were
introduced.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--a4OpE2oFwEhgPhMwRvFUipCDfvfPLXWL2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYgiD5AAoJEKeha0olJ0Nq0hkIAIL3zlPcqUQXMeJk4/9BFKFy
FJUAasxu7/ZqtNgBWHYyNaKWnbWovDdHZYsyF1lBLnOFVBVR90fzugN+wQvz7D/W
UjIh09nrgCIe/vvJ++zRWNkdE7vzkx1qjrZY4cCyizhAbu8jzqD7Kc869LcPTD69
1ArHtZt7X987nUfcJ/9r9cF2IttLOLwuO+TRubcnzIi/dyLSKt0Hj4oJupxArWtt
FilGW/QJQ12r5BA20gn6oWOlaY/DzWXB4t086amh1ZGStsN1apVbxTTPpcwH0A8E
uGbBOjBD0kMwBxvOYEot/OVEAZNdTxAEs7QZ/p2hq9eq/FcgtEnQYA4KpkIIeiI=
=kwVK
-----END PGP SIGNATURE-----

--a4OpE2oFwEhgPhMwRvFUipCDfvfPLXWL2--
