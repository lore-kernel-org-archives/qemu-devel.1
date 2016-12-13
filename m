Received: from eggs.gnu.org ([2001:4830:134:3::10]:34821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cGvgI-0007iW-Vc
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 17:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cGvgI-0002Pg-5T
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 17:36:19 -0500
References: <20161205234235.5728-1-eblake@redhat.com>
	<20161212181237.3aymdmenxeu2kwjj@grep.be>
	<20161213073812.GA4443@noname.str.redhat.com>
	<20161213121856.b7fmjwjfkoeufz4g@grep.be>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f354bb95-fcbe-c59d-d5b1-479d76764d9d@redhat.com>
Date: Tue, 13 Dec 2016 16:36:08 -0600
MIME-Version: 1.0
In-Reply-To: <20161213121856.b7fmjwjfkoeufz4g@grep.be>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SQRnnGnJl9F3uFuXPbP04SPBkHvMJrj4T"
Subject: Re: [Qemu-devel] [Nbd] [Qemu-block] [PATCH] doc: Propose
 NBD_FLAG_INIT_ZEROES extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>, Kevin Wolf <kwolf@redhat.com>
Cc: nbd-general@lists.sourceforge.net, xieyingtai@huawei.com, subo7@huawei.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SQRnnGnJl9F3uFuXPbP04SPBkHvMJrj4T
From: Eric Blake <eblake@redhat.com>
To: Wouter Verhelst <w@uter.be>, Kevin Wolf <kwolf@redhat.com>
Cc: nbd-general@lists.sourceforge.net, xieyingtai@huawei.com,
 subo7@huawei.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Message-ID: <f354bb95-fcbe-c59d-d5b1-479d76764d9d@redhat.com>
Subject: Re: [Qemu-devel] [Nbd] [Qemu-block] [PATCH] doc: Propose
 NBD_FLAG_INIT_ZEROES extension
References: <20161205234235.5728-1-eblake@redhat.com>
 <20161212181237.3aymdmenxeu2kwjj@grep.be>
 <20161213073812.GA4443@noname.str.redhat.com>
 <20161213121856.b7fmjwjfkoeufz4g@grep.be>
In-Reply-To: <20161213121856.b7fmjwjfkoeufz4g@grep.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/13/2016 06:18 AM, Wouter Verhelst wrote:
> On Tue, Dec 13, 2016 at 08:38:12AM +0100, Kevin Wolf wrote:
>> Am 12.12.2016 um 19:12 hat Wouter Verhelst geschrieben:
>>> I'm not opposed to this proposal, per se, but there seems to be some
>>> disagreement (by Kevin, for instance) on whether this extension is at=

>>> all useful.
>>
>> FWIW, I'm not opposed to adding the flag. I don't think it can hurt, b=
ut
>> I wanted to ask the question so that we don't end up adding a feature
>> that noone actually uses. Ultimately it's your call as a maintainer
>> anyway how conservative you want to be with spec additions.
>=20
> I'm not opposed either, but I do agree with you that we shouldn't add
> such a feature if it doesn't end up getting used. Especially so if it
> burns a flag in the (16-bit) "transmission flags" field, where space is=

> at a premium.

No, it is NOT a "transmission flag", as it is a per-export property
(where we currently have 64 bits).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--SQRnnGnJl9F3uFuXPbP04SPBkHvMJrj4T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYUHfYAAoJEKeha0olJ0Nq4fgH/iEsxkrQXl5WeBFwLIVJue4S
cJ8QkhNaBWP+ENLlN/C2VVitKv0uG4ZJ40cCdOEvlGcyjPBbGUyUonJ5kTqoe4yU
U+OtWABMxEElf4ELcKKf5LRWNvZsFugE6bPxcfSrdZKrWnd7qchKSYVfvW/S2JAy
h/hzbLkEGaG4lbuUKkIdoyxt52pIVm5s75d72si6ZBqMz7Jo9oosx08ccc66pURJ
dMsDiJwxveb9GjbPd/ZNT1RSnXtYDuvyKKmVO2NrmXLx9/qHeRvNIaua142kmKDO
Gvz6Pfd59YkNy6qmyLUtNvpucvhX6RPGOgJLDhD8rARfpZe1ezxQWcniATe1X6Q=
=wFqT
-----END PGP SIGNATURE-----

--SQRnnGnJl9F3uFuXPbP04SPBkHvMJrj4T--
