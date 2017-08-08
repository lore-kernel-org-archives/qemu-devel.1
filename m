Received: from eggs.gnu.org ([2001:4830:134:3::10]:45983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfBhj-0007zA-Bh
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 17:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfBhf-0001oG-AG
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 17:06:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfBhf-0001nK-1W
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 17:06:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B6BF26148E
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 21:06:13 +0000 (UTC)
References: <20170808203900.7661-1-jfreimann@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f10f4722-1d0b-0793-c837-5915ed70d65a@redhat.com>
Date: Tue, 8 Aug 2017 16:05:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170808203900.7661-1-jfreimann@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1FMlLd0NO2Sc42Jf4dWsixLbX1XTpfiDx"
Subject: Re: [Qemu-devel] [PATCH for-2.10? v2 0/5] tests/pxe-test: add
 testcase using vhost-user-bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jens Freimann <jfreimann@redhat.com>, qemu-devel@nongnu.org
Cc: victork@redhat.com, mst@redhat.com, jasowang@redhat.com, maxime.coquelin@redhat.com, stefanha@redhat.com, marcandre.lureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1FMlLd0NO2Sc42Jf4dWsixLbX1XTpfiDx
From: Eric Blake <eblake@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>, qemu-devel@nongnu.org
Cc: victork@redhat.com, mst@redhat.com, jasowang@redhat.com,
 maxime.coquelin@redhat.com, stefanha@redhat.com, marcandre.lureau@redhat.com
Message-ID: <f10f4722-1d0b-0793-c837-5915ed70d65a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10? v2 0/5] tests/pxe-test: add
 testcase using vhost-user-bridge
References: <20170808203900.7661-1-jfreimann@redhat.com>
In-Reply-To: <20170808203900.7661-1-jfreimann@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 03:38 PM, Jens Freimann wrote:
> This implements a testcase for pxe-test using the vhost-user interface.=
 Spawn a
> vhost-user-bridge process and connect it to the qemu process.
>=20
> To make the testcase work we need to apply a few patches before the act=
ual testcase:
> - Patch 1 disables debug output of vhost-user-bridge
> - Patch 2 fixes passing a file descriptor to -netdev.  This was broken =
since the
>   mcast option was introduced.=20

Is this a regression worthy of fixing in rc3?  Or are we okay with this
entire series waiting for 2.11.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1FMlLd0NO2Sc42Jf4dWsixLbX1XTpfiDx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmKJ7QACgkQp6FrSiUn
Q2qj5wf/Zd7W4+vWmOfWxi1pEtwkpbQZi43NkUENY6pmAM5sGUMilCmzt++oe4Jp
1VQ4yNIIgLptKlNNVHKvvx0ZLND0vQUwYOqLxconqHzqxw+CSt9eDMnJvfZAt7sA
Ng5oAGrjrREm+LpE7eM4nU64tOZIEjuWnKI5bMZ4c4xGIyVloXn+tXnI2YkY91Mt
9dY1+WIz38tEU7Fj87iJO+0r3mcA/LlsxZ/Tyk/QsIweBXAOH1mRm55YCfXRH9+E
wX/tr1OWMkvklynsSI5hO7XWhWBgdg+/cK4MsoCgWzmTUVwsULWgG1xshrFE8dxT
2YS2wgl2kNFI0yjBDjvfuSu1r6EPaQ==
=1aAJ
-----END PGP SIGNATURE-----

--1FMlLd0NO2Sc42Jf4dWsixLbX1XTpfiDx--
