Received: from eggs.gnu.org ([2001:4830:134:3::10]:40957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw84h-0004dl-0Q
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw84d-0001kZ-13
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:07:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cw84c-0001k2-Ri
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:07:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ECF97C05B1C7
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 14:07:41 +0000 (UTC)
References: <20170406131326.2418-1-quintela@redhat.com>
	<20170406131326.2418-4-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7ee6eb58-b9b8-f85d-edf1-65bc32467e20@redhat.com>
Date: Thu, 6 Apr 2017 09:07:40 -0500
MIME-Version: 1.0
In-Reply-To: <20170406131326.2418-4-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HhHWf6s0HV0sq1WV94UdP2GV44126Xfr0"
Subject: Re: [Qemu-devel] [PATCH 3/5] qdev: Move qdev_unplug() to
 qdev-monitor.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HhHWf6s0HV0sq1WV94UdP2GV44126Xfr0
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com
Message-ID: <7ee6eb58-b9b8-f85d-edf1-65bc32467e20@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] qdev: Move qdev_unplug() to
 qdev-monitor.c
References: <20170406131326.2418-1-quintela@redhat.com>
 <20170406131326.2418-4-quintela@redhat.com>
In-Reply-To: <20170406131326.2418-4-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 08:13 AM, Juan Quintela wrote:
> It is not used by linux-user, otherwise I need to to create one stub
> for migration_is_idle() on following patch.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/core/qdev.c | 34 ----------------------------------
>  qdev-monitor.c | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 34 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--HhHWf6s0HV0sq1WV94UdP2GV44126Xfr0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5kusAAoJEKeha0olJ0NqsLYH/3dJcLo4tWU+aIF4p1vQJpAp
hxV7UwWanFKWi/PHHrGp/sx1AdH0uWkJ0xwUVRe+U4WjP3o/XqqHDNjExqHcNbnG
2xf40JLVfYuIRUjAlnLrklbAjmt5a0P0ptVFFp6Iil8lMmX2ObgA3roEK4i1nPRl
2Haq3O230kh1Icd5+35j4AHQyhUUAiHb7vJT1Kq+u2uhBa6JJU0LLqt2bg8qoOB8
1f9ieEi435olyeVTxoNGADhu+6mHmq7gttA9CK/IUrGw7nsLFQRl1JeFrGvOs/2E
FD0+bAhg5ikwbBQokl99pzr7VR7yJ6zAbWhmHGIHMXzkkrXG1ElIsoBHZQr2vBQ=
=wbMn
-----END PGP SIGNATURE-----

--HhHWf6s0HV0sq1WV94UdP2GV44126Xfr0--
