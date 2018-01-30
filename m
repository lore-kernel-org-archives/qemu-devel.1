Received: from eggs.gnu.org ([2001:4830:134:3::10]:42036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egYef-0002jE-Br
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:21:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egYeb-0006UK-AO
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:21:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egYeb-0006Tx-3A
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:21:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 61985445C1
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 16:21:00 +0000 (UTC)
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-5-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <75f40c27-4247-6283-8967-2d19ea474175@redhat.com>
Date: Tue, 30 Jan 2018 10:20:58 -0600
MIME-Version: 1.0
In-Reply-To: <20180130102202.28519-5-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="veDtGi0QzfOEaJh1C2sB0b5WeH5HvtZjZ"
Subject: Re: [Qemu-devel] [PATCH 04/18] Drop superfluous includes of
 qapi/qmp/qerror.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--veDtGi0QzfOEaJh1C2sB0b5WeH5HvtZjZ
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <75f40c27-4247-6283-8967-2d19ea474175@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/18] Drop superfluous includes of
 qapi/qmp/qerror.h
References: <20180130102202.28519-1-armbru@redhat.com>
 <20180130102202.28519-5-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-5-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 04:21 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  backends/tpm.c             | 1 -
>  block/qcow.c               | 1 -
>  block/qed.c                | 1 -
>  blockdev-nbd.c             | 1 -
>  hw/s390x/s390-virtio-ccw.c | 1 -
>  net/colo-compare.c         | 1 -
>  net/filter-mirror.c        | 1 -
>  net/filter-rewriter.c      | 1 -
>  qapi/qmp-dispatch.c        | 1 -
>  qemu-img.c                 | 1 -
>  ui/vnc.c                   | 1 -
>  11 files changed, 11 deletions(-)
>=20
> diff --git a/backends/tpm.c b/backends/tpm.c
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--veDtGi0QzfOEaJh1C2sB0b5WeH5HvtZjZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwm2oACgkQp6FrSiUn
Q2qmSgf+PrNsMU5ne1cJKfD97GYoJtLkQ2eaSVu+eOqxoarImvpvFX3zk4uZ8ugQ
bUmw+/k32mcaKjLBRzCx06Ef39b+HzJvqpOCyWDOn4jrP98xwU9TgRy5Xw2/jDUg
ac5NiDOK1cXf/MglfmKDnuTrJ5Zd45tp/IqfTOYM91iFNarMcWaPok+T7ut0Ye3P
8lK4ByMTkhkcUeYYFiwSLzirkiARsaH68xLZ8UV+0LZFkAAs/GCfwRRsFiOThDJm
+VZYDAps93eceKut3MCRiZglYNdPPOIBgB9CssuWP/yjdI7qeHXEnhunJ+J6pT19
RTVgntLP4Y/2i1gfTKI6j1QsLHerYQ==
=Q72J
-----END PGP SIGNATURE-----

--veDtGi0QzfOEaJh1C2sB0b5WeH5HvtZjZ--
