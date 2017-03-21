Received: from eggs.gnu.org ([2001:4830:134:3::10]:43839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq8Uk-0004tk-Su
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq8Ug-0002eu-Tb
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:21:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cq8Ug-0002dG-Ki
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:21:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 773EA8047A
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 01:21:50 +0000 (UTC)
References: <1489980999-5965-1-git-send-email-jasowang@redhat.com>
	<1489980999-5965-3-git-send-email-jasowang@redhat.com>
	<20170320090734.GN17405@pxdev.xzpeter.org>
	<20170321031220-mutt-send-email-mst@kernel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3d33b743-3939-9917-fc8c-f13c09ff7f1d@redhat.com>
Date: Mon, 20 Mar 2017 20:21:44 -0500
MIME-Version: 1.0
In-Reply-To: <20170321031220-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="T0rm2KKgm2MPqqVoWgKXbKNAaaSajU9MO"
Subject: Re: [Qemu-devel] [PATCH fixup 2/2] vhost: genearlize iommu memory
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T0rm2KKgm2MPqqVoWgKXbKNAaaSajU9MO
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Message-ID: <3d33b743-3939-9917-fc8c-f13c09ff7f1d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH fixup 2/2] vhost: genearlize iommu memory
 region
References: <1489980999-5965-1-git-send-email-jasowang@redhat.com>
 <1489980999-5965-3-git-send-email-jasowang@redhat.com>
 <20170320090734.GN17405@pxdev.xzpeter.org>
 <20170321031220-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170321031220-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/20/2017 08:12 PM, Michael S. Tsirkin wrote:

>>
>> Since this patchset depends on vtd vfio series and fixes its breakage
>> to vhost, I'll pick them up for consistency for next post of vtd vfio
>> series as well.
>>
>> Thanks,
>>
>> -- peterx
>=20
> Sounds good. It's best to order patches in a way that avoids
> breakages even for people that bisect though.
> Might require some patch squashing.

Indeed - a patch submitted with 'fixup' in the title is usually best
incorporated by squashing into a prior patch that has not actually
landed in master, rather than as a standalone patch.

But if you do post this to master as a standalone patch, please fix the
subject line: s/genearlize/generalize/

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--T0rm2KKgm2MPqqVoWgKXbKNAaaSajU9MO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0IAoAAoJEKeha0olJ0NqBy4H/i5JlAZCqzVsaZJ03UHAChWX
IVIUpI3owyxH3RCe9NuFSPUV8s7zqyE5G/bxrXcz1Eg3Gq5tb10FzWbohf3a80pe
aF53kRHWiKL6jsUfhKW4i/VS3kxONEcYSkV0vNnhMRD98NEAtf7I5424zUWb5vSW
c950oOeV10uJw1qSiM8MWgm0nIW0YE1nhBnrHi06SI60NuCmATfOyvh89RgUkx3Z
nzjLAgYXa/lIq11w2aJ4PrGHbUsLz3CJzk0WYkFULrqcyScjByo+ASHTj0CE+/Xj
NHVKSHkSmVSL0OntZ8wkt9pXOnxyc/3aN6jquzvR4cl1ptjWRhVyarL5QfntoZw=
=vDJy
-----END PGP SIGNATURE-----

--T0rm2KKgm2MPqqVoWgKXbKNAaaSajU9MO--
