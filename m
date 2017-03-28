Received: from eggs.gnu.org ([2001:4830:134:3::10]:37033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cswDv-000212-Vl
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cswDs-00013f-MD
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:52:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cswDs-00013Q-DJ
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:52:04 -0400
References: <20170324231943.18768-1-Andrew.Baumann@microsoft.com>
	<bb0868d1-5c56-45e5-8b6c-ee08e77dfeaa@weilnetz.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fbb1c7da-1c51-8ee5-b94d-62fd17c068e0@redhat.com>
Date: Tue, 28 Mar 2017 13:51:57 -0500
MIME-Version: 1.0
In-Reply-To: <bb0868d1-5c56-45e5-8b6c-ee08e77dfeaa@weilnetz.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="svBDLbUSFOM6bm0DCJOx1OEI9hSmb26bb"
Subject: Re: [Qemu-devel] [PATCH v3 for-2.9?] virtio: fix vring_align() on
 64-bit windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--svBDLbUSFOM6bm0DCJOx1OEI9hSmb26bb
From: Eric Blake <eblake@redhat.com>
To: Stefan Weil <sw@weilnetz.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <fbb1c7da-1c51-8ee5-b94d-62fd17c068e0@redhat.com>
Subject: Re: [PATCH v3 for-2.9?] virtio: fix vring_align() on 64-bit windows
References: <20170324231943.18768-1-Andrew.Baumann@microsoft.com>
 <bb0868d1-5c56-45e5-8b6c-ee08e77dfeaa@weilnetz.de>
In-Reply-To: <bb0868d1-5c56-45e5-8b6c-ee08e77dfeaa@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/28/2017 01:38 PM, Stefan Weil wrote:
> Am 25.03.2017 um 00:19 schrieb Andrew Baumann:
>> long is 32-bits on 64-bit windows, which caused the top half of the
>> address to be truncated; this patch changes it to use the
>> QEMU_ALIGN_UP macro which does not suffer the same problem
>>
>> Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---

> Eric added "for-2.9" to the subject line of v2, but now it was
> missing again for v3.
>=20
> Is this needed for 2.9?

Yes, it's a correctness bug that avoids miscompilation on 64-bit targets
where long is 32 bits (which, at the moment, is really just Windows).

> I wonder why I never before noticed
> a problem or got a bug report for this issue.

Probably because so few people are testing on native Windows, and it
doesn't affect other platforms.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--svBDLbUSFOM6bm0DCJOx1OEI9hSmb26bb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY2rDNAAoJEKeha0olJ0Nq+R8H/3kef193tZJauXrTIRMa7b2w
hQZ5HFs8xTMcxE9vVoqXd8FLIyTfPcGM0tCkAlixiML5hEMKsen9etyiygB0vb62
udM3vPuGJjXSiviVfaKqR+QNOlHtQKdRhCsLk2LI4nwG4bC8wVKMriGXjsu5q29I
0HQJGwqEFtgygBjwjo/KbIRRxXjw4HH4kgHyAA3CJAas8OCNcbBCRk+sGhCrsvzb
nhZF6GaiOZ3VP4gXvbymmyP5hdEJaP2oreFdIQfj63aAo1tedLwGHvmkzI9X5FPO
RxSfrCFP7UU+g/Y4PYe5s2IdNwKEo9FYWhF/zrkjgFt3nUNo3ExQyftlx+pWYAU=
=/4UX
-----END PGP SIGNATURE-----

--svBDLbUSFOM6bm0DCJOx1OEI9hSmb26bb--
