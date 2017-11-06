Received: from eggs.gnu.org ([2001:4830:134:3::10]:38595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBkws-0004gy-Gp
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBkwr-00022n-Li
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:12:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eBkwr-00022V-DW
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:12:33 -0500
References: <20171106114134.10125-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e34755df-ce62-ad41-7974-7bce9bdc6621@redhat.com>
Date: Mon, 6 Nov 2017 11:12:30 -0600
MIME-Version: 1.0
In-Reply-To: <20171106114134.10125-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8gNGUtNJR0sB8ORbRc0oDmDdUE998HlTu"
Subject: Re: [Qemu-devel] [PATCH] build: remove use of MAKELEVEL
 optimization in submodule handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8gNGUtNJR0sB8ORbRc0oDmDdUE998HlTu
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>
Message-ID: <e34755df-ce62-ad41-7974-7bce9bdc6621@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] build: remove use of MAKELEVEL optimization
 in submodule handling
References: <20171106114134.10125-1-berrange@redhat.com>
In-Reply-To: <20171106114134.10125-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/06/2017 05:41 AM, Daniel P. Berrange wrote:
> The Makefile attempts to optimize the handling of submodules by using M=
AKELEVEL
> to only check the submodule status when running from the top level make=

> invokation. This causes problems for people who are using a makefile of=
 their

s/invokation/invocation/

> own to in turn invoke QEMU's makefile, as MAKELEVEL is already set to 1=
 (or
> more) when QEMU's makefile runs.
>=20
> This optimization should not really be needed, since the git-submodule.=
sh
> script is already used to detect if a submodule update is required. Thi=
s by

s/This/Thus/

> removing the MAKELEVEL check, we at most add an extra 'git-submodule.sh=
 status'
> call to each make level, the overhead of which is lost in noise of buil=
ding
> QEMU.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>=20
> NB this is on top of https://lists.gnu.org/archive/html/qemu-devel/2017=
-11/msg00449.html

Or in wording understood by patchew:

Based-on:
https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg00449.html

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8gNGUtNJR0sB8ORbRc0oDmDdUE998HlTu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloAl/4ACgkQp6FrSiUn
Q2rTjgf/dM6QKFMJesYRwrAEdufzLR6vOaWRY92snRcxqKubwj1B4GvYn8j1o++A
rsuIl3Vaeodq8E05mHfmOFLU8n4nEW3lVBb+C2ORTtjMq/y1UGa7167Y6+y4DMhH
EvATLWjGzVv0BhWT3tK8H5fc7DvuZF5veQSdoKUFFC222MVKUvHQDZgxgJ9aj40u
efPx65FEkAfwtmnpsIB1pp6ddGnngfLiFAN/OVLjfZJVCI7In7+mT5R1ueyIXUbL
n/t29f137J29Uhiq4W8TQESDNHVo+8+lMU+unnmT4yHmuaaWrx8D0WfoOtmy9ZLm
LdZj/s5Lt7wzLBAWQ6zXRaKFY+zk8A==
=vLiu
-----END PGP SIGNATURE-----

--8gNGUtNJR0sB8ORbRc0oDmDdUE998HlTu--
