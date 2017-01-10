Received: from eggs.gnu.org ([2001:4830:134:3::10]:33041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQxvR-0007Eq-5Z
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 10:01:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQxvO-0004CB-4Y
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 10:01:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cQxvN-0004C5-Sx
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 10:01:22 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B4BD481231
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 15:01:21 +0000 (UTC)
References: <20170109153914.27424-1-berrange@redhat.com>
	<20170109153914.27424-9-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4cb003a6-c2ad-ed9a-2e44-ea910b0eb3a9@redhat.com>
Date: Tue, 10 Jan 2017 09:01:19 -0600
MIME-Version: 1.0
In-Reply-To: <20170109153914.27424-9-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="01TO9hKRwBKLdEUImsbWCa0cMxqujLCoi"
Subject: Re: [Qemu-devel] [PATCH v2 8/8] io: introduce a DNS resolver API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--01TO9hKRwBKLdEUImsbWCa0cMxqujLCoi
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <4cb003a6-c2ad-ed9a-2e44-ea910b0eb3a9@redhat.com>
Subject: Re: [PATCH v2 8/8] io: introduce a DNS resolver API
References: <20170109153914.27424-1-berrange@redhat.com>
 <20170109153914.27424-9-berrange@redhat.com>
In-Reply-To: <20170109153914.27424-9-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/09/2017 09:39 AM, Daniel P. Berrange wrote:
> Currently DNS resolution is done automatically as part
> of the creation of a QIOChannelSocket object instance.
> This works ok for network clients where you just end
> up a single network socket, but for servers, the results
> of DNS resolution may require creation of multiple
> sockets.
>=20
> Introducing a DNS resolver API allows DNS resolution
> to be separated from the socket object creation. This
> will make it practical to create multiple QIOChannelSocket
> instances for servers.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  include/io/dns-resolver.h | 228 ++++++++++++++++++++++++++++++++++++++=
+
>  include/qemu/sockets.h    |   2 +
>  io/Makefile.objs          |   1 +
>  io/dns-resolver.c         | 267 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  util/qemu-sockets.c       |   4 +-
>  5 files changed, 500 insertions(+), 2 deletions(-)
>  create mode 100644 include/io/dns-resolver.h
>  create mode 100644 io/dns-resolver.c
>=20

> +++ b/io/dns-resolver.c
> @@ -0,0 +1,267 @@
> +/*
> + * QEMU DNS resolver
> + *
> + * Copyright (c) 2016 Red Hat, Inc.

If you want to add 2017, go for it.

Looks like you addressed everything I spotted in v1.
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--01TO9hKRwBKLdEUImsbWCa0cMxqujLCoi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdPc/AAoJEKeha0olJ0Nq8BIH/R8kvbEKkMVntCfngAuVmO+s
pFaVuB3+VtM987UnpijVt5ZnNa+CyfYKYI2UsXzoF+F8ZT3n7N/IUpER+IASgAtU
/xawe/gM68PAPbOasJMGv14U1pP15ZcQPHpvcpKNA+LDIhJTXZfgiCjx5k+Utdtl
K/L4HPmmtFCSlPZ6uTtgEnWjbwJKqxHcNnwm8fiytRk8w6okmw3gZj9qr8TVDbOc
0AIIccEPPJRH1kbHejskilCiX2WQbdO6K8otJHpcDmbC3Uv2yYsbViPb0YH/AGNK
R7esWMXq+w3ZkGKJsRxlGmLSHtZ74D/0IcbEve2wfsVGJyp5MO6jPMNF5JF2rPo=
=mbk/
-----END PGP SIGNATURE-----

--01TO9hKRwBKLdEUImsbWCa0cMxqujLCoi--
