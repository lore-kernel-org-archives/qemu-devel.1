Received: from eggs.gnu.org ([2001:4830:134:3::10]:57921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr41U-0006iD-72
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr41R-0003Oy-3Z
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:47:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cr41Q-0003Ol-R3
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:47:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B771D80F95
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 14:47:28 +0000 (UTC)
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
	<1490266548-22500-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c8cbdda1-3b5e-d9e7-b5ee-ebf49d12340e@redhat.com>
Date: Thu, 23 Mar 2017 09:47:24 -0500
MIME-Version: 1.0
In-Reply-To: <1490266548-22500-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eqmJRSTeAWHBQkKkcbDarePQl73a9Tum8"
Subject: Re: [Qemu-devel] [PATCH for-2.9 2/5] rbd: Clean up
 qemu_rbd_create()'s detour through QemuOpts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eqmJRSTeAWHBQkKkcbDarePQl73a9Tum8
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <c8cbdda1-3b5e-d9e7-b5ee-ebf49d12340e@redhat.com>
Subject: Re: [PATCH for-2.9 2/5] rbd: Clean up qemu_rbd_create()'s detour
 through QemuOpts
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
 <1490266548-22500-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1490266548-22500-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/23/2017 05:55 AM, Markus Armbruster wrote:
> The conversion from QDict to QemuOpts is pointless.  Simply get the
> stuff straight from the QDict.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/rbd.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--eqmJRSTeAWHBQkKkcbDarePQl73a9Tum8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY09/8AAoJEKeha0olJ0NqSpAH/1WSKSpB8Ii2zDcsX3P4WnG9
k43YSi8ew1Zz5MKvHryqKiz+tYyFOvOH2L4sYJTiBNRzi1F+f70N7vbhWUyXtUaX
XMrTPWs93lXaVvjw4CBeSejbeBH8n8VuXlE8TXBGE0YuPqDmlMnsVS2gzml7n/Q1
8WIep3xqiEtdozzl7Y/7aS9dGsVAzKUcRtLwzs42caPYAWWWa6EEA0awUfYSIbRz
LDMkhZy67P5gsLz4Al9u3yEDqCtuMIw9kWqKcJ9AEFylNnDMYBdnwW20M/fMXhSq
wr+bxutqmzS1Jqv8muLsc7UYFIgwLv/0h/mFMyHILxAcqbt9z+o1dJTSwrDAFEU=
=MKen
-----END PGP SIGNATURE-----

--eqmJRSTeAWHBQkKkcbDarePQl73a9Tum8--
