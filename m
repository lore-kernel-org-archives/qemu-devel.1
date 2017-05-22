Received: from eggs.gnu.org ([2001:4830:134:3::10]:54705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCpKC-0006UA-5i
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCpK9-0001pw-2t
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:32:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCpK8-0001oB-Qe
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:32:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8AF920264
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 15:32:43 +0000 (UTC)
References: <20170519180342.19618-1-berrange@redhat.com>
	<20170519180342.19618-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d14a673e-b78b-a8c1-84c7-ab558fc376d2@redhat.com>
Date: Mon, 22 May 2017 10:32:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170519180342.19618-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QxLab3dJbMnLWcPNIailWkl0HC09Q1WjH"
Subject: Re: [Qemu-devel] [PATCH v2 3/5] sockets: ensure we don't accept
 IPv4 clients when IPv4 is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QxLab3dJbMnLWcPNIailWkl0HC09Q1WjH
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <d14a673e-b78b-a8c1-84c7-ab558fc376d2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] sockets: ensure we don't accept IPv4
 clients when IPv4 is disabled
References: <20170519180342.19618-1-berrange@redhat.com>
 <20170519180342.19618-4-berrange@redhat.com>
In-Reply-To: <20170519180342.19618-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/19/2017 01:03 PM, Daniel P. Berrange wrote:
> Currently if you disable listening on IPv4 addresses, via the
> CLI flag ipv4=3Doff, we still mistakenly accept IPv4 clients via
> the IPv6 listener socket due to IPV6_V6ONLY flag being unset.
>=20
> We must ensure IPV6_V6ONLY is always set if ipv4=3Doff
>=20
> This fixes the following scenarios
>=20
>   -incoming tcp::9000,ipv6=3Don
>   -incoming tcp:[::]:9000,ipv6=3Don
>   -chardev socket,id=3Dcdev0,host=3D,port=3D9000,server,nowait,ipv4=3Do=
ff
>   -chardev socket,id=3Dcdev0,host=3D,port=3D9000,server,nowait,ipv6=3Do=
n
>   -chardev socket,id=3Dcdev0,host=3D::,port=3D9000,server,nowait,ipv4=3D=
off
>   -chardev socket,id=3Dcdev0,host=3D::,port=3D9000,server,nowait,ipv6=3D=
on
>=20
> which all mistakenly accepted IPv4 clients
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  util/qemu-sockets.c | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QxLab3dJbMnLWcPNIailWkl0HC09Q1WjH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIwSaAAoJEKeha0olJ0Nq3DMH/3XrJlbPAEY6c5/ZOXO2En4t
7GUWqyLRe32FVCSpMLxX4teQe6PIAIE3jsaxwCML9qSQAX+ATDhi5tCnVklcoVix
lWbztZe/C1KH69n+thlyP+AGuexJYWDHUmt/0NKiEQdYeeVhyFmwU00+9z6EP2lm
d/yTWk39sJ4sqqJ2oOeUeig+wqwPe3P330GiE2jHFw1i3EZ1ZE+lo4QO8bHFu/6X
ZRvi4p1HNoEzQhUJQdOPRFMz4LjV592wBEd3o3PiCVQ4ks67tVBUYQaEK7txkpco
2U54URjRs6h1jzfkBGhl8Qxy9F8QMwEMQamve4chEx8OK67csKSJb//UZIvklJg=
=k01L
-----END PGP SIGNATURE-----

--QxLab3dJbMnLWcPNIailWkl0HC09Q1WjH--
